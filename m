Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13213BADBD
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152858; cv=none; b=fhfLJ7IBPi+pMPWkAvkQmzeZtKYIMYiPyLOZfuMxz7hPIG4XGB0yg8I2pvwmjANmNfbVLGluffZzIwVzfu3rWCRpF/fL/yOSRm5YqEbywRDV/5+SwRU45kSKYMrt8F/S8MDrRYn6mgD9qX0Er1WNYgUNORgGdksjpKogWvLbJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152858; c=relaxed/simple;
	bh=RDuXZkY3cV9899KL7rFkT+K+IM4qtzLOU4vpYErha5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dcw8fErpbojSpxsR23ezDH4CaY3owJv/ssXKlQCYYi8xCjW0gpSrOty26E0Z2gHVbzUcFjvFoiC6Yp0i7TBinDIoUrJPCzNYRmKabZ6+yugg79i5qA6siQZKmWPN6O0kzQ0BlEGyqqxwFOOm/O8tQEbtRFiQW41YlFJsRWMH2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8GYJg0k; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8GYJg0k"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so678043f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152855; x=1784757655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8Bp8f+9I30ODZzhr5gRZj2lZedpx46KirqY7kjA8ag=;
        b=M8GYJg0kHqWuSL8+xc5xpKeijqt84Al7Xcg2ACSUmR9Eow3xEURCgGZbprIEVD1lZD
         /W2fAvVbKdB9N2ju40aJZVPwhnyX64pYHH2pbtDWIV2lSoe/4q5jnhPfux/iK3kE274W
         C1E9DJJC5veXJwwod83gUGQG1xqvWQsMwJL8zNDaxpJVEJ+smU+/IFDFlbdJ3JCCcDcc
         XgJY+2waiLUS6jyJ8X6RnwUfcsV6N81numW0dgQguQAG1c3peFAkea8B0RZb7ncdLbc/
         0wU+Su+94BCFG6luMqPB90RXOCkzgRg5M9YDe7Ih+RYQMtV9uZ7qdmlsGvLlPi97NU9U
         c2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152855; x=1784757655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8Bp8f+9I30ODZzhr5gRZj2lZedpx46KirqY7kjA8ag=;
        b=EQXOJnfV+1C8XyGXa6J3Ltlt8at/xIVo0s6IHuZU+KUlQP5UVgQQrMq23ztMAc8YK9
         +Tx1FV7H/zTz++MH+4MU5k/dPV2BX5cXp3LhJMUth/X4we9wg9remwk/7gNQopdoCCyH
         T0nB+FXxtf1G2nz5U6N2fMpaRQ9YZ3FJGXp679S4VeB48WO0bWYXvliMcb2JxRV9fYCl
         l3jmTxHM9yEXEXiqIfatxWuT/b2FUaOx6ofP5D5hXw7U9NiMleCCYZlRfilqogpeQp6a
         tg+Tvf2HjNIjsmMUMtpeBa+9jaoG0CZ+/zlwDhQuh3s64hJTrStxtNYfQN+lr85RwK/1
         kqAg==
X-Gm-Message-State: AOJu0Yz5bb/ItLkZukDbrspeNlywHHVgq7PV4BwkQa1m1SltUltOnj0C
	aIXYeLfoqnb9074Q8Wq5Ov7M/PB0MDPnIKXmuFf2VuUXWIUe8ZtGr7cmOE/FnZE/
X-Gm-Gg: AfdE7cm3dgdMyLJ+1//2/mB6tcQQHgRezGPJ9UiBOioeeja7t975lQy2aJqc1TjvPUh
	QDeBfF9n47UQxdCwJq9x2Hyn864/0702lJClbawx5dPJFtUzxMSgMwMP7apPLeyf6Qlg6dJ6G6y
	iJd0I+anqj0IadZAQc+M4NSIPouvn7Shyw1aq3EP0G3emdwqZ3TSoKpbjal4NHObXGzPp7v6yrw
	axv0sCalQeCImLk9fU5Z6daN8MzA+aAiBU+4/GbsHysCNEQ9uAF3wsTlrJOtggMKk8yQnbSz93W
	Ky4HiEMQ+66OXcfJPGhKP92U5cOPIl8SgG2/7Xi9wlN38Vkvto4+CSiU5opLH5zb3MEmdw0oN7P
	7nkLLcHQYMTsVABT7XPDIjz42kQRWq+4WBKCoOVZRRTNRtD/LaJbWcy+AfjQJPPA1djp4p83HNb
	Q9SENlcncUZw97vyQDQrjNmZ4A8OIMHOPLD6M+4ru0PfkPhEmXuNaehxztaUqihWH4vxDYtkuXZ
	B0s1kvnaBO6+g40NtB+aSCR0PEq4TTFUuzBXVEbLLI9
X-Received: by 2002:a05:6000:2207:b0:47f:25e4:5c34 with SMTP id ffacd0b85a97d-47f2dcd79f1mr22638976f8f.29.1784152854775;
        Wed, 15 Jul 2026 15:00:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c30a9sm18686518f8f.31.2026.07.15.15.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/9] bpf: Support __arena and __arena_nullable kfunc argument suffixes
Date: Thu, 16 Jul 2026 00:00:41 +0200
Message-ID: <20260715220052.1590783-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9337; i=memxor@gmail.com; h=from:subject; bh=8k0B93UlZWCZ5jplV+Da6xKBO0g0jdtMyWQP9bIvLDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6daHQz6cM+67WsR3Xn64NCPkoMiinXeuBH+0/akZe ++ZOW9XRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy5zTD/5BL/0se6j14VxSd EaDRlvApqUbgf87HCRkBXqWFOjucoxkZ+q/H7Mm0nphwKfSWUenbZZNlDjKyux1N71STMVFve2/ DBgA=
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
check_kfunc_args() and recorded as two per-call register bitmasks in
insn_aux_data, which JITs retrieve through bpf_kfunc_arena_args() while
emitting the call.

JITs declare support with bpf_jit_supports_arena_args() and verification
fails with -ENOTSUPP elsewhere.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 29 +++++++++++++++++++++++++
 include/linux/bpf.h          |  9 ++++++++
 include/linux/bpf_verifier.h |  4 ++++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            | 18 ++++++++++++++++
 kernel/bpf/verifier.c        | 42 ++++++++++++++++++++++++++++++++++++
 6 files changed, 103 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c801a330aece..a980266ec788 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -250,6 +250,33 @@ Or::
                 ...
         }
 
+2.3.7 __arena and __arena_nullable Annotations
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
+Calling such a kfunc requires the program to use an arena map and a JIT
+with arena argument support (currently x86-64 and arm64); verification
+fails otherwise. The program can pass any value without compromising the
+kernel. A value that does not point into the arena is a program bug.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -487,6 +514,8 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
+.. _BPF_kfunc_arena_access:
+
 2.8 Accessing arena memory through kfunc arguments
 --------------------------------------------------
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31181e0c2b80..08d1aec8e30e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1601,6 +1601,15 @@ void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
 				 int insn_idx);
+
+/* which R1-R5 args of a kfunc call carry arena pointers to be rebased by the JIT */
+struct bpf_jit_arena_args {
+	u8 regs;
+	u8 nullable_regs;	/* subset of @regs where NULL is preserved */
+};
+
+struct bpf_jit_arena_args bpf_kfunc_arena_args(const struct bpf_verifier_env *env,
+					       const struct bpf_prog *prog, int insn_idx);
 u16 bpf_out_stack_arg_cnt(const struct bpf_verifier_env *env, const struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_tramp_node *node,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 682c2cd3b844..8ed1ea315581 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -690,6 +690,10 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	/* bitmask of R1-R5 kfunc args to rebase to arena kernel addresses */
+	u8 arg_arena_regs;
+	/* subset of arg_arena_regs where NULL is preserved across the rebase */
+	u8 arg_arena_nullable_regs;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14acb2455746..7b673333f846 100644
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
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..db99e01f11fc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1640,6 +1640,19 @@ bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struc
 	return env->insn_aux_data[insn_idx].indirect_target;
 }
 
+struct bpf_jit_arena_args bpf_kfunc_arena_args(const struct bpf_verifier_env *env,
+					       const struct bpf_prog *prog, int insn_idx)
+{
+	struct bpf_jit_arena_args args = {};
+
+	if (!env)
+		return args;
+	insn_idx += prog->aux->subprog_start;
+	args.regs = env->insn_aux_data[insn_idx].arg_arena_regs;
+	args.nullable_regs = env->insn_aux_data[insn_idx].arg_arena_nullable_regs;
+	return args;
+}
+
 u16 bpf_out_stack_arg_cnt(const struct bpf_verifier_env *env, const struct bpf_prog *prog)
 {
 	const struct bpf_subprog_info *sub;
@@ -3296,6 +3309,11 @@ bool __weak bpf_jit_supports_stack_args(void)
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
index de816063ae63..2affe2e1a6a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10833,6 +10833,16 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
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
@@ -12042,6 +12052,38 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
+		if (is_kfunc_arg_arena(btf, &args[i]) || is_kfunc_arg_arena_nullable(btf, &args[i])) {
+			if (verifier_bug_if(!btf_type_is_ptr(t), env,
+					    "kfunc %s arg#%d has __arena tag on non-pointer",
+					    func_name, i))
+				return -EFAULT;
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
+			cur_aux(env)->arg_arena_regs |= BIT(regno - BPF_REG_1);
+			if (is_kfunc_arg_arena_nullable(btf, &args[i]))
+				cur_aux(env)->arg_arena_nullable_regs |= BIT(regno - BPF_REG_1);
+			continue;
+		}
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-- 
2.53.0

