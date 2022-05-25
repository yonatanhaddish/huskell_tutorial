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
        AssetName.new(Buffer.from(this.state.assetNameHex, "hex")),
        BigNum.from_str(this.state.assetAmountToSend.toString())
    );

}