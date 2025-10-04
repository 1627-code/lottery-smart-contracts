
# 🎲 Lottery Smart Contract (Foundry Fundamentals)

This project is a Lottery (a.k.a Raffle) smart contract built as part of the **Foundry Fundamentals Course** by Patrick Collins.  
It showcases how to write, test, and deploy advanced Solidity contracts with randomness, Chainlink VRF, and automation using Chainlink Keepers.


## Features

- Players can enter the lottery by paying ETH.
- Winner is chosen automatically using **Chainlink VRF** for randomness.
- Lottery upkeep is automated using **Chainlink Keepers**.
- Fully tested using **Foundry** (unit tests + integration tests).
- Deployable on **Sepolia Testnet** with Chainlink VRF subscription.


## 📂 Project Structure
```
├── src/
│ └── Raffle.sol # Main Lottery contract
│
├── script/
│ ├── DeployRaffle.s.sol # Deployment script
│ └── Interactions.s.sol # Interaction script (enter, checkUpkeep, etc.)
│
├── test/
│ ├── unit/ # Unit tests for core logic
│ └── integration/ # Integration tests with mocks & network
│
├── foundry.toml # Foundry config
└── README.md # This file
```
## 🛠️ Tech Stack
- [Solidity ^0.8.x](https://soliditylang.org/)  
- [Foundry](https://book.getfoundry.sh/) (Forge + Cast + Anvil)  
- [Chainlink VRF](https://docs.chain.link/vrf/v2/introduction) (randomness)  
- [Chainlink Keepers](https://docs.chain.link/chainlink-automation/introduction) (automation)  
- [Alchemy](https://alchemy.com) (RPC provider)  
## 🚀 Getting Started

### Prequisites
- Install [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Have a funded wallet with Sepolia ETH (for deployment & VRF subscription)
- Set up environment variables:
```bash
export SEPOLIA_RPC_URL="https://eth-sepolia.g.alchemy.com/v2/<your-key>"
export PRIVATE_KEY="<your-wallet-private-key>"
export ETHERSCAN_API_KEY="<your-etherscan-api-key>"
```
## 🛠️ Build

```bash
forge build
```
## Running Tests

To run tests, run the following command

```bash
 forge test

```


## Deployment

To deploy this project run

```bash
  forge script script/DeployRaffle.s.sol:DeployRaffle \
  --rpc-url $SEPOLIA_RPC_URL \
  --account <your-account> \
  --broadcast

```


## 🧪 Tests

Unit tests ensure each function works as expected.

Integration tests simulate Chainlink VRF + Keepers behavior.

```bash
forge test --match-path test/unit/RaffleTest.t.sol
forge test --match-path test/integration/InteractionsTest.t.sol
```
## 📖 Learning Outcomes

This repo represents my journey through:

- Debugging tricky Foundry issues (console.log, chain IDs, gas errors)

- Handling Chainlink subscription ownership & VRF requests

- Understanding the difference between Ethereum mainnet fork vs Sepolia testnet fork

- Writing resilient tests that simulate real-world blockchain conditions


## 🙏 Credits

Huge thanks to Patrick Collins and the Cyfrin Updraft
 team for creating this course and pushing me beyond my limits.
This project taught me not only Solidity, but also resilience in debugging and persistence in learning Web3.


## 📬 Contact

Built with ❤️ by Ebenezer Evero Ighozino

LinkedIn @https://www.linkedin.com/in/ebenezer-evero-49323b27a/

Twitter/X @https://x.com/BennyEvero
