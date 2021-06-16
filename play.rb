class Hangman

    #construct
    def initialize
        #randomiza o array e seleciona uma word
        @word = words.sample
        @lives = 7
        #variável que põe na tela o "_" ou a última letra digitada pelo guess
        @word_teaser = ""

        #Pega o tamanho da palavra devolvida por words.sample e repete "_ " no tamanho certo de palavras
        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    #contém as palavras do jogo
    def words
        [
            ["cricket", "A game play by gentlemen"],
            ["jogging", "We are not walking..."],
            ["celebrate", "Remembering special moments"],
            ["continent", "There are 7 of these"],
            ["exotic", "Not from around here.."]
        ]
    end

    #imprime a váriavel @word_teaser e atualiza caso necessário
    def print_teaser last_guess = nil
        #atualiza @word_teaser com letra digitada pelo guess, caso last_guess não seja nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    #atualiza @word_teaser com letra digitada pelo guess
    def update_teaser last_guess
        #separa word_teaser em um array
        new_teaser = @word_teaser.split
        #faz um loop no array e associa um index a cada letra
        new_teaser.each_with_index do |letter, index|
            #se letter for um underline e a letra digitada pelo guess for igual de word
            if letter == '_' && @word.first[index] == last_guess
                #na posição do underline entra a leta digitada pelo guess
                new_teaser[index] = last_guess
            end
        end
        #dá a word_teaser as novas palvaras com separador ' '
        @word_teaser = new_teaser.join(' ')
    end

    #aqui é onde o jogo acontece
    def make_guess
        #se ainda houver vida
        if @lives > 0
            puts "Enter a letter:"
            guess = gets.chomp
            #verifica se a palavra contém a letra digitada e retorna true
            good_guess = @word.first.include? guess
            #pode digitar 'exit' pra sair do jogo
            if guess == 'exit'
                puts "Thank you for playing"
            #se letra conter na palavra
            elsif good_guess
                puts "Good guess... you are correct!"
                #print e atualiza
                print_teaser guess
                #aqui ele compara a palavra do jogo com tudo que foi digitado até o momento e 
                #se a palavra estiver completa, venceu o jogo
                #só acho que esse split com join seria a melhor solução, mas fazer funcionar primeiro e depois otimizar
                if @word.first == @word_teaser.split.join
                    puts "Congratulations"
                else
                    #continua o jogo e não perde vida
                    make_guess
                end
            else
                #perde vida porque errou a letra
                @lives -= 1
                puts "Sorry... you have #{@lives} left. Try again"
                #segue o jogo
                make_guess
            end
        else
            puts "Game Over!"
        end
    end

    #inicio do jogo
    def begin
        puts "New game started... your word is #{@word.first.size} characters long"
        puts "To exit game at any time type 'exit'"
        print_teaser
        puts "Clue: #{@word.last}" #imprime a dica da palavra
        make_guess
        
    end

end

game = Hangman.new
game.begin
