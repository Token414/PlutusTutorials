module MyFirstPlutusSmartContract where

import qualified Language.PlutusTx            as PlutusTx
import           Ledger
import           Wallet
import           Ledger.Validation
import           Playground.Contract


myFirstValidator :: ValidatorScript
myFirstValidator = ValidatorScript (fromCompiledCode $$(PlutusTx.compile
    [|| \(submittedPIN :: Int) (myPIN :: Int) (p :: PendingTx') -> ()  ||]))
   
smartContractAddress :: Address'
smartContractAddress = scriptAddress myFirstValidator

watchSmartContract :: MockWallet ()
watchSmartContract = startWatching smartContractAddress

depositADA :: Int -> Value -> MockWallet ()
depositADA pin val = payToScript_ smartContractAddress val (DataScript (lifted pin))

withdrawADA :: Int -> MockWallet ()
withdrawADA pin = collectFromScript myFirstValidator (RedeemerScript (lifted pin))

$(mkFunction 'watchSmartContract)
$(mkFunction 'depositADA)
$(mkFunction 'withdrawADA)