Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00826F288
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902803; cv=none; b=fJ/Cg9sgry+IcdAALAZZZMG0ophz2C/Sb1NVBmvfva0QYH+x1FJ5f4DxLA/IKRa9FuSpzBAN/v5SareUCq5gfM4Gi1Um4jQcFck80ZPpPCuaU9U8pJVZzA+YfjGMyTeqDYfBLZtN0/TQ81tggQ4q4hlXXA5C62TxCI/k5z8a6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902803; c=relaxed/simple;
	bh=LezZX8wXVk/uguowe9Ju5EGGiwS1nQuEHYHdc87CzYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfIKZRDtm7QqH9fXa2LE+rQA77hrn+yWZjfpHh61WPFSugx2AScvzi3OmTVJBU0fPSySduKJvc/n3U2+21F98DVfzKdcB7Zo0z8IIEMyhKNrNl8RiLZo+ep93aS64cZsGS3mCcHTabv26pPtvsx822rgT+ZnetXzfIXYt+D0yUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi4gZfTK; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi4gZfTK"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso33405125e9.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902787; x=1782507587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeX3jxRv4eWCePANJOWGmET4S23yfE8lp+CoKuzf2LM=;
        b=Vi4gZfTKvOqs0xmqkQigkml1PnLhumYFIH1WDrP5QJ4li217h+c0s3zX7Z8dsmOUXq
         qtOYi0gKHbJ0DwIZ2kMkPVnhOHEOjuQfVJOiFSfOsbUCCsB95qQ9c3lWbvDFxDumcwis
         NaFDffYbJ1fvdY9LJTIqkL+4d2Uk1Matxocsx3T/QN73rCx0iupLEeF6Md5nlVm+iSlw
         ok74MifuAsMgD6UpqbjjbQnGpZ7cRVsGc5gubTXaqwpvA2vodcrIQKmxYmqzZguE5VIx
         3DzOidi9V+oE98cehTgaLBQEoUg13RC+lMDw478y/qiU2etBYiXdIlfjGosLVxqQoQx+
         /ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902787; x=1782507587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeX3jxRv4eWCePANJOWGmET4S23yfE8lp+CoKuzf2LM=;
        b=KsxkyM4U6zM6cM2vhkNqtjZjU6CDh2itueMnuqET5W/vNEZglWH1mfAOPmijVWokko
         vuh90HMWxddJl97D3D5d6KqF+hdC7WXYg3TxH767nNBzG0PwyVABR44xExm4JUyPT2mm
         c94ce82pfQwLTf0ar+dK7z0yv/BAUddMAoYD51B+eSR3HoiWRaSuUxheAwszqP0AzTF1
         mHUfg/CNUsuTQ8QT+rA76cwwo7lyxyUGobGgdSQMth39fU+Q3CAGoKqk/fpIX1IzSmz0
         487nFVol9S6Vasfn+o0jikiMfpb16buBQGTXL461a79yKUXquepgHgPRwRGGYcK1yi11
         CV+Q==
X-Gm-Message-State: AOJu0YzeCf1TwtGpuxC3ct4FpFOUyAh2hJLv9S5o10xWMLqvdKds1rQr
	Fjv1fXIRH0ae/B4krTZrAYBLrtPGZzrNslJpcZq+GkSBM7xKz50At4IK5/pgI9dK
X-Gm-Gg: AfdE7cl3AEYFJqeWlgp5To3UKtkXmaY+WTOCnPzAqtl0r29yahBwEWZfrD4zq0iLFE9
	orr6cxJH38CBg48k0JrBdtilknUzCIm3VF0Bj3R+XJ6OMKGAMHJuyx+9+4768OQozjU326M/Y1f
	cCt1jR5wSbCdHy5pRsKKkLFlPrS1bRAVPfYe6EHmDfYFqm79zHdHKWKpFua9E1+tss+v1tEIBs0
	dHp7IbZyGD0FcBqb35WgDdslTbd8LwJVAdvYk/560XoBhVHl5bXdJofHthCHebEfaOnl9YNWv9C
	s+KdjxuwHkhHUAE6cHRYbBF48DS9OD/TsrL32ZfXpUvJEXy+1P5EKQ54dT4rghBqzv/mUFjXRI6
	o236FBGqKBGGPjdhWB5efmYwQakmexAYWAnD9y3onmDKfu9OOFib9uWD9DwDf3BKlOYgETaRpPw
	BjcE8THAGJcoRURNuzANJyZQY45S8nTl7r8FQTOFVFjdmBW9Ro5Ig7ioaj9mOtV2BmtR4jzOJPU
	eM+FCHpwIBbLg6jXFrPYdm0UUcYkKP1in7ep9uETG4MOXA9S7fnbPk=
X-Received: by 2002:a05:600d:108:20b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-4923f5a0083mr74139955e9.34.1781902786763;
        Fri, 19 Jun 2026 13:59:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944faa8sm9635325e9.13.2026.06.19.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 11/17] bpf: Report Call Type Safety argument errors
Date: Fri, 19 Jun 2026 22:59:24 +0200
Message-ID: <20260619205934.1312876-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22946; i=memxor@gmail.com; h=from:subject; bh=LezZX8wXVk/uguowe9Ju5EGGiwS1nQuEHYHdc87CzYQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FUOR6I4D0zk6QrW33djBck31W9Ur++NC5t5znva/P ROje/VvRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYitZ3hn6HmhuTjp1sS/klX xl1xzAv1YHWKfq5ZGTOn/MOcCTxB5owMt18z3S2v9la/6fBo9d+IhHZW93dMvr9s/vzSCyg5xBr GBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected helper and kfunc argument-contract failures with Call Type
Safety reports. Keep the existing terse verifier messages and add reason,
source context, causal register or stack-argument history, and targeted
suggestions.

Cover helper register-type mismatch, helper and kfunc non-NULL pointer
requirements, release-helper ownership requirements, scalar and constant kfunc
arguments, trusted and RCU pointer contracts, kfunc memory arguments,
memory/length pairs, refcounted kptrs, constant strings, and IRQ flag stack
arguments.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |  52 ++++++++
 kernel/bpf/diagnostics.h |   4 +
 kernel/bpf/verifier.c    | 249 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 295 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index e9c58f84ec89..19e72b07afc1 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -901,6 +901,58 @@ static const char *bpf_diag_arg_ordinal(int argno)
 	}
 }
 
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
+			       int argno, int regno, int stack_arg_slot,
+			       const char *call_name, const char *arg_name,
+			       const char *reason, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.frameno = bpf_diag_current_frameno(env),
+	};
+	const char *ordinal = bpf_diag_arg_ordinal(argno);
+	const char *arg_desc;
+	bool print_history = true;
+
+	if (regno >= 0) {
+		opts.scope = BPF_DIAG_HISTORY_SCOPE_REG;
+		opts.regno = regno;
+	} else if (stack_arg_slot >= 0) {
+		opts.scope = BPF_DIAG_HISTORY_SCOPE_STACK_ARG;
+		opts.stack_arg_slot = stack_arg_slot;
+	} else {
+		print_history = false;
+	}
+
+	if (ordinal && arg_name)
+		arg_desc = bpf_diag_scratch_printf(env, 1,
+						   "%s argument (%s)",
+						   ordinal, arg_name);
+	else if (ordinal)
+		arg_desc = bpf_diag_scratch_printf(env, 1,
+						   "%s argument", ordinal);
+	else if (arg_name)
+		arg_desc = bpf_diag_scratch_printf(env, 1,
+						   "argument %s", arg_name);
+	else
+		arg_desc = bpf_diag_scratch_strcpy(env, 1,
+						   "argument");
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY,
+			       "invalid call argument");
+	bpf_diag_report_reason(env,
+			       "The %s to %s does not satisfy the verifier contract: %s.",
+			       arg_desc, call_name, reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "invalid %s for %s", arg_desc, call_name);
+
+	if (print_history)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4e0bb27ea951..07d06d366f22 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -198,6 +198,10 @@ void bpf_diag_report_irq_resource_state(struct bpf_verifier_env *env,
 					u32 depth);
 void bpf_diag_report_ref_leak(struct bpf_verifier_env *env, u32 ref_id,
 			      u32 alloc_insn, u32 fail_insn);
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
+			       int argno, int regno, int stack_arg_slot,
+			       const char *call_name, const char *arg_name,
+			       const char *reason, const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db151e6b8949..fdbf92bffc17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -320,6 +320,15 @@ static int arg_idx_from_argno(argno_t a)
 	return arg_from_argno(a) - 1;
 }
 
+static int bpf_diag_stack_arg_slot_from_argno(argno_t a)
+{
+	int arg = arg_from_argno(a);
+
+	if (arg <= MAX_BPF_FUNC_REG_ARGS)
+		return -1;
+	return arg - MAX_BPF_FUNC_REG_ARGS - 1;
+}
+
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -8161,6 +8170,8 @@ static const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env,
 			return "a nullable memory pointer";
 		return "a memory pointer";
 	case PTR_TO_BTF_ID:
+		if (type_may_be_null(type))
+			return "a nullable kernel object pointer";
 		if (type_is_non_owning_ref(type))
 			return "a borrowed allocated object pointer";
 		if (type_is_ptr_alloc_obj(type))
@@ -8173,6 +8184,60 @@ static const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env,
 	}
 }
 
+static void bpf_diag_report_call_arg(struct bpf_verifier_env *env,
+				     u32 insn_idx, argno_t argno,
+				     const char *call_name,
+				     const char *reason,
+				     const char *suggestion)
+{
+	bpf_diag_report_call_type(env, insn_idx, arg_from_argno(argno),
+				  reg_from_argno(argno),
+				  bpf_diag_stack_arg_slot_from_argno(argno),
+				  call_name && *call_name ? call_name : "call",
+				  reg_arg_name(env, argno), reason, suggestion);
+}
+
+static const char *diag_btf_type_name(struct bpf_verifier_env *env,
+				      const struct btf *btf, u32 type_id)
+{
+	return bpf_diag_format_btf_type_scratch(env, 1,
+						btf, type_id);
+}
+
+static const char *diag_arg_name(struct bpf_verifier_env *env,
+				 unsigned int slot, argno_t argno)
+{
+	return bpf_diag_scratch_strcpy(env, slot, reg_arg_name(env, argno));
+}
+
+static void diag_call_arg_fmt(struct bpf_verifier_env *env,
+			      u32 insn_idx, argno_t argno,
+			      const char *call_name,
+			      const char *suggestion,
+			      const char *fmt, ...) __printf(6, 7);
+static void diag_call_arg_fmt(struct bpf_verifier_env *env,
+			      u32 insn_idx, argno_t argno,
+			      const char *call_name,
+			      const char *suggestion,
+			      const char *fmt, ...)
+{
+	size_t size;
+	va_list args;
+	char *reason;
+
+	reason = bpf_diag_scratch_buf(env, 0, &size);
+	if (reason) {
+		va_start(args, fmt);
+		vscnprintf(reason, size, fmt, args);
+		va_end(args);
+	} else {
+		reason = "";
+	}
+
+	bpf_diag_report_call_arg(env, insn_idx, argno, call_name, reason,
+				 suggestion);
+}
+
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			  enum bpf_arg_type arg_type,
 			  const u32 *arg_btf_id,
@@ -8226,6 +8291,32 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+	{
+		size_t expected_size;
+		char *expected_buf;
+		const char *call_name;
+		int len = 0;
+
+		expected_buf = bpf_diag_scratch_buf(env, 1,
+						    &expected_size);
+		if (expected_buf) {
+			expected_buf[0] = '\0';
+			for (j = 0; j < i && len < expected_size; j++)
+				len += scnprintf(expected_buf + len,
+						 expected_size - len,
+						 "%s%s", j ? ", " : "",
+						 reg_type_str(env, compatible->types[j]));
+		} else {
+			expected_buf = "";
+		}
+
+		call_name = meta->func_id ? func_id_name(meta->func_id) : "callee";
+		diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
+				  "Pass a value with one of the accepted pointer or scalar types for this call.",
+				  "it has type %s, but this argument accepts %s",
+				  bpf_diag_reg_type_plain(env, reg->type),
+				  expected_buf);
+	}
 	return -EACCES;
 
 found:
@@ -8262,6 +8353,10 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_call_arg(env, env->insn_idx, argno,
+						 func_id_name(meta->func_id),
+						 "the pointer may be NULL, but this helper requires a non-NULL pointer",
+						 "Add a NULL check and call the helper only on the non-NULL path.");
 			return -EACCES;
 		}
 
@@ -8597,7 +8692,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno_from_reg(regno), arg_type, arg_btf_id, meta);
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
 
@@ -8610,6 +8705,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 			func_id_name(meta->func_id), reg_arg_name(env, argno));
+		bpf_diag_report_call_arg(env, insn_idx, argno,
+					 func_id_name(meta->func_id),
+					 "release helpers require a value that owns a live resource returned by a matching acquire helper",
+					 "Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
 		return -EINVAL;
 	}
 
@@ -11716,7 +11815,8 @@ static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
 		       struct bpf_reg_state *regs, struct bpf_kfunc_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
-		       const char *ref_tname, const struct btf_param *args,
+		       const char *ref_tname, u32 ref_id,
+		       const struct btf_param *args,
 		       int arg, int nargs, argno_t argno, struct bpf_reg_state *reg)
 {
 	bool arg_mem_size = false;
@@ -11808,9 +11908,20 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+		const char *expected_type;
+
+		expected_type = bpf_diag_format_btf_type_scratch(env,
+								 1,
+								 meta->btf,
+								 ref_id);
 		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
 			reg_arg_name(env, argno),
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+		diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
+				  "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
+				  "the kfunc expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
+				  expected_type,
+				  bpf_diag_reg_type_plain(env, reg->type));
 		return -EINVAL;
 	}
 	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
@@ -12461,6 +12572,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar value for this argument, not a pointer or resource object.",
+						  "the kfunc expects an integer scalar, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12472,6 +12588,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(reg->var_off)) {
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno,
+							  func_name,
+							  "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
+							  "the kfunc requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
+							  reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 				if (regno >= 0)
@@ -12498,6 +12619,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(reg->var_off)) {
 					verbose(env, "%s is not a const\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno,
+							  func_name,
+							  "Pass a verifier-known constant size for this kfunc buffer argument.",
+							  "the kfunc uses this argument as a return-buffer size, but %s is variable on this path",
+							  reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 
@@ -12518,28 +12644,50 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
 		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
+			const char *expected_type;
+
+			expected_type = bpf_diag_format_btf_type_scratch(env,
+									 1,
+									 btf,
+									 ref_id);
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
+			diag_call_arg_fmt(env, insn_idx, argno, func_name,
+					  "Add a NULL check and call the kfunc only on the non-NULL path.",
+					  "the pointer may be NULL, but this kfunc requires a non-NULL pointer to %s",
+					  expected_type);
 			return -EACCES;
 		}
 
 		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
 		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
+			const char *expected_type;
+
+			expected_type = bpf_diag_format_btf_type_scratch(env,
+									 1,
+									 btf,
+									 ref_id);
 			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 				func_name, reg_arg_name(env, argno));
+			diag_call_arg_fmt(env, insn_idx, argno, func_name,
+					  "Pass the resource-owning pointer returned by the matching acquire kfunc, and avoid calling the release kfunc after ownership has already been transferred or released.",
+					  "release kfuncs require a resource-owning pointer to %s returned by a matching acquire kfunc",
+					  expected_type);
 			return -EINVAL;
 		}
 
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-
-		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno, reg);
+		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta,
+						     t, ref_t, ref_tname,
+						     ref_id, args, i, nargs,
+						     argno, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12587,13 +12735,35 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
 				if (!is_kfunc_rcu(meta)) {
+					const char *expected_type;
+
+					expected_type = diag_btf_type_name(env, btf,
+									   ref_id);
 					verbose(env, "%s must be referenced or trusted\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno,
+							  func_name,
+							  "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU pointers.",
+							  "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
+							  expected_type,
+							  reg_arg_name(env, argno),
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
+					const char *expected_type;
+
+					expected_type = diag_btf_type_name(env, btf,
+									   ref_id);
 					verbose(env, "%s must be a rcu pointer\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno,
+							  func_name,
+							  "Use this kfunc with a pointer that is valid in an RCU read lock region.",
+							  "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
+							  expected_type,
+							  reg_arg_name(env, argno),
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return -EINVAL;
 				}
 			}
@@ -12636,6 +12806,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the original program context pointer or preserve it before modifying registers.",
+						  "the kfunc expects a context pointer, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12662,10 +12837,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			} else {
 				verbose(env, "%s expected pointer to allocated object\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a pointer returned by the matching BPF object allocation path.",
+						  "the kfunc expects an allocated object pointer, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the owned object pointer before it is released or transferred.",
+						  "the allocated object pointer in %s must still carry verifier-tracked ownership, but this pointer no longer owns a live resource",
+						  reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (meta->btf == btf_vmlinux) {
@@ -12831,8 +13015,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			ret = check_mem_reg(env, reg, argno, type_size);
-			if (ret < 0)
+			if (ret < 0) {
+				const char *expected_type;
+
+				expected_type = diag_btf_type_name(env, btf,
+								   ref_id);
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
+						  "the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
+						  type_size, expected_type,
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return ret;
+			}
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
@@ -12846,9 +13040,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
 							       argno, next_argno);
 				if (ret < 0) {
-					verbose(env, "%s and ", reg_arg_name(env, argno));
+					const char *mem_arg, *size_arg_name;
+
+					mem_arg = diag_arg_name(env, 1,
+								argno);
+					size_arg_name = diag_arg_name(env, 2,
+								      next_argno);
+					verbose(env, "%s and ", mem_arg);
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-						reg_arg_name(env, next_argno));
+						size_arg_name);
+					diag_call_arg_fmt(env, insn_idx, argno,
+							  func_name,
+							  "Pass a stack, map, context, or other verifier-known memory pointer, and keep the paired length within that object.",
+							  "it is the memory pointer in a memory/length pair with %s, but it is %s and does not point to verifier-readable memory for the requested length",
+							  size_arg_name,
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return ret;
 				}
 			}
@@ -12861,6 +13067,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(size_reg->var_off)) {
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, next_argno));
+					diag_call_arg_fmt(env, insn_idx, next_argno,
+							  func_name,
+							  "Pass a compile-time constant or verifier-known constant for this memory size argument.",
+							  "the kfunc requires the paired memory size argument %s to be a verifier-known constant, but it is variable on this path",
+							  reg_arg_name(env, next_argno));
 					return -EINVAL;
 				}
 				meta->arg_constant.found = true;
@@ -12880,8 +13091,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
+				const char *expected_type;
+
+				expected_type = diag_btf_type_name(env, btf,
+								   ref_id);
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a pointer returned by the matching BPF object allocation or lookup operation for this kfunc.",
+						  "the kfunc expects a pointer to BPF-managed refcounted object type %s, but this argument is not such an object pointer",
+						  expected_type);
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
@@ -12906,6 +13125,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a const string\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a constant string pointer that the verifier recognizes, such as a string stored in a read-only map value.",
+						  "the kfunc expects a pointer to a constant string stored in verifier-known memory, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			ret = check_arg_const_str(env, reg, argno);
@@ -12946,6 +13170,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_STACK) {
 				verbose(env, "%s doesn't point to an irq flag on stack\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the same stack slot used by bpf_local_irq_save() or bpf_res_spin_lock_irqsave().",
+						  "the kfunc expects a stack pointer to an IRQ flag slot, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			ret = process_irq_flag(env, reg, argno, meta);
-- 
2.53.0

