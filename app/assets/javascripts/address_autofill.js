$(function() {return $('#course_postcode').jpostal({postcode: ['#course_postcode'],
    address: {
      '#course_prefecture_code': '%3',
      '#course_address_city': '%4%5',
      '#course_address_street': '%6%7',
    },
   });
 });