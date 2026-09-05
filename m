Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8876380FC5
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645711; cv=none; b=h0vZmQeF02ouoooAhSL99Mffr61eP+wXdV2ZmHj6J2wbUr7g5eSH7IDrvqS02u+5MkHBXJ3EkGMhtAs6RPdQPFnoWJySJW274OxZrvcoVQVuXCIXLtgmhWAOF3ZkbPsDQqLpOD+fInSMJRLBZX4FCNtAqCxOJxoLXLIXX67mC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645711; c=relaxed/simple;
	bh=LxoM/1CDa/mlOcnQ0ex/HbJVaLjpqDg0ilV19bagU5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwP+SLVO252Jbmns84740u/w2CSH2w5Bvmb6VsUPZLBtKp2WAQLATSucKPORydl9ZTRKwYiYiFUDrX9L4NuRNoNWr5hiAFVyoynrbzGBdW6A50sRVCg3JYUewU9wJ8b5z5zA4aOhzfRliTq8EhbFRAEnNmCvTevQXsSQlxOoIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqcNdJvS; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqcNdJvS"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f4b94d72acso2157455a34.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645707; x=1789250507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaOtx/7YN+jXTQGrtfYojDsfyFt5rVVU1Z/E90/jdPY=;
        b=BqcNdJvSnnvn9RecOEqpfYZ8LtBUbmlWPOaHlOY5j55x2jmc5n0SvkHLj8ORAMjKgY
         0JaORoo2Cndz8nIo4ATxvnwcF0ApTeExIC/4nTKk/lnkL4zPexMxxj/uTii2osQU9iE6
         SNDIj+L4ML3R+tjBUUu/cfjdoAJRpva+ZYZGWURuvLCk6jk7Jq/1by+B3fMqT9H/yoqY
         yVnc+vVvOQ52abOlJXb7o68mPhr9SVJobrTDzSc1inhX8xvF4CuIcvgcFUYBlC1uu6HI
         sINI8c6Z3NM+JLKnrAY4tJ1AEmQKKmWj6On9alv8ToYtHcXTrSVKj73lJHq+AZS/3JBX
         FEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645707; x=1789250507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaOtx/7YN+jXTQGrtfYojDsfyFt5rVVU1Z/E90/jdPY=;
        b=igkiRV0TiRSppPp1pnoDgnYRP5V66QE6JSRwwiXTrsflNyDiXCNVCHWlZ0C8qwc1kY
         F8Wq+w4AmpjveEweRTR2uZZeHDVG5FXcra+K0H+Qg3jiQjK0q+Nt6rl2EZISfzOWJniU
         02I0rs4dICHUAyfFu+IUbMBkYclpLngYLqLllsXdwihRa346TjfSo1XZnrIuFdSQ1jfl
         s8No6sJ8Y1XwTGbv9PU0CSmz9mzeGs+SvwraqLI/VevX7Y4LgMipEL+GjLUMEKjOofHc
         SsVkL/LixvN7ZKX1PITYHw6qCtbjKzxhQTjufidl/pFBB4B6ygCF+Lj5NkzQzIUqd9HT
         DtKg==
X-Gm-Message-State: AFuF++kAaWHB+MjxdkoRZt1c2TiTmDkl70jLsRdS4+DkSKmRCwoow3tb
	eKY+qOThgTEVUjfsFYSMorJMb4jLdQzSvDMffijBRiMg60JQ3hGzpa0UEBEPng==
X-Gm-Gg: AYBFou2FlniIorjBrAiDd3ZSzI6uzEkz5Croo2Dn2A9JX6N+S58FIm5Ly7+3GC3+pL8
	yA+g2nJKaV9E4GQ3NIYoPBt6aKtPII1V/BRplhwwE1SNtQ1akh5muOLx5862C5y838pGyKmHCPJ
	46NkNJVkqgLknbWIHwmSQoSImV4CHB2x4nfyUcxJObzOcmUlFeTbbIjwf2V86Y471lQujH8G8v9
	Gt81HLBaG/H5muy9fDh6ZT3HtqkK7rQzo//3yJDFiMZsLIVMo0K0HQkm7vKUe6uf2g+d+9+a3ub
	wGYtvKsmZVDbIgesFe001qz4u37HfJw21PfLmYgFARiPIq7ZfZOJUyN7F7in2pSLQ5thCsUKrOK
	2+ATm6w7viYeIqQeHY230P+NVRHhoWupnVl7H+DYYaASvj/6lFZXK6wqerFWIeqfVlqM+HNO7f9
	V4Rmj+oHfKcFqs893zkyzWoO3tfBm3B/wTyVuStuq8BqJXJUnKa6Y=
X-Received: by 2002:a05:6820:4cc5:b0:6b2:c720:456d with SMTP id 006d021491bc7-6b6fa8e0294mr9091042eaf.6.1788645707140;
        Sat, 05 Sep 2026 15:01:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dbedc6fasm7950866eaf.3.2026.09.05.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:46 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 18/22] bpf: Admit kfunc argument registers through check_reg_type()
Date: Sat,  5 Sep 2026 15:01:13 -0700
Message-ID: <20260905220117.922028-19-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() open-codes exact register-type tests in most of its
per-argument cases, duplicating what compatible_reg_types[] already
expresses for helpers. This leaves two admission paths and prevents the
helper and kfunc loops from converging.

Runtime argument resolution now converts a scalar-struct BTF argument
to fixed-size memory before register admission. Give the remaining
kfunc-only argument kinds compatibility entries and run
check_reg_type() once before the per-kind switch.

For ARG_PTR_TO_BTF_ID, let check_reg_type() admit BTF-backed register
types and reject incompatible register classes with its standard
diagnostic. Remove the now-unused lookup_reg2btf_ids(). Exact BTF
identity and trust requirements remain checked later by
process_arg_ptr_to_btf_id(). ARG_IGNORE and ARG_PTR_TO_PROG_AUX remain
skipped because the verifier does not read those arguments from the
program.

Iterator arguments use the stack-pointer table. Graph nodes and
ARG_PTR_TO_REFCOUNTED_KPTR share a table for owning and borrowed
allocated-object forms; their switch cases retain the API-specific
ownership and BTF-record validation.

Rename timer_types to map_value_types now that ARG_PTR_TO_WORKQUEUE and
ARG_PTR_TO_TASK_WORK share it. Similarly, rename spin_lock_types to
map_value_or_alloc_obj_types because graph roots and resource spin
locks share its map-value-or-allocated-object admission.

Moving admission checks into check_reg_type() must not discard the
structured call-argument diagnostics emitted by the individual cases.
Add bpf_diag_arg_type_plain() alongside bpf_diag_reg_type_plain() and
use it to preserve the existing per-kind Pass suggestions where
available. Other argument kinds retain the generic suggestion. The
reason continues to report the actual register type and all accepted
register types.

Two behavior changes fall out of running admission first:

  - ARG_CONST_MEM_SIZE reaches process_const_arg(), and through it
    mark_chain_precision(), only after the register is known to be a
    scalar. Passing a pointer as a __szk argument used to reach
    backtrack_insn() with a non-scalar and trip the backtracking-misuse
    verifier bug.

  - ARG_CONST_MAP_PTR no longer needs its own type_may_be_null() test,
    because check_reg_type() compares whole register types.

Every kfunc argument that is not explicitly ignored now passes through
check_reg_type(), followed by the common register-offset check in the
same order as a helper argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/diagnostics.c                      |  29 +++
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/verifier.c                         | 233 +++++-------------
 .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
 .../testing/selftests/bpf/progs/arena_kfunc.c |   2 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   2 +-
 tools/testing/selftests/bpf/progs/irq.c       |   4 +-
 tools/testing/selftests/bpf/progs/iters.c     |   6 +-
 .../selftests/bpf/progs/iters_testmod.c       |   3 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   3 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/res_spin_lock_fail.c  |   2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
 .../selftests/bpf/progs/task_work_fail.c      |   2 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 18 files changed, 108 insertions(+), 199 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index b682fd2be443..c740ae070e61 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -960,6 +960,35 @@ const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_t
 	}
 }
 
+const char *bpf_diag_arg_type_plain(enum bpf_arg_type type)
+{
+	switch (base_type(type)) {
+	case ARG_MEM_SIZE:
+	case ARG_CONST_MEM_SIZE:
+		return "an integer scalar length for this memory argument";
+	case ARG_PTR_TO_CTX:
+		return "the original program context pointer or preserve it before modifying registers";
+	case ARG_SCALAR:
+	case ARG_CONST_SCALAR:
+	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
+		return "an integer scalar value for this argument, not a pointer or resource object";
+	case ARG_PTR_TO_CONST_STR:
+		return "a constant string pointer that the verifier recognizes, such as a string stored in a read-only map value";
+	case ARG_PTR_TO_DYNPTR:
+		return "the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path";
+	case ARG_PTR_TO_ALLOC_BTF_ID:
+		return "a pointer returned by the matching BPF object allocation path";
+	case ARG_PTR_TO_REFCOUNTED_KPTR:
+		return "an owning or non-owning pointer to a BPF-managed object containing a bpf_refcount field";
+	case ARG_PTR_TO_ITER:
+		return "the address of a stack iterator object for iterator new, next, and destroy calls";
+	case ARG_PTR_TO_IRQ_FLAG:
+		return "the same stack slot used by bpf_local_irq_save() or bpf_res_spin_lock_irqsave()";
+	default:
+		return "a value with one of the accepted pointer or scalar types for this call";
+	}
+}
+
 static const char *diag_arg_ordinal(int argno)
 {
 	switch (argno) {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d1b79945008a..a4102fb049ec 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -51,6 +51,7 @@ const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list
 const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type);
+const char *bpf_diag_arg_type_plain(enum bpf_arg_type type);
 u64 bpf_diag_event_log_save(struct bpf_verifier_env *env);
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos);
 u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd3fea62aa02..cad49ea5fdfa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5134,18 +5134,6 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
-static enum bpf_reg_type lookup_reg2btf_ids(u32 ref_id)
-{
-	enum bpf_reg_type type;
-
-	for (type = 0; type < __BPF_REG_TYPE_MAX; type++) {
-		if (reg2btf_ids[type] && *reg2btf_ids[type] == ref_id)
-			return type;
-	}
-
-	return NOT_INIT;
-}
-
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	/* A referenced register is always trusted. */
@@ -8201,7 +8189,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 
 static int resolve_func_arg_type(struct bpf_verifier_env *env,
 				 struct bpf_reg_state *reg, u32 arg,
-				 struct bpf_call_arg_meta *meta, int insn_idx,
+				 struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type, u32 *arg_size);
 static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				     argno_t argno, enum bpf_arg_type arg_type,
@@ -8251,7 +8239,7 @@ static const struct bpf_reg_types mem_types = {
 	},
 };
 
-static const struct bpf_reg_types spin_lock_types = {
+static const struct bpf_reg_types map_value_or_alloc_obj_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_BTF_ID | MEM_ALLOC,
@@ -8280,7 +8268,29 @@ static const struct bpf_reg_types percpu_btf_ptr_types = {
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types map_value_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types arena_types = {
+	.types = {
+		PTR_TO_ARENA,
+		SCALAR_VALUE,
+	}
+};
+
+static const struct bpf_reg_types alloc_obj_types = {
+	.types = {
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU,
+	}
+};
+
+static const struct bpf_reg_types alloc_obj_or_non_own_ref_types = {
+	.types = {
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
+	}
+};
+
 static const struct bpf_reg_types kptr_xchg_dest_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
@@ -8310,16 +8320,32 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 #endif
 	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
-	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
+	[ARG_PTR_TO_SPIN_LOCK]		= &map_value_or_alloc_obj_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
-	[ARG_PTR_TO_TIMER]		= &timer_types,
+	[ARG_PTR_TO_TIMER]		= &map_value_types,
 	[ARG_KPTR_XCHG_DEST]		= &kptr_xchg_dest_types,
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
+	/* Argument kinds only a kfunc can have. */
+	[ARG_SCALAR]			= &scalar_types,
+	[ARG_CONST_SCALAR]		= &scalar_types,
+	[ARG_CONST_MEM_SIZE]		= &scalar_types,
+	[ARG_PTR_TO_ALLOC_BTF_ID]	= &alloc_obj_types,
+	[ARG_PTR_TO_REFCOUNTED_KPTR]	= &alloc_obj_or_non_own_ref_types,
+	[ARG_PTR_TO_ITER]		= &stack_ptr_types,
+	[ARG_PTR_TO_LIST_HEAD]		= &map_value_or_alloc_obj_types,
+	[ARG_PTR_TO_LIST_NODE]		= &alloc_obj_or_non_own_ref_types,
+	[ARG_PTR_TO_RB_ROOT]		= &map_value_or_alloc_obj_types,
+	[ARG_PTR_TO_RB_NODE]		= &alloc_obj_or_non_own_ref_types,
+	[ARG_PTR_TO_RES_SPIN_LOCK]	= &map_value_or_alloc_obj_types,
+	[ARG_PTR_TO_WORKQUEUE]		= &map_value_types,
+	[ARG_PTR_TO_TASK_WORK]		= &map_value_types,
+	[ARG_PTR_TO_IRQ_FLAG]		= &stack_ptr_types,
+	[ARG_PTR_TO_ARENA]		= &arena_types,
 };
 
 static void bpf_diag_call_arg(struct bpf_verifier_env *env, u32 insn_idx, argno_t argno,
@@ -8420,6 +8446,9 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		verifier_bug(env, "unsupported arg type %d", arg_type);
 		return -EFAULT;
 	}
+	if (meta->btf && base_type(arg_type) == ARG_PTR_TO_BTF_ID &&
+	    (base_type(type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(type)]))
+		goto found;
 
 	/* ARG_PTR_TO_MEM + RDONLY is compatible with PTR_TO_MEM and PTR_TO_MEM + RDONLY,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM and NOT with PTR_TO_MEM + RDONLY
@@ -8463,7 +8492,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	actual = bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
 	accepted = bpf_diag_expected_reg_types(env, compatible->types, i);
 	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
-			      "Pass a value with one of the accepted pointer or scalar types for this call.",
+			      bpf_diag_fmt(env, "Pass %s.", bpf_diag_arg_type_plain(arg_type)),
 			      "it has type %s, but this argument accepts %s",
 			      actual, accepted);
 	return -EACCES;
@@ -8775,7 +8804,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
-	err = resolve_func_arg_type(env, reg, arg, meta, insn_idx, &arg_type, &arg_size);
+	err = resolve_func_arg_type(env, reg, arg, meta, &arg_type, &arg_size);
 	if (err)
 		return err;
 
@@ -11820,7 +11849,7 @@ static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 
 static int resolve_func_arg_type(struct bpf_verifier_env *env,
 				 struct bpf_reg_state *reg, u32 arg,
-				 struct bpf_call_arg_meta *meta, int insn_idx,
+				 struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type, u32 *arg_size)
 {
 	argno_t argno = argno_from_arg(arg + 1);
@@ -11845,24 +11874,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 		ref_t = btf_type_skip_modifiers(btf, ref_id, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		if (!btf_type_is_scalar_struct(env, btf, ref_t)) {
-			enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
-			const char *expected_type;
-
-			verbose(env, "%s is %s expected %s %s",
-				reg_arg_name(env, argno), reg_type_str(env, reg->type),
-				btf_type_str(ref_t), ref_tname);
-			if (reg2btf_type != NOT_INIT)
-				verbose(env, " or %s", reg_type_str(env, reg2btf_type));
-			verbose(env, "\n");
-			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-			bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
-					      "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
-					      "the function expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
-					      expected_type,
-					      bpf_diag_reg_type_plain(env, reg->type));
-			return -EINVAL;
-		}
+		if (!btf_type_is_scalar_struct(env, btf, ref_t))
+			return 0;
 
 		resolve_ret = btf_resolve_size(btf, ref_t, arg_size);
 		if (IS_ERR(resolve_ret)) {
@@ -13002,25 +13015,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
 			ref_id = *meta->fn->arg_btf_id[i];
 
-		ret = resolve_func_arg_type(env, reg, i, meta, insn_idx, &arg_type, &arg_size);
+		ret = resolve_func_arg_type(env, reg, i, meta, &arg_type, &arg_size);
 		if (ret < 0)
 			return ret;
+
+		ret = check_reg_type(env, reg, argno, arg_type, meta);
+		if (ret < 0)
+			return ret;
+
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
 
 		switch (base_type(arg_type)) {
 		case ARG_CONST_SCALAR:
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an integer scalar value for this argument, not a pointer or resource object.",
-						      "the kfunc expects an integer scalar, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
-
 			ret = process_const_arg(env, reg, argno, meta);
 			if (ret < 0) {
 				if (ret == -EINVAL)
@@ -13032,27 +13040,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 			break;
 		case ARG_SCALAR:
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an integer scalar value for this argument, not a pointer or resource object.",
-						      "the kfunc expects an integer scalar, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
 			break;
 		case ARG_CONST_ALLOC_SIZE_OR_ZERO:
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an integer scalar value for this argument, not a pointer or resource object.",
-						      "the kfunc expects an integer scalar, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
-
 			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size"))
 				meta->r0_rdonly = true;
 			ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
@@ -13066,17 +13055,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 			break;
 		case ARG_PTR_TO_CTX:
-			if (reg->type != PTR_TO_CTX) {
-				verbose(env, "%s expected pointer to ctx, but got %s\n",
-					reg_arg_name(env, argno), reg_type_str(env, reg->type));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass the original program context pointer or preserve it before modifying registers.",
-						      "the kfunc expects a context pointer, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
-
 			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx])) {
 				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
 				if (ret < 0)
@@ -13085,11 +13063,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 			break;
 		case ARG_PTR_TO_ARENA:
-			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a pointer to arena or scalar\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			break;
 		case ARG_PTR_TO_ALLOC_BTF_ID:
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
@@ -13104,15 +13077,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
-			} else {
-				verbose(env, "%s expected pointer to allocated object\n",
-					reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass a pointer returned by the matching BPF object allocation path.",
-						      "the kfunc expects an allocated object pointer, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
 			}
 			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
@@ -13161,12 +13125,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case ARG_PTR_TO_LIST_HEAD:
-			if (reg->type != PTR_TO_MAP_VALUE &&
-			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "%s expected pointer to map value or allocated object\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
 			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
@@ -13177,12 +13135,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case ARG_PTR_TO_RB_ROOT:
-			if (reg->type != PTR_TO_MAP_VALUE &&
-			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "%s expected pointer to map value or allocated object\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
 			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
@@ -13242,12 +13194,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case ARG_CONST_MAP_PTR:
-			if (base_type(reg->type) != CONST_PTR_TO_MAP ||
-			    type_may_be_null(reg->type)) {
-				verbose(env, "pointer in %s isn't map pointer\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			ret = process_map_ptr_arg(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
@@ -13336,16 +13282,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			argno_t buff_argno = argno_from_arg(i);
 			enum bpf_mem_size_failure failure;
 
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an integer scalar length for this memory argument.",
-						      "the kfunc expects a scalar memory size, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
-
 			if (bpf_register_is_null(buff_reg))
 				break;
 
@@ -13383,23 +13319,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		}
 		case ARG_PTR_TO_FUNC:
-			if (reg->type != PTR_TO_FUNC) {
-				verbose(env, "%s expected pointer to func\n", reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			meta->subprogno = reg->subprogno;
 			break;
 		case ARG_PTR_TO_REFCOUNTED_KPTR:
-			if (!type_is_ptr_alloc_obj(reg->type)) {
-				verbose(env, "%s is neither owning or non-owning ref\n",
-					reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass an owning or non-owning pointer to a BPF-managed object containing a bpf_refcount field.",
-						      "the kfunc expects a pointer to a BPF-managed refcounted object, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
 			if (!type_is_non_owning_ref(reg->type))
 				meta->arg_owning_ref = true;
 
@@ -13419,61 +13341,26 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			meta->arg_btf_id = reg->btf_id;
 			break;
 		case ARG_PTR_TO_CONST_STR:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "%s doesn't point to a const string\n",
-					reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass a constant string pointer that the verifier recognizes, such as a string stored in a read-only map value.",
-						      "the kfunc expects a pointer to a constant string stored in verifier-known memory, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
 			ret = check_arg_const_str(env, reg, argno);
 			if (ret)
 				return ret;
 			break;
 		case ARG_PTR_TO_WORKQUEUE:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "%s doesn't point to a map value\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			ret = check_map_field_pointer(env, reg, argno, BPF_WORKQUEUE, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
 		case ARG_PTR_TO_TIMER:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "%s doesn't point to a map value\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			ret = process_timer_func(env, reg, argno, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
 		case ARG_PTR_TO_TASK_WORK:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "%s doesn't point to a map value\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 			ret = check_map_field_pointer(env, reg, argno, BPF_TASK_WORK, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
 		case ARG_PTR_TO_IRQ_FLAG:
-			if (reg->type != PTR_TO_STACK) {
-				verbose(env, "%s doesn't point to an irq flag on stack\n",
-					reg_arg_name(env, argno));
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass the same stack slot used by bpf_local_irq_save() or bpf_res_spin_lock_irqsave().",
-						      "the kfunc expects a stack pointer to an IRQ flag slot, but %s is %s",
-						      reg_arg_name(env, argno),
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
-			}
 			ret = process_irq_flag(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
@@ -13482,12 +13369,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		{
 			int flags = PROCESS_RES_LOCK;
 
-			if (reg->type != PTR_TO_MAP_VALUE && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "%s doesn't point to map value or allocated object\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-
 			if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
 				return -EFAULT;
 			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock]) ||
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 2b39cc1b09f9..0063e60d6f2f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -70,7 +70,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_oversized, 0, "allocation size exceeds u32 max"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
-	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 expected pointer to ctx, but got scalar"),
+	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 type=scalar expected=ctx"),
 	TC_FAIL(kfunc_call_test_spin_lock_unsafe, 0, "function calls are not allowed while holding a lock"),
 
 	/* success cases */
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 50609f3b0564..6578cf12fa27 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -205,7 +205,7 @@ int arena_arg_no_arena(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-__failure __msg("is not a pointer to arena or scalar")
+__failure __msg("R1 type=fp expected=arena, scalar")
 int arena_arg_bad_reg(void *ctx)
 {
 	u64 buf = 0;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 6d730535eb95..76a3cba6f23c 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -243,7 +243,7 @@ int BPF_PROG(test_populate_invalid_destination, struct task_struct *task, u64 cl
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("leads to invalid memory access")
+__failure __msg("R2 type=scalar expected=fp")
 int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u64 clone_flags)
 {
 	void *garbage = (void *)0x123456;
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index a4a007866a33..53df6d248e26 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -15,7 +15,7 @@ struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
 
 SEC("?tc")
-__failure __msg("R1 doesn't point to an irq flag on stack")
+__failure __msg("R1 type=map_value expected=fp")
 int irq_save_bad_arg(struct __sk_buff *ctx)
 {
 	bpf_local_irq_save(&global_flags);
@@ -23,7 +23,7 @@ int irq_save_bad_arg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("R1 doesn't point to an irq flag on stack")
+__failure __msg("R1 type=map_value expected=fp")
 int irq_restore_bad_arg(struct __sk_buff *ctx)
 {
 	bpf_local_irq_restore(&global_flags);
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 62d7df9e80be..e4d099c533aa 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1688,7 +1688,7 @@ int iter_subprog_check_stacksafe(const void *ctx)
 struct bpf_iter_num global_it;
 
 SEC("raw_tp")
-__failure __msg("R1 expected pointer to an iterator on stack")
+__failure __msg("R1 type=map_value expected=fp")
 int iter_new_bad_arg(const void *ctx)
 {
 	bpf_iter_num_new(&global_it, 0, 1);
@@ -1696,7 +1696,7 @@ int iter_new_bad_arg(const void *ctx)
 }
 
 SEC("raw_tp")
-__failure __msg("R1 expected pointer to an iterator on stack")
+__failure __msg("R1 type=map_value expected=fp")
 int iter_next_bad_arg(const void *ctx)
 {
 	bpf_iter_num_next(&global_it);
@@ -1704,7 +1704,7 @@ int iter_next_bad_arg(const void *ctx)
 }
 
 SEC("raw_tp")
-__failure __msg("R1 expected pointer to an iterator on stack")
+__failure __msg("R1 type=map_value expected=fp")
 int iter_destroy_bad_arg(const void *ctx)
 {
 	bpf_iter_num_destroy(&global_it);
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 5a3ff65e8234..f65cc9766633 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -105,8 +105,7 @@ int iter_next_rcu_not_trusted(const void *ctx)
 }
 
 SEC("raw_tp/sys_enter")
-__failure __msg("R1 cannot write into rdonly_mem")
-/* Message should not be 'R1 cannot write into rdonly_trusted_mem' */
+__failure __msg("R1 type=rdonly_mem expected=fp")
 int iter_next_ptr_mem_not_trusted(const void *ctx)
 {
 	struct bpf_iter_num num_it;
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 3e0d4f687aaa..23019023511a 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -118,8 +118,7 @@ int atomic_rmw_not_ok(void *ctx)
 
 SEC("socket")
 __failure
-__msg("invalid access to memory, mem_size=0 off=0 size=4")
-__msg("R1 min value is outside of the allowed memory range")
+__msg("R1 type=rdonly_untrusted_mem expected=fp")
 int kfunc_param_not_ok(void *ctx)
 {
 	int *p;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 555379952dcc..80494e00ede3 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -179,7 +179,7 @@ long rbtree_api_use_unchecked_remove_retval(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
+__failure __msg("R2 type=scalar expected=ptr_, ptr_, rcu_ptr_")
 long rbtree_api_add_release_unlock_escape(void *ctx)
 {
 	struct node_data *n;
@@ -203,7 +203,7 @@ long rbtree_api_add_release_unlock_escape(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_rbtree_remove can only take non-owning or refcounted bpf_rb_node pointer")
+__failure __msg("R2 type=scalar expected=ptr_, ptr_, rcu_ptr_")
 long rbtree_api_first_release_unlock_escape(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index eaaed0859f94..8a98e901382d 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -82,8 +82,8 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("R1 is neither owning or non-owning ref")
-__msg("expects a pointer to a BPF-managed refcounted object, but R1 is a context pointer")
+__failure __msg("R1 type=ctx expected=ptr_, ptr_, rcu_ptr_")
+__msg("type ctx, but this argument accepts ptr_, ptr_, rcu_ptr_")
 long refcount_acquire_non_object(void *ctx)
 {
 	return bpf_refcount_acquire(ctx) != NULL;
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
index 330682a88c16..8fd591bd1f6c 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -24,7 +24,7 @@ struct bpf_spin_lock lock __hidden SEC(".data.A");
 struct bpf_res_spin_lock res_lock __hidden SEC(".data.B");
 
 SEC("?tc")
-__failure __msg("point to map value or allocated object")
+__failure __msg("R1 type=untrusted_ptr_ expected=map_value, ptr_")
 int res_spin_lock_arg(struct __sk_buff *ctx)
 {
 	struct arr_elem *elem;
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index 21428bb1ee59..10ebb4a7f105 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -23,7 +23,7 @@ int stream_vprintk_scalar_arg(void *ctx)
 }
 
 SEC("syscall")
-__failure __msg("R2 doesn't point to a const string")
+__failure __msg("R2 type=ctx expected=map_value")
 int stream_vprintk_string_arg(void *ctx)
 {
 	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 3186e7b4b24e..bc56bdaca780 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -58,7 +58,7 @@ int mismatch_map(struct pt_regs *args)
 }
 
 SEC("perf_event")
-__failure __msg("R2 doesn't point to a map value")
+__failure __msg("R2 type=fp expected=map_value")
 int no_map_task_work(struct pt_regs *args)
 {
 	struct task_struct *task;
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index bf48fc43c7ab..f7a83e502454 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -40,7 +40,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size,
 }
 
 SEC("?lsm.s/bpf")
-__failure __msg("R1 expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("R1 type=map_value expected=fp, dynptr_ptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	static struct bpf_dynptr val;
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 32dc8827e128..bd30217579d4 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -48,7 +48,7 @@ __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __failure
 __msg(": (85) call bpf_wq_init#") /* anchor message */
-__msg("pointer in R2 isn't map pointer")
+__msg("R2 type=fp expected=map_ptr")
 long test_wq_init_nomap(void *ctx)
 {
 	struct bpf_wq *wq;
@@ -98,7 +98,7 @@ __failure
  * is a correct bpf_wq pointer.
  */
 __msg(": (85) call bpf_wq_set_callback#") /* anchor message */
-__msg("R1 doesn't point to a map value")
+__msg("R1 type=fp expected=map_value")
 long test_wrong_wq_pointer(void *ctx)
 {
 	int key = 0;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index d730215e520b..0930ef862697 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -76,7 +76,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 expected pointer to ctx, but got fp",
+	.errstr = "R1 type=fp expected=ctx",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
-- 
2.52.0

