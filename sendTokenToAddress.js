/**
 * The transaction is build in 3 stages:
 * 1 - initialize the Transaction Builder
 * 2 - Add inputs and outputs
 * 3 - Calculate the fee and how much change needs to be given
 * 4 - Build the transaction body
 * 5 - Sign it (at this point the user will be prompted for
 * a password in his wallet)
 * 6 - Send the transaction
 * @returns {Promise<void>}
 */

buildSendTokenTransaction = async () => {
    const txBuilder= await this.initTransactionBuilder();
    const shellyOutputAddress= Address.from_bech32(this.state.addressBech32SendAda);
    const shellyChangeAddress= Address.from_bech32(this.state.changeAddress);

    let txOutputBuilder= TransactionOutputBuilder.new();
    txOutputBuilder= txOutputBuilder.with_address(shellyOutputAddress);
    txOutputBuilder= txOutputBuilder.next();

    let multiAsset= MultiAsset.new();
    let assets= Assets.new();
    assets.insert(
        AssetName.new(Buffer.from(this.state.assetNameHex, "hex")), // Asset Name
        BigNum.from_str(this.state.assetAmountToSend.toString()) // How much ADA to send
    );
    multiAsset.insert(
        ScriptHash.from_bytes(Buffer.from(this.state.assetPolicyIdHex, "hex")), // PolicyID
        assets
    );

    txOutputBuilder= txOutputBuilder.with_address_and_min_required_coin(multiAsset, BigNum.from_str(
        this.protocolParams.coinsPerUtxoWord))
    
    const txOutput= txOutputBuilder.build();

    txBuilder.add_output(txOutput);

    const txUnspentOutputs= await this.getTxUnspentOutputs();
    txBuilder.add_inputs_from(txUnspentOutputs, 3);

    txBuilder.add_change_if_needed(shellyChangeAddress)

    const txBody= txBuilder.build();

    const transactionWitnessSet= TransactionWitnessSet.new();

    const tx= Transaction.new(
        txBody,
        TransactionWitnessSet.from_bytes(transactionWitnessSet.to_bytes())
    )

    let txVkeyWitness= await this.API.signTx(Buffer.from(tx.to_bytes(), "utf8").toString("hex"), true);
    txVkeyWitness= TransactionWitnessSet.from_bytes(Buffer.from(txVkeyWitness, "hex"));

    transactionWitnessSet.set_Vkeys(txVkeyWitness.vkeys());

    const signedTx = Transaction.new(
        tx.body(),
        transactionWitnessSet
    );

    const submittedTxHash= await this.API.submitTx(Buffer.from(signedTx.to_bytes(), "utf8").toString("hex"));
    this.setState({submittedTxHash})
    
}