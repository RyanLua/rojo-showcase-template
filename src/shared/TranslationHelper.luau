--!strict

--[[
	Safely loads translators based on the player's default locale and
	includes functions for providing specific translations and switching languages.

	https://create.roblox.com/docs/production/localization/localizing-with-scripting#creating-a-translationhelper-module
]]

local TranslationHelper = {}

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

-- Local variables
local player = Players.LocalPlayer
local sourceLanguageCode: string = "en"

-- Get translators
local playerTranslator: Translator, fallbackTranslator: Translator
local foundPlayerTranslator: boolean = pcall(function(): ()
	playerTranslator = LocalizationService:GetTranslatorForPlayerAsync(player)
end)
local foundFallbackTranslator: boolean = pcall(function(): ()
	fallbackTranslator = LocalizationService:GetTranslatorForLocaleAsync(sourceLanguageCode)
end)

-- Create a method TranslationHelper.setLanguage to load a new translation for the TranslationHelper
function TranslationHelper.setLanguage(newLanguageCode: string): boolean
	if sourceLanguageCode ~= newLanguageCode then
		local success: boolean, newPlayerTranslator: Translator = pcall(function(): Translator
			return LocalizationService:GetTranslatorForLocaleAsync(newLanguageCode)
		end)

		--Only override current playerTranslator if the new one is valid (fallbackTranslator remains as experience's source language)
		if success and newPlayerTranslator then
			playerTranslator = newPlayerTranslator
			return true
		end
	end
	return false
end

-- Create a Translate function that uses a fallback translator if the first fails to load or return successfully. You can also set the referenced object to default to the generic game object

function TranslationHelper.translate(text: string, object: Instance?): string
	local context: Instance = object or game

	if foundPlayerTranslator then
		return playerTranslator:Translate(context, text)
	end
	if foundFallbackTranslator then
		return fallbackTranslator:Translate(context, text)
	end
	return text
end

-- Create a FormatByKey() function that uses a fallback translator if the first fails to load or return successfully

function TranslationHelper.translateByKey(key: string, arguments: any): string
	local translation: string = ""
	local foundTranslation: boolean = false

	-- First tries to translate for the player's language (if a translator was found)
	if foundPlayerTranslator then
		foundTranslation = pcall(function(): ()
			translation = playerTranslator:FormatByKey(key, arguments)
		end)
	end
	if foundFallbackTranslator and not foundTranslation then
		foundTranslation = pcall(function(): ()
			translation = fallbackTranslator:FormatByKey(key, arguments)
		end)
	end
	if foundTranslation then
		return translation
	else
		return key
	end
end

-- Create a OnLocaleIdChanged function that updates the player's translator when the locale changes

function TranslationHelper.onLocaleIdChanged(): RBXScriptSignal | false
	if foundPlayerTranslator then
		return playerTranslator:GetPropertyChangedSignal("LocaleId")
	end
	if foundFallbackTranslator then
		return fallbackTranslator:GetPropertyChangedSignal("LocaleId")
	end
	return false
end

return TranslationHelper
