# DevOps_4
Лабораторная работа №4
Разберем плохой CI/CD

1. Использование latest

<img width="357" height="115" alt="image" src="https://github.com/user-attachments/assets/616c7eba-9cec-4273-9c63-99d0a68274c4" />

Теперь сборка нестабильная. Могут возникнуть ограничения в поддержке и обновлениях, проблемы совместимости, неожиданные сбои из-за багов и обновлений самой версии языка. Ненадежно. 

В исправленном файле указываем версию. Как итог - стабильность, с этого берега проблем быть не должно. 

 <img width="207" height="51" alt="image" src="https://github.com/user-attachments/assets/a53b557f-89c6-4339-983c-45e420e41885" />


2. Пароль хранится прямо в коде
   
<img width="274" height="68" alt="image" src="https://github.com/user-attachments/assets/5ad5d66f-071a-45d2-bd18-fbf89b86c254" />
  
Проблема в том, что если файл попадет в git, а скорее всего он туда попадет, то пароль навсегда там останется, даже если его удалить (в таком случае - будет в коммитах). Никакой засекречености, заходи, бери что хочешь.

В исправленной версии секреты вынесены в CI/CD variables, где они хранятся отдельно от кода и подставляются во время выполнения pipeline.

3. Многократное повторение pip install

<img width="339" height="495" alt="image" src="https://github.com/user-attachments/assets/254f97d7-3ee9-43a4-a18d-d41b169dabb1" />

Таким образом, программа тратит лишнее время на установку зависимостей, дублированию одинаковых операций, увеличению нагрузки на CI и замедлению. 

Добавим общий image и централизованную установку. Тогда зависимости будут установлены один раз на job уровне, да и код стал компактнее. 

<img width="290" height="95" alt="image" src="https://github.com/user-attachments/assets/b573e01e-3b2b-4ff3-8f60-7fb23000ef55" />

5. allow_failure: true
   <img width="210" height="63" alt="image" src="https://github.com/user-attachments/assets/5c8436d3-2bcb-4cca-ba74-d4fefe72e96b" />
   Игнорирование lint ошибок, плохой код попадет в main.

6. Нет cache
   Зависимости качаются заново, pipeline работает меленно

7. Нет артефактов
   Не сохраняются результаты тестов, нет отчетов.

8. Нет разделения environments
   Небезопасный деплой, нет staging, нет контроля.


Исправления: 

1. Фиксировали питон версию
   <img width="207" height="51" alt="image" src="https://github.com/user-attachments/assets/a53b557f-89c6-4339-983c-45e420e41885" />
   Фиксируем версию -- стабильные сборки, одинаковое окружение. 
2. добавили кэширование
   <img width="185" height="74" alt="image" src="https://github.com/user-attachments/assets/0d542fd3-675a-4a70-84ed-8ed23f06b978" />

3. Убрали дублирование
   <img width="365" height="110" alt="image" src="https://github.com/user-attachments/assets/bdf308eb-83a8-49e5-815d-eac9e25dc319" />

4. Убрали allow_failure
   Теперь lint обязательно проходит. 

5. Добавили артефакты
   <img width="252" height="66" alt="image" src="https://github.com/user-attachments/assets/69631599-c732-40de-afce-9977d0209267" />
   GitLab показывает test reports

6. Разделили security stage
   проверка безопасности отдельно; pipeline читается лучше




