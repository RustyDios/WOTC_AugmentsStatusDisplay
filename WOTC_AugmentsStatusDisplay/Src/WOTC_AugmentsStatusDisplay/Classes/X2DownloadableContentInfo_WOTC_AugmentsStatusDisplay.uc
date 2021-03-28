//*******************************************************************************************
//  FILE:   XComDownloadableContentInfo_WOTC_AugmentsStatusDisplay.uc                                    
//  
//	File created by RustyDios	07/10/20    05:00
//	LAST UPDATED				10/10/20    13:30
//
//*******************************************************************************************

class X2DownloadableContentInfo_WOTC_AugmentsStatusDisplay extends X2DownloadableContentInfo;

var config bool bSwapImages, bShowRustyAugmentsSwap;
var config string strHead_ZR, strHead_CV, strHead_MG, strHead_BM, strHead_MG_Alt, strHead_BM_Alt;
var config string strBody_ZR, strBody_CV, strBody_MG, strBody_BM;
var config string strArms_ZR, strArms_CV, strArms_MG, strArms_BM, strArms_MG_Alt;
var config string strLegs_ZR, strLegs_CV, strLegs_MG, strLegs_BM, strLegs_MG_Alt, strLegs_BM_Alt;

static event OnLoadedSavedGame(){}

static event InstallNewCampaign(XComGameState StartState){}

static event OnPostTemplatesCreated()
{
	local X2ItemTemplateManager AllItems;			//holder for all items

    if(default.bSwapImages)
    {
        AllItems = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

        //heads/eyes
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_MkZero'),                      default.strHead_ZR);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_Base_CV'),                     default.strHead_CV);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_NeuralGunlink_MG'),            default.strHead_MG);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_NeuralTacticalProcessor_BM'),  default.strHead_BM);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_WeakpointAnalyzer_MG'),        default.strHead_MG_Alt);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationHead_WeakpointAnalyzer_BM'),        default.strHead_BM_Alt);

        //torsos
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationTorso_MkZero'),         default.strBody_ZR);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationTorso_Base_CV'),        default.strBody_CV);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationTorso_NanoCoating_MG'), default.strBody_MG);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationTorso_NanoCoating_BM'), default.strBody_BM);

        //arms
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_MkZero'),          default.strArms_ZR);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_Base_CV'),         default.strArms_CV);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_Claws_MG'),        default.strArms_MG_Alt);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_Claws_Left_MG'),   default.strArms_MG_Alt);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_Grapple_MG'),      default.strArms_MG);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationArms_Launcher_BM'),     default.strArms_BM);

        //legs
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationLegs_MkZero'),          default.strLegs_ZR);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationLegs_Base_CV'),         default.strLegs_CV);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationLegs_JumpModule_MG'),   default.strLegs_MG_Alt);
        SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationLegs_JumpModule_BM'),   default.strLegs_BM_Alt);
		SwapImagesOfAugments(AllItems.FindItemTemplate('AugmentationLegs_SilentRunners_BM'),default.strLegs_BM);
    }
}

static function SwapImagesOfAugments(X2ItemTemplate Template, string ImagePath)
{
    local string OldImagePath;

    If(Template != none)
    {
        OldImagePath = Template.strImage;

        Template.strImage = "img:///"$ImagePath;

        `LOG("Item Image Updated :: " @Template.FriendlyName @" :: OLD Image Path :: " @OldImagePath @" :: Image Path :: " @Template.strImage,default.bShowRustyAugmentsSwap,'RustyImageSwapperExtension');
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// ADD THE ITEMS TO THE HQ INVENTORY BY CONSOLE COMMAND
//////////////////////////////////////////////////////////////////////////////////////////

exec function RustyFix_ToolBox_Augments()
{
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_MkZero", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_Base_CV", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_NeuralGunlink_MG", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_NeuralTacticalProcessor_BM", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_WeakpointAnalyzer_MG", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationHead_WeakpointAnalyzer_BM", 5);

	RustyFix_AugmentsToolBox_AddItem("AugmentationTorso_MkZero", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationTorso_Base_CV", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationTorso_NanoCoating_MG", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationTorso_NanoCoating_BM", 5);

	RustyFix_AugmentsToolBox_AddItem("AugmentationArms_MkZero", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationArms_Base_CV", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationArms_Claws_MG", 5);
	//RustyFix_AugmentsToolBox_AddItem("AugmentationArms_Claws_Left_MG", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationArms_Grapple_MG", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationArms_Launcher_BM", 5);

	RustyFix_AugmentsToolBox_AddItem("AugmentationLegs_MkZero", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationLegs_Base_CV", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationLegs_JumpModule_MG", 5);
    RustyFix_AugmentsToolBox_AddItem("AugmentationLegs_JumpModule_BM", 5);
	RustyFix_AugmentsToolBox_AddItem("AugmentationLegs_SilentRunners_BM", 5);
}

static function RustyFix_AugmentsToolBox_AddItem(string strItemTemplate, optional int Quantity = 1, optional bool bLoot = false)
{
	local X2ItemTemplateManager ItemManager;
	local X2ItemTemplate ItemTemplate;
	local XComGameState NewGameState;
	local XComGameState_Item ItemState;
	local XComGameState_HeadquartersXCom HQState;
	local XComGameStateHistory History;
	local bool bWasInfinite;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplate = ItemManager.FindItemTemplate(name(strItemTemplate));

	if (ItemTemplate == none)
	{
		`log("No item template named" @ strItemTemplate @ "was found.");
		return;
	}

	if (ItemTemplate.bInfiniteItem)
	{
		bWasInfinite = true;
		ItemTemplate.bInfiniteItem = false;
	}

	History = `XCOMHISTORY;
	HQState = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	`assert(HQState != none);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Item Cheat: Create Item");
	ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState.Quantity = Quantity;

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Item Cheat: Complete");
	HQState = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(HQState.Class, HQState.ObjectID));
	HQState.PutItemInInventory(NewGameState, ItemState, bLoot);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	`log("Added item" @ strItemTemplate @ "object id" @ ItemState.ObjectID);

	if (bWasInfinite)
	{
		ItemTemplate.bInfiniteItem = true;
	}
}
