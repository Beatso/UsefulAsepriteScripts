if not app.isUIAvailable then return end

if app.activeSprite == nil then
	app.alert ("Open a sprite first.")
	return
end

local sprite = app.site.sprite
local oldSize = { width = sprite.width, height = sprite.height}
local dialog = Dialog("Resize Sprite")

dialog:label {
	label = string.format("Current size: %sx%s", oldSize.width, oldSize.height)
}

dialog:separator()

dialog:number {
	id = "width",
	label = "Width:"
}

dialog:number {
	id = "height",
	label = "Height:"
}

dialog:newrow()

dialog:button {
	id = "ok",
	text = "OK",
	onclick = function ()

		local newWidth = dialog.data.width
		local newHeight = dialog.data.height

		-- resize sprite
		sprite.width = newWidth
		sprite.height = newHeight

		dialog:close()

		-- move cels
		for frameIndex, frame in ipairs(sprite.frames) do
			for layerIndex, layer in ipairs(sprite.layers) do

				local cel = layer:cel(frameIndex)

				cel.position = Point (
					cel.position.x * (newWidth / oldSize.width),
					cel.position.y * (newHeight / oldSize.height)
				)

			end
		end

	end
}

dialog:show()

