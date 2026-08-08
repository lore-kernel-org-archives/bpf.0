Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2241C72
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149595; cv=none; b=p2nbM6D0+YxMlxeLisAlDlg9NcSS4ALFo972YnE7OB7s1wISqauV13LOL/iFhN2rR69ZElJ2EusEErENeC/j8L1yMY8Lzut4epj+4rESPnSflRzaJ/k1Ne/peEGKVUiLrxDX9RMpdjGBes6ed26GrI2NIuBKe4N9y4YcYML/K7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149595; c=relaxed/simple;
	bh=48JIH2D5X1qmWNGi0TTbV2lPTVQ6kicoL7e8TEDJprE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUjCfUF3/8finnHBfufrK7L7MYAajkRI0qpXxuKnLS0O6WZrnNI+bwJydM4t1Lop37Sh+fqA3HXZDm69dRUBTlEl/AyEILxzquLkMG+FP9fxHO8kusSYgXvc3vz6QxTqwL02EKb5u2Ej1KuVeIrsG+FhhDWnhBuW1IUr5EorOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/QTbvWm; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/QTbvWm"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-7ea63f91262so48450a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149592; x=1786754392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KA+cL/bdyJGJlBXsB+zRACpxkLIHJeH156k/3o5VOIQ=;
        b=q/QTbvWm3X2Km70JxJI47CTgANoVPuBsK8ZBMOkyotCOy/4m+0s+2LU4Abz1tDzAXg
         LZD1vIYMc4NwZ73kIAONSXma9Fv33jtibCxNnNQ1g8wdX9EOIjHBJJIMapYfoa/Djzqq
         /2LapvmPlQpP8I3E6poU9onADitzF3zwet7h1UW7VXjF/ftCsl5bvK83FEptNbEKAQo8
         jKyqof0Nqigtecj96LpwF2G+h2rlF1c6Wt6bSjkqiPFX9HwijhNXkDg8UTaExPR+vVN5
         uZ22ssJwdsZSiouHv+QxJq2dPqFu/JAlmuGCKlLOnUlRp/ak6Z2tUNk6/MXOqpHkS90P
         9RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149592; x=1786754392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KA+cL/bdyJGJlBXsB+zRACpxkLIHJeH156k/3o5VOIQ=;
        b=i68OPthAMFSMBGecDdHQxAm4CNDpo3FVaCBpz5vUXIEVVQCP0+7Jrj0hIpzVJ+HULw
         gR1mzrviOO0FwPEf6BzQX7kOiM+1eujzN7ZAhg6lmNLwyAJctSoFh7U/7xcnTZ6biJwp
         CWM2eWsp7KjoNaxF8awM1zRtLtUW8jK8zrKpKz9ZZNLQgBFCwmpS4S4jvy75oN2yxLBl
         p7wWv5RA321LFCfxoeyCET1xrSIMGvUO++sCHFuvK6h+d94rX31eU97RxZyR0/zzOiiM
         WEJYymC/Y1fOukt1QbRMwAbNYcavYdY+TO+oEvZDQwVxVQrFYFDXbmpPzciY4uZ8Sw7f
         i9uw==
X-Gm-Message-State: AOJu0YyYO6bhlZsXSOmOlEdhy83gZ8nye81x2DmkTP03dwRPqsi5Nelb
	YG1PAHhrX1FPjdbRjdg8LSklXgKLMIdwWSnUvGmb6xlKfhhUpZukYTSWVrHsk5fxtOQ=
X-Gm-Gg: AR+sD124ysKmcIKsAq86vLuNv5lDcV9VtHHdMFkOHGnIpmtsYZ7BtHpd6r5f3xgie+k
	XbHCnNDDZ3aV/fSHiYWNraUo5tTS7t/PEnvaS10nb0J6+BV1GL3w3u8okLh06zBb8YDQBjRQVeA
	kj+XfDiVYP9ghWV/ev/Lgs6QPfec7xX3T4xxCiUkjQAvofjCk5FYHeeM42yiD/d9gNsm6ixtqO+
	fbaYztWFmr4eemUQ5JwkvyaZoqUm8GLpB7/rSQzdl4H9TLJ7/G7SzLf24VDPuHjlPjSjmlBRAhV
	wmWkncwIB83b/4ASJVzS10ubn75FeQPooP7WAd0JwTqAVggF9Tr3xFlaGqjCQU1YcXWfCJz2+cp
	5ElKw+rX5eO4obDvcukunXF1zHfVeq+E8HssvmexGX9TnitS812GSf8SZWwftzm0Z9MywkW3BNL
	jzOvT9fJiHmEu6lYQWMczgBARdlXKfY5sf8/GRrdKCDWN9HCxokqW8dw/MBE2rRMPF51yzrYBEM
	tbwpKue1mbr4M2ZTd7XQM4Qj6rcVhLrxtpjQKZOfJGKDZgqvEwLU99xqhRD3zJRx7bbh4M=
X-Received: by 2002:a05:6820:827:b0:6aa:9be1:4844 with SMTP id 006d021491bc7-6ae96c17bdcmr13115061eaf.5.1786149592004;
        Fri, 07 Aug 2026 17:39:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc76279sm3717491eaf.7.2026.08.07.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/14] bpf: Support __arena and __arena__nullable kfunc argument suffixes
Date: Sat,  8 Aug 2026 02:39:24 +0200
Message-ID: <20260808003938.3486067-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11394; i=memxor@gmail.com; h=from:subject; bh=1EWMFLETkzaaVfhbT/jHF9Wn+FeMMr+bG90gOHc4mys=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqsLqSHH9c5EHjfdVw855/5M4arVRe37+xDOZZxdsnSJt cL69o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZ1s/wP2DS7L8rlmxNeKm6xsKv+g GvkBNzyjS3ub1bGHV2LHeb78TIMIXN7/vTZo5mQ4fAFX9XTL699GcU25d4/+bLxlPWWU6z4wUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Passing an arena pointer to a kfunc takes two steps today. There is no
arena pointer argument type, so the pointer crosses the boundary as a
bare scalar, and the kfunc then offsets it by the arena base and casts
it before it can touch the memory. Every such kfunc open-codes the same
translation.

Add the __arena and __arena__nullable argument suffixes to make this more
convenient. The kfunc declares the parameter by its real pointer type
and dereferences it directly, with the JIT rebasing the value at the
call site, rN = kern_vm_start + (u32)rN. No bounds check is needed: the
u32 offset stays within the guard-padded arena kernel mapping, and a
fault on an unpopulated page recovers through the per-arena scratch
page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
matching global subprog arena arguments.

__arena rebases unconditionally, so the kfunc never sees NULL and a
value with zero in the low 32 bits arrives as the arena base.
__arena__nullable preserves NULL for optional arguments by skipping the
rebase when the truncated value, arena offset 0, is zero. Keeping the
plain form NULL-free saves the NULL test on every call.

The double separator makes the annotations composable:
__arena__nullable also ends in __nullable and naturally follows the
common nullable argument path. Plain __arena follows that path too for
verifier type checking because both forms accept a constant zero; the
function-model flag still determines whether the JIT preserves NULL or
rebases it to the arena base.

This patch adds the verifier side: the suffixes are recognized in
check_kfunc_args() and distilled into argument flags in the function
model stored in the kfunc descriptor. JITs retrieve the model while
emitting the call, avoiding per-call state in insn_aux_data.

JITs declare support with bpf_jit_supports_arena_args() and verification
fails with -ENOTSUPP elsewhere.

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 29 +++++++++++++++++++++++
 include/linux/bpf.h          |  6 +++++
 include/linux/filter.h       |  1 +
 kernel/bpf/btf.c             | 18 +++++++++++++-
 kernel/bpf/core.c            |  5 ++++
 kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++----
 6 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 021be6d93dfb..9c205d8b5fff 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -278,6 +278,33 @@ An example is given below::
                 ...
         }
 
+2.3.8 __arena and __arena__nullable Annotations
+-----------------------------------------------
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
+With ``__arena__nullable`` such a value arrives as NULL instead and the
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
@@ -522,6 +549,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d79bf7557ef6..ba1b9d8ac348 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1195,6 +1195,12 @@ struct bpf_prog_offload {
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
index 41b02d53e222..4edba8182db1 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1214,6 +1214,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_stack_args(void);
+bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 42414633cf26..4ff6148ae8e8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7539,6 +7539,22 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
 	return flags;
 }
 
+static u8 __get_arg_fmodel_flags(const struct btf *btf,
+				 const struct btf_param *arg,
+				 const struct btf_type *t)
+{
+	u8 flags = __get_type_fmodel_flags(t);
+
+	if (btf_param_match_suffix(btf, arg, "__arena__nullable"))
+		flags |= BTF_FMODEL_ARENA_ARG | BTF_FMODEL_NULLABLE_ARG;
+	else if (btf_param_match_suffix(btf, arg, "__arena"))
+		flags |= BTF_FMODEL_ARENA_ARG;
+	else if (btf_param_match_suffix(btf, arg, "__nullable"))
+		flags |= BTF_FMODEL_NULLABLE_ARG;
+
+	return flags;
+}
+
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
 			   const struct btf_type *func,
@@ -7604,7 +7620,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
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
index 7936a42097da..099ee2df217b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10936,7 +10936,8 @@ static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf
 
 static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param *arg)
 {
-	return btf_param_match_suffix(btf, arg, "__nullable");
+	return btf_param_match_suffix(btf, arg, "__nullable") ||
+	       btf_param_match_suffix(btf, arg, "__arena");
 }
 
 static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const struct btf_param *arg)
@@ -10954,6 +10955,12 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena__nullable") ||
+	       btf_param_match_suffix(btf, arg, "__arena");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11174,6 +11181,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_PTR_TO_ARENA,
 };
 
 enum special_kfunc_type {
@@ -11459,7 +11467,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			reg_arg_name(env, argno), btf_type_str(t));
 		return -EINVAL;
 	}
-
 	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
 	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
 
@@ -11508,7 +11515,30 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		arg_type = KF_ARG_PTR_TO_RES_SPIN_LOCK;
 	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		arg_type = KF_ARG_PTR_TO_CALLBACK;
-	else if (arg + 1 < nargs &&
+	else if (is_kfunc_arg_arena(meta->btf, &args[arg])) {
+		if (!bpf_jit_supports_arena_args()) {
+			verbose(env, "JIT does not support kfunc %s() with arena pointer arguments\n",
+				meta->func_name);
+			return -ENOTSUPP;
+		}
+		if (!env->prog->aux->arena) {
+			verbose(env,
+				"%s arena pointer requires a program with an associated arena\n",
+				reg_arg_name(env, argno));
+			return -EINVAL;
+		}
+		if (reg_from_argno(argno) < 0) {
+			verbose(env, "%s arena pointer cannot be a stack argument\n",
+				reg_arg_name(env, argno));
+			return -EINVAL;
+		}
+		/*
+		 * Both suffixes accept a constant zero. The function model determines
+		 * whether the JIT rebases it to the arena base or preserves NULL.
+		 * The common nullable path below records that verifier property.
+		 */
+		arg_type = KF_ARG_PTR_TO_ARENA;
+	} else if (arg + 1 < nargs &&
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
 		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
@@ -12183,7 +12213,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
 		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
-		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
+		    !type_may_be_null(kf_arg_type)) {
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
 			return -EACCES;
@@ -12236,6 +12266,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
+		case KF_ARG_PTR_TO_ARENA:
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 			arg_type = ARG_PTR_TO_DYNPTR;
@@ -12302,6 +12333,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				meta->ret_btf_id  = ret;
 			}
 			break;
+		case KF_ARG_PTR_TO_ARENA:
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a pointer to arena or scalar\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			break;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
-- 
2.53.0-Meta

