//
//  SupabaseManager.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//


import Foundation
import Supabase

@MainActor
final class SupabaseManager {
    
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        guard let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String else {
            fatalError("SUPABASE_KEY not found in Info.plist")
        }
        
        print("SUPABASE_KEY:", supabaseKey, "len:", supabaseKey.count)
        
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://epojjylthwzdduagqrob.supabase.co")!,
            supabaseKey: supabaseKey
        )
        
    }
    
    func currentUserId() async throws -> String {
        let user = try await client.auth.user()
        return user.id.uuidString
    }
    
    
    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(
            email: email,
            password: password
        )
    }
    
    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(
            email: email,
            password: password
        )
    }
    
    
    func checkUserIDDuplicate(_ userEmail: String) async throws -> Bool {
        let result: [UserInfoDup] = try await SupabaseManager.shared.client
            .from("users")
            .select("id")
            .eq("user_email", value: userEmail)
            .limit(1)
            .execute()
            .value
        return !result.isEmpty
    }
    
    // User Session Check
    func hasValidSession() async -> Bool {
        do {
            _ = try await client.auth.user()
            return true
        } catch {
            return false
        }
    }
    
    // logOut
    func logOut() async throws {
        try await client.auth.signOut()
    }
    
    // MARK: - Social LogIn
    
    enum SocialProvider {
        case apple
        var supabaseProvider: Provider { .apple }
    }
    
    private let oauthRedirectURL = URL(string: "gguk://auth-callback")!
    
    func startAppleOAuth() async throws {
        try await client.auth.signInWithOAuth(
            provider: .apple,
            redirectTo: oauthRedirectURL,
            queryParams: []
        )
    }
    
    
    
    
}
