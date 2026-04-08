Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD8363084
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614453; cv=none; b=IrjkF/AOvL0fdepq+F+P/LptmOXfGTky1zlXEt2278L7qwL+s6O0misjomGqXOrDeIBkPCDdoXjL7qlhv0QHU4dIQawUPoypJjuUMK4Q7SQJ1bvGwNs1aYfL7OSTycEF36Otuk6k3uaSymqpz3zVCcdQg//TnUtCNsyMGrpO6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614453; c=relaxed/simple;
	bh=KLEcKrNNxJLRmBOtQV0vrvqacmvRnYPtxeKTmG9NeAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6j5XRIFS1J1CdjhvsTopKx+S/eEcdtquGa5OvJh7Wd0KmJduORJy4mXpfnH1N1rwXN0CL7KGQWkQufwi+KGyX2cajUYLOzi242pXxA5WucMXSo9TQbIky2Kj2uy02YCTEbz8lGJGvZCy/8KraSF5GpkjJd7Bm6gsIxLCcP5U38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv98tr3J; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv98tr3J"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbd801138eso276881a34.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614451; x=1776219251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kGatzaq9+4I5rkmlmYvC3KMJ5b6j+lGzhs9tZbxtFI=;
        b=gv98tr3J29RjibgCSLHAs3YQms48RIEyqy4R9Tt01jrw+/vV9rut8xIWeQsmcwt08c
         A8DvN9vNrCd3Tig36MaLOvRXPhSZnNfif8UFEjnJsmUBqM9EIG4QXwR/W+QwUHpNTHsh
         wQdZZPZGVA98Cm/H+bs7JJncW8ZtVxLkCEkJM+ioIPhOLgdz3eP3v8VEnb7WOcupyr1n
         3Dr9mk7SeKwn1DIVozEYH00K4+iY+maUMJCVcg6NadNB6ic5/dn8AvfuupvGTmDsMB9Y
         35WGidtX78xus+ECAPypOT1DkWdjO6nLMxwTh2b0ey9QTXza/XB8XuGvGQtSisleXyFq
         kMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614451; x=1776219251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kGatzaq9+4I5rkmlmYvC3KMJ5b6j+lGzhs9tZbxtFI=;
        b=Pxrx/unVvGIrV5vCBL+xg8tsQrkIGGTP3HHDQKX2msWDtrYMivvCmpl/piF+ox03ZG
         emOKShWB6GOToQLuISgsY4dX6PkIlRUT2YUcNM7YEGySyoBoeOgKssDrinUzpGPc25nt
         KyTevDq0UQvACEXxseuhPnXQQcnq8FQ1/4sxTe9NrQUkE3EGo3o9iYW+eOmzoHZnw2o4
         /bF45CO8vS0P2c6iTqNi1sDbQWIfBIXSUfM/uUUwXbnic52OsQbFqS7qpZyZ27ZGo7UE
         gDCTZlShkT++zyflWiomWncAuNtKRanIs8URjXQBWL58FnnRd/2oVsGCOpXklL2q4BA3
         IjmQ==
X-Gm-Message-State: AOJu0YyGWEwhWSi9spiNQR4fGcecvjpe6LXmUUGGuYzAZM2NlcAtWgov
	t9QfoiLsdn9SLyGBgYL1d87huwGvSGSd3MoiNHSO7EERoY6ituHrJWLyBoMpJhHYxj8=
X-Gm-Gg: AeBDievq0O+scmYmshI/dmwEf4yXT9EG+fm5kbwO7//2yeCx42Jq11VKlYxvR/vjc0E
	kg5Yn1mIgFHC+v6Wo9cfRzlAeCy40WEOEMA5O+4gAJc0yMu6hpV7VcGqCZuR4x/Y+oTkr0V+GjZ
	zdnrasjGCA0G/UGj8LhMLyptulIdCAa/SE/ElhNoefqlH/TEH6Gp74GyPa1uyEpNLJF7OOhoRee
	lky6iZXQQKdmY70v+fGMlFd+PppePCsRUUhZm1sdfuC2f33Rdr4aaaLU3eo6BRwnJIcmdID1xD7
	kKbhPBxQJ30hOZpOFZjd2yZQGBbGa/GIdEgDz5Ed+34AyI45C7fVXUVCJmh9bub9CM9UtpUtuDd
	4HgyFQ/0QHQwdwK4gpUvuhuwSkNcTi08IQ9I4pK3JZmj0ZVGahQOzId9oAk6embx+XazDEDlmwJ
	Jib00R+4cHruQpQBw0JbtAAVEbROCBy9CT8bZ8LiucyoKn
X-Received: by 2002:a05:6820:998:b0:67f:31e3:81a with SMTP id 006d021491bc7-6821dd77ea0mr9368006eaf.2.1775614451086;
        Tue, 07 Apr 2026 19:14:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42330d4a3c1sm9810323fac.1.2026.04.07.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/6] bpf: Use KF_DEPRECATED to emit verifier warnings
Date: Wed,  8 Apr 2026 04:13:55 +0200
Message-ID: <20260408021359.3786905-5-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7062; h=from:subject; bh=KLEcKrNNxJLRmBOtQV0vrvqacmvRnYPtxeKTmG9NeAA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzmMrJU77Ooe5zrqR2qApobg15twEjfis+2Z8s6PLY16+ 6l3dUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInMWcLI0KG/LeYnz/G6RpdX+z38M2 XCXr35pr6U0ZDjcYLii08NTxj++2tM+T1lL1fg/OXZpseu6ZhWvlyy+43xqbRND3g1L0x+zQgA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

As documented in kfuncs.rst, introduce a KF_DEPRECATED annotation for
kfuncs and apply it to all existing impl-suffixed kfuncs that are
preserved for backwards compatibility for a few kernel releases, after
we introduced versions with KF_IMPLICIT_ARGS.

Use the kfunc flag to decide whether to emit warnings to the verifier
log or not. Be helpful and point out the file:line in addition to the
instruction when the information is available while emitting the
deprecation warning.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |  1 +
 kernel/bpf/helpers.c                          | 16 ++++-----
 kernel/bpf/verifier.c                         | 34 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  2 +-
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..86006a2d8b2a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_DEPRECATED   (1 << 17) /* kfunc is deprecated and should warn when used */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb95e287b0dc..190c0b382f11 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4685,19 +4685,19 @@ BTF_KFUNCS_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new, KF_ACQUIRE | KF_RET_NULL | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL | KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_percpu_obj_new, KF_ACQUIRE | KF_RET_NULL | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_percpu_obj_new_impl, KF_ACQUIRE | KF_RET_NULL | KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE | KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_percpu_obj_drop, KF_RELEASE | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_percpu_obj_drop_impl, KF_RELEASE | KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_refcount_acquire, KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL | KF_RCU | KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_list_push_front_impl)
+BTF_ID_FLAGS(func, bpf_list_push_front_impl, KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_list_push_back_impl)
+BTF_ID_FLAGS(func, bpf_list_push_back_impl, KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
@@ -4706,7 +4706,7 @@ BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_add, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
+BTF_ID_FLAGS(func, bpf_rbtree_add_impl, KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86d77d5f7f83..267ab3c36f6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3229,6 +3229,7 @@ struct bpf_kfunc_desc {
 	u32 func_id;
 	s32 imm;
 	u16 offset;
+	bool warned_deprecated;
 	unsigned long addr;
 };
 
@@ -12426,6 +12427,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
 }
 
+static bool is_kfunc_deprecated(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_DEPRECATED;
+}
+
 static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RCU;
@@ -14583,6 +14589,32 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
 
+static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
+				       struct bpf_kfunc_call_arg_meta *meta,
+				       int insn_idx, s16 offset)
+{
+	const struct bpf_line_info *linfo;
+	struct bpf_kfunc_desc *desc;
+	const char *file;
+	int line_num;
+
+	desc = find_kfunc_desc(env->prog, meta->func_id, offset);
+	if (!desc || desc->warned_deprecated || !is_kfunc_deprecated(meta) || !env->prog->aux->btf)
+		return;
+
+	linfo = bpf_find_linfo(env->prog, insn_idx);
+	if (linfo) {
+		bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, NULL, &line_num);
+		warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
+		     file, line_num, insn_idx, meta->func_name);
+	} else {
+		warn(env, "(insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
+		     insn_idx, meta->func_name);
+	}
+
+	desc->warned_deprecated = true;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -14612,6 +14644,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
 
+	warn_for_deprecated_kfuncs(env, &meta, insn_idx, insn->off);
+
 	if (!insn->off &&
 	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
 	     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index d876314a4d67..6ad7b2cdfd05 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1326,7 +1326,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_assoc, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
+BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl, KF_DEPRECATED)
 BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
-- 
2.52.0

