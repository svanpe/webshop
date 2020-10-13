db = db.getSiblingDB("mongodb");
db.product.drop();

db.product.save(
    {
      code: 'A',
      name: "ROSE GOLD",
      boximg: "/static/img/products/watches/box-img.png",
      image2: "/static/img/products/watches/2.png",
      image3: "/static/img/products/watches/3.png",
      image4: "/static/img/products/watches/4.png",
      image: "/static/img/products/watches/1.png",
      category: "watch",
      p1: " MELBOURNE MINIMAL",
      p2: "$95.00",
      p3: "Pretty in peach.",
      p4: "Glamour without the glitz.",
      p5: "Neutral tones with a brushed rose gold casing and peach Italian leather band."
    });

db.product.save(
    {
      code: 'B',
      name: "SUNGLASSES",
      boximg: "/static/img/products/sunglasses/box-img.png",
      image2: "/static/img/products/sunglasses/2.jpeg",
      image3: "/static/img/products/sunglasses/3.jpg",
      image: "/static/img/products/sunglasses/1.jpg",
      image4: "",
      category: "sunglasses",
      p1: " MELBOURNE MINIMAL",
      p2: "$95.00",
      p3: "Pretty in peach.",
      p4: "Wide Fit Oxford Brogue Sunglasses In Burgundy Leather.",
      p5: ""
    });
	
db.product.save(	
    {
      code: 'C',
      name: "BROGUE SHOES",
      boximg: "/static/img/products/shoes/box-img.png",
      image2: "/static/img/products/shoes/2.png",
      image3: "/static/img/products/shoes/3.png",
      image4: "/static/img/products/shoes/4.png",
      image: "/static/img/products/shoes/1.png",
      category: "shoes",
      p1: " MELBOURNE MINIMAL",
      p2: "$95.00",
      p3: "Color: Burgundy",
      p4: "Wide Fit Oxford Brogue Sunglasses In Burgundy Leather.",
      p5: ""
    });
