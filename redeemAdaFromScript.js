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

 buildRedeemAdaFromPlutusScript = async () => {
     const txBuilder = await this.initTransactionBuilder()
     const ScriptAddress = Address.from_bech32(this.state.addressScriptBech32)
     const shellyChangeAddress = Address.from_bech32(this.state.changeAddress)
     
     txBuilder.add_input(
         ScriptAddress,
         TransactionInput.new(
             TranscationHash.from_bytes(Buffer.from(this.state.tranactionIdLocked, "hex")),
             this.state.tranactionIndxLocked.toSrting()),
        Value.new(BigNum.from_srt(this.state.lovelaceLocked.toSrting()))
     )

     txBuilder.set_fee(BigNum.from_str(Number(this.state.manualFee).toString()));

     const scripts = PlutusScripts.new();
     scripts.add(PlutusScripts.from_bytes(Buffer.from(this.state.plutusScriptCborHex, "hex")));

     const outputVal = this.state.lovelaceLocked.toSrting() - Number(this.state.manualFee);
     const outputValSrt = outputVal.toString();
     txBuilder.add_output(TransactionOutput.new(shellyChangeAddress, Value.new(BigNum.from_str(outputValSrt))));

     const txBody = txBuilder.build();

     const collateral = this.state.CollatUtoxs;
     const inputs = TransactionInput.new();
     collateral.forEach((utxo) => {
         inputs.add(utxo.input());
     });
    
     let datums = PlutusList.new();
     datums.add(PlutusData.new_integer(BigInt.from_str(this.state.datumStr)));

     const redeemers = Redeemers.new();

     const data = PlutusData.new_consrt_plutus_data(
         ConsrtPlutusData.new(
             BigNum.from_str("0"),
             PlutusList.new()
         )
     );

     const redemmer = Redeemer.new(
         RedeemerTag.new_spend(),
         BigNum.from_str("0"),
         data,
         ExUnits.new(
             BigNum.from_str("7000000"),
             BigNum.from("3000000000")
         )
     );

     redeemers.add(redemmer);

     const transactionWitnessSet = transactionWitnessSet.new();

     transactionWitnessSet.set_plutus_scripts(scripts);
     transactionWitnessSet.set_plutus_data(datums);
     transactionWitnessSet.set_plutus_redeemers(redeemers);

     const cost_model_vals = [197209, 0, 1, 1, 396231, 621, 0, 1, 150000, 1000, 0, 1, 150000, 32, 2477736, 29175, 4, 29773, 100, 29773, 100, 29773, 100, 29773, 100, 29773, 100, 29773, 100, 100, 100, 29773, 100, 150000, 32, 150000, 32, 150000, 32, 150000, 1000, 0, 1, 150000, 32, 150000, 1000, 0, 8, 148000, 425507, 118, 0, 1, 1, 150000, 1000, 0, 8, 150000, 112536, 247, 1, 150000, 10000, 1, 136542, 1326, 1, 1000, 150000, 1000, 1, 150000, 32, 150000, 32, 150000, 32, 1, 1, 150000, 1, 150000, 4, 103599, 248, 1, 103599, 248, 1, 145276, 1366, 1, 179690, 497, 1, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 148000, 425507, 118, 0, 1, 1, 61516, 11218, 0, 1, 150000, 32, 148000, 425507, 118, 0, 1, 1, 148000, 425507, 118, 0, 1, 1, 2477736, 29175, 4, 0, 82363, 4, 150000, 5000, 0, 1, 150000, 32, 197209, 0, 1, 1, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 150000, 32, 3345831, 1, 1];

     const costModel = CostModel.new();
     cost_model_vals.forEach((x, i) => costModel.set(i, Int.new_i32(x)));

     costModels = Costmdls.new();
     costModels.insert(Language.new_plutus_v1(), costModel);

     const scriptDataHash = hash_script_data(redeemers, costModels, datums);
     txBody.set_script_data_hash(scriptDataHash);

     txBody.set_collateral(inputs);

     const baseAddress = BaseAddress.from_address(shellyChangeAddress)
     const requiredSigners = Ed25519KeyHashes.new();
     requiredSigners.add(baseAddress.payment_cred().to_keyhash());

     txBody.set_required_signers(requiredSigners);

     const tx = Transaction.new(
         txBody,
         transactionWitnessSet.from_bytes(transactionWitnessSet.to_bytes())
     )

     let txVkeyWitness = await this.API.signTx(Buffer.from(tx.to_bytes(), "utf8"), true);
     txVkeyWitness = transactionWitnessSet.set_vkeys(txVkeyWitness.vkeys());

     const signedTx = Transaction.new(
         tx.body(),
         transactionWitnessSet
     );

     const submittedTxHash = await this.API.submitTx(Buffer.from(signedTx.to_bytes(), "utf8").toSrting("hex"));
    //  console.log(submittedTxHash)
    this.setState({submittedTxHash});

 }