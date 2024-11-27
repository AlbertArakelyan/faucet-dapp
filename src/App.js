import { useEffect, useState, useCallback } from 'react';
import Web3 from 'web3';
import detectEthereumProvider from '@metamask/detect-provider';

import { loadContract } from './utils/loadContract';

import './App.css';

const DONATING_ETH_AMOUNT = '1';

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null,
  });
  const [balance, setBalance] = useState(null);
  const [account, setAccount] = useState(null);
  const [shouldReload, setShouldReload] = useState(false);

  useEffect(() => {
    const loadProvider = async () => {
      // with metamask we have an access window.ethereum & to window.web3
      // metamask injects a global API into websitea
      // this API allows websites to request users, accounts, read data to blockchain
      // sign messages and transactions

      const provider = await detectEthereumProvider(); // instead of doing many if...else (w.ethereum, w.web3 or localhost)

      if (provider) {
        const contract = await loadContract('Faucet', provider);

        setWeb3Api({
          web3: new Web3(provider),
          provider,
          contract,
        });
      } else {
        console.error('Please install MetaMask!');
      }
    };

    loadProvider();
  }, []);

  useEffect(() => {
    const laodBalance = async () => {
      const { contract, web3 } = web3Api;
      const balance = await web3.eth.getBalance(contract.address);
      setBalance(web3.utils.fromWei(balance, 'ether'));
    };

    web3Api.contract && laodBalance();
  }, [web3Api, shouldReload]);

  useEffect(() => {
    const getAccount = async () => {
      const accounts = await web3Api.web3.eth.getAccounts();
      setAccount(accounts[0]);
    };

    web3Api.web3 && getAccount();
  }, [web3Api.web3]);

  const reloadEffect = () => {
    setShouldReload(!shouldReload);
  };

  const addFunds = useCallback(async () => {
    const { contract, web3 } = web3Api;
    await contract.addFunds({
      from: account,
      value: web3.utils.toWei(DONATING_ETH_AMOUNT, 'ether'),
    });

    reloadEffect();
  }, [web3Api, account]);

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          <div className="is-flex is-align-items-center">
            <span className="mr-2">
              <strong>Account: </strong>
            </span>
            {account ? (
              <span>{account}</span>
            ) : (
              <button
                className="button is-small"
                onClick={() =>
                  web3Api.provider.request({ method: "eth_requestAccounts" })
                }
              >
                Connect Wallet
              </button>
            )}
          </div>
          <div className="balance-view is-size-2 my-4">
            Current Balance: <strong>{balance}</strong> ETH
          </div>
          <button
            className="button is-link mr-2"
            onClick={addFunds}
          >
            Donate 1eth
          </button>
          <button className="button is-primary">Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
