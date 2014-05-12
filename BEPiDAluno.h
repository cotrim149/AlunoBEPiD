//
//  BEPiDAluno.h
//  Aluno
//
//  Created by ALS on 02/05/14.
//  Copyright (c) 2014 Cotrim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEPiDAluno : NSObject

typedef NS_ENUM(int, BEPiDUniversidade){
    UnB,
    UCB,
    UFMS,
    CEUB,
    FGA,
    UDF
};

@property (nonatomic)NSString *nome;
@property (nonatomic)NSDate *dataNascimento;
@property (nonatomic,readonly) NSInteger idade;
@property (nonatomic) BEPiDUniversidade universidade ;
@property (nonatomic)NSString* curso;
@property (nonatomic)NSDate *dataEntrada;
@property (nonatomic,readonly)NSInteger semestre;

-(instancetype)initWithName: (NSString*) nome
          andDataNascimento: (NSString*) dataNascimento
            andUniversidade: (BEPiDUniversidade) universidade
                   andCurso: (NSString*) curso
             andDataEntrada: (NSString*) dataEntrada;

@end
