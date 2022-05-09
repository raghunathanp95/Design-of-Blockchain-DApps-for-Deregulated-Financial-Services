// SPDX-License-Identifier: MIT

// Declare the versions of the Solidity Compiler
pragma solidity ^0.4.4;
// library for logging in console
import "hardhat/console.sol";

// Used to convert unint to string
//import "@openzeppelin/contracts/utils.Strings.sol";

contract GSTContract{
    string public GST_App = "Active"; //checks whether active or not
    uint public Check_Slab = 16; // tax slab is 16% example
    string myName = "Raghu";

    constructor() {}
    // function funcName (parameterlist) scope returns() {statements}
    // takes input taxable_amount = 100rs, item = 16%, amount_amount = 116rs, origin = A, destination = B
    
    function GST(uint taxable_amount, uint item, uint amount_paid, string memory origin, string memory destination) public view returns (string memory){
        if(item == Check_Slab){
            if(amount_paid == (taxable_amount + ((Check_Slab*taxable_amount))/100)){
                if(keccak256(abi.encodePacked((origin))) == keccak256(abi.encodePacked((destination)))){
                    uint igst = amount_paid - taxable_amount;
                    console.log("Successfully paid IGST = %s", igst);
                    //return igst;
                    return appendUintToString("Successfully paid IGST of Rs: ", igst);
                    
                }
                else{
                    uint cgst = (amount_paid - taxable_amount)/2;
                    //uint sgst = (amount_paid - taxable_amount)/2;
                    console.log("Successfully paid CGST, SGST = %s", cgst);
                    return appendUintToString("Successfully paid CGST, SGST of Rs: ", cgst);                   
                }
            }else{console.log("Tax not fully paid!");}
        }else{console.log("Tax slab not equal!");}
    }

    // This function concatenate Uint & String
    function appendUintToString(string memory inStr, uint v) private view returns (string memory str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory inStrb = bytes(inStr);
        bytes memory s = new bytes(inStrb.length + i);
        uint j;
        for (j = 0; j < inStrb.length; j++) {
            s[j] = inStrb[j];
        }
        for (j = 0; j < i; j++) {
            s[j + inStrb.length] = reversed[i - 1 - j];
        }
        str = string(s);
    }

} 
