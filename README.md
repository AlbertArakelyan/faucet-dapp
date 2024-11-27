# Facuet dApp

![Screenshot](./public/screenshot.png)

<div align="center">
  <img src="https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white" alt="Ethereum">
  <img src="https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white" alt="Solidity">
  <img src="https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB" alt="React">
</div>

<p align="center" style="width: 90%; margin: 0 auto">
  My First <b>blockchain</b> app after having a deep understanding about <b>blockchain technologies</b>
  and after taking a deep course of <b>blockchain</b>, <b>ethereum</b>, <b>Solidity</b> and about
  blockchain development in general.
</p>

## 🔍 About dApp
Here you can find a huge starter information about the application also all used approaches in it for
deeping dive into blockchain development such as

- React App installation guidance, Node.js versions for development
- What is [Solidity](https://soliditylang.org/)
- All used approaches during development with [Solidity](https://soliditylang.org/) via a cheatsheet (right in this README)
- What are [Tuffle](https://archive.trufflesuite.com/) and [Ganache](https://archive.trufflesuite.com/ganache/) and how to install and initialize them

## 📦 Installation
Here you will get to know which Node.js, npm and yarn versions you need for running this project, also
how to install the project.

### Versions
- node v20.18.0
- npm v10.8.2
- yarn v1.22.22

1. Clone the repository
```bash
https://github.com/AlbertArakelyan/faucet-dapp.git
```

2. Install dependencies
```bash
yarn
```

3. Run the project
```bash
yarn start
```

### \* Depricatied package
There is a package for interacting with deployed smart contracts by truffle [@truffle/contract](https://www.npmjs.com/package/@truffle/contract) which is currently deprecated and I couldn't find an alternative for that, and this caused lot's Webpack errors and also fetching a `json` file caused as well.

For solving this problem I had to create [config-overrides.js](./config-overrides.js) file and add browserified versions of missing **Node.js packages**. More details about the fix you will find inside of [config-overrides.js](./config-overrides.js) file.

## Solidity
[Solidity](https://soliditylang.org/) is a programming language for developing Smart Contracts for interacting with blockchain, making crypto transfers and many other things.

## Used approaches in Solidity and cheatsheet
