Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31D3AC0D7
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265530; cv=none; b=Sb/xnNOcRTHC6sJY1dIvbtL3IQZOebymQsxvQygk0sL0KuNXihRhgeMkbGpc5UbgFx13nmtLl7p+h2rT8dJIzwRYDcDpn5AcZbpCrbmseEs6XHiUVoBy2A9uReWcBv9/fTHDLG6MNqhWVIV9frAvkBVXw4fzC7Pzkzr8nSkSVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265530; c=relaxed/simple;
	bh=4MLTtvjvKDC3l2XU/DafWg9VnlzyNh3yS4pphL0VWtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7hCojyNGvfl7JJHVGy36CjN8MfKXHsF4OLb7gQSrKnLqDf7n2cZbmW2DLNO27tA0eO9IbcRDflewOYQOinDIuAfH3uGurbd5mOblCgQfkM+K7/Liu7rrTtoZ/YQMCUM9o5RGS8OKklJa0mVpPd0o+0V9X5yC5EbMkFh2NBA474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agf88kjh; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agf88kjh"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7e9f37a2160so439519a34.0
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786265525; x=1786870325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLe57F29VIukVWwG47prntnnRlvOaqwzUfT0XT874IM=;
        b=agf88kjh/hH7iDYQVX1e4GHx59oACec5lMTCJeat96Os21Oou6fWOgs9ogMRlDk0VN
         J88usG6LBsxC87dOxroAVvWJZkKokkPTfId76tVrtgjgWWAP73bT4TS3dEi/5NANXH2Z
         mR3Lnk5716Czm7kKdzIlEFgtCfvubUYoWMf7wo3FFpUXDW1lVpFTevqgJy0RWwFN3MJj
         kTDwiDPSYAjKHHC2nBkSXJnRjGztKNXkYKh0D2Kos5R+sFkY6oNrXeZ4xqE6DRITfpqA
         1DRgYXEJIWuBFNZ2VZFnBfT4cDdTpvPXHc8Jt3Cc9xygV+6GV4zVRs7SAr/glKxdF+5d
         fhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786265525; x=1786870325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLe57F29VIukVWwG47prntnnRlvOaqwzUfT0XT874IM=;
        b=RD9FdVAReaNdM+8MmGd7CtdJ7D4TKSXEgTCOgWVZbaheOKJtuJROOmM6ZkCy8fV3Ib
         1u8TwsLeGmEJS4QXKt/Y3AT+bn9Hteqv8NDhlfCPRQ8O5s6/NmAXtsEXc9igNKyiyv2H
         iHu6zg34oD31k1ymvbo90GnXGdsQL2XF4xNoMHh+3VRqguPFht6EN4ppZ1IigELDne2G
         zCweQiYKx0uckU+Hz7L+nLc4qc8RErjrsLXzfpFPRgjnzeSoiSBgaDWDqe6EakDTnwl+
         3A9mawXol4HRMdGUuYbGi6DSGri/mZLehDZsOHGpmAc5paCoMtFmxy6NyVu0oRUZJHkV
         nn8w==
X-Gm-Message-State: AOJu0YxkQ5bWqzrKGd2Qrt9080aoFHyECULkYuasEDUX6jHo520xTNSH
	NHG/izpNF+1tdl80cXKAFabx4JKHyHOWPDkBIp/hyNDtZBl2OntgLtS69qRqCQTWxn4=
X-Gm-Gg: AR+sD13xg6WSQadjXzLm70GHuln43j9DOdU+zTHTjhOidq653At3FoIMYiTGTCMe7Yp
	8A1zjp8ywjEvnjINUiuDBKZJd/pUR0196g8mxLuXE+5mk4pmnqQfQ3ONnFc3QYzjNq9UMxAmMpP
	lPpjauAYuUngNhJCulDCPZjHuWvq4kPAPdgHTMilZkBgBMrE9qhZwWnI2Pb6lfjipAnyxzwEnUU
	yXFuh0gm0v8jVmSNQUpq/dV7dsYCJ/cGNkmsFHHv07W23KO37qMRgxKCFvaWQ6asoC9PfUN+iB7
	RCunhuA3z/ofq/NgePgy1IfkN8DG0lrcn+09m9knFiUrBy7E+rxN4l4bnnnZxNnLeKS0GkpEb+J
	rpGsKqZjGaYnnZfqzw3enRd7LnZEwIdPntpWr2czIph2JOoeD1iYQF+6hMq/dOO2J1vjFNvb8gT
	51Abf2kXKEm3K+m5HZmHLSABxqENkIA1NAG2R3TwHlO6OctDbmGDnzWIttA8ynqesZZ+cifKJlS
	Xo/vF5cI+sAwLjFMzS7NNJ9WasrzTnaIsi6HFkRPn8GAFBVczkvhUSaPEFvdivN21xkxJ8=
X-Received: by 2002:a05:6830:4393:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7f1e5e4685dmr21324512a34.9.1786265525193;
        Sun, 09 Aug 2026 01:52:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:17::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b56391dsm4862780a34.1.2026.08.09.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:52:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test resolve_btfids arena argument suffixes
Date: Sun,  9 Aug 2026 10:51:54 +0200
Message-ID: <20260809085155.3305519-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809085155.3305519-1-memxor@gmail.com>
References: <20260809085155.3305519-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4456; h=from:subject; bh=4MLTtvjvKDC3l2XU/DafWg9VnlzyNh3yS4pphL0VWtg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavCfnb8pIqAuvNbTtp4zjwa7tH/4r2bXsZnHcW8tyvfTW4/ ekGjo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5yMLIsGXH4Z28u3/WBx9aNX9N/D H9h8Kr77vIVfhUvUt/f9573XyGv4LpxqtSj1hdmHMjbW1Xutx5ifbOPR907l/JZ800Oi+nwQ8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a suffix-only kfunc declaration with arena annotations on all five
arguments. Verify that resolve_btfids emits address_space(1) type tags
for every position without KF_ARENA_ARG flags in the BTF ID sets.

Represent expected arena arguments as a per-parameter bitmap so the
test covers suffixes beyond the two positions expressible by flags.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 35 ++++++++++---------
 tools/testing/selftests/bpf/progs/btf_data.c  |  9 +++++
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 732cfed35e1c..9bd84fe32b89 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -15,6 +15,7 @@
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
 #define TYPE_ATTR_ARENA "address_space(1)"
+#define ARENA_ARG(n) (1U << (n))
 
 #ifndef KF_FASTCALL
 #define KF_FASTCALL (1 << 12)
@@ -49,13 +50,18 @@ struct kfunc_symbol {
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
 };
 
 /* Align the .BTF_ids section to 4 bytes */
@@ -105,6 +111,7 @@ BTF_ID_FLAGS(func, kfunc_a)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
 BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_e)
 BTF_KFUNCS_END(test_kfunc_set)
 
 /*
@@ -112,6 +119,7 @@ BTF_KFUNCS_END(test_kfunc_set)
  * actually sort at least one of the two sets.
  */
 BTF_KFUNCS_START(test_kfunc_set_rev)
+BTF_ID_FLAGS(func, kfunc_e)
 BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
@@ -301,15 +309,15 @@ void test_resolve_btfids(void)
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
@@ -322,15 +330,10 @@ void test_resolve_btfids(void)
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
index ec34f7a6e038..ea41c9801432 100644
--- a/tools/testing/selftests/bpf/progs/btf_data.c
+++ b/tools/testing/selftests/bpf/progs/btf_data.c
@@ -68,3 +68,12 @@ int kfunc_d(struct root_struct *a, struct root_struct *b)
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
-- 
2.53.0-Meta

