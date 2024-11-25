import { useEffect, useState } from 'react';
import Web3 from 'web3';
import detectEthereumProvider from '@metamask/detect-provider'

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
      
      const provider = await detectEthereumProvider(); // instead of doing many if...else (w.ethereum, w.web3 or localhost)

      if (provider) {
        setWeb3Api({
          web3: new Web3(provider),
          provider,
        });
      } else {
        console.error('Please install MetaMask!');
      }
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
          <div className="is-flex is-align-items-center">
            <span className="mr-2">
              <strong>Account: </strong> 
            </span>
            {account ? (
                <span>{account}</span>
              ) : (
                <button
                  className="button is-small"
                  onClick={() => web3Api.provider.request({ method: 'eth_requestAccounts' })}
                >
                  Connect Collect
                </button>
              )
            }
          </div>
          <div className="balance-view is-size-2 my-4">
            Current Balance: <strong>10</strong> ETH
          </div>
          <button className="button is-link mr-2">Donate</button>
          <button className="button is-primary">Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
