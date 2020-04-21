pragma solidity ^0.5.13;

contract StartStopUpdateExample {
    address owner;

    bool paused;
    
    constructor() public {
        //aqui se guarda el adress de quien hizo el deploy del contrato
        owner = msg.sender;
    }
    
    function sendMoney() public payable {
        
    }

    function setPaused(bool _paused) public {
        // solo si eres el propietario
        require(msg.sender == owner, "No eres el propietario");
        paused = _paused;
    }
    
    function withdrawAllMoney(address payable _to) public {
        // el require es como un if que no permite el withdraw si  no eres el propietario del smart
        require(msg.sender == owner, "No eres el propietario del smart contract");
        // pausa los retiros
        require(!paused, "Contrato pausado");
        _to.transfer(address(this).balance);
    }

    // esta funcion destruye el smart contract
    // es payable porque regresa todos los fondos que tenia almacenados
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "No eres el propietario");
        selfdestruct(_to);
    }
}