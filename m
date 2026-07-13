Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3241B357
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957167; cv=none; b=g343KHuX82P3FqB/OX+tpbJsOCcSESU5bKpNrekWiW4f2BkZRlxQyCOScHTrfKwmjeicgEmzIdxv9BmsfQG4Wz281SHA+nbjsS4bhu7wuGpXrKEbeteoYmBwKuqM6/mxa+KkVGtYB8hB6PhNnVSOc1LPGf5wOvAUylrUibY37fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957167; c=relaxed/simple;
	bh=O/hpZG2OIuGl5SmJ5x4tgPCuOZh4tyNiDq6WsfTeIqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9bs9SB1MV5wE1RG16WIofFpb6LFuY+DGvbqYA2cLPKsF5KiA9vaxBoZY+y4ieWsgkIMZhjkd4OVoVkIJ4foamOPXoD/eChk0c7SCO5WRD+WVrUd1CivVsTIiFWVGpMnZ7gwYIVKQGSp6SmOYZ4z1AcEOcZ9aSp0o6fW5dUb3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKNF43qR; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKNF43qR"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so1798369f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957163; x=1784561963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJN/Io6m6uk1SaEzN6x8sdaCoqCjZj9Uvs/AJ8GwiH4=;
        b=TKNF43qRQv6NTgohQc6XKywKvVMZw5x6mc7iQZVS0gVCiMEb6RqEgkcCEaqZmozlNu
         ea9RiNGqnloS+1lQ9xA8U80lmCpfEF9ZearSQux3A+xGoj1t2wGwBy4XnnhGvabMeW0q
         D1/195Scryy4Ctv4bKUjYtJEOV0U/2DBRPet9GOe5mMHO+T9XyOnvCnWtFQXqxGJLQzd
         lcOGQ7Iv4R2TCstFDIOPHR9ooq/kFYAV6bw2e5hoJ49Qcn6ZlI8b8jO1Og/aL0Now4Y4
         EQvyuDQNXEZ0/3NQy6UZ7MHkRNMcM/7K9Sdw1K46efBYXRu8LnOKd1xidiC2wFzd2QGD
         Nl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957163; x=1784561963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJN/Io6m6uk1SaEzN6x8sdaCoqCjZj9Uvs/AJ8GwiH4=;
        b=NED3PR7csrVZanWVG8kp0B2wRfMRAkcKxW0FvUZ4jgGU8al+rCS84AnODfj0rjkNhH
         jPmQiDF7yEb84+8uCimxwcNqyKiWF1CA4V8ZILuCEpOtEMEBt007A4pRUxhqOdu884HH
         dgKq5+Ybvsra4kXxOBmDoiER1W6lpb7Z0OyQmZ5GrBG9tvntxXRqpUtgvFEZw7TdvAFr
         4WCbVXGogIIruBxrXfQWCEqsgCkhZ2uIeVokhBo7SEOF1+2/9YcPjXBV1ayPyIn7cfW4
         BGBFI9K98/XAIYsQVxWSoqckcFUvwsZJYJJt+f2xzzepNFeEllnGY01TZay0WVZd2js0
         hT/w==
X-Gm-Message-State: AOJu0YyYGidcBGRsm6HFB1WBx7aFF3HWyJZ5TjpOceUm54p64lFYbxPC
	+2mLEJFLQlTGw3bDG9KTuwQiNl27oqQEb6jZw+08I5+dH0/aXIOZ/QXzueDwq89v
X-Gm-Gg: AfdE7cn03m2zXxwSdf2pTWucK1Tuz7cnX7Kn+E4k+xuhw1CE8/2W6CdEW9eASSlhQcZ
	hsVmRNB/9qmDN3EpS5B308355hFuELVv+WRoRmIOLEQGofW/aTp0g9nab4vKqqVh05HCfE9LS41
	QoCIfmMyQeWO8p/hFqIIct28VIaMW6edMOAYHyfK86lUVrryTmxqNIgxPUzbbHTxrJEtSVYB6Ae
	/ncg7dRycqDubofYArIhHQzCPbQ4ivwpdcR4lUZ2syjgZoyZai06FaroTbCXUod8J4NLGRYuJqA
	n6Xqji4nY1s4RW7cUSYuHNKYe4AjnYCpBtXZawSvi/LeRmp2QhK/GCoGCePQvE9nB7uxPNjs5cC
	O0gTKU0xP2lnrT7SjQIFvQUlB1OlvqOgByBqKe5lkyOcTIF0nlzd5NChraa62aUyXiLtAQhVj/0
	xT0HO6yRZZuwGD7RNvyaufkzj+6vnJ9zTbhRFSYl5DUo9zGQJrn3G7CEfuej6C+P4RaJd9/b47H
	uGK6H/t+Ugh6UPNTd+d7vCgJyuG9wIwTjKMq2GtCaw37gTx6O+dR16Yk1G5mdHnPA==
X-Received: by 2002:a05:600c:4f4c:b0:493:f868:d882 with SMTP id 5b1f17b1804b1-493f87e4a92mr97108785e9.14.1783957162674;
        Mon, 13 Jul 2026 08:39:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm8253985e9.7.2026.07.13.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/17] bpf: Report Register Type Safety errors
Date: Mon, 13 Jul 2026 17:38:57 +0200
Message-ID: <20260713153910.2556007-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26243; i=memxor@gmail.com; h=from:subject; bh=O/hpZG2OIuGl5SmJ5x4tgPCuOZh4tyNiDq6WsfTeIqg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURaHR5HhjRajMg9eFvg0bU4O69R2SZy/M37tf/7yKk ZhvrnFHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJpK1nOGvzPN0D/U8zxmx4RMm LrZ1yLLM+sGm1tzxNC+vVs+P0/w7w/+U56bnl4savzjpIMt17pfI0fLqhwx6R/OM7BQcZrHw1jI CAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected register-state verifier failures with Register Type Safety
reports. The existing verbose verifier messages remain in place; the new
reports add reason, source context, causal path, and suggestions.

Cover invalid pointer dereferences, unreadable registers, missing outgoing
stack arguments for bpf2bpf and kfunc calls, and rejected pointer arithmetic.
Use scoped diagnostic history so reports start from the latest relevant value
change and then show later branch outcomes.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 249 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  19 +++
 kernel/bpf/verifier.c    | 160 ++++++++++++++++++++++---
 3 files changed, 412 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index bd06974efd7b..0fa61882ee69 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -853,6 +853,255 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 	kfree(msg);
 }
 
+static u32 diag_current_frameno(const struct bpf_verifier_env *env)
+{
+	return env->cur_state->frame[env->cur_state->curframe]->frameno;
+}
+
+void bpf_diag_report_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *problem, const char *reason, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, CATEGORY_REGISTER_TYPE_SAFETY, problem);
+	diag_report_reason(env, "%s", reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type)
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
+		if (type_may_be_null(type))
+			return "a nullable kernel object pointer";
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
+static const char *diag_arg_ordinal(int argno)
+{
+	switch (argno) {
+	case 1:
+		return "first";
+	case 2:
+		return "second";
+	case 3:
+		return "third";
+	case 4:
+		return "fourth";
+	case 5:
+		return "fifth";
+	case 6:
+		return "sixth";
+	case 7:
+		return "seventh";
+	case 8:
+		return "eighth";
+	case 9:
+		return "ninth";
+	case 10:
+		return "tenth";
+	case 11:
+		return "eleventh";
+	case 12:
+		return "twelfth";
+	default:
+		return NULL;
+	}
+}
+
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *reg_name, const struct bpf_reg_state *reg,
+				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+	const char *type_name = bpf_diag_reg_type_plain(env, reg->type);
+
+	bpf_diag_report_header(env, CATEGORY_REGISTER_TYPE_SAFETY, "invalid dereference");
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_SCALAR:
+		diag_report_reason(env, "%s is an integer scalar here, not a pointer to memory.",
+				   reg_name);
+		break;
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		diag_report_reason(env,
+				   "%s may be NULL here (%s). The program could dereference NULL "
+				   "on this path, so the verifier cannot prove this access is "
+				   "safe.",
+				   reg_name, type_name);
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		diag_report_reason(env,
+				   "%s has offset %lld here, but this pointer type must be "
+				   "dereferenced in its original form.",
+				   reg_name, offset);
+		break;
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		diag_report_reason(env,
+				   "%s has type %s here, which is not valid for this memory "
+				   "access.",
+				   reg_name, type_name);
+		break;
+	}
+
+	diag_report_section(env, "At");
+	if (kind == BPF_DIAG_DEREF_MODIFIED_PTR)
+		bpf_diag_report_source(env, insn_idx, "error",
+				       "dereference requires the original %s pointer", type_name);
+	else
+		bpf_diag_report_source(env, insn_idx, "error", "invalid dereference of %s (%s)",
+				       reg_name, type_name);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		diag_report_suggestion(env, "Add a NULL check before the access and dereference "
+					    "the pointer only on the non-NULL path.");
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		diag_report_suggestion(env, "Preserve the original pointer in another register, or "
+					    "use only offsets this pointer type permits before "
+					    "dereferencing it.");
+		break;
+	case BPF_DIAG_DEREF_SCALAR:
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		diag_report_suggestion(env, "Preserve a pointer-valued register where needed, or "
+					    "reload and revalidate the pointer after scalar "
+					    "arithmetic, helper calls, or other operations that "
+					    "can invalidate it.");
+		break;
+	}
+}
+
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int regno)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, CATEGORY_REGISTER_TYPE_SAFETY, "unreadable register");
+	diag_report_reason(env,
+			   "R%d is not readable here. A previous operation may have invalidated "
+			   "this register, so the verifier cannot use it as an input.",
+			   regno);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "R%d is not readable", regno);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "Avoid using the register after it is invalidated, or reload "
+				    "and revalidate a fresh pointer before this instruction.");
+}
+
+static int diag_stack_argno(u8 slot)
+{
+	return MAX_BPF_FUNC_REG_ARGS + slot + 1;
+}
+
+static void diag_format_stack_arg(char *buf, size_t size, u8 slot, const char *arg_name)
+{
+	int argno = diag_stack_argno(slot);
+	const char *ordinal = diag_arg_ordinal(argno);
+
+	if (ordinal && arg_name)
+		scnprintf(buf, size, "outgoing stack argument %u (%s argument, %s)", slot + 1,
+			  ordinal, arg_name);
+	else if (ordinal)
+		scnprintf(buf, size, "outgoing stack argument %u (%s argument)", slot + 1, ordinal);
+	else if (arg_name)
+		scnprintf(buf, size, "outgoing stack argument %u (%s)", slot + 1, arg_name);
+	else
+		scnprintf(buf, size, "outgoing stack argument %u", slot + 1);
+}
+
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
+				      int stack_arg_slot, const char *callee_name,
+				      const char *arg_name)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+		.frameno = diag_current_frameno(env),
+		.stack_arg_slot = stack_arg_slot,
+	};
+	const char *arg_buf;
+
+	arg_buf = bpf_diag_scratch_buf(env, 1, NULL);
+	if (arg_buf)
+		diag_format_stack_arg((char *)arg_buf, BPF_DIAG_SCRATCH_STR_LEN, stack_arg_slot,
+				      arg_name);
+	else
+		arg_buf = "";
+	bpf_diag_report_header(env, CATEGORY_REGISTER_TYPE_SAFETY, "missing stack argument");
+	if (callee_name && *callee_name)
+		diag_report_reason(env,
+				   "Function %s expects %d arguments, but %s is not initialized at "
+				   "this call.",
+				   callee_name, nargs, arg_buf);
+	else
+		diag_report_reason(env,
+				   "The callee expects %d arguments, but %s is not initialized at "
+				   "this call.",
+				   nargs, arg_buf);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s is not initialized", arg_buf);
+
+	if (stack_arg_slot >= 0)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "Write the outgoing stack argument after any operation that "
+				    "may invalidate stored pointer values, and before making this "
+				    "call.");
+}
+
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
 {
 	struct bpf_diag_history_event event = {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 931d880b7eda..28bc234cfe56 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -4,6 +4,7 @@
 #ifndef __BPF_DIAGNOSTICS_H
 #define __BPF_DIAGNOSTICS_H
 
+#include <linux/bpf.h>
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
@@ -98,6 +99,14 @@ enum bpf_diag_context_event_kind {
 	BPF_DIAG_CONTEXT_EVENT_IRQ = BPF_DIAG_CONTEXT_IRQ,
 	BPF_DIAG_CONTEXT_EVENT_LOCK = BPF_DIAG_CONTEXT_LOCK,
 };
+
+enum bpf_diag_invalid_deref_kind {
+	BPF_DIAG_DEREF_SCALAR,
+	BPF_DIAG_DEREF_NULLABLE_PTR,
+	BPF_DIAG_DEREF_MODIFIED_PTR,
+	BPF_DIAG_DEREF_INVALID_PTR,
+};
+
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size);
@@ -108,6 +117,7 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int s
 				    const char *fmt, ...) __printf(3, 4);
 const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env, unsigned int slot,
 					     const struct btf *btf, u32 type_id);
+const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type);
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 int bpf_diag_error(const struct bpf_verifier_env *env);
@@ -117,6 +127,15 @@ void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
+void bpf_diag_report_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *problem, const char *reason, const char *suggestion);
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *reg_name, const struct bpf_reg_state *reg,
+				   enum bpf_diag_invalid_deref_kind kind, s64 offset);
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int regno);
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
+				      int stack_arg_slot, const char *callee_name,
+				      const char *arg_name);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cc4f1cc01c0..ca903e4e53ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3253,6 +3253,7 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
 			verbose(env, "R%d !read_ok\n", regno);
+			bpf_diag_report_unreadable_reg(env, env->insn_idx, regno);
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
@@ -4311,7 +4312,8 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
 }
 
 static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
-				     int nargs)
+				     int nargs, const char *callee_name, const struct btf *btf,
+				     const struct btf_param *args)
 {
 	int i, spi;
 
@@ -4319,8 +4321,14 @@ static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_fu
 		spi = i - MAX_BPF_FUNC_REG_ARGS;
 		if (spi >= caller->out_stack_arg_cnt ||
 		    caller->stack_arg_regs[spi].type == NOT_INIT) {
+			const char *arg_name = NULL;
+
+			if (args && args[i].name_off)
+				arg_name = btf_name_by_offset(btf, args[i].name_off);
 			verbose(env, "callee expects %d args, stack arg%d is not initialized\n",
 				nargs, spi + 1);
+			bpf_diag_report_stack_arg_uninit(env, env->insn_idx, nargs, spi,
+							 callee_name, arg_name);
 			return -EFAULT;
 		}
 	}
@@ -4475,6 +4483,9 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	if (!fixed_off_ok && reg->var_off.value != 0) {
 		verbose(env, "dereference of modified %s ptr %s off=%lld disallowed\n",
 			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.value);
+		bpf_diag_report_invalid_deref(env, env->insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno), reg,
+					      BPF_DIAG_DEREF_MODIFIED_PTR, reg->var_off.value);
 		return -EACCES;
 	}
 
@@ -6363,6 +6374,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 				reg_type_str(env, reg->type));
+			bpf_diag_report_invalid_deref(env, insn_idx, reg_from_argno(argno),
+						      reg_arg_name(env, argno), reg,
+						      BPF_DIAG_DEREF_NULLABLE_PTR, 0);
 			return -EACCES;
 		}
 
@@ -6519,8 +6533,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
+		enum bpf_diag_invalid_deref_kind kind = BPF_DIAG_DEREF_INVALID_PTR;
+
 		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
+		if (reg->type == SCALAR_VALUE)
+			kind = BPF_DIAG_DEREF_SCALAR;
+		else if (type_may_be_null(reg->type))
+			kind = BPF_DIAG_DEREF_NULLABLE_PTR;
+		bpf_diag_report_invalid_deref(env, insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno), reg, kind, 0);
 		return -EACCES;
 	}
 
@@ -9550,20 +9572,28 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
 	struct ref_obj_desc ref_obj = {};
+	const struct btf_param *args;
+	const struct btf_type *func, *func_proto;
 	u32 i;
 	int ret, err;
 
 	ret = btf_prepare_func_args(env, subprog);
 	if (ret) {
 		if (bpf_in_stack_arg_cnt(sub) > 0) {
-			err = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+			err = check_outgoing_stack_args(env, caller, sub->arg_cnt,
+							bpf_verifier_subprog_name(env, subprog),
+							NULL, NULL);
 			if (err)
 				return err;
 		}
 		return ret;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
+	func_proto = btf_type_by_id(btf, func->type);
+	args = btf_params(func_proto);
+	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt,
+					bpf_verifier_subprog_name(env, subprog), btf, args);
 	if (ret)
 		return ret;
 
@@ -12372,7 +12402,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		return -ENOTSUPP;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, nargs);
+	ret = check_outgoing_stack_args(env, caller, nargs, func_name, btf, args);
 	if (ret)
 		return ret;
 
@@ -14103,9 +14133,8 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  * If we return -EACCES, caller may want to try again treating pointer as a
  * scalar.  So we only emit a diagnostic if !env->allow_ptr_leaks.
  */
-static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
-				   struct bpf_insn *insn,
-				   const struct bpf_reg_state *ptr_reg,
+static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				   u32 ptr_regno, const struct bpf_reg_state *ptr_reg,
 				   const struct bpf_reg_state *off_reg)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -14117,6 +14146,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	const char *reason;
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
@@ -14140,12 +14170,31 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env,
 			"R%d 32-bit pointer arithmetic prohibited\n",
 			dst);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. 32-bit ALU operations on pointers "
+						 "discard pointer tracking, so the verifier cannot "
+						 "keep the result as a safe pointer.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "32-bit pointer arithmetic", reason,
+					      "Use a 64-bit ALU instruction with an allowed, "
+					      "bounded scalar offset.");
 		return -EACCES;
 	}
 
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d may be NULL (%s). Pointer arithmetic is "
+						 "allowed only after the program proves the "
+						 "pointer is non-NULL on this path.",
+						 ptr_regno, reg_type_str(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer arithmetic before NULL check", reason,
+					      "Make sure that a NULL check precedes any arithmetic "
+					      "performed on the pointer.");
 		return -EACCES;
 	}
 
@@ -14182,6 +14231,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	default:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_scratch_printf(
+			env, 0, "R%d holds %s. This pointer kind does not allow offset arithmetic.",
+			ptr_regno, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer arithmetic is not allowed", reason,
+					      "Do not change this pointer's offset; use it only in "
+					      "operations accepted for its kind.");
 		return -EACCES;
 	}
 
@@ -14191,9 +14247,30 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	dst_reg->type = ptr_reg->type;
 	dst_reg->id = ptr_reg->id;
 
-	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
-	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "The scalar offset used with R%d is unbounded or "
+						 "outside the verifier's safe pointer-offset range "
+						 "[-%u, %u].",
+						 ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe", reason,
+					      "Clamp or bounds-check the scalar offset before "
+					      "applying it to the pointer.");
 		return -EINVAL;
+	}
+	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d already has an offset outside the verifier's "
+						 "safe range [-%u, %u] for %s.",
+						 ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe", reason,
+					      "Keep the base pointer within the verifier's allowed "
+					      "offset range before applying more arithmetic.");
+		return -EINVAL;
+	}
 
 	/* pointer types do not carry 32-bit bounds at the moment. */
 	__mark_reg32_unbounded(dst_reg);
@@ -14236,6 +14313,17 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
+			reason = bpf_diag_scratch_printf(env, 0,
+							 "This operation subtracts pointer "
+							 "register R%d from scalar register R%d. "
+							 "The verifier only tracks "
+							 "pointer-minus-scalar arithmetic for "
+							 "allowed pointer types.",
+							 ptr_regno, dst);
+			bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+						      "pointer subtracted from scalar", reason,
+						      "Keep the pointer as the base; only add or "
+						      "subtract bounded scalars when permitted.");
 			return -EACCES;
 		}
 		/* We don't allow subtraction from FP, because (according to
@@ -14245,6 +14333,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		if (ptr_reg->type == PTR_TO_STACK) {
 			verbose(env, "R%d subtraction from stack pointer prohibited\n",
 				dst);
+			reason = bpf_diag_scratch_printf(env, 0,
+							 "R%d is a stack pointer. The verifier "
+							 "does not allow BPF_SUB to move stack "
+							 "pointers.",
+							 ptr_regno);
+			bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+						      "subtraction from stack pointer", reason,
+						      "Use addition from R10 to form stack "
+						      "addresses within the tracked stack frame.");
 			return -EACCES;
 		}
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
@@ -14270,16 +14367,49 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* bitwise ops on pointers are troublesome, prohibit. */
 		verbose(env, "R%d bitwise operator %s on pointer prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. Bitwise operator %s would destroy "
+						 "the pointer value the verifier is tracking.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type),
+						 bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "bitwise operation on pointer", reason,
+					      "Do bitwise operations on scalar values, not on "
+					      "pointer-valued registers.");
 		return -EACCES;
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		verbose(env, "R%d pointer arithmetic with %s operator prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. Operator %s is not one of the "
+						 "limited pointer arithmetic operations the "
+						 "verifier can track.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type),
+						 bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "invalid pointer arithmetic operator", reason,
+					      "Use only verifier-supported addition or subtraction "
+					      "with a bounded scalar offset, or perform this "
+					      "operation on a scalar value.");
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "After this arithmetic, R%d would be outside the "
+						 "verifier's safe offset range [-%u, %u] for %s.",
+						 dst, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe", reason,
+					      "Tighten the scalar bounds before the arithmetic so "
+					      "the resulting pointer remains within the allowed "
+					      "range.");
 		return -EINVAL;
+	}
 	reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
@@ -15250,16 +15380,15 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				err = mark_chain_precision(env, insn->dst_reg);
 				if (err)
 					return err;
-				return adjust_ptr_min_max_vals(env, insn,
-							       src_reg, dst_reg);
+				return adjust_ptr_min_max_vals(env, insn, insn->src_reg, src_reg,
+							       dst_reg);
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
 			err = mark_chain_precision(env, insn->src_reg);
 			if (err)
 				return err;
-			return adjust_ptr_min_max_vals(env, insn,
-						       dst_reg, src_reg);
+			return adjust_ptr_min_max_vals(env, insn, insn->dst_reg, dst_reg, src_reg);
 		} else if (dst_reg->precise) {
 			/* if dst_reg is precise, src_reg should be precise as well */
 			err = mark_chain_precision(env, insn->src_reg);
@@ -15274,8 +15403,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		__mark_reg_known(&off_reg, insn->imm);
 		src_reg = &off_reg;
 		if (ptr_reg) /* pointer += K */
-			return adjust_ptr_min_max_vals(env, insn,
-						       ptr_reg, src_reg);
+			return adjust_ptr_min_max_vals(env, insn, insn->dst_reg, ptr_reg, src_reg);
 	}
 
 	/* Got here implies adding two SCALAR_VALUEs */
-- 
2.53.0

