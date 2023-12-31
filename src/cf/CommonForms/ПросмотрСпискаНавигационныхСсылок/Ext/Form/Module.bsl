﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Перем ЗначениеПараметраЗаголовок;
	
	СписокСсылок.ЗагрузитьЗначения(Параметры.СписокСсылок.ВыгрузитьЗначения());
	
	Если Параметры.Свойство("Заголовок", ЗначениеПараметраЗаголовок) Тогда
		Заголовок = ЗначениеПараметраЗаголовок;
	Иначе
		Заголовок = НСтр("ru='Навигационные ссылки (%КоличествоСсылок%)'");
	КонецЕсли;
	
	Заголовок = СтрЗаменить(Заголовок, "%КоличествоСсылок%", СписокСсылок.Количество());
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокСсылокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ПоказатьЗначение(Неопределено, Элементы.СписокСсылок.ТекущиеДанные.Значение);
	
КонецПроцедуры

#КонецОбласти
