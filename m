Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23374400DFC
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355339; cv=none; b=Qav5rXQ6dndbxFQJM+qUBtm2iEevlNXhbyFu16hwNyVmV5I6JEGA9owZTqERr3MfoVxozNn7L45Uy28D+QAj3mZ0dxnH6pxxOkVSX03F1DnlNU7p0TwYcyT+h20CLxijGGTrHm9zShHw2dYuEBeVhjz3uyd0jiNOHYJXSuJHdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355339; c=relaxed/simple;
	bh=Rz/BUaU5siIUnuuwj1Mq8Z1Qg0lhmhEY3sgn7X5pftA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcIaAk8cpVM+GirpMz93ui2ulIJw5W5yFZzOlFuvyEtC6cuJz6nv9UDTeeJT0IA7uWvmIYZRAzsQ1aRAok2LfQ05TTTw7MpfYU98tOUdHlpFLEJtgYexLi4hOig0QTB7HA/yzxLkWhK1WgQiwVAZAbpnZ/NbkWB1FxPqVscqh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYMmabOC; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYMmabOC"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c2193fc3dabso90737266b.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355336; x=1787960136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smyROgr+MzPW0n2vVcqkEpMhNLZH2fJrr3C0paFKLM0=;
        b=gYMmabOCM5ZG9fT9zoFZnBV4VcuLy2BlfAjMJSWLQ2f7knRqQpysvIIfnLkhN08PzJ
         P72EoJy63/xbB0bOOPsRd0chRL+YfdaVf67rvUB9E+EtVCYqbadQ8TP/3fQSi+KfT9Pz
         ICODNckpN7f1a5k4UHNPiquF4FRPIWFlyncPlOOt6oyp90U9E6gpjgcWvefbLqpXmGa0
         go5P4cZB3W0nq+/9vDOen299Av/UsUBm6Q6H79v61DM9PQmvY/2p3So1XrMu4lLU7rOZ
         xiyrDYyIT8XSuNz2G8FAHMD2c8/q8MnCSBkTugz8kS4f5BhC9qAdrtepJRHflwwRtnCJ
         KKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355336; x=1787960136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=smyROgr+MzPW0n2vVcqkEpMhNLZH2fJrr3C0paFKLM0=;
        b=gscpVbYuwPAidYTeSeZ67DVYZ4qulcuerllzc8NBLbTUq6ssfRV4n3Ld+NqIcMuRFW
         diTC7VQzC25paiLPtQnDFzHAZ0wNsNe9PEttM4HLKN8ZTNGiBtSm8EMfPZvicDdBLWrR
         dVc4JNACpCrHwOlRYkcXzl8vSsAGGt4yinNWF76Hz1U0/F7C+eeoA9abRPpDbHrGEFJY
         56mrxHYxtFhy3aXPjbhxPu7z6u7JPi+NmaL9fq8snxU0CAH/TVSi6GTLvNaFbQUSawpJ
         2LGb0YcBlfxWVPD2KMsL2LF/+wXBSQJzCXFCsCp+2Ds48dmlQvWIYk1D/CsXB5HlnRsl
         +nnQ==
X-Gm-Message-State: AFuF++loOMoktdVUcoRpFDbTp6YQNesM1P8ondsfF4NroJfIu1B82oeu
	5cnQj6Mayq11maNTJMEkjjQqYqpTt+B7rVoD8EOqoZ6U2kQZC3AzKX2ZQuCxUmKX
X-Gm-Gg: AR+sD11XtPjr/MWpviwW+XG/o9iN3PNlGhTqFYfm1ihrmlvsaIgBrkWwPGmbPEHcmKN
	sGPl3+MhaGcwj52KW+xUtzgzw/28pqy3Qd6T1zw7iJ+YhNces8CRMzEvy5O+PUP76ztsUoYNKML
	zZjs0n5thfjufdvVuPV8JPdF4OYLmE+IhFdf61yB6C4garPC3aLouEM0keDFCNge8c8zm+bTTvs
	KJxFcxmqCp41B5FnSPsuwuEE8auyL/InPoDWHC8qEy8hPQN3x7K/4s70/2OxKfSFf8Jxhr9CVqx
	lvudEfg9XF9kxeEI30gnbUCqUmOH+bp3WIK2tsLkuNSARMQ/3bHMXNicc3jKOU+7U3HHCzYdxut
	4dT/H1NqjyW240dvr6mibC2hHLpvltSPHynVG7lupjFpFJnmJGmkSjPw4cA+Fk2PnMkg87ZNAKd
	l5ooz2tk3VYWx+I5Cht6tXffGS9wSHODW1+obYtOoub5uu/WLizkHf3uJv/7ygHvfT3ARezErY5
	TEVO2JnhldbrEwNAXfkQPa57Ma8HxdZOD6dRzjlZ3usVzJfT2akT3mbSTy4H1KhN40hkXbMFYiU
	PvNs3XFtbinN40M/SKXJkFF0nj8=
X-Received: by 2002:a17:906:2481:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c246b4c5e33mr820802666b.24.1787355336140;
        Fri, 21 Aug 2026 16:35:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496297189sm41847066b.22.2026.08.21.16.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/14] resolve_btfids: Drop KF_ARENA_ARG flag support
Date: Sat, 22 Aug 2026 01:35:06 +0200
Message-ID: <20260821233516.3426127-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5008; i=memxor@gmail.com; h=from:subject; bh=Rz/BUaU5siIUnuuwj1Mq8Z1Qg0lhmhEY3sgn7X5pftA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQf/eP4ZfYmWKf4T4+S8IjXAs1eJaGf89UXW3a6+Da bbbp+cdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMiZhwz/XSzuBnj/Ps95qrv9 8cqU4/etyh8rX34xob14Xp5wkdjLdIb/GU7ZDw00xBTqhNcunnVMq5JtuigbP+vcI0YltreqAtO YAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Arena argument suffixes now describe the address-space contract at any
parameter position, while the kernel no longer publishes KF_ARENA_ARG1
or KF_ARENA_ARG2. Keeping private copies in resolve_btfids would leave an
obsolete second annotation mechanism and silently accept flags the
kernel no longer understands.

Derive arena arguments exclusively from their suffixes and retain
KF_ARENA_RET for functions returning arena pointers. Update the resolver
selftest to distinguish return-only flags, unannotated pointer arguments,
and suffix-annotated arguments.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/resolve_btfids/main.c               | 22 ++-----------------
 .../selftests/bpf/prog_tests/resolve_btfids.c | 22 ++++++-------------
 2 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 37d7e7224207..3dbf329edb46 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -177,8 +177,6 @@ struct object {
 
 #define KF_FASTCALL	(1 << 12)
 #define KF_ARENA_RET	(1 << 13)
-#define KF_ARENA_ARG1	(1 << 14)
-#define KF_ARENA_ARG2	(1 << 15)
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
 #define TYPE_ATTR_ARENA "address_space(1)"
@@ -1317,22 +1315,6 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
-static bool is_arena_arg(const struct btf *btf, const struct kfunc *kfunc,
-			 const struct btf_param *param, u32 idx)
-{
-	if (is_arena_param(btf, param))
-		return true;
-
-	switch (idx) {
-	case 0:
-		return kfunc->flags & KF_ARENA_ARG1;
-	case 1:
-		return kfunc->flags & KF_ARENA_ARG2;
-	default:
-		return false;
-	}
-}
-
 static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id, struct kfunc *kfunc)
 {
 	const struct btf_type *ptr = btf__type_by_id(btf, ptr_id);
@@ -1382,7 +1364,7 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	int err, i;
 
 	for (i = 0; i < nr_params; i++) {
-		if (is_arena_arg(btf, kfunc, &params[i], i)) {
+		if (is_arena_param(btf, &params[i])) {
 			has_arena_arg = true;
 			break;
 		}
@@ -1420,7 +1402,7 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	for (i = 0; i < nr_params; i++) {
 		t = btf__type_by_id(btf, new_proto_id);
 		tag_params = btf_params(t);
-		if (!is_arena_arg(btf, kfunc, &tag_params[i], i))
+		if (!is_arena_param(btf, &tag_params[i]))
 			continue;
 
 		id = arena_tag_ptr(btf, tag_params[i].type, kfunc);
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 3f9949e8227d..a4381c7fa7da 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -23,13 +23,6 @@
 #ifndef KF_ARENA_RET
 #define KF_ARENA_RET  (1 << 13)
 #endif
-#ifndef KF_ARENA_ARG1
-#define KF_ARENA_ARG1 (1 << 14)
-#endif
-#ifndef KF_ARENA_ARG2
-#define KF_ARENA_ARG2 (1 << 15)
-#endif
-
 struct symbol {
 	const char	*name;
 	int		 type;
@@ -57,9 +50,8 @@ struct kfunc_symbol {
 static struct kfunc_symbol kfunc_symbols[] = {
 	{ "kfunc_a", -1, 0, 0, false },
 	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
-	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
-	  ARENA_ARG(0) | ARENA_ARG(1), true },
-	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
+	{ "kfunc_c", -1, KF_ARENA_RET, 0, true },
+	{ "kfunc_d", -1, 0, 0, false },
 	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
 	  ARENA_ARG(3) | ARENA_ARG(4), false },
 	{ "kfunc_f", -1, 0, ARENA_ARG(1), false },
@@ -111,8 +103,8 @@ BTF_SET_END(test_set)
 BTF_KFUNCS_START(test_kfunc_set)
 BTF_ID_FLAGS(func, kfunc_a)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
-BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET)
+BTF_ID_FLAGS(func, kfunc_d)
 BTF_ID_FLAGS(func, kfunc_e)
 BTF_ID_FLAGS(func, kfunc_f)
 BTF_ID_FLAGS(func, kfunc_g, KF_ARENA_RET)
@@ -126,8 +118,8 @@ BTF_KFUNCS_START(test_kfunc_set_rev)
 BTF_ID_FLAGS(func, kfunc_g, KF_ARENA_RET)
 BTF_ID_FLAGS(func, kfunc_f)
 BTF_ID_FLAGS(func, kfunc_e)
-BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_d)
+BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
 BTF_ID_FLAGS(func, kfunc_a)
 BTF_KFUNCS_END(test_kfunc_set_rev)
@@ -315,7 +307,7 @@ void test_resolve_btfids(void)
 	}
 
 	/*
-	 * Check resolve_btfids wrapped exactly the arena-flagged or suffixed
+	 * Check resolve_btfids wrapped exactly the arena return or suffixed
 	 * return/args with the address_space(1) type attribute, and left other
 	 * pointers/returns untouched.
 	 */
-- 
2.53.0

