unit uErrorConst;

interface

const
   // For library class
  ERROR_DLL_NOTFOUND = 10; //'Dll (%s) no found.';
  ERROR_DLL_NOT_VALID = 12; // Not valid dll
  ERROR_DLL_LOAD_FAILED = 13; // Error wile load dll
  ERROR_DLL_FUNC_NOTFOUND = 14; // Default func not found

   // For main form
  ERROR_MAIN_LIBDIR_NOTFOUND = 101;
  ERROR_MAIN_CANT_DELETE = 102;

implementation

end.
