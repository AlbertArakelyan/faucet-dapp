import { useEffect, useState } from 'react';
import Web3 from 'web3';

import './App.css';

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
  });
  const [account, setAccount] = useState(null);

  useEffect(() => {
    const loadProvider = async () => {
      // with metamask we have an access window.ethereum & to window.web3
      // metamask injects a global API into websitea
      // this API allows websites to request users, accounts, read data to blockchain
      // sign messages and transactions
      
      let provider = null;
      
      if (window.ethereum) {
        provider = window.ethereum; // newest version

        try {
          await provider.enable();
        } catch (error) {
          console.error('User denied account access!');
        }
      } else if (window.web3) {
        provider = window.web3.currentProvider; // only legacy metamask accounts/applications
      } else if (!process.env.production) {
        provider = new Web3.providers.HttpProvider('http://localhost:7545'); // Ganache
      }

      setWeb3Api({
        web3: new Web3(provider),
        provider,
      });
    };

    loadProvider();
  }, []);

  useEffect(() => {
    const getAccount = async () => {
      const accounts = await web3Api.web3.eth.getAccounts();
      setAccount(accounts[0]);
    };

    web3Api.web3 && getAccount();
  }, [web3Api.web3]);

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          <span>
            <strong>Account: </strong>
          </span>
          <h1>{account ? account : 'Not connected'}</h1>
          <div className="balance-view is-size-2">
            Current Balance: <strong>10</strong> ETH
          </div>
          <button className="btn mr-2">Donate</button>
          <button className="btn">Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
