package Tutorial::Perl::Orientado::Objeto::Moose::PT::BR;
use strict;
use warnings;
use Moose;

    our $VERSION = '0.01';

=head1 NAME

 Tutorial::Perl::Orientado::Objeto::Moose::PT::BR - Tutorial perl Orientação a Objeto com Moose

=head1 SYNOPSIS

Aprenda a programar com perl e Moose (orientação a objetos)

=head1 DESCRIPTION

Moose é um dos melhores sistemas para orientação a objeto em perl.

Moose tira o tédio da orientação a objetos. Moose é uma junção das melhores práticas do: Perl 6, Clos (LISP), Smalltalk, Java, BETA, OCaml, Ruby e outras.

Moose é irado!! funciona super bem e é loooouco. Adoro trabalhar com Moose.

Este tutorial tem por objetivo ajudar os novos desenvolvedores perl que queiram utilizar Moose. Este documento não é a bíblia do Moose, pois o Moose é um assunto bem extenso e de infinitas possibilidades. Então, darei o início a este documento no entanto espero que outras pessoas ajudem a melhorar este tutorial.

=head2 Documentação completa online

http://search.cpan.org/~doy/Moose-2.0604/lib/Moose.pm

http://search.cpan.org/~stevan/Moose-0.54/lib/Moose/Cookbook/Recipe1.pod

... até ...

http://search.cpan.org/~stevan/Moose-0.54/lib/Moose/Cookbook/Recipe22.pod

http://search.cpan.org/~stevan/Moose-0.54/

=head2 Instalacao

cpanm Moose
cpan Moose

=head2 Basicao

Neste primeiro exemplo, vou definir uma classe Carro.

A classe carro vai ter 2 atributos:
- motor:     Indica qual o motor do carro
- top speed: Indica qual a velocidade máxima para este carro
Obs: Atributos em Moose são definidos com 'has' ex.

Atributo tipo String     | Atrib tipo Inteiro | Atributo tipo objeto
                         +                    +
has cor => (             | has idade => (     | has user_agent => (
    is => 'rw',          |     is => 'rw',    |     is => 'rw',
    isa => 'Str',        |     isa => 'Int',  |     isa => 'LWP::UserAgent',
    default => 'Branco', |     default => 50, |     default => sub {
                         |                    |        return
                         |                    |        LWP::UserAgent->new();
                         |                    |     },
);                       | );                 | );

No exemplo acima, foi definido um atributo 'user_agent' que é um LWP::UserAgent
e ao mesmo tempo contem um objeto LWP::UserAgent inicializado com ->new(); Em
outras palavras, meu atributo user_agent é literalmente um LWP::UserAgent

A classe carro vai ter 2 métodos:
- acelerar:  Inicia a aceleração do carro
- marca:     Imprime a marca do carro

 package Carro;
 use Moose;

 #=============================================================================
 # ATTRIBUTO
 # motor: indica que nossa classe tem um motor, do tipo 'Str'
 # eh apenas uma String, mas poderia ser um objeto.. mais
 # pra frente veremos este mesmo exemplo de maneira diferente
 #=============================================================================
 has motor => (
     is => 'rw',
     isa => 'Str',
     default => 'Fusca',
 );

 #=============================================================================
 # ATTRIBUTO
 # top_speed: indica a velocidade máxima do nosso carro. Neste caso é 120
 #=============================================================================
 has top_speed => (
    is => 'ro',
    isa => 'Int',
    default => 120,
 );

 #=============================================================================
 # MÉTODO:
 # acelarar: método de aceleração para nossa classe carro.
 # este método é responsável por fazer nosso carro acelerar.
 # Como estamos usando um fusca, nossa velocidade máxima é 120km/h
 #=============================================================================
 sub acelerar {
     my ( $self ) = @_;    warn "acelerando...";
     warn "vruum vruuuuum";
     my $i = 0;
     while ( $i < $self->top_speed ) {
         warn $i . " km/h" ;
         $i = $i + 25;
     }
 }

 #=============================================================================
 # MÉTODO:
 # marca: Indica a marca atual do carro.
 #=============================================================================
 sub marca {
     my ( $self ) = @_;
     warn "marca: Fusca";
 }

 1;

 #=============================================================================
 # Uso da nossa classe
 #=============================================================================

 package Pista;
 use Moose;
 extends qw/Carro/;
 my $c = Carro->new();
 $c->acelerar;
 $c->marca;

Salve o arquivo como car.pm e execute. Aqui está a saída:

 perl car.pm
 acelerando...
 vruum vruuuuum
 0   km/h
 25  km/h
 50  km/h
 75  km/h
 100 km/h
 marca
 Fusca

=head2 Atributos

 Em moose os atributos são definidos da seguinte maneira:

 has cor => (             | has idade => (     | has user_agent => (
     is => 'rw',          |     is => 'rw',    |     is => 'rw',
     isa => 'Str',        |     isa => 'Int',  |     isa => 'LWP::UserAgent',
     default => 'Branco', |     default => 50, |     default => sub {
                          |                    |        return
                          |                    |        LWP::UserAgent->new();
                          |                    |     },
 );                       | );                 | );

 $obj->nome( 'João' );  #seta o nome joão
 $obj->idade( 30 );     #set a idade
 print $obj->nome;      #imprime nome
 print $obj->idade;     #imprime idade

 Os atributos tambem tem propriedades, por exemplo o atributo cor acima, tem:

  is => 'rw'   Isto indica que cor é rw (Read Write)
  is => 'ro'   Isto indica que cor é ro (Read Only)

 A propriedade isa: quer dizer "Is a" ou seja, "É". Em outras palavras: isa=é

  isa => 'Any' Indica que o atributo pode ser qualquer coisa.. int, string, obj
  isa => 'Int' Indica que só poderá receber valores inteiros
  isa => 'Str' Indica que só poderá receber strings
  isa => 'Some::Object' Indica que este atributo só pode ser do tipo Some::Object

 A propriedade default: Traz o valor padrão para este atributo. A propriedade
  default sempre é executada quando seu objeto é instanciado. Ou seja, se você
  tiver:

  has something => (
      is => 'rw',
      isa => 'Some::Thing',
      default => sub { Some::Thing->new() } ,
  );

 O seu 'something' sempre será um Some::Thing desde o início... Mas... digamos
 que... Some::Thing->new() demora 30 segundos pra executar, e você decidiu que
 não quer este atributo inicializado toda vez que você usar seu objeto. Então
 este atributo pode ser 'lazy'. E sendo lazy, o 'something' não será populado
 automaticamente toda vez. Ao inves disso, ele só será inicializado quando você
 executar o ->something. Ou seja, a demora de 30seg só irá acontecer quando vc
 usar o atributo ->something pela primeira vez.


=head3 is

 is => 'rw' - Read Write
 is => 'ro' - Read Only

=head3 isa

 Documentaçao completa: http://search.cpan.org/dist/Moose/lib/Moose/Manual/Types.pod

 Você pode criar outros tipos, por exemplo um tipo Natural, ou um tipo inteiro positivo ( > 0 )
 crie novos: http://search.cpan.org/dist/Moose/lib/Moose/Util/TypeConstraints.pm

 isa => 'Any' - Any pode receber qualquer valor
 isa => 'Int' - Recebe apenas inteiros
 isa => 'Str' - Recebe apenas strings

 Any
 Item
     Bool
     Maybe[`a]
     Undef
     Defined
         Value
             Str
                 Num
                     Int
                 ClassName
                 RoleName
         Ref
             ScalarRef[`a]
             ArrayRef[`a]
             HashRef[`a]
             CodeRef
             RegexpRef
             GlobRef
                 FileHandle
             Object

=head3 default

 Todos os atributos possúem uma propriedade 'default' que indica o valor padrão para o atributo.
 A propriedade default normalmente recebe uma sub ex:

 has something => (
     is => 'rw',
     isa => 'Any',
     default => 'bla bla',
 );

 has something => (
     is => 'rw',
     isa => 'Any',
     default => sub { return 5 + 5 } ,
 );

=head3 Atributo tipo lazy

Perceba o objeto some_lazy

 package ObjetoLazy;

 use Moose;

 sub BUILD {
     my ( $self ) = @_;
     warn "Startando: ObjetoLazy";
 }

 sub from_lazy {
     my ( $self ) = @_;
     warn "FROM LAZY";
 }

 1;

 package Carro;
 use Moose;

 has motor => (
     is => 'rw',
     isa => 'Str',
     default => 'Fusca',
 );

 has some_lazy => (
     is => 'rw',
     lazy => 1,
     builder => '_some_lazy_builder',
 );

 sub _some_lazy_builder {
     my ( $self ) = @_;
     return ObjetoLazy->new();
 }

 sub acelerar {
     my ( $self ) = @_;
     warn "acelerando...";
     warn "vruum vruuuuum";
     my $i = 0;
     while ( $i < 120 ) {
         warn $i . " km/h" ;
         $i = $i + 25;
     }
 }

 sub marca {
     my ( $self ) = @_;
     warn "marca";
     warn "Fusca";
 }

=head3 predicate

=head2 Métodos

Os métodos de uma classe Moose sempre recebem o argumento $self. veja ex abaixo
O $self, é a referência para o próprio objeto
Os métodos sempre começam com "sub algumacoisa" ex:

 sub somar {
     my ( $self, $a, $b ) = @_;
     return $a + $b;
 }

ou... (mesma coisa)

 has a => (
     is => 'rw',
     isa => 'Int',
     default => 5,
 );

 has b => (
     is => 'rw',
     isa => 'Int',
     default => 5,
 );

 sub somar {
     my ( $self ) = @_;
     return $self->a + $self->b;
 }

=head2 Construtores

Quando você usa Moose, você não precisa definir um construtor para seu objeto. O moose já traz construtores padrão.
O mais legal é que por padrão você pode passar os valores do atributo para o construtor e ele ser vira. ex:

 Package Objeto;
 use Moose;

 has nome => (
     is => 'rw',
     isa => 'Str',
 );

 has idade => (
     is => 'rw',
     isa => 'Int',
 );

 1;

E depois, instanciamos o objeto:

 my $o = Objeto->new( nome => 'João', idade => 50);
 print $o->nome;  #imprime João
 print $o->idade; #imprime 50

Ou seja, não precisamos definir um construtor para nosso objeto, e melhor ainda, podemos passar os atributos para o construtor e ele automaticamente atribúi os valores nos respectivos atributos

Legal, mas vamos supor que eu preciso fazer algo na minha construção.. então eu preciso intervir no meu ->new()  então podemos fazer isso de 2 maneiras.. utilizando BUILD e BUILDARGS

=item BUILDARGS

 O método BUILDARGS é executado, sempre, antes do objeto ser criado. Quando o BUILDARGS é executao, $self ainda não existe pois o objeto não foi instanciado. O BUILDARG recebe exatamente todos os argumentos que são passados para new(). E normalmente o BUILDARGS vai retornar um hash que será utilizado pelo new().

 Segue o exemplo do BUILDARGS. Neste exemplo, eu passo um email ao instanciar o objeto. BUILDARGS é chamado para verificar meu domain e email. Ou seja, tenho umas rotinas dentro do BUILDARGS que separam meu id do meu email e prepara os valores antes de instanciar meu objeto:

 Salve o programa abaixo como:

   buildargs.pl

 E depois execute:

   $ perl buildargs.pl

 O programa:

 package Teste;
 use Moose;
 use Data::Dumper;

 has email => (
     is => 'rw',
     isa => 'Str',
 );

 has domain => (
     is => 'rw',
     isa => 'Str',
 );

 around BUILDARGS => sub {
     my $orig  = shift;
     my $class = shift;
     warn "FROM BUILDARGS...........";
     warn Dumper $class;
     warn Dumper $_[0];

     if ( ref $_[0] eq ref {} and exists $_[0]->{ email } ) {
         # Vamos retirar o domain do email antes instanciar o objeto
         my ( $username, $domain ) = $_[0]->{ email } =~ m|(.+)@(.+)|g;
         return $class->$orig(
             email  => $_[0]->{ email } ,
             domain => $domain,
         );
     }
     else {
         return $class->$orig(@_);
     }
 };

 1;

 package TesteBuildArgs;
 use Moose;
 extends qw/Teste/;

 my $t = Teste->new( {
     email=>'hernanlopes@gmail.com'
 } );
 warn "EMAIL: " . $t->email;
 warn "DOMAIN: " . $t->domain;

 1;

=item BUILD

 O métoro BUILD é executado sempre logo após o objeto ser instanciado. Quando BUILD é executado, $self já existe. Vou Inserir um método BUILD no exemplo anterior para exemplificar.

 Salve o programa abaixo como:

   buildargs.pl

 E depois execute:

   $ perl buildargs.pl

 O programa:

 package Teste;
 use Moose;
 use Data::Dumper;

 has email => (
     is => 'rw',sa => 'Str',
 );

 has domain => (
     is => 'rw',
     isa => 'Str',
 );

 around BUILDARGS => sub {
     my $orig  = shift;
     my $class = shift;
     warn "\n\nFROM BUILDARGS...........";

     if ( ref $_[0] eq ref {} and exists $_[0]->{ email } ) {
         # Vamos retirar o domain do email antes instanciar o objeto
         my ( $username, $domain ) = $_[0]->{ email } =~ m|(.+)@(.+)|g;
         return $class->$orig(
             email  => $_[0]->{ email } ,
             domain => $domain,
         );
     }
     else {
         return $class->$orig(@_);
     }
 };

 sub BUILD {
     my ( $self ) = @_;
     warn "\n\nBUILD... agora \$self já existe";
     warn " EMAIL: " . $self->email;
     warn "DOMAIN: " . $self->domain;
 }

 1;

 package TesteBuildArgs;
 use Moose;
 extends qw/Teste/;

 my $t = Teste->new( {
     email=>'hernanlopes@gmail.com'
 } );
 warn "EMAIL: " . $t->email;
 warn "DOMAIN: " . $t->domain;

 1;

=head2 Delegation

Um atributo pode definir métodos que delegam para seu valor:

 has 'cor_cabelo' => (
       is      => 'ro',
       isa     => 'Graphics::Color::RGB',
       handles => { cor_em_hex => 'as_hex_string' },
 );

 Adiciona um novo método, cor_em_hex.
 E quando alguem usar cor_em_hex, internamente o objeto vai executar: $self->cor_cabelo->as_hex_string.

 Mais infos: Moose::Manual::Delegation

=head2 Engines

 Engines é um tema bem legal e eu gosto bastante. Muitas vezes vamos fazer um módulo que depende de outros módulos. Qual o melhor jeito de fazer isso ?
 Por exemplo, vamos criar uma classe carro. Todo carro pode acelerar e pode ter uma marca. Isso são características do carro. Mas a velocidade máxima varia de acordo com o modelo e marca do carro.
 Então, vou exemplificar uma classe Carro que pode ter motor Ferrari ou Fusca. E Você vai poder mudar o motor; Segue ex:

  Salve tudo e depois execute com:

    perl acelerar.pl

Arquivo: README

  Exemplo de como utilizar diferentes 'engine' carregados atraves de uma unica classe para o exemplo, execute acelerar.pl

Arquivo: arrancada.pl

  use Carro;

  #usando engine Fusca
  my $c = Carro->new( motor => 'Fusca' );
  $c->acelerar;
  warn 'Marca do carro: '. $c->marca;

  #usando engine Ferrari
  my $c = Carro->new( motor => 'Ferrari' );
  $c->acelerar;
  warn 'Marca do carro: '. $c->marca;

Arquivo Carro.pm

  package Carro;
  use Moose;
  use Ferrari;
  use Fusca;

  has engine => (
      is => 'rw',
      isa => 'Any',
      builder => '_build_engine',
  );

  has motor => (
      is => 'rw',
      isa => 'Str',
      default => 'Fusca',
  );

  sub _build_engine {
      my ( $self ) = @_;
      $self->engine( $self->motor->new );
  }

  sub acelerar {
      my ( $self ) = @_;
      $self->engine->acelerar();
  }

  sub marca {
      my ( $self ) = @_;
      $self->engine->marca();
  }

  1;

Arquivo Ferrari.pm

  package Ferrari;
  use Moose;

  has top_speed => (
      is => 'ro',
      isa => 'Int',
      default => 300,
  );

  sub acelerar {
      my ( $self ) = @_;
      for ( my $i = 0; $i <= $self->top_speed; $i = $i + 25 ) {
          print $i,"\n";
      }
  }

  has marca => (
      is => 'ro',
      isa => 'Str',
      default => 'Ferrari v1.0',
  );

  1;

Arquivo Fusca.pm

  package Fusca;
  use Moose;

  has top_speed => (
      is => 'ro',
      isa => 'Int',
      default => 100,
  );

  sub acelerar {
      my ( $self ) = @_;
      for ( my $i = 0; $i <= $self->top_speed; $i = $i + 25 ) {
          print $i,"\n";
      }
  }

  has marca => (
      is => 'ro',
      isa => 'Str',
      default => 'Fusca v1.0',
  );

  1;

=head2 Before, After, Around

 O moose disponibiliza modificadores de métodos que permitem 'grudar' tarefas antes, após ou ao redor dos métodos.

 Isto permite associar métodos em outros métodos. Ou, executar algo similar a um callback.

 Um ponto importante é entender que os modificadores: before, after e around recebem exatamente os mesmos argumentos que o método em questão.

 Segue um exemplo... salve o exemplo abaixo em um arquivo chamado:

    modifier.pl

 e execute:

    perl modifier.pl:

 package Example;
 use Moose;

 sub gritar {
     print "    gridando.... dentro do metodo gritar\n";
 }

 before 'gritar' => sub { print "vou... gritar\n"; };
 after 'gritar'  => sub { print "acabei de... gritar\n"; };

 around 'gritar' => sub {
     my $orig = shift;
     my $self = shift;

     print "  estou em volta de gritar\n";

     $self->$orig(@_);

     print "  ainda estou em volta de gritar\n";
 };

 1;
 package XYZ;
 my $e = Example->new();
 warn $e->gritar;

aqui esta a saída do programa acima:

 vou... gritar
   estou em volta de gritar
     gridando.... dentro do metodo gritar
   ainda estou em volta de gritar
 acabei de... gritar
 1 at modifier.pl line 25.


=head2 Roles

 Uma role encapsula partes de codigo que podem ser compartilhadas entre classes. Roles são coisas que as classes fazem. É importante você entender que Roles não são classes. Você não pode herdar de uma Role e Roles não podem ser instanciadas. Dizem que Roles são consumidas por classes ou outras roles.

 package Pessoa;
 use Moose::Role;

 requires 'corpo';

 has olhos => (
     is => 'rw',
     isa => 'Str',
     default => 'azul',
 );

 has boca => (
     is => 'rw',
     isa => 'Str',
     default => 'vermelha',
 );

 has tipo => (
     is => 'rw',
     isa => 'Str',
     default => 'Pessoa',
 );

 sub listar_itens_cabeca {
     my ( $self ) = @_;
     warn $self->boca;
     warn $self->olhos;
 }

 package SerVivo;
 use Moose;
 with qw/Pessoa/;

 sub corpo {
     my ( $self ) = @_;
     warn "Meus olhos são: " . $self->olhos;
     warn "Minha boca é: " . $self->boca;
 }

 package SeresVivos;
 use Moose;

 my $ser_vivo = SerVivo->new();
 warn $ser_vivo->tipo;
 warn $ser_vivo->corpo;

=head2 Traits

=head2 Types

=head1 AUTHOR

    Hernan Lopes
    CPAN ID: HERNAN
    hernan604
    hernanlopes . gmail.com
    http://github.com/hernan604

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

perl(1).

=cut

#################### main pod documentation end ###################


1;
# The preceding line will help the module return a true value

