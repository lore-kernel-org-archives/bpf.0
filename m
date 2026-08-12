Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233D42DFE6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577632; cv=none; b=pTUj3M7XuOd8ctl06hgG7a3UuknWSaJHdbUVuZItooKf+oySM1gjS7dgJNlqTK7kD1wkrIkNjRA+rRzJ4kKQdk+ueHXbETgyEigsykePmlUh0sxEpTWKzOuzS8zKHflcKww1egD8g0UZcyH3XvG21fi7yUhjgN6rZmvs4s0YzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577632; c=relaxed/simple;
	bh=gm0KaXd3kb+LZcJwEXSizN37mhfr4nTdixG+yWHbYX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLrCFlvY1qADO/SnD45sr4VKE/ieArwevfnHTXgiaIk6IoBj8EIiwG3CcW0CSfNwnBMwQrxHxhwRPImBm2Z1A+1OX6lO0JG9skcrgqmViW4RX9u15g7byeuzFq9KW1XdzRwK8hiiDUjFvulNJw9De45uZdAwOjGUJySQMFnAV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2CCbDg6; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2CCbDg6"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso373270f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577628; x=1787182428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/K4aPmCxNb8SLMnMFSoeHFc/HkvatUCjR61P+eneoY=;
        b=o2CCbDg6AY6vO/ZRRRK6WfjihQ69GwZTmN8lV59ZDzs6wLYA7tgSeRyd1wp9jAyzvs
         G2Unso7gLkuP5B+uypXpAonXkmvgM+Ll9Ej9EJQQ0p1L4b5dlgm+t5BwrGg/RvzqcoEq
         aYkxCuF4IoFxYjc+jspa3olp65qJPT/ls8Kaqqa9wThFN3ArG97MkP2qairHZcQyaFNp
         0HNVjC1Ti7VagWDNdnZVyYmIiTxxPfSSnXs5NcRzi3rzfoSuTkdNmtfiogKnQKk+EpVs
         GvHo1l6D+JrM4mWY7b+38+g+mIdTwjpF0KFhiiaT+iRfvjZ1n5cUKU+2IAp6oAEVgEvx
         j7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577628; x=1787182428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/K4aPmCxNb8SLMnMFSoeHFc/HkvatUCjR61P+eneoY=;
        b=CVWSscPzxJDpPwYLnda/i4iNnLOGh06HHexDzhR7V7+GYPjbCELr+UQeRd0bjfvvxi
         FdCdKsTip8E47Ea/VE4L4rTQzotTarxko63p1scWnPbEg70Mtu0V04fOk1j0ldgnO7Rf
         Dkmpkn4jrixCY2yYEuacZf+daQJWd46H14jL8ADOFTXcAJmG8L7TzMUVE16MOxLA7SCO
         skcsTEQCYoBrncXFIGKHGIrfz9gnZgU37Qa1qjqaam+kin0G6ozE8+VsHqXEbrTf+O9D
         mvbjr27sgC/QaVu6tQUurME1hqk8SnR4NvzcaCyREyFJrCbhvVwP06wCDshN22dbAGDG
         2r1Q==
X-Gm-Message-State: AOJu0YzZ/Y8LSaKeBojwNMYNXLYbae9DRfV2D3BCpAF7MJpQg1WitPnB
	vosJyWtPo5e/dQ9RBM9iFZJJWYgHsw6ToihMB9WuMxN6h6HVnHQKyv5ECvkFmLJ+
X-Gm-Gg: AR+sD13Rla63jY8Q07AVsMRobTinblZYfZyZUR4pNg0JqSFe/Y+tEQKDmpUaZKAj4RV
	NN31ALjJH1beH0Ya+sBLCSEdy5A/uORJ9NXEUTIGXi5z/HF10sPkhRpetFS194Vl2HkwaeRvuSX
	h3uXrTNFR42CX/QFgd9N5RtMzYZcmJnO6044mu6EdFShTsnwZNWU68Yq5WmTA3wyErTacO4bLIi
	DSgTAtlxLTIApkFZKUYxsHhNXdi9cgzwO0fGUxrGmhPFmY/u6AcOdR5NN3MBXDN5EAJSqL990fH
	d++t7qbOBkkstAs56qcuBep6RuYnqEyFgAadHmYZxolgI9fBW/jf/Y5cEYhXfEdqhmCZ6Y8UPKz
	AA9ifu1IFKKeROw670BR2oeJQxjLIXSYGWDMklXTBjFw91zYWO37cJYfcp2llWS/1Rli4ooHIVV
	RYWlupwWBS7HD94UepCXMWq7GTkq/VblfweQ61M2UutP5X2ATw4LCDM0+hsWIvIKkLzzL5HQtzA
	B8MtUkYM067dbybfvs1XXMWLfkuRm7A/CboNaxEncX44ruTcCcF5+0ix5EO4DmOCOqrN4xA9u6V
	y1CR3d1TjHsUyN2F8i7meyUVmRk=
X-Received: by 2002:a05:600c:8b54:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-4998216b3bdmr16612275e9.8.1786577627619;
        Wed, 12 Aug 2026 16:33:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b03e70sm22645555e9.3.2026.08.12.16.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 11/16] bpf: Report Call Type Safety argument errors
Date: Thu, 13 Aug 2026 01:33:14 +0200
Message-ID: <20260812233326.3575958-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25365; i=memxor@gmail.com; h=from:subject; bh=gm0KaXd3kb+LZcJwEXSizN37mhfr4nTdixG+yWHbYX4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQefk1dBTMYZr7F9pTFm8zfTFQp0pfDfqpXl5VOKKm RNtfk/uKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESOqDP8d/nhFMC/QtbiX5oa y86W+PxJGg8O9LE/mesS4H1OWNx1ByPDMlNtnz2bbuedlLY2Ddo/dafc0XPfVF0vPLqQ7a7yRn8 nHwA=
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c                      |  63 ++++-
 kernel/bpf/diagnostics.h                      |   4 +
 kernel/bpf/verifier.c                         | 228 ++++++++++++++++--
 .../selftests/bpf/progs/verifier_map_in_map.c |   1 +
 4 files changed, 268 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 708415e74ceb..c4022aba8e67 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -175,7 +175,6 @@ int bpf_diag_init(struct bpf_verifier_env *env)
 	env->diag = kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
 	if (!env->diag)
 		return -ENOMEM;
-
 	INIT_LIST_HEAD(&env->diag->fmt_chunks);
 	return 0;
 }
@@ -927,6 +926,49 @@ static const char *diag_arg_ordinal(int argno)
 	}
 }
 
+void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
+			       int stack_arg_slot, const char *call_name, const char *arg_name,
+			       const char *reason, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.frameno = diag_current_frameno(env),
+	};
+	const char *ordinal = diag_arg_ordinal(argno);
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
+		arg_desc = bpf_diag_fmt(env, "%s argument (%s)", ordinal, arg_name);
+	else if (ordinal)
+		arg_desc = bpf_diag_fmt(env, "%s argument", ordinal);
+	else if (arg_name)
+		arg_desc = bpf_diag_fmt(env, "argument %s", arg_name);
+	else
+		arg_desc = "argument";
+
+	bpf_diag_header(env, CALL_TYPE_SAFETY, "invalid call argument");
+	diag_reason(env, "The %s to %s does not satisfy the verifier contract: %s.",
+			   arg_desc, call_name, reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "invalid %s for %s", arg_desc, call_name);
+
+	if (print_history)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
@@ -1085,15 +1127,13 @@ void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int n
 		arg_buf = "";
 	bpf_diag_header(env, REGISTER_TYPE_SAFETY, "missing stack argument");
 	if (callee_name && *callee_name)
-		diag_reason(env,
-				   "Function %s expects %d arguments, but %s is not initialized at "
-				   "this call.",
-				   callee_name, nargs, arg_buf);
+		diag_reason(
+			env, "Function %s expects %d arguments, but %s is not initialized at this call.",
+			callee_name, nargs, arg_buf);
 	else
-		diag_reason(env,
-				   "The callee expects %d arguments, but %s is not initialized at "
-				   "this call.",
-				   nargs, arg_buf);
+		diag_reason(
+			env, "The callee expects %d arguments, but %s is not initialized at this call.",
+			nargs, arg_buf);
 
 	diag_section(env, "At");
 	bpf_diag_source(env, insn_idx, "error", "%s is not initialized", arg_buf);
@@ -1101,9 +1141,8 @@ void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int n
 	if (stack_arg_slot >= 0)
 		diag_print_history(env, &opts);
 
-	diag_suggestion(env, "Write the outgoing stack argument after any operation that "
-				    "may invalidate stored pointer values, and before making this "
-				    "call.");
+	diag_suggestion(
+		env, "Write the outgoing stack argument after any operation that may invalidate stored pointer values, and before making this call.");
 }
 
 void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 053655550856..9d4cdbcb1c75 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -6,6 +6,7 @@
 
 #include <linux/bpf.h>
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 
 struct bpf_reference_state;
@@ -138,6 +139,9 @@ void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *probl
 void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
 		  const char *reason, const char *suggestion, u32 depth);
 void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn);
+void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
+			       int stack_arg_slot, const char *call_name, const char *arg_name,
+			       const char *reason, const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24ae3cb38f6d..7e28f4d9f5c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8093,13 +8093,73 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
+static void bpf_diag_call_arg(struct bpf_verifier_env *env, u32 insn_idx, argno_t argno,
+				     const char *call_name, const char *reason,
+				     const char *suggestion)
+{
+	int arg = arg_from_argno(argno);
+	int stack_slot = -1;
+
+	if (arg > MAX_BPF_FUNC_REG_ARGS)
+		stack_slot = arg - MAX_BPF_FUNC_REG_ARGS - 1;
+
+	bpf_diag_call_type(env, insn_idx, arg, reg_from_argno(argno), stack_slot,
+				  call_name && *call_name ? call_name : "call",
+				  reg_arg_name(env, argno), reason, suggestion);
+}
+
+static const char *diag_btf_type_name(struct bpf_verifier_env *env, const struct btf *btf,
+				      u32 type_id)
+{
+	return bpf_diag_fmt_btf_type(env, btf, type_id);
+}
+
+static const char *diag_arg_name(struct bpf_verifier_env *env, argno_t argno)
+{
+	return bpf_diag_fmt(env, "%s", reg_arg_name(env, argno));
+}
+
+__printf(6, 7) static void diag_call_arg_fmt(struct bpf_verifier_env *env, u32 insn_idx,
+					     argno_t argno, const char *call_name,
+					     const char *suggestion, const char *fmt, ...)
+{
+	const char *reason;
+	va_list args;
+
+	va_start(args, fmt);
+	reason = bpf_diag_vfmt(env, fmt, args);
+	va_end(args);
+
+	bpf_diag_call_arg(env, insn_idx, argno, call_name, reason, suggestion);
+}
+
+static const char *diag_expected_reg_types(struct bpf_verifier_env *env,
+					   const enum bpf_reg_type *types, int count)
+{
+	size_t len = 0, size = 1;
+	char *buf;
+	int i;
+
+	for (i = 0; i < count; i++)
+		size += strlen(reg_type_str(env, types[i])) + (i ? 2 : 0);
+
+	buf = bpf_diag_fmt_buf(env, size);
+	if (!buf)
+		return "";
+
+	for (i = 0; i < count; i++)
+		len += scnprintf(buf + len, size - len, "%s%s", i ? ", " : "",
+				 reg_type_str(env, types[i]));
+	return buf;
+}
+
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			  enum bpf_arg_type arg_type,
-			  const u32 *arg_btf_id,
-			  struct bpf_call_arg_meta *meta)
+			  enum bpf_arg_type arg_type, const u32 *arg_btf_id,
+			  struct bpf_call_arg_meta *meta, const char *call_name)
 {
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
+	const char *actual, *accepted;
 	int i, j, err;
 
 	compatible = compatible_reg_types[base_type(arg_type)];
@@ -8146,6 +8206,12 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+	actual = bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
+	accepted = diag_expected_reg_types(env, compatible->types, i);
+	diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
+			  "Pass a value with one of the accepted pointer or scalar types for this call.",
+			  "it has type %s, but this argument accepts %s",
+			  actual, accepted);
 	return -EACCES;
 
 found:
@@ -8182,6 +8248,10 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_call_arg(
+				env, env->insn_idx, argno, call_name,
+				"the pointer may be NULL, but this call requires a non-NULL pointer",
+				"Add a NULL check and make the call only on the non-NULL path.");
 			return -EACCES;
 		}
 
@@ -8562,7 +8632,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta,
+			     func_id_name(meta->func_id));
 	if (err)
 		return err;
 
@@ -8575,6 +8646,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 			func_id_name(meta->func_id), reg_arg_name(env, argno));
+		bpf_diag_call_arg(
+			env, insn_idx, argno, func_id_name(meta->func_id),
+			"release helpers require a value that owns a live resource returned by a matching acquire helper",
+			"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
 		return -EINVAL;
 	}
 
@@ -9549,7 +9624,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta);
+			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta,
+					     bpf_subprog_name(env, subprog));
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
@@ -12361,29 +12437,43 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
-		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
+		if (btf_type_is_ptr(t)) {
+			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
+
+		if (btf_type_is_ptr(t) &&
+		    (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !type_may_be_null(kf_arg_type)) {
+			const char *expected_type;
+
+			expected_type = diag_btf_type_name(env, btf, ref_id);
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
+			expected_type = diag_btf_type_name(env, btf, ref_id);
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
 
-		if (btf_type_is_ptr(t)) {
-			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		}
-
-
 		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
 			continue;
 
@@ -12443,35 +12533,67 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_CONST:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar value for this argument, not a pointer or resource object.",
+						  "the kfunc expects an integer scalar, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
 			ret = process_const_arg(env, reg, argno, meta);
-			if (ret < 0)
+			if (ret < 0) {
+				if (ret == -EINVAL)
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
+							  "the kfunc requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
+							  reg_arg_name(env, argno));
 				return ret;
+			}
 			break;
 		case KF_ARG_ANYTHING:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar value for this argument, not a pointer or resource object.",
+						  "the kfunc expects an integer scalar, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			break;
 		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar value for this argument, not a pointer or resource object.",
+						  "the kfunc expects an integer scalar, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
 			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size"))
 				meta->r0_rdonly = true;
 			ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
-			if (ret < 0)
+			if (ret < 0) {
+				if (ret == -EINVAL)
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a verifier-known constant size for this kfunc buffer argument.",
+							  "the kfunc uses this argument as a return-buffer size, but %s is invalid or variable on this path",
+							  reg_arg_name(env, argno));
 				return ret;
+			}
 			break;
 		case KF_ARG_PTR_TO_CTX:
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
 
@@ -12505,10 +12627,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12661,18 +12792,37 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				if (!is_trusted_reg(env, reg) ||
 				    bpf_type_has_unsafe_modifiers(reg->type)) {
 					if (!is_kfunc_rcu(meta)) {
+						const char *expected_type;
+
+						expected_type = diag_btf_type_name(env, btf, ref_id);
 						verbose(env, "%s must be referenced or trusted\n",
 							reg_arg_name(env, argno));
+						diag_call_arg_fmt(env, insn_idx, argno, func_name,
+								  "Pass a pointer acquired from a verifier-tracked source, or call this kfunc only inside the required protection if it accepts RCU pointers.",
+								  "the kfunc requires a trusted or resource-owning pointer to %s, but %s is %s",
+								  expected_type,
+								  reg_arg_name(env, argno),
+								  bpf_diag_reg_type_plain(env, reg->type));
 						return -EINVAL;
 					}
 					if (!is_rcu_reg(reg)) {
+						const char *expected_type;
+
+						expected_type = diag_btf_type_name(env, btf, ref_id);
 						verbose(env, "%s must be a rcu pointer\n",
 							reg_arg_name(env, argno));
+						diag_call_arg_fmt(env, insn_idx, argno, func_name,
+								  "Use this kfunc with a pointer that is valid in an RCU read lock region.",
+								  "the kfunc requires an RCU-protected pointer to %s, but %s is %s",
+								  expected_type,
+								  reg_arg_name(env, argno),
+								  bpf_diag_reg_type_plain(env, reg->type));
 						return -EINVAL;
 					}
 				}
 
-				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i, argno);
+				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname,
+							       ref_id, meta, i, argno);
 				if (ret < 0)
 					return ret;
 				break;
@@ -12680,6 +12830,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (!__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
 				enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
+				const char *expected_type;
 
 				verbose(env, "%s is %s expected %s %s",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type),
@@ -12687,6 +12838,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				if (reg2btf_type != NOT_INIT)
 					verbose(env, " or %s", reg_type_str(env, reg2btf_type));
 				verbose(env, "\n");
+				expected_type = diag_btf_type_name(env, btf, ref_id);
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
+						  "the kfunc expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
+						  expected_type,
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12706,8 +12863,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					return -EINVAL;
 				}
 				ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
-				if (ret < 0)
+				if (ret < 0) {
+					const char *expected_type;
+
+					expected_type = diag_btf_type_name(env, btf, ref_id);
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
+							  "the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
+							  type_size, expected_type,
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return ret;
+				}
 			}
 			break;
 		case KF_ARG_CONST_MEM_SIZE:
@@ -12723,6 +12889,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar length for this memory argument.",
+						  "the kfunc expects a scalar memory size, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12732,9 +12903,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
 						 BPF_READ | BPF_WRITE, true, meta);
 			if (ret < 0) {
+				const char *buff_arg, *size_arg;
+
+				buff_arg = diag_arg_name(env, buff_argno);
+				size_arg = diag_arg_name(env, argno);
 				verbose(env, "%s and ", reg_arg_name(env, buff_argno));
 				verbose(env, "%s memory, len pair leads to invalid memory access\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, buff_argno, func_name,
+						  "Pass a stack, map, context, or other verifier-known memory pointer, and keep the paired length within that object.",
+						  "it is the memory pointer in a memory/length pair with %s, but %s does not describe verifier-readable memory for the requested length",
+						  size_arg, buff_arg);
 				return ret;
 			}
 			break;
@@ -12748,8 +12927,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
+				const char *expected_type;
+
+				expected_type = diag_btf_type_name(env, btf, ref_id);
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a pointer returned by the matching BPF object allocation or lookup operation for this kfunc.",
+						  "the kfunc expects a pointer to BPF-managed refcounted object type %s, but this argument is not such an object pointer",
+						  expected_type);
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
@@ -12774,6 +12960,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12814,6 +13005,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index 7918646e5bfc..d3be69a9a755 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -155,6 +155,7 @@ l0_%=:	r0 = 0;						\
 SEC("socket")
 __description("forgot null checking on the inner map pointer")
 __failure __msg("R1 type=map_ptr_or_null expected=map_ptr")
+__msg("map_ptr_or_null, but this argument accepts map_ptr")
 __failure_unpriv
 __naked void on_the_inner_map_pointer(void)
 {
-- 
2.53.0

