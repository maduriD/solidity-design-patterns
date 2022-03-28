// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

/*
This is example of access restriction pattern where access to execution of some function is restricted.
In this example only DogOwner can take the dog for a walk.

*/
contract AccessRestrictionPattern {
    address private admin;
    mapping(uint => address) internal dogOwnersMap;

    constructor() {
        admin = msg.sender;
    }

    function addDogOwner(uint dog, address owner) public isAdmin {
        dogOwnersMap[dog] = owner;
    }

    function takeDogForWalk(uint dog) public isDogOwner(dog) {
        // the real dog owner is free to take the dog for a walk
    }

    modifier isDogOwner(uint dog) {
        require(dogOwnersMap[dog] == msg.sender, "Only dog owner can take the dog for a walk");
        _;
    }

    modifier isAdmin() {
        require(msg.sender == admin, "Sender is not owner");
        _;
    }

} 