Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F94F30F6
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370785; cv=none; b=tauAGNQAfB/qOB4OpUw49VIG/P8JqK2qn9uQxoqN9aol+M5WjWUptPu2YvdQaezSQEwRDw8pmkkhtdRWK9lGipYJDEjxRn7jZ8o04X7COO/JwcL02OYnbRoQWfUJt4SNvLFI+0dZaWHX34R1v7DGJRQ7orNryhqq1UYs35jOz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370785; c=relaxed/simple;
	bh=DRxDpmgDWq77i0hlCIvNeBNj5tK5RT8xkLku7KtJTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcuKK48SAgvbr0lllWtAbNWeUzGuZqujQMgsl2bDg1U8UgNhMulhalqjZfl5/fMY2AnvU0+Je4K4/oYI8K22d6ch6/aihmHiaEgxwUZCie+FnbKDRLYa+OseMNNClFi6W0N/JxhFBjOZ3CjRJDhcQcnIFxIWF7lawowMdcYDlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nz4NRzgy; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz4NRzgy"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6b1ae6a9960so1038177eaf.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370783; x=1790975583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nzJ2Zj+yZmx/KbcqDRKZocop8BTOz+F/qigPmlj7mh0=;
        b=nz4NRzgyf5l46rz8NCwQgy4ynzhdjF1n4vsg+QbTby0iE+aBL89LhX02vn54R3aaHO
         m1vZansbhndki+ANlumD96ueLerkI4j+buMyoZJMJydXH+3NDoEhsduQbd6nQ98OfQO5
         bv958F89UVCgPsFKrRh47AQBwWZfuzdxu6W4MIVA2MJhALEfnwRtNbBADEgq+9WZJN5R
         r+HsOH2ipo0n+nU92DI59sXcf2oiqeZTlHPOYPBNJV3ISO/tCNC6h6xaGjhiW6uq03n7
         lEvJDdqHuQVyxnUBjK36mDZKIq9D5Np4DEF6IyQ8+GJ3W5v0GDj2qCS/aaBry7+MKqTt
         iwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370783; x=1790975583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nzJ2Zj+yZmx/KbcqDRKZocop8BTOz+F/qigPmlj7mh0=;
        b=rOkageznBC3bmpJKe4wZx49M4wwUezlILwFiMUAHRe/DPDnUEDE3WWJknAxsFXfvgq
         wJYhJvXTHcV3nLS63mjqNhlFWb5Ejto53Fl/KwaotxIuHkbVxJHGY1teYVbgL5xJQcld
         9q0u8fh8fxySdKCxpCKvw9m9+lSoQCsldwaYU5TNXrDUpl+cHvSwDUwMMv8bVRJ3l/MD
         foroEiRCX5m9Mi4XltgFy50yc2qi9d0/T7ylNupNq1eg/qTLsA+c+nfTEXig3GKOG89q
         JUx7bvZIUL8ZQoEpfoKzrhbxxh+PkHeQt0CAeFTzH6x/Lhbf67p3ZJ/gvSTEy+c4szwj
         Fb9g==
X-Gm-Message-State: AFuF++l6AQFKJC7pU70RWuChL1evskHpwskUgTg7cdAd3LI4aq+RzmVH
	YoUsT3ZaXx6Zp65fzom31nuUfcn13JOuibs+43YBy44OkcH+0sd21qCQaSKhvA==
X-Gm-Gg: AYBFou1DQkiQfq2jFY9qCbDOv2DRNZukIRq3nwozjrWEI0uRdhybsU7i3AmUVi0Knh+
	kqJQ63YDk/rxxjl7M0UqlgITK2rPEQD0KjOZmevWrYinDaFc2QY07/VZ1sDU+PdoV9KbISEnXFi
	o6jvPeXjlPocW24HaC5wobqlgjNkN7XhgoCQxp4eqrxszWnXGqZBoXmvV4MyN/Eeb9PBxPbjezB
	0TTNrbzJsU7n5UEi9o+mH2DhnHb8hkONdYfHXzCvg6xX6VNiB2I5L3n94Q+azROLaqg0Ha7LCdt
	amSHUdk6gvuKyQrgZL5P3twg+JjGc/D0+FKEbXed0dURoxtErYX1hFbMGebrFXFHD0NDWicMHig
	5xftz70mKFA3qHVszfG5k7+NoX6B/pJWoulEUhpX2XIrKmWD6vqLKOzzhbv0CfaT4uPfholJXU8
	B3O3Sv5hA5YwAlf/eNShbw6WIowrufUUiIbRywgS//mwzzJbx7Wi7/8EmWbKYQqg==
X-Received: by 2002:a05:6820:827:b0:6b3:f4b8:bb86 with SMTP id 006d021491bc7-6d43f4bd3c4mr7072259eaf.22.1790370782754;
        Fri, 25 Sep 2026 14:13:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:12::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e814afe0sm3497974a34.6.2026.09.25.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/12] bpf: Build argument prototypes for subprog calls
Date: Fri, 25 Sep 2026 14:12:47 -0700
Message-ID: <20260925211256.1834061-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The common argument checker consumes a parameter-indexed bpf_func_proto,
while BPF subprogram argument metadata is cached by ABI slot in compact
bpf_subprog_info entries. Embedding a full prototype in every fixed
subprogram entry would waste memory.

Embed a scratch prototype in the verifier environment. Fill it by
walking BTF parameters and the cached slots with separate cursors,
mirroring the kfunc representation for parameters that occupy multiple
slots. Keep the compact cache as the source of truth. The verifier
environment is already heap allocated, so this avoids a separate
allocation, failure path, and cleanup.

Keep the existing validation loop, but make it consume the generated
prototype in preparation for moving BPF subprogram calls to the common
argument checker. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |   3 +-
 kernel/bpf/verifier.c        | 103 ++++++++++++++++++++++++-----------
 2 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 646e447cebd8..144da990ee8c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -972,6 +972,7 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_diag *diag;
+	struct bpf_func_proto bpf_subprog_scratch;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
@@ -1638,6 +1639,7 @@ struct bpf_call_arg_meta {
 	struct btf *btf;
 	u32 func_id;
 	const struct bpf_func_proto *fn;
+	const struct btf_type *func_proto;
 	u8 release_regno;
 	u32 ret_btf_id;
 	u32 subprogno;
@@ -1650,7 +1652,6 @@ struct bpf_call_arg_meta {
 	/* Only set by kfunc */
 	bool r0_rdonly;
 	u32 kfunc_flags;
-	const struct btf_type *func_proto;
 	const char *func_name;
 	struct arg_constant_desc arg_constant;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 43cae33d9921..65a1245e4edb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9940,20 +9940,20 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
  * func model recorded, or the verifier would check an argument at a slot
  * the JIT does not place it at.
  */
-static u32 kfunc_arg_slots(const struct btf_type *t)
+static u32 btf_arg_slots(const struct btf_type *t)
 {
 	if (btf_type_is_int(t) || btf_type_is_struct(t))
 		return (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
 	return 1;
 }
 
-static u32 kfunc_proto_slots(const struct btf *btf, const struct btf_type *func_proto)
+static u32 btf_proto_slots(const struct btf *btf, const struct btf_type *func_proto)
 {
 	const struct btf_param *args = btf_params(func_proto);
 	u32 i, nargs = btf_type_vlen(func_proto), slots_used = 0;
 
 	for (i = 0; i < nargs; i++)
-		slots_used += kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
+		slots_used += btf_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
 
 	return slots_used;
 }
@@ -9996,7 +9996,7 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 	 * count. Only a proto whose parameters take a slot each can name the
 	 * argument a stack slot belongs to.
 	 */
-	proto_slots = meta->btf ? kfunc_proto_slots(meta->btf, meta->func_proto) : nargs;
+	proto_slots = meta->btf ? btf_proto_slots(meta->btf, meta->func_proto) : nargs;
 
 	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		err = check_outgoing_stack_args(env, caller, proto_slots, meta->func_name,
@@ -10012,7 +10012,7 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 		nslots = 1;
 		if (args) {
 			t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
-			nslots = kfunc_arg_slots(t);
+			nslots = btf_arg_slots(t);
 		}
 
 		if (meta->fn->arg_type[arg] == ARG_UNUSED)
@@ -10797,6 +10797,22 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	return err;
 }
 
+static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const struct btf *btf,
+				  const struct btf_type *func_proto, struct bpf_func_proto *proto)
+{
+	const struct btf_param *args = btf_params(func_proto);
+	u32 arg, slot = 0;
+
+	memset(proto, 0, sizeof(*proto));
+	for (arg = 0; arg < btf_type_vlen(func_proto); arg++) {
+		const struct btf_type *t;
+
+		proto->arg_type[arg] = sub->args[slot].arg_type;
+		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
+		slot += btf_arg_slots(t);
+	}
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				    struct btf *btf,
 				    struct bpf_reg_state *regs)
@@ -10804,10 +10820,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
-	const struct btf_param *args;
+	const struct btf_param *args, *stack_args;
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
-	u32 i;
+	struct bpf_func_proto *fn;
+	u32 arg, slot, nslots;
 	int ret, err;
 
 	memset(&meta, 0, sizeof(meta));
@@ -10829,33 +10846,42 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
 	func_proto = btf_type_by_id(btf, func->type);
 	args = btf_params(func_proto);
-	if (sub->arg_slot_cnt != btf_type_vlen(func_proto))
-		args = NULL;
+	stack_args = sub->arg_slot_cnt == btf_type_vlen(func_proto) ? args : NULL;
 	ret = check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
-					bpf_subprog_name(env, subprog), btf, args);
+					bpf_subprog_name(env, subprog), btf, stack_args);
 	if (ret)
 		return ret;
 
+	fn = &env->bpf_subprog_scratch;
+	gen_subprog_arg_proto(sub, btf, func_proto, fn);
+	meta.fn = fn;
+	meta.func_proto = func_proto;
+
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
-	for (i = 0; i < sub->arg_slot_cnt; i++) {
-		argno_t argno = argno_from_arg(i + 1);
-		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
-		struct bpf_subprog_arg_info *arg = &sub->args[i];
+	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
+		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slot);
+		enum bpf_arg_type arg_type = fn->arg_type[arg];
+		argno_t argno = argno_from_arg(slot + 1);
+		const struct btf_type *t;
+		u32 k;
+
+		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
+		nslots = btf_arg_slots(t);
 
-		if (arg->arg_type == ARG_SCALAR) {
+		if (arg_type == ARG_SCALAR) {
 			if (reg->type != SCALAR_VALUE) {
 				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (arg->arg_type & PTR_UNTRUSTED) {
+		} else if (arg_type & PTR_UNTRUSTED) {
 			/*
 			 * Anything is allowed for untrusted arguments, as these are
 			 * read-only and probe read instructions would protect against
 			 * invalid memory access.
 			 */
-		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
+		} else if (arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
 			if (ret < 0)
 				return ret;
@@ -10867,11 +10893,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
+		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
+			if (check_mem_reg(env, reg, argno, sub->args[slot].mem_size,
+					  BPF_READ | BPF_WRITE, NULL,
 					  NULL))
 				return -EINVAL;
 			/*
@@ -10884,13 +10911,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 						reg_arg_name(env, argno), subprog);
 				return -EINVAL;
 			}
-			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
+			if (!(arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
+		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			/*
 			 * Can pass any value and the kernel won't crash, but
 			 * only PTR_TO_ARENA or SCALAR make sense. Everything
@@ -10903,38 +10930,50 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
+		} else if (arg_type == ARG_PTR_TO_DYNPTR) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
 			if (ret)
 				return ret;
 
 			ret = process_dynptr_func(env, reg, argno, env->insn_idx,
-						  arg->arg_type, &meta);
+						  arg_type, &meta);
 			if (ret)
 				return ret;
-		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
+		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			int err;
 
-			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type)) {
+			if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 				err = mark_arg_precision(env, argno);
 				if (err)
 					return err;
 				continue;
 			}
 
-			err = check_reg_type(env, reg, argno, arg->arg_type, &meta);
-			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
+			err = check_reg_type(env, reg, argno, arg_type, &meta);
+			err = err ?: check_func_arg_reg_off(env, reg, argno, arg_type);
 			if (!err && base_type(reg->type) == PTR_TO_BTF_ID)
-				err = process_arg_ptr_to_btf_id(env, reg, argno, arg->arg_type,
-								btf_vmlinux, arg->btf_id,
+				err = process_arg_ptr_to_btf_id(env, reg, argno, arg_type,
+								btf_vmlinux, sub->args[slot].btf_id,
 								&meta, env->insn_idx);
 			if (err)
 				return err;
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
-				     reg_arg_name(env, argno), arg->arg_type);
+				     reg_arg_name(env, argno), arg_type);
 			return -EFAULT;
 		}
+
+		for (k = 1; k < nslots; k++) {
+			argno_t extra_argno = argno_from_arg(slot + k + 1);
+			struct bpf_reg_state *extra_reg;
+
+			extra_reg = get_func_arg_reg(caller, regs, slot + k);
+			if (extra_reg->type != SCALAR_VALUE) {
+				bpf_log(log, "%s is not a scalar\n",
+					reg_arg_name(env, extra_argno));
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
@@ -14509,7 +14548,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	 * pointer, and neither does a slot past the last parameter.
 	 */
 	for (i = 0, slot = 0; i < nargs && slot < arg; i++)
-		slot += kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
+		slot += btf_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
 	if (i >= nargs || slot != arg)
 		return 0;
 
@@ -18792,7 +18831,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 		if (err < 0)
 			/* error would be reported later */
 			return false;
-		cs->arg_slot_cnt = kfunc_proto_slots(meta.btf, meta.func_proto);
+		cs->arg_slot_cnt = btf_proto_slots(meta.btf, meta.func_proto);
 		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
-- 
2.52.0

