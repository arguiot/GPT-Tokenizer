import XCTest
@testable import GPT_Tokenizer

struct EncodingSampleDataset: Decodable {
    let text: String
    let encoded_text: [String]
    let bpe_tokens: [String]
    let token_ids: [Int]
}

struct EncodingSample {
    static let dataset: EncodingSampleDataset = {
        let url = Bundle.module.url(forResource: "encoded_tokens", withExtension: "json")!
        let json = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let dataset = try! decoder.decode(EncodingSampleDataset.self, from: json)
        return dataset
    }()
}

final class GPT_TokenizerTests: XCTestCase {
    func testByteEncode() {
        let dataset = EncodingSample.dataset
        
        let tokenizer = GPT_Tokenizer()
        XCTAssertEqual(
            tokenizer.byteEncode(text: dataset.text),
            dataset.encoded_text
        )
    }
    
    func testTokenize() {
        let dataset = EncodingSample.dataset
        
        let tokenizer = GPT_Tokenizer()
        XCTAssertEqual(
            tokenizer.tokenize(text: dataset.text),
            dataset.bpe_tokens
        )
    }
    
    func testEncode() {
        let dataset = EncodingSample.dataset
        
        let tokenizer = GPT_Tokenizer()
        XCTAssertEqual(
            tokenizer.encode(text: dataset.text),
            dataset.token_ids
        )
    }
    
    func testDecode() {
        let dataset = EncodingSample.dataset
        
        let tokenizer = GPT_Tokenizer()
        print(
            tokenizer.decode(tokens: dataset.token_ids)
        )
        XCTAssertEqual(
            tokenizer.decode(tokens: dataset.token_ids),
            dataset.text
        )
    }
}
