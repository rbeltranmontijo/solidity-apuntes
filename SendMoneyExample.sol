pragma solidity ^0.5.13;

contract SendMoneyExample {
    
    uint public balanceReceived;
    
    // Funcion para recibir dinero desde el exterior
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    
    // Funcion para saber el balance del smart contract y regresa la wallet
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // Funcion para retirar el balance a quien esta ejecutando el smart
    function withdrawMoney() public {
        address payable to = msg.sender;
        
        to.transfer(this.getBalance());
        
        balanceReceived = this.getBalance();
    }
    
    // Funcio  para retirar el balance y especificar a que wallet se envia
    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
         balanceReceived = this.getBalance();
    }
    
}