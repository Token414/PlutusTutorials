module MyFirstPlutusSmartContract where

import qualified Language.PlutusTx            as PlutusTx
import           Ledger
import           Wallet
import           Playground.Contract


myFirstValidator :: ValidatorScript
myFirstValidator = ValidatorScript (fromCompiledCode $$(PlutusTx.compile
    [|| \(a :: ()) (b :: ()) (c :: ()) -> ()  ||]))
   
smartContractAddress :: Address'
smartContractAddress = scriptAddress myFirstValidator

watchSmartContract :: MockWallet ()
watchSmartContract = startWatching smartContractAddress

$(mkFunction 'watchSmartContract)