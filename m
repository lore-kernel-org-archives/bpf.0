Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4D497B7F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164296; cv=none; b=Akv00nB7cgjTcs9LYwZ9Q23c9Jw8CLn+y9S2z3uJCpKJ54UjcZefIoTs9yDKieQBGedge2+bDB1GOH5lSKiXxbIvnEzuXNIoJK9IbNxxcpI7+gqk11lphd63plagqNqXsGgDW8DDbY7WkX1VL2YAbnLWzos0Es0EOsOv/rVRBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164296; c=relaxed/simple;
	bh=ub34/6LurXAeJOrDc6hsq/Dty+Da2Vl+cyAZ/9TPKhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFqAPzwVDWR9Rbj6VvqGmcvb5IWsrMEapQk/LWLtO2BbjisA2GX5J8ubfSHVt/icYuickMcj4k3f6cUV/lgHz8nB0EzF7tbjLc7YKtymDeUXqvuOiyMpjZ7qAnNuQPTxc1E5vxI1PJHINlnl6wN/7+q5u3/TXSl78zAf2zZjk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTfAMUEC; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTfAMUEC"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-46adfc81112so834904fac.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164291; x=1789769091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/lXvKmEelkJHJ4xCNDhLteTZbOi4Z1RK+iIUrAM76E=;
        b=VTfAMUECCP0MtBc3KEQ7XOlfnive/Sixe07HHmnVlF6MM5Ktl3X8cXkI82Nvz31JPv
         QhNkxIKj/Oj8A9ez5+xQNmu2Ne3XasATh8BP9uN/7VDbQYEb5/GDS7PPDxikqnplKh4w
         vIedh6q8jmJobg1U93RKYPRMVTOHMqZyZp1Jw8VbvhyGESSUmMWaHZltppDr4usLJU3j
         mNsZrs0m0ZNgzbpzaegYa6dKVapeU0bkmURS/sQfTru2RY5AoiGsaKevmhTae5AVo/3f
         R57m3V8fWFMdc68R0YaNPaIg7s6WKsk0S43fHeQpwneBUWWjVgfuNmGWAGv4BEpxCRGw
         qyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164291; x=1789769091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/lXvKmEelkJHJ4xCNDhLteTZbOi4Z1RK+iIUrAM76E=;
        b=bVK9KlTxtNr9ErgoAqrUJNlgq/fFnk3SAuFzks0yf9Kj3jTi99XPXzotlrJztnyxmq
         AQkmnQALAvL2RYkKAETKRRyQpKu3QkVwUW0Q7+2O2hyyrdJ3ChFmFZ5NW/ipIQJvEzbc
         dYIqIhTOC/dX8cMBQ0KNWiQrbPHKUJVzi8CDD8PVojKg8Id79NSJrpMBF0NqiRYz36Y0
         sIrRYf49msgZUUyMZkTD5niiAa/WCHLiEsj9O483WcgA4GU+9L56dO5KZgbVo+0+JwND
         mEe/tE5hYqAUSCEkco8Q0M4w+UG6Hniev4cUwB8Sz62jRHrfuvPn0ckEUH2uOkkCNljE
         C4aw==
X-Gm-Message-State: AFuF++lnsy9Adxeou/tBDUTI7J06PeEVLEDBLxOMWDkj9pXEe+egwP9g
	nuwIf0maAcbuux2Ie4sbxcZDg5riJg4wuPTX1qy93VOdRwVyxN7/vhBmc/MBsQ==
X-Gm-Gg: AYBFou14LWjX4JZWncvY661utrY97NWkS6O5fv836mRDUx5laCC3HYtyqLwx7PKuPct
	Bi/4V1bPkZ2MzBIis2CtkDhmlImaO+iZarSvPZwxBl+LoxOI9QZqzL9NmSwm1WPP1QuSJtM5O5Q
	nFHmwNvLVY3nsEKFbRz44cdlXKao/GsdkI26Jfnd2ZSlXUZno0180MJOmTyqD8NPlYJ/zuD2k5u
	i2LWlOh7jW11eU3l9oORvFfjFBhNgbrWNrhGiQ//LbuoPuUlJIfG8MFjo5ZICMvO8Ria4b9tBO5
	J2x4F0A4wwL+zSLLZfmBqTKfLToKD8Pa33jV8Z1T/HsOLR34kK+117iV6kTsbPrl3RymzA1Mjgz
	id00kFwUU8bYChKTlbGqRs5bKQ6KFh7dXxzYt0Mp8WKGtG/6KyMwYwRBj7Z0MO1hgWs5JRoYXi7
	yA2JFpQyXI/Cc2ncvb6V4VE4wTtsQdAo3eOsHf4DW/5/izx0QDIyNkDcPnvH3Z1A==
X-Received: by 2002:a05:6870:6b95:b0:475:e2e9:4f52 with SMTP id 586e51a60fabf-47deaf76a13mr4859664fac.32.1789164290401;
        Fri, 11 Sep 2026 15:04:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df962a078sm3178810fac.16.2026.09.11.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:50 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 23/23] bpf: Check helper and kfunc arguments in one path
Date: Fri, 11 Sep 2026 15:04:15 -0700
Message-ID: <20260911220415.1396439-24-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generated kfunc prototypes now carry the argument kinds and metadata
needed by the helper argument checker, but kfunc calls still duplicate
the per-argument loop and switch.

Add check_func_args() to determine the argument count, validate outgoing
kfunc stack arguments, and drive check_func_arg() for both call kinds.
Move the remaining kfunc-only argument handlers, including the dynptr
clone runtime refinement, into check_func_arg(), derive each kfunc BTF
referent there once, and skip check_reg_arg() for stack-passed
arguments that check_outgoing_stack_args() already validated. Keep
special-kfunc ID checks behind small helpers so their table can remain
in place.

Keep the intentional differences selected by call metadata: helpers
retain their privileged ARG_ANYTHING pointer-leak behavior, while kfunc
scalars use strict ARG_SCALAR register admission. The shared
ARG_PTR_TO_BTF_ID case retains helper-only compatible-ID and
bpf_kptr_xchg() handling, performs kfunc trusted/RCU provenance
checks, and selects the expected BTF based on call kind. Helper and kfunc
memory arguments likewise
retain their access modes and share fixed-memory and memory/size
diagnostics.

Treat an accepted nullable NULL as a completed argument check, matching
the former kfunc continue path. The skipped helper-specific processing
is either a no-op for NULL or deferred to the paired size argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 922 +++++++++---------
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/wakeup_source_fail.c  |   2 +-
 5 files changed, 440 insertions(+), 490 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe8a45303602..617a277c3558 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7719,7 +7719,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			bpf_diag_res(
 				env, insn_idx, "dynptr is already initialized",
-				"This kfunc constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr state.",
+				"This function constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr state.",
 				"Use a fresh stack dynptr slot, or release/destroy the existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
@@ -7848,8 +7848,8 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 			reg_arg_name(env, argno));
 		bpf_diag_call_arg(
 			env, insn_idx, argno, meta->func_name,
-			"the kfunc expects a recognized iterator state pointer, but this argument does not match a valid iterator type",
-			"Pass the exact iterator state type expected by this kfunc.");
+			"the function expects a recognized iterator state pointer, but this argument does not match a valid iterator type",
+			"Pass the exact iterator state type expected by this function.");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -8245,6 +8245,39 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 				     argno_t argno, enum bpf_arg_type arg_type,
 				     const struct btf *arg_btf, u32 arg_btf_id,
 				     struct bpf_call_arg_meta *meta, int insn_idx);
+static bool is_kfunc_arg_nonown_allowed(const struct btf *btf,
+					const struct btf_param *arg);
+static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
+					  const struct btf_param *arg,
+					  const char *name);
+static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_bpf_obj_drop_kfunc(u32 func_id);
+static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
+static bool is_bpf_rbtree_add_kfunc(u32 func_id);
+static int get_bpf_res_spin_lock_kfunc_flags(const struct bpf_call_arg_meta *meta);
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
+static int process_irq_flag(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *reg, argno_t argno,
+			    struct bpf_call_arg_meta *meta);
+static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   argno_t argno,
+					   struct bpf_call_arg_meta *meta);
+static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *env,
+					     struct bpf_reg_state *reg,
+					     argno_t argno,
+					     struct bpf_call_arg_meta *meta);
+static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *reg,
+					   argno_t argno,
+					   struct bpf_call_arg_meta *meta);
+static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
+					     struct bpf_reg_state *reg,
+					     argno_t argno,
+					     struct bpf_call_arg_meta *meta);
+static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env);
 
 struct bpf_reg_types {
 	const enum bpf_reg_type types[10];
@@ -8813,7 +8846,6 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 }
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
-static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
 
 static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, struct bpf_call_arg_meta *meta)
@@ -8857,6 +8889,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
 {
+	const struct btf_param *btf_arg = meta->btf ? &btf_params(meta->func_proto)[arg] : NULL;
 	const struct bpf_func_proto *fn = meta->fn;
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -8882,6 +8915,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 	}
 
+	/* Preserve the legacy helper behavior for privileged pointer leaks. */
 	if (arg_type == ARG_ANYTHING) {
 		if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			verbose(env, "%s leaks addr into helper function\n",
@@ -8896,13 +8930,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
-		/* A NULL register has a SCALAR_VALUE type, so skip
-		 * type checking.
-		 */
-		err = mark_chain_precision(env, regno);
+		err = mark_arg_precision(env, argno);
 		if (err)
 			return err;
-		goto skip_type_check;
+		return 0;
 	}
 
 	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
@@ -8917,7 +8948,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-skip_type_check:
 	err = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
@@ -8926,6 +8956,19 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		update_ref_obj(&meta->ref_obj, reg);
 
 	switch (base_type(arg_type)) {
+	case ARG_CONST_SCALAR:
+		err = process_const_arg(env, reg, argno, meta);
+		if (err < 0) {
+			if (err == -EINVAL)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+						      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
+						      "the function requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
+						      reg_arg_name(env, argno));
+			return err;
+		}
+		break;
+	case ARG_SCALAR:
+		break;
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		err = process_map_ptr_arg(env, reg, argno, meta);
@@ -8991,6 +9034,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
 	{
 		const u32 *arg_btf_id = fn->arg_btf_id[arg];
+		const struct btf *arg_btf = meta->btf ?: btf_vmlinux;
 
 		if (!meta->btf) {
 			const struct bpf_reg_types *compatible;
@@ -9018,7 +9062,39 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			}
 		}
 
-		err = process_arg_ptr_to_btf_id(env, reg, argno, arg_type, btf_vmlinux,
+		if (meta->btf && (!is_trusted_reg(env, reg) ||
+				  bpf_type_has_unsafe_modifiers(reg->type))) {
+			if (!(arg_type & MEM_RCU)) {
+				const char *actual_type, *arg_name, *expected_type;
+
+				expected_type = bpf_diag_fmt_btf_type(env, arg_btf, *arg_btf_id);
+				verbose(env, "%s must be referenced or trusted\n",
+					reg_arg_name(env, argno));
+				arg_name = reg_arg_name(env, argno);
+				actual_type = bpf_diag_reg_type_plain(env, reg->type);
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+						      "Pass a pointer acquired from a verifier-tracked source, or call this function only inside the required protection if it accepts RCU pointers.",
+						      "the function requires a trusted or resource-owning pointer to %s, but %s is %s",
+						      expected_type, arg_name, actual_type);
+				return -EINVAL;
+			}
+			if (!is_rcu_reg(reg)) {
+				const char *actual_type, *arg_name, *expected_type;
+
+				expected_type = bpf_diag_fmt_btf_type(env, arg_btf, *arg_btf_id);
+				verbose(env, "%s must be a rcu pointer\n",
+					reg_arg_name(env, argno));
+				arg_name = reg_arg_name(env, argno);
+				actual_type = bpf_diag_reg_type_plain(env, reg->type);
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+						      "Use this function with a pointer that is valid in an RCU read lock region.",
+						      "the function requires an RCU-protected pointer to %s, but %s is %s",
+						      expected_type, arg_name, actual_type);
+				return -EINVAL;
+			}
+		}
+
+		err = process_arg_ptr_to_btf_id(env, reg, argno, arg_type, arg_btf,
 						*arg_btf_id, meta, insn_idx);
 		if (err < 0)
 			return err;
@@ -9055,44 +9131,274 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		break;
+	case ARG_PTR_TO_CTX:
+		if (is_bpf_cast_to_kern_ctx_kfunc(meta)) {
+			err = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
+			if (err < 0)
+				return -EINVAL;
+			meta->ret_btf_id = err;
+		}
+		break;
+	case ARG_PTR_TO_ARENA:
+		break;
+	case ARG_PTR_TO_ALLOC_BTF_ID:
+		if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
+			if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
+				verbose(env, "%s expected for bpf_obj_drop()\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+		} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
+			if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
+				verbose(env, "%s expected for bpf_percpu_obj_drop()\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+		}
+		if (!reg_is_referenced(env, reg)) {
+			verbose(env, "allocated object must be referenced\n");
+			bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					      "Pass the owned object pointer before it is released or transferred.",
+					      "the allocated object pointer in %s must still carry verifier-tracked ownership, but this pointer no longer owns a live resource",
+					      reg_arg_name(env, argno));
+			return -EINVAL;
+		}
+		if (meta->btf == btf_vmlinux) {
+			meta->arg_btf = reg->btf;
+			meta->arg_btf_id = reg->btf_id;
+		}
+		break;
 	case ARG_PTR_TO_FUNC:
 		meta->subprogno = reg->subprogno;
 		break;
 	case ARG_PTR_TO_MEM:
+	{
+		enum bpf_access_type access_type;
+		bool known_memory;
+
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
-		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_mem_reg(env, reg, argno, arg_size,
-					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta, NULL);
-			if (err)
-				return err;
-			if (arg_type & MEM_ALIGNED)
-				err = check_ptr_alignment(env, reg, 0, arg_size, true);
+		if (!(arg_type & MEM_FIXED_SIZE))
+			break;
+
+		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
+		if (meta->btf)
+			access_type = BPF_READ | BPF_WRITE;
+
+		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
+		if (err < 0) {
+			if (known_memory)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					"Pass memory with at least the required number of accessible bytes and suitable read or write access.",
+					"the function expects %u bytes of memory, but the verifier cannot prove that %s provides a range of that size with the required read or write access",
+					arg_size,
+					bpf_diag_reg_type_plain(env, reg->type));
+			else
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					"Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
+					"the function expects %u bytes of memory, but it is %s and not verifier-known memory",
+					arg_size,
+					bpf_diag_reg_type_plain(env, reg->type));
+			return err;
 		}
+		if (arg_type & MEM_ALIGNED)
+			err = check_ptr_alignment(env, reg, 0, arg_size, true);
 		break;
+	}
+	case ARG_CONST_MEM_SIZE:
+		err = process_const_arg(env, reg, argno, meta);
+		if (err < 0) {
+			if (err == -EINVAL)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+						      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
+						      "the function requires this memory size to be a verifier-known constant, but %s is variable on this path",
+						      reg_arg_name(env, argno));
+			return err;
+		}
+		fallthrough;
 	case ARG_MEM_SIZE:
-		err = check_mem_size_reg(env, get_func_arg_reg(caller, regs, arg - 1), reg,
-					 argno_from_arg(arg), argno,
-					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 false, meta, NULL);
-		break;
 	case ARG_MEM_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, get_func_arg_reg(caller, regs, arg - 1), reg,
-					 argno_from_arg(arg), argno,
-					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 true, meta, NULL);
+	{
+		struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, arg - 1);
+		argno_t buff_argno = argno_from_arg(arg);
+		enum bpf_mem_size_failure failure;
+		const char *buff_arg, *size_arg;
+		bool zero_size_allowed;
+		u32 access_type;
+
+		if (meta->btf && bpf_register_is_null(buff_reg))
+			break;
+
+		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
+		if (meta->btf)
+			access_type = BPF_READ | BPF_WRITE;
+
+		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
+
+		err = check_mem_size_reg(env, buff_reg, reg, buff_argno, argno,
+					 access_type, zero_size_allowed, meta, &failure);
+		if (!err)
+			break;
+
+		buff_arg = bpf_diag_arg_name(env, buff_argno);
+		size_arg = bpf_diag_arg_name(env, argno);
+		verbose(env, "%s and ", reg_arg_name(env, buff_argno));
+		verbose(env, "%s memory, len pair leads to invalid memory access\n",
+			reg_arg_name(env, argno));
+		if (failure == BPF_MEM_SIZE_FAIL_MEMORY) {
+			bpf_diag_call_arg_fmt(env, insn_idx, buff_argno, meta->func_name,
+					      "Pass a stack, map, context, or other verifier-known memory pointer, and keep the paired length within that object.",
+					      "it is the memory pointer in a memory/length pair with %s, but %s does not provide a verifier-accessible range of the requested length",
+					      size_arg, buff_arg);
+		} else if (failure == BPF_MEM_SIZE_FAIL_SIZE) {
+			if (reg_smin(reg) < 0)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					"Constrain the memory size to a non-negative value smaller than BPF_MAX_VAR_SIZ before this call.",
+					"the memory size in %s may be negative because its signed minimum is %lld",
+					size_arg, reg_smin(reg));
+			else if (!zero_size_allowed && reg_umin(reg) == 0)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					"Ensure the memory size is non-zero before this call.",
+					"the memory size in %s may be zero, but the function requires a non-zero size",
+					size_arg);
+			else
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+					"Constrain the memory size to a non-negative value smaller than BPF_MAX_VAR_SIZ before this call.",
+					"the memory size in %s may reach %llu bytes, but variable memory accesses must stay below %u bytes",
+					size_arg, reg_umax(reg), BPF_MAX_VAR_SIZ);
+		}
 		break;
-	case ARG_PTR_TO_DYNPTR:
+	}
+	case ARG_PTR_TO_DYNPTR: {
+		if (is_bpf_dynptr_clone_kfunc(meta) &&
+		    (arg_type & MEM_UNINIT)) {
+			enum bpf_dynptr_type parent_type = meta->dynptr.type;
+
+			if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
+				verifier_bug(env, "no dynptr type for parent of clone");
+				return -EFAULT;
+			}
+
+			arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
+		}
+
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
 		break;
+	}
+	case ARG_PTR_TO_ITER:
+		if (is_bpf_iter_css_task_new_kfunc(meta) &&
+		    !check_css_task_iter_allowlist(env)) {
+			verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
+			return -EINVAL;
+		}
+		err = process_iter_arg(env, reg, argno, insn_idx, meta);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_LIST_HEAD:
+		if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+		    !reg_is_referenced(env, reg)) {
+			verbose(env, "allocated object must be referenced\n");
+			return -EINVAL;
+		}
+		err = process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_RB_ROOT:
+		if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+		    !reg_is_referenced(env, reg)) {
+			verbose(env, "allocated object must be referenced\n");
+			return -EINVAL;
+		}
+		err = process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_LIST_NODE:
+		if (!(is_kfunc_arg_nonown_allowed(meta->btf, btf_arg) &&
+		      type_is_non_owning_ref(reg->type) && !reg_is_referenced(env, reg))) {
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "%s expected pointer to allocated object\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (!reg_is_referenced(env, reg)) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+		}
+		err = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_RB_NODE:
+		if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
+			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "%s expected pointer to allocated object\n",
+					reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			if (!reg_is_referenced(env, reg)) {
+				verbose(env, "allocated object must be referenced\n");
+				return -EINVAL;
+			}
+		} else {
+			if (!type_is_non_owning_ref(reg->type) &&
+			    !reg_is_referenced(env, reg)) {
+				verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n",
+					meta->func_name);
+				return -EINVAL;
+			}
+			if (in_rbtree_lock_required_cb(env)) {
+				verbose(env, "%s not allowed in rbtree cb\n", meta->func_name);
+				return -EINVAL;
+			}
+		}
+		err = process_kf_arg_ptr_to_rbtree_node(env, reg, argno, meta);
+		if (err < 0)
+			return err;
+		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
+		if (meta->btf && is_kfunc_arg_scalar_with_name(meta->btf, btf_arg,
+							       "rdonly_buf_size"))
+			meta->r0_rdonly = true;
 		err = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
-		if (err)
+		if (err < 0) {
+			if (meta->btf && err == -EINVAL)
+				bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+						      "Pass a verifier-known constant size for this function's buffer argument.",
+						      "the function uses this argument as a return-buffer size, but %s is invalid or variable on this path",
+						      reg_arg_name(env, argno));
 			return err;
+		}
+		break;
+	case ARG_PTR_TO_REFCOUNTED_KPTR:
+	{
+		struct btf_record *rec;
+
+		if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
+			meta->arg_owning_ref = true;
+
+		rec = reg_btf_record(reg);
+		if (!rec) {
+			verifier_bug(env, "Couldn't find btf_record");
+			return -EFAULT;
+		}
+
+		if (rec->refcount_off < 0) {
+			verbose(env, "%s doesn't point to a type with bpf_refcount field\n",
+				reg_arg_name(env, argno));
+			return -EINVAL;
+		}
+
+		meta->arg_btf = reg->btf;
+		meta->arg_btf_id = reg->btf_id;
 		break;
+	}
 	case ARG_PTR_TO_CONST_STR:
 	{
 		err = check_arg_const_str(env, reg, argno);
@@ -9100,6 +9406,38 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 		break;
 	}
+	case ARG_PTR_TO_WORKQUEUE:
+		err = check_map_field_pointer(env, reg, argno, BPF_WORKQUEUE, &meta->map);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_TASK_WORK:
+		err = check_map_field_pointer(env, reg, argno, BPF_TASK_WORK, &meta->map);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_IRQ_FLAG:
+		err = process_irq_flag(env, reg, argno, meta);
+		if (err < 0)
+			return err;
+		break;
+	case ARG_PTR_TO_RES_SPIN_LOCK:
+	{
+		int flags;
+
+		if (in_rbtree_lock_required_cb(env)) {
+			verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
+			return -EACCES;
+		}
+
+		flags = get_bpf_res_spin_lock_kfunc_flags(meta);
+		if (!flags)
+			return -EFAULT;
+		err = process_spin_lock(env, reg, argno, flags);
+		if (err < 0)
+			return err;
+		break;
+	}
 	case ARG_KPTR_XCHG_DEST:
 		err = process_kptr_func(env, regno, meta);
 		if (err)
@@ -9110,6 +9448,37 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	return err;
 }
 
+static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			   int insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	const struct btf_param *args = NULL;
+	u32 arg, nargs = MAX_BPF_FUNC_REG_ARGS;
+	int err;
+
+	if (meta->btf) {
+		args = btf_params(meta->func_proto);
+		nargs = btf_type_vlen(meta->func_proto);
+	}
+
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		err = check_outgoing_stack_args(env, caller, nargs, meta->func_name,
+						meta->btf, args);
+		if (err)
+			return err;
+	}
+
+	for (arg = 0; arg < nargs; arg++) {
+		if (meta->fn->arg_type[arg] == ARG_UNUSED)
+			break;
+		err = check_func_arg(env, arg, meta, insn_idx);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
@@ -11116,14 +11485,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	meta.func_id = func_id;
 	meta.func_name = func_id_name(func_id);
 	meta.fn = fn;
-	/* check args */
-	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-		if (fn->arg_type[i] == ARG_UNUSED)
-			break;
-		err = check_func_arg(env, i, &meta, insn_idx);
-		if (err)
-			return err;
-	}
+	err = check_func_args(env, &meta, insn_idx);
+	if (err)
+		return err;
 
 	err = record_func_map(env, &meta, func_id, insn_idx);
 	if (err)
@@ -12092,7 +12456,10 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_arena_reserve_pages,
 	KF_bpf_session_is_return,
+	KF_bpf_stream_vprintk,
+	KF_bpf_stream_print_stack,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12182,11 +12549,29 @@ BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_arena_reserve_pages)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_stream_vprintk)
+BTF_ID(func, bpf_stream_print_stack)
+
+static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]);
+}
+
+static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]);
+}
+
+static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new]);
+}
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
@@ -12777,12 +13162,20 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
 }
 
-static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
+static int get_bpf_res_spin_lock_kfunc_flags(const struct bpf_call_arg_meta *meta)
 {
-	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
+	int flags = PROCESS_RES_LOCK;
+
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
+		flags |= PROCESS_SPIN_LOCK;
+	else if (!is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_unlock]) &&
+		 !is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]))
+		return 0;
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]))
+		flags |= PROCESS_LOCK_IRQ;
+	return flags;
 }
 
 static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 offset)
@@ -13059,449 +13452,6 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	}
 }
 
-static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-			    int insn_idx)
-{
-	const char *func_name = meta->func_name;
-	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_reg_state *regs = cur_regs(env);
-	const struct btf *btf = meta->btf;
-	const struct btf_param *args;
-	struct btf_record *rec;
-	u32 i, nargs;
-	int ret;
-
-	args = (const struct btf_param *)(meta->func_proto + 1);
-	nargs = btf_type_vlen(meta->func_proto);
-
-	ret = check_outgoing_stack_args(env, caller, nargs, func_name, btf, args);
-	if (ret)
-		return ret;
-
-	/* Check that BTF function arguments match actual types that the
-	 * verifier sees.
-	 */
-	for (i = 0; i < nargs; i++) {
-		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
-		enum bpf_arg_type arg_type = meta->fn->arg_type[i];
-		const struct btf_type *t;
-		argno_t argno = argno_from_arg(i + 1);
-		int regno = reg_from_argno(argno);
-		u32 ref_id = args[i].type;
-		u32 arg_size = arg_type & MEM_FIXED_SIZE ? meta->fn->arg_size[i] : 0;
-
-		if (arg_type == ARG_PTR_TO_PROG_AUX) {
-			cur_aux(env)->arg_prog = regno;
-			continue;
-		}
-
-		if (arg_type == ARG_IGNORE)
-			continue;
-
-		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
-
-		if (btf_type_is_ptr(t))
-			btf_type_skip_modifiers(btf, t->type, &ref_id);
-
-		ret = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
-		if (ret < 0)
-			return ret;
-
-		ret = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
-		if (ret < 0)
-			return ret;
-
-		if (reg_is_referenced(env, reg))
-			update_ref_obj(&meta->ref_obj, reg);
-
-		if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
-			ret = mark_arg_precision(env, argno);
-			if (ret)
-				return ret;
-			continue;
-		}
-
-		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
-			ref_id = *meta->fn->arg_btf_id[i];
-
-		ret = resolve_func_arg_type(env, reg, i, meta, &arg_type, &arg_size);
-		if (ret < 0)
-			return ret;
-
-		ret = check_reg_type(env, reg, argno, arg_type, meta);
-		if (ret < 0)
-			return ret;
-
-		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
-		if (ret < 0)
-			return ret;
-
-		switch (base_type(arg_type)) {
-		case ARG_CONST_SCALAR:
-			ret = process_const_arg(env, reg, argno, meta);
-			if (ret < 0) {
-				if (ret == -EINVAL)
-					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-							      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
-							      "the kfunc requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
-							      reg_arg_name(env, argno));
-				return ret;
-			}
-			break;
-		case ARG_SCALAR:
-			break;
-		case ARG_CONST_ALLOC_SIZE_OR_ZERO:
-			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size"))
-				meta->r0_rdonly = true;
-			ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
-			if (ret < 0) {
-				if (ret == -EINVAL)
-					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-							      "Pass a verifier-known constant size for this kfunc buffer argument.",
-							      "the kfunc uses this argument as a return-buffer size, but %s is invalid or variable on this path",
-							      reg_arg_name(env, argno));
-				return ret;
-			}
-			break;
-		case ARG_PTR_TO_CTX:
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx])) {
-				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
-				if (ret < 0)
-					return -EINVAL;
-				meta->ret_btf_id  = ret;
-			}
-			break;
-		case ARG_PTR_TO_ARENA:
-			break;
-		case ARG_PTR_TO_ALLOC_BTF_ID:
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
-					verbose(env, "%s expected for bpf_obj_drop()\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
-				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
-					verbose(env, "%s expected for bpf_percpu_obj_drop()\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-			}
-			if (!reg_is_referenced(env, reg)) {
-				verbose(env, "allocated object must be referenced\n");
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass the owned object pointer before it is released or transferred.",
-						      "the allocated object pointer in %s must still carry verifier-tracked ownership, but this pointer no longer owns a live resource",
-						      reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-			if (meta->btf == btf_vmlinux) {
-				meta->arg_btf = reg->btf;
-				meta->arg_btf_id = reg->btf_id;
-			}
-			break;
-		case ARG_PTR_TO_DYNPTR:
-		{
-			enum bpf_arg_type dynptr_arg_type = arg_type;
-
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]) &&
-			    (dynptr_arg_type & MEM_UNINIT)) {
-				enum bpf_dynptr_type parent_type = meta->dynptr.type;
-
-				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
-					verifier_bug(env, "no dynptr type for parent of clone");
-					return -EFAULT;
-				}
-
-				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
-			}
-
-			ret = process_dynptr_func(env, reg, argno, insn_idx,
-						  dynptr_arg_type, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		}
-		case ARG_PTR_TO_ITER:
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new])) {
-				if (!check_css_task_iter_allowlist(env)) {
-					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
-					return -EINVAL;
-				}
-			}
-			ret = process_iter_arg(env, reg, argno, insn_idx, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_LIST_HEAD:
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
-			    !reg_is_referenced(env, reg)) {
-				verbose(env, "allocated object must be referenced\n");
-				return -EINVAL;
-			}
-			ret = process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_RB_ROOT:
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
-			    !reg_is_referenced(env, reg)) {
-				verbose(env, "allocated object must be referenced\n");
-				return -EINVAL;
-			}
-			ret = process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_LIST_NODE:
-			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
-			    type_is_non_owning_ref(reg->type) && !reg_is_referenced(env, reg)) {
-				/* Allow bpf_list_front/back return value for
-				 * __nonown_allowed list-node arguments.
-				 */
-				goto check_ok;
-			}
-			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "%s expected pointer to allocated object\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-			if (!reg_is_referenced(env, reg)) {
-				verbose(env, "allocated object must be referenced\n");
-				return -EINVAL;
-			}
-check_ok:
-			ret = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_RB_NODE:
-			if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
-				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-					verbose(env, "%s expected pointer to allocated object\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				if (!reg_is_referenced(env, reg)) {
-					verbose(env, "allocated object must be referenced\n");
-					return -EINVAL;
-				}
-			} else {
-				if (!type_is_non_owning_ref(reg->type) &&
-				    !reg_is_referenced(env, reg)) {
-					verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n", func_name);
-					return -EINVAL;
-				}
-				if (in_rbtree_lock_required_cb(env)) {
-					verbose(env, "%s not allowed in rbtree cb\n", func_name);
-					return -EINVAL;
-				}
-			}
-
-			ret = process_kf_arg_ptr_to_rbtree_node(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_CONST_MAP_PTR:
-			ret = process_map_ptr_arg(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_BTF_ID:
-			if (!is_trusted_reg(env, reg) ||
-			    bpf_type_has_unsafe_modifiers(reg->type)) {
-				if (!(arg_type & MEM_RCU)) {
-					const char *actual_type, *arg_name, *expected_type;
-
-					expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-					verbose(env, "%s must be referenced or trusted\n",
-						reg_arg_name(env, argno));
-					arg_name = reg_arg_name(env, argno);
-					actual_type = bpf_diag_reg_type_plain(env, reg->type);
-					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-							      "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU pointers.",
-							      "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
-							      expected_type, arg_name, actual_type);
-					return -EINVAL;
-				}
-				if (!is_rcu_reg(reg)) {
-					const char *actual_type, *arg_name, *expected_type;
-
-					expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-					verbose(env, "%s must be a rcu pointer\n",
-						reg_arg_name(env, argno));
-					arg_name = reg_arg_name(env, argno);
-					actual_type = bpf_diag_reg_type_plain(env, reg->type);
-					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-							      "Use this kfunc with a pointer that is valid in an RCU read lock region.",
-							      "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
-							      expected_type, arg_name, actual_type);
-					return -EINVAL;
-				}
-			}
-
-			ret = process_arg_ptr_to_btf_id(env, reg, argno, arg_type, btf,
-						   ref_id, meta, insn_idx);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_MEM:
-			if (arg_type & MEM_FIXED_SIZE) {
-				bool known_memory;
-
-				ret = check_mem_reg(env, reg, argno, arg_size, BPF_READ | BPF_WRITE,
-						    meta, &known_memory);
-				if (ret < 0) {
-					const char *expected_type;
-
-					expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-					if (known_memory)
-						bpf_diag_call_arg_fmt(
-							env, insn_idx, argno, func_name,
-							"Pass memory with at least the required number of accessible bytes and suitable read and write access.",
-							"the kfunc expects %u bytes of memory for %s, but the verifier cannot prove that %s provides a readable and writable range of that size",
-							arg_size, expected_type,
-							bpf_diag_reg_type_plain(env, reg->type));
-					else
-						bpf_diag_call_arg_fmt(
-							env, insn_idx, argno, func_name,
-							"Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
-							"the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
-							arg_size, expected_type,
-							bpf_diag_reg_type_plain(env, reg->type));
-					return ret;
-				}
-			}
-			break;
-		case ARG_CONST_MEM_SIZE:
-			ret = process_const_arg(env, reg, argno, meta);
-			if (ret < 0) {
-				if (ret == -EINVAL)
-					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-							      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
-							      "the kfunc requires this memory size to be a verifier-known constant, but %s is variable on this path",
-							      reg_arg_name(env, argno));
-				return ret;
-			}
-			fallthrough;
-		case ARG_MEM_SIZE:
-		{
-			struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
-			struct bpf_reg_state *size_reg = reg;
-			argno_t buff_argno = argno_from_arg(i);
-			enum bpf_mem_size_failure failure;
-
-			if (bpf_register_is_null(buff_reg))
-				break;
-
-			ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
-						 BPF_READ | BPF_WRITE, true, meta, &failure);
-			if (ret < 0) {
-				const char *buff_arg, *size_arg;
-
-				buff_arg = bpf_diag_arg_name(env, buff_argno);
-				size_arg = bpf_diag_arg_name(env, argno);
-				verbose(env, "%s and ", reg_arg_name(env, buff_argno));
-				verbose(env, "%s memory, len pair leads to invalid memory access\n",
-					reg_arg_name(env, argno));
-				if (failure == BPF_MEM_SIZE_FAIL_MEMORY) {
-					bpf_diag_call_arg_fmt(env, insn_idx, buff_argno, func_name,
-							      "Pass a stack, map, context, or other verifier-known memory pointer, and keep the paired length within that object.",
-							      "it is the memory pointer in a memory/length pair with %s, but %s does not describe verifier-readable memory for the requested length",
-							      size_arg, buff_arg);
-				} else if (failure == BPF_MEM_SIZE_FAIL_SIZE) {
-					if (reg_smin(size_reg) < 0)
-						bpf_diag_call_arg_fmt(
-							env, insn_idx, argno, func_name,
-							"Constrain the memory size to a non-negative value smaller than BPF_MAX_VAR_SIZ before this call.",
-							"the memory size in %s may be negative because its signed minimum is %lld",
-							size_arg, reg_smin(size_reg));
-					else
-						bpf_diag_call_arg_fmt(
-							env, insn_idx, argno, func_name,
-							"Constrain the memory size to a non-negative value smaller than BPF_MAX_VAR_SIZ before this call.",
-							"the memory size in %s may reach %llu bytes, but variable memory accesses must stay below %u bytes",
-							size_arg, reg_umax(size_reg), BPF_MAX_VAR_SIZ);
-				}
-				return ret;
-			}
-			break;
-		}
-		case ARG_PTR_TO_FUNC:
-			meta->subprogno = reg->subprogno;
-			break;
-		case ARG_PTR_TO_REFCOUNTED_KPTR:
-			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
-				meta->arg_owning_ref = true;
-
-			rec = reg_btf_record(reg);
-			if (!rec) {
-				verifier_bug(env, "Couldn't find btf_record");
-				return -EFAULT;
-			}
-
-			if (rec->refcount_off < 0) {
-				verbose(env, "%s doesn't point to a type with bpf_refcount field\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-
-			meta->arg_btf = reg->btf;
-			meta->arg_btf_id = reg->btf_id;
-			break;
-		case ARG_PTR_TO_CONST_STR:
-			ret = check_arg_const_str(env, reg, argno);
-			if (ret)
-				return ret;
-			break;
-		case ARG_PTR_TO_WORKQUEUE:
-			ret = check_map_field_pointer(env, reg, argno, BPF_WORKQUEUE, &meta->map);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_TIMER:
-			ret = process_timer_func(env, reg, argno, &meta->map);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_TASK_WORK:
-			ret = check_map_field_pointer(env, reg, argno, BPF_TASK_WORK, &meta->map);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_IRQ_FLAG:
-			ret = process_irq_flag(env, reg, argno, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case ARG_PTR_TO_RES_SPIN_LOCK:
-		{
-			int flags = PROCESS_RES_LOCK;
-
-			if (in_rbtree_lock_required_cb(env)) {
-				verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
-				return -EACCES;
-			}
-			if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
-				return -EFAULT;
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock]) ||
-			    is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
-				flags |= PROCESS_SPIN_LOCK;
-			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]) ||
-			    is_kfunc_call(meta,
-					  special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]))
-				flags |= PROCESS_LOCK_IRQ;
-			ret = process_spin_lock(env, reg, argno, flags);
-			if (ret < 0)
-				return ret;
-			break;
-		}
-		}
-	}
-
-	return 0;
-}
-
 int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 			     s32 func_id,
 			     s16 offset,
@@ -13993,7 +13943,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_aux->non_sleepable = true;
 
 	/* Check the arguments */
-	err = check_kfunc_args(env, &meta, insn_idx);
+	err = check_func_args(env, &meta, insn_idx);
 	if (err < 0)
 		return err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index e415acc08b16..c32c6dab49bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -11,7 +11,7 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } cb_refs_tests[] = {
-	{ "underflow_prog", "release function bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
+	{ "underflow_prog", "R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_" },
 	{ "leak_prog", "Unreleased reference id=4 alloc_insn=3" }, /* alloc_insn=3{2,3} */
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 731eaa09db96..ede6a17d7da3 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -191,7 +191,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("release function bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("R1 type=fp expected=ptr_, trusted_ptr_, rcu_ptr_")
 int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *acquired = (struct cgroup *)&path;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 0ca2e1a38a94..12c8ac6099ca 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -179,7 +179,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("release function bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("R1 type=fp expected=ptr_, trusted_ptr_, rcu_ptr_")
 int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired = (struct task_struct *)&clone_flags;
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
index ff9ea5aa80ad..ec4e0f3ff792 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
 }
 
 SEC("syscall")
-__failure __msg("release function bpf_wakeup_sources_read_unlock expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
 int wakeup_source_unlock_no_lock(void *ctx)
 {
 	struct bpf_ws_lock *lock = (void *)0x1;
-- 
2.52.0

