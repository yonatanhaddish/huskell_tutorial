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

 buildSendAdaToPlutusScript = async () => {

    const txBuilder= await this.initTransactionBuilder();
    const ScriptAddress = Address.from_bech32(this.state.addressScriptBech32);
    const shellyChangeAddress = Address.from_bech32(this.state.chageAddress);

    let txOutputBuilder= TransactionOutBuilder.new()
    txOutputBuilder= txOutputBuilder.with_address(ScriptAddress);
    const dataHash = hash_plutus_data(PlutusData.new_integer(BigInt.from_str(this.state.datumStr)));
    txOutputBuilder= txOutputBuilder.with_data_hash(dataHash);

    txOutputBuilder= txOutputBuilder.next();

    txOutputBuilder= txOutputBuilder.with_value(Value.new(BigNum.from_str(this.state.lovelaceToSend.toString())))
    const txOutput= txOutputBuilder.build();

    txBuilder.add_out_put(txOutput);
    
    const txUnspentOutputs= await this.getTxUnspentOutputs();
    txBuilder.add_inputs_from(txUnspentOutputs, 2);

    const txBody= txBuilder.build();

    const transactionWitnessSet= TransactionWitnessSet.new();

    const tx= Transaction.new(
        txBody, TransactionWitnessSet.from_bytes(transactionWitnessSet.to_bytes())
    )

    let txVkeyWitness = await this.API.signTx(Buffer.from(tx.to_bytes(), "utf8").toString("hex"), true);
    txVkeyWitness= TransactionWitnessSet.from_bytes(Buffer.from(txVkeyWitness, "hex"));

 }