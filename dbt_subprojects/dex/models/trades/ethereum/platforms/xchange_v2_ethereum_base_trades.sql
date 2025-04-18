{{
    config(
        schema = 'xchange_v2_ethereum',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'ethereum',
        project = 'xchange',
        version = '2',
        Pair_evt_Swap = source('xchange_v2_ethereum', 'XchangePair_evt_Swap'),
        Factory_evt_PairCreated = source('xchange_v2_ethereum', 'XchangeFactory_evt_PairCreated')
    )
}}
