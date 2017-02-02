function atomneb_list_aeff_he_i_pfsd12_references, Atom_RC_file, atom, ion
;+
; NAME:
;     atomneb_list_aeff_he_i_pfsd12_references
; PURPOSE:
;     list all references of recombination coefficients (Aeff) 
;     for given element and ionic level
; EXPLANATION:
;
; CALLING SEQUENCE:
;     atom='he'
;     ion='ii'
;     list_hei_aeff_reference=atomneb_list_aeff_he_i_pfsd12_references(Atom_RC_file, atom, ion)
;     print,list_hei_aeff_reference
;
; INPUTS:
;     fits_file - the MGFIT line data (./rc_he_ii_PFSD12.fits)
; RETURN:  References: Array of Strings
;
; REQUIRED EXTERNAL LIBRARY:
;     ftab_ext from IDL Astronomy User's library (../externals/astron/pro)
;
; REVISION HISTORY:
;     IDL code by A. Danehkar, 15/01/2017
;- 
  element_data_list=atomneb_read_aeff_he_i_pfsd12_list(Atom_RC_file)
  atom_ion_name=strlowcase(atom)+'_'+strlowcase(ion)+'_aeff*'
  ii=where(strmatch(element_data_list.Aeff_Data, atom_ion_name));
  temp=size(ii,/DIMENSIONS)
  ii_length=temp[0]
  if ii_length eq 1 then begin
    if ii eq -1 then begin
      print, 'could not find the given element or ion'
      exit
    endif
  endif
  Select_Aeff_Data=element_data_list[ii].Aeff_Data
  ;temp=size(Select_Omij_Data,/DIMENSIONS)
  NLINES1=ii_length;temp[0]
  References = STRARR(NLINES1)
  for i=0, NLINES1-1 do begin 
    Select_Aeff_Data_str1=strsplit(Select_Aeff_Data[i],'_', /EXTRACT)
    temp=size(Select_Aeff_Data_str1,/DIMENSIONS)
    ref_num=temp[0]
    if ref_num gt 3 then References[i] = Select_Aeff_Data_str1[3] else References[i] =''
  endfor
  return, References
end
