Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B53793D0
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563530; cv=none; b=hWFCrOoojMhoUWi+vj5sRJDYaWQVouaMBt49Ea36bjhtyMGkwV/BoU+/J7bOvRd1j+suxf07t4xdJR5uUGAfEa2Sq2M3m6zcWrrV7woeC4eBSk5uSc9e5LLXUlguORrESMTsw4sWrMSHQUuSgNxkSlSg5SMkCjCF+9H9K3anWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563530; c=relaxed/simple;
	bh=Dwd9QnD9rSQ6RC6ptgKSbVSViULIlXeT/HerutUw6i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBIqbNbHIxvsGMgnuyWsMIRHFiCRmlaMBrVgWDbM7ZcF1pMmwr4hQhjrgOwVawb45c3ItdAPrnxqHvMA+2usyCAczNq0c5F+alimnqqjKIkJEtp/UF5zSZaQpPPKl9qCT+pL378gLkpo4SSgT43E+0Nfv4LLcYS09ShW8p6oVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBUwSpMa; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBUwSpMa"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso4463275e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563527; x=1787168327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1xNTEMoZNsbCW0f/gzo0teYaCedt460RPF1L8LLPd8=;
        b=QBUwSpMa8S5UZJ9l+or23cmDIps/a4dMoostLlsIpeIttUrvld+NtxoDjpPLjL/WWi
         EeFca0IDbHQZC3Nmw7WM49wBFwvjklohBKd3QHzQMdl3u4AoCypQm4Wc+Rl/smGmBrzN
         k5jhtZHhY/+kBz4WgHfgNiyUw7SZIk+NJOFhD43QgkA7i3lOEaVDOSIxxOgYLwePwZ53
         K87C6/iF8G1z3XJOoEzaXNO278f6O+oKF4qGSICTg0ESMyU+0gk/2QMgNYkiCYtBiokD
         g2X5j5sBmOG/VqrF5axFau53hcLwofiqE5H9myeAog9+iSLLJ7q99lxBMbfx9NkrmWYS
         iF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563527; x=1787168327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1xNTEMoZNsbCW0f/gzo0teYaCedt460RPF1L8LLPd8=;
        b=Eb1GzDTYB7Y/c2PVREpY0txVxcG5CY/lPQiUdTygFt/Iiczx4+w5RFiJEw6gSk5EPr
         2aryAYvnFhw3Z7DnEKvOzoMkBGAVYUB6sL1HMEQufqwa/3iiCillahuZ+Zk4rMolqLui
         aTpkEEoWMErhNX2Rot0M8SPnAOilQSwW/bnW/qaOgHwMaYpU6m2z7IUFGH5UkO9cfvzq
         l1ObuxnbHJ0UYLqIXkgmknfzZMW7SrvVLlIxp/fqMlhNrjJD9CEF1PrVQgl4LvxAJ2wB
         iOwxNBXnabatkkqO1FybfuTSoUM2tFqBp2w6sh1ng1ClkAOFWCnYUAUkSLW4e7/m78Tb
         aU5A==
X-Gm-Message-State: AOJu0YwphV0TBx9bbt2masd5LYokfNNhllfzrdC92zH8XHPJ731HIZ4Q
	2/AoffWkoZd0nt+C9+e6O1XnRbD1dCx6SerTeAcsuxFHyavcdjo/5kLwIcmKa0Nw
X-Gm-Gg: AR+sD13EviGigFYkv6hZtXaXEL+7QNRZkxCEY808pT27cYRS3k96crxHlpw0VSrqKXN
	dQm1+ARVD6epp5lXBzgN0Oc8F2PZ6+DOG+uQ4A+evUS1nyuUMgzmIU25zpeE6+LximSBbmfQ6lz
	cQ9NgUVIbzspuckWnY/ZQnTQWlsM7TJQU7ONaCNTPwyujEVTl3i9zpF0P8kEiM6Q8BA+2YRuoZw
	yZSuxFEeUJQ6Fa3gjTdeye/iElBFQgXtYDuttWw9/8J4urKU6MI6n4w+jY3oVH+MbQVUTDncR5a
	SgIn1uc3+H+WuhjlPYVnS5FGXGlVjRdGyIhlFFg6glcEfEMLfAYbRc4BQS/S8VWsAkaUInCfhvJ
	W5d7IeRleWktouR/20leKI55wOXU3hfl8cs7pjC7m+32EHPUKzdRuXmXk4V5kt71IXkhu0OOKMf
	+MxYKS+4o8umxkNyeV7EAHhFNORzbifd9o1xaLBM5PQ5s4NEN1WJOFBlJRoFQ77D1sPnYebfwKv
	3OrKzup7PS9KEHt1GGF7RuUA5brjDTHzY6ogjS02cIjly39m39o1h5d+rRuKT9Jqn6nQmP1x4NS
	x6plAbGkok+v08uFePReMeL+D/A=
X-Received: by 2002:a05:600c:4f87:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-499821cf33bmr377145e9.7.1786563526942;
        Wed, 12 Aug 2026 12:38:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820c2897sm4953415e9.0.2026.08.12.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:38:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test resolve_btfids arena argument suffixes
Date: Wed, 12 Aug 2026 21:38:41 +0200
Message-ID: <20260812193842.2879226-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812193842.2879226-1-memxor@gmail.com>
References: <20260812193842.2879226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; i=memxor@gmail.com; h=from:subject; bh=Dwd9QnD9rSQ6RC6ptgKSbVSViULIlXeT/HerutUw6i0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmtFJCl0vTtExJvVlnlPktK6z++5uJr5ese77w35/FS VsL2jg6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJEGX4b/YcbLdvIvKPwU52Ew /17jb6aLH69Ff9269nL315+zD15u1WH471U/39vlUMfUWufzOstuKHzrVtt8bwd37Zfyd2t2i02 7yQ0A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a suffix-only kfunc declaration with arena annotations on all five
arguments. Verify that resolve_btfids emits address_space(1) type tags
for every position without KF_ARENA_ARG flags in the BTF ID sets.

Represent expected arena arguments as a per-parameter bitmap so the
test covers suffixes beyond the two positions expressible by flags.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 41 +++++++++++--------
 tools/testing/selftests/bpf/progs/btf_data.c  | 20 +++++++++
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 732cfed35e1c..3f9949e8227d 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -15,6 +15,7 @@
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
 #define TYPE_ATTR_ARENA "address_space(1)"
+#define ARENA_ARG(n) (1U << (n))
 
 #ifndef KF_FASTCALL
 #define KF_FASTCALL (1 << 12)
@@ -49,13 +50,20 @@ struct kfunc_symbol {
 	const char	*name;
 	s32		 id;
 	u32		 flags;
+	u32		 arena_args;
+	bool		 arena_ret;
 };
 
 static struct kfunc_symbol kfunc_symbols[] = {
-	{ "kfunc_a", -1, 0 },
-	{ "kfunc_b", -1, KF_FASTCALL },
-	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
-	{ "kfunc_d", -1, KF_ARENA_ARG2 },
+	{ "kfunc_a", -1, 0, 0, false },
+	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
+	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
+	  ARENA_ARG(0) | ARENA_ARG(1), true },
+	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
+	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
+	  ARENA_ARG(3) | ARENA_ARG(4), false },
+	{ "kfunc_f", -1, 0, ARENA_ARG(1), false },
+	{ "kfunc_g", -1, KF_ARENA_RET, ARENA_ARG(0) | ARENA_ARG(1), true },
 };
 
 /* Align the .BTF_ids section to 4 bytes */
@@ -105,6 +113,9 @@ BTF_ID_FLAGS(func, kfunc_a)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
 BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_e)
+BTF_ID_FLAGS(func, kfunc_f)
+BTF_ID_FLAGS(func, kfunc_g, KF_ARENA_RET)
 BTF_KFUNCS_END(test_kfunc_set)
 
 /*
@@ -112,6 +123,9 @@ BTF_KFUNCS_END(test_kfunc_set)
  * actually sort at least one of the two sets.
  */
 BTF_KFUNCS_START(test_kfunc_set_rev)
+BTF_ID_FLAGS(func, kfunc_g, KF_ARENA_RET)
+BTF_ID_FLAGS(func, kfunc_f)
+BTF_ID_FLAGS(func, kfunc_e)
 BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
@@ -301,15 +315,15 @@ void test_resolve_btfids(void)
 	}
 
 	/*
-	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
-	 * with the address_space(1) type attribute, and left other
+	 * Check resolve_btfids wrapped exactly the arena-flagged or suffixed
+	 * return/args with the address_space(1) type attribute, and left other
 	 * pointers/returns untouched.
 	 */
 	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
 		const struct btf_type *fn, *proto;
 		const struct btf_param *params;
 		const char *name = kfunc_symbols[i].name;
-		u32 fl = kfunc_symbols[i].flags;
+		u32 arena_args = kfunc_symbols[i].arena_args;
 		__u32 nr;
 
 		fn = btf__type_by_id(btf, kfunc_symbols[i].id);
@@ -322,15 +336,10 @@ void test_resolve_btfids(void)
 		nr = btf_vlen(proto);
 
 		ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
-			  !!(fl & KF_ARENA_RET), name);
-		if (nr > 0) {
-			ASSERT_EQ(is_arena_tagged_ptr(btf, params[0].type),
-				  !!(fl & KF_ARENA_ARG1), name);
-		}
-		if (nr > 1) {
-			ASSERT_EQ(is_arena_tagged_ptr(btf, params[1].type),
-				  !!(fl & KF_ARENA_ARG2), name);
-		}
+			  kfunc_symbols[i].arena_ret, name);
+		for (j = 0; j < nr; j++)
+			ASSERT_EQ(is_arena_tagged_ptr(btf, params[j].type),
+				  !!(arena_args & ARENA_ARG(j)), name);
 	}
 
 out:
diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing/selftests/bpf/progs/btf_data.c
index ec34f7a6e038..8082c13490ab 100644
--- a/tools/testing/selftests/bpf/progs/btf_data.c
+++ b/tools/testing/selftests/bpf/progs/btf_data.c
@@ -68,3 +68,23 @@ int kfunc_d(struct root_struct *a, struct root_struct *b)
 {
 	return 0;
 }
+
+int kfunc_e(struct root_struct *a__arena,
+	    struct root_struct *b__arena__nullable,
+	    struct root_struct *c__arena,
+	    struct root_struct *d__arena__nullable,
+	    struct root_struct *e__arena)
+{
+	return 0;
+}
+
+int kfunc_f(struct root_struct *a, struct root_struct *b__arena, int flags)
+{
+	return 0;
+}
+
+struct root_struct *kfunc_g(struct root_struct *a__arena,
+			    struct root_struct *b__arena__nullable)
+{
+	return a__arena;
+}
-- 
2.53.0

