function encText = huffmanEnc(data, dict)
    encText ='';
    % Пока ввод данных все еще содержит символы
    while(~isempty(data))
        tmpEncText = '';
        % Для всех букв в словаре
        for i = 1: length(dict.output)
            if(strcmp(data(1), dict.symbol{i}))
                tmpEncText = dict.output{i};
            end
        end
        encText = strcat(encText, tmpEncText);
        data = data(2:end);
    end
end