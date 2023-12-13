#!/bin/bash

# Edit Exif 1.0.2
# Author and copyright (C): Marcello Vitagliano
# License: GNU General Public License


#################### Parametri da modificare ########################

# inserire la directory contenente le immagini (*.jpg) o la singola immagine (nomefile.jpg) 
Path="/home/$USER/<directory>/*.jpg"

# rimuovere/commentare i tags e i rispettivi comandi exiv2 se non devono essere utilizzati
Fotocamera="Panasonic"
Modello="Lumix GH5"
Data="2022:04:03 14:05:30"
DataOriginale="2022:04:03 14:05:30"
DataDigitalizz="2022:04:03 14:05:30"
Flash="1"
Software="GIMP 2.10.24"
Commento="commento dell'autore"

################### Fine parametri da modificare ###################

PathD="${Path%/*}"

# conto quante immagini saranno modificate
shopt -s nullglob;
files=($Path); 

if [ ${#files[@]} == 0 ]; then
	echo -e "  Non ci sono immagini .jpg nella directory $PathD";
exit;
fi

# cancello, inserisco o modifico i tags exif

echo -e "\n  \e[1m-------- Edit Exif --------\e[0m \n";

echo -e "  Immagini .jpg che saranno modificate in \e[1m$PathD\e[0m:" ${#files[@]} "\n";

echo -e "\n  ⬇️  Inserire i tags nuovi al posto di quelli attuali: \e[1mi\e[0m + <Invio>\n\n  🔄 Lasciare i tags esistenti e modificare solo quelli nuovi: \e[1mm\e[0m + <Invio>\n\n  🗙  Cancellare tutti i tags: \e[1mc\e[0m + <Invio>\n\n  Per uscire: ctrl+c \n";

read risposta;

if [ $risposta == "i" ]; then
	for i in $Path;
	do
	exiv2 rm "$i"
	exiv2 -M "set Exif.Image.Make $Fotocamera" "$i"
	exiv2 -M "set Exif.Image.Model $Modello" "$i"
	exiv2 -M "set Exif.Image.DateTime Ascii $Data" "$i"
	exiv2 -M "set Exif.Photo.DateTimeOriginal Ascii $DataOriginale" "$i"
	exiv2 -M "set Exif.Photo.DateTimeDigitized Ascii $DataDigitalizz" "$i"
	exiv2 -M "set Exif.Photo.Flash Short $Flash" "$i"
	exiv2 -M "set Exif.Image.Software Ascii $Software" "$i"
	exiv2 -M "set Exif.Photo.UserComment charset=Ascii $Commento" "$i"
	done
	echo -e "  Fatto: tags nuovi inseriti \n";

elif [ $risposta == "m" ]; then
	for i in $Path;
	do
	exiv2 -M "set Exif.Image.Make $Fotocamera" "$i"
	exiv2 -M "set Exif.Image.Model $Modello" "$i"
	exiv2 -M "set Exif.Image.DateTime Ascii $Data" "$i"
	exiv2 -M "set Exif.Photo.DateTimeOriginal Ascii $DataOriginale" "$i"
	exiv2 -M "set Exif.Photo.DateTimeDigitized Ascii $DataDigitalizz" "$i"
	exiv2 -M "set Exif.Photo.Flash Short $Flash" "$i"
	exiv2 -M "set Exif.Image.Software Ascii $Software" "$i"
	exiv2 -M "set Exif.Photo.UserComment charset=Ascii $Commento" "$i"
	done
	echo -e "   Fatto: tags modificati \n";
	
elif [ $risposta == "c" ]; then
	for i in $Path;
	do
	exiv2 rm "$i"
	done
	echo -e "   Fatto: tutti i tags cancellati \n";
else
	echo -e "   Scelta errata \n"
exit;
fi
