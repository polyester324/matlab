function [offsetArray, lengthArray, lettersArray] = lzParser(str)
    % Находим индексы символов '<' и '>'
    ltIndices = strfind(str, '<');
    gtIndices = strfind(str, '>');
    
    % Инициализируем массивы
    offsetArray = zeros(1, length(ltIndices));
    lengthArray = zeros(1, length(ltIndices));
    lettersArray = cell(1, length(ltIndices));
    
    % Разбиваем строку на массивы
    for i = 1:length(ltIndices)
        % Определяем подстроку между символами '<' и '>'
        substr = str(ltIndices(i)+1:gtIndices(i)-1);

        % Разбиваем подстроку по запятой
        parts = strsplit(substr, ',');

        % Записываем значения в соответствующие массивы
        offsetArray(i) = str2double(parts{1});
        lengthArray(i) = str2double(parts{2});
        lettersArray{i} = parts{3};
    end
end