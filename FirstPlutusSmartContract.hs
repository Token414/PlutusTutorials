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

depositADA :: Value -> MockWallet ()
depositADA val = payToScript_ smartContractAddress val unitData

withdrawADA :: MockWallet ()
withdrawADA = collectFromScript myFirstValidator unitRedeemer

$(mkFunction 'watchSmartContract)
$(mkFunction 'depositADA)
$(mkFunction 'withdrawADA)