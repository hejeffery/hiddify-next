import 'package:flutter/material.dart';
import 'package:hiddify/domain/singbox/singbox.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProxyTile extends HookConsumerWidget {
  const ProxyTile(
    this.proxy, {
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final OutboundGroupItem proxy;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        sanitizedTag(proxy.tag),
        overflow: TextOverflow.ellipsis,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          width: 6,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: selected ? theme.colorScheme.primary : Colors.transparent,
          ),
        ),
      ),
      subtitle: Text.rich(
        TextSpan(
          text: proxy.type.label,
          children: [
            if (proxy.selectedTag != null)
              TextSpan(
                text: ' (${sanitizedTag(proxy.selectedTag!)})',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: proxy.urlTestDelay != 0
          ? Text(
              proxy.urlTestDelay.toString(),
              style: TextStyle(color: delayColor(context, proxy.urlTestDelay)),
            )
          : null,
      selected: selected,
      onTap: onSelect,
      horizontalTitleGap: 4,
    );
  }

  Color delayColor(BuildContext context, int delay) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return switch (delay) {
        < 800 => Colors.lightGreen,
        < 1500 => Colors.orange,
        _ => Colors.redAccent
      };
    }
    return switch (delay) {
      < 800 => Colors.green,
      < 1500 => Colors.deepOrangeAccent,
      _ => Colors.red
    };
  }
}
