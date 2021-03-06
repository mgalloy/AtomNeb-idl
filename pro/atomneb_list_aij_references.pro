function atomneb_list_aij_references, Atom_Aij_file, atom, ion
;+
; NAME:
;     atomneb_list_aij_references
; PURPOSE:
;     list all references of transition probabilities (Aij) 
;     for given element and ionic level
; EXPLANATION:
;
; CALLING SEQUENCE:
;     atom='o'
;     ion='iii'
;     list_oiii_aij_reference=atomneb_list_aij_references(Atom_Aij_file, atom, ion)
;     print,list_oiii_aij_reference
;
; INPUTS:
;     fits_file - the MGFIT line data (./AtomAij.fits)
; RETURN:  References: Array of Strings
;
; REQUIRED EXTERNAL LIBRARY:
;     ftab_ext from IDL Astronomy User's library (../externals/astron/pro)
;
; REVISION HISTORY:
;     IDL code by A. Danehkar, 24/12/2015
;- 
  element_data_list=atomneb_read_aij_list(Atom_Aij_file)
  atom_ion_name=strlowcase(atom)+'_'+strlowcase(ion)+'_aij_*'
  ii=where(strmatch(element_data_list.Aij_Data, atom_ion_name));
  temp=size(ii,/DIMENSIONS)
  ii_length=temp[0]
  if ii_length eq 1 then begin
    if ii eq -1 then begin
      print, 'could not find the given element or ion'
      exit
    endif
  endif
  Select_Aij_Data=element_data_list[ii].Aij_Data
  ;temp=size(Select_Aij_Data,/DIMENSIONS)
  NLINES1=ii_length;temp[0]
  References = STRARR(NLINES1)
  for i=0, NLINES1-1 do begin 
    Select_Aij_Data_str1=strsplit(Select_Aij_Data[i],'_', /EXTRACT)
    References[i] = Select_Aij_Data_str1[3]
  endfor
  return, References
end

