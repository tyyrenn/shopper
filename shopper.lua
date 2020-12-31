Shopper = LibStub('AceAddon-3.0'):NewAddon('Shopper', 'AceConsole-3.0')

-- idea: Config GUI that takes a list of recipe spell IDs, and a slash cmd that
--       breaks them down into their components, scans the AH, and reports
--       whether it's cheaper to craft or to buy

local defaults = {
  profile = {
    recipes = {
      -- cooking
      308405, 308413, 308426,
      -- alchemy
      307101, 307118, 307119,
      -- leatherworking
      -- nested recipe; Armor Kit should use cheaper of reg/heavy leather
      -- 308899, 324088
    }
  }
}

local options = {
  name = 'Shopper',
  handler = Shopper,
  type = 'group',
  args = {
  },
}

function Shopper:OnInitialize()
  self.db = LibStub('AceDB-3.0'):New('ShopperDB', defaults, true)

  LibStub('AceConfig-3.0'):RegisterOptionsTable('Shopper', options)
  self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('Shopper', 'Shopper')
  self:RegisterChatCommand('shopper', 'ChatCommand')
  self:RegisterChatCommand('shp', 'ChatCommand')
end

function Shopper:OnEnable()
end

function Shopper:OnDisable()
end

function Shopper:ChatCommand(input)
  if input and input:trim() == 'config' then
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
  else
    LibStub('AceConfigCmd-3.0'):HandleCommand('shp', 'Shopper', input)
  end
end

function shopper_analyzerecipe(recipeID)
  local numReagents = C_TradeSkillUI.GetRecipeNumReagents(recipeID)
  -- for each reagent
  local qty = select(3, C_TradeSkillUI.GetRecipeReagentInfo(recipeID, reagentIndex))
  -- todo (tyyrenn): How to get reagent item ID from item name?
end
