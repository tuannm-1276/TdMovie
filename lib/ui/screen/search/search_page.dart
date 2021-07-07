import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/ui/components/common/bottom_loader.dart';
import 'package:td_movie/ui/components/common/loading_widget.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key key,
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.searchFieldDecorationTheme,
    this.textInputAction = TextInputAction.search,
    this.keyboardType,
  }) : super(key: key);

  final String searchFieldLabel;
  final TextStyle searchFieldStyle;
  final InputDecorationTheme searchFieldDecorationTheme;

  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  Animation<double> get transitionAnimation => proxyAnimation;
  final ProxyAnimation proxyAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final _scrollController = ScrollController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onQueryChanged);
    _scrollController.addListener(_onScroll);
    _searchBloc = context.read();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.removeListener(_onQueryChanged);
    _scrollController.removeListener(_onScroll);
    _searchBloc.close();
  }

  void _onQueryChanged() {
    _searchBloc.add(TextChangedEvent(query: _textEditingController.text));
  }

  void _onScroll() {
    if (_isBottom)
      _searchBloc.add(SearchLoadMoreEvent(query: _textEditingController.text));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  ThemeData _appBarTheme() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: widget.searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle:
                widget.searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = _appBarTheme();
    String routeName = '';
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        routeName = widget.searchFieldLabel;
    }

    return Semantics(
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      label: routeName,
      child: Theme(
        data: theme,
        child: Scaffold(
          appBar: AppBar(
            leading: _buildLeading(),
            title: TextField(
              controller: _textEditingController,
              style: theme.textTheme.headline6,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              onChanged: (query) {
                _searchBloc.add(TextChangedEvent(query: query));
              },
              onSubmitted: (query) {
                _searchBloc.add(TextChangedEvent(query: query));
              },
              decoration: InputDecoration(hintText: widget.searchFieldLabel),
            ),
            actions: _buildActions(),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildBody(),
          ),
          // body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: _close,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: _searchBloc,
      builder: (context, state) {
        return state.switchResult(
          onSearchLoadSuccess: (successState) {
            final width = (MediaQuery.of(context).size.width / 2) - 16;
            return Column(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  itemCount: successState.movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: width * 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: MovieItem(
                          movie: successState.movies[index],
                        ),
                      ),
                      onTap: () => navigateToDetail(successState.movies[index]),
                    );
                  },
                ),
                Visibility(
                  visible: successState.isEndReached,
                  child: BottomLoader(),
                ),
              ],
            );
          },
          onSearchEmptyState: (emptyState) => Container(
            child: Center(
              child: Text('Empty'),
            ),
          ),
          onSearchLoadInProgress: (loadingState) => LoadingWidget(message: ''),
          onSearchLoadFailure: (errorState) =>
              Text(errorState.error.toString()),
        );
      },
    );
  }

  List<Widget> _buildActions() {
    return _textEditingController.text.isEmpty
        ? []
        : [
            IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                _textEditingController.text = '';
              },
            )
          ];
  }
}
