if not app.isUIAvailable then return end

local inputDialog = Dialog("Select Colours")

inputDialog:newrow {
	always = true
}

inputDialog:color {
	id = "colourOne",
	label = "Colour 1"
}

inputDialog:color {
	id = "colourTwo",
	label = "Colour 2"
}

inputDialog:slider {
	id = "midpoints",
	label = "Midpoints",
	min = 1,
	max = 12,
	value = 1
}

inputDialog:button {
	id = "ok",
	text = "OK",
	onclick = function ()

		inputDialog:close()

		results = {
			inputDialog.data.colourOne
		}

		
		local getMidValue = function (num1, num2, index)
			return num1 + (index * ((num2 - num1) / (inputDialog.data.midpoints + 1)))
		end

		for i = 1, inputDialog.data.midpoints do
			results[i+1] = Color {
				red = getMidValue(inputDialog.data.colourOne.red, inputDialog.data.colourTwo.red, i),
				green = getMidValue(inputDialog.data.colourOne.green, inputDialog.data.colourTwo.green, i),
				blue = getMidValue(inputDialog.data.colourOne.blue, inputDialog.data.colourTwo.blue, i),
				alpha = getMidValue(inputDialog.data.colourOne.alpha, inputDialog.data.colourTwo.alpha, i)
			}
		end

		results [inputDialog.data.midpoints + 2] = inputDialog.data.colourTwo
		
		local outputDialog = Dialog("Midpoint Colours")

		outputDialog:newrow {
			always = true
		}

		outputDialog:label {
			text = "Left click to set as foreground colour."
		}
		outputDialog:label {
			text = "Right click to add colour to palette."
		}

		outputDialog:shades {
			mode = "pick",
			colors = results,
			onclick = function (event)
				if event.button == MouseButton.LEFT then 
					-- set foreground colour
					app.fgColor = event.color
				elseif event.button == MouseButton.RIGHT then
					if app.activeSprite == nil then -- check a sprite is open
						app.alert ("Open a sprite first.")
					else  -- add colour to palette
						app.command.AddColor {
							color = event.color
						}
					end
				end
			end
		}

		outputDialog:show()

	end
}

inputDialog:show()
