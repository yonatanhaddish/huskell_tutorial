import Plutus.Contract
import PlutusTx (Data (..))
import qualified PlutusTx
import qualified PlutusTx.Builtins as Builtins
import PlutusTx.Prelude hiding (Semigroup(..), unless)
import Ledger hiding (singleton)
import Ledger.Constraints as Constraints
import qualified Ledger.Scripts as Scripts
import Ledger.Ada as Ada
import Playground.Contract (printJson, printSchemas, ensureKnownCurrencies, stage)
import Playground.TH (mkKnownCurrencies, mkSchemaDefinitions)
import Playground.Types (KnownCurrency (..))
import Prelude (IO, Semigroup (..), String)
import Text.Printf (printf)

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

{-# INLINABLE mkValidator #-}
mkValidator :: BuiltinData -> BuiltinData -> BuiltinData -> ()
mkValidator _ _ _ = ()

validator :: Validator
validator = mkValidatorScript $$(PlutusTx.compile [|| mkValidator ||])

valHash :: Ledger.ValidatorHash
valHash = Scripts.ValidatorHash validator

scrAddress :: Ledger.Address
scrAddress = scrAddress validator

type GiftSchema = Endpoint "give" Integer
              .\/ Endpoint "grab" ()


