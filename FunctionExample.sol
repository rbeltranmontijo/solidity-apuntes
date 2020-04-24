pragma solidity ^0.5.12;

contract FunctionExample {
     mapping(address => uint64) public balanceReceived;
     
     address payable owner;
     
     // El constructor se ejecuta solo en el deploy y es una sola vez
     constructor() public {
         owner = msg.sender;
     }
     // write function
     function destroySmartContract() public {
         require(msg.sender == owner, "No eres el propietario");
         selfdestruct(owner);
     }
     
     // Funcion view
     // pueden acceder a la variables del state pero solo para leer
     // no pueden llamar a funciones normales solo a view o pure
     function getOwner() public view returns(address) {
         return owner;
     }
     
     //Las pure function son las que no interactuan con las store variables
     // solo pueden llamar a otras pure function
     function convertWeiToEther(uint _amountInWei) public pure returns(uint) {
         // 1 ether es lo mismo que 1x10^18  ó 1000000000000000000 
         return _amountInWei / 1 ether;
     }

     function receiveMoney() public payable {
         assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
         balanceReceived[msg.sender] += uint64(msg.value);
     }
    
     function withdrawMoney(address payable _to, uint _amount) public {
         require(_amount <= balanceReceived[msg.sender], "not enough funds.");
         assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
         balanceReceived[msg.sender] -= uint64(_amount);
         _to.transfer(_amount);
     }
     
     // Esta es una funcion fallback solo pueden ser external function
     // se ejecuta automaticamente cuando recibe un pago desde fuera
     // external solo se pueden llamar de fuera del contrato
     function () external payable {
         receiveMoney();
     }
}