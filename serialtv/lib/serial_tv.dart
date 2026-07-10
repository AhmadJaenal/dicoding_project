// Data
export 'data/datasources/serial_remote_data_source.dart';
export 'data/datasources/serial_local_data_source.dart';

export 'data/models/serial_tv_model.dart';
export 'data/models/serial_table.dart';

export 'data/repositories/serial_tv_repository_impl.dart';

// Domain
export 'domain/entities/serial_tv.dart';

export 'domain/repositories/serial_tv_repository.dart';

export 'domain/usecases/get_serial_tv.dart';
export 'domain/usecases/get_serial_tv_playing_now.dart';
export 'domain/usecases/get_serial_tv_recommedations.dart';
export 'domain/usecases/get_serial_tv_top_rated.dart';
export 'domain/usecases/get_watchlist_serial_tv.dart';
export 'domain/usecases/get_watchlist_status_serial_tv.dart';
export 'domain/usecases/remove_watchlist_serial_tv.dart';
export 'domain/usecases/get_serial_tv_detail.dart';
export 'domain/usecases/save_watchlist_serial_tv.dart';

// Presentation - Bloc
export 'presentation/bloc/get_serial_detail/get_detail_serial_bloc.dart';

export 'presentation/bloc/get_serial_playing_now/get_serial_playing_now_bloc.dart';

export 'presentation/bloc/get_serial_recommend/get_serial_recommendation_bloc.dart';

export 'presentation/bloc/get_serial_top_rated/get_serial_top_rated_bloc.dart';

export 'presentation/bloc/get_serial_tv_popular/get_serial_tv_popular_bloc.dart';

export 'presentation/bloc/watchlist/watchlist_bloc.dart';

// Presentation - Pages
export 'presentation/pages/serial_tv_page.dart';
export 'presentation/pages/serial_tv_playing_now_page.dart';
export 'presentation/pages/serial_tv_top_rated_page.dart';
export 'presentation/pages/serial_tv_detail_page.dart';

// Presentation - Widgets
export 'presentation/widgets/serial_tv_card_list.dart';
