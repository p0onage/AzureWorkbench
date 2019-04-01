pragma solidity ^0.4.25;

contract DareInitialisor 
{
    enum StateType { DareInstantiated, DareAccepted, JudgeConfirmed, Complete,DareRejected, Terminated}
    address public Challenger;
    address public Competitor;
    address public Judge;
    string public Description;
    uint public DonationAmount;
    StateType public State;


    constructor(string description, uint256 price, address judge, address competitor) public
    {
        Challenger = msg.sender;
        DonationAmount = price;
        Description = description;
        State = StateType.DareInstantiated;
        Judge = judge;
        Competitor = competitor;
    }

    function Modify(string description, uint256 price) public
    {
        if (State != StateType.DareInstantiated)
        {
            revert();
        }
        if (Challenger != msg.sender)
        {
            revert();
        }

        Description = description;
        DonationAmount = price;
    }

    function JudgeConfirmed() public
    {
        if (Judge == 0x0 || Competitor == 0x0 || DonationAmount == 0)
        {
            revert();
        }
        if (State != StateType.DareAccepted)
        {
            revert();
        }

        // don't want the judge to be the same as the darer
        // if (InstanceOwner == msg.sender) 
        // {
        //     revert();
        // }
        State = StateType.JudgeConfirmed;
    }

    function Complete() public 
    {
        State = StateType.Complete;
    }

    function AcceptDare() public
    {
        if (State != StateType.DareInstantiated)
        {
            revert();
        }
        if (Competitor != msg.sender)
        {
            revert();
        }

        State = StateType.DareAccepted;
    }

    function RejectDare() public
    {
        if (State != StateType.DareInstantiated)
        {
            revert();
        }
        if (Competitor != msg.sender)
        {
            revert();
        }

        State = StateType.DareRejected;
    }

}
