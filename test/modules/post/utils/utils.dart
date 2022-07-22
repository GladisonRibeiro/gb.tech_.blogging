final postMap = {
  "id": 1,
  "update_date": null,
  "user": {
    "id": 1,
    "name": "Eliane",
    "profile_picture":
        "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl"
  },
  "message": {
    "content":
        "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida.",
    "created_at": "2022-07-18T06:04:33Z"
  }
};
const postsJson = r"""
[
    {
      "id": 1,
      "update_date": null,
      "user": {
        "id": 1,
        "name": "Eliane",
        "profile_picture":
            "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl"
      },
      "message": {
        "content":
            "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida.",
        "created_at": "2022-07-18T06:04:33Z"
      }
    },
    {
      "id": 2,
      "update_date": null,
      "user": {
        "id": 2,
        "name": "Guilherme",
        "profile_picture":
            "https://drive.google.com/uc?export=view&id=1FXDLNNYSdtcBKbURSrc3dAA_YJCJ9ZuB"
      },
      "message": {"content": "Bom dia!", "created_at": "2022-07-18T07:30:14Z"}
    },
    {
      "id": 3,
      "update_date": null,
      "user": {
        "id": 2,
        "name": "Guilherme",
        "profile_picture":
            "https://drive.google.com/uc?export=view&id=1FXDLNNYSdtcBKbURSrc3dAA_YJCJ9ZuB"
      },
      "message": {
        "content": "Otima semana a todos",
        "created_at": "2022-07-18T07:31:37Z"
      }
    },
    {
      "id": 4,
      "update_date": null,
      "user": {
        "id": 3,
        "name": "Eliza",
        "profile_picture":
            "https://drive.google.com/uc?export=view&id=17V_4ZY-doIfvMRNf0qiAgq8_QVydpuI6"
      },
      "message": {
        "content": "Boa semana ;)",
        "created_at": "2022-07-18T07:37:50Z"
      }
    }
  ]
""";
const newsJson = r"""
{
   "news":[
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?",
            "created_at":"2020-02-02T16:10:33Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Com a união das demais marcas do grupo, doamos 216 toneladas de produtos de higiene para comunidades em vulnerabilidade social de diversas partes do país.",
            "created_at":"2020-02-02T15:10:33Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Tá sabendo da novidade? Tem lançamento de batons Make B. com ácido hialurônico e tá rolando amostra no app do Boti",
            "created_at":"2020-02-02T16:00:00Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Passe protetor solar e beba muuuita água. Essa dupla é essencial pra você conseguir aproveitar todos os dias de festa. Cuida desse corpo que você tanto ama!",
            "created_at":"2020-02-03T15:10:40Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Rainha que é Rainha também se preocupa com o reino animal. Tô muito orgulhosa e querendo que essa atitude vire moda! O Boti ama muito os bichinhos e não testa em animais há quase 20 anos.",
            "created_at":"2020-02-04T18:10:23Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"Produtos veganos também demonstram nosso amor pela natureza!  Sabia que são mais de 30% de produtos de make sem nenhuma matéria-prima de origem animal? Ah, e 40% da linha de Nativa SPA também é vegana. Pra saber se o produto é vegano, é só conferir na embalagem!",
            "created_at":"2020-02-05T16:10:00Z"
         }
      },
      {
         "user":{
            "name":"O Boticário",
            "profile_picture":"https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png"
         },
         "message":{
            "content":"É tanto produto em promoção que vc nem vai saber pra onde olhar.  Entra lá na nossa loja online e vem comemorar o Dia da #BotiLover com a gente.",
            "created_at":"2020-02-06T11:10:00Z"
         }
      }
   ]
}
""";
