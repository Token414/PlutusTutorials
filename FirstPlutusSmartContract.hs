module MyFirstPlutusSmartContract where

import qualified Language.PlutusTx            as PlutusTx
import           Ledger
import           Wallet
import           Playground.Contract


myFirstValidator :: ValidatorScript
myFirstValidator = ValidatorScript (fromCompiledCode $$(PlutusTx.compile
    [|| \(a :: ()) (myPIN :: Int) (c :: ()) -> ()  ||]))
   
smartContractAddress :: Address'
smartContractAddress = scriptAddress myFirstValidator

watchSmartContract :: MockWallet ()
watchSmartContract = startWatching smartContractAddress

depositADA :: Int -> Value -> MockWallet ()
depositADA pin val = payToScript_ smartContractAddress val (DataScript (lifted pin))

withdrawADA :: MockWallet ()
withdrawADA = collectFromScript myFirstValidator unitRedeemer

$(mkFunction 'watchSmartContract)
$(mkFunction 'depositADA)
$(mkFunction 'withdrawADA)