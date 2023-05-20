module.exports = {
  networks: {
    development: {
      // host: "192.168.60.141", // --isha
      host: "192.168.0.105", //--mohit
      port: 7545,
      network_id: "5777",
    },
    advanced: {
      websockets: true,
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
