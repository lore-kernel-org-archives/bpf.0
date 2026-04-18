Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219491B4F0A
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532630; cv=none; b=gQjbUA+yEPQ5CheE36RsbqsIj16GIPGUW6heUWXllTvAaEddfnI4SdHtO7HhSKTSm67ck5VC3fFUd4BgiaL3pxY0ngQ40WmuF7JociBNCKIRXCGj1Hxj4BwJXPHC0WNzUSdeYxqlYjYRpd/MnLZ4Gg+oN4LQBaGDwzxVHC/JEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532630; c=relaxed/simple;
	bh=T5VTzDKnEDmyAshDfRVx3ycUn+tXEGnQD5pDffeLeFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtUBoszh580DLzfRWDpEGYRkpdbd2ydG6yYun3V1dnQ6jXijCCfZzzq+QJa2XQfihEiFPFUSbYoMx8W1Vez0VWpVEo658rX85o43cChVK77PTUQrHYEH6P2mFifsD2U/d3kknp0x6OgvG0dJUnb6Gsn/Okqxe2356vdlRyLAiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afrrEPjM; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afrrEPjM"
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-66f747175d8so841178eaf.0
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532627; x=1777137427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewPSjR0Aa2p04575IY8ofuP6yOfyfBsxpIVWQwD88fM=;
        b=afrrEPjMeVuY8m96vaWbmtXDB3sAruvKKCQLk8YFzCKp/ZSpklKLo+3wltSMsn3KAw
         BTReCI1WDPi2BKxakKseCS/PusvTJIePHw2pAVMj9i6cQpvLkXvsf+I2Ay0uQGOsEStz
         yaRRptZDYQHrBIsvUUNBOlmtDY4YIcjZPltMFiIfR/RTdDhy5VLGE6+s1K36yfp+hmy+
         xhCx2/2wLBRIlmlOEyVE7q3Xhp+ay/u4PzPqE0re9daIrKbfO9h841CAXKlZ0SqQUSqY
         iNZXuMqb1Co+boT2mzVx8yZAjqyllvRDHNANw/Bu6Eb8eQv6/k1wPYX90uJi/8PnZq61
         1nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532627; x=1777137427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewPSjR0Aa2p04575IY8ofuP6yOfyfBsxpIVWQwD88fM=;
        b=PkEZjh2BRtjjI6gQkZ/uRmjbieuO2uk57rpZiMC3y0P7W5DJBoGFF4ErYfclnolldQ
         fqPJmyj5QDKCL8gA8v65DrM1gRA1W4hYyqZFLHWDDHPGhXtMNfGQWoGyHBN73Hr7RJ13
         toAMXluinmW++qIo75TKYrTc4cOJNkGNyR3pkiYJWN9wmnvEq4h3hYMDvl+/MBeoZDcE
         umHr7Sc14s1B4EVFj71Qx+8UivbgE5u35QVWB81ufGu49WR+UzSzoVqZfhI0pLe+7JEk
         qkEDUU5JkTir4OpS59kE5rdWgr8Zno7znPc8Nx9Vz3OaTha9HvyFZThKdpiZkvpw35gf
         46pQ==
X-Gm-Message-State: AOJu0Yww8aATaR8a9TYqZi1eODcRd/UwIWkrhYKBv6nqKNnwEzwNUbpD
	tHmEGR7kEPIdYYhS3ot3/j45A8XqJuDYPWtGOlCjHIhgR8zgOLvXsrsEladbpOo3yNCK0g==
X-Gm-Gg: AeBDies8z+rHK/NWCFPt71H8LX4KJ898drpoohe1jjgShm2DJIlx2BbiArZPvhzrFPv
	wVaMeyVCMjdVmzUokleMKEJ5GsxPhoRKDvFVGaVykekGHS87yVxBh4OMRGmqegU3qwe2CKC/CZQ
	RzW1F6PmVikGbujWADmlooW2Bhjy4G0sc7tFAxFSgAw4RMTQighhWSGZbrGgP/Gne4PsMY7BbpS
	ajA7dyFMKvoUZVKGrtsMXv5LuDEaJRiqXmdmSSvnudgyJiv3lToQeDTjcAp6LtFG5r3tAk7m3KR
	iJTHgXHecGJaHF+AQvlvpCP3leUDi4RtUrjB8/VG6QFEDrt1Ls4+onAo1Bz/8E4k8V+sRdmkB0o
	k7x49sG913MpwGPRJzlPo9ppfjmtE+oB3FL2BjicZmzDyjMJPc9gmqcEuPqUNiIJ8et7jSn4VTy
	Alycvr6MS4YQMZEVv60ARAkvpKLeEplH6cAvwr4XpOWBvyJBCh/0WrSSL0cYK+dDnN8a4hp0oAB
	mqateX+xYe61Wq2T9Ne0YCLbBXnCwbR1wGJD919yn+8
X-Received: by 2002:a05:6820:825:b0:680:322:4f36 with SMTP id 006d021491bc7-69462e759d7mr4140307eaf.25.1776532627521;
        Sat, 18 Apr 2026 10:17:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930bca47sm3826891fac.7.2026.04.18.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:17:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/4] bpf: Introduce __bpf_kfunc_mark_deprecated annotation
Date: Sat, 18 Apr 2026 19:16:57 +0200
Message-ID: <20260418171701.610025-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418171701.610025-1-memxor@gmail.com>
References: <20260418171701.610025-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12551; h=from:subject; bh=T5VTzDKnEDmyAshDfRVx3ycUn+tXEGnQD5pDffeLeFM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPxnmx14cvaFvvm+m7+cNzx7u9zRrttLtjabJhznPuTqd76 LiubjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwkpobhf1ZFgfq53Gdvvxofkr5wQL y1vFCQQfLo2Y5fhturWvIndTL8FXzcNl3BJf57tv9knsRrdseP/pm0YdHG3/2BSQ2z+iam8gIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Documentation for KF_DEPRECATED documents the expectations and
recommendations for deprecating existing kfuncs. Until now, such a flag
never materialized. Unlike other kfunc flags, more context needs to be
carried with such a flag, thus we introduce __bpf_kfunc_mark_deprecated
as a replacement for the (non-existent) kfunc flag which takes a
replacement kfunc to provide recommendations to the user.

Apply it to all existing impl-suffixed kfuncs that are preserved for
backwards compatibility for a few kernel releases, after we introduced
versions with KF_IMPLICIT_ARGS.

Note that this is only supported by LLVM-compiled kernels as of writing,
since GCC does not support for BTF declaration tags.

Cc: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst                  | 42 ++++++++++---------
 include/linux/bpf_verifier.h                  |  1 +
 include/linux/btf.h                           |  5 +++
 include/linux/compiler_types.h                | 14 ++++++-
 kernel/bpf/helpers.c                          |  8 ++++
 kernel/bpf/verifier.c                         | 41 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 7 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 47d60011d8eb..5beef4432a8d 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -344,22 +344,23 @@ RCU protection but do not take RCU protected arguments.
 
 .. _KF_deprecated_flag:
 
-2.5.8 KF_DEPRECATED flag
-------------------------
-
-The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
-changed or removed in a subsequent kernel release. A kfunc that is
-marked with KF_DEPRECATED should also have any relevant information
-captured in its kernel doc. Such information typically includes the
-kfunc's expected remaining lifespan, a recommendation for new
-functionality that can replace it if any is available, and possibly a
-rationale for why it is being removed. When verifier warning logging is
-requested, the verifier will emit a warning when a BPF program uses a
-deprecated kfunc.
-
-Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
-supported and have its KF_DEPRECATED flag removed, it is likely to be far more
-difficult to remove a KF_DEPRECATED flag after it's been added than it is to
+2.5.8 Deprecated kfunc annotation
+---------------------------------
+
+The ``__bpf_kfunc_mark_deprecated(replacement)`` annotation is used for
+kfuncs which are scheduled to be changed or removed in a subsequent
+kernel release. A kfunc annotated with
+``__bpf_kfunc_mark_deprecated(replacement)`` should also have any
+relevant information captured in its kernel doc. Such information
+typically includes the kfunc's expected remaining lifespan, a
+recommendation for new functionality that can replace it if any is
+available, and possibly a rationale for why it is being removed. When
+verifier warning logging is requested, the verifier will emit a warning
+when a BPF program uses such a deprecated kfunc.
+
+Note that while on some occasions, a deprecated kfunc may continue to be
+supported and have its deprecation annotation removed, it is likely to be far
+more difficult to remove such an annotation after it's been added than it is to
 prevent it from being added in the first place. As described in
 :ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfuncs are
 encouraged to make their use-cases known as early as possible, and participate
@@ -534,10 +535,11 @@ maintainer if it turns out that the kfunc is actually being used.
 
 It's expected that the common case will be that kfuncs will go through a
 deprecation period rather than being changed or removed without warning. As
-described in :ref:`KF_deprecated_flag`, the kfunc framework provides the
-KF_DEPRECATED flag to kfunc developers to signal to users that a kfunc has been
-deprecated. Once a kfunc has been marked with KF_DEPRECATED, the following
-procedure is followed for removal:
+described in :ref:`KF_deprecated_flag`, the kfunc framework provides
+the ``__bpf_kfunc_mark_deprecated(replacement)`` annotation to signal to users
+that a kfunc has been deprecated and to identify the replacement kfunc. Once a
+kfunc has been marked deprecated, the following procedure is followed for
+removal:
 
 1. Any relevant information for deprecated kfuncs is documented in the kfunc's
    kernel docs. This documentation will typically include the kfunc's expected
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 515afcb83ec7..b70081fe24d8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1461,6 +1461,7 @@ struct bpf_kfunc_desc {
 	u32 func_id;
 	s32 imm;
 	u16 offset;
+	bool warned_deprecated;
 	unsigned long addr;
 };
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..c75ecef67096 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -88,6 +88,11 @@
  */
 #define __bpf_kfunc __used __retain __noclone noinline
 
+#define BPF_KFUNC_DECL_TAG_DEPRECATED "bpf:kfunc:deprecated:"
+
+#define __bpf_kfunc_mark_deprecated(replacement) \
+	BTF_DECL_TAG(BPF_KFUNC_DECL_TAG_DEPRECATED __stringify(replacement))
+
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
 	__diag_ignore_all("-Wmissing-declarations",			       \
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e8fd77593b68..ba5b20e30d4d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -35,10 +35,20 @@
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
  */
 #if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
-	__has_attribute(btf_type_tag) && !defined(__BINDGEN__)
-# define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
+	!defined(__BINDGEN__)
+# if __has_attribute(btf_type_tag)
+#  define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
+# else
+#  define BTF_TYPE_TAG(value) /* nothing */
+# endif
+# if __has_attribute(btf_decl_tag)
+#  define BTF_DECL_TAG(value) __attribute__((btf_decl_tag(value)))
+# else
+#  define BTF_DECL_TAG(value) /* nothing */
+# endif
 #else
 # define BTF_TYPE_TAG(value) /* nothing */
+# define BTF_DECL_TAG(value) /* nothing */
 #endif
 
 #include <linux/compiler-context-analysis.h>
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..69b4eae257a1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2343,6 +2343,7 @@ __bpf_kfunc void *bpf_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta
 	return p;
 }
 
+__bpf_kfunc_mark_deprecated(bpf_obj_new)
 __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	return bpf_obj_new(local_type_id__k, meta__ign);
@@ -2367,6 +2368,7 @@ __bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_met
 	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_percpu_obj_new)
 __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	return bpf_percpu_obj_new(local_type_id__k, meta__ign);
@@ -2410,6 +2412,7 @@ __bpf_kfunc void bpf_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
 	__bpf_obj_drop_impl(p, meta ? meta->record : NULL, false);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_obj_drop)
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	return bpf_obj_drop(p__alloc, meta__ign);
@@ -2428,6 +2431,7 @@ __bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *met
 	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_percpu_obj_drop)
 __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	bpf_percpu_obj_drop(p__alloc, meta__ign);
@@ -2460,6 +2464,7 @@ __bpf_kfunc void *bpf_refcount_acquire(void *p__refcounted_kptr, struct btf_stru
 	return (void *)p__refcounted_kptr;
 }
 
+__bpf_kfunc_mark_deprecated(bpf_refcount_acquire)
 __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
 {
 	return bpf_refcount_acquire(p__refcounted_kptr, meta__ign);
@@ -2514,6 +2519,7 @@ __bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_list_push_front)
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
 					 struct bpf_list_node *node,
 					 void *meta__ign, u64 off)
@@ -2543,6 +2549,7 @@ __bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_list_push_back)
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 					struct bpf_list_node *node,
 					void *meta__ign, u64 off)
@@ -2683,6 +2690,7 @@ __bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
 	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_mark_deprecated(bpf_rbtree_add)
 __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
 				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
 				    void *meta__ign, u64 off)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8de2a4e5f5de..1f3b44f47949 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12987,6 +12987,45 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
 
+static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
+				       struct bpf_kfunc_call_arg_meta *meta,
+				       int insn_idx, s16 offset)
+{
+	const struct bpf_line_info *linfo;
+	const char *replacement;
+	const struct btf_type *t;
+	struct bpf_kfunc_desc *desc;
+	const char *file;
+	int line_num;
+
+	if (!env->prog->aux->btf)
+		return;
+
+	t = btf_type_by_id(meta->btf, meta->func_id);
+	replacement = btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DECL_TAG_DEPRECATED);
+	if (IS_ERR(replacement) || str_is_empty(replacement))
+		return;
+
+	desc = find_kfunc_desc(env->prog, meta->func_id, offset);
+	if (!desc || desc->warned_deprecated)
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
+	warn(env, "Switch to kfunc %s() instead.\n", replacement);
+	warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_exists().\n");
+
+	desc->warned_deprecated = true;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -13016,6 +13055,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
 
+	warn_for_deprecated_kfuncs(env, &meta, insn_idx, insn->off);
+
 	if (!insn->off &&
 	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
 	     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index d876314a4d67..5a57a92a8f8c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1252,6 +1252,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
 
 __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
+__bpf_kfunc_mark_deprecated(bpf_kfunc_implicit_arg_legacy)
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
 
 /* hook targets */
-- 
2.52.0

