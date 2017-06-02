/*
 * Functions to load from geth
 */

// https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts
// Print the total amout of ether in all known accounts
// from geth command-line
function checkAllBalances() {
  var totalBal = 0;
  for (var acctNum in eth.accounts) {
    var acct = eth.accounts[acctNum];
    var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
    totalBal += parseFloat(acctBal);
    console.log("  eth.accounts[" + acctNum + "]: \t" +
                acct + " \tbalance: " + acctBal + " ether");
  }
  console.log("  Total balance: " + totalBal + " ether");
}
