Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030836;
	b=gPavB7dlMjHEK/sDTbTFUtRf9yJuFvdmHd4w2vlbuo9IuGD3kTgBfVXyvT+wa53WJ3kn
	 yaNlD31Ld8xWTZDaVzJe33uidbY3lF4dykAQ8ZIjHtmfW7ryzSQxQteJ482B9Eff+IdIF
	 KfheIXGFGdkMD6550K7Is7EyqAU/UWZU/bbsEYuhysh7jJj2uiTAnYpCVFeyVhBNccIZz
	 +hW71oFIUJPo57bEVojVY1t7znq5OtbRP2JKQTiSg22HfivlC7kneYgDarUqCiXC3XD6O
	 Y8CuerIFCWVXc0SdczIBqk3E19FyWTwhvcjVuooPx5VVwHzq7l8pDEG7xANihyWbkng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rYnNBLNbrCGboeFjxh+F0qH3TnrbEqslyPJYVnSLs28=;
	b=J/0yyxHbcR6t5qJbWxgphb3KvP3pYWCHfMb3P8KB/EaTZNAvUjma1Z3oYqiWNGNn65Mw
	 zT+U14ymMiv4eC7sginy/vZflif4yi7tPKzIQOdk30DC/ZYh5TEP47SjA1eXbRl8nQnax
	 bToKh0GwSytWEyXHg9pd3CNKeeNp/+zkuHbH8brmm8ad1vPL3LXJoUNGHMX/ogDIyMq/8
	 eBfNTjc9TZoKZj8HUov0NrWDPPRqNGhBXeTazS5pdB4qCJJDKN8+ZK4opvdrlGQqoVxX9
	 4oxAsPPyyNYfpeEVuQweFAgBeIg0Aa7DxIeHLQ9ROcf5gVUF/fabc8kAORP70pebWpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ke3U5TlJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9D606C737
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ke3U5TlJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2BF1F000C4;
	Wed, 18 Nov 2026 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030836;
	bh=rYnNBLNbrCGboeFjxh+F0qH3TnrbEqslyPJYVnSLs28=;
	h=From:To:Cc:Subject:Date;
	b=ke3U5TlJHCyGMzndxiBD2C3EGfTeBBEQrhsy5586NVyUhI1bS/J9A27+2ThexbEhN
	 NCQw+hRZDVsDuHXTgqztE879d9obNGCeACNKT9e4lIQVE3Q3dXrPCSYd/7A1OK9+7s
	 oTol5LfYQXnqBGIXt/F68A7JyTk386trYOeDkYTlTmIvJdP5GdyeeBFR/3sDM9Lsoa
	 5PRWY2fB3npmpTMXsvUJBMcJA81R0sbzWdnCxywvE13VEklhYfyMlTKgDhTotx1tFl
	 toeDbePR5sg9VPs82vIZBespl2zKUFJCIzbT1igSiDuD1H+aotma6dz2zKuc7lzPwm
	 M1CrHKko18pfQ==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for LLVM 24 in text_mc
Date: Wed, 18 Nov 2026 19:40:30 +0000
Message-ID: <20261118194030.4103149-1-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PR #170968, “[AArch64] Treat NOP as a separate instruction” [1]
gave NOP its own instruction definition; LLVM 24 decodes
"1f 20 03 d5" as the opcode NOP. Earlier releases decode it
as HINT #0, which is what the arm64 table looks for. So the
test of the nop fails, text_arch_init() gives up and a kernel
with CONFIG_BPF_FMODRET_SCAN=y cannot be built:

  text_mc: LLVM 24.0.0git: 1f 20 03 d5 is NOP, length 4, nop 0 ...
      expected: nop 1 ...
  text_mc: LLVM 24.0.0git: the table of the arch does not fit it. ...
  FAILED: no decoder for the code of ELF machine 183

Add a pattern for NOP. An LLVM before this has no opcode of that name,
and a name which is missing is an error. So a pattern can now be
OPTIONAL: it is left out if this LLVM lacks the opcode. The pattern of
HINT #0 stays for the releases before, and the test shows that one of
the two matches.

With LLVM 24.0.0git the scan of an arm64 vmlinux finds no instruction
it cannot decode: 3385 of 65138 functions are tagged (the smaller
number of matches is due to CONFIG_KCSAN causing functions to be
marked as unsafe for fmod_ret).

[1] https://github.com/llvm/llvm-project/pull/170968

Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return errors")
Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tools/bpf/resolve_btfids/text_mc.cpp     | 2 ++
 tools/bpf/resolve_btfids/text_mc.h       | 6 ++++++
 tools/bpf/resolve_btfids/text_mc_arm64.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index 57f45a4bed6f..69668f8b12d7 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -195,6 +195,8 @@ bool read_opcodes()
 		auto it = by_name.find(pattern->opcode);
 
 		if (it == by_name.end()) {
+			if (pattern->optional)
+				continue;
 			error() << "no opcode " << pattern->opcode << "\n";
 			ok = false;
 		} else if (pattern->kind == TEXT_RETURN) {
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index f2add1f45f4f..574d4a94afa6 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -50,6 +50,11 @@ struct mc_predicate {
  * has, and DEFS.
  * With NOP the instruction is a nop if the first predicate holds.
  *
+ * An opcode which this LLVM does not have is an error, unless the pattern is
+ * OPTIONAL: then it is left out. That is for an opcode which LLVM split off
+ * from another one in some release, while the pattern of the old one stays
+ * for the releases before. The tests show that one of the two matches.
+ *
  * A pattern of kind TEXT_RETURN names a return to the caller. isReturn() holds
  * for a return from an exception as well, which does not hand the return value
  * register to a caller. Without such a pattern it is an opcode like any other,
@@ -71,6 +76,7 @@ struct mc_pattern {
 	s64 value;
 	u32 defs;		/* of TEXT_OTHER */
 	bool nop;		/* of TEXT_OTHER */
+	bool optional;		/* the opcode is missing in some LLVM releases */
 	struct mc_predicate predicates[2];
 };
 
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 5d2fa8a23a14..9cc41900fa4a 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -25,6 +25,8 @@ static const struct mc_pattern arm64_patterns[] = {
 	/* HINT: nop, bti, yield, wfe ... */
 	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
 	{ "HINT", TEXT_OTHER, .nop = true, .predicates = { IMM(0, 0) } },	/* nop */
+	/* LLVM 24 decodes nop as NOP, not as HINT #0 */
+	{ "NOP", TEXT_OTHER, .nop = true, .optional = true },
 	{ "DMB", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },
 	{ "STLRB", TEXT_OTHER }, { "STLRW", TEXT_OTHER },
 	WX("LDXR", "", TEXT_OTHER), WX("STXR", "", TEXT_OTHER), WX("STLXR", "", TEXT_OTHER),
-- 
2.56.0

