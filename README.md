# Freelance Escrow Smart Contract

A decentralized, secure, and transparent escrow smart contract built with Solidity. This contract acts as a trusted third-party system to facilitate freelance transactions, ensuring that funds are securely locked until the client approves the work, with an arbiter option to resolve any disputes.

---

## Features

- **Fund Security:** Client deposits funds directly into the smart contract during deployment.
- **Direct Payout:** Client can release funds directly to the freelancer upon successful completion of work.
- **Dispute Resolution:** Either the client or the freelancer can trigger a dispute if an issue arises.
- **Arbiter Management:** A trusted third-party (Arbiter) can resolve disputes and refund the client if necessary.

---

## Smart Contract Details

- **Language:** Solidity `^0.8.20`
- **License:** MIT

### Roles & Actors
1. **Client:** The party who deploys the contract and funds the escrow.
2. **Freelancer:** The party performing the service who receives the funds upon completion.
3. **Arbiter:** A designated neutral third party responsible for resolving conflicts.

---

## State Workflow

The contract follows a strict lifecycle governed by the `EscrowStatus` enum:
- `Funded`: The initial state when the contract is deployed with ether.
- `Released`: Funds are transferred to the freelancer (Contract Closed).
- `Disputed`: Funds are locked due to a disagreement between parties.
- `Refunded`: Funds are returned to the client by the arbiter after a dispute.

---

## Functions

### `constructor(address _freelancer, address _arbiter)`
Deploys the contract, assigns the freelancer and arbiter addresses, and locks the deposited ether (`msg.value`).

### `releaseFunds()`
- **Callable by:** Client only.
- **Action:** Transfers the entire locked amount to the freelancer's wallet.

### `raiseDispute()`
- **Callable by:** Client or Freelancer.
- **Action:** Locks the contract state into `Disputed`, halting any direct fund release.

### `refundClient()`
- **Callable by:** Arbiter only.
- **Action:** Resolves a dispute by returning all locked funds back to the client.

---

## How to Test on Remix IDE

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file named `FreelanceEscrow.sol` and paste the contract code.
3. Compile using Solidity compiler version `0.8.20` or higher.
4. Go to the **Deploy & Run Transactions** tab.
5. Provide the `_freelancer` and `_arbiter` addresses, set the **Value** (e.g., `1 ETH`), and click **Deploy**.
6. Interact with the deployed contract using the generated interface buttons.

---

## License

This project is licensed under the MIT License.
