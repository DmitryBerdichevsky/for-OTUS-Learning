﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Владелец = "Патчи_ДанныеДляПубликацииИсправлений";
	УстановитьПривилегированныйРежим(Истина);
	СохраненныеДанные = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Владелец, "Логин,Пароль");
	УстановитьПривилегированныйРежим(Ложь);
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СохраненныеДанные);
	
	АдресСайта = Константы.АдресСервисаПубликацииИсправлений.Получить();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьИЗакрытьНаСервере();
	Закрыть(ЗначениеЗаполнено(АдресСайта));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаписатьИЗакрытьНаСервере()
	
	Владелец = "Патчи_ДанныеДляПубликацииИсправлений";
	Константы.АдресСервисаПубликацииИсправлений.Установить(АдресСайта);
	
	УстановитьПривилегированныйРежим(Истина);
	Если ЗначениеЗаполнено(Логин) Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Логин, "Логин");
	Иначе
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Неопределено, "Логин");
	КонецЕсли;
	Если ЗначениеЗаполнено(Пароль) Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Пароль);
	Иначе
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Неопределено);
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#КонецОбласти