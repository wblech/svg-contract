# Solidity SVG Contract
This is an experiment on using the SVG to create NFT with imagem and metadata on-chain

# How to config
Create an .env file with your private key and the RPC of the blockchain your are using.
You can configure the type of blockchain on the hardhat.config.js file

# How to deploy
For a fast deploy you com use the file ./deploy/01_deploy_svgnft.js
Just make sure to create an imagem in svg to be deployed on the blockchain
After that you can run this codes

```bash
yarn
npx hardhat deploy --network <name of the network in config file>
```

You can run a local deploy running this commands
```bash
yarn
npx hardhat deploy
```
