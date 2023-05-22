module.exports = {
  networks: {
    development: {
      // host: "192.168.4.141", // --isha
      // host: "192.168.0.105", //--mohit
      host: "34.131.90.213",
      port: 80,
      network_id: "*",
    },
  },
  contracts_build_directory: "./src/abis/",
  compilers: {
    solc: {
      version: "0.8.19",
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
// geth --http --http.corsdomain "*" --http.api web3,eth,debug,personal,net --http.vhosts "*" --ws --ws.api web3,eth,debug,personal,net --vmdebug --dev console attach
// eth.sendTransaction({
//   from: eth.coinbase,
//   to: "0x86fDC5685b533923e5E7Cd4F7154D692A5643677",
//   value: web3.toWei(5000, "ether"),
// });
