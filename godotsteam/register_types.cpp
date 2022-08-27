#include "register_types.h"
#include <core/config/engine.h>

#include "godotsteam.h"
#include "steam_network_peer.h"
#include "steam_id.h"

static Steam* SteamPtr = NULL;

void initialize_godotsteam_module(ModuleInitializationLevel p_level){
	if (p_level == MODULE_INITIALIZATION_LEVEL_SCENE) {
		ClassDB::register_class<Steam>();
		ClassDB::register_class<SteamId>();
		ClassDB::register_class<SteamNetworkPeer>();
		SteamPtr = memnew(Steam);
		Engine::get_singleton()->add_singleton(Engine::Singleton("Steam",Steam::get_singleton()));
	}
}

void uninitialize_godotsteam_module(ModuleInitializationLevel p_level){
	if (p_level == MODULE_INITIALIZATION_LEVEL_SCENE) {
		memdelete(SteamPtr);
	}
}
