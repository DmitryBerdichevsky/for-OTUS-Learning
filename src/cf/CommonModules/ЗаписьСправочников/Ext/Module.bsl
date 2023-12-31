﻿Процедура УстановитьКодСправочника(Объект) Экспорт
	
	Если (Объект.ЭтоНовый() ИЛИ ТипЗнч(Объект)=Тип("СправочникОбъект.ЭлементыСправки")) И НЕ ЗначениеЗаполнено(Объект.Код) Тогда
		
		Если ТипЗнч(Объект) = Тип("СправочникОбъект.ЭлементыСправки")
			ИЛИ ТипЗнч(Объект) = Тип("СправочникОбъект.ШагиПроцесса") Тогда
			
			Объект.УстановитьНовыйКод();
		Иначе
			Если (ТипЗнч(Объект) = Тип("СправочникОбъект.КонтрольныеТочкиТехническихПроектов") ИЛИ НЕ ЗначениеЗаполнено(Объект.Родитель)) Тогда
				УстановитьНовыйКодСУчетомПроекта(Объект);
			Иначе
				Объект.УстановитьНовыйКод();
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
		
КонецПроцедуры

// Устанавливает правильное значение реквизита ПолныйКод
//
Процедура УстановитьПолныйКодСправочника(Объект, КоличествоРазрядов = 0) Экспорт
	
	Если КоличествоРазрядов > 0 Тогда
		Код = Формат(Число(Объект.Код), "ЧЦ=" + КоличествоРазрядов + "; ЧВН=");
	Иначе
		Код = Объект.Код;
	КонецЕсли;
	
	Если НЕ Объект.Родитель.Пустая() Тогда
		Объект.ПолныйКод = СокрЛП(Универсальные.ЗначенияРеквизитовСправочника(Объект.Родитель, "ПолныйКод").ПолныйКод) + "." + Код;
	Иначе
		Объект.ПолныйКод = Код;
	КонецЕсли;
	
КонецПроцедуры

// Устанавливает правильное значение реквизита ПолныйКод дочерним элементам записываемого справочника.
//
Процедура УстановкаПолногоКодаДочернихЭлементовСправочникаПриЗаписи(Источник, Отказ) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Ссылка
	|ИЗ
	|	Справочник." + Источник.Метаданные().Имя + "
	|ГДЕ
	|	Родитель = &Родитель
	|	И ПОДСТРОКА(ПолныйКод, 1, &ДлинаПолногоКодаРодителя) <> &ПолныйКодРодителя";
	
	Запрос.УстановитьПараметр("Родитель", Источник.Ссылка);
	Запрос.УстановитьПараметр("ДлинаПолногоКодаРодителя", СтрДлина(Источник.ПолныйКод));
	Запрос.УстановитьПараметр("ПолныйКодРодителя", Источник.ПолныйКод);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Выборка.Ссылка.ПолучитьОбъект().Записать();
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Меняет владельца у подчиненных элементов
Процедура ПереписатьВладельцевУПодчиненныхЭлементов(Ссылка, Отказ, Сообщение) Экспорт
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Справочники[Ссылка.Метаданные().Имя].Выбрать(Ссылка);
	Пока Выборка.Следующий() Цикл
		Если Не Ссылка.Владелец = Выборка.Владелец Тогда
			Объект = Выборка.ПолучитьОбъект();
			Попытка
				Объект.Заблокировать();
			Исключение
				СоставноеСообщение = НСтр(" ru= ""Не удалось изменить владельца у подчиненного элемента: %Ссылка% по причине: %ОписаниеОшибки%""; ");
				СоставноеСообщение = СтрЗаменить(СоставноеСообщение, "%Ссылка%", Выборка.Ссылка);
				СоставноеСообщение = СтрЗаменить(СоставноеСообщение, "%ОписаниеОшибки%", ОписаниеОшибки());
				Сообщение = Сообщение + Символы.ПС + СоставноеСообщение;
				Отказ = Истина;
				Возврат;
			КонецПопытки;
			Объект.Владелец = Ссылка.Владелец;
			Объект.ОбменДанными.Загрузка = Истина;
			Попытка
				Объект.Записать();
				Объект.Разблокировать();
			Исключение
				СоставноеСообщение = НСтр(" ru= ""Не удалось изменить владельца у подчиненного элемента: %Ссылка%""; "); 
				СоставноеСообщение = СтрЗаменить(СоставноеСообщение, "%Ссылка%", Выборка.Ссылка);
				Сообщение = Сообщение + Символы.ПС + СоставноеСообщение;
				Отказ = Истина;
				Возврат;
			КонецПопытки; 
		КонецЕсли; 
	КонецЦикла;
	
КонецПроцедуры

Процедура УстановитьНовыйКодСУчетомПроекта(Объект)
	
	ИмяТаблицы = Объект.Метаданные().Имя;
	
	Запрос = Новый Запрос();
	
	УстановитьПривилегированныйРежим(Истина);
	
	Проект = Объект.Владелец;
	ТекстУсловияДляПроекта = " И Таблица.Владелец = &Проект ";
	
	Запрос.Текст="ВЫБРАТЬ ПЕРВЫЕ 1 
	|	Таблица.Код КАК Код
	|ИЗ
	|	Справочник." + ИмяТаблицы + " КАК Таблица
	|ГДЕ
	|	Таблица.Родитель = ЗНАЧЕНИЕ(Справочник." + ИмяТаблицы + ".ПустаяСсылка)" + ТекстУсловияДляПроекта + "
	|
	|УПОРЯДОЧИТЬ ПО
	|	Код УБЫВ";
	
	Запрос.УстановитьПараметр("Проект", Проект);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Объект.Код = Выборка.Код + 1;
	Иначе
		Объект.Код = 1;
	КонецЕсли;

КонецПроцедуры