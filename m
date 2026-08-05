Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312573D300F
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963877; cv=none; b=nN7BnXKaXF5loGUVdUker9XuneOrLUnl6kvq3mSj0HgOp1M86Vo60OUg/mzKv1ya7d4tjEe48hq9ml1Qm33VYFZuGqthAv1QE6hpbhxmblVfcLs+u1vA6nRPGxL9ei77yTJbUW3P5sAZgYiF2cqXG7lh8KORZrY+8MGv4Hfn2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963877; c=relaxed/simple;
	bh=DHgSf4l1a1mLcUiZ6hL5Y4lZ7a7AVuPxODW9oPwAir0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHwre9JnMfW/H6BkGxCZLUbf+MJ5scULSFNvHclwvIL5/pR5/YjlHcbPSO3f1y+8FY7dH/dhCWR6xP1mQDhlxu+se81X5mzjyvr8CYFkqFQ+YR5o0y6gphc3bMwTZcvUPhg+tISR6/NTkNMiErvQc+9IlqVOmdK5JbgwWYg05h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnN3REjv; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnN3REjv"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso380559f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963873; x=1786568673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=85bYXU4k96j1VpyHuNwzz0Wnjv3u8MSTqKrjI8LsmE8=;
        b=nnN3REjv+xUD8xYAb16SB1bi3YgxjdzWawQyU5SA5G2Iw4WXuO2rMBHrhb+qOuIezE
         6zb9+xlQ7VMqHtK8waP5XbK03b4uyYJ5SsLb+58kTfOKzOuRzcBO5ky/Rjjrxb9msOI+
         VduGoN0JWC46Fdtx9GoBJ4NY1xoq+GCeqcOuUHG1eB7UNMvY4GewUsOZKW7ifnIZ2lLe
         KbrZ3/KHUcQLoHehLQ4Xx56nNJp/5Lfzetbj/QeJxsHeJJd+pguJYx66OSk01JgpMfAZ
         fR1DErhGjXFSCpXP0LLKJhgKzooe2f/nbRDaB7HjrAsU6N4Sd4eALTbfWx/YFBV/voUv
         9Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963873; x=1786568673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=85bYXU4k96j1VpyHuNwzz0Wnjv3u8MSTqKrjI8LsmE8=;
        b=n40sKfhwupFPe470rwi83VYzYt5qOyosyBgv0XppgI/UIgKYSi/YkIAu8pJNBVVkYF
         1qjlJ5R12mqMTKFaw5xbVIJpaLVB8EDRsKBueaLob5qitXWiQWcFBNH1oG3rWfecyYGO
         2fDJ3a3m5oX5qlVwWuVKEjnoEZn+trojAIAY4anCgSc1aODbSwlL8V5hOFPtaU7BqfYB
         IN4YK4oi8E0jA1E6Z77V0/vGHHFZ+ZIjDCGBDBADxo7UmOMCX/1WTYRZGvWzX8H036bB
         /pgh+lezH+EoeYoKKQi3qbNmLapR/6KWdXZ2/l2yuDgK39xTl1GSPDLRPrnOXOaykmuq
         wNeA==
X-Gm-Message-State: AOJu0YySCI895Zrb+e1oxT0l1fYy9CnFdxXP08qDrOQV0Kvh0D0RJ0Hy
	dnu2t68zCr40Ih4r4qmSbou1b77uWHGC8qKAiHr9UboQ2sKjZEQQ6U8p93gyUJmT
X-Gm-Gg: AR+sD13zSy6URHAFbGtkYD6kbr/nm/XwGZW49ONfg1SX0KziLbHc+meKh6KZc7QBD/J
	t6lpHVy6RGontZ43W9BT83q6v9X31xuFKp/2IT/NzVjRlKyoDZDe/PNszgHgOWw769sA6HQph4u
	BFPHg1hZQgH3vHdgjnm5YjGmDa+q9/iZg2/s3Fq4na7+jXras4e3llMYq/Xwhu2sYrbqizLoEQL
	natA+ybt1jciwDRYYujhD8oIhiPIhohz+M7bu8rOTweXBkAtfPSHu3EXTFaSB4BipuF4PCsWNCq
	b9s/G8SzKR81AeQkyLoc6xAa20273YoLBFVO6+BOQOlnN1R6iHnqTH3E63P1c+Ip0ou08D77H8G
	qA2NyPcz4vXXI27MDb7hyv9xc1SQkAlWQRL8CINe7PK/Lg+5no0HEBe03veS1IadPesV3BR0lEI
	S4+zgMgGY0bv0KyB31VJsmg1S9lxAmP4z7zMxlu0BgLd+AZca3Nn+IcMT61WDLGGfKQ/kehKcBb
	LGlPMXt7oPNyogQVzGH9c1l7645vJMsPESWzs26a3dE5R0HTRPEbNHSxP/sI9nN9fwliOOqWCrQ
	jiKj/5+TCIVZG9IjxRRBdH7N470=
X-Received: by 2002:a05:6000:2995:20b0:47f:959f:f69c with SMTP id ffacd0b85a97d-47fec512853mr14269236f8f.7.1785963873214;
        Wed, 05 Aug 2026 14:04:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b32b1sm331768f8f.9.2026.08.05.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 04/13] bpf: Support __arena and __arena__nullable kfunc argument suffixes
Date: Wed,  5 Aug 2026 23:04:15 +0200
Message-ID: <20260805210427.3218326-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11396; i=memxor@gmail.com; h=from:subject; bh=3HGPInpQOt3JMr4TOBZ5qDLsGU6G7O5JeXLp+1UQO6c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40eS233e/uTK8nfL38pLVlv+/Xc1eW3VFbtUMx58bX 1d+8pm6pKOUhUGMi0FWTJGl5P8+JuMTlb8DbZdxw8xhZQIZwsDFKQATCUtjZNig8TzUKNXgxp+K ZY4LPnT4B0uKWa2TvzOLle/CHcNWHndGhjllR6bMPPUxjXO11tLH0l+Vv+vdPJq6cXP6KYv1ZTf Nf3ABAA==
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
__arena__nullable also ends in __nullable. Match the composite suffix
first when classifying kfunc arguments and function-model flags so it
retains arena semantics while carrying the nullable flag.

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
 Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++
 include/linux/bpf.h          |  6 +++++
 include/linux/filter.h       |  1 +
 kernel/bpf/btf.c             | 18 ++++++++++++-
 kernel/bpf/core.c            |  5 ++++
 kernel/bpf/verifier.c        | 51 +++++++++++++++++++++++++++++++++---
 6 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index cbde86d082cc..cd9b90d072cf 100644
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
@@ -515,6 +542,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..f47556b56a48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1210,6 +1210,12 @@ struct bpf_prog_offload {
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
index b62e77949542..2b7f6f6bbe76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10909,9 +10909,16 @@ static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf
 	return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
 }
 
+static bool is_kfunc_arg_arena_nullable(const struct btf *btf,
+					const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__arena__nullable");
+}
+
 static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param *arg)
 {
-	return btf_param_match_suffix(btf, arg, "__nullable");
+	return !is_kfunc_arg_arena_nullable(btf, arg) &&
+	       btf_param_match_suffix(btf, arg, "__nullable");
 }
 
 static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const struct btf_param *arg)
@@ -10929,6 +10936,12 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_param *arg)
+{
+	return is_kfunc_arg_arena_nullable(btf, arg) ||
+	       btf_param_match_suffix(btf, arg, "__arena");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -11149,6 +11162,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_PTR_TO_ARENA,
 };
 
 enum special_kfunc_type {
@@ -11434,7 +11448,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			reg_arg_name(env, argno), btf_type_str(t));
 		return -EINVAL;
 	}
-
 	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
 	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
 
@@ -11483,7 +11496,29 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
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
+		 */
+		arg_type = KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL;
+	} else if (arg + 1 < nargs &&
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
 		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
@@ -12177,7 +12212,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
 		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
-		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
+		    !type_may_be_null(kf_arg_type)) {
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
 			return -EACCES;
@@ -12230,6 +12265,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
+		case KF_ARG_PTR_TO_ARENA:
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 			arg_type = ARG_PTR_TO_DYNPTR;
@@ -12296,6 +12332,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
2.53.0

