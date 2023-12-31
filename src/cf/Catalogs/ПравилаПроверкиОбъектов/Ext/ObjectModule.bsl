﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если НЕ ЭтоГруппа И ПустаяСтрока(ТекстЗапроса) Тогда
		
		ТекстЗапроса =
		"// Здесь должен быть написан запрос, выполняющий проверку правила.
		|// 
		|// Обязательные поля запроса:
		|// 
		|// ОбъектПроверки - Ссылка на проверяемый справочник
		|// ЭлементОбъекта - Ссылка на справочник, подчиненный проверяемому
		|// Информация - Текст, описывающий возникшую проблему
		|// 
		|// В отчет информация выводится 3-мя колонками:
		|// ОбъектПроверки
		|// ЭлементОбъекта
		|// Информация
		|
		|ВЫБРАТЬ
		|	NULL КАК ОбъектПроверки,
		|	NULL КАК ЭлементОбъекта,
		|	"""" КАК Информация
		|";
		
	КонецЕсли;
		
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЭтоГруппа И Активно Тогда
		ПроверкаОбъектов.СоздатьПостроительОтчетаПоПравилу(ТекстЗапроса, Отказ);
	КонецЕсли;
	
	Если Отказ Тогда
		ТекстСообщения = НСтр("ru='Правило <%Наименование%> не записано.'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Наименование%", Наименование) + Символы.ПС;
		Сообщить(ТекстСообщения, СтатусСообщения.Важное);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
