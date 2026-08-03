Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0817A586
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761481; cv=none; b=oL9gapQBpGWlm03ACzBRD4NCQdAoEJFxmiJF8DiFMgg5kzgkdynIwLxIXuad0JpL/SJly1va6uiEbi5yZI+5+fA7+2hgpP1jHBxuKGyhIGKoRqIUggq01xSBEy0tqX5pEYto11W0GxWdey4sVk7WgrWk5gQGh21B6UIe9Z0g2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761481; c=relaxed/simple;
	bh=mausEsuYlu7rgrWo8hNXMkLdipaAgmm5xoljHocDUC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goAIwWSA4RExJ6wYd7Sj8a5GPK2HFkfugdiaZE225KEwHIqMBr7CVFYPJmupXyS/XGblfpTR8NFRdeeATSSWfSMLeSm11751/d3Bh0X89qb9vC90OCpmeSDV7Bs8MDsbQQCeETvG6xv3u0JRQfs1mddsvhnsuhlBBLWxrs3WYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnzPnMud; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnzPnMud"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1623186f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761477; x=1786366277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5hdMJ2ya4jD/hDWxvG4v0YcFcSLW0V4eap0yNZ+p5A=;
        b=QnzPnMudcKFqjXAJ+WFfrCMEVclrnNIAdq26ggTaRV/Z3E8oQf9eN/zAsCnD3X2Ryk
         8d4OIuTnOBxZ+V/ei7DIqNq4XxMKceI88z04gkPE60cXD9O4Lchy5G6UG+U2OU9PvGVJ
         YhFLTL2WwjOykRsM0oSZhO1+Z8QbAMy84qDasKgt07befbXnLwztn4YbgvJd+d/zEzX2
         +943+sOJqlMSEAg4j/bOU6NSzaKdjY78ptS5cFpWK2QjXVs3raiFMlGWzoZ10lkaSQHo
         /y7nrjg5cTdOsoytc6we5sVpGltOduYxd7JJkb/Qkbc7v2DJRKgb2MgjpxVz8Xw+seI9
         mLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761477; x=1786366277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M5hdMJ2ya4jD/hDWxvG4v0YcFcSLW0V4eap0yNZ+p5A=;
        b=KQWQnPAFGOFFS6SFh9sSNHi1zfQDNfXJ35oeO/LGVVnBQibLhGYt8Ij/WLnWoUuoWz
         r3E/K/QcL8XEbtk9xdvOr1uCeSFNacypHrN9V5miigpRsWEcsqrCrVJjh1r7zdg7SNPO
         BlRgzINzAi8Ki96RicfOwyPLxr07R9axulxk+pFfHMw4JXTwmngQm6KQd4aGrW65YawT
         GNQwqMQpw0LblyKq1Y2ag0OVKLHOjL0oCHwadAx5Q8gZRXw6H3c51E2pdqEOF2KDGUk/
         MUcesQSoquLtgpUsFNzP9n6v7mj1q8hwAiXY0XCQ5B4LiAbnMQ7S03skjMJpPcE1LRBc
         sI4g==
X-Gm-Message-State: AOJu0YyZ3W5TufUvK7g33GtXXfov68GP29qjy2WDdnPBfRyY1fyH2Fvp
	RsRHl5TVDzXHi3lyWwg/1pbDbCOhIE3NIVsqBGOT6pSz6bssHOarsQcv79B/PGRC
X-Gm-Gg: AR+sD10DqwPE8eYkabcwLjEZbj0RjtfhxOiCPM92VkopKIsiZIcxPkFsGMePBYP6uwG
	7By/ChDy16NcDDbtc3jv4tOC6hhBwA/ouKpG6WeKr3U+EkV3IFwIVaT6G274rBA4Br2/ITd5gQG
	D5DGbkkGmBnxIRiOzau+VEl0znh6Wh2YK/pxP1ejf4SRzTdMX6bkUTF8qpONzzfR3Xc6irDtSdN
	upMIr17t/Zok1Q5gO8qv9LzloSnGIF1AaJClc3vhDpNCYqnnIPC4hNL4kQs4nH765MXfjKOq48B
	Z+1DNPOGxE4J39jhvNeynH6CDS74Ure7M1t6afNoxc2g3IJoV21W/fmcGf0Qt3scGQq9//KckJX
	EKMSg9Y9hVKf+j1eevQFYHZaGvtL7ipG/6YZWy39GEJDoZZPFA3XcmlqnaWa5nk8s9MwLaRU6O3
	D+1J/v2Em8nLHAUsGmln1iSLABMI6DoU1eAe4ThwfgRFi7PJ3KS9HdcNqbYD0yvy3Nq+9fjt4A7
	WYKlytosFf7M7CkAbbaSGBwopJZ+XW6PN8j63XW24JsXZ+6RREsDqK8pToOVXgRnyZOcGCjYj3t
	m8CD22jI5XcbX83CQPq4QJ1XLu4=
X-Received: by 2002:a05:6000:1787:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-47fd7262860mr26875798f8f.0.1785761477301;
        Mon, 03 Aug 2026 05:51:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm32668847f8f.7.2026.08.03.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/9] bpf: Support __arena and __arena_nullable kfunc argument suffixes
Date: Mon,  3 Aug 2026 14:51:02 +0200
Message-ID: <20260803125115.2264733-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9639; i=memxor@gmail.com; h=from:subject; bh=uz/RM7znmnbGKpbOrQlYHVaWGwVBEkPaXbvj6NMss4g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb1O3uMKBWdfK09bIx9XtC9xzIlewp60kYmH//W1ZT IK/VQ90lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIrHBgZdnRIvmmTu6j50HqD vX3s2l2v9BbuMvn10/TJYnd/k/NH5jL8r53wnrGnMOuP9ps3L61frGVK/i1+3O5zCCeP9+ZNSS4 d3AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Passing an arena pointer to a kfunc takes two steps today. There is no
arena pointer argument type, so the pointer crosses the boundary as a
bare scalar, and the kfunc then offsets it by the arena base and casts
it before it can touch the memory. Every such kfunc open-codes the same
translation.

Add the __arena and __arena_nullable argument suffixes to make this more
convenient. The kfunc declares the parameter by its real pointer type
and dereferences it directly, with the JIT rebasing the value at the
call site, rN = kern_vm_start + (u32)rN. No bounds check is needed: the
u32 offset stays within the guard-padded arena kernel mapping, and a
fault on an unpopulated page recovers through the per-arena scratch
page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
matching global subprog arena arguments.

__arena rebases unconditionally, so the kfunc never sees NULL and a
value with zero in the low 32 bits arrives as the arena base.
__arena_nullable preserves NULL for optional arguments by skipping the
rebase when the truncated value, arena offset 0, is zero. Keeping the
plain form NULL-free saves the NULL test on every call.

This patch adds the verifier side: the suffixes are recognized in
check_kfunc_args() and distilled into argument flags in the function
model stored in the kfunc descriptor. JITs retrieve the model while
emitting the call, avoiding per-call state in insn_aux_data.

JITs declare support with bpf_jit_supports_arena_args() and verification
fails with -ENOTSUPP elsewhere.

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++++++++
 include/linux/bpf.h          |  6 ++++++
 include/linux/filter.h       |  1 +
 kernel/bpf/btf.c             | 18 +++++++++++++++-
 kernel/bpf/core.c            |  5 +++++
 kernel/bpf/verifier.c        | 40 +++++++++++++++++++++++++++++++++++-
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index cbde86d082cc..8e84484636c5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -278,6 +278,33 @@ An example is given below::
                 ...
         }
 
+2.3.8 __arena and __arena_nullable Annotations
+----------------------------------------------
+
+Both annotations indicate that the pointer argument points into the
+calling program's arena. The JIT rebases the value at the call site so
+the kfunc receives a directly dereferenceable kernel address, subject to
+the access rules described in :ref:`BPF_kfunc_arena_access` (at most
+``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access).
+
+With ``__arena`` the rebase is unconditional and the argument is never
+NULL: a value whose lower 32 bits are zero arrives as the arena base
+address (arena offset 0). The kfunc must not check the argument for NULL.
+With ``__arena_nullable`` such a value arrives as NULL instead and the
+kfunc must check before dereferencing.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_process_item(struct item *item__arena)
+        {
+        ...
+        }
+
+Calling such a kfunc requires the program to use an arena map and a JIT with
+arena argument support (currently x86-64); verification fails otherwise. The
+program can pass any value without compromising the kernel. A value that does
+not point into the arena is a program bug.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -515,6 +542,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 356884587ae1..6da8a6be930c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
 
+/* The argument is an arena pointer. */
+#define BTF_FMODEL_ARENA_ARG		BIT(2)
+
+/* The argument is nullable. */
+#define BTF_FMODEL_NULLABLE_ARG		BIT(3)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 32d5297c557e..36ce3403fe59 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_stack_args(void);
+bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5e8ac45ce56a..bf86df91a70b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
 	return flags;
 }
 
+static u8 __get_arg_fmodel_flags(const struct btf *btf,
+				 const struct btf_param *arg,
+				 const struct btf_type *t)
+{
+	u8 flags = __get_type_fmodel_flags(t);
+
+	if (btf_param_match_suffix(btf, arg, "__arena") ||
+	    btf_param_match_suffix(btf, arg, "__arena_nullable"))
+		flags |= BTF_FMODEL_ARENA_ARG;
+	if (btf_param_match_suffix(btf, arg, "__nullable") ||
+	    btf_param_match_suffix(btf, arg, "__arena_nullable"))
+		flags |= BTF_FMODEL_NULLABLE_ARG;
+
+	return flags;
+}
+
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
 			   const struct btf_type *func,
@@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		m->arg_size[i] = ret;
-		m->arg_flags[i] = __get_type_fmodel_flags(t);
+		m->arg_flags[i] = __get_arg_fmodel_flags(btf, &args[i], t);
 	}
 	m->nr_args = nargs;
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e2076667b245..a3e1fae32eac 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_arena_args(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_far_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..4c50237f49f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10907,6 +10907,16 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena");
+}
+
+static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena_nullable");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11127,6 +11137,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_PTR_TO_ARENA,
 };
 
 enum special_kfunc_type {
@@ -11412,7 +11423,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			reg_arg_name(env, argno), btf_type_str(t));
 		return -EINVAL;
 	}
-
 	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
 	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
 
@@ -11461,6 +11471,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = KF_ARG_PTR_TO_RES_SPIN_LOCK;
 	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		arg_type = KF_ARG_PTR_TO_CALLBACK;
+	else if (is_kfunc_arg_arena(meta->btf, &args[arg]) ||
+		 is_kfunc_arg_arena_nullable(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_ARENA;
 	else if (arg + 1 < nargs &&
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
@@ -12154,6 +12167,31 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
+		if (base_type(kf_arg_type) == KF_ARG_PTR_TO_ARENA) {
+			if (!bpf_jit_supports_arena_args()) {
+				verbose(env, "JIT does not support kfunc %s() with arena pointer arguments\n",
+					func_name);
+				return -ENOTSUPP;
+			}
+			if (!env->prog->aux->arena) {
+				verbose(env,
+					"%s arena pointer requires a program with an associated arena\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (regno < 0) {
+				verbose(env, "%s arena pointer cannot be a stack argument\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a pointer to arena or scalar\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			continue;
+		}
+
 		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
-- 
2.53.0

