﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Заполняет список текущих дел пользователя.
//
// Параметры:
//  ТекущиеДела - ТаблицаЗначений - таблица значений с колонками:
//    * Идентификатор - Строка - внутренний идентификатор дела, используемый механизмом "Текущие дела".
//    * ЕстьДела      - Булево - если Истина, дело выводится в списке текущих дел пользователя.
//    * Важное        - Булево - если Истина, дело будет выделено красным цветом.
//    * Представление - Строка - представление дела, выводимое пользователю.
//    * Количество    - Число  - количественный показатель дела, выводится в строке заголовка дела.
//    * Форма         - Строка - полный путь к форме, которую необходимо открыть при нажатии на гиперссылку
//                               дела на панели "Текущие дела".
//    * ПараметрыФормы- Структура - параметры, с которыми нужно открывать форму показателя.
//    * Владелец      - Строка, объект метаданных - строковый идентификатор дела, которое будет владельцем для текущего
//                      или объект метаданных подсистема.
//    * Подсказка     - Строка - текст подсказки.
//
Процедура ПриЗаполненииСпискаТекущихДел(ТекущиеДела) Экспорт
	
	Если Не ПравоДоступа("Редактирование", Метаданные.РегистрыСведений.ВыполнениеОбщихЗадач) Тогда
		Возврат;
	КонецЕсли;
	
	ИдентификаторГруппыОбщиеЗадачи = НСтр("ru='Общие задачи'");
	
	ПоказателиТекущихДел = ПоказателиТекущихДелПоОбщимЗадачам();
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	СписокСроков = Новый СписокЗначений;
	СписокСроков.Добавить("Вчера");
	СписокСроков.Добавить("Сегодня");
	
	СписокСроковВыполненияОбщейЗадачи = Новый СписокЗначений;
	СписокСроковВыполненияОбщейЗадачи.Добавить("Вчера");
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("Действие", Новый СписокЗначений);
	ПараметрыОтбора.Вставить("СрокОтработки", СписокСроков);
	ПараметрыОтбора.Вставить("СрокВыполненияОбщейЗадачи", Новый СписокЗначений);
	
	ПараметрыОтбораТребуетсяЗапланировать = Новый Структура;
	ПараметрыОтбораВыполнить = Новый Структура;
	ПараметрыОтбораПросрочено = Новый Структура;
	
	Для Каждого ЭлементСтруктуры из ПараметрыОтбора Цикл
		ПараметрыОтбораТребуетсяЗапланировать.Вставить(ЭлементСтруктуры.Ключ, ЭлементСтруктуры.Значение);
		ПараметрыОтбораВыполнить.Вставить(ЭлементСтруктуры.Ключ, ЭлементСтруктуры.Значение);
		ПараметрыОтбораПросрочено.Вставить(ЭлементСтруктуры.Ключ, ЭлементСтруктуры.Значение);
	КонецЦикла;
	
	СписокДействийТребуетсяЗапланировать = Новый СписокЗначений;
	СписокДействийТребуетсяЗапланировать.Добавить("Требуется запланировать");
	
	СписокДействийВыполнить = Новый СписокЗначений;
	СписокДействийВыполнить.Добавить("Выполнить");
	
	СписокДействийПросрочено = Новый СписокЗначений;
	СписокДействийПросрочено.Добавить("Требуется запланировать");
	СписокДействийПросрочено.Добавить("Выполнить");
	
	СписокСроковВыполненияОбщейЗадачиПросрочено = Новый СписокЗначений;
	СписокСроковВыполненияОбщейЗадачиПросрочено.Добавить("Вчера");
	
	ПараметрыОтбораТребуетсяЗапланировать.Вставить("Действие", СписокДействийТребуетсяЗапланировать);
	
	ПараметрыОтбораВыполнить.Вставить("Действие", СписокДействийВыполнить);
	ПараметрыОтбораПросрочено.Вставить("Действие", СписокДействийПросрочено);
	
	ПараметрыОтбораПросрочено.Вставить("СрокОтработки", Новый СписокЗначений);
	ПараметрыОтбораПросрочено.Вставить("ВыполнитьНеПозднее", СписокСроковВыполненияОбщейЗадачиПросрочено);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КлюЧНазначенияИспользования", "ТекущиеДела");
	ПараметрыФормы.Вставить("СтруктураБыстрогоОтбора", ПараметрыОтбораТребуетсяЗапланировать);
	
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = "ОбщиеЗадачиТребуетсяЗапланировать";
	Дело.ЕстьДела       = ПоказателиТекущихДел.ТребуетсяЗапланировать > 0;
	Дело.Представление  = НСтр("ru = 'Запланировать'");
	Дело.Количество     = ПоказателиТекущихДел.ТребуетсяЗапланировать;
	Дело.Важное 		= Ложь;
	Дело.ПараметрыФормы = ПараметрыФормы;
	Дело.Форма          = "РегистрСведений.ВыполнениеОбщихЗадач.Форма.ОбщиеЗадачиПоОтветственному";
	Дело.Владелец       = ИдентификаторГруппыОбщиеЗадачи;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КлюЧНазначенияИспользования", "ТекущиеДела");
	ПараметрыФормы.Вставить("СтруктураБыстрогоОтбора", ПараметрыОтбораВыполнить);
	
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = "ОбщиеЗадачиВыполнить";
	Дело.ЕстьДела       = ПоказателиТекущихДел.Выполнить > 0;
	Дело.Представление  = НСтр("ru = 'Выполнить'");
	Дело.Количество     = ПоказателиТекущихДел.Выполнить;
	Дело.Важное 		= Ложь;
	Дело.ПараметрыФормы = ПараметрыФормы;
	Дело.Форма          = "РегистрСведений.ВыполнениеОбщихЗадач.Форма.ОбщиеЗадачиПоОтветственному";
	Дело.Владелец       = ИдентификаторГруппыОбщиеЗадачи;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КлюЧНазначенияИспользования", "ТекущиеДела");
	ПараметрыФормы.Вставить("СтруктураБыстрогоОтбора", ПараметрыОтбораПросрочено);
	
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = "ОбщиеЗадачиПросрочено";
	Дело.ЕстьДела       = ПоказателиТекущихДел.Просрочено > 0;
	Дело.Представление  = НСтр("ru = 'Просрочено'");
	Дело.Количество     = ПоказателиТекущихДел.Просрочено;
	Дело.Важное 		= Истина;
	Дело.ПараметрыФормы = ПараметрыФормы;
	Дело.Форма          = "РегистрСведений.ВыполнениеОбщихЗадач.Форма.ОбщиеЗадачиПоОтветственному";
	Дело.Владелец       = ИдентификаторГруппыОбщиеЗадачи;
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Проект)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПоказателиТекущихДелПоОбщимЗадачам()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВЫБОР
	|			КОГДА ВыполнениеОбщихЗадачСрезПоследних.СтатусВыполнения = ЗНАЧЕНИЕ(Перечисление.СтатусыОбщихЗадач.ТребуетсяЗапланировать)
	|					И ВыполнениеОбщихЗадачСрезПоследних.ОбщаяЗадача.ЗапланироватьНеПозднее < &ДатаЗавтра
	|				ТОГДА ВыполнениеОбщихЗадачСрезПоследних.Проект
	|		КОНЕЦ) КАК ТребуетсяЗапланировать,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВЫБОР
	|			КОГДА ВыполнениеОбщихЗадачСрезПоследних.СтатусВыполнения = ЗНАЧЕНИЕ(Перечисление.СтатусыОбщихЗадач.Запланирована)
	|					И ВыполнениеОбщихЗадачСрезПоследних.СрокВыполнения < &ДатаЗавтра
	|				ТОГДА ВыполнениеОбщихЗадачСрезПоследних.Проект
	|		КОНЕЦ) КАК Выполнить,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВЫБОР
	|			КОГДА ВыполнениеОбщихЗадачСрезПоследних.СтатусВыполнения В (ЗНАЧЕНИЕ(Перечисление.СтатусыОбщихЗадач.ТребуетсяЗапланировать), ЗНАЧЕНИЕ(Перечисление.СтатусыОбщихЗадач.Запланирована))
	|					И ВыполнениеОбщихЗадачСрезПоследних.ОбщаяЗадача.ВыполнитьНеПозднее < &ТекущаяДата
	|				ТОГДА ВыполнениеОбщихЗадачСрезПоследних.Проект
	|		КОНЕЦ) КАК Просрочено
	|ИЗ
	|	РегистрСведений.ВыполнениеОбщихЗадач.СрезПоследних(
	|			,
	|			Ответственный = &ТекущийПользователь
	|				И НЕ ОбщаяЗадача.ПометкаУдаления) КАК ВыполнениеОбщихЗадачСрезПоследних"
	;
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	ТекущаяДата = НачалоДня(Текущаядата());
	
	ДатаЗавтра = ОбщегоНазначенияСППР.СледующаяДатаПоОсновномуКалендарю();
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ТекущийПользователь", ТекущийПользователь);
	Запрос.УстановитьПараметр("ДатаЗавтра", ДатаЗавтра);
	Запрос.УстановитьПараметр("ТекущаяДата", НачалоДня(ТекущаяДата()));
	
	СтруктураРезультата = Новый Структура;
	СтруктураРезультата.Вставить("ТребуетсяЗапланировать", 0);
	СтруктураРезультата.Вставить("Выполнить", 0);
	СтруктураРезультата.Вставить("Просрочено", 0);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(СтруктураРезультата, Выборка);
	КонецЕслИ;
	
	Возврат СтруктураРезультата;
	
КонецФункции

#КонецОбласти

#КонецЕсли