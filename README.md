# GodotSteam for GDNative
An open-source and fully functional Steamworks SDK / API module and plug-in for the Godot Game Engine (version 3.x). For the Windows, Linux, and Mac platforms. 

Additional flavors include:
- [Godot 3.x](https://github.com/Gramps/GodotSteam/tree/master)
- [Godot 4.x](https://github.com/Gramps/GodotSteam/tree/godot4)
- [Godot 2.x](https://github.com/Gramps/GodotSteam/tree/godot2)
- [Server](https://github.com/Gramps/GodotSteam/tree/server)

Documentation
----------
[Documentation is available here](https://gramps.github.io/GodotSteam/) and [is mirrored on and exported from CoaguCo's site](https://coaguco.com/godotsteam).

Feel free to chat with us about GodotSteam on the [CoaguCo Discord server](https://discord.gg/SJRSq6K).

Current Build
----------
You can [download pre-compiled versions _(currently v3.4)_ of this repo here as a plug-in](https://github.com/Gramps/GodotSteam/releases).

**Version 3.4 Changes:**
- Added: setDLCContext, getProfileItemPropertyString, getProfileItemPropertyInt, hasEquippedProfileItem, getPublicIP, getPSNID, getStadiaID, getXboxPairwiseID functions
- Added: handle arguments to HTML Surface class functions
- Added: inventory handle arguments to Inventory class functions
- Added: networking identity references into new Networking class functions
- Added: equipped_profile_items_changed, equipped_profile_items callbacks
- Added: additional data types to signals
- Changed: many functions in Networking Sockets and Networking Types classes
- Changed: newtorking identity maps
- Changed: various argument names to fall in line with module version
- Changed: renamed some signals
- Fixed: serverInit, advertiseGame functions
- Fixed: getSessionID using wrong type in Remote Play class
- Fixed: various incorrect types in Screenshots class
- Fixed: wrong int type for inventory update handle
- Fixed: not casting app ID for addFavoriteGame
- Fixed: wrong int type for server ID in getLobbyGameServer
- Removed: requestAllProofOfPurchaseKeys, requestAppProofOfPurchaseKey functions and related callbacks
- Removed: leading dash from signal / callback function names

Known Issues
----------
- The GDNative version does not allow for default arguments in functions, thus some functions may have odd behaviors.  If you are using this version of GodotSteam you are required to pass any argument that has a default in the module version. Also, there are no enums in the GDNative version due to how it is structured.
- As of Steamworks SDK 1.53, you cannot compile with previous version of GodotSteam (3.11.1 or earlier) due to a code change in the SDK.
  - Using Steamworks SDK 1.53 or newer, you must use GodotSteam 3.12 or newer.
  - Using Steamworks SDK 1.53 or earlier, you must use GodotSteam 3.11.1 or earlier.

Quick How-To
----------
- Create a new folder and call it **GDNative** (or whatever you want).
- Download this repository and unpack it into the **GDNative** folder.
- Download the [Steamworks SDK](https://partner.steamgames.com); this requires a Steam developer account.
	- Unpack the Steamworks SDK then copy the **public** and **redistributable_bin** to the **/godotsteam/sdk** folder in the unpacked repo folder.
- Download the [Godot cpp](https://github.com/godotengine/godot-cpp), the 3.4 branch.
	- Unpack the **godot_cpp** into the **GDNative** folder.
	- **Alternatively**, you can just use these commands inside the **GDNative** folder to clone them:
	````
		git clone --recursive -b 3.4 https://github.com/godotengine/godot-cpp
	````
- CD into the **godot-cpp** folder and compile the bindings (make sure your slashes are OS appropriate):
````
	scons platform=<your platform> generate_bindings=yes target=release
````
- You should end up with a **GDNative** folder that looks something like this:
````
	godot-cpp/
	--- bin/*
	--- godot-headers/*
	--- include/*
	--- misc/*
	--- src/*
	--- test/*
	--- binding_generator.py
	--- CMakeLists.txt
	--- LICENSE
	--- Makefile
	--- README.md
	--- SConstruct
	godotsteam/
	--- sdk/
	--- --- public/steam/*
	--- --- redistributable_bin/*
	--- godotsteam.h
	--- godotsteam.cpp
	--- init.cpp
	SConstruct
	README.md
	LICENSE.txt
````
- **Windows users using VS**, follow these steps for Visual Studio (big thanks to **willnationsdev**):
	- **Note**: these instructions may be outdated and I have modified them without confirmation!
	- Create a new Visual Studio project.
	- Name it **GDNative** and make sure it DOES NOT create a directory.
		- Uncheck the box here.
	- Select the **GDNative** folder we were working in.
	- Choose Win32 Desktop Wizard template.
	- Select options for both a dynamic library (.dll) and an empty project.
	- Things should look like this:
	````
		GDNative -godot-cpp -godot_headers -lib -GDNative --.vs --GDNative.sln --GDNative.vcxproj --GDNative.vcsproj.filters -src
	````
	- Make sure you have a debug, x64 configuration for the solution.
		- The options are located in the toolbar at the top left.
	- Go to "Project > GDNative Properties" to open the project properties.
	- Ensure you are on the x64 Debug configurations at the top and make these changes:
		- VC++ Directories > Include Directories. Add 'GDNative\godot-cpp\include', 'GDNative\godot-cpp\include\core', and 'GDNative\godot-cpp\godot-headers' to the list.
		- VC++ Directories > Library Directories. Add 'GDNative\godotsteam'.
		- VC++ Directories > Source Directories. Add 'GDNative\godotsteam'.
		- C/C++ > Linker > System. Subsystem = "Console (/SUBSYSTEM:CONSOLE)"
		- C/C++ > Linker > Input. Add "godot-cpp.windows.64.lib" (without quotes) to the Additional Dependencies parameter.
	- Click on Apply and then Save.
	- Now build the solution.
	- **Alternatively,** you can also run the following in the VS Command Prompt:
	````
		scons platform=windows production=yes target=release
	````
- **Linux and Mac users**, follow these steps:
	- **Note:** Linux users must use platform=linux or you'll get errors
	- Simply CD into the root of the **GDNative** folder and run:
	````
		scons platform=<your platform> production=yes target=release
	````
- Copy the resulting file from your **/bin/win64 or /bin/linuxbsd or /bin/osx** folder and copy the matching Steam API file into an **/addons/godotsteam** folder inside your **game's project folder**. For example:
	- For Windows: /addons/godotsteam/win64/, you want **godotsteam.dll** and **steam_api64.dll**.
	- For Linux: /addons/godotsteam/x11/, you want **libgodotsteam.so** and **libsteam_api.so**.
		- You will want to rename linuxbsd to x11
	- For Mac: /addons/godotsteam/osx, you want **libgodotsteam.dylib** and **libsteam_api.dylib**.
- In a text editor, create a file called **godotsteam.gdnlib** (this may need to be renamed as such if using Windows).
	- Place the following inside this file and save it in the **addons/godotsteam/** folder in your project:
	````
	[general]
	singleton=false
	load_once=true
	symbol_prefix="godot_"
	reloadable=true

	[entry]
	(read below)

	[dependencies]
	(read below)
	````
	- If using Windows:
	````
		[entry]
		Windows.64="res://addons/godotsteam/win64/godotsteam.dll"

		[dependencies]
		Windows.64=[ "res://addons/godotsteam/win64/steam_api64.dll" ]
	````
	- If using Linux:
	````
		[entry]
		X11.64="res://addons/godotsteam/x11/libgodotsteam.so"

		[dependencies]
		X11.64=[ "res://addons/godotsteam/x11/libsteam_api.so" ]
	````
	- If using OSX:
	````
		[entry]
		OSX.64="res://addons/godotsteam/osx/libgodotsteam.dylib"

		[dependencies]
		OSX.64=[ "res://addons/godotsteam/osx/libsteam_api.dylib" ]
	````
	- To double-check this worked, in your Godot project, open the **.gdnlib** file in the **Inspector**. It will have the correct data in the GUI editor that pops up in the bottom panel.
- In a text editor, create a file called **godotsteam.gdns** (this may need to be renamed as such if using Windows).
	- Place the following inside this file and save it in the **addons/godotsteam/** folder in your project:
	````
	[gd_resource type="NativeScript" load_steps=2 format=2]

	[ext_resource path="res://addons/godotsteam/godotsteam.gdnlib" type="GDNativeLibrary" id=1]

	[resource]

	resource_name = "godotsteam"
	class_name = "Steam"
	library = ExtResource( 1 )
	script_class_name = "Steam"
	````
- Create a new scene in your game project.
	- Add a Node node with a GDScript as the script.
	- Add the following code:
	````
	extends Node

	onready var Steam = preload("res://addons/godotsteam/godotsteam.gdns").new()

	func _ready():
		Steam.steamInit()

	````
- Save the scene as **steam.tscn** and place it where ever you want.
- Go to "Project > Project Settings" then click on **Autoload**.
- Add your **steam.tscn** as a singleton, with the node name of **Steam**.
- Done!

Usage
----------
Now you should be able to call functions from **Steam** like you would normally with the **GodotSteam module**.  They will, however, have to be added to your **steam.gd** script like this:
````
	name = Steam.getPersonaName()
	country = Steam.getIPCountry()
	running = Steam.isSteamRunning()

	func setAchievement(achieve):
		Steam.setAchievement(achieve)
````
These can then be called in any other script (since **steam.tscn** is a singleton) like this:
````
	print(steam.name)
	print(steam.country)

	if steam.running:
		runFunction()

	steam.setAchievement(achieve)
````

The documentation for GodotSteam should apply to GodotSteam GDNative as they are built from the same code and have all the same functions; generally speaking.

Donate
-------------
Pull-requests are the best way to help the project out but you can also donate through [Patreon](https://patreon.com/coaguco) or [Paypal](https://www.paypal.me/sithlordkyle)!

License
-------------
MIT license
