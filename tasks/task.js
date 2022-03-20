const { task } = require("hardhat/config");
const fetch = require("node-fetch");
const { ethers } = require("ethers");



task("mint", "Mints from the NFT contract")
.addParam("address", "The address to receive a token")
.setAction(async function (taskArguments, hre) {
    const MyContract = await ethers.getContractFactory("myNFT");
    hardhatToken = await MyContract.deploy();  
    const transactionResponse = await hardhatToken.mintTo(taskArguments.address);
    console.log('You create your NFT token and transfer to: ', taskArguments.address);
});

