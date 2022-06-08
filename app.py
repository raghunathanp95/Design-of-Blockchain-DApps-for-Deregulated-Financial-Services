import json
from web3 import Web3, HTTPProvider

# truffle development blockchain address
blockchain_address = 'http://127.0.0.1:9545'
# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
web3.eth.defaultAccount = web3.eth.accounts[0]

# Path to the compiled contract JSON file
compiled_contract_path = 'build/contracts/GSTContract.json'
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0x4DCfa573484EB45eF45B9a968AB5e800DE7dE490'

with open(compiled_contract_path) as file:
    contract_json = json.load(file)  # load contract info as JSON
    contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions

# Fetch deployed contract reference
contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)

# Call contract function (this is not persisted to the blockchain)
# GST function takes input taxable_amount = 100rs, item = 16%, total_amount = 116rs, origin = A, destination = B
message = contract.functions.GST(100,16,116,'Kochi','Bangalore').call()

print(message)
