import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/field.dart';
import '../../../core/widgets/main_button.dart';
import '../bloc/site_bloc.dart';
import '../models/site.dart';

class AddSiteScreen extends StatefulWidget {
  const AddSiteScreen({super.key});

  static const routePath = '/AddSiteScreen';

  @override
  State<AddSiteScreen> createState() => _AddSiteScreenState();
}

class _AddSiteScreenState extends State<AddSiteScreen> {
  final titleController = TextEditingController();
  final urlController = TextEditingController();

  bool active = false;

  void onChanged(String _) {
    setState(() {
      active = [
        titleController,
        urlController,
      ].every((element) => element.text.isNotEmpty);
    });
  }

  void onAdd() {
    final site = Site(
      title: titleController.text,
      url: urlController.text,
    );
    context.read<SiteBloc>().add(AddSite(site: site));
  }

  @override
  void dispose() {
    titleController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: 'Add site'),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding).copyWith(
          bottom: Constants.padding + MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Column(
          children: [
            Field(
              controller: titleController,
              hintText: 'Title',
              onChanged: onChanged,
            ),
            const SizedBox(height: Constants.padding),
            Field(
              controller: urlController,
              hintText: 'Url',
              fieldType: FieldType.url,
              onChanged: onChanged,
            ),
            const Spacer(),
            BlocConsumer<SiteBloc, SiteState>(
              listener: (context, state) {
                if (state is SitesLoaded) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return MainButton(
                  title: 'Add',
                  active: active,
                  loading: state is SitesLoading,
                  onPressed: onAdd,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
