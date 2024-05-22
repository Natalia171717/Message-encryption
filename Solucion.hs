module Solucion where
import Data.Char
-- No se permite agrear nuevos imports
-- Sólo está permitido usar estas funciones:
-- https://campus.exactas.uba.ar/pluginfile.php/557895/mod_resource/content/1/validas_tp.pdf


-- Completar!
-- Nombre de grupo: {Los Linces}
-- Integrante1: { 4526405, Andrade, Gonzalo}
-- Integrante2: { 45320586, De Marco, Augusto}
-- Integrante3: { 96245438, Pérez, Natalia}
-- Integrante4: { DNI4,apellidoYNombre4}
-- Integrantes que abandonaron la materia: {En caso que haya abandonado la materia algún
                        -- integrante, completar con los dni y apellidos, sino dejar vacío}


-- Las letras en minuscula van de la 97 a la 122
-- Las mayusculas van de la 65 a la 90
--Cuando una variable es llamada palabra, hace referencia a una palabra o a una frase

--PARTE I
-- EJ 1
esMinuscula :: Char -> Bool
esMinuscula caracter = 97 <= ord(caracter) && ord(caracter) <= 122 
                -- el 97 es la a minuscula, el 122 es la Z minuscula

-- EJ 2
{--esMayuscula :: Char -> Bool
esMayuscula caracter = 65 < Data.Char.ord(caracter) && Data.Char.ord(caracter) < 90--} 
                -- el 65 es la A mayusucla, el 90 es la Z mayuscula

letraANatural :: Char -> Int
letraANatural caracter = ord(caracter) - 97

-- EJ 3
desplazar :: Char -> Int -> Char
desplazar caracter movimiento | esMinuscula caracter == True && (ord(caracter) + movimiento) >=97 && (ord(caracter) + movimiento) <= 122 = chr(ord(caracter) + movimiento)
                              | esMinuscula caracter == True = desplazarAux caracter movimiento
                              | otherwise = caracter

desplazarAux :: Char -> Int -> Char
desplazarAux caracter movimiento | movimiento>0 && (ord(caracter) + movimiento)>122 = desplazarAux caracter (movimiento-26)
                                 | movimiento<0 && (ord(caracter) + movimiento)<97 = desplazarAux caracter (movimiento+26)
                                 |otherwise = chr(ord(caracter) + movimiento)

-- EJ 4
cifrar :: String -> Int -> String
cifrar "" _ = ""
cifrar (x:xs) movimiento = (desplazar x movimiento) : (cifrar xs movimiento) --Donde x es el primer Char y xs el resto de Chars del String

-- EJ 5
descifrar :: String -> Int -> String
descifrar "" _ = ""
descifrar (x:xs) movimiento = (desplazar x (-movimiento)) : (descifrar xs movimiento) --Donde x es el primer Char y xs el resto de Chars del String

-- EJ 6
cifrarLista :: [String] -> [String]
cifrarLista [] = []
cifrarLista lista = cifrarListaAux lista 0 --El primer elemento tiene posición cero, por lo tanto, su desplazamiento será cero

cifrarListaAux :: [String] -> Int -> [String]
cifrarListaAux [] _= []
cifrarListaAux (palabra:xs) movimiento = (cifrar palabra movimiento) : cifrarListaAux xs (movimiento+1) --xs es la lista de palabras (o frases) sin incluir la primera

-- EJ 7
frecuencia :: String -> [Float]
frecuencia "" = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
frecuencia palabra |totalMinusculas palabra == 0 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                   |otherwise = frecuenciaAux palabra 'a'

frecuenciaAux :: String -> Char -> [Float]
frecuenciaAux palabra letra |ord(letra)>122 = [] --Las letras en minuscula van de la 97 a la 122 y empecé por 'a', que es 97, entonces termino en 122
                            |otherwise = frecuenciaLetra : frecuenciaAux palabra (chr(ord(letra) + 1)) --hago recursion con la misma palabra y la siguiente letra del abecedario
                            where frecuenciaLetra = fromInteger((aparicionesLetra letra palabra)*100) / fromInteger(totalMinusculas palabra)

aparicionesLetra :: Char -> String -> Integer --funcion que devuelve cantidad de veces que aparece una letra en una palabra o frase
aparicionesLetra _ [] = 0
aparicionesLetra letra (x:xs) |letra==x = 1 + aparicionesLetra letra xs --Donde x es el primer Char y xs el resto de Chars del String
                              |otherwise = aparicionesLetra letra xs

totalMinusculas :: String -> Integer --funcion que devuelve la cantidad de minusculas en una palabra o frase
totalMinusculas [] = 0
totalMinusculas (x:xs) |esMinuscula x = 1 + totalMinusculas xs --Donde x es el primer Char y xs el resto de Chars del String
                       |otherwise = totalMinusculas xs

-- Ej 8
cifradoMasFrecuente :: String -> Int -> (Char, Float)
cifradoMasFrecuente palabraACifrar movimiento = cifradoMasFrecuenteAux (frecuencia(cifrar palabraACifrar movimiento)) 97 --Para empezar con la 'a' usamos el numero 97

cifradoMasFrecuenteAux :: [Float] -> Int -> (Char, Float)
cifradoMasFrecuenteAux [x] numeroLetra = ((chr(numeroLetra)) , x) --x es el unico porcentaje de la lista
cifradoMasFrecuenteAux (porcentaje:xs) numeroLetra | porcentaje >= mayorPorcentaje = (chr(numeroLetra) , porcentaje) --xs es el resto de la lista
                                                   | otherwise = cifradoMasFrecuenteAux xs (numeroLetra+1)
                                                   where mayorPorcentaje = snd(cifradoMasFrecuenteAux xs (numeroLetra+1))
--El 8 funciona bien pero se tarda un poco

-- EJ 9
esDescifrado :: String -> String -> Bool
esDescifrado palabraNormal palabraCapazCifrada = esDescifradoAux palabraNormal palabraCapazCifrada 0

esDescifradoAux :: String -> String -> Int -> Bool
esDescifradoAux _ _ 26 = False -- Si dio la vuelta entera en la calesita del abecedario, no es descifrado
esDescifradoAux palabraNormal palabraCapazCifrada n | cifrar palabraNormal n == palabraCapazCifrada = True 
                                                    | otherwise = esDescifradoAux palabraNormal palabraCapazCifrada (n+1)
-- EJ 10            
todosLosDescifrados :: [String] -> [(String, String)]
todosLosDescifrados listaPalabras = todosLosDescifradosAux listaPalabras listaPalabras 

todosLosDescifradosAux :: [String] -> [String] -> [(String, String)]
todosLosDescifradosAux [] _ = []
todosLosDescifradosAux (palabra:xs) listaPalabras = (descifrados palabra listaPalabras) ++ (todosLosDescifradosAux xs listaPalabras)
--xs es la lista de palabras (o frases) sin incluir la primera
descifrados :: String -> [String] -> [(String, String)]
descifrados _ [] = []
descifrados palabra1 (palabra2:xs) |esDescifradoAux palabra1 palabra2 1 = (palabra1, palabra2):(descifrados palabra1 xs)
                                   |otherwise = descifrados palabra1 xs
--esta funcion arma pares donde el primer componente es palabra1 y el segundo componente son todas las palabras de la lista que son el resultado de cifrar(palabra1,n) para algun n

--PARTE II
-- EJ 11
expandirClave :: String -> Int -> String
expandirClave palabra longitudDeseada =  expandirClaveAux palabra palabra palabra longitudDeseada
-- La triple palabra, es un poco largo de explicar. Esto trata de resolver un problemilla que se encuentra cuando se quiere expandir la clave, a digamos, 100 caracteres y la clave, en este ejemplo, sea "clave"
-- En ese caso, por como esta hecho el codigo, los "bloques de construccion" que son las letras que se van a ir removiendo de la tercera "palabra", entonces se va a vaciar, en ese caso se ve de hacer un "refill".
-- Esto s econsigue a traves de la constante "palabraOriginal", y por ultimo tenemos "claveFinal", donde se realiza y guarda los cambios a la clave


expandirClaveAux :: String -> String-> String-> Int -> String
expandirClaveAux claveFinal palabraOriginal [y] longitudDeseada = expandirClaveAux claveFinal palabraOriginal palabraOriginal longitudDeseada
expandirClaveAux (x:xs) palabra (y:ys) longitudDeseada | length (x:xs) == longitudDeseada = (x:xs) 
                       | otherwise = (x:xs) ++ [y] ++ expandirClaveAux (x:xs) palabra ys longitudDeseada 
-- Hay que preguntar que deberia de pasar cuando queremos "acortar" la palabra, deberia de acortarla? o quedar como es?
-- EJ 12
cifrarVigenere :: String -> String -> String
cifrarVigenere _ _ = "kdueciirqdv"

-- EJ 13
descifrarVigenere :: String -> String -> String
descifrarVigenere _ _ = "computacion"

-- EJ 14
peorCifrado :: String -> [String] -> String
peorCifrado _ _ = "asdef"

-- EJ 15
combinacionesVigenere :: [String] -> [String] -> String -> [(String, String)]
combinacionesVigenere _ _ _ = [("hola", "b")]
