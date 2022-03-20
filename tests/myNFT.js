const { expect } = require("chai");
const { ethers, waffle} = require("hardhat");
const provider = waffle.provider;

describe("Deployment token contract",  function (){
    let ZERO_ADDRESS = "0x0000000000000000000000000000000000000000";
    let mynft;
   
    beforeEach(async function () {
        [owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners()
        const myNFT = await ethers.getContractFactory("myNFT");
        mynft = await myNFT.deploy();
        await mynft.deployed()
    });
     

    describe("Test getter functions group", function () {

         //mintTo require
        it("Should check require nyNFT token", async function () {
            await expect(mynft.connect(owner).mintTo(ZERO_ADDRESS)).to.be.revertedWith("Recipient don't be equal zero address");
        });
         
        it("Should check require ownable contract", async function () {
            await expect(mynft.connect(addr1).mintTo(addr1.address)).to.be.revertedWith("Ownable: caller is not the owne");
        }); 

        it("Should mint nyNFT token", async function () {
            await mynft.connect(owner).mintTo(addr1.address);
            expect( await mynft.connect(owner)._ownerOf(mynft.connect(owner).getTokenId())).to.equal(addr1.address);
        }); 
    });
});