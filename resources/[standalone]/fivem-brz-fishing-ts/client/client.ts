import { Fish } from "@common/types";
import { requestStartFishing, startFishing } from "./fishing";
import { getState, setState } from "./state";
import { t } from "@config/locales";
import { getUseItemHookName, getUseItemHookHandler } from "@core/inventory";

RegisterCommand(
  t("fish_command"),
  (source: number, args: string[]) => {
    changeFishingState();
  },
  false
);

TriggerEvent(
  "chat:addSuggestion",
  "/" + t("fish_command"),
  t("fish_command_description"),
  []
);

CreateThread(() => {
  const blip = AddBlipForCoord(2813.74, -1511.85, 24.5);

  SetBlipSprite(blip, 68); // Hook icon
  SetBlipDisplay(blip, 4);
  SetBlipScale(blip, 0.9);
  SetBlipColour(blip, 38);
  SetBlipAsShortRange(blip, true);
  BeginTextCommandSetBlipName("STRING");
  AddTextComponentString(t("fish_blip_name") || "Fishing Pier");
  EndTextCommandSetBlipName(blip);
});

onNet("brz-fishing:startFishing", (fishId: keyof Fish) =>
  startFishing(GetPlayerServerId(PlayerId()), fishId)
);

onNet(getUseItemHookName(), (...params: any) => {
  const { itemName, itemType } = getUseItemHookHandler()(params);

  if (itemType === "use" && itemName === "fishingrod1") {
    changeFishingState();
  }
});

const changeFishingState = () => {
  if (getState() === "not-fishing") {
    requestStartFishing();
  } else {
    setState("not-fishing");
  }
};

emit("ox_inventory:loadItems");
