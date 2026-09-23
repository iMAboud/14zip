// OptionsDialog.cpp

#include "StdAfx.h"

#include "../../../Windows/Control/Dialog.h"
#include "../../../Windows/Control/PropertyPage.h"

#include "DialogSize.h"

#include "EditPage.h"
#include "EditPageRes.h"
#include "FoldersPage.h"
#include "FoldersPageRes.h"
#include "LangPage.h"
#include "LangPageRes.h"
#include "MenuPage.h"
#include "MenuPageRes.h"
#include "SettingsPage.h"
#include "SettingsPageRes.h"
#include "SystemPage.h"
#include "SystemPageRes.h"

#include "App.h"
#include "LangUtils.h"
#include "MyLoadMenu.h"

#include "resource.h"

using namespace NWindows;

void OptionsDialog(HWND hwndOwner, HINSTANCE hInstance);
void OptionsDialog(HWND hwndOwner, HINSTANCE /* hInstance */)
{
  CMenuPage menuPage;
  CSettingsPage settingsPage;

  CObjectVector<NControl::CPageInfo> pages;
  BIG_DIALOG_SIZE(200, 200);

  const UINT pageIDs[] = {
      SIZED_DIALOG(IDD_MENU),
      SIZED_DIALOG(IDD_SETTINGS) };

  NControl::CPropertyPage *pagePointers[] = { &menuPage, &settingsPage };
  
  for (unsigned i = 0; i < Z7_ARRAY_SIZE(pageIDs); i++)
  {
    NControl::CPageInfo &page = pages.AddNew();
    page.ID = pageIDs[i];
    #ifdef Z7_LANG
    LangString_OnlyFromLangFile(page.ID, page.Title);
    #endif
    page.Page = pagePointers[i];
  }

  const INT_PTR res = NControl::MyPropertySheet(pages, hwndOwner, LangString(IDS_OPTIONS));
  
  if (res != -1 && res != 0)
  {
    g_App.SetListSettings();
    g_App.RefreshAllPanels();
  }
}
