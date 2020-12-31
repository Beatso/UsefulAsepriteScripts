local oldSprite = app.site.sprite

local newSprite = Sprite( oldSprite.width, oldSprite.height * #oldSprite.frames)

local firstLayer = newSprite.layers[1]
newSprite:deleteCel(newSprite.cels[1])

for frameIndex, oldFrame in ipairs(oldSprite.frames) do
	for layerIndex, oldLayer in ipairs(oldSprite.layers) do
		local oldCel = oldLayer:cel(frameIndex)
		local newPos = oldCel.position
		local newLayer = newSprite:newLayer()
		
		newPos.y = newPos.y + (oldSprite.height * (frameIndex - 1) )
		newSprite:newCel(newLayer, 1, oldCel.image, newPos)
	end
end

newSprite:flatten()
