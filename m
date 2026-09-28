Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495637E5DD
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619262; cv=none; b=Cb3fTd3SbVK3buGKXeSAo1gUP4De2fD89HOvC728wSCAORRdFvwMMXBRyhrJbrbvQHWItAwjh25kBkbYYUVh+wNI3Iu1hRAbigpbpv2pf/5QHTipEuwSV6VVevEmr35virg9G0Kp/RKBj7cxG/xnErz5K6greIaO3H6eaXWmZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619262; c=relaxed/simple;
	bh=btntanXihUbAVSPflz+0fF2hPVOJZsLJWicci3KLJaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7k6901JA54pN554HIFHy1kGcbmwJFgwVF9PEpOGVW6dkK6t0Ys6CUgaJEKJ1Vs1rOWZheLl/sMvLX8EgMpuaC4mMcusmVJyg2N3W1zidzs5Wz57zfAg+H17MfmZ8A09K0GpxFiq4p3VYLnVb67MX/ABEua/4wstvSaFyOwXhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDayFLpG; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDayFLpG"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a29bf27so1534704b6e.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619259; x=1791224059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DkXyQyCT07vRfCH6Jnj1/i1oY5OvEjBWyIMa3aYOWR4=;
        b=bDayFLpGwa7tlw+nmTlsywWfZiUMqo2eQaeFZzFMihGTtzaou0K6dcEAFmXv0LV5gu
         iqJcTEF+s/xV6nCAmBPl402dEWcmunsZayyJDtrKrZ7H9mDFaWxq8oNOfJ7eG1pISzKj
         F4FVUcpsUb00zuvEjwPP6eWP/6pkGZmdUvfOQJHU9d+Frcn0smUxuvy65eezRu9cX90M
         gOQuYgsUAxDLhPotIxv5WwVVr8ggDssIchaDnubapfvQV7rFFquewVBAs64/Us9dow3v
         GSAEDMj3Xv1UNrB96p6Xxp69RYa0EpN5gBLFRScFPrq7YgwgM9OpARnA77NFoWCO3IZh
         Vjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619259; x=1791224059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DkXyQyCT07vRfCH6Jnj1/i1oY5OvEjBWyIMa3aYOWR4=;
        b=bhhy9CBIDoPVIB4m5irfZIuMFFP7PNnms294VEuc5TYKcNTVI5FhrgQJOGZL8Kc6pz
         D6uKghXY84wtFtejlrDN+fqGakkkA4YUKtlgD7x0gaB1Sj3s7eTXHcggJZC+uuEcKKFo
         aJo4JEGnt1BggI7UxMvuGSD9l+A34CHDR+1MozzxegXe91C9VpvtZuXXq1f2Rzwn0FyY
         OKGDxPsOum1fMSoNa4BYhIqZpJRZUq2EU3oN+zAmLhuCNcbTwZjwsQgRmsUuYJIvaDP/
         6FxfbpbDeCHFoBtE1WD4nteUdb91gyCAPNqcIsFxC0pDdiA+1PG8emS/Z1t86TDOqVrO
         +kAQ==
X-Gm-Message-State: AFuF++nWe6LDiTNdQlzj+vkAg+USX6syQPuNByYoMjoaSZ2k6KNJ5Ry9
	SJ8kdrVYqo8QLlhg8t/94bE2jRG4sBQvfbnCe21JpdwkOFn/LACUlvQaE9hwRw==
X-Gm-Gg: AYBFou2xpKdmCOuNLKRpVVEJpBOWuqaFt8L2sL4iWHb6LmeWoFm3QE3jM445Ua4xAQP
	N6goaQSOi2r623hdivnMZu/8xSWMnHUvZWtcVeQC+FipEOE8zb03ufrZQnMFBIWIDEx2C2zttn8
	TPHQYyEthHiyTuJ7ioRNv1MpyVx9gItv1pRWzdJJ+U4SN4aSNLu+akSWgk5lZhwXOnnvMAxdumR
	NWJtsceyEY/jyFBVMFAUSIKUrb3pmu5Z602QTkNH7jwZ0yNlq1rQk3CITBd0fcxKhavrnYji+fu
	HpbuxIHdbJnowbAFsJ+qoYmRcO6E7nDKMyNG0tXkfrEzGUDjWRRlMie1iAbvU3kNue/+yKHGMCM
	A0irR57Mp1duxPyynNrIAo7vLOvwms15qqwiJxbwRA//NMKz3cIyDRUajsGjmIrVw00vRHbkaIU
	my7+JZkcVV1OgOeA9BpD5jGVvVguinBngeQe84ZzFX8mJO1tcyW1gV2GoNBSEBEA==
X-Received: by 2002:a05:6808:1c0d:b0:4e6:fdeb:9348 with SMTP id 5614622812f47-4e6fdeb98f1mr5990092b6e.24.1790619259236;
        Mon, 28 Sep 2026 11:14:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbbb2042bsm2492861b6e.7.2026.09.28.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/11] bpf: Build argument prototypes for subprog calls
Date: Mon, 28 Sep 2026 11:14:05 -0700
Message-ID: <20260928181414.644158-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
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
index c61141617d47..d2281b27f17b 100644
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

