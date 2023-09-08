use dep::std;
use dep::array_helpers;


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
    
}

#[test]
fn test_main() {


}
