import contract from '@truffle/contract';

export const loadContract = async (name, provider) => {
  const res = await fetch(`/contracts/${name}.json`);
  const Artifact = await res.json();
  const _contract = await contract(Artifact);
  _contract.setProvider(provider);

  let deployedContract = null;

  try {
    deployedContract = await _contract.deployed(); // we get this from network (in this case Ganache)
  } catch (error) {
    console.error('Cannot load the contract or you are connecting to the wrong network.', error);
  }

  return deployedContract ;
};
