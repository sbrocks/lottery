pragma solidity ^ 0.4.17;

contract Lottery {
	address public manager;
	address[] public players;

	function Lottery() public {
		manager = msg.sender;
	}

	function enter() public payable {
		// require() is used to check whether some requirement is fulfilled before executing main code
		require(msg.value > .01 ether);
		players.push(msg.sender);
	}

	// pseudo random generator
	function random() private view returns (uint) {
		return uint(keccak256(block.difficulty, now, players));
	} 

	function pickWinner() public restricted{
		// It gives a random index from players array as the winner index
		uint index = random() % players.length;
		// We transfer the entire money of the current contract to this player address
		players[index].transfer(this.balance);

		// As the winner is selected, the players array must be empty now
		// and we have to reset the contract and make players[] empty
		players = new address[](0); 
	}

	// modifier is similar to middlewares in Node.js
	modifier restricted() {
		// To check that this function is called by manager only
		// as only the manager can pick the winner 
		require(msg.sender == manager);
		_;
	}

	// Get all the players in the contract
	function getPlayers() public view returns (address[]) {
		return players;
	}

}  
  



