﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает список реквизитов, которые не нужно редактировать
// с помощью обработки группового изменения объектов
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	
	НеРедактируемыеРеквизиты.Добавить("Владелец");
	НеРедактируемыеРеквизиты.Добавить("ПолныйКод");
	НеРедактируемыеРеквизиты.Добавить("ХранилищеЗаметок");
	НеРедактируемыеРеквизиты.Добавить("ХранилищеОписания");
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

// Функция определяет реквизиты процесса.
//
// Параметры:
//  Процесс - СправочникСсылка.Процессы - Ссылка на процесс
//
// Возвращаемое значение:
//	Структура - структура, содержащая реквизиты процесса
//
Функция ПолучитьРеквизитыПроцесса(Процесс) Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Процессы.Наименование КАК Наименование,
	|	Процессы.Описание КАК Описание
	|ИЗ
	|	Справочник.Процессы КАК Процессы
	|ГДЕ
	|	Процессы.Ссылка = &Процесс
	|");
	
	Запрос.УстановитьПараметр("Процесс", Процесс);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Наименование = Выборка.Наименование;
		Описание = Выборка.Описание;
	Иначе
		Наименование = "";
		Описание = "";
	КонецЕсли;
	
	СтруктураРеквизитов = Новый Структура("Наименование, Описание",
		Наименование,
		Описание
	);
	
	Возврат СтруктураРеквизитов;

КонецФункции

Функция СформироватьПечатныеФормы(МассивОбъектов, СУчетомПриемника=Ложь, ДанныеСоответствия=Неопределено) Экспорт
	
	ПечатныеФормы = Новый Соответствие;
	
	ТекстЗапроса = ТекстЗапросаДляФормированияОписания();
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	МассивРезультатовЗапроса = Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатовЗапроса[0].Выбрать();
	
	ДеревоШагов = МассивРезультатовЗапроса[1].Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	Пока Выборка.Следующий() Цикл
		
		Документ = Новый ТабличныйДокумент;
		
		ОписаниеОбъектов.НастроитьОписаниеОбъекта(Документ);
		Документ.НачатьАвтогруппировкуСтрок();
		
		СтруктураОтбора = Новый Структура("Процесс", Выборка.Ссылка);
		
		// Шаги процесса
		ДеревоШаговПроцесса = ОписаниеОбъектов.ДеревоОбъектаПоОбщемуДереву(ДеревоШагов, СтруктураОтбора);
		
		СформироватьОписаниеОбъекта(Выборка, ДеревоШаговПроцесса, Документ);
		
	    Документ.ЗакончитьАвтогруппировкуСтрок();
		
		СтруктураПечатныхФорм = Новый Структура;
		СтруктураПечатныхФорм.Вставить("Описание", Документ);
		
		ПечатныеФормы.Вставить(Выборка.Ссылка, СтруктураПечатныхФорм);
		
	КонецЦикла;
	
	Возврат ПечатныеФормы;
	
КонецФункции

// Выполняет печать описаний и схем переданных объектов
//
// Параметры:
//  МассивОбъектов - массив объектов, подлежащих печати
//
Процедура Печать(МассивОбъектов, ПечатныеФормы) Экспорт
	
	ПечатныеФормы = СформироватьПечатныеФормы(МассивОбъектов);
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ТекстЗапросаДляФормированияОписания()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Процессы.Ссылка КАК Ссылка,
	|	Процессы.ПометкаУдаления КАК ПометкаУдаления,
	|	Процессы.Родитель КАК Родитель,
	|	Процессы.ЭтоГруппа КАК ЭтоГруппа,
	|	Процессы.Код КАК Код,
	|	Процессы.Наименование КАК Наименование,
	|	Процессы.Описание КАК Описание,
	|	Процессы.Заметки КАК Заметки,
	|	Процессы.ПолныйКод КАК ПолныйКод,
	|	Процессы.КогдаСтартует КАК КогдаСтартует,
	|	Процессы.ЧемЗавершается КАК ЧемЗавершается,
	|	Процессы.Ответственный КАК Ответственный,
	|	Процессы.РазделПроекта КАК РазделПроекта,
	|	Процессы.Публикуется КАК Публикуется,
	|	Процессы.ПредшествующиеПроцессы.(
	|		ВЫБОР
	|			КОГДА Процессы.ПредшествующиеПроцессы.Процесс.ЭтоГруппа
	|				ТОГДА ""Группа процессов""
	|			ИНАЧЕ ""Процесс""
	|		КОНЕЦ КАК ВидПодраздела,
	|		Процесс КАК Ссылка,
	|		Процесс.ПолныйКод КАК НомерПодраздела,
	|		Процесс.Наименование КАК ЗаголовокПодраздела,
	|		Процесс.ПометкаУдаления КАК ПометкаУдаления,
	|		ВЫРАЗИТЬ(Процессы.ПредшествующиеПроцессы.Процесс.Описание КАК СТРОКА(1000)) КАК Текст1,
	|		"""" КАК Текст2,
	|		"""" КАК СлужебнаяИнформация,
	|		"""" КАК Гиперссылка
	|	) КАК ПредшествующиеПроцессы,
	|	Процессы.РазделыПроекта.(
	|		Раздел КАК Раздел
	|	) КАК РазделыПроекта,
	|	Процессы.ПараметрыПроцесса.(
	|		Имя КАК Имя,
	|		Значение КАК Значение,
	|		ТипПараметра КАК ТипПараметра,
	|		ИсходящийПараметр КАК ИсходящийПараметр
	|	) КАК ПараметрыПроцесса
	|ИЗ
	|	Справочник.Процессы КАК Процессы
	|ГДЕ
	|	Процессы.Ссылка В(&МассивОбъектов)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВЫБОР
	|		КОГДА ШагиПроцесса.ЭтоГруппа
	|			ТОГДА ""Группа шагов""
	|		ИНАЧЕ ""Шаг""
	|	КОНЕЦ КАК ВидПодраздела,
	|	ШагиПроцесса.Ссылка КАК Ссылка,
	|	ШагиПроцесса.ПолныйКод КАК НомерПодраздела,
	|	ШагиПроцесса.Наименование КАК ЗаголовокПодраздела,
	|	ШагиПроцесса.ПометкаУдаления КАК ПометкаУдаления,
	|	ВЫРАЗИТЬ(ШагиПроцесса.Описание КАК СТРОКА(1000)) КАК Текст1,
	|	"""" КАК Текст2,
	|	"""" КАК СлужебнаяИнформация,
	|	"""" КАК Гиперссылка,
	|	ШагиПроцесса.Владелец КАК Процесс,
	|	ШагиПроцесса.ФункцияСистемы КАК ФункцияСистемы,
	|	ШагиПроцесса.СценарийРаботыПользователя КАК СценарийРаботыПользователя
	|ИЗ
	|	Справочник.ШагиПроцесса КАК ШагиПроцесса
	|ГДЕ
	|	ШагиПроцесса.Владелец В(&МассивОбъектов)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ШагиПроцесса.ПолныйКод"
	;
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура СформироватьОписаниеОбъекта(Выборка, ДеревоШаговПроцесса, Документ)
	
	ОписаниеОбъектов.ВывестиЗаголовокОбъекта(НСтр("ru='Процесс'"), Выборка.Ссылка, Выборка.ПолныйКод, Документ);
	ОписаниеОбъектов.ВывестиЗаголовокТекста("", , Документ);
	
	Если НЕ Выборка.ЭтоГруппа Тогда
		ОписаниеОбъектов.ВывестиТекстПоАбзацам(НСтр("ru='Ответственный: '") + Выборка.Ответственный, 1, Документ);
	КонецЕсли;
	
	ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Раздел проекта'"), Документ);
	ОписаниеОбъектов.ВывестиТекстПоАбзацам(Выборка.РазделПроекта, 1, Документ, Выборка.РазделПроекта);
	
	РазделыПроекта = Выборка.РазделыПроекта.Выгрузить();
	
	Если РазделыПроекта.Количество()>0 Тогда
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Дополнительные разделы'"), Документ);
		
		Для Каждого СтрокаТЧ из РазделыПроекта Цикл
			ОписаниеОбъектов.ВывестиТекстПоАбзацам(СтрокаТЧ.Раздел, 1, Документ, СтрокаТЧ.Раздел);
		КонецЦикла;
		
	КонецЕсли;
	
	ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Описание'"), Документ);
	ОписаниеОбъектов.ВывестиТекстПоАбзацам(Выборка.Описание, , Документ);
	
	Если НЕ Выборка.ЭтоГруппа Тогда
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Когда стартует'"), Документ);
		ОписаниеОбъектов.ВывестиТекстПоАбзацам(Выборка.КогдаСтартует, , Документ);
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Чем завершается'"), Документ);
		ОписаниеОбъектов.ВывестиТекстПоАбзацам(Выборка.ЧемЗавершается, , Документ);
		
		ПредшествующиеПроцессы = Выборка.ПредшествующиеПроцессы.Выгрузить();
		ПредшествующиеПроцессы.Сортировать("НомерПодраздела");
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Предшествующие процессы'"), Документ);
		ОписаниеОбъектов.ВывестиПодразделы(ПредшествующиеПроцессы, , , Документ);
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Шаги процесса'"), Документ);
		ОписаниеОбъектов.ВывестиПодразделы(ДеревоШаговПроцесса.Строки, , , Документ);
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Параметры процесса'"), Документ);
		ПараметрыПроцесса = Выборка.ПараметрыПроцесса.Выгрузить();
		Для Каждого СтрокаПараметрыПроцесса Из ПараметрыПроцесса Цикл
			ОписаниеОбъектов.ВывестиЗаголовокПодраздела(НСтр("ru='Имя: '") + СтрокаПараметрыПроцесса.Имя, , 0, Документ);
			ОписаниеОбъектов.ВывестиТекстПоАбзацам(НСтр("ru='Значение: '") + СтрокаПараметрыПроцесса.Значение, 1, Документ);
			ОписаниеОбъектов.ВывестиТекстПоАбзацам(НСтр("ru='Тип: '") + СтрокаПараметрыПроцесса.ТипПараметра, 1, Документ);
			ОписаниеОбъектов.ВывестиТекстПоАбзацам(НСтр("ru='Исходящий: '")
			    + СтрокаПараметрыПроцесса.ИсходящийПараметр, 1, Документ);
		КонецЦикла;	 
		
		ОписаниеОбъектов.ВывестиЗаголовокРаздела(НСтр("ru='Заметки'"), Документ);
		ОписаниеОбъектов.ВывестиТекстПоАбзацам(Выборка.Заметки, , Документ);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли