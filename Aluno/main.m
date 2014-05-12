//
//  main.m
//  Aluno
//
//  Created by ALS on 02/05/14.
//  Copyright (c) 2014 Cotrim. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BEPiDAluno.h"

NSString* getNomeFromString(NSString *infoAluno,NSUInteger marcador){
    NSMutableString* nome=[[NSMutableString alloc] init];
    
    [nome appendString:[infoAluno substringToIndex:marcador]];
    return nome;
}

NSString* getDtFromString(NSString *infoAluno,NSUInteger marcador1){
    NSMutableString *string1 = [[NSMutableString alloc] init];
    NSMutableString *string2 = [[NSMutableString alloc] init];
    
    [string1 appendString:[infoAluno substringFromIndex:marcador1+1]];
    NSUInteger location = [string1 rangeOfString:@")"].location;
    [string2 appendString:[string1 substringToIndex:location]];
    
    return string2;
}

NSString* getCursoFromString(NSString *infoAluno){
    NSMutableString* string1 = [[NSMutableString alloc] init];
    NSMutableString* string2 = [[NSMutableString alloc] init];
    NSUInteger marcador1 = [infoAluno rangeOfString:@"-"].location;
    
    [string1 appendString:[infoAluno substringFromIndex:marcador1+2]];
    NSUInteger marcador2 = [string1 rangeOfString:@"("].location;
    
    [string2 appendString:[string1 substringToIndex:marcador2]];
    
    return string2;
}

NSString* getUniversidadeFromString(NSString *infoAluno){
    NSMutableString* string1 = [[NSMutableString alloc] init];
    NSMutableString* string2 = [[NSMutableString alloc] init];
    NSMutableString* string3 = [[NSMutableString alloc] init];
    NSUInteger marcador1 = [infoAluno rangeOfString:@"-"].location;
    
    [string1 appendString:[infoAluno substringFromIndex:marcador1+1]];
    NSUInteger marcador2 = [string1 rangeOfString:@"("].location;
    
    [string2 appendString:[string1 substringFromIndex:marcador2+1]];
    NSUInteger marcador3 = [string2 rangeOfString:@")"].location;
    
    [string3 appendString:[string2 substringToIndex:marcador3]];
    
    return string3;
    
}

NSString* getDtEntradaFromString(NSString* infoAluno){
    NSMutableString* string1 = [[NSMutableString alloc] init];
    NSMutableString* string2 = [[NSMutableString alloc] init];
    NSUInteger marcador1 = [infoAluno rangeOfString:@"entrou em"].location;
    
    [string1 appendString:[infoAluno substringFromIndex:marcador1]];
    
    NSUInteger marcador2 = [string1 rangeOfString:@"em"].location;
    
    [string2 appendString:[string1 substringFromIndex:marcador2+3]];
    
    
    return string2;
}


BEPiDUniversidade mapUniversidade(NSString * universidade){
    
    if([universidade isEqualToString:@"UnB"]){
        return UnB;
    }
    if([universidade isEqualToString:@"UCB"]){
        return UCB;
    }
    if([universidade isEqualToString:@"UFMS"]){
        return UFMS;
    }
    if([universidade isEqualToString:@"CEUB"]){
        return CEUB;
    }
    if([universidade isEqualToString:@"FGA"]){
        return FGA;
    }
    if([universidade isEqualToString:@"UDF"]){
        return UDF;
    }

    return -1;
}


int main(int argc, char *argv[])
{

//    NSMutableArray *alunos = [[NSMutableArray alloc] init];
//    
//    BEPiDAluno *aluno1 = [[BEPiDAluno alloc] initWithName:@"victor Cotrim"
//                                        andDataNascimento: @"05/06/1990"
//                                          andUniversidade: UnB
//                                                 andCurso: EngenhariaSoftware
//                                           andDataEntrada: @"01/08/2009"];
//    
//    [alunos addObject:aluno1];
//    
//    NSMutableDictionary *grupos = [[NSMutableDictionary alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"grupos_d110" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    if (error){
        NSLog(@"Erro ao ler arquivo: %@",error.localizedDescription);
    }
    
    //NSLog(@"conteudo: %@",fileContents);
    
    NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];
    NSLog(@"items: %ld",(unsigned long)[listArray count]);
    NSMutableArray *nomeGrupos = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicio = [[NSMutableDictionary alloc] init];
    int contAntigo = -1;
    for (int cont=-1, i=0; i<[listArray count]; i++) {
        if([[listArray objectAtIndex:i] rangeOfString:@"Grupo"].location != NSNotFound){
            [nomeGrupos addObject:[listArray objectAtIndex:i]];
            cont++;
            //NSLog(@"%@",[listArray objectAtIndex:cont]);
        }
        if([[listArray objectAtIndex:i] rangeOfString:@" - "].location !=NSNotFound ){
            NSString *infoAluno = [listArray objectAtIndex:i];
            NSUInteger dtNascimentoInicio = [infoAluno rangeOfString:@"("].location;

            NSString *nome = getNomeFromString(infoAluno,dtNascimentoInicio);
            NSString *dtNascimento = getDtFromString(infoAluno,dtNascimentoInicio);
            NSString *curso = getCursoFromString(infoAluno);
            NSString *universidade = getUniversidadeFromString(infoAluno);
            NSString *dtEntrada = getDtEntradaFromString(infoAluno);
            
            BEPiDAluno *aluno = [[BEPiDAluno alloc] initWithName:nome
                                               andDataNascimento:dtNascimento
                                                 andUniversidade:mapUniversidade(universidade)
                                                        andCurso:curso
                                                  andDataEntrada:dtEntrada];

            if(cont == contAntigo){
                NSMutableArray *grupo = dicio[[nomeGrupos objectAtIndex:cont]];
                [grupo addObject:aluno];
            }else{
                NSMutableArray *alunos = [[NSMutableArray alloc] init];
                [alunos addObject:aluno];
                [dicio setValue:alunos forKey:[nomeGrupos objectAtIndex:cont] ];
                contAntigo = cont;
                
            }
            
        }
    }
    int contador =0;
    for (int i=0; i< [nomeGrupos count]; i++){
        NSMutableArray *alunos = dicio[[nomeGrupos objectAtIndex:i]];
        
        for(int j=0; j< [alunos count];j++){
            NSLog(@"%@",[alunos objectAtIndex:j]);
            contador++;
        }
    
    }
    
    NSLog(@"total de alunos cadastrados: %d",contador);
//    [grupos setValue:alunos forKey:@"azul"];
    
    
    return NSApplicationMain(argc, (const char **)argv);
}
