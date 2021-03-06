import 'package:cumbialive/components/cumbia_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';

Product activeProduct;

int avaliableUnits;
int price;

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();

  EditProductScreen(Product p) {
    activeProduct = p;
    avaliableUnits = activeProduct.avaliableUnits;
    price = activeProduct.price;
  }
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController(text: activeProduct.productName);
  final TextEditingController refController =
      TextEditingController(text: activeProduct.reference);
  final TextEditingController textController =
      TextEditingController(text: activeProduct.description);
  final TextEditingController colorController =
      TextEditingController(text: activeProduct.color);
  final TextEditingController sizeController =
      TextEditingController(text: activeProduct.size);
  final TextEditingController heightController =
      TextEditingController(text: activeProduct.height.toString());
  final TextEditingController largeController =
      TextEditingController(text: activeProduct.large.toString());
  final TextEditingController widthController =
      TextEditingController(text: activeProduct.width.toString());
  final TextEditingController weightController =
      TextEditingController(text: activeProduct.weight.toString());
  final TextEditingController avaliableUnitsController =
      TextEditingController(text: activeProduct.avaliableUnits.toString());
  final TextEditingController priceController =
      TextEditingController(text: activeProduct.price.toString());

  bool canPush = false;

  bool isFreeShipping = activeProduct.isFreeShipping != null
      ? activeProduct.isFreeShipping
      : false;
  int _groupValue =
      activeProduct.isFreeShipping != null && activeProduct.isFreeShipping
          ? 0
          : 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        border: Border.symmetric(),
        //actionsForegroundColor: Palette.black,
        middle: Container(
          child: Text(
            activeProduct.productName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.black,
            ),
          ),
        ),
        backgroundColor: Palette.bgColor,
        trailing: GestureDetector(
          onTap: () {
            showMainActionAlert(context, '??Quieres eliminar este producto?', '',
                () {
              References.products.doc(activeProduct.id).delete();
              Navigator.of(context).pop();
            }, mainActionText: "Eliminar", isDestructiveAction: true);
          },
          child: Text('eliminar',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.red,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Text(
                          'Imagen del producto',
                          style: Styles.txtTitleLbl,
                        ),
                        SizedBox(height: 10.0),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.width / 2.5,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(activeProduct.imageUrl),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Ingresa un nombre',
                          controller: nameController,
                          onChanged: _canPush,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Nombre del producto',
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Ingresa una referencia',
                          onChanged: _canPush,
                          controller: refController,
                          validator: null,
                          title: 'Referencia',
                          optional: 'Opcional',
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder:
                              'Ingresa una breve descripci??n del producto',
                          onChanged: _canPush,
                          controller: textController,
                          maxLength: 150,
                          optional:
                              '${150 - textController.text.length} caracteres',
                          maxlines: 3,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Descripci??n',
                        ),
                        SizedBox(height: 60.0),
                        CumbiaTextField(
                          placeholder: 'Escribe el color del producto',
                          onChanged: _canPush,
                          controller: colorController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Color',
                        ),
                        SizedBox(height: 20.0),
                        CumbiaTextField(
                          placeholder: 'Describe el tama??o del producto',
                          onChanged: _canPush,
                          controller: sizeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, rellena este campo';
                            } else {
                              return null;
                            }
                          },
                          title: 'Tama??o',
                        ),
                        SizedBox(height: 60.0),

                        Text(
                          'Medidas',
                          style: Styles.txtTitleLbl,
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: CumbiaTextField(
                                placeholder: '0',
                                keyboardType: TextInputType.number,
                                onChanged: _canPush,
                                controller: heightController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo vacio';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Alto (cm)',
                                sizeLabeltext: 12.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: CumbiaTextField(
                                placeholder: '0',
                                keyboardType: TextInputType.number,
                                onChanged: _canPush,
                                controller: largeController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo vacio';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Largo (cm)',
                                sizeLabeltext: 12.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Expanded(
                              child: CumbiaTextField(
                                placeholder: '0',
                                keyboardType: TextInputType.number,
                                onChanged: _canPush,
                                controller: widthController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo vacio';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Ancho (cm)',
                                sizeLabeltext: 12.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: CumbiaTextField(
                                placeholder: '0',
                                keyboardType: TextInputType.number,
                                onChanged: _canPush,
                                controller: weightController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo vacio';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Peso (kg)',
                                sizeLabeltext: 12.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CumbiaTextField(
                                placeholder: '0',
                                keyboardType: TextInputType.number,
                                onChanged: _canPush,
                                controller: avaliableUnitsController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo vacio';
                                  } else {
                                    return null;
                                  }
                                },
                                title: 'Unidades disponibles',
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Palette.cumbiaGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 58,
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_drop_down,
                                                color: (avaliableUnits > 0)
                                                    ? Palette.cumbiaIconGrey
                                                    : Palette.cumbiaGrey),
                                            onPressed: () {
                                              setState(() {
                                                if (avaliableUnits > 0)
                                                  avaliableUnits--;
                                                avaliableUnitsController.text =
                                                    avaliableUnits.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 58,
                                        width: 2.0,
                                        color: Palette.cumbiaGrey,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 58,
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_drop_up,
                                                color: Palette.cumbiaIconGrey),
                                            onPressed: () {
                                              setState(() {
                                                avaliableUnits++;
                                                avaliableUnitsController.text =
                                                    avaliableUnits.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0),
                        activeProduct.isShipmentRequired
                            ? Text(
                                "Seleccione el env??o",
                                style: Styles.txtTitleLbl.copyWith(
                                    // color: isDark?Palette.b5Grey :labelTextColor,
                                    //fontSize: sizeLabeltext,
                                    ),
                              )
                            : Container(),
                        activeProduct.isShipmentRequired
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CumbiaRadioButton(
                                    title: "Env??o gratis",
                                    onChanged: (newValue) {
                                      _canPush(newValue.toString());
                                      setState(() {
                                        print(_groupValue);
                                        activeProduct.isFreeShipping = true;
                                        _groupValue = newValue;
                                        isFreeShipping = true;
                                      });
                                    },
                                    groupValue: _groupValue,
                                    value: 0,
                                  ),
                                  CumbiaRadioButton(
                                    title: "Env??o pago por el consumidor",
                                    onChanged: (newValue) {
                                      _canPush(newValue.toString());

                                      print(_groupValue);

                                      setState(() {
                                        activeProduct.isFreeShipping = false;

                                        _groupValue = newValue;
                                        isFreeShipping = false;
                                        print(_groupValue);
                                      });
                                    },
                                    groupValue: _groupValue,
                                    value: 1,
                                  )
                                ],
                              )
                            : Container(),
                        SizedBox(height: 60.0),
                        CumbiaTextField(
                          placeholder: '0',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              if (value != '') {
                                price = int.parse(value.trim());
                              }
                            });
                          },
                          controller: priceController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, ingresa un precio para este producto';
                            } else {
                              return null;
                            }
                          },
                          title: 'Precio (COP)',
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Comisi??n Cumbia live',
                              style: Styles.txtTitleLbl,
                            ),
                            Text('10%',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Precio final (COP)',
                              style: Styles.txtTitleLbl,
                            ),
                            Text('\$${(price).toInt().toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            // Text('\$${(price * 1.1).toInt().toString()}',
                            //     style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Text(
                        //           'Precio final (',
                        //           style: Styles.txtTitleLbl,
                        //         ),
                        //         Image(
                        //             image: AssetImage('images/emerald.png'),
                        //             height: 20.0),
                        //         Text(
                        //           ')',
                        //           style: Styles.txtTitleLbl,
                        //         ),
                        //       ],
                        //     ),
                        //     Text(
                        //       '\$${((price * 1.1) ~/ 100).toString()}',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 18.0,
                        //           color: Palette.cumbiaDark),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 30.0),
                        CumbiaButton(
                          title: 'Guardar cambios',
                          onPressed: () async {
                            if (canPush) {
                              showConfirmAlert(
                                context,
                                'Actualizando producto',
                                'El producto se actualiz?? exitosamente.',
                                () {
                                  updateData();
                                  Navigator.of(context).pop([
                                    nameController.text.trim(),
                                    textController.text.trim(),
                                    avaliableUnits
                                  ]);
                                },
                              );
                            }
                          },
                          canPush: true,
                          backgroundColor: Palette.cumbiaLight,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _canPush(String value) {
    setState(() {
      if (_formKey.currentState.validate()) {
        canPush = true;
      } else {
        canPush = false;
      }
    });
  }

  Future<void> updateData() async {
    Map<String, dynamic> variantMap = {
      'variantInfo': {
        'color': colorController.text.trim(),
        'size': sizeController.text.trim()
      },
      'productInfo': {
        'description': textController.text.trim(),
        'imageUrl': activeProduct.imageUrl,
        'productName': nameController.text.trim(),
        'reference': refController.text.trim(),
      },
      'especifications': {
        'height': double.parse(heightController.text.trim()),
        'large': double.parse(largeController.text.trim()),
        'weight': double.parse(weightController.text.trim()),
        'width': double.parse(widthController.text.trim()),
      },
      'avaliableUnits': int.parse(avaliableUnitsController.text.trim()),
      'price': int.parse(priceController.text.trim()),
      'isFreeShipping': isFreeShipping
    };

    print("??? ACTUALIZAR?? PRODUCT");
    References.products
        .doc(activeProduct.id.trim())
        .update(variantMap)
        .then((r) async {
      print("??? PRODUCT ACTUALIZADO");
    }).catchError((e) {
      print("???? ERROR AL ACTUALIZAR USER: $e");
    });
  }
}
