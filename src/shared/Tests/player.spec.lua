--[[local testerUsername = "WithinCode" --Change this

return function ()
    local player = require(script.Parent.Parent.Player)

    describe("new", function()
        it("should error when no player is passed", function()
            expect(player.new()).to.throw();
        end)
        it("should recognize strings as players", function()
            expect(player.new(testerUsername)).to.be.ok();
        end)
        it("should accept player objects", function()
            local p = game.Players:WaitForChild(testerUsername);
            expect(player.new(p)).to.be.ok();
        end)
    end)

    describe("switchWeapon", function()
        
    end)

end]]