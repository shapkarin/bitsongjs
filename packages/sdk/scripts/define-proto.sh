#!/bin/bash
set -o errexit -o nounset -o pipefail
command -v shellcheck >/dev/null && shellcheck "$0"

ROOT_PROTO_DIR="./proto/cosmos/cosmos-sdk"
COSMOS_PROTO_DIR="$ROOT_PROTO_DIR/proto"
THIRD_PARTY_PROTO_DIR="$ROOT_PROTO_DIR/third_party/proto"

ROOT_BITSONG_PROTO_DIR="./proto/bitsong/chainmodules"
BITSONG_PROTO_DIR="$ROOT_BITSONG_PROTO_DIR/proto"

ROOT_LIQUIDITY_PROTO_DIR="./proto/liquidity/liquidity"
LIQUIDITY_PROTO_DIR="$ROOT_LIQUIDITY_PROTO_DIR/proto"
THIRD_PARTY_LIQUIDITY_PROTO_DIR="$ROOT_LIQUIDITY_PROTO_DIR/third_party/proto"

OUT_DIR="./src/codec/"

mkdir -p "$OUT_DIR"

protoc \
    --plugin="$(yarn bin protoc-gen-ts_proto)" \
    --ts_proto_out="$OUT_DIR" \
    --proto_path="$COSMOS_PROTO_DIR" \
    --proto_path="$THIRD_PARTY_PROTO_DIR" \
    --proto_path="$THIRD_PARTY_LIQUIDITY_PROTO_DIR" \
    --proto_path="$BITSONG_PROTO_DIR" \
    --ts_proto_opt="esModuleInterop=true,forceLong=long,useOptionals=true" \
    "$COSMOS_PROTO_DIR/cosmos/auth/v1beta1/auth.proto" \
    "$COSMOS_PROTO_DIR/cosmos/auth/v1beta1/query.proto" \
    "$COSMOS_PROTO_DIR/cosmos/bank/v1beta1/bank.proto" \
    "$COSMOS_PROTO_DIR/cosmos/bank/v1beta1/query.proto" \
    "$COSMOS_PROTO_DIR/cosmos/bank/v1beta1/tx.proto" \
    "$COSMOS_PROTO_DIR/cosmos/base/abci/v1beta1/abci.proto" \
    "$COSMOS_PROTO_DIR/cosmos/base/query/v1beta1/pagination.proto" \
    "$COSMOS_PROTO_DIR/cosmos/base/v1beta1/coin.proto" \
    "$COSMOS_PROTO_DIR/cosmos/crypto/multisig/v1beta1/multisig.proto" \
    "$COSMOS_PROTO_DIR/cosmos/crypto/secp256k1/keys.proto" \
    "$COSMOS_PROTO_DIR/cosmos/distribution/v1beta1/distribution.proto" \
    "$COSMOS_PROTO_DIR/cosmos/distribution/v1beta1/query.proto" \
    "$COSMOS_PROTO_DIR/cosmos/distribution/v1beta1/tx.proto" \
    "$COSMOS_PROTO_DIR/cosmos/staking/v1beta1/query.proto" \
    "$COSMOS_PROTO_DIR/cosmos/staking/v1beta1/staking.proto" \
    "$COSMOS_PROTO_DIR/cosmos/staking/v1beta1/tx.proto" \
    "$COSMOS_PROTO_DIR/cosmos/gov/v1beta1/query.proto" \
    "$COSMOS_PROTO_DIR/cosmos/gov/v1beta1/gov.proto" \
    "$COSMOS_PROTO_DIR/cosmos/gov/v1beta1/tx.proto" \
    "$COSMOS_PROTO_DIR/cosmos/tx/signing/v1beta1/signing.proto" \
    "$COSMOS_PROTO_DIR/cosmos/tx/v1beta1/tx.proto" \
    "$COSMOS_PROTO_DIR/cosmos/vesting/v1beta1/vesting.proto" \
    "$COSMOS_PROTO_DIR/ibc/applications/transfer/v1/tx.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/channel/v1/channel.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/channel/v1/query.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/channel/v1/tx.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/client/v1/client.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/client/v1/query.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/client/v1/tx.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/commitment/v1/commitment.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/connection/v1/connection.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/connection/v1/query.proto" \
    "$COSMOS_PROTO_DIR/ibc/core/connection/v1/tx.proto" \
    "$COSMOS_PROTO_DIR/ibc/lightclients/tendermint/v1/tendermint.proto" \
    "$THIRD_PARTY_PROTO_DIR/confio/proofs.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/abci/types.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/crypto/keys.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/crypto/proof.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/libs/bits/types.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/types/params.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/types/types.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/types/validator.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/version/types.proto" \
    "$THIRD_PARTY_PROTO_DIR/tendermint/version/types.proto" \
    "$BITSONG_PROTO_DIR/fantoken/fantoken.proto" \
    "$BITSONG_PROTO_DIR/fantoken/query.proto" \
    "$BITSONG_PROTO_DIR/fantoken/tx.proto"

protoc \
    --plugin="$(yarn bin protoc-gen-ts_proto)" \
    --ts_proto_out="$OUT_DIR" \
    --proto_path="$LIQUIDITY_PROTO_DIR" \
    --proto_path="$THIRD_PARTY_LIQUIDITY_PROTO_DIR" \
    --ts_proto_opt="esModuleInterop=true,forceLong=long,useOptionals=true" \
    "$LIQUIDITY_PROTO_DIR/tendermint/liquidity/v1beta1/liquidity.proto" \
    "$LIQUIDITY_PROTO_DIR/tendermint/liquidity/v1beta1/tx.proto" \
    "$LIQUIDITY_PROTO_DIR/tendermint/liquidity/v1beta1/query.proto"


# Remove unnecessary codec files (TODO: IMPROVE!)
rm -rf \
    src/codec/gogoproto/ \
    src/codec/google/api/ \
    src/codec/google/protobuf/descriptor.ts
#src/codec/cosmos_proto/ \
