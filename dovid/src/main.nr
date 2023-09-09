use dep::std;
use dep::ecrecover;

fn main(tree_root: pub Field,
        message_hash: pub [u8; 32],
        signature: [u8; 64],
        tree_path: [Field; 1],
        tree_index: Field,
        pub_key_x: [u8; 32],
        pub_key_y: [u8; 32],
        ) {

    // 1 - verify ECDSA signature & get the address from pub key
    let address = ecrecover::ecrecover(pub_key_x, pub_key_y, signature, message_hash);
    // 2 - get the hash of the address
    let address_hash = std::hash::poseidon::bn254::hash_1([address]);
    // 3 - compute the Merkle root & check if the account is in the Merkle Tree
    // *Noir has already implemented compute_merkle_root, but it uses the Pedersen hashes
    let root = compute_merkle_root(address_hash, tree_index, tree_path);
    // 4 - check that retrieved root is equal to publicly known one 
    assert(root == tree_root);
}

fn compute_merkle_root<N>(leaf: Field, index: Field, hash_path: [Field; N]) -> Field {
    let n = hash_path.len();
    let index_bits = index.to_le_bits(n as u32);
    let mut current = leaf;
    for i in 0..n {
        let path_bit = index_bits[i] as bool;
        let (hash_left, hash_right) = if path_bit {
            (hash_path[i], current)
         } else {
            (current, hash_path[i])
         };

      current = std::hash::poseidon::bn254::hash_2([hash_left, hash_right]);
    };
    current
}

#[test]
fn test_main() {


}
