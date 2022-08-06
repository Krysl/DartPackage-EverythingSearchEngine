// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import '../assets.dart';
import 'everything.g.dart';
import 'string.dart';

extension on bool {
  int get toInt => this ? 1 : 0;
}

class Everything {
  final EverythingBase _;

  /// The symbols are looked up in [dynamicLibrary].
  Everything(ffi.DynamicLibrary dynamicLibrary) : _ = EverythingBase(dynamicLibrary);

  factory Everything.fromLibraryPath(String libraryPath) {
    assert(File(libraryPath).existsSync(), 'file $libraryPath not exist in ${Directory.current}');
    return Everything(ffi.DynamicLibrary.open(libraryPath));
  }
  factory Everything.fromDefaultLibraryPath({
    /// use only in development of this package
    bool isLocalTest = false,

    /// use in test for common user
    bool isTest = false,
  }) =>
      Everything.fromLibraryPath(
        path.normalize(
          path.join(
            isLocalTest ? '' : (isTest ? 'build/flutter_assets' : 'data/flutter_assets'),
            Assets.everything_search_engine$Everything64_dll,
          ),
        ),
      );

  /// The symbols are looked up with [lookup].
  Everything.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup)
      : _ = EverythingBase.fromLookup(lookup);

  /* API */
  /* version */
  /// The **[majorVersion]** function retrieves the major version number of Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetMajorVersion(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the major version number.  
  /// The function returns 0 if major version information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything uses the following version format:  
  /// major.minor.revision.build  
  /// The build part is incremental and unique for all Everything versions.  
  /// ## Example  
  /// ```  
  /// DWORD majorVersion;  
  /// DWORD minorVersion;  
  /// DWORD revision;  
  ///   
  /// // get version information  
  /// majorVersion = Everything_GetMajorVersion();  
  /// minorVersion = Everything_GetMinorVersion();  
  /// revision = Everything_GetRevision();  
  ///   
  /// if ((majorVersion > 1) || ((majorVersion == 1) && (minorVersion > 3)) || ((majorVersion == 1) && (minorVersion == 3) && (revision >= 4)))  
  /// {  
  /// 	// do something with version 1.3.4 or later  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [minorVersion]  
  /// - [revision]  
  /// - [buildNumber]  
  /// - [targetMachine]
  int get majorVersion => _.GetMajorVersion();
  /// The **[minorVersion]** function retrieves the minor version number of Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetMinorVersion(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the minor version number.  
  /// The function returns 0 if minor version information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything uses the following version format:  
  /// major.minor.revision.build  
  /// The build part is incremental and unique for all Everything versions.  
  /// ## Example  
  /// ```  
  /// DWORD majorVersion;  
  /// DWORD minorVersion;  
  /// DWORD revision;  
  ///   
  /// // get version information  
  /// majorVersion = Everything_GetMajorVersion();  
  /// minorVersion = Everything_GetMinorVersion();  
  /// revision = Everything_GetRevision();  
  ///   
  /// if ((majorVersion > 1) || ((majorVersion == 1) && (minorVersion > 3)) || ((majorVersion == 1) && (minorVersion == 3) && (revision >= 4)))  
  /// {  
  /// 	// do something with version 1.3.4 or later  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [majorVersion]  
  /// - [revision]  
  /// - [buildNumber]  
  /// - [targetMachine]
  int get minorVersion => _.GetMinorVersion();
  /// The **[revision]** function retrieves the revision number of Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetRevision(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the revision number.  
  /// The function returns 0 if revision information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything uses the following version format:  
  /// major.minor.revision.build  
  /// The build part is incremental and unique for all Everything versions.  
  /// ## Example  
  /// ```  
  /// DWORD majorVersion;  
  /// DWORD minorVersion;  
  /// DWORD revision;  
  ///   
  /// // get version information  
  /// majorVersion = Everything_GetMajorVersion();  
  /// minorVersion = Everything_GetMinorVersion();  
  /// revision = Everything_GetRevision();  
  ///   
  /// if ((majorVersion > 1) || ((majorVersion == 1) && (minorVersion > 3)) || ((majorVersion == 1) && (minorVersion == 3) && (revision >= 4)))  
  /// {  
  /// 	// do something with version 1.3.4 or later  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [majorVersion]  
  /// - [minorVersion]  
  /// - [buildNumber]  
  /// - [targetMachine]
  int get revision => _.GetRevision();
  /// The **[buildNumber]** function retrieves the build number of Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetBuildNumber(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the build number.  
  /// The function returns 0 if build information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything uses the following version format:  
  /// major.minor.revision.build  
  /// The build part is incremental and unique for all Everything versions.  
  /// ## Example  
  /// ```  
  /// DWORD buildNumber;  
  ///   
  /// // get the build number   
  /// buildNumber = Everything_GetBuildNumber();  
  ///   
  /// if (buildNumber >= 686)  
  /// {  
  /// 	// do something with build 686 or later.  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [majorVersion]  
  /// - [minorVersion]  
  /// - [revision]  
  /// - [targetMachine]
  int get buildNumber => _.GetBuildNumber();
  /// The **[targetMachine]** function retrieves the target machine of Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetTargetMachine(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns one of the following:  
  ///   
  /// The function returns 0 if target machine information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything uses the following version format:  
  /// major.minor.revision.build  
  /// The build part is incremental and unique for all Everything versions.  
  /// ## Example  
  /// ```  
  /// DWORD targetMachine;  
  ///   
  /// // Get the attributes of the first visible result.  
  /// targetMachine = Everything_GetTargetMachine();  
  ///   
  /// if (targetMachine == EVERYTHING_TARGET_MACHINE_X64)  
  /// {  
  /// 	// do something with x64 build.  
  /// }  
  /// else  
  /// if (targetMachine == EVERYTHING_TARGET_MACHINE_X86)  
  /// {  
  /// 	// do something with x86 build.  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [majorVersion]  
  /// - [minorVersion]  
  /// - [revision]  
  /// - [buildNumber]
  int get targetMachine => _.GetTargetMachine();
  /* search */
  /// write search state
  /// The **[search]** function sets the search string for the IPC Query.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetSearch(  
  ///     LPCTSTR lpString  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *lpString* \[in\]  
  ///   Pointer to a null-terminated string to be used as the new search text.   
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// Optionally call this function prior to a call to [query]  
  /// [query] executes the IPC Query using this search string.  
  /// ## Example  
  /// ```  
  /// // Set the search string to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // Execute the IPC query.  
  /// Everything_Query(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [search]  
  /// - [query]
  set search(String lpString) => _.SetSearchW(lpString.toLPCWSTR());
  /// The **[search]** function retrieves the search text to use for the next call to [query].  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetSearch(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is a pointer to the null terminated search string.  
  /// The unicode and ansi version must match the call to Everything_SetSearch.  
  /// The function will fail if you call Everything_GetSearchA after a call to Everything_SetSearchW  
  /// The function will fail if you call Everything_GetSearchW after a call to Everything_SetSearchA  
  /// If the function fails, the return value is NULL.  
  /// To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// Get the internal state of the search text.  
  /// The default string is an empty string.  
  /// ## Example  
  /// ```  
  /// LPCTSTR lpSearchString = Everything_GetSearch();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [search]  
  /// - [query]
  String get search => _.GetSearchW().toDartString();

  /// The **[lastError]** function retrieves the last-error code value.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetLastError(void);  
  /// ```  
  /// ## Parameters  
  /// This function has no parameters.  
  /// ## Return Value  
  ///   
  /// ## Example  
  /// ```  
  /// // execute the query  
  /// if (!Everything_Query(true))  
  /// {  
  /// 	DWORD dwLastError = Everything_GetLastError();  
  /// 	if (dwLastError == EVERYTHING_ERROR_IPC)  
  /// 	{  
  /// 		// IPC not available.  
  /// 	}  
  /// }  
  /// ```
  int get lastError => _.GetLastError();

  /* search mode */
  /// The **[matchCase]** function enables or disables full path matching for the next call to [query].  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetMatchCase(  
  ///     BOOL bEnable  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *bEnable*  
  ///   Specifies whether the search is case sensitive or insensitive.  
  /// If this parameter is TRUE, the search is case sensitive.   
  /// If the parameter is FALSE, the search is case insensitive.   
  ///   
  ///   
  /// ## Remarks  
  /// Match case is disabled by default.  
  /// ## Example  
  /// ```  
  /// Everything_SetMatchCase(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchCase]  
  /// - [query]
  set matchCase(bool bEnable) => _.SetMatchCase(bEnable.toInt);
  /// The **[matchCase]** function returns the match case state.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_GetMatchCase(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the match case state.  
  /// The function returns TRUE if match case is enabled.  
  /// The function returns FALSE if match case is disabled.  
  /// ## Remarks  
  /// Get the internal state of the match case switch.  
  /// The default state is FALSE, or disabled.  
  /// ## Example  
  /// ```  
  /// BOOL bEnabled = Everything_GetMatchCase();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchCase]  
  /// - [query]
  bool get matchCase => _.GetMatchCase() == 1;

  /// The **[matchWholeWord]** function enables or disables matching whole words for the next call to [query].  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetMatchWholeWord(  
  ///     BOOL bEnable  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *bEnable*  
  ///   Specifies whether the search matches whole words, or can match anywhere.  
  /// If this parameter is TRUE, the search matches whole words only.   
  /// If the parameter is FALSE, the search can occur anywhere.   
  ///   
  ///   
  /// ## Remarks  
  /// Match whole word is disabled by default.  
  /// ## Example  
  /// ```  
  /// Everything_SetMatchWholeWord(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchWholeWord]  
  /// - [query]
  set matchWholeWord(bool bEnable) => _.SetMatchWholeWord(bEnable.toInt);
  /// The **[matchWholeWord]** function returns the match whole word state.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_GetMatchWholeWord(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the match whole word state.  
  /// The function returns TRUE if match whole word is enabled.  
  /// The function returns FALSE if match whole word is disabled.  
  /// ## Remarks  
  /// The default state is FALSE, or disabled.  
  /// ## Example  
  /// ```  
  /// BOOL bEnabled = Everything_GetMatchWholeWord();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchWholeWord]  
  /// - [query]
  bool get matchWholeWord => _.GetMatchWholeWord() == 1;

  /// The **[matchPath]** function enables or disables full path matching for the next call to [query].  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetMatchPath(  
  ///     BOOL bEnable  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *bEnable*  
  ///   \[in\] Specifies whether to enable or disable full path matching.  
  /// If this parameter is TRUE, full path matching is enabled.   
  /// If the parameter is FALSE, full path matching is disabled.   
  ///   
  ///   
  /// ## Remarks  
  /// If match full path is being enabled, the next call to [query] will search the full path and file name of each file and folder.  
  /// If match full path is being disabled, the next call to [query] will search the file name only of each file and folder.  
  /// Match path is disabled by default.  
  /// Enabling match path will add a significant performance hit.  
  /// ## Example  
  /// ```  
  /// Everything_SetMatchPath(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchPath]  
  /// - [query]
  set matchPath(bool bEnable) => _.SetMatchPath(bEnable.toInt);
  /// The **[matchPath]** function returns the state of the match full path switch.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_GetMatchPath(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the state of the match full path switch.  
  /// The function returns TRUE if match full path is enabled.  
  /// The function returns FALSE if match full path is disabled.  
  /// ## Remarks  
  /// Get the internal state of the match full path switch.  
  /// The default state is FALSE, or disabled.  
  /// ## Example  
  /// ```  
  /// BOOL bEnabled = Everything_GetMatchPath();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [matchPath]  
  /// - [query]
  bool get matchPath => _.GetMatchPath() == 1;

  /// The Everything_SetRegex function enables or disables Regular Expression searching.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetRegex(  
  ///     BOOL bEnabled  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *bEnabled*  
  ///   Set to non-zero to enable regex, set to zero to disable regex.  
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// Regex is disabled by default.  
  /// ## Example  
  /// ```  
  /// Everything_SetRegex(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [regex]  
  /// - [query]
  set regex(bool bEnable) => _.SetRegex(bEnable.toInt);
  /// The Everything_GetRegex function returns the regex state.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_GetRegex(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the regex state.  
  /// The function returns TRUE if regex is enabled.  
  /// The function returns FALSE if regex is disabled.  
  /// ## Remarks  
  /// The default state is FALSE.  
  /// ## Example  
  /// ```  
  /// BOOL bRegex = Everything_GetRegex();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [regex]  
  /// - [query]
  bool get regex => _.GetRegex() == 1;

  /*  */
  /// The **[max]** function set the maximum number of results to return from [query].  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetMax(  
  ///     DWORD dwMaxResults  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwMaxResults*  
  ///   Specifies the maximum number of results to return.  
  /// Setting this to 0xffffffff will return all results.  
  ///   
  ///   
  /// ## Remarks  
  /// The default maximum number of results is 0xffffffff (all results).  
  /// If you are displaying the results in a window, set the maximum number of results to the number of visible items in the window.  
  /// ## Example  
  /// ```  
  /// Everything_SetMax(window_height / item_height);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [max]  
  /// - [query]
  set max(int max) => _.SetMax(max);
  /// The **[max]** function returns the maximum number of results state.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_GetMax(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the maximum number of results state.  
  /// The function returns 0xFFFFFFFF if all results should be returned.  
  /// ## Remarks  
  /// The default state is 0xFFFFFFFF, or all results.  
  /// ## Example  
  /// ```  
  /// DWORD dwMaxResults = Everything_GetMax();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [max]  
  /// - [query]
  int get max => _.GetMax();

  /// The **[offset]** function set the first result offset to return from a call to [query].  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetOffset(  
  ///     DWORD dwOffset  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - dwOffset  
  ///   Specifies the first result from the available results.  
  /// Set this to 0 to return the first available result.  
  ///   
  ///   
  /// ## Remarks  
  /// The default offset is 0 (the first available result).  
  /// If you are displaying the results in a window with a custom scroll bar, set the offset to the vertical scroll bar position.  
  /// Using a search window can reduce the amount of data sent over the IPC and significantly increase search performance.  
  /// ## Example  
  /// ```  
  /// Everything_SetOffset(scrollbar_vpos);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [offset]  
  /// - [query]
  set offset(int offset) => _.SetOffset(offset);
  /// The **[offset]** function returns the first item offset of the available results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetOffset(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the first item offset.  
  /// ## Remarks  
  /// The default offset is 0.  
  /// ## Example  
  /// ```  
  /// DWORD dwOffset = Everything_GetOffset();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [offset]  
  /// - [query]
  int get offset => _.GetOffset();

  /// The **[replyWindow]** function sets the window that will receive the the IPC Query results.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetReplyWindow(  
  ///     HWND hWnd  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *hWnd*  
  ///   The handle to the window that will receive the IPC Query reply.  
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// This function must be called before calling [query] with bWait set to FALSE.  
  /// Check for results with the specified window using [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply).  
  /// Call [replyID] with a unique identifier to specify multiple searches.  
  /// ## Example  
  /// ```  
  /// // reply to this window.  
  /// Everything_SetReplyWindow(hwnd);  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [replyID]  
  /// - [replyWindow]  
  /// - [replyID]  
  /// - [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply)
  set replyWindow(HWND hWnd) => _.SetReplyWindow(hWnd);
  /// The **[replyWindow]** function returns the current reply window for the IPC query reply.  
  /// ## Syntax  
  /// ```  
  /// HWND Everything_GetReplyWindow(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the current reply window.  
  /// ## Remarks  
  /// The default reply window is 0, or no reply window.  
  /// ## Example  
  /// ```  
  /// HWND hWnd = Everything_GetReplyWindow();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [replyWindow]  
  /// - [replyID]  
  /// - [replyID]  
  /// - [query]  
  /// - [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply)
  HWND get replyWindow => _.GetReplyWindow();

  /// The **[replyID]** function sets the unique number to identify the next query.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetReplyID(  
  ///     DWORD nId  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *nID*  
  ///   The unique number to identify the next query.  
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// The default identifier is 0.  
  /// Set a unique identifier for the IPC Query.  
  /// If you want to post multiple search queries with the same window handle, you must call the Everything_SetReplyID function to assign each query a unique identifier.  
  /// The nID value is the dwData member in the COPYDATASTRUCT used in the WM_COPYDATA reply message.  
  /// This function is not required if you call Everything_Query with bWait set to true.  
  /// ## Example  
  /// ```  
  /// // reply to this window.  
  /// Everything_SetReplyWindow(hwnd);  
  ///   
  /// // set a unique identifier for this query.  
  /// Everything_SetReplyID(1);  
  ///   
  /// // execute the query  
  /// Everything_Query(FALSE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [replyWindow]  
  /// - [replyWindow]  
  /// - [replyID]  
  /// - [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply)
  set replyID(int dwId) => _.SetReplyID(dwId);
  /// The **[replyID]** function returns the current reply identifier for the IPC query reply.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetReplyID(void);  
  /// ```  
  /// ## Return Value  
  /// The return value is the current reply identifier.  
  /// ## Remarks  
  /// The default reply identifier is 0.  
  /// ## Example  
  /// ```  
  /// DWORD id = Everything_GetReplyID();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [replyWindow]  
  /// - [replyWindow]  
  /// - [replyID]  
  /// - [query]  
  /// - [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply)
  int get replyID => _.GetReplyID();

  /// The **[sort]** function sets how the results should be ordered.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetSort(  
  ///     DWORD dwSortType  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwSortType*  
  ///   The sort type, can be one of the following values:  
  /// ```  
  /// EVERYTHING_SORT_NAME_ASCENDING                      (1)  
  /// EVERYTHING_SORT_NAME_DESCENDING                     (2)  
  /// EVERYTHING_SORT_PATH_ASCENDING                      (3)  
  /// EVERYTHING_SORT_PATH_DESCENDING                     (4)  
  /// EVERYTHING_SORT_SIZE_ASCENDING                      (5)  
  /// EVERYTHING_SORT_SIZE_DESCENDING                     (6)  
  /// EVERYTHING_SORT_EXTENSION_ASCENDING                 (7)  
  /// EVERYTHING_SORT_EXTENSION_DESCENDING                (8)  
  /// EVERYTHING_SORT_TYPE_NAME_ASCENDING                 (9)  
  /// EVERYTHING_SORT_TYPE_NAME_DESCENDING                (10)  
  /// EVERYTHING_SORT_DATE_CREATED_ASCENDING              (11)  
  /// EVERYTHING_SORT_DATE_CREATED_DESCENDING             (12)  
  /// EVERYTHING_SORT_DATE_MODIFIED_ASCENDING             (13)  
  /// EVERYTHING_SORT_DATE_MODIFIED_DESCENDING            (14)  
  /// EVERYTHING_SORT_ATTRIBUTES_ASCENDING                (15)  
  /// EVERYTHING_SORT_ATTRIBUTES_DESCENDING               (16)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING        (17)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING       (18)  
  /// EVERYTHING_SORT_RUN_COUNT_ASCENDING                 (19)  
  /// EVERYTHING_SORT_RUN_COUNT_DESCENDING                (20)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING     (21)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING    (22)  
  /// EVERYTHING_SORT_DATE_ACCESSED_ASCENDING             (23)  
  /// EVERYTHING_SORT_DATE_ACCESSED_DESCENDING            (24)  
  /// EVERYTHING_SORT_DATE_RUN_ASCENDING                  (25)  
  /// EVERYTHING_SORT_DATE_RUN_DESCENDING                 (26)  
  /// ```  
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// The default sort is EVERYTHING_SORT_NAME_ASCENDING (1). This sort is free.  
  /// Using fast sorts is recommended, fast sorting is instant.  
  /// To enable fast sorts in Everything:  
  ///   
  /// - In **Everything**, from the **Tools** menu, click **Options**.  
  /// - Click the **Indexes** tab.  
  /// - Check **fast sort** for desired fast sort type.  
  /// - Click **OK**.  
  ///   
  /// It is possible the sort is not supported, in which case after you have received your results you should call *[resultListSort] to determine the sorting actually used.  
  /// This function must be called before [query].  
  /// ## Example  
  /// ```  
  /// // set the search.  
  /// Everything_SetSearch("123 ABC");  
  ///   
  /// // sort by size descending.  
  /// Everything_SetSort(EVERYTHING_SORT_SIZE_DESCENDING);  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]
  set sort(EverythingSort sortType) => _.SetSort(sortType.val);
  /// The **[sort]** function returns the desired sort order for the results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetSort(void);  
  /// ```  
  /// ## Return Value  
  /// Returns one of the following sort types:  
  /// ```  
  /// EVERYTHING_SORT_NAME_ASCENDING                      (1)  
  /// EVERYTHING_SORT_NAME_DESCENDING                     (2)  
  /// EVERYTHING_SORT_PATH_ASCENDING                      (3)  
  /// EVERYTHING_SORT_PATH_DESCENDING                     (4)  
  /// EVERYTHING_SORT_SIZE_ASCENDING                      (5)  
  /// EVERYTHING_SORT_SIZE_DESCENDING                     (6)  
  /// EVERYTHING_SORT_EXTENSION_ASCENDING                 (7)  
  /// EVERYTHING_SORT_EXTENSION_DESCENDING                (8)  
  /// EVERYTHING_SORT_TYPE_NAME_ASCENDING                 (9)  
  /// EVERYTHING_SORT_TYPE_NAME_DESCENDING                (10)  
  /// EVERYTHING_SORT_DATE_CREATED_ASCENDING              (11)  
  /// EVERYTHING_SORT_DATE_CREATED_DESCENDING             (12)  
  /// EVERYTHING_SORT_DATE_MODIFIED_ASCENDING             (13)  
  /// EVERYTHING_SORT_DATE_MODIFIED_DESCENDING            (14)  
  /// EVERYTHING_SORT_ATTRIBUTES_ASCENDING                (15)  
  /// EVERYTHING_SORT_ATTRIBUTES_DESCENDING               (16)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING        (17)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING       (18)  
  /// EVERYTHING_SORT_RUN_COUNT_ASCENDING                 (19)  
  /// EVERYTHING_SORT_RUN_COUNT_DESCENDING                (20)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING     (21)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING    (22)  
  /// EVERYTHING_SORT_DATE_ACCESSED_ASCENDING             (23)  
  /// EVERYTHING_SORT_DATE_ACCESSED_DESCENDING            (24)  
  /// EVERYTHING_SORT_DATE_RUN_ASCENDING                  (25)  
  /// EVERYTHING_SORT_DATE_RUN_DESCENDING                 (26)  
  /// ```  
  /// ## Remarks  
  /// The default sort is EVERYTHING_SORT_NAME_ASCENDING (1)  
  /// ## Example  
  /// ```  
  /// DWORD dwSort = Everything_GetSort();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [sort]  
  /// - [query]
  EverythingSort get sort => EverythingSort.fromVal(_.GetSort());

  /// The **[requestFlags]** function sets the desired result data.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SetRequestFlags(  
  ///     DWORD dwRequestFlags  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwRequestFlags*  
  ///   The request flags, can be zero or more of the following flags:  
  /// ```  
  /// EVERYTHING_REQUEST_FILE_NAME                            (0x00000001)  
  /// EVERYTHING_REQUEST_PATH                                 (0x00000002)  
  /// EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME              (0x00000004)  
  /// EVERYTHING_REQUEST_EXTENSION                            (0x00000008)  
  /// EVERYTHING_REQUEST_SIZE                                 (0x00000010)  
  /// EVERYTHING_REQUEST_DATE_CREATED                         (0x00000020)  
  /// EVERYTHING_REQUEST_DATE_MODIFIED                        (0x00000040)  
  /// EVERYTHING_REQUEST_DATE_ACCESSED                        (0x00000080)  
  /// EVERYTHING_REQUEST_ATTRIBUTES                           (0x00000100)  
  /// EVERYTHING_REQUEST_FILE_LIST_FILE_NAME                  (0x00000200)  
  /// EVERYTHING_REQUEST_RUN_COUNT                            (0x00000400)  
  /// EVERYTHING_REQUEST_DATE_RUN                             (0x00000800)  
  /// EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED                (0x00001000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME                (0x00002000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_PATH                     (0x00004000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME  (0x00008000)  
  /// ```  
  ///   
  ///   
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// Make sure you include EVERYTHING_REQUEST_FILE_NAME and EVERYTHING_REQUEST_PATH if you want the result file name information returned.  
  /// The default request flags are EVERYTHING_REQUEST_FILE_NAME | EVERYTHING_REQUEST_PATH (0x00000003).  
  /// When the default flags (EVERYTHING_REQUEST_FILE_NAME | EVERYTHING_REQUEST_PATH) are used the SDK will use the old version 1 query.  
  /// When any other flags are used the new version 2 query will be tried first, and then fall back to version 1 query.  
  /// It is possible the requested data is not available, in which case after you have received your results you should call [resultListRequestFlags] to determine the available result data.  
  /// This function must be called before [query].  
  /// ## Example  
  /// ```  
  /// LARGE_INTEGER size;  
  ///   
  /// // set the search.  
  /// Everything_SetSearch("123 ABC");  
  ///   
  /// // request filename, path, size and date modified result data.  
  /// Everything_SetRequestFlags(EVERYTHING_REQUEST_FILE_NAME | EVERYTHING_REQUEST_PATH | EVERYTHING_REQUEST_SIZE | EVERYTHING_REQUEST_DATE_MODIFIED);  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the size of the first result.  
  /// Everything_GetResultSize(0,&size);  
  ///   
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [resultListRequestFlags]
  set requestFlags(RequestFlags flags) => _.SetRequestFlags(flags.flags);
  /// The **[requestFlags]** function returns the desired result data flags.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetRequestFlags(void);  
  /// ```  
  /// ## Return Value  
  /// Returns zero or more of the following request flags:  
  /// ```  
  /// EVERYTHING_REQUEST_FILE_NAME                            (0x00000001)  
  /// EVERYTHING_REQUEST_PATH                                 (0x00000002)  
  /// EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME              (0x00000004)  
  /// EVERYTHING_REQUEST_EXTENSION                            (0x00000008)  
  /// EVERYTHING_REQUEST_SIZE                                 (0x00000010)  
  /// EVERYTHING_REQUEST_DATE_CREATED                         (0x00000020)  
  /// EVERYTHING_REQUEST_DATE_MODIFIED                        (0x00000040)  
  /// EVERYTHING_REQUEST_DATE_ACCESSED                        (0x00000080)  
  /// EVERYTHING_REQUEST_ATTRIBUTES                           (0x00000100)  
  /// EVERYTHING_REQUEST_FILE_LIST_FILE_NAME                  (0x00000200)  
  /// EVERYTHING_REQUEST_RUN_COUNT                            (0x00000400)  
  /// EVERYTHING_REQUEST_DATE_RUN                             (0x00000800)  
  /// EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED                (0x00001000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME                (0x00002000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_PATH                     (0x00004000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME  (0x00008000)  
  /// ```  
  /// ## Remarks  
  /// The default request flags are EVERYTHING_REQUEST_FILE_NAME | EVERYTHING_REQUEST_PATH (0x00000003)  
  /// ## Example  
  /// ```  
  /// DWORD dwRequestFlags = Everything_GetRequestFlags();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [requestFlags]  
  /// - [query]
  RequestFlags get requestFlags => RequestFlags.fromFlags(_.GetRequestFlags());

  /// execute query
  /// The **[query]** function executes an Everything IPC query with the current search state.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_Query(  
  ///     BOOL bWait  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *bWait*  
  ///   Should the function wait for the results or return immediately.  
  /// Set this to FALSE to post the IPC Query and return immediately.  
  /// Set this to TRUE to send the IPC Query and wait for the results.  
  ///   
  ///   
  /// ## Return Value  
  /// If the function succeeds, the return value is TRUE.  
  /// If the function fails, the return value is FALSE.  To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// If bWait is FALSE you must call [replyWindow] before calling Everything_Query. Use the [Everything_IsQueryReply](/support/everything/sdk/everything_isqueryreply) function to check for query replies.  
  /// Optionally call the following functions to set the search state before calling Everything_Query:  
  ///   
  /// - [search]  
  /// - [matchPath]  
  /// - [matchCase]  
  /// - [matchWholeWord]  
  /// - [regex]  
  /// - [max]  
  /// - [offset]  
  /// - [replyID]  
  /// - [requestFlags]  
  ///   
  /// You can mix ANSI / Unicode version of Everything_SetSearch and Everything_Query.  
  /// The ANSI / Unicode version of Everything_Query MUST match the ANSI / Unicode version of Everything_GetResultName and Everything_GetResultPath.  
  /// The search state is not modified from a call to Everything_Query.  
  /// The default state is as follows:  
  /// See [reset] for the default search state.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // enable case sensitive searching.  
  /// Everything_SetMatchCase(TRUE);  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [search]  
  /// - [matchPath]  
  /// - [matchCase]  
  /// - [matchWholeWord]  
  /// - [regex]  
  /// - [max]  
  /// - [offset]  
  /// - [sortResultsByPath]  
  /// - [lastError]  
  /// - [numFileResults]  
  /// - [numFolderResults]  
  /// - [numResults]  
  /// - [totFileResults]  
  /// - [totFolderResults]  
  /// - [totResults]  
  /// - [isVolumeResult]  
  /// - [isFolderResult]  
  /// - [isFileResult]  
  /// - [getResultFileName]  
  /// - [getResultPath]  
  /// - [Everything_GetResultFullPathName](/support/everything/sdk/everything_getresultfullpathname)  
  /// - [replyWindow]  
  /// - [replyID]  
  /// - [reset]
  int query(bool wait) => _.QueryW(wait.toInt);

  /// query reply
  int isQueryReply(
    int message,
    int wParam,
    int lParam,
    int dwId,
  ) =>
      _.IsQueryReply(message, wParam, lParam, dwId);

  /// The **[sortResultsByPath]** function sorts the current results by path, then file name.  
  /// SortResultsByPath is CPU Intensive. Sorting by path can take several seconds.  
  /// ## Syntax  
  /// ```  
  /// void Everything_SortResultsByPath(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// The default result list contains no results.  
  /// Call [query] to retrieve the result list prior to a call to Everything_SortResultsByPath.  
  /// For improved performance, use \[Everything/SDK/Everything_SetSort|Everything_SetSort\]\]  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch(\"abc 123\");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // sort the results by path  
  /// Everything_SortResultsByPath();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]
  void sortResultsByPath() => _.SortResultsByPath();
  /* get result num */
  /// The **[numFileResults]** function returns the number of visible file results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetNumFileResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the number of visible file results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetNumFileResults.  
  /// Use [totFileResults] to retrieve the total number of file results.  
  /// If the result offset state is 0, and the max result is 0xFFFFFFFF, Everything_GetNumFileResults will return the total number of file results and all file results will be visible.  
  /// Everything_GetNumFileResults is not supported when using [requestFlags]  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the number of visible file results.  
  /// DWORD dwNumFileResults = Everything_GetNumFileResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numResults]  
  /// - [numFolderResults]  
  /// - [totResults]  
  /// - [totFileResults]  
  /// - [totFolderResults]
  int get numFileResults => _.GetNumFileResults();
  /// The **[numFolderResults]** function returns the number of visible folder results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetNumFolderResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the number of visible folder results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetNumFolderResults.  
  /// Use [totFolderResults] to retrieve the total number of folder results.  
  /// If the result offset state is 0, and the max result is 0xFFFFFFFF, Everything_GetNumFolderResults will return the total number of folder results and all folder results will be visible.  
  /// Everything_GetNumFolderResults is not supported when using [requestFlags]  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the number of visible folder results  
  /// DWORD dwNumFolderResults = Everything_GetNumFolderResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numResults]  
  /// - [numFileResults]  
  /// - [totResults]  
  /// - [totFileResults]  
  /// - [totFolderResults]
  int get numFolderResults => _.GetNumFolderResults();
  /// The **[numResults]** function returns the number of visible file and folder results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetNumResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the number of visible file and folder results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetNumResults.  
  /// Use [totResults] to retrieve the total number of file and folder results.  
  /// If the result offset state is 0, and the max result is 0xFFFFFFFF, Everything_GetNumResults will return the total number of file and folder results and all file and folder results will be visible.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the number of visible file and folder results.  
  /// DWORD dwNumResults = Everything_GetNumResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numFileResults]  
  /// - [numFolderResults]  
  /// - [totResults]  
  /// - [totFileResults]  
  /// - [totFolderResults]
  int get numResults => _.GetNumResults();

  ///  returns the total number of file results.
  ///
  /// The **[totFileResults]** function returns the total number of file results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetTotFileResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the total number of file results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetTotFileResults.  
  /// Use [numFileResults] to retrieve the number of visible file results.  
  /// Use the result offset and max result values to limit the number of visible results.  
  /// Everything_GetTotFileResults is not supported when using [requestFlags]  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the total number of file results.  
  /// DWORD dwTotFileResults = Everything_GetTotFileResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numResults]  
  /// - [numFileResults]  
  /// - [numFolderResults]  
  /// - [totResults]  
  /// - [totFolderResults]
  int get totFileResults => _.GetTotFileResults();
  /// The **[totFolderResults]** function returns the total number of folder results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetTotFolderResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the total number of folder results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetTotFolderResults.  
  /// Use [numFolderResults] to retrieve the number of visible folder results.  
  /// Use the result offset and max result values to limit the number of visible results.  
  /// Everything_GetTotFolderResults is not supported when using [requestFlags]  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the total number of folder results.  
  /// DWORD dwTotFolderResults = Everything_GetTotFolderResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numResults]  
  /// - [numFileResults]  
  /// - [numFolderResults]  
  /// - [totResults]  
  /// - [totFileResults]
  int get totFolderResults => _.GetTotFolderResults();
  /// The **[totResults]** function returns the total number of file and folder results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetTotResults(void);  
  /// ```  
  /// ## Parameters  
  /// This functions has no parameters.  
  /// ## Return Value  
  /// Returns the total number of file and folder results.  
  /// If the function fails the return value is 0. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You must call [query] before calling Everything_GetTotResults.  
  /// Use [numResults] to retrieve the number of visible file and folder results.  
  /// Use the result offset and max result values to limit the number of visible results.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // get the total number of file and folder results.  
  /// DWORD dwTotResults = Everything_GetTotResults();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [numResults]  
  /// - [numFileResults]  
  /// - [numFolderResults]  
  /// - [totFileResults]  
  /// - [totFolderResults]
  int get totResults => _.GetTotResults();
  /* get result info */
  /// The **[resultListSort]** function returns the actual sort order for the results.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetResultListSort(void);  
  /// ```  
  /// ## Return Value  
  /// Returns one of the following sort types:  
  /// ```  
  /// EVERYTHING_SORT_NAME_ASCENDING                      (1)  
  /// EVERYTHING_SORT_NAME_DESCENDING                     (2)  
  /// EVERYTHING_SORT_PATH_ASCENDING                      (3)  
  /// EVERYTHING_SORT_PATH_DESCENDING                     (4)  
  /// EVERYTHING_SORT_SIZE_ASCENDING                      (5)  
  /// EVERYTHING_SORT_SIZE_DESCENDING                     (6)  
  /// EVERYTHING_SORT_EXTENSION_ASCENDING                 (7)  
  /// EVERYTHING_SORT_EXTENSION_DESCENDING                (8)  
  /// EVERYTHING_SORT_TYPE_NAME_ASCENDING                 (9)  
  /// EVERYTHING_SORT_TYPE_NAME_DESCENDING                (10)  
  /// EVERYTHING_SORT_DATE_CREATED_ASCENDING              (11)  
  /// EVERYTHING_SORT_DATE_CREATED_DESCENDING             (12)  
  /// EVERYTHING_SORT_DATE_MODIFIED_ASCENDING             (13)  
  /// EVERYTHING_SORT_DATE_MODIFIED_DESCENDING            (14)  
  /// EVERYTHING_SORT_ATTRIBUTES_ASCENDING                (15)  
  /// EVERYTHING_SORT_ATTRIBUTES_DESCENDING               (16)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING        (17)  
  /// EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING       (18)  
  /// EVERYTHING_SORT_RUN_COUNT_ASCENDING                 (19)  
  /// EVERYTHING_SORT_RUN_COUNT_DESCENDING                (20)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING     (21)  
  /// EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING    (22)  
  /// EVERYTHING_SORT_DATE_ACCESSED_ASCENDING             (23)  
  /// EVERYTHING_SORT_DATE_ACCESSED_DESCENDING            (24)  
  /// EVERYTHING_SORT_DATE_RUN_ASCENDING                  (25)  
  /// EVERYTHING_SORT_DATE_RUN_DESCENDING                 (26)  
  /// ```  
  /// ## Remarks  
  /// **[resultListSort]** must be called after calling [query].  
  /// If no desired sort order was specified the result list is sorted by EVERYTHING_SORT_NAME_ASCENDING.  
  /// The result list sort may differ to the desired sort specified in [sort].  
  /// ## Example  
  /// ```  
  /// DWORD dwSort = Everything_GetResultListSort();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [sort]  
  /// - [query]
  int get resultListSort => _.GetResultListSort();
  /// The **[resultListRequestFlags]** function returns the flags of available result data.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetResultListRequestFlags(void);  
  /// ```  
  /// ## Return Value  
  /// Returns zero or more of the following request flags:  
  /// ```  
  /// EVERYTHING_REQUEST_FILE_NAME                            (0x00000001)  
  /// EVERYTHING_REQUEST_PATH                                 (0x00000002)  
  /// EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME              (0x00000004)  
  /// EVERYTHING_REQUEST_EXTENSION                            (0x00000008)  
  /// EVERYTHING_REQUEST_SIZE                                 (0x00000010)  
  /// EVERYTHING_REQUEST_DATE_CREATED                         (0x00000020)  
  /// EVERYTHING_REQUEST_DATE_MODIFIED                        (0x00000040)  
  /// EVERYTHING_REQUEST_DATE_ACCESSED                        (0x00000080)  
  /// EVERYTHING_REQUEST_ATTRIBUTES                           (0x00000100)  
  /// EVERYTHING_REQUEST_FILE_LIST_FILE_NAME                  (0x00000200)  
  /// EVERYTHING_REQUEST_RUN_COUNT                            (0x00000400)  
  /// EVERYTHING_REQUEST_DATE_RUN                             (0x00000800)  
  /// EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED                (0x00001000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME                (0x00002000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_PATH                     (0x00004000)  
  /// EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME  (0x00008000)  
  /// ```  
  /// ## Remarks  
  /// The requested result data may differ to the desired result data specified in [requestFlags].  
  /// ## Example  
  /// ```  
  /// DWORD dwRequestFlags = Everything_GetResultListRequestFlags();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [requestFlags]  
  /// - [query]
  RequestFlags get resultListRequestFlags => RequestFlags.fromFlags(_.GetResultListRequestFlags());
  /* result item type */
  /// The **[isVolumeResult]** function determines if the visible result is the root folder of a volume.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsVolumeResult(  
  ///     DWORD index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns TRUE, if the visible result is a volume (For example: C:).  
  /// The function returns FALSE, if the visible result is a folder or file (For example: C:\ABC.123).  
  /// If the function fails the return value is FALSE. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // determine if the first visible result is a volume.  
  /// BOOL bIsVolumeResult = Everything_IsVolumeResult(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [isFolderResult]  
  /// - [isFileResult]
  bool isVolumeResult(int dwIndex) => _.IsVolumeResult(dwIndex) == 1;
  /// The **[isFolderResult]** function determines if the visible result is a folder.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsFolderResult(  
  ///     DWORD index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns TRUE, if the visible result is a folder or volume (For example: C: or c:\WINDOWS).  
  /// The function returns FALSE, if the visible result is a file (For example: C:\ABC.123).  
  /// If the function fails the return value is FALSE. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // determine if the first visible result is a folder.  
  /// BOOL bIsFolderResult = Everything_IsFolderResult(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [isVolumeResult]  
  /// - [isFileResult]
  int isFolderResult(int dwIndex) => _.IsFolderResult(dwIndex);
  /// The **[isFileResult]** function determines if the visible result is file.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsFileResult(  
  ///     DWORD index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns TRUE, if the visible result is a file (For example: C:\ABC.123).  
  /// The function returns FALSE, if the visible result is a folder or volume (For example: C: or c:\WINDOWS).  
  /// If the function fails the return value is FALSE. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // determine if the first visible result is a file.  
  /// BOOL bIsFileResult = Everything_IsFileResult(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [isVolumeResult]  
  /// - [isFolderResult]
  int isFileResult(int dwIndex) => _.IsFileResult(dwIndex);
  /* result item info */
  /// The **[getResultFileName]** function retrieves the file name part only of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultFileName(  
  ///     DWORD index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function is faster than Everything_GetResultFullPathName as no memory copying occurs.  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the file name part of the first visible result.  
  /// LPCTSTR cFileName = Everything_GetResultFileName(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [getResultPath]  
  /// - [Everything_GetResultFullPathName](/support/everything/sdk/everything_getresultfullpathname)
  String getResultFileName(int dwIndex) => _.GetResultFileNameW(dwIndex).toDartString();
  /// The **[getResultPath]** function retrieves the path part of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultPath(  
  ///     int index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function is faster than Everything_GetResultFullPathName as no memory copying occurs.  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the path part of the first visible result.  
  /// LPCTSTR lpPath = Everything_GetResultPath(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [getResultFileName]  
  /// - [Everything_GetResultFullPathName](/support/everything/sdk/everything_getresultfullpathname)
  String getResultPath(int dwIndex) => _.GetResultPathW(dwIndex).toDartString();
  String getResultFullPathName(int dwIndex, {int len = 260, ffi.Allocator allocator = malloc}) {
    LPWSTR buf = allocator<WCHAR>(len + 1);
    _.GetResultFullPathNameW(
      dwIndex,
      buf,
      len,
    );
    final result = buf.toDartString();
    malloc.free(buf);
    return result;
  }

  /// The **[getResultExtension]** function retrieves the extension part of a visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultExtension(  
  ///     DWORD dwIndex  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwIndex*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query], [reset] or [cleanUp].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the extension part of the first visible result.  
  /// LPCTSTR lpExtension = Everything_GetResultExtension(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  String getResultExtension(int dwIndex) => _.GetResultExtensionW(dwIndex).toDartString();
  int getResultSize(int dwIndex, {ffi.Allocator allocator = malloc}) {
    final lpSize = allocator<LARGE_INTEGER>();
    final ret = _.GetResultSize(dwIndex, lpSize); //todo:

    final size = lpSize.ref.QuadPart;
    allocator.free(lpSize);
    return size;
  }

  DateTime _getFileTime(int dwIndex, int Function(int, ffi.Pointer<FILETIME>) getFileTime,
      {ffi.Allocator allocator = malloc}) {
    final lpDateCreated = allocator<FILETIME>();
    final ret = getFileTime(
      dwIndex,
      lpDateCreated,
    );
    final time = lpDateCreated.ref;
    final datetime = DateTime(2020);
    allocator.free(lpDateCreated);
    return datetime;
  }

  DateTime getResultDateCreated(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateCreated);
  DateTime getResultDateModified(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateModified);
  DateTime getResultDateAccessed(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateAccessed);

  /// The **[getResultAttributes]** function retrieves the attributes of a visible result.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetResultAttributes(  
  ///     DWORD dwIndex,  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwIndex*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns zero or more of FILE_ATTRIBUTE_* flags.  
  /// The function returns INVALID_FILE_ATTRIBUTES if attribute information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// dwIndex must be a valid visible result index. To determine if a result index is visible use the [numResults] function.  
  /// ## Example  
  /// ```  
  /// DWORD attributes;  
  ///   
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the attributes of the first visible result.  
  /// attributes = Everything_GetResultAttributes(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  int getResultAttributes(int dwIndex) => _.GetResultAttributes(dwIndex);
  /// The **[getResultFileListFileName]** function retrieves the file list full path and filename of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultFileListFileName(  
  ///     DWORD dwIndex  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwIndex*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  /// If the result specified by dwIndex is not in a file list, then the filename returned is an empty string.  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// dwIndex must be a valid visible result index. To determine if a result is visible use the [numFileResults] function.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the file list filename of the first visible result.  
  /// LPCTSTR lpFileListFileName = Everything_GetResultFileListFileName(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  String getResultFileListFileName(int dwIndex) => _.GetResultFileListFileNameW(dwIndex).toDartString();
  /// The **[getResultRunCount]** function retrieves the number of times a visible result has been run from Everything.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetResultRunCount(  
  ///     DWORD dwIndex,  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *dwIndex*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the number of times the result has been run from Everything.  
  /// The function returns 0 if the run count information is unavailable. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// dwIndex must be a valid visible result index. To determine if a result index is visible use the [numResults] function.  
  /// ## Example  
  /// ```  
  /// DWORD runCount;  
  ///   
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the run count of the first visible result.  
  /// runCount = Everything_GetResultRunCount(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  int getResultRunCount(int dwIndex) => _.GetResultRunCount(dwIndex);

  DateTime getResultDateRun(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateRun);
  DateTime getResultDateRecentlyChanged(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateRecentlyChanged);
  /// The **[getResultHighlightedFileName]** function retrieves the highlighted file name part of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultHighlightedFileName(  
  ///     int index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// Text inside a * quote is highlighted, two consecutive *'s is a single literal *.  
  /// For example, in the highlighted text: abc *123* the 123 part is highlighted.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the highlighted file name of the first visible result.  
  /// LPCTSTR lpHighlightedFileName = Everything_GetResultHighlightedFileName(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  String getResultHighlightedFileName(int dwIndex) => _.GetResultHighlightedFileNameW(dwIndex).toDartString();
  /// The **[getResultHighlightedPath]** function retrieves the highlighted path part of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultHighlightedPath(  
  ///     int index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// Text inside a * quote is highlighted, two consecutive *'s is a single literal *.  
  /// For example, in the highlighted text: abc *123* the 123 part is highlighted.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the highlighted path of the first visible result.  
  /// LPCTSTR lpHighlightedPath = Everything_GetResultHighlightedPath(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  String getResultHighlightedPath(int dwIndex) => _.GetResultHighlightedPathW(dwIndex).toDartString();
  /// The **[getResultHighlightedFullPathAndFileName]** function retrieves the highlighted full path and file name of the visible result.  
  /// ## Syntax  
  /// ```  
  /// LPCTSTR Everything_GetResultHighlightedFullPathAndFileName(  
  ///     int index  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *index*  
  ///   Zero based index of the visible result.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns a pointer to a null terminated string of **TCHARs**.  
  /// If the function fails the return value is NULL. To get extended error information, call [lastError].  
  ///   
  /// ## Remarks  
  /// The ANSI / Unicode version of this function must match the ANSI / Unicode version of the call to [query].  
  /// The function returns a pointer to an internal structure that is only valid until the next call to [query] or [reset].  
  /// You can only call this function for a visible result. To determine if a result is visible use the [numFileResults] function.  
  /// Text inside a * quote is highlighted, two consecutive *'s is a single literal *.  
  /// For example, in the highlighted text: abc *123* the 123 part is highlighted.  
  /// ## Example  
  /// ```  
  /// // set the search text to abc AND 123  
  /// Everything_SetSearch("abc 123");  
  ///   
  /// // execute the query  
  /// Everything_Query(TRUE);  
  ///   
  /// // Get the highlighted full path and file name information of the first visible result.  
  /// LPCTSTR lpHighlightedFullPathAndFileName = Everything_GetResultHighlightedFullPathAndFileName(0);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]  
  /// - [reset]  
  /// - [requestFlags]
  String getResultHighlightedFullPathAndFileName(int dwIndex) =>
      _.GetResultHighlightedFullPathAndFileNameW(dwIndex).toDartString();
  /// The **[getRunCountFromFileName]** function gets the run count from a specified file in the Everything index by file name.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_GetRunCountFromFileName(  
  ///     LPCTSTR lpFileName  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *lpFileName* \[in\]  
  ///   Pointer to a null-terminated string that specifies a fully qualified file name in the Everything index.   
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the number of times the file has been run from Everything.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Example  
  /// ```  
  /// DWORD runCount;  
  ///   
  /// // get the run count of a file.  
  /// runCount = Everything_GetRunCountFromFileName(TEXT("C:\\folder\\file.doc"));  
  /// ```  
  /// ## See Also  
  ///   
  /// - [setRunCountFromFileName]  
  /// - [incRunCountFromFileName]
  int getRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final count = _.GetRunCountFromFileNameW(
      str,
    );
    malloc.free(str);
    return count;
  }

  /// The **[setRunCountFromFileName]** function sets the run count for a specified file in the Everything index by file name.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_SetRunCountFromFileName(  
  ///     LPCTSTR lpFileName,  
  ///     DWORD dwRunCount  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *lpFileName* \[in\]  
  ///   Pointer to a null-terminated string that specifies a fully qualified file name in the Everything index.   
  ///   
  /// - *dwRunCount* \[in\]  
  ///   The new run count.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if successful.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Set the run count to 0 to remove any run history information for the specified file.  
  /// The file does not have to exist. When the file is created it will have the correct run history.  
  /// Run history information is preserved between file deletion and creation.  
  /// Calling this function will update the date run to the current time for the specified file.  
  /// ## Example  
  /// ```  
  /// // set a file to show higher in the results by setting an exaggerated run count  
  /// Everything_SetRunCountFromFileName(TEXT("C:\\folder\\file.doc"),1000);  
  /// ```  
  /// ## See Also  
  ///   
  /// - [getRunCountFromFileName]  
  /// - [incRunCountFromFileName]
  int setRunCountFromFileName(String fileName, int count) {
    final str = fileName.toLPCWSTR();
    final ret = _.SetRunCountFromFileNameW(str, count);
    malloc.free(str);
    return ret;
  }

  /// The **[incRunCountFromFileName]** function increments the run count by one for a specified file in the Everything by file name.  
  /// ## Syntax  
  /// ```  
  /// DWORD Everything_IncRunCountFromFileName(  
  ///     LPCTSTR lpFileName  
  /// );  
  /// ```  
  /// ## Parameters  
  ///   
  /// - *lpFileName* \[in\]  
  ///   Pointer to a null-terminated string that specifies a fully qualified file name in the Everything index.   
  ///   
  ///   
  /// ## Return Value  
  /// The function returns the new run count for the specifed file.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// The file does not have to exist. When the file is created it will have the correct run history.  
  /// Run history information is preserved between file deletion and creation.  
  /// Calling this function will update the date run to the current time for the specified file.  
  /// Incrementing a file with a run count of 4294967295 (0xffffffff) will do nothing.  
  /// ## Example  
  /// ```  
  /// // run a file  
  /// system("C:\\folder\\file.doc");  
  ///   
  /// // increment the run count in Everything.  
  /// Everything_IncRunCountFromFileName(TEXT("C:\\folder\\file.doc"));  
  /// ```  
  /// ## See Also  
  ///   
  /// - [getRunCountFromFileName]  
  /// - [setRunCountFromFileName]
  int incRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final ret = _.IncRunCountFromFileNameW(str);
    malloc.free(str);
    return ret;
  }

  /*  */
  /// reset state and free any allocated memory
  /// The **[reset]** function resets the result list and search state to the default state, freeing any allocated memory by the library.  
  /// ## Syntax  
  /// ```  
  /// void Everything_Reset(void);  
  /// ```  
  /// ## Parameters  
  /// This function has no parameters.  
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// Calling [search] frees the old search and allocates the new search string.  
  /// Calling [query] frees the old result list and allocates the new result list.  
  /// Calling [reset] frees the current search and current result list.  
  /// The default state:  
  /// ```  
  /// Everything_SetSearch(\"\");  
  /// Everything_SetMatchPath(FALSE);  
  /// Everything_SetMatchCase(FALSE);  
  /// Everything_SetMatchWholeWord(FALSE);  
  /// Everything_SetRegex(FALSE);  
  /// Everything_SetMax(0xFFFFFFFF);  
  /// Everything_SetOffset(0);  
  /// Everything_SetReplyWindow(0);  
  /// Everything_SetReplyID(0);  
  /// ```  
  /// ## Example  
  /// ```  
  /// Everything_Reset();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [search]  
  /// - [query]  
  /// - [cleanUp]
  void reset() => _.Reset();
  /// The **[cleanUp]** function frees any allocated memory by the library.  
  /// ## Syntax  
  /// ```  
  /// void Everything_CleanUp(void);  
  /// ```  
  /// ## Parameters  
  /// This function has no parameters.  
  /// ## Return Value  
  /// This function has no return value.  
  /// ## Remarks  
  /// You should call **[cleanUp]** to free any memory allocated by the Everything SDK.  
  /// Everything_CleanUp should be the last call to the Everything SDK.  
  /// Call [reset] to free any allocated memory for the current search and results.  
  /// [reset] will also reset the search and result state to their defaults.  
  /// Calling [search] frees the old search and allocates the new search string.  
  /// Calling [query] frees the old result list and allocates the new result list.  
  /// ## Example  
  /// ```  
  /// Everything_CleanUp();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [search]  
  /// - [reset]  
  /// - [query]
  void cleanUp() => _.CleanUp();
  /// The **[exit]** function requests Everything to exit.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_Exit(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the exit request was successful.  
  /// The function returns 0 if the request failed. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Request Everything to save settings and data to disk and exit.  
  /// ## Example  
  /// ```  
  /// // request Everything to exit.  
  /// Everything_Exit();  
  /// ```  
  /// ## See Also
  void exit() => _.Exit();
  /// The **[isAdmin]** function checks if Everything is running as administrator or as a standard user.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsAdmin(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the Everything is running as an administrator.  
  /// The function returns 0 Everything is running as a standard user or if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Example  
  /// ```  
  /// BOOL isAdmin;  
  ///   
  /// isAdmin = Everything_IsAdmin();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [isAppData]
  void isAdmin() => _.IsAdmin();
  /// The **[isAppData]** function checks if Everything is saving settings and data to %APPDATA%\Everything or to the same location as the Everything.exe.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsAppData(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if settings and data are saved in %APPDATA%\Everything.  
  /// The function returns 0 if settings and data are saved to the same location as the Everything.exe or if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Example  
  /// ```  
  /// BOOL isAppData;  
  ///   
  /// isAppData = Everything_IsAppData();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [isAdmin]
  void isAppData() => _.IsAppData();
  /* DB */
  /// The **[isDBLoaded]** function checks if the database has been fully loaded.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_IsDBLoaded(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the Everything database is fully loaded.  
  /// The function returns 0 if the database has not fully loaded or if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// When Everything is loading, any queries will appear to return no results.  
  /// Use **[isDBLoaded]** to determine if the database has been loaded before performing a query.  
  /// ## Example  
  /// ```  
  /// for(;;)  
  /// {  
  /// 	if (Everything_IsDBLoaded())  
  /// 	{  
  /// 		// perform a query...  
  /// 		break;  
  /// 	}	  
  /// 	else  
  /// 	{  
  /// 		if (Everything_GetLastError())  
  /// 		{  
  /// 			// IPC not running.  
  /// 			break;  
  /// 		}  
  /// 	}  
  /// 	  
  /// 	// wait for database to load..  
  /// 	Sleep(1000);  
  /// }  
  /// ```  
  /// ## See Also  
  ///   
  /// - [query]
  void isDBLoaded() => _.IsDBLoaded();
  /// The **[rebuildDB]** function requests Everything to forcefully rebuild the Everything index.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_RebuildDB(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the request to forcefully rebuild the Everything index was successful.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Requesting a rebuild will mark all indexes as dirty and start the rebuild process.  
  /// Use **[isDBLoaded]** to determine if the database has been rebuilt before performing a query.  
  /// ## Example  
  /// ```  
  /// // rebuild the database.  
  /// Everything_RebuildDB();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [isDBLoaded]
  void rebuildDB() => _.RebuildDB();
  /// The **[updateAllFolderIndexes]** function requests Everything to rescan all folder indexes.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_UpdateAllFolderIndexes(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the request to rescan all folder indexes was successful.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Everything will begin updating all folder indexes in the background.  
  /// ## Example  
  /// ```  
  /// // Request all folder indexes be rescanned.  
  /// Everything_UpdateAllFolderIndexes();  
  /// ```  
  /// ## See Also
  void updateAllFolderIndexes() => _.UpdateAllFolderIndexes();
  /// The **[saveDB]** function requests Everything to save the index to disk.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_SaveDB(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the request to save the Everything index to disk was successful.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// The index is only saved to disk when you exit Everything.  
  /// Call **[saveDB]** to write the index to the file: Everything.db  
  /// ## Example  
  /// ```  
  /// // flush index to disk  
  /// Everything_SaveDB();  
  /// ```  
  /// ## See Also
  void saveDB() => _.SaveDB();
  /// The **[saveRunHistory]** function requests Everything to save the run history to disk.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_SaveRunHistory(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if the request to save the run history to disk was successful.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// The run history is only saved to disk when you close an Everything search window or exit Everything.  
  /// Call **Everything_RunHistory** to write the run history to the file: Run History.csv  
  /// ## Example  
  /// ```  
  /// // flush run history to disk  
  /// Everything_SaveRunHistory();  
  /// ```  
  /// ## See Also
  void saveRunHistory() => _.SaveRunHistory();
  /// The **[deleteRunHistory]** function deletes all run history.  
  /// ## Syntax  
  /// ```  
  /// BOOL Everything_DeleteRunHistory(void);  
  /// ```  
  /// ## Parameters  
  ///   
  ///   No parameters.  
  ///   
  ///   
  /// ## Return Value  
  /// The function returns non-zero if run history is cleared.  
  /// The function returns 0 if an error occurred. To get extended error information, call [lastError]  
  ///   
  /// ## Remarks  
  /// Calling this function will clear all run history from memory and disk.  
  /// ## Example  
  /// ```  
  /// // clear run history  
  /// Everything_DeleteRunHistory();  
  /// ```  
  /// ## See Also  
  ///   
  /// - [getRunCountFromFileName]  
  /// - [setRunCountFromFileName]  
  /// - [incRunCountFromFileName]
  void deleteRunHistory() => _.DeleteRunHistory();

  /* utils */
  void runQuery(
    String q, {
    bool isMatchCase = false,
    bool isMatchWholeWord = false,
    bool isRegex = false,
    bool isMatchPath = false,
    RequestFlags? requestFlags,
    EverythingSort sort = EverythingSort.sizeAscending,
  }) {
    search = q;
    this.requestFlags = requestFlags ??
        RequestFlags(
          fileName: true,
          path: true,
          size: true,
        );
    this.sort = sort;

    /// search mode
    matchCase = isMatchCase;
    matchWholeWord = isMatchWholeWord;
    matchPath = isMatchPath;
    regex = isRegex;

    /// run query
    query(true);
    final flags = resultListRequestFlags;
    final resultLen = numResults;
    final fileNum = numFileResults;
    final folderNum = numFolderResults;
    final totfile = totFileResults;
    final totFolder = totFolderResults;
    final tot = totResults;
    for (var i = 0; i < resultLen; i++) {
      final size = getResultSize(i);

      final filename = getResultFileName(i);
      final path = getResultPath(i);

      print('$i Name: $filename, Path: $path, Size: $size');
    }
  }
}

enum EverythingError implements Comparable<EverythingError> {
  ok(EVERYTHING_OK),
  errorMemory(EVERYTHING_ERROR_MEMORY),
  errorIpc(EVERYTHING_ERROR_IPC),
  errorRegisterclassex(EVERYTHING_ERROR_REGISTERCLASSEX),
  errorCreatewindow(EVERYTHING_ERROR_CREATEWINDOW),
  errorCreatethread(EVERYTHING_ERROR_CREATETHREAD),
  errorInvalidindex(EVERYTHING_ERROR_INVALIDINDEX),
  errorInvalidcall(EVERYTHING_ERROR_INVALIDCALL),
  errorInvalidrequest(EVERYTHING_ERROR_INVALIDREQUEST),
  errorInvalidparameter(EVERYTHING_ERROR_INVALIDPARAMETER),

  ///
  errorUnknow(-1);

  final int val;
  const EverythingError(this.val);
  factory EverythingError.fromVal(int val) {
    switch (val) {
      case EVERYTHING_OK:
        return ok;
      case EVERYTHING_ERROR_MEMORY:
        return errorMemory;
      case EVERYTHING_ERROR_IPC:
        return errorIpc;
      case EVERYTHING_ERROR_REGISTERCLASSEX:
        return errorRegisterclassex;
      case EVERYTHING_ERROR_CREATEWINDOW:
        return errorCreatewindow;
      case EVERYTHING_ERROR_CREATETHREAD:
        return errorCreatethread;
      case EVERYTHING_ERROR_INVALIDINDEX:
        return errorInvalidindex;
      case EVERYTHING_ERROR_INVALIDCALL:
        return errorInvalidcall;
      case EVERYTHING_ERROR_INVALIDREQUEST:
        return errorInvalidrequest;
      case EVERYTHING_ERROR_INVALIDPARAMETER:
        return errorInvalidparameter;
      default:
        return errorUnknow;
    }
  }
  @override
  int compareTo(EverythingError other) => val - other.val;
}

enum EverythingSort implements Comparable<EverythingSort> {
  nameAscending(EVERYTHING_SORT_NAME_ASCENDING),
  nameDescending(EVERYTHING_SORT_NAME_DESCENDING),
  pathAscending(EVERYTHING_SORT_PATH_ASCENDING),
  pathDescending(EVERYTHING_SORT_PATH_DESCENDING),
  sizeAscending(EVERYTHING_SORT_SIZE_ASCENDING),
  sizeDescending(EVERYTHING_SORT_SIZE_DESCENDING),
  extensionAscending(EVERYTHING_SORT_EXTENSION_ASCENDING),
  extensionDescending(EVERYTHING_SORT_EXTENSION_DESCENDING),
  typeNameAscending(EVERYTHING_SORT_TYPE_NAME_ASCENDING),
  typeNameDescending(EVERYTHING_SORT_TYPE_NAME_DESCENDING),
  dateCreatedAscending(EVERYTHING_SORT_DATE_CREATED_ASCENDING),
  dateCreatedDescending(EVERYTHING_SORT_DATE_CREATED_DESCENDING),
  dateModifiedAscending(EVERYTHING_SORT_DATE_MODIFIED_ASCENDING),
  dateModifiedDescending(EVERYTHING_SORT_DATE_MODIFIED_DESCENDING),
  attributesAscending(EVERYTHING_SORT_ATTRIBUTES_ASCENDING),
  attributesDescending(EVERYTHING_SORT_ATTRIBUTES_DESCENDING),
  fileListFilenameAscending(EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING),
  fileListFilenameDescending(EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING),
  runCountAscending(EVERYTHING_SORT_RUN_COUNT_ASCENDING),
  runCountDescending(EVERYTHING_SORT_RUN_COUNT_DESCENDING),
  dateRecentlyChangedAscending(EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING),
  dateRecentlyChangedDescending(EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING),
  dateAccessedAscending(EVERYTHING_SORT_DATE_ACCESSED_ASCENDING),
  dateAccessedDescending(EVERYTHING_SORT_DATE_ACCESSED_DESCENDING),
  dateRunAscending(EVERYTHING_SORT_DATE_RUN_ASCENDING),
  dateRunDescending(EVERYTHING_SORT_DATE_RUN_DESCENDING),

  ///
  unknow(-1);

  final int val;
  const EverythingSort(this.val);
  factory EverythingSort.fromVal(int val) {
    switch (val) {
      case EVERYTHING_SORT_NAME_ASCENDING:
        return nameAscending;
      case EVERYTHING_SORT_NAME_DESCENDING:
        return nameDescending;
      case EVERYTHING_SORT_PATH_ASCENDING:
        return pathAscending;
      case EVERYTHING_SORT_PATH_DESCENDING:
        return pathDescending;
      case EVERYTHING_SORT_SIZE_ASCENDING:
        return sizeAscending;
      case EVERYTHING_SORT_SIZE_DESCENDING:
        return sizeDescending;
      case EVERYTHING_SORT_EXTENSION_ASCENDING:
        return extensionAscending;
      case EVERYTHING_SORT_EXTENSION_DESCENDING:
        return extensionDescending;
      case EVERYTHING_SORT_TYPE_NAME_ASCENDING:
        return typeNameAscending;
      case EVERYTHING_SORT_TYPE_NAME_DESCENDING:
        return typeNameDescending;
      case EVERYTHING_SORT_DATE_CREATED_ASCENDING:
        return dateCreatedAscending;
      case EVERYTHING_SORT_DATE_CREATED_DESCENDING:
        return dateCreatedDescending;
      case EVERYTHING_SORT_DATE_MODIFIED_ASCENDING:
        return dateModifiedAscending;
      case EVERYTHING_SORT_DATE_MODIFIED_DESCENDING:
        return dateModifiedDescending;
      case EVERYTHING_SORT_ATTRIBUTES_ASCENDING:
        return attributesAscending;
      case EVERYTHING_SORT_ATTRIBUTES_DESCENDING:
        return attributesDescending;
      case EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING:
        return fileListFilenameAscending;
      case EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING:
        return fileListFilenameDescending;
      case EVERYTHING_SORT_RUN_COUNT_ASCENDING:
        return runCountAscending;
      case EVERYTHING_SORT_RUN_COUNT_DESCENDING:
        return runCountDescending;
      case EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING:
        return dateRecentlyChangedAscending;
      case EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING:
        return dateRecentlyChangedDescending;
      case EVERYTHING_SORT_DATE_ACCESSED_ASCENDING:
        return dateAccessedAscending;
      case EVERYTHING_SORT_DATE_ACCESSED_DESCENDING:
        return dateAccessedDescending;
      case EVERYTHING_SORT_DATE_RUN_ASCENDING:
        return dateRunAscending;
      case EVERYTHING_SORT_DATE_RUN_DESCENDING:
        return dateRunDescending;
      default:
        return unknow;
    }
  }
  @override
  int compareTo(EverythingSort other) => val - other.val;
}

class RequestFlags {
  final bool fileName;
  final bool path;
  final bool fullPathAndFileName;
  final bool extension;
  final bool size;
  final bool dateCreated;
  final bool dateModified;
  final bool dateAccessed;
  final bool attributes;
  final bool fileListFileName;
  final bool runCount;
  final bool dateRun;
  final bool dateRecentlyChanged;
  final bool highlightedFileName;
  final bool highlightedPath;
  final bool highlightedFullPathAndFileName;
  RequestFlags({
    this.fileName = false,
    this.path = false,
    this.fullPathAndFileName = false,
    this.extension = false,
    this.size = false,
    this.dateCreated = false,
    this.dateModified = false,
    this.dateAccessed = false,
    this.attributes = false,
    this.fileListFileName = false,
    this.runCount = false,
    this.dateRun = false,
    this.dateRecentlyChanged = false,
    this.highlightedFileName = false,
    this.highlightedPath = false,
    this.highlightedFullPathAndFileName = false,
  });
  factory RequestFlags.fromFlags(int flags) => RequestFlags(
        fileName: flags & EVERYTHING_REQUEST_FILE_NAME != 0,
        path: flags & EVERYTHING_REQUEST_PATH != 0,
        fullPathAndFileName: flags & EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME != 0,
        extension: flags & EVERYTHING_REQUEST_EXTENSION != 0,
        size: flags & EVERYTHING_REQUEST_SIZE != 0,
        dateCreated: flags & EVERYTHING_REQUEST_DATE_CREATED != 0,
        dateModified: flags & EVERYTHING_REQUEST_DATE_MODIFIED != 0,
        dateAccessed: flags & EVERYTHING_REQUEST_DATE_ACCESSED != 0,
        attributes: flags & EVERYTHING_REQUEST_ATTRIBUTES != 0,
        fileListFileName: flags & EVERYTHING_REQUEST_FILE_LIST_FILE_NAME != 0,
        runCount: flags & EVERYTHING_REQUEST_RUN_COUNT != 0,
        dateRun: flags & EVERYTHING_REQUEST_DATE_RUN != 0,
        dateRecentlyChanged: flags & EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED != 0,
        highlightedFileName: flags & EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME != 0,
        highlightedPath: flags & EVERYTHING_REQUEST_HIGHLIGHTED_PATH != 0,
        highlightedFullPathAndFileName: flags & EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME != 0,
      );

  int get flags =>
      (fileName ? EVERYTHING_REQUEST_FILE_NAME : 0) |
      (path ? EVERYTHING_REQUEST_PATH : 0) |
      (fullPathAndFileName ? EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME : 0) |
      (extension ? EVERYTHING_REQUEST_EXTENSION : 0) |
      (size ? EVERYTHING_REQUEST_SIZE : 0) |
      (dateCreated ? EVERYTHING_REQUEST_DATE_CREATED : 0) |
      (dateModified ? EVERYTHING_REQUEST_DATE_MODIFIED : 0) |
      (dateAccessed ? EVERYTHING_REQUEST_DATE_ACCESSED : 0) |
      (attributes ? EVERYTHING_REQUEST_ATTRIBUTES : 0) |
      (fileListFileName ? EVERYTHING_REQUEST_FILE_LIST_FILE_NAME : 0) |
      (runCount ? EVERYTHING_REQUEST_RUN_COUNT : 0) |
      (dateRun ? EVERYTHING_REQUEST_DATE_RUN : 0) |
      (dateRecentlyChanged ? EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED : 0) |
      (highlightedFileName ? EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME : 0) |
      (highlightedPath ? EVERYTHING_REQUEST_HIGHLIGHTED_PATH : 0) |
      (highlightedFullPathAndFileName ? EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME : 0);
}

