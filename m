Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA0145B11
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641270; cv=none; b=lWfH2ShogTU2ofUzEN48az8mt2fbv4ROI5NHA5kKkBnvctMppwnN3qE0LflGqHMWpUMrDKSIQevAeaLtQlT83edTGuQYv9Bjg/LDublF/XwQxCjeQm9SutEuw1ynVN4xtgH7/+GDpEHgg59bp9HtdcB21gFnbZhJ+jVttPb13SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641270; c=relaxed/simple;
	bh=hqaJ1fHO85I3uqN25+LPGbXAEy2ZISjnwU1UiBwEiKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sniAT6ThuRa7/xqj1LsRqaKovf2vwxMVWN5Zfy5Wq9o5eLCYxC95HQ896FUlPPjw0NWcZvcHfSF3KSbyW/AJE47NqNh/EXvkRc531VYYNxhKONFDHUeWFVE29aH8tJqcQwSh54+JiowPpEIMe3J1mF2uvZAZwnd/d819E1juauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6+Mr5/Q; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6+Mr5/Q"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45eec22fab7so780480f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641267; x=1781246067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5FaQx968hXaFTFCcPcbUzQGc9Jb3NNgdhxQyiffUbI=;
        b=T6+Mr5/QZTxraHKL/Wb4APUkpsRqdKALcTGdzp8hWA1DuZPViwVOplspjDgEmYMnCS
         02XTJz4w1QDbkL41Sxhl6Q85Ys2oypH4HA2UPeXKWW1mIzTE2NbvyfZActqQHz+3DBW5
         Kc48tMdvXr4o9dAJ1czS4GHT7dtNX8jC3L2aZmS6EgLdCoeAISOzMx4mIbi+KttHwtZl
         w0Mvo/BNgJKuYEFDt8794V80a7Myt4Ja11cgojfz3uyws3p4/+yJ4tgTXTZ9DHJsvraT
         jF/Dla52KPXkIig2wiBw+xjFj8fSpSQxjhhtdLGOA4RbNxxjMA2IFnYesIebtCpmLdfE
         GSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641267; x=1781246067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5FaQx968hXaFTFCcPcbUzQGc9Jb3NNgdhxQyiffUbI=;
        b=SchE3BHZJaQ+wNQ0Mx48QEe8nvPYj/L5d1QtOvokyEt9I2D0FABJWZD+KTOYU6cUBl
         f9c43rtS5oEWbX1qvzxd7OZkcJO5rYcIwEu78Eyvmbw/7yfiTmKGMiTtAn2YjBrgssqI
         o1GGzCRHFqrtrdEvkVXcy6YWbMkGer02evvWyomaZ1wtwKiKdZp3Xg+Ts1lGE3R4qlFB
         sarMJCJezsJcMSa0lDgE+jyKtDHY3NmYtwx9eTA/PzaeHaARew39Nk35oXm+DEvQStG1
         vnubPqFYXY6Li7k4nAn4VsmnZ8ImPC1oqXRiwUeeHvJ54TnfKpTvcC/Zt5Oqvorz2ijw
         eIbg==
X-Gm-Message-State: AOJu0YzLQktGY6INYZjm2HRf8ySVeU/vppTU7WVpNc6m/At2X0wcSEzg
	9fYRos5JCyNg1LtZFTBXby8LVXI7HNxsrulVg7xLZBhv/fLzROjqZr1jQb4+DeU4
X-Gm-Gg: Acq92OGw10zvR2fXkTFcD90Y2VPBH76uYAf7jIXDSGZeH1LYs4YCCn0PfEl+a2QGpSa
	uxJbu/1o7Mq60qv6xG2IecLsDWpG3rOxX3kVV99IF3QBKruDvHSahopHxeB+Q2Q5GSnHkBbQh6f
	M/hWzPzWWvJYnNelQGGjzkM7wYL5TyRRgbnfKlKsYr5YZBhW1h4Bpgr522GASiXdIjSJOpJf/4X
	mxpyiw1ATa3cfsk13wd8aVWPf6KDtdk9RJ22Z5J0BuPkm/COnB5So/zF5qCtD3sAC3wR27Q1ZFC
	b71cLpY+KFMiXiZ7Drz4BC3p49I6BF54VibKbXZunv3o6lZcRzVg9VdEGCK812+nUrzNhCWEtW3
	BDNn1XjwpSLM1B6WSs0LbCEbe9PUCy454fH1Wkp1vmJCyW8ArHpRXRzwU63WdZ54TevibRm6z1f
	DPHxs/JYKTzbTZld4h3VDQs3JI+BITRg5ty0OJ49RlfpLkvAbY1ZodCKh80iyngkTBgJ7zs3m8b
	aL+OpLjkqP2z+6sJOoGBZkHT+kizs1cyOa9xPSG7sa8SpxOQS/Xe6whtycCsS0IgV9D7qtADXVi
X-Received: by 2002:a05:6000:4609:b0:460:3234:4472 with SMTP id ffacd0b85a97d-460323444d8mr2303544f8f.40.1780641266950;
        Thu, 04 Jun 2026 23:34:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm10127858f8f.32.2026.06.04.23.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/17] bpf: Report Call Type Safety argument errors
Date: Fri,  5 Jun 2026 08:34:01 +0200
Message-ID: <20260605063412.974640-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22666; i=memxor@gmail.com; h=from:subject; bh=hqaJ1fHO85I3uqN25+LPGbXAEy2ZISjnwU1UiBwEiKU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUsptyTSVWK68aYlC/ReyPG67zb/LPpZTc2d+41Ns++Sm 4Hf7Gw6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFgZoZ/2o1L6srZBbfZbFqh E39u682KrEdX8nhPb3FOCV2uJBdYwMiwJ9J/gt981bTzMnVrEuY+dHp+aFpLsEg3w/MDJwXNdvz jBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected helper and kfunc argument-contract failures with Call
Type Safety reports. Keep the existing terse verifier messages and add
reason, source context, causal register history, and targeted
suggestions.

Cover helper register-type mismatch, helper non-NULL pointer
requirements, kfunc trusted-pointer nullability, release kfunc
referenced-pointer requirements, kfunc memory arguments, memory/length
pairs, and kernel object pointer contracts.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |  37 +++++
 kernel/bpf/diagnostics.h |   4 +
 kernel/bpf/verifier.c    | 295 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 329 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 369b7813b5dc..169c1a2425c8 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -714,6 +714,43 @@ static const char *bpf_diag_arg_ordinal(int argno)
 	}
 }
 
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
+			       int regno, const char *call_name,
+			       const char *arg_name, const char *reason,
+			       const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+	const char *ordinal = bpf_diag_arg_ordinal(regno);
+	char arg_desc[48];
+
+	if (ordinal && arg_name)
+		scnprintf(arg_desc, sizeof(arg_desc), "%s argument (%s)",
+			  ordinal, arg_name);
+	else if (arg_name)
+		scnprintf(arg_desc, sizeof(arg_desc), "argument %s", arg_name);
+	else
+		scnprintf(arg_desc, sizeof(arg_desc), "argument");
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY,
+			       "invalid call argument");
+	bpf_diag_report_reason(env,
+			       "The %s to %s does not satisfy the verifier contract: %s.",
+			       arg_desc, call_name, reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "invalid %s for %s", arg_desc, call_name);
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 0bc5f3492c47..d8c433759dee 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -181,6 +181,10 @@ void bpf_diag_report_resource_state(struct bpf_verifier_env *env,
 				    const char *suggestion);
 void bpf_diag_report_ref_leak(struct bpf_verifier_env *env, u32 ref_id,
 			      u32 alloc_insn, u32 fail_insn);
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
+			       int regno, const char *call_name,
+			       const char *arg_name, const char *reason,
+			       const char *suggestion);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c26614bec2b..d2a776d2059c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8039,6 +8039,39 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
+static const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env,
+					   enum bpf_reg_type type)
+{
+	switch (base_type(type)) {
+	case NOT_INIT:
+		return "an uninitialized value";
+	case SCALAR_VALUE:
+		return "an integer scalar";
+	case PTR_TO_CTX:
+		return "a context pointer";
+	case PTR_TO_STACK:
+		return "a stack pointer";
+	case PTR_TO_MAP_VALUE:
+		if (type_may_be_null(type))
+			return "a nullable map value pointer";
+		return "a map value pointer";
+	case PTR_TO_MEM:
+		if (type_may_be_null(type))
+			return "a nullable memory pointer";
+		return "a memory pointer";
+	case PTR_TO_BTF_ID:
+		if (type_is_non_owning_ref(type))
+			return "a borrowed allocated object pointer";
+		if (type_is_ptr_alloc_obj(type))
+			return "an owned allocated object pointer";
+		if (type_flag(type) & PTR_UNTRUSTED)
+			return "an untrusted kernel object pointer";
+		return "a kernel object pointer";
+	default:
+		return reg_type_str(env, type);
+	}
+}
+
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			  enum bpf_arg_type arg_type,
 			  const u32 *arg_btf_id,
@@ -8092,6 +8125,27 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+	{
+		char expected_buf[160], reason[256];
+		int len = 0;
+
+		expected_buf[0] = '\0';
+		for (j = 0; j < i; j++)
+			len += scnprintf(expected_buf + len,
+					 sizeof(expected_buf) - len,
+					 "%s%s", j ? ", " : "",
+					 reg_type_str(env, compatible->types[j]));
+
+		scnprintf(reason, sizeof(reason),
+			  "it has type %s, but this helper argument accepts %s",
+			  bpf_diag_reg_type_plain(env, reg->type),
+			  expected_buf);
+		bpf_diag_report_call_type(env, env->insn_idx,
+					  reg_from_argno(argno),
+					  func_id_name(meta->func_id),
+					  reg_arg_name(env, argno), reason,
+					  "Pass a value with one of the accepted pointer or scalar types for this helper.");
+	}
 	return -EACCES;
 
 found:
@@ -8128,6 +8182,12 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_call_type(env, env->insn_idx,
+						  reg_from_argno(argno),
+						  func_id_name(meta->func_id),
+						  reg_arg_name(env, argno),
+						  "the pointer may be NULL, but this helper requires a non-NULL pointer",
+						  "Add a NULL check and call the helper only on the non-NULL path.");
 			return -EACCES;
 		}
 
@@ -8476,6 +8536,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 			func_id_name(meta->func_id), reg_arg_name(env, argno));
+			bpf_diag_report_call_type(env, insn_idx, regno,
+						  func_id_name(meta->func_id),
+						  reg_arg_name(env, argno),
+						  "release helpers require a value that owns a live resource returned by a matching acquire helper",
+						  "Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has "
+						  "already been transferred or released.");
 		return -EINVAL;
 	}
 
@@ -11560,9 +11626,22 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+		char arg_name[32], expected_type[64], reason[256];
+
+		strscpy(arg_name, reg_arg_name(env, argno), sizeof(arg_name));
+		bpf_diag_format_btf_type(expected_type, sizeof(expected_type),
+					 ref_t, ref_tname);
 		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
-			reg_arg_name(env, argno),
+			arg_name,
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+		scnprintf(reason, sizeof(reason),
+			  "the kfunc expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
+			  expected_type,
+			  bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_report_call_type(env, env->insn_idx,
+					  reg_from_argno(argno),
+					  meta->func_name, arg_name, reason,
+					  "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.");
 		return -EINVAL;
 	}
 	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
@@ -12209,7 +12288,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
+				char reason[256];
+
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects an integer scalar, but %s is %s",
+					  reg_arg_name(env, argno),
+					  bpf_diag_reg_type_plain(env, reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass an integer scalar value for this argument, not a pointer or resource object.");
 				return -EINVAL;
 			}
 
@@ -12219,8 +12309,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(reg->var_off)) {
+					char reason[256];
+
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, argno));
+					scnprintf(reason, sizeof(reason),
+						  "the kfunc requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
+						  reg_arg_name(env, argno));
+					bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  reg_arg_name(env, argno),
+								  reason,
+								  "Pass a compile-time constant or a value the verifier can prove is constant at this call.");
 					return -EINVAL;
 				}
 				if (regno >= 0)
@@ -12245,8 +12345,18 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				if (!tnum_is_const(reg->var_off)) {
+					char reason[256];
+
 					verbose(env, "%s is not a const\n",
 						reg_arg_name(env, argno));
+					scnprintf(reason, sizeof(reason),
+						  "the kfunc uses this argument as a return-buffer size, but %s is variable on this path",
+						  reg_arg_name(env, argno));
+					bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  reg_arg_name(env, argno),
+								  reason,
+								  "Pass a verifier-known constant size for this kfunc buffer argument.");
 					return -EINVAL;
 				}
 
@@ -12267,26 +12377,53 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
 		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
+			char expected_type[64], reason[256];
+
+			bpf_diag_format_btf_type(expected_type,
+						 sizeof(expected_type), ref_t,
+						 ref_tname);
+			scnprintf(reason, sizeof(reason),
+				  "the pointer may be NULL, but this kfunc requires a non-NULL pointer to %s",
+				  expected_type);
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_call_type(env, insn_idx, regno,
+						  func_name,
+						  reg_arg_name(env, argno),
+						  reason,
+						  "Add a NULL check and call the kfunc only on the non-NULL path.");
 			return -EACCES;
 		}
 
 		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
 		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
+			char expected_type[64], reason[256];
+
+			bpf_diag_format_btf_type(expected_type,
+						 sizeof(expected_type), ref_t,
+						 ref_tname);
+			scnprintf(reason, sizeof(reason),
+				  "release kfuncs require a resource-owning pointer to %s returned by a matching acquire kfunc",
+				  expected_type);
 			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 				func_name, reg_arg_name(env, argno));
+			bpf_diag_report_call_type(env, insn_idx, regno,
+						  func_name,
+						  reg_arg_name(env, argno),
+						  reason,
+						  "Pass the resource-owning pointer returned by the matching acquire kfunc, and avoid calling the release kfunc after ownership has "
+						  "already been transferred or released.");
 			return -EINVAL;
 		}
 
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-
 		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
@@ -12336,13 +12473,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
 				if (!is_kfunc_rcu(meta)) {
+					char expected_type[64], reason[256];
+
+					bpf_diag_format_btf_type(expected_type,
+								 sizeof(expected_type),
+								 ref_t, ref_tname);
 					verbose(env, "%s must be referenced or trusted\n",
 						reg_arg_name(env, argno));
+					scnprintf(reason, sizeof(reason),
+						  "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
+						  expected_type,
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
+					bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  reg_arg_name(env, argno),
+								  reason,
+								  "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU "
+								  "pointers.");
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
+					char expected_type[64], reason[256];
+
+					bpf_diag_format_btf_type(expected_type,
+								 sizeof(expected_type),
+								 ref_t, ref_tname);
 					verbose(env, "%s must be a rcu pointer\n",
 						reg_arg_name(env, argno));
+					scnprintf(reason, sizeof(reason),
+						  "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
+						  expected_type,
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
+					bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  reg_arg_name(env, argno),
+								  reason,
+								  "Use this kfunc with a pointer that is valid in an RCU read lock region.");
 					return -EINVAL;
 				}
 			}
@@ -12383,8 +12551,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
+				char reason[256];
+
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type));
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects a context pointer, but %s is %s",
+					  reg_arg_name(env, argno),
+					  bpf_diag_reg_type_plain(env, reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  reg_arg_name(env, argno),
+								  reason,
+								  "Pass the original program context pointer or preserve it before modifying registers.");
 				return -EINVAL;
 			}
 
@@ -12409,12 +12588,33 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			} else {
+				char reason[256];
+
 				verbose(env, "%s expected pointer to allocated object\n",
 					reg_arg_name(env, argno));
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects an allocated object pointer, but %s is %s",
+					  reg_arg_name(env, argno),
+					  bpf_diag_reg_type_plain(env, reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass a pointer returned by the matching BPF object allocation path.");
 				return -EINVAL;
 			}
 			if (!reg_is_referenced(env, reg)) {
+				char reason[256];
+
 				verbose(env, "allocated object must be referenced\n");
+				scnprintf(reason, sizeof(reason),
+					  "the allocated object pointer in %s must still carry verifier-tracked ownership, but this pointer no longer owns a live resource",
+					  reg_arg_name(env, argno));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass the owned object pointer before it is released or transferred.");
 				return -EINVAL;
 			}
 			if (meta->btf == btf_vmlinux) {
@@ -12580,8 +12780,25 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			ret = check_mem_reg(env, reg, argno, type_size);
-			if (ret < 0)
+			if (ret < 0) {
+				char arg_name[32], expected_type[64], reason[256];
+
+				strscpy(arg_name, reg_arg_name(env, argno),
+					sizeof(arg_name));
+				bpf_diag_format_btf_type(expected_type,
+							 sizeof(expected_type),
+							 ref_t, ref_tname);
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
+					  type_size, expected_type,
+					  bpf_diag_reg_type_plain(env,
+								  reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name, arg_name,
+							  reason,
+							  "Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.");
 				return ret;
+			}
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
@@ -12595,9 +12812,27 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
 							       argno, next_argno);
 				if (ret < 0) {
-					verbose(env, "%s and ", reg_arg_name(env, argno));
+					char mem_arg[32], size_arg[32];
+					char reason[256];
+
+					strscpy(mem_arg, reg_arg_name(env, argno),
+						sizeof(mem_arg));
+					strscpy(size_arg, reg_arg_name(env, next_argno),
+						sizeof(size_arg));
+					verbose(env, "%s and ", mem_arg);
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-						reg_arg_name(env, next_argno));
+						size_arg);
+					scnprintf(reason, sizeof(reason),
+						  "it is the memory pointer in a memory/length pair with %s, but it is %s and does not point to verifier-readable memory for the "
+						  "requested length",
+						  size_arg,
+						  bpf_diag_reg_type_plain(env,
+									  buff_reg->type));
+					bpf_diag_report_call_type(env, insn_idx, regno,
+								  func_name,
+								  mem_arg,
+								  reason,
+								  "Pass a stack, map, context, or other verifier-known memory pointer, and keep the paired length within that object.");
 					return ret;
 				}
 			}
@@ -12608,8 +12843,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(size_reg->var_off)) {
+					char reason[256];
+
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, next_argno));
+					scnprintf(reason, sizeof(reason),
+						  "the kfunc requires the paired memory size argument %s to be a verifier-known constant, but it is variable on this path",
+						  reg_arg_name(env, next_argno));
+					bpf_diag_report_call_type(env, insn_idx,
+								  reg_from_argno(next_argno),
+								  func_name,
+								  reg_arg_name(env, next_argno),
+								  reason,
+								  "Pass a compile-time constant or verifier-known constant for this memory size argument.");
 					return -EINVAL;
 				}
 				meta->arg_constant.found = true;
@@ -12629,8 +12875,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
+				char expected_type[64], reason[256];
+
+				bpf_diag_format_btf_type(expected_type,
+							 sizeof(expected_type),
+							 ref_t, ref_tname);
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects a pointer to BPF-managed refcounted object type %s, but this argument is not such an object pointer",
+					  expected_type);
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass a pointer returned by the matching BPF object allocation or lookup operation for this kfunc.");
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
@@ -12653,8 +12912,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_CONST_STR:
 			if (reg->type != PTR_TO_MAP_VALUE) {
+				char reason[256];
+
 				verbose(env, "%s doesn't point to a const string\n",
 					reg_arg_name(env, argno));
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects a pointer to a constant string stored in verifier-known memory, but %s is %s",
+					  reg_arg_name(env, argno),
+					  bpf_diag_reg_type_plain(env, reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass a constant string pointer that the verifier recognizes, such as a string stored in a read-only map value.");
 				return -EINVAL;
 			}
 			ret = check_arg_const_str(env, reg, argno);
@@ -12693,8 +12963,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 			if (reg->type != PTR_TO_STACK) {
+				char reason[256];
+
 				verbose(env, "%s doesn't point to an irq flag on stack\n",
 					reg_arg_name(env, argno));
+				scnprintf(reason, sizeof(reason),
+					  "the kfunc expects a stack pointer to an IRQ flag slot, but %s is %s",
+					  reg_arg_name(env, argno),
+					  bpf_diag_reg_type_plain(env, reg->type));
+				bpf_diag_report_call_type(env, insn_idx, regno,
+							  func_name,
+							  reg_arg_name(env, argno),
+							  reason,
+							  "Pass the same stack slot used by bpf_local_irq_save() or bpf_res_spin_lock_irqsave().");
 				return -EINVAL;
 			}
 			ret = process_irq_flag(env, reg, argno, meta);
-- 
2.53.0

