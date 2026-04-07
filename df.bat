echo %~f1 is modified in%fmod% and created in%fcre%>>processed.txt
if /i "%rext%"=="jpeg" goto :jpeg
::call png.bat %1
if not defined pcre (
		IF "%fcre%" LEQ "%fmod%" (
			exiftool "-CreationTime<FileCreateDate" "-overwrite_original" %1 2>> error.txt
		) else (
			exiftool "-CreationTime<FileModifyDate" "-overwrite_original" %1 2>> error.txt
		)
	) else (
		if "%pcre%" LSS "%fcre%" (
			exiftool "-FileCreateDate<CreationTime" "-overwrite_original" %1 2>> error.txt
		)
		echo Date Taken:%pcre%>>processed.txt
	)
	exiftool "-FileModifyDate<CreationTime" "-overwrite_original" %1 2>> error.txt
)
goto :eof
:jpeg
if not defined mod (
	if not defined crea (
		IF "%fcre%" LEQ "%fmod%" (
			exiftool "-ModifyDate<FileCreateDate" "-overwrite_original" %1 2>> error.txt
			set mod=%fcre%
			echo EXIF modified is taken from file created:%fcre%>>processed.txt
		) else (
			exiftool "-ModifyDate<FileModifyDate" "-overwrite_original" %1 2>> error.txt
			set mod=%fmod%
			echo EXIF modified is taken from file modified:%fmod%>>processed.txt
		)
	) else (
		exiftool "-ModifyDate<CreateDate" "-overwrite_original" %1 2>> error.txt
		echo EXIF modified is taken from EXIF created:%crea%>>processed.txt
	)
) else (
	echo EXIF is modified in%mod%>>processed.txt
)
if not defined crea (
	if "%fcre%" GEQ "%fmod%" (
		if "%fmod%" GTR "%mod%" (
			goto :cdmd
		) else (
			exiftool "-CreateDate<ModifyDate" "-overwrite_original" %1 2>> error.txt
			echo EXIF created is taken from file modified:%fmod%>>processed.txt
		)
	) else (
		if "%fcre%" LSS "%mod%" (
			exiftool "-CreateDate<FileCreateDate" "-overwrite_original" %1 2>> error.txt
			echo EXIF created is taken from file created:%fcre%>>processed.txt
		) else (
			:cdmd
			exiftool "-CreateDate<ModifyDate" "-overwrite_original" %1 2>> error.txt
			echo EXIF created is taken from EXIF modified:%mod%>>processed.txt
		)
	)
	goto :mcym
) else (
	echo EXIF is created in%crea%>>processed.txt 2>> error.txt
)
:mcym
if not defined dacq (
	if not defined pcre (
		if not defined dori (
			goto :fccd
		) else (
			echo Date Taken:%dori%>>processed.txt
			if "%dori%" LSS "%crea%" (
				goto :fcdt
			) else (
				goto :fccd
			)
		)
	) else (
		echo Date Taken:%pcre%>>processed.txt
		if "%pcre%" LSS "%crea%" (
			exiftool "-FileCreateDate<CreationTime" "-overwrite_original" %1 2>> error.txt
		) else (
			goto :fccd
		)
	)
) else (
	if not defined dori (
		echo Date Acquired:%dacq%>>processed.txt
		if "%dacq%" LSS "%crea%" (
			goto :fcda
		) else (
			goto :fccd
		)
	) else (
		echo Date Taken:%dori%>>processed.txt
		echo Date Acquired:%dacq%>>processed.txt
		if "%dori%" LSS "%crea%" (
			:fcdt
			exiftool "-FileCreateDate<DateTimeOriginal" "-overwrite_original" %1 2>> error.txt
		) else (
			if "%dacq%" LSS "%crea%" (
				:fcda
				exiftool "-FileCreateDate<DateAcquired" "-overwrite_original" %1 2>> error.txt	
			) else (
				:fccd
				exiftool "-FileCreateDate<CreateDate" "-overwrite_original" %1 2>> error.txt
			)
		)
	)
)
exiftool "-FileModifyDate<ModifyDate" "-overwrite_original" %1 2>> error.txt
ENDLOCAL