/* global ethers */
/* eslint no-undef: "off" */
/* eslint no-unused-vars: "off" */
const fs = require('fs');
const {networkConfig} = require('../helper-hardhat-config')

module.exports = async({
    getNamedAccounts,
    deployments,
    getChainId
}) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = await getChainId()

    log("-----------------------------------------")
    const SVGNFT = await deploy("SVGNFT", { 
        from: deployer,
        log: true
    })
    log(`You have deployed an NFT contract to ${SVGNFT.address}`)
    const filePath = "./img/triangle.svg"
    const svg = fs.readFileSync(filePath, { encoding: 'utf8' })

    const svgNFTContract = await ethers.getContractFactory("SVGNFT")
    const accounts = await hre.ethers.getSigners()
    const signer = accounts[0]
    const svgNFT = new ethers.Contract(SVGNFT.address, svgNFTContract.interface, signer)
    const networkName = networkConfig[chainId].name
    log(`Verify with: \n npx hardhat verify --network ${networkName} ${svgNFT.address}`)

    const transactionResponse = await svgNFT.create(svg)
    const receipt = await transactionResponse.wait(1)
    log(`You have made an NFT!`)
    log(`You can view the token the tokenURI here ${await svgNFT.tokenURI(0)}`)
}
