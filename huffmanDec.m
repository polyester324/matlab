function decText = huffmanDec(encText, dict)
    decText = [];
    % Пока в закодированном тексте еще есть символы
    position = 1;
    while(position <= length(encText))
        % Получение первого бита
        tmp = encText(position);
        dictOut = dict;
        while(true)
            % Использование вложенной функции для поиска совпадающих символов
            dictM = match(tmp, position, dictOut);
            % Обновление словаря
            dictOut = dictM;
            % Пока не останется 1 ключевое слово
            if (length(dictOut.output) ~= 1)
                position = position + 1;
                tmp = encText(position);
            % Найденный символ
            else
                position = 1;
                encText = encText(length(dictOut.output{1})+1:end);
                break;
            end        
        end
        decText = [decText dictOut.symbol];
    end
    % Нахождение совпадения входного словаря в позиции закодированного текста
    function dictM = match(encWord, position, dict)
        dictM.symbol={}; dictM.output={};
        j = 1;
        % Для каждого закодированного слова в словаре
        for i = 1:length(dict.output)
            % Сравнение битов
            if (length(dict.output{i}) >= position && strcmp(dict.output{i}(position), encWord)) 
                % Получение совпадающего символа и закодированного слова
                dictM.symbol(j) = dict.symbol(i);
                dictM.output(j) = dict.output(i);
                j = j + 1;
            end
        end
    end
end