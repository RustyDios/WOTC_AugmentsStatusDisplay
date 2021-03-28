//*******************************************************************************************
//  FILE:  Augmentations Add On                                 
//  
//	File created	07/10/20    05:00
//	LAST UPDATED    07/10/20    21:00
//
//  This listener uses a CHL event to set the status in the barracks correctly
//  uses CHL issue #322 ((also needs a config setting in xcomgame.ini xcomgame.chhelpers ?? ))
//
//*******************************************************************************************
class X2EventListener_StatusOfAugmentationRequired extends X2EventListener config (Game);

enum ESeveredBodyPart
{
	eHead,
	eTorso,
	eArms,
	eLegs
};

var localized string m_strHead;
var localized string m_strTorso;
var localized string m_strArms;
var localized string m_strLegs;

var localized string m_strAugmentation;

var config int eStatusELR_AugColor;

//setup the templates
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListenerTemplate_StatusOfAugmentationRequired());
	
	return Templates; 
}

//create the listener template
static function CHEventListenerTemplate CreateListenerTemplate_StatusOfAugmentationRequired()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'StatusOfAugmentationRequired');

	Template.RegisterInTactical = false;
	Template.RegisterInStrategy = true;

	Template.AddCHEvent('OverridePersonnelStatus', OnStatusOfAugmentationRequired, ELD_Immediate);

	return Template;
}

/*
//FOR REF/INFO ONLY called in UiUtilities_Strategy from UIPersonnel_ListItem
static function TriggerOverridePersonnelStatus(XComGameState_Unit Unit,	out string Status, out EUIState eState,	out string TimeLabel, out string TimeValueOverride,	out int TimeNum, out int HideTime, out int DoTimeConversion)
{
	local XComLWTuple OverrideTuple;

	OverrideTuple = new class'XComLWTuple';
	OverrideTuple.Id = 'OverridePersonnelStatus';
	OverrideTuple.Data.Add(7);
	OverrideTuple.Data[0].s = Status;
	OverrideTuple.Data[1].s = TimeLabel;
	OverrideTuple.Data[2].s = TimeValueOverride;
	OverrideTuple.Data[3].i = TimeNum;
	OverrideTuple.Data[4].i = int(eState);
	OverrideTuple.Data[5].b = HideTime != 0;
	OverrideTuple.Data[6].b = DoTimeConversion != 0;

	`XEVENTMGR.TriggerEvent('OverridePersonnelStatus', OverrideTuple, Unit);

}
*/

//create the listener return
static function EventListenerReturn OnStatusOfAugmentationRequired(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
    local XComLWTuple           Tuple;
    local XComGameState_Unit    UnitState;

   	local UnitValue SeveredBodyPart;

    Tuple = XComLWTuple(EventData);
    UnitState = XComGameState_Unit(EventSource);

    if (UnitState != none /*&& UnitState.IsGravelyInjured()*/ && UnitState.GetUnitValue('SeveredBodyPart', SeveredBodyPart) )
    {
        if( (int(SeveredBodyPart.fValue) == eHead && UnitState.GetItemInSlot(eInvSlot_AugmentationHead) == none)
         || (int(SeveredBodyPart.fValue) == eTorso && UnitState.GetItemInSlot(eInvSlot_AugmentationTorso) == none)
         || (int(SeveredBodyPart.fValue) == eArms && UnitState.GetItemInSlot(eInvSlot_AugmentationArms) == none)
         || (int(SeveredBodyPart.fValue) == eLegs && UnitState.GetItemInSlot(eInvSlot_AugmentationLegs) == none)
        )
        {
            Tuple.Data[0].s = GetBodyPartTitle(int(SeveredBodyPart.fValue)) @default.m_strAugmentation;   //"NEEDS AUGMENTATION"; //status string x
            Tuple.Data[1].s = "";                               //time string y
            Tuple.Data[2].s = "";                               //time value override z?
            Tuple.Data[3].i = 0;                                //time number, days/hrs
            Tuple.Data[4].i = default.eStatusELR_AugColor;		//eUIState_Faded;                //colour from EUI State - see UI Utilities_Colours
            Tuple.Data[5].b = true;                             //Indicates whether you should display the time value and label or not. false means don't hide it || display it. true means hide.
            Tuple.Data[6].b = false;                            //convert time to hours
        }
    }

	return ELR_NoInterrupt;
}

//helper func to help create the string
static function String GetBodyPartTitle(int eBodyPart)
{
	switch (eBodyPart)
	{
		case eHead:			return default.m_strHead;			break;
		case eTorso:		return default.m_strTorso;			break;
		case eArms:			return default.m_strArms;			break;
		case eLegs:			return default.m_strLegs;			break;
		default:			return "";							break;
	}
}
