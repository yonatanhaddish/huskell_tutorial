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

buildSendAdaTransaction = async () => {
  const txBuilder = await this.initTransactionBuilder();
  const shellyOutputAddress = Address.from_bech32(
    this.state.addressBech32SendADA
  );
  const shellyChangeAddress = Address.from_bech32(this.state.addressChange);

  txBuilder.add_output(
    transactionOutput.new(
      shellyOutputAddress,
      Value.new(BigNum.from_str(this.state.lovelaceToSend.toString()))
    )
  );

  const txUnspentOutputs = await this.getTxUnspentOutputs();
  txBuilder.add_inputs_from(txUnspentOutputs, 1);

  txBuilder.add_change_if_needed(shellyChangeAddress);

  const txBody = txBuilder.build();

  const transactionWitnessSet = TransactionWitnessSet.new();

  const tx = Transaction.new(
    txBody,
    TransactionWitnessSet.from_bytes(transactionWitnessSet.to_bytes())
  );

  let txVkeyWitness = await this.API.signTx(
    Buffer.from(tx.to_bytes, "utf8").toString("hex"),
    true
  );

  transactionWitnessSet.set_vkeys(txVkeyWitness.vkeys());

  const signedTx = Transaction.new(tx.Body(), transactionWitnessSet);

  const submittedTxHash = await this.API.submitTx(
    Buffer.from(signedTx.to_bytes(), "utf8").toString("hex")
  );
  this.setState({ submittedTxHash });
};
