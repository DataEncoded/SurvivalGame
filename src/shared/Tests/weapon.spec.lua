--[[return function()
    local weaponModule = require(script.Parent.Parent.Weapon);

    describe("new", function()
        it("should fail to create an empty weapon without parameters", function()
            expect(weaponModule.new()).to.throw();
        end)
        it("should create a weapon with correct parameters", function()
            expect(weaponModule.new("Pistol", 25, 0.05, 21)).to.be.ok(); --Weapon Name, Damage, Debounce, Max Ammo
        end)
    end)

    describe("Shoot", function()
        it("should start debounce and remove one ammo", function()
            local weapon = weaponModule.new("Pistol", 25, 0.05, 21)

            expect(weapon:Shoot(Vector3())).to.be.ok();
            expect(weapon.debounce).to.be.equal(true);
            expect(weapon.ammo)

        end)
    end)
end]]