module MyFirstPlutusSmartContract where

import qualified Language.PlutusTx            as PlutusTx
import           Ledger

myFirstValidator :: ValidatorScript
myFirstValidator = ValidatorScript (fromCompiledCode $$(PlutusTx.compile
    [|| \(a :: ()) (b :: ()) (c :: ()) -> ()  ||]))