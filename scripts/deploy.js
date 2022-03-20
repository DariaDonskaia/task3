const hre = require("hardhat"); 


async function main() {
    const [deployer] = await ethers.getSigners();
    console.log('Deploying contracts with the account:', deployer.address);
    const myNFT = await ethers.getContractFactory("myNFT");
    const mynft = await myNFT.deploy();
    console.log(`Contract deployed to address: ${mynft.address}`);
}

main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});