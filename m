Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A836405F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614455; cv=none; b=E48YtOO4s5O0YIOpgZ8a1d+EznFSR+68lQrm9tB8nqahfiFR8SoHnjpF6AdlHy5Bg+XP2xMDcVF9PZCykZ65DsKUR0UsKS1ihl5raUlqVefYFHUd/DFzy8Skza4B9HplvpQb7IpmYkOsrvDWKCwSEDKP4Zgla+IvHAzL8x2qJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614455; c=relaxed/simple;
	bh=fm1ohCrUMcOl2Kz6lutQ+Bk3wu5ocECGu64a6uTxVAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/wB8hf6t7PvWblNvvI3dGJORYZFierj/97RjVOaiwf297nOeFw2i0o0CbQQIKXt/CKDTyQkrMgwHjvNRUQ0P+nZ2Btv4q4ihWUzKeVs58+etdOR1n0miiShiSLwsEKLQaD+mOILgt116S+CmFozuwSJ/X6ij8pnBrhBTgRZNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTgBrkaj; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTgBrkaj"
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-68244d317e5so2604392eaf.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614452; x=1776219252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju3nZs2qmk2ARtUP5giVPvYUp+REqAU/fau9C0EA2UU=;
        b=FTgBrkajstRaqbDlXdLmG+pnxx/+D64RNVXKe37Ah9h5COpfKM9TYSoOYUlOl1lRCT
         WxRShTBxs5ki2zMdfoS28eROZqoKJL9KCtvoNsRZeySgBTor7VycxDPUDdaXDpM5Ukmf
         gNh2yWfwyNLiKOcxugjvep6sgLMlkFeJHNKURxU/lnb0thVtLobq/etCsZX4dvWZxSkt
         GUhgDoid42Tl6uPhC5zZriRHuwbDN1F9/2O63CEcF7RvmlLwWj4+RlD2nIZQq/1ZP9e2
         F4x1Eqg5v+iFlUDGwKwZOCqbRY0MH3bmi5RZfEfE6I+rzbOhj57BT041ImoJKCLhCUFH
         IZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614452; x=1776219252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ju3nZs2qmk2ARtUP5giVPvYUp+REqAU/fau9C0EA2UU=;
        b=ZcYFhTM5povVuGxzK/E6HjFX+ULpdOLFabtzyFT2lMIyxiy/TUpftM2e4ibb2i1WaK
         6wbNLT/YJ+MTeNGKgF4L4gUC+9MDbn82yoiNHApPZAlCexc161gIEFzaLySteQ3YVpfk
         +yUVU+QLLuSsVRMT8ZcJH/F//PbuF1JDeIzVdVFHcXWg4nJQUW+r/7pBA40wD+05MjNT
         Dz00LCcAen1TDgACs/o3Oi4w5ZdEPYFl5NqGwFBf+slFpch3OaeJUiq1rsUxoTPeSpeh
         JtwugCBugXqqYQaUxJiIOo+IlLtI16ZlD6RKAs9Z4mAb2Y2sUa3b0Y8T9aKe/yZf8aUI
         n/WQ==
X-Gm-Message-State: AOJu0Yz0+AIPPI0QXjH+aWn2MjM2mtUycCiZa6eceEoGTdG9M8fldjd5
	dsQWJiRk7xrArPLh4ZidArS10Jje5tlpBjlRwcqr+Den2amf8CeNmFhBDjK/Nz9938o=
X-Gm-Gg: AeBDiesveFl0Vf60vyVQS1Lqh5C7FN2Awr0oY30IvXTgZp8KSyxmsicmbFwcbVdHlBS
	sIzCkp4cjxPPI3GHmlC+CJ+k9/XGTXrkUiwhqeyn2bSIcTdGbpcmmOJazmmzK0AvCKOpLdAHLUM
	8BZ7/EqjIlN4mrso4t1AIw/9yKAj766DEwR3iTrKH/3sjjnw16KRA7O8SuHAeYtmIX79hIiufgC
	Vxewl/QpYF225CTvyHyiv3UuLV7hhS22cKiVIOf59tW3kOgocKTs9Nc0Qhq4hrvvw+KffJgKX2G
	7QxoSUXQGw7FAnHU1BFpdgVEaJKrsk0MvSLsOCSwfQ4c9n/q9wlFPQgL4u1E6/JHNSH4ZXB8eFN
	jArjQqp00zTbYIQbII72jqHL8zfzi2txpUJLIFDoKLPDPc7LXLq2WW/g2dJ0WqRN1+wvHT0JOFy
	jYbrIVG+8+vpC1CykSketTHV9i1IYf5+agGVB8pGJfyJc=
X-Received: by 2002:a05:6820:4c0b:b0:67e:310a:3638 with SMTP id 006d021491bc7-6821d53c53bmr13874421eaf.6.1775614452544;
        Tue, 07 Apr 2026 19:14:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25a55asm15764091fac.10.2026.04.07.19.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/6] bpf: Add __bpf_kfunc_replacement() annotation
Date: Wed,  8 Apr 2026 04:13:56 +0200
Message-ID: <20260408021359.3786905-6-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7209; h=from:subject; bh=fm1ohCrUMcOl2Kz6lutQ+Bk3wu5ocECGu64a6uTxVAE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzuOJqTW+SgdDp9X+mXIptJ3Nx2g3q+vvh9Ybg+5+0Nxz 9OD5jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk3hdGhqv7rcW35n7Y9qON3zD+66 qVnPwzpwR0vXOJUTF7d0SNTZOR4b+m/UTmylV8tS2JPV8emmhLN+SZOP4VdGubdvxHR7w9IwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an annotation to emit more contextual messages per deprecated kfunc
about which replacement kfunc can be used in its place.  The macro
itself takes the replacement kfunc as the argument.

This uses BTF declaration tags, and is only supplied as a warning to the
user when the kernel is compiled using LLVM, as GCC lacks equivalent
support. That said, in all cases KF_DEPRECATED does produce a warning,
so this strictly leads to an improved message where possible.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                                |  5 +++++
 include/linux/compiler_types.h                     | 14 ++++++++++++--
 kernel/bpf/helpers.c                               |  8 ++++++++
 kernel/bpf/verifier.c                              |  9 +++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  1 +
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 86006a2d8b2a..50cc8aa50e7a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -89,6 +89,11 @@
  */
 #define __bpf_kfunc __used __retain __noclone noinline
 
+#define BPF_KFUNC_DECL_TAG_REPLACEMENT "bpf:kfunc:replacement:"
+
+#define __bpf_kfunc_replacement(replacement) \
+	BTF_DECL_TAG(BPF_KFUNC_DECL_TAG_REPLACEMENT __stringify(replacement))
+
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
 	__diag_ignore_all("-Wmissing-declarations",			       \
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 890076d0974b..ef840212dc56 100644
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
index 190c0b382f11..a07ebc0597a3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2328,6 +2328,7 @@ __bpf_kfunc void *bpf_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta
 	return p;
 }
 
+__bpf_kfunc_replacement(bpf_obj_new)
 __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	return bpf_obj_new(local_type_id__k, meta__ign);
@@ -2352,6 +2353,7 @@ __bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_met
 	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
 }
 
+__bpf_kfunc_replacement(bpf_percpu_obj_new)
 __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
 	return bpf_percpu_obj_new(local_type_id__k, meta__ign);
@@ -2395,6 +2397,7 @@ __bpf_kfunc void bpf_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
 	__bpf_obj_drop_impl(p, meta ? meta->record : NULL, false);
 }
 
+__bpf_kfunc_replacement(bpf_obj_drop)
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	return bpf_obj_drop(p__alloc, meta__ign);
@@ -2413,6 +2416,7 @@ __bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *met
 	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
 }
 
+__bpf_kfunc_replacement(bpf_percpu_obj_drop)
 __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
 {
 	bpf_percpu_obj_drop(p__alloc, meta__ign);
@@ -2445,6 +2449,7 @@ __bpf_kfunc void *bpf_refcount_acquire(void *p__refcounted_kptr, struct btf_stru
 	return (void *)p__refcounted_kptr;
 }
 
+__bpf_kfunc_replacement(bpf_refcount_acquire)
 __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
 {
 	return bpf_refcount_acquire(p__refcounted_kptr, meta__ign);
@@ -2499,6 +2504,7 @@ __bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_replacement(bpf_list_push_front)
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
 					 struct bpf_list_node *node,
 					 void *meta__ign, u64 off)
@@ -2528,6 +2534,7 @@ __bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_replacement(bpf_list_push_back)
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 					struct bpf_list_node *node,
 					void *meta__ign, u64 off)
@@ -2668,6 +2675,7 @@ __bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
 	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc_replacement(bpf_rbtree_add)
 __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
 				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
 				    void *meta__ign, u64 off)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 267ab3c36f6f..535b4af710a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14594,6 +14594,8 @@ static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
 				       int insn_idx, s16 offset)
 {
 	const struct bpf_line_info *linfo;
+	const char *replacement;
+	const struct btf_type *t;
 	struct bpf_kfunc_desc *desc;
 	const char *file;
 	int line_num;
@@ -14612,6 +14614,13 @@ static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
 		     insn_idx, meta->func_name);
 	}
 
+	t = btf_type_by_id(meta->btf, meta->func_id);
+	replacement = btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DECL_TAG_REPLACEMENT);
+	if (!IS_ERR(replacement) && !str_is_empty(replacement)) {
+		warn(env, "Switch to kfunc %s() instead.\n", replacement);
+		warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_exists().\n");
+	}
+
 	desc->warned_deprecated = true;
 }
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6ad7b2cdfd05..7391247e3d18 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1252,6 +1252,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
 
 __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
+__bpf_kfunc_replacement(bpf_kfunc_implicit_arg_legacy)
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
 
 /* hook targets */
-- 
2.52.0

