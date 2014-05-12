//
//  BEPiDAluno.m
//  Aluno
//
//  Created by ALS on 02/05/14.
//  Copyright (c) 2014 Cotrim. All rights reserved.
//

#import "BEPiDAluno.h"

@implementation BEPiDAluno

int calculaIdade(NSDate *dtNascimento){
    NSDate *now = [[NSDate alloc] init];
    
    NSTimeInterval idade = [now timeIntervalSinceDate:dtNascimento];
    
    idade = idade/(60*60*24*366);
    return idade ;
}

int calculaSemestreAtual(NSDate* dtEntrada){
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval semestre = [now timeIntervalSinceDate:dtEntrada];
    
    semestre = semestre/(60*60*24*365) *2;
    	
    return semestre;
}


-(instancetype)initWithName: (NSString*) nome andDataNascimento: (NSString*) dataNascimento andUniversidade: (BEPiDUniversidade) universidade andCurso: (NSString*) curso andDataEntrada: (NSString*) dataEntrada{
    
    self.nome = nome;
    
    NSDateFormatter *data = [[NSDateFormatter alloc] init];
    data.timeStyle = NSDateFormatterNoStyle;
    data.dateFormat = @"dd/mm/yyyy";
    self.dataNascimento = [data dateFromString:dataNascimento];
    self.universidade = universidade;
    self.curso = curso;
    self.dataEntrada = [data dateFromString:dataEntrada];
    _idade = calculaIdade(self.dataNascimento);
    _semestre = calculaSemestreAtual(self.dataEntrada);
    return self;
    
}

-(NSString*)description{
    return [NSString stringWithFormat:@"Nome: %@ \n Idade: %ld \n Universidade: %d \n Curso: %@ \n Semestre: %lu ",_nome,(long)_idade,_universidade,_curso,_semestre];
}

@end
