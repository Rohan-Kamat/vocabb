import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabb/models/poolModel.dart';
import 'package:vocabb/models/wordModel.dart';
import 'package:vocabb/pages/poolPage.dart';
import 'package:vocabb/providers/loadingProvider.dart';
import 'package:vocabb/services/dbServices.dart';
import 'package:vocabb/widgets/appBarWidget.dart';

class CreatePoolPage extends StatelessWidget {
  CreatePoolPage({super.key});

  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _createPool(BuildContext context) async {
    if (_poolNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pool name cannot be Empty", style: TextStyle(
            color: Colors.white
          )),
          backgroundColor: Colors.red,
        )
      );
    } else {
      LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.setLoading(true);
      PoolModel? newPool = await PoolModel.createNewPool(
          _poolNameController.text,
          _descriptionController.text,
          null
      );
      loadingProvider.setLoading(false);
      if (newPool != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Pool created", style: TextStyle(
                color: Colors.white
              )),
            backgroundColor: Colors.green,
          )
        );
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => PoolPage(
          poolModel: newPool,
        )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error creating pool. Please try again", style: TextStyle(
                  color: Colors.green
              )),
              backgroundColor: Colors.red,
            )
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: AppBarWidget(
            leadingIcon: Icons.chevron_left,
            action: () {
              Navigator.pop(context);
            },
          ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create New Pool", style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),
              const SizedBox(height: 20),
              Text("Pool name", style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary
              )),
              TextField(
                controller: _poolNameController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                      ),
                    ),
                    hintText: "Enter pool name",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                    )
                ),
              ),
              const SizedBox(height: 30,),
              Text("Description", style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary
              )),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a description"
                ),
                maxLines: 10, // You can use 'null' to make it expand dynamically
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    print("Creating pool");
                    _createPool(context);
                  },
                  child: Consumer<LoadingProvider>(
                    builder: (context, provider, _) {
                      return provider.isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Theme
                                .of(context)
                                .primaryColor,
                          )
                        : const Text("Create", style: TextStyle(
                            fontSize: 18
                        ));
                    }
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
