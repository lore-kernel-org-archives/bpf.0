Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524E497B6C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164283; cv=none; b=HAsf5D7uV+ElV6VXlsAUglGxqcovLfre4OZLBhIoC880XTRe/PZB+dPZwHqwRS3zPSHgEL0qDkTP1KhFl5OOGH8vWMhZbDc2srj8AQqa11T89CrPfS2NhZcY+L5tuj6UGKXNXrJq475M4dREMI2kTWpPaO5Ijwp1UNgrfbPdmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164283; c=relaxed/simple;
	bh=5w0LFhyrG5pg0tzR77d849jHo9OtLcul4MpcpA1Q1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+ffu+/FSp8KDI+7ueMA/hgnn597Trk0axyFA8t98OrXTWvhJMJSLP/pyNBe5LAMXxhp31ISLQf8Rl00l7C2hTh41AeCqabd+r78dNzjfx3TnHc/gr5oXDMNpB+vFo9t5G9muOOIYYRC4Wx+Tzl0Ye2AIY6kTllZwiywdTMDSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM7xXpdu; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM7xXpdu"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7f4f0dd550aso19936a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164277; x=1789769077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwZVKviNk/j3h3VHRBIiezluI19v8eu2/Xqpo2KButQ=;
        b=QM7xXpduMk10Uad6DEnvh2zjxhF2t47desUjVep83AT3wIMcWr5qoEeDcruapwL/xo
         D3I/qgjVLotHYDNvO4Z7foEjBmYkNaOY5pkY5cI8nDkPYxegykThDpICXhQtqQ/kJE5w
         t4DRPJPzItHg3a2fvbl1HkIl6DrlJPtCToo+qjDQ4kmKkpGrd6CMgTg4/9VOmJ4Z3Jhr
         d5X1qdXOsbqiOOiHGe6xc+twU0mV5GnrhDYur6JOXw5/4VDXzhiCyFyf/SRi5SxY2pyI
         bQ6NbsxFyY9+2y9osV3/ML7sn6pCfDmf92VrKoe9sFkJ14MDmBCQMkUR2w0bUYO8HY/u
         eicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164277; x=1789769077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwZVKviNk/j3h3VHRBIiezluI19v8eu2/Xqpo2KButQ=;
        b=SBXQdGkdsdZAvwIRjm2cAuIxYBEOf0vEjfAMpJQvlHj7TqczJ4Xp9723vOIdKtE9Yp
         twJxgQwahRDJIhWeTmIaGakImqMj1PRCcRvmOUbHDRmM5C71pgwqdTpD2SdJD26uAka8
         KhWn64MN2rBcjGPStiCMW3H+gbGCGKVb/mWLAZ+Xjv8ImF4GmRB4Ews98Z43IJyqUzL3
         Agj+iO/3Ft1e4YtDC2B7E+tsjYoQcAaB2s8KN1HxGQjBcQBNK0RlBnpcamYJbqN9ndho
         BlYP9QteeUoacVb4IRZcAucOzBR1hfPpLH+nlhNOmfnHrDjXN8ynThrBBsaosrU5FGLz
         7Nbw==
X-Gm-Message-State: AFuF++nrLS5+RqY33RFmh9m3EKmACMUSdJTh79e1gvyJCnmOzdDSrS1e
	g6cWvMrt9NwDhqdnvfkQnXkUyTne8FcdeNAbp8HtR/J6v9SmRHsxn8aAaDuWdw==
X-Gm-Gg: AYBFou0idptLwM538pvlUVqGnxcT87NjjHbWfxZji2i+MulP5hh5WZR822b848bZgIF
	A+rK+ftsuLbxxyDMpsyEMcRGU+w0mY/9cNgODyozCcjO97joLsBNeIr2ocejJbU6zaS/ZhNOtXO
	KeVoGZow3WLpjinLNHwNASDjfcY+9vNWT7M1R3FDlNY5FQWSn7is72MUVxrYjTt0qicle1Hzebf
	oQyG67X5RN3ChAiNNx30ThaHNEpNsNwg7AjZycLlDH0GG4zJfjmqy9dQk2t6TgbWS/fmBzrfSUU
	eGby36mLmblAtF0gai0jNl0f/BjgSXqaVE23ka/Vq/e+Kcw2Kmc9aExox4ZZ5RWyfeVA8rhVki/
	3iAjbyiAJoGAKctKH/o4v7Q2zp/2Oo0w6xn5l+5yeTkzfntdYlMdcC6Y7ZkNwYfRN8TqiNqvLY/
	i83RLwIBkwoY1XL8bZgOQbxG2Zb8Ebow5hdxfcz3ZPNfq9sd72rzpKhgubtg/dpA==
X-Received: by 2002:a05:6830:2b20:b0:7f4:e011:6b2b with SMTP id 46e09a7af769-8059e84fcd0mr195128a34.1.1789164277420;
        Fri, 11 Sep 2026 15:04:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-804de582afcsm1878590a34.16.2026.09.11.15.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 14/23] bpf: Consolidate runtime argument type resolution
Date: Fri, 11 Sep 2026 15:04:06 -0700
Message-ID: <20260911220415.1396439-15-ameryhung@gmail.com>
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

A function argument type can require call-site refinement before
register admission. Helpers refine map-value arguments according to the
recorded map type, while kfuncs reinterpret a pointer to a scalar-only
BTF struct as fixed-size memory when the register does not carry a
BTF ID.

Add resolve_func_arg_type() as the common entry point. It delegates
helper map-value refinement to the existing resolve_map_arg_type(),
then handles the kfunc BTF-to-memory fallback. It updates the effective
argument type and size consumed by the subsequent checks.

Preserve PTR_MAYBE_NULL when changing the base type so later
nullability validation observes the BTF contract. Keep OBJ_RELEASE
arguments in their original pointer class. The latter is not a bug fix:
existing kfunc checking already validates ownership before this
resolver. It preserves release metadata for the later shared checking
order, where ownership validation follows register admission.

Moving the kfunc fallback before admission lets the resulting
fixed-size memory argument enter the compatibility check directly.
This is another step toward routing both call types through
check_func_arg().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 194 ++++++++++++++++++++++++------------------
 1 file changed, 109 insertions(+), 85 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 615a5667e569..4e7230cb5791 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8196,8 +8196,8 @@ static bool is_kfunc_call(const struct bpf_call_arg_meta *meta, u32 btf_id)
 }
 
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
-				 const struct bpf_call_arg_meta *meta,
-				 enum bpf_arg_type *arg_type)
+				const struct bpf_call_arg_meta *meta,
+				enum bpf_arg_type *arg_type)
 {
 	if (!meta->map.ptr) {
 		/* kernel subsystem misconfigured verifier */
@@ -8225,6 +8225,11 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int resolve_func_arg_type(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *reg, u32 arg,
+				 struct bpf_call_arg_meta *meta, int insn_idx,
+				 enum bpf_arg_type *arg_type, u32 *arg_size);
+
 struct bpf_reg_types {
 	const enum bpf_reg_type types[10];
 	u32 *btf_id;
@@ -8840,6 +8845,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	int regno = reg_from_argno(argno);
 	enum bpf_reg_type type = reg->type;
 	const u32 *arg_btf_id = NULL;
+	u32 arg_size = arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
 	u32 key_size;
 	int err = 0;
 
@@ -8872,11 +8878,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
-	if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
-		err = resolve_map_arg_type(env, meta, &arg_type);
-		if (err)
-			return err;
-	}
+	err = resolve_func_arg_type(env, reg, arg, meta, insn_idx, &arg_type, &arg_size);
+	if (err)
+		return err;
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		/* A NULL register has a SCALAR_VALUE type, so skip
@@ -9017,12 +9021,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_mem_reg(env, reg, argno, fn->arg_size[arg],
+			err = check_mem_reg(env, reg, argno, arg_size,
 					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta, NULL);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
-				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
+				err = check_ptr_alignment(env, reg, 0, arg_size, true);
 		}
 		break;
 	case ARG_MEM_SIZE:
@@ -11911,6 +11915,65 @@ static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
 }
 
+static int resolve_func_arg_type(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *reg, u32 arg,
+				 struct bpf_call_arg_meta *meta, int insn_idx,
+				 enum bpf_arg_type *arg_type, u32 *arg_size)
+{
+	argno_t argno = argno_from_arg(arg + 1);
+	const struct btf_param *args;
+	const struct btf_type *ref_t, *resolve_ret;
+	const struct btf *btf;
+	const char *ref_tname;
+	u32 ref_id;
+
+	if (base_type(*arg_type) == ARG_PTR_TO_MAP_VALUE)
+		return resolve_map_arg_type(env, meta, arg_type);
+
+	if (base_type(*arg_type) != ARG_PTR_TO_BTF_ID)
+		return 0;
+
+	if (!meta->btf || arg_type_is_release(*arg_type) ||
+	    base_type(reg->type) == PTR_TO_BTF_ID ||
+	    reg2btf_ids[base_type(reg->type)])
+		return 0;
+	args = btf_params(meta->func_proto);
+	ref_id = *meta->fn->arg_btf_id[arg];
+	btf = is_kfunc_arg_map(meta->btf, &args[arg]) ? btf_vmlinux : meta->btf;
+	ref_t = btf_type_skip_modifiers(btf, ref_id, &ref_id);
+	ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+	if (!btf_type_is_scalar_struct(env, btf, ref_t)) {
+		enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
+		const char *expected_type;
+
+		verbose(env, "%s is %s expected %s %s",
+			reg_arg_name(env, argno), reg_type_str(env, reg->type),
+			btf_type_str(ref_t), ref_tname);
+		if (reg2btf_type != NOT_INIT)
+			verbose(env, " or %s", reg_type_str(env, reg2btf_type));
+		verbose(env, "\n");
+		expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
+		bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+				      "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
+				      "the function expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
+				      expected_type,
+				      bpf_diag_reg_type_plain(env, reg->type));
+		return -EINVAL;
+	}
+
+	resolve_ret = btf_resolve_size(btf, ref_t, arg_size);
+	if (IS_ERR(resolve_ret)) {
+		verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
+			reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname,
+			PTR_ERR(resolve_ret));
+		return -EINVAL;
+	}
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+
+	return 0;
+}
+
 static void btf_member_path_str(const struct btf *btf, const struct btf_member_path *path,
 				char *buf, size_t buf_sz)
 {
@@ -12990,7 +13053,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	for (i = 0; i < nargs; i++) {
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		enum bpf_arg_type arg_type = meta->fn->arg_type[i];
-		const struct btf_type *t, *ref_t, *resolve_ret;
+		const struct btf_type *t, *ref_t;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
 		u32 ref_id = args[i].type;
@@ -13053,11 +13116,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
 			ref_id = *meta->fn->arg_btf_id[i];
 
-		if (is_kfunc_arg_map(btf, &args[i])) {
-			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		}
-
+		ret = resolve_func_arg_type(env, reg, i, meta, insn_idx, &arg_type, &arg_size);
+		if (ret < 0)
+			return ret;
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
@@ -13306,80 +13367,43 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case ARG_PTR_TO_BTF_ID:
-			/* Only base_type is checked, further checks are done here */
-			if (base_type(reg->type) == PTR_TO_BTF_ID ||
-			    reg2btf_ids[base_type(reg->type)]) {
-				if (!is_trusted_reg(env, reg) ||
-				    bpf_type_has_unsafe_modifiers(reg->type)) {
-					if (!(arg_type & MEM_RCU)) {
-						const char *expected_type;
-
-						expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-						verbose(env, "%s must be referenced or trusted\n",
-							reg_arg_name(env, argno));
-						bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-								      "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU pointers.",
-								      "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
-								      expected_type,
-								      reg_arg_name(env, argno),
-								      bpf_diag_reg_type_plain(env, reg->type));
-						return -EINVAL;
-					}
-					if (!is_rcu_reg(reg)) {
-						const char *expected_type;
-
-						expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-						verbose(env, "%s must be a rcu pointer\n",
-							reg_arg_name(env, argno));
-						bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-								      "Use this kfunc with a pointer that is valid in an RCU read lock region.",
-								      "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
-								      expected_type,
-								      reg_arg_name(env, argno),
-								      bpf_diag_reg_type_plain(env, reg->type));
-						return -EINVAL;
-					}
-				}
+			if (!is_trusted_reg(env, reg) ||
+			    bpf_type_has_unsafe_modifiers(reg->type)) {
+				if (!(arg_type & MEM_RCU)) {
+					const char *actual_type, *arg_name, *expected_type;
 
-				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i, argno);
-				if (ret < 0)
-					return ret;
-				break;
-			}
+					expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
+					verbose(env, "%s must be referenced or trusted\n",
+						reg_arg_name(env, argno));
+					arg_name = reg_arg_name(env, argno);
+					actual_type = bpf_diag_reg_type_plain(env, reg->type);
+					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							      "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU pointers.",
+							      "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
+							      expected_type, arg_name, actual_type);
+					return -EINVAL;
+				}
+				if (!is_rcu_reg(reg)) {
+					const char *actual_type, *arg_name, *expected_type;
 
-			if (!btf_type_is_scalar_struct(env, meta->btf, ref_t)) {
-				enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
-				const char *expected_type;
-
-				verbose(env, "%s is %s expected %s %s",
-					reg_arg_name(env, argno), reg_type_str(env, reg->type),
-					btf_type_str(ref_t), ref_tname);
-				if (reg2btf_type != NOT_INIT)
-					verbose(env, " or %s", reg_type_str(env, reg2btf_type));
-				verbose(env, "\n");
-				expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-						      "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
-						      "the kfunc expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
-						      expected_type,
-						      bpf_diag_reg_type_plain(env, reg->type));
-				return -EINVAL;
+					expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
+					verbose(env, "%s must be a rcu pointer\n",
+						reg_arg_name(env, argno));
+					arg_name = reg_arg_name(env, argno);
+					actual_type = bpf_diag_reg_type_plain(env, reg->type);
+					bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							      "Use this kfunc with a pointer that is valid in an RCU read lock region.",
+							      "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
+							      expected_type, arg_name, actual_type);
+					return -EINVAL;
+				}
 			}
 
-			/*
-			 * If the register does not contain btf id but the argument type is a pointer to
-			 * scalar-only struct, allow verifying it as a fixed size memory.
-			 */
-			resolve_ret = btf_resolve_size(btf, ref_t, &arg_size);
-			if (IS_ERR(resolve_ret)) {
-				verbose(env,
-					"%s reference type('%s %s') size cannot be determined: %ld\n",
-					reg_arg_name(env, argno), btf_type_str(ref_t),
-					ref_tname, PTR_ERR(resolve_ret));
-				return -EINVAL;
-			}
-			arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
-			fallthrough;
+			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname,
+							ref_id, meta, i, argno);
+			if (ret < 0)
+				return ret;
+			break;
 		case ARG_PTR_TO_MEM:
 			if (arg_type & MEM_FIXED_SIZE) {
 				bool known_memory;
-- 
2.52.0

