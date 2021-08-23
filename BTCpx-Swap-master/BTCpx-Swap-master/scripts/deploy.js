async function main() {
  const treasury = "0x3d86F31bF8DE193C6fd77FA925E4155eE2075d8d";
  const wbtc = "0xc04b0d3107736c32e19f1c62b2af67be61d63a05";
  const btcpx = "0x100c5abf85e6035c02771cb3ddc803350da77d3c";
  const prxy = "0x612Ca9049f4fACFD923f2360da14D35803Fc6521";

  const ControllerFactory = await ethers.getContractFactory("BTCSwap");
  const contract = await ControllerFactory.deploy(treasury, wbtc, btcpx, prxy);
  console.log("BTCSwap deployed at ", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
