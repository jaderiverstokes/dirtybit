from bitcoin.rpc import RawProxy

p = RawProxy()

info = p.getblockchaininfo()
print(info)

blockheight = info['blocks']
print(blockheight)

blockhash = p.getblockhash(blockheight)
print(blockhash)

block = p.getblock(blockhash)
print(block)

transactions = block['tx']

block_value = 0

for txid in transactions:
    tx_value = 0
    raw_tx = p.getrawtransaction(txid)
    decoded_tx = p.decoderawtransaction(raw_tx)
    for output in decoded_tx['vout']:
        tx_value = tx_value + output['value']
    block_value = block_value + tx_value
print(block_value)
