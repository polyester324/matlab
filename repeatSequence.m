function repeatedSequence = repeatSequence(filename, sequence, targetLength)
    % Повторяем последовательность, пока длина не достигнет целевой
    repeatedSequence = sequence;
    while length(repeatedSequence) < targetLength
        repeatedSequence = [repeatedSequence sequence];
    end
    % Обрезаем до указанной длины
    repeatedSequence = repeatedSequence(1:targetLength);
    
    % Записываем последовательность в файл
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%s', repeatedSequence);
    fclose(fileID);
end