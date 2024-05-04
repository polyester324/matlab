function [compressed, original, r] = main(lengthOfText)
    % Размер окна
    ws = 13; 
    % Баффер
    lab = 6;
    % Генерация случайного текста
    randomSeq = char(randi([97, 122], [1, 7]));
    disp(randomSeq);
    repeatSequence('sample.txt', randomSeq, lengthOfText);
    seq = fileread('sample.txt');
    fprintf('Sequence to encode:\n%s\n', seq);
    
    fprintf('Sequence to encode:\n%s\n', seq);
    % Кодирование в формат LZ77
    enseq = lz77Enc(seq, ws, lab);
    fprintf('Encoded sequence:\n%s\n', enseq);
    
    % Вычисление длины закодированной последовательности
    x = length(enseq)/7;
    enLen = x*(8 + length(dec2bin(ws-lab)) + length(dec2bin(lab)));
    
    % Вычисление степени сжатия
    r = length(seq)*8/enLen;
    r = num2str(r);
    
    % Открываем файл для записи декодированных данных
    fid = fopen('encoded_Lz77_data.txt', 'w');
    
    % Записываем декодированные данные в файл
    fprintf(fid, '%s', enseq);
    
    % Закрываем файл
    fclose(fid);
    
    % Парсировка в Lz77
    [offsetArray, lengthArray, lettersArray] = lzParser(enseq);
    data = strjoin(lettersArray, '');
    
    % Данные для словаря
    letter = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'B' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '-' ',' '.' '_'};
    letters = 'abcdefghijklmnopqrstuvwxyz-,._';
    % arrayfun применяет функцию anon (сумму) к элементам буквы
    occurence = arrayfun(@(x)sum(data==x), letters);
    %divide each element by number of characters in data file
    probability1 = occurence ./ length(data);
    
    % Изъятие частот
    fileIDFreq = fopen('frequency.txt', 'r');
    freqData = textscan(fileIDFreq,'%s %f');
    fclose(fileIDFreq);
    probability3 = freqData{2};
    probability3 = transpose(probability3);
    
    % Создание словаря
    dict = huffmanDict(letter, probability3);
    encodedDict = [dict.symbol; dict.output];
    disp(encodedDict)
    
    % Кодирование текстa
    encText = huffmanEnc(data, dict);
    disp(encText)
    
    % Декодирование текста
    decText = huffmanDec(encText, dict);
    decoded = cell2mat(decText);
    disp(num2cell(decoded));
    
    disp('staert DecodeLz77');
    finalDecodedText = lz77Dec(offsetArray, lengthArray, num2cell(decoded));
    disp(finalDecodedText);
    
    % Запись декодированных данные в файл
    fid = fopen('decoded_data.txt', 'w');
    fprintf(fid, '%s', finalDecodedText);
    fclose(fid);
    
    % Запись закодированных данных
    fid = fopen('encoded_huffman_data.txt', 'w');
    fprintf(fid, '%s', encText);
    fclose(fid);
    
    % Получение размера закодированных данных
    fileInfo = dir('encoded_huffman_data.txt');
    compressed = [num2str(fileInfo.bytes), ' B'];
    
    % Получение размера разкодированных данных
    fileInfo = dir('decoded_data.txt');
    original = [num2str(fileInfo.bytes), ' B'];
end


