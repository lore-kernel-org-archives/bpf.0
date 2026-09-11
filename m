Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB703B8406
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164290; cv=none; b=iCjzFqJ9DLsIACVuu0eiODCM8dSBLeGGEvNGQSR0/FARBSUUGqxxqnBE82bfvjrr4m/Q2eb6VrDw7oeqe+PdpH0J6kc1/zeWU01FXsiVxKxZyGeCPQ7Bl0tqsKLmdxpPyCSNVLMiCBW4BFBW+FqSr3i2UcIjzkpWUYduTIal+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164290; c=relaxed/simple;
	bh=y9aWlmt6kFajjvRBrfeA3JjT/GN2fmKCL7Z/WACwYGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOAffkV9XKrwgKMGSJG9uLmhH/wsRtZZFmgiOAMPy3fvgcs9imH9SkfDn8tG/yjsUy+T9EtmP2LT6DzfGtmXiVBwzDBw8Ld1ttdPI+vbjZZI7VGXLuRsNmhGDa942l/lHEenakv7rTLBJ7PBVGSHaKSKD7TODzIN83jmPYcVdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTMs8tkP; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTMs8tkP"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-80576d65d8eso214413a34.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164282; x=1789769082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvfR0KdUO6QUYciRgMN95wy6/vKXrv0YOjWcezo2Owg=;
        b=DTMs8tkP7KPF3Rg60SJnvSvcItgMnnC5rEydcMcnOJOuQrtGRXxxLtrFUfsR4K8bEf
         A0/lSPNYW306cKgykH9qpEzqkHNWMzlgQX8lrdOzUifyw4hLxth+owJ+L9F01OajrhoU
         kcMaWHJrfZOPtQbwERGYslcJ8yzXV6xsWIVAjsZ0oX9eqEhDa75Ut7w4X3doH44adKpm
         8PpY9tPQ60ORBLMmKgqQOCAkQcrC+GRWKyKSLh39mCfkNt1EIgTr2SHpoQYUvM8FeedB
         ta8aayFCWlU/X/PtVbt8mN6lTyp6gHmbSv9VnvjSmZz5r3G8bW888zji1u6QmEQQAMlM
         IDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164282; x=1789769082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IvfR0KdUO6QUYciRgMN95wy6/vKXrv0YOjWcezo2Owg=;
        b=VoR/iy2CrbsPpWln5axOGNF3MtfTVzGATx7Ldnb4PBuKMPgCVVa3W+lDLiQe0dcZTJ
         EQHs63s8Dkgv2aoaWYGJBe6wmS//iTcocn/R5W4tXn3E+4bC0flp7xJF7xCDqzYZiMZ8
         pJVp9BfKbO2Q6CvjJtDGCJeNsLwO1mQPj/MGYfqbz0LCNSVbnp+S0STAhuXEvPYaVFh0
         KDDWU+OjA3cLOqyvhHTKwnV8+5TRFRHStT5NGngkOLKsNCAXaQZEi5RofSwKMDdlpTK0
         ycrHexDtPJQMSN2vDFdcj0cNwBt+PeWuWj6BjPFwMCBIF5iAiPZr7YeI/bZvNSJaR/k1
         Fmvw==
X-Gm-Message-State: AFuF++nody8Q7jkhrg/AmG7vzRn2yxrsQxPaLrs68T/yesbjYeR7H+B9
	J7g4rDNihFoLYRMdONqedsFdopejqkR0brbLNm4ueRJvPWKDL5suXrhRtV9A6Q==
X-Gm-Gg: AYBFou0nmrsYMLI36aHaEMJsHsHyKZ5J5DvvdpXG6oTZ0YkTOSU8qvgXCJSeyAM42If
	3cp2q+j2fq/1IShrSDu+4P1D25GuoG16mqBOU7P5wB/GrbuC5h2iYqxXtEiVt5qsiENWXC4bLJG
	4410OGY6nh5mqCPD5Vqr585/mkL1kz6JvEmLFIjUTnHkX6yUfQsjqnOvio/B9unWHXp8sVHEiHe
	7a/O0Lpxw1RvD62v6EwyWcXHl/jfxRTaGlLayPYPPNHgLR8tUkOk90ka30IDdetD1ukEwq6fsT9
	3PoDVyVDvpMu7sQ4WUwuH+4REzY3X2K3qFXmjFvORY0h/5gs1hapg4Lb9U73hkb47aIPfL4VQl2
	ymrVHTqIyOe33YH8XT6ih036KsXJJZu/qeOQJ752bmOFe3G+funGfQ9fWECgCDDMLBFurxepKO8
	7cIUHSVOvzcBF32TAkMlguL8J9irZTDNyFEfuq0gWmKcLQ37S5AoIS7cQ+R2Ri+g==
X-Received: by 2002:a05:6820:a294:10b0:6bd:a88f:c8c7 with SMTP id 006d021491bc7-6c0bc7be2f2mr3430959eaf.45.1789164281790;
        Fri, 11 Sep 2026 15:04:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0996dc5a6sm4006752eaf.6.2026.09.11.15.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 17/23] bpf: Consolidate helper and kfunc PTR_TO_BTF_ID argument matching
Date: Fri, 11 Sep 2026 15:04:09 -0700
Message-ID: <20260911220415.1396439-18-ameryhung@gmail.com>
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

Keep check_reg_type() focused on register admission. Helpers currently
match BTF-ID arguments there, while kfuncs use
process_kf_arg_ptr_to_btf_id(). Both paths ultimately call
btf_struct_ids_match().

Introduce process_arg_ptr_to_btf_id() for helpers, kfuncs, and global
subprograms. Callers provide the expected BTF and ID and retain their
call-specific metadata handling. Group the helper compatible-ID, poison,
and bpf_kptr_xchg() handling in a helper-only block in the
ARG_PTR_TO_BTF_ID case, leaving the common matcher outside it.

Derive strict matching from the generated argument type. This limits
KF_RELEASE strictness to the argument marked OBJ_RELEASE while
preserving the bpf_sk_release() exception and kfunc no-cast-alias rule.

Remove the post-admission BTF and nullability switch from
check_reg_type(), leaving it responsible for register admission. The
compatibility tables already limit helper MEM_ALLOC inputs to
ARG_PTR_TO_SPIN_LOCK and ARG_KPTR_XCHG_DEST, while the kptr source is
admitted only for bpf_kptr_xchg(). Drop the redundant helper-ID
whitelist, pointer-offset check, and constant-offset assertion.

The bpf_kptr_xchg() source match now follows offset validation, so a
source within a referenced object reports the release zero-offset error
before the kptr type error. Update the affected selftests and use
call-neutral wording for BTF mismatch diagnostics.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 215 +++++++-----------
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  14 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 6 files changed, 94 insertions(+), 143 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb825fc3ce0d..11d28c8d9c79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8248,6 +8248,10 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 				 struct bpf_reg_state *reg, u32 arg,
 				 struct bpf_call_arg_meta *meta, int insn_idx,
 				 enum bpf_arg_type *arg_type, u32 *arg_size);
+static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				     argno_t argno, enum bpf_arg_type arg_type,
+				     const struct btf *arg_btf, u32 arg_btf_id,
+				     struct bpf_call_arg_meta *meta, int insn_idx);
 
 struct bpf_reg_types {
 	const enum bpf_reg_type types[10];
@@ -8450,13 +8454,12 @@ static const char *bpf_diag_expected_reg_types(struct bpf_verifier_env *env,
 }
 
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			  enum bpf_arg_type arg_type, const u32 *arg_btf_id,
-			  struct bpf_call_arg_meta *meta)
+			  enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
 	const char *actual, *accepted;
-	int i, j, err;
+	int i, j;
 
 	compatible = compatible_reg_types[base_type(arg_type)];
 	if (!compatible) {
@@ -8512,90 +8515,6 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	return -EACCES;
 
 found:
-	if (base_type(reg->type) != PTR_TO_BTF_ID)
-		return 0;
-
-	if (compatible == &mem_types)
-		return 0;
-
-	switch ((int)reg->type) {
-	case PTR_TO_BTF_ID:
-	case PTR_TO_BTF_ID | PTR_TRUSTED:
-	case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
-	case PTR_TO_BTF_ID | MEM_RCU:
-	case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
-	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
-	{
-		/* For bpf_sk_release, it needs to match against first member
-		 * 'struct sock_common', hence make an exception for it. This
-		 * allows bpf_sk_release to work for multiple socket types.
-		 */
-		bool strict_type_match = arg_type_is_release(arg_type) &&
-					 !is_helper_call(meta, BPF_FUNC_sk_release);
-
-		if (!arg_btf_id) {
-			if (!compatible->btf_id) {
-				verifier_bug(env, "missing arg compatible BTF ID");
-				return -EFAULT;
-			}
-			arg_btf_id = compatible->btf_id;
-		}
-
-		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
-			if (map_kptr_match_type(env, meta->kptr_field, reg, reg_from_argno(argno)))
-				return -EACCES;
-		} else {
-			if (arg_btf_id == BPF_PTR_POISON) {
-				verbose(env, "verifier internal error:");
-				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
-					reg_arg_name(env, argno));
-				return -EACCES;
-			}
-
-			err = __check_ptr_off_reg(env, reg, argno, true);
-			if (err)
-				return err;
-
-			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
-						  reg->var_off.value, btf_vmlinux, *arg_btf_id,
-						  strict_type_match, !type_is_alloc(reg->type))) {
-				verbose(env, "%s is of type %s but %s is expected\n",
-					reg_arg_name(env, argno),
-					btf_type_name(reg->btf, reg->btf_id),
-					btf_type_name(btf_vmlinux, *arg_btf_id));
-				return -EACCES;
-			}
-		}
-		break;
-	}
-	case PTR_TO_BTF_ID | MEM_ALLOC:
-	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
-	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
-	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
-		if (!is_helper_call(meta, BPF_FUNC_spin_lock) &&
-		    !is_helper_call(meta, BPF_FUNC_spin_unlock) &&
-		    !is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
-			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-			return -EFAULT;
-		}
-		/* Check if local kptr in src arg matches kptr in dst arg */
-		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
-			int regno = reg_from_argno(argno);
-
-			if (regno == BPF_REG_2 &&
-			    map_kptr_match_type(env, meta->kptr_field, reg, regno))
-				return -EACCES;
-		}
-		break;
-	case PTR_TO_BTF_ID | MEM_PERCPU:
-	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU:
-	case PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED:
-		/* Handled by helper specific checks */
-		break;
-	default:
-		verifier_bug(env, "invalid PTR_TO_BTF_ID register for type match");
-		return -EFAULT;
-	}
 	return 0;
 }
 
@@ -8872,7 +8791,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	int regno = reg_from_argno(argno);
 	enum bpf_reg_type type = reg->type;
-	const u32 *arg_btf_id = NULL;
 	u32 arg_size = arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
 	u32 key_size;
 	int err = 0;
@@ -8924,12 +8842,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
-	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
-		arg_btf_id = fn->arg_btf_id[arg];
-
-	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
+	err = check_reg_type(env, reg, argno, arg_type, meta);
 	if (err)
 		return err;
 
@@ -9027,6 +8940,43 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta, NULL);
 		break;
+	case ARG_PTR_TO_BTF_ID:
+	case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
+	{
+		const u32 *arg_btf_id = fn->arg_btf_id[arg];
+
+		if (!meta->btf) {
+			const struct bpf_reg_types *compatible;
+
+			if (base_type(reg->type) != PTR_TO_BTF_ID)
+				break;
+
+			if (is_helper_call(meta, BPF_FUNC_kptr_xchg))
+				return map_kptr_match_type(env, meta->kptr_field, reg, regno) ?
+				       -EACCES : 0;
+
+			if (!arg_btf_id) {
+				compatible = compatible_reg_types[base_type(arg_type)];
+				if (!compatible->btf_id) {
+					verifier_bug(env, "missing arg compatible BTF ID");
+					return -EFAULT;
+				}
+				arg_btf_id = compatible->btf_id;
+			}
+			if (arg_btf_id == BPF_PTR_POISON) {
+				verbose(env, "verifier internal error:");
+				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
+					reg_arg_name(env, argno));
+				return -EACCES;
+			}
+		}
+
+		err = process_arg_ptr_to_btf_id(env, reg, argno, arg_type, btf_vmlinux,
+						*arg_btf_id, meta, insn_idx);
+		if (err < 0)
+			return err;
+		break;
+	}
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
 			verbose(env, "Helper has invalid btf_id in %s\n", reg_arg_name(env, argno));
@@ -9973,8 +9923,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				continue;
 			}
 
-			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta);
+			err = check_reg_type(env, reg, argno, arg->arg_type, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
+			if (!err && base_type(reg->type) == PTR_TO_BTF_ID)
+				err = process_arg_ptr_to_btf_id(env, reg, argno, arg->arg_type,
+								btf_vmlinux, arg->btf_id,
+								&meta, env->insn_idx);
 			if (err)
 				return err;
 		} else {
@@ -12511,32 +12465,28 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
-static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
-					struct bpf_reg_state *reg,
-					const struct btf_type *ref_t,
-					const char *ref_tname, u32 ref_id,
-					struct bpf_call_arg_meta *meta,
-					int arg, argno_t argno)
+static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				     argno_t argno, enum bpf_arg_type arg_type,
+				     const struct btf *arg_btf, u32 arg_btf_id,
+				     struct bpf_call_arg_meta *meta, int insn_idx)
 {
-	const struct btf_type *reg_ref_t;
-	bool strict_type_match = false;
+	bool taking_projection, struct_same, strict_type_match = false;
+	const struct btf_type *arg_t, *reg_t;
+	const char *arg_tname, *reg_tname;
 	const struct btf *reg_btf;
-	const char *reg_ref_tname;
-	bool taking_projection;
-	bool struct_same;
-	u32 reg_ref_id;
+	u32 reg_btf_id;
 
 	if (base_type(reg->type) == PTR_TO_BTF_ID) {
 		reg_btf = reg->btf;
-		reg_ref_id = reg->btf_id;
+		reg_btf_id = reg->btf_id;
 	} else {
 		reg_btf = btf_vmlinux;
-		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
+		reg_btf_id = *reg2btf_ids[base_type(reg->type)];
 	}
 
-	/* Enforce strict type matching for calls to kfuncs that are acquiring
-	 * or releasing a reference, or are no-cast aliases. We do _not_
-	 * enforce strict matching for kfuncs by default,
+	/*
+	 * Enforce strict type matching for arguments that release a reference,
+	 * or are no-cast aliases. We do _not_ enforce strict matching by default,
 	 * as we want to enable BPF programs to pass types that are bitwise
 	 * equivalent without forcing them to explicitly cast with something
 	 * like bpf_cast_to_kern_ctx().
@@ -12558,27 +12508,30 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
 	 * resolve types.
 	 */
-	if ((is_kfunc_release(meta) && reg_is_referenced(env, reg)) ||
-	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
+	if ((arg_type_is_release(arg_type) && !is_helper_call(meta, BPF_FUNC_sk_release)) ||
+	    (meta->btf && btf_type_ids_nocast_alias(&env->log, reg_btf, reg_btf_id,
+						    arg_btf, arg_btf_id)))
 		strict_type_match = true;
 
-	WARN_ON_ONCE(is_kfunc_release(meta) && !tnum_is_const(reg->var_off));
+	arg_t = btf_type_skip_modifiers(arg_btf, arg_btf_id, &arg_btf_id);
+	arg_tname = btf_name_by_offset(arg_btf, arg_t->name_off);
+	reg_t = btf_type_skip_modifiers(reg_btf, reg_btf_id, &reg_btf_id);
+	reg_tname = btf_name_by_offset(reg_btf, reg_t->name_off);
+
+	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_btf_id,
+					  reg->var_off.value, arg_btf, arg_btf_id,
+					  strict_type_match, !type_is_alloc(reg->type));
 
-	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
-	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
-	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->var_off.value,
-					   meta->btf, ref_id, strict_type_match,
-					   !type_is_alloc(reg->type));
 	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
 	 * actually use it -- it must cast to the underlying type. So we allow
 	 * caller to pass in the underlying type.
 	 */
-	taking_projection = btf_is_projection_of(ref_tname, reg_ref_tname);
+	taking_projection = meta->btf && btf_is_projection_of(arg_tname, reg_tname);
 	if (!taking_projection && !struct_same) {
-		verbose(env, "kernel function %s %s expected pointer to %s %s but %s has a pointer to %s %s\n",
+		verbose(env, "%s %s expected pointer to %s %s but %s has a pointer to %s %s\n",
 			meta->func_name, reg_arg_name(env, argno),
-			btf_type_str(ref_t), ref_tname, reg_arg_name(env, argno),
-			btf_type_str(reg_ref_t), reg_ref_tname);
+			btf_type_str(arg_t), arg_tname,
+			reg_arg_name(env, argno), btf_type_str(reg_t), reg_tname);
 		return -EINVAL;
 	}
 	return 0;
@@ -13076,7 +13029,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			    int insn_idx)
 {
-	const char *func_name = meta->func_name, *ref_tname;
+	const char *func_name = meta->func_name;
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_reg_state *regs = cur_regs(env);
 	const struct btf *btf = meta->btf;
@@ -13098,7 +13051,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	for (i = 0; i < nargs; i++) {
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		enum bpf_arg_type arg_type = meta->fn->arg_type[i];
-		const struct btf_type *t, *ref_t;
+		const struct btf_type *t;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
 		u32 ref_id = args[i].type;
@@ -13114,10 +13067,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
-		if (btf_type_is_ptr(t)) {
-			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		}
+		if (btf_type_is_ptr(t))
+			btf_type_skip_modifiers(btf, t->type, &ref_id);
 
 		ret = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
 		if (ret < 0)
@@ -13433,8 +13384,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 
-			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname,
-							ref_id, meta, i, argno);
+			ret = process_arg_ptr_to_btf_id(env, reg, argno, arg_type, btf,
+						   ref_id, meta, insn_idx);
 			if (ret < 0)
 				return ret;
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index 14d4c1793aed..d74a9db54c9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -13,13 +13,13 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } test_bpf_nf_fail_tests[] = {
-	{ "alloc_release", "kernel function bpf_ct_release R1 expected pointer to STRUCT nf_conn but" },
-	{ "insert_insert", "kernel function bpf_ct_insert_entry R1 expected pointer to STRUCT nf_conn___init but" },
-	{ "lookup_insert", "kernel function bpf_ct_insert_entry R1 expected pointer to STRUCT nf_conn___init but" },
-	{ "set_timeout_after_insert", "kernel function bpf_ct_set_timeout R1 expected pointer to STRUCT nf_conn___init but" },
-	{ "set_status_after_insert", "kernel function bpf_ct_set_status R1 expected pointer to STRUCT nf_conn___init but" },
-	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout R1 expected pointer to STRUCT nf_conn but" },
-	{ "change_status_after_alloc", "kernel function bpf_ct_change_status R1 expected pointer to STRUCT nf_conn but" },
+	{ "alloc_release", "bpf_ct_release R1 expected pointer to STRUCT nf_conn but" },
+	{ "insert_insert", "bpf_ct_insert_entry R1 expected pointer to STRUCT nf_conn___init but" },
+	{ "lookup_insert", "bpf_ct_insert_entry R1 expected pointer to STRUCT nf_conn___init but" },
+	{ "set_timeout_after_insert", "bpf_ct_set_timeout R1 expected pointer to STRUCT nf_conn___init but" },
+	{ "set_status_after_insert", "bpf_ct_set_status R1 expected pointer to STRUCT nf_conn___init but" },
+	{ "change_timeout_after_alloc", "bpf_ct_change_timeout R1 expected pointer to STRUCT nf_conn but" },
+	{ "change_status_after_alloc", "bpf_ct_change_status R1 expected pointer to STRUCT nf_conn but" },
 	{ "write_not_allowlisted_field", "no write support to nf_conn at off" },
 	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted R2" },
 	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted R4" },
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 0d7365b704b1..186b56357110 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -291,7 +291,7 @@ int reject_bad_type_xchg(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("invalid kptr access, R2 type=trusted_ptr_prog_test_ref_kfunc")
+__failure __msg("R2 must have zero offset when passed to release func")
 int reject_member_of_ref_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *ref_ptr;
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 8f0c45421f89..ff08aa75d6f7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -128,7 +128,7 @@ int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
 }
 
 SEC("lsm.s/file_open")
-__failure __msg("kernel function bpf_path_d_path R1 expected pointer to STRUCT path but R1 has a pointer to STRUCT file")
+__failure __msg("bpf_path_d_path R1 expected pointer to STRUCT path but R1 has a pointer to STRUCT file")
 int BPF_PROG(path_d_path_kfunc_type_mismatch, struct file *file)
 {
 	bpf_path_d_path((struct path *)&file->f_task_work, buf, sizeof(buf));
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index eb6e3baef412..d730215e520b 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -152,7 +152,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "kernel function bpf_kfunc_call_memb1_release R1 expected pointer",
+	.errstr = "bpf_kfunc_call_memb1_release R1 expected pointer",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_memb_acquire", 1 },
 		{ "bpf_kfunc_call_memb1_release", 5 },
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 1efaff296b7c..345cecc722a3 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -342,7 +342,7 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member",
+	.errstr = "R2 must have zero offset when passed to release func",
 },
 {
 	"map_kptr: ref: reference state created and released on xchg",
-- 
2.52.0

