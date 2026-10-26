Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983915;
	b=vJu+dAIQgeNxxKoDOWB13gb72fldNFUjYkI9T3W/buDekqBvaXQT56TzIS2rBML7tHLx
	 KhfQ/RoMvarChZ/p9OWwiflWP2NDFPRpsAuyb90hVjeD2/1fdjRrryalqlGP84IpmuBCw
	 wcg66poCDUiLpVhPYlfj43OOQ6QVRm3f0xB5UH5dE/6JklgUYRqVniCPIxEHb1peLUryl
	 E4RWVWi0S9lB40xjyq6qfPK9mJuW4qHGkWPdEnB/IHDiE4gBXpDjgkwOK8h8Z+XIa7w1c
	 BCeprujbJcHjrXk+OeImB3iReFv5KfnTK/tyZTNOAdVfKnhbxOqmhnfSmTMgui1Pn4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+3IzL2zgK2XfnJonQIiZ2E1J7rS+tEb+mhztSnddzRw=;
	b=mOPhnI75zAsnoz9ccUTQwarVOd9Ktbmzf86FwWB9GB+85sFEcOKFCiU9ignioCXiwwUU
	 jOvblwhBvs0lYzxiINpNjNPyVNY5WZXgUjZOaGiiGI8GidJPcDuqgrmWKRWJbtoLVKmb5
	 pNlEWS0zpUFz1UikYd56FGVdSRJgx8wa/i9YIG5rmDYCT3rkVWkbH4SX7A7wFoUsVLQ3i
	 bZiBHrCP/anF9wjkCiZQt7dpNCk9Epn24Kt4sMNTHaUc+m1pHJsNqPGE3K2t/9koDdVTl
	 oqNzQowYrpuunD/wf25qRvFCOq68PYece+8lD8fSl3uBzqE696MgbL5eU3lwa8AWKcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XwDoRyHX;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA9606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75BA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XwDoRyHX
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1839102a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983915; x=1793588715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3IzL2zgK2XfnJonQIiZ2E1J7rS+tEb+mhztSnddzRw=;
        b=XwDoRyHXytu90nhZd+O21NZTYELbd4+kvxL7y8g80x0NLQ013+2b4/qXPW3o5qLtOn
         xkcxkNXDnI7AVno8bdYxGESRLrltLxxrMkzsrzZ3MFXystxB5zGhg4bZXVleCJjZb/eW
         ig2BZwg/1G3oUgAMihL1lM+TeWSuRt8vJSGeyZ4/09lBcV9+PKCuhABX5ZcCbP0+VYB5
         LuQFu75hXIK1aBTtwF/GKqSc+1aNgccNv7kYGYLaKaxT4V+PzaGfjepGsRIo9I+fbDbo
         0wWb+/UF4W1rV0eKTxR8Lfh/Q+FEmtshNP5lqLnpqtPwrRjrolzuG7kWIHQRWeqmNvZI
         utNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983915; x=1793588715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+3IzL2zgK2XfnJonQIiZ2E1J7rS+tEb+mhztSnddzRw=;
        b=jJKxYILdEhSakU4eMOUkmshPE08DsZSlJZ1+84XLWK/7d5SNTsyvd5OGFN4QLyQvQ8
         xIKmkrqs482uTgeSXVaWUQPFoDSKizWRVEBGPm+vymbsCYN5WqRLY6kGCVBf3hKhAbms
         g08GyjDpcZM04Z+VrEMPn3EwzlsxMouocQ/1OenwgO+74fk8kyHYp8XWxzSwvzN+PMUH
         PCLEupfoj/6sE5DpIMuaaojyy6uADLY4lmZpeVBWFtfvi7e0FXKsnM3kv2/o8Bl+laI0
         8YWPf7vtFWC9izrYnPmyNf/C7nAxI8pKLRKnOYwfBVZ6ldsJ/v0442bF2ME+wg3GtVm8
         izWg==
X-Gm-Message-State: AFq9FYJcgzX7fYJiRUS5z+5FYRDml/xWEuVgjptVl3brhlobCRVCC+Fd
	YvxdUad5mdvpQHR8GEIwX1T01W6F+BoSO7uoMnX2s9BtZxyMkkseuKXA9okKsg==
X-Gm-Gg: AYBFou1YgE1fZplqghiMsdy1pe2Vsk0m4KbxS5Io5C9yyORzjVZDRiMTzKRvzpQQEUj
	R7ciWDnbnpgOgFfIgudg7kGeuK4mfiCYkueeo9Xo6w2Em8fPsk0jgUV3pTyo78II8t/x6MrJ5Ow
	m3u7f6a5N0SjgUr3zvpeZzp1NIMPmbB0UM068nDsFF7QJn98RMk/AQ7L5GtkIbiSyFt+AIhH4BV
	+vZR7mhSLANGP7mtd0CJHoKhD6X+4pxVXa9MA1mPkY0mvp7Y853G13zJOTRzBKeCnusQkN/cWpq
	D0yAgGSVlSM6XPNiJLWYX1NcXKDyeRExM/TCQLTk6ZPRPQgWBuo6d8T1hSDWEJy0uxdflKlviTh
	KI9LJU/YjOmoUx7Hknu7WeqZ0iHyu+Gr+Bv+ZNf4fAliU02g5vH0ByuKtLJaBxLrIT02Ym5bQwE
	q0OW1YfyQzpVGtwa6d/jNtC6Y0zDTvQFlsOfuhWup/3XdVMsla76L0FBuaZYGAMzFqWlb13KMAJ
	wlVSomdpAxNG1yE+rUICBJJ/u8+jLnO+ArjKzUmEWwxtUSITYYaPjd06CrPNxJZLqu1QGMAHbnY
	1JcsxNGGUcDiQ3G3L74RzRF+jRamDflkZWVDPpzt0ypvI4v8o8CiwmW28r86HK6BbDc1ZewcyH2
	a3LGZtFBmo+nDWeskfcQqqrEY
X-Received: by 2002:a17:90b:6c7:b0:3a8:bbc2:5551 with SMTP id 98e67ed59e1d1-3ade94716e6mr4520772a91.0.1792983914548;
        Sun, 25 Oct 2026 20:05:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm6197935a91.9.2026.10.25.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 56/81] bpf: Bump MAX_CALL_FRAMES to 32
Date: Mon, 26 Oct 2026 02:59:17 +0000
Message-ID: <20261026025943.404450-57-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Progs that use Rust crates nest calls deeply and hit the limit of
16 frames. Bump the limit to 32.

A frame number now needs 5 bits. Widen it in bpf_jmp_history_entry and in
the packed linked registers. There the index of a register or a stack slot
loses one bit. The static_assert next to it shows that the index fits.
Widen the mask of frames in liveness.c to 32 bits.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 8 ++++----
 kernel/bpf/liveness.c        | 4 ++--
 kernel/bpf/verifier.c        | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c0227e74899b..6139e889c86a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -458,7 +458,7 @@ struct bpf_func_state {
 	struct loop_stack_entry *loop_stack;
 };
 
-#define MAX_CALL_FRAMES 16
+#define MAX_CALL_FRAMES 32
 
 /* instruction history flags, used in bpf_jmp_history_entry.flags field.
  * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.
@@ -478,10 +478,10 @@ enum {
 struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
-	u32 frame : 4;	/* stack access frame number */
+	u32 frame : 5;	/* stack access frame number */
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 4;
+	u32 : 3;
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
@@ -495,7 +495,7 @@ struct bpf_jmp_history_entry {
 	u8 linked_regs_cnt;
 };
 
-static_assert(MAX_CALL_FRAMES <= (1 << 4));
+static_assert(MAX_CALL_FRAMES <= (1 << 5));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 985cd39acf3e..8c7629c99400 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -814,7 +814,7 @@ static int print_instances(struct bpf_verifier_env *env)
 struct arg_track {
 	union {
 		s16 off[MAX_ARG_OFFSETS]; /* byte offsets; off_cnt says how many */
-		u16 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
+		u32 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
 	};
 	s8 frame;	/* absolute frame index, or enum arg_track_state */
 	s8 off_cnt;	/* 0 = offset-imprecise, 1-4 = # of precise offsets */
@@ -1175,7 +1175,7 @@ static struct arg_track fill_from_stack(struct bpf_insn *insn,
 					int depth)
 {
 	struct arg_track imp = {
-		.mask = (1u << (depth + 1)) - 1,
+		.mask = GENMASK(depth, 0),
 		.frame = ARG_IMPRECISE
 	};
 	struct arg_track result = { .frame = ARG_NONE };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50e24237a6b7..e55ba1db2e1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3654,8 +3654,8 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
 }
 
 /* Layout of one packed linked register in the jump history, see linked_regs_pack() */
-#define LR_FRAMENO_BITS	4
-#define LR_INDEX_BITS	11
+#define LR_FRAMENO_BITS	5
+#define LR_INDEX_BITS	10
 #define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
 #define LR_IS_REG	BIT(LR_FRAMENO_BITS)
 #define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)
-- 
2.55.0

