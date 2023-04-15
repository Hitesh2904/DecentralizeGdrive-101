// SPDX-License-identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract uplaod
{
    struct access
    {
        address user;
        bool access;
    }

    mapping(address=>string[]) value;
    mapping(address=>mapping(address=>bool)) ownership;
    mapping(address=>access[]) accessList;
    mapping(address=>mapping(address=>bool)) previousData;

    function add(address user, string memory ur1) external
    {
        value[user].push(ur1);
    }

    function allow(address user) external
    {
        ownership[msg.sender][user] = true;
        if(previousData[msg.sender][user])
        {
            for(uint i=0; i < accessList[msg.sender].length ;i++)
                if(accessList[msg.sender][i].user == user)
                {
                    accessList[msg.sender][i].access = true;
                }
        }
        else
            {
                accessList[msg.sender].push(access(user,true));
                previousData[msg.sender][user]=true;  
            }
    }

    function disallow(address user) public
    {
        ownership[msg.sender][user] = false;
        
        for(uint i=0 ; i < accessList[msg.sender].length ;i++)
        {
            if(accessList[msg.sender][i].user == user)
            {
                accessList[msg.sender][i].access = false;
            }
        }
    }

    function Display(address user) external view returns(string[] memory)
    {
        require(user == msg.sender ||  ownership[user][msg.sender], "You dont have access");
        return value[user];
    }

    function shareAcess() public view returns(access[] memory)
    {
        return accessList[msg.sender];
    }
}