Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16142DFE6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577628; cv=none; b=hU4ogVrNIw82r7hZ3LjqictPQkufj/RRjAL9/sjDP2SOOPSqvhusU43ZNU6X9THBEBXjpt1qm4DAwdb8T9/ZGIXHCPgURihlv0QmcZxAHql8pM48JFvPtGi39Sf0drpIccFiLPwIZPD1Ekv/Uzc6mA4hZ6KxFvspO05GD4rxE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577628; c=relaxed/simple;
	bh=5CFnANAWJYP0zSLbd0hNW00Qp7lyTt8J8RpKLoWJOvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIOHBawN3BodUpuGfe3J+yfZam/etvbN4E1NZwJrYZEhfG8bp4MQxHqOU6DM2RGoJDA2Y+VlJ3BYYdb2vsw0jge/Dd/NgsxdIsi9kGO14+T7UfF2wVBdjyuvGpqOqy3MvHpyF5M0LuWp1SfMHG8Mnj5v5ArbqMjehICETKxU2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6nbJk7H; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6nbJk7H"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-481512c85ffso594008f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577623; x=1787182423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jiqsdgYv6GQ7l7RMMWCPNDzMlNvKdGCS6yRD1r8CG/g=;
        b=N6nbJk7Hp+PeMVUVD/PyUZ7YYkzqJk9oe+aBDuzDMjLY/xKIkg8+Wv6hQA+kxhE+kV
         b78YyelT1QrwOch79pnlfbdg48M2/2QdKvJfZ0KtK2JieXtiJnd4vhLqwhV9TF+KGWVT
         wxew8BgGFGp1sgVe/dE1mpbKXAFo3xTQzzd6cx2CE1Z2BOfvGjZc9PC6rYiPCdah7KZI
         kG1d8nh3KsvHeGOuvY36JjSQW04BqankfPz3gKz9j6bJG940LVoYf2CVKvFUKzH6H7Zg
         2BwRxPzJ3i1iga8wW4i5QF4jeLtO3e3hyvLLJP7oR6Und1R4WkaGF/GWoVk3X60AETC0
         kAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577623; x=1787182423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jiqsdgYv6GQ7l7RMMWCPNDzMlNvKdGCS6yRD1r8CG/g=;
        b=cvz1RtabKV7lkSnp4hhpMFRGE0q/DHuor2F7b1zh8RxK1V9nhLwRh+fBwaiB24co68
         agxlpnbC3nRTwzzNQ3pOGRtpP7pZ9mKiNqRBm4/HDtq2V/U0ELBmCs/9a0O9S1mjiHuK
         l0aBjDi23w0iwKGb4avkWEo3xdemCu+3a2PIuToZY6w3wx4XwGZnuKXLp5bVm0UROJ8T
         fZuKyhtZ18uSqH3d/GYJyCUfyobWwMHUYDwoeUqHSDzA6iae5y7eB1x7ZYGKZaAh0/EK
         BTbZAhcwssqeq8Pdp9SI5fFB3izWvBXFKgGxOJgqgdIKpsRN6v/vVnKW4hMqE8/Kff3O
         1j+g==
X-Gm-Message-State: AOJu0YziV3HMzZqEG8q370ZR4/NHgX6NO+iZdMNjyNAebDtqGzIEE1dI
	zT1SpFs1LxotVOyg+rJ5r2DOfS1PIgsxfVlqIsV8uBLFtPLhJR5oT/oP2EspJJql
X-Gm-Gg: AR+sD12BGXhJc+Q4WfR1cdoMFkEoRCVE7B6QHd5eVt9LH3EKHFUcw+SZ9lgGRN6lSjL
	nonoZA/Tddsw8eaVe3305zZwCPV7vEHC70yQdld1ssaon9JLuD1EKJbXzUxFmluljkaPYPRVzZu
	pRFynu/n2YfKpNIuIaTHdhWHX5vhraMYiSAbdRQmha0Or3GCpcYES2MQYcg7bQvk5xuBfGr1JOq
	uTmj1nvxZGgcL+PdL850+nlze2wAJllFlUaYRQPaz5nSlxUOpIvvEVmg+8WuO5ff389Akh3o7Ur
	fu6aXQleuD44prWbJQPYuRrjW2QoGuEz9N2Qby5uJkEf3aBN52gNHFlZtOEpyNvAHkd0spIrsGM
	YQqjixqwZ/9Swz8bbIXu6+AeHGWaczFrEbLymZxNGyXdY7ptxNCi8RdbRJGmW4QLoXBFxYXBAOv
	jfrIkfU1biGUg3eLMOy5dLRcfbHzFHxrf88X39KY8llGFYBdKn17FWzBcd7ErUPZX2F8LUxNQFs
	xolNBelFxVCYCT48OAWssffUZXaafg0TdgZw9FkAtq+uk2BNgByWFQjUBTfAUxCiV0q8gwLxnHW
	fT6l0MbT11Ms1+YWULNewSchGow=
X-Received: by 2002:a05:6000:61a:b0:47f:e4e3:d85f with SMTP id ffacd0b85a97d-48159eea04bmr2161566f8f.17.1786577622671;
        Wed, 12 Aug 2026 16:33:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2769sm1199783f8f.36.2026.08.12.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 08/16] bpf: Report Register Type Safety errors
Date: Thu, 13 Aug 2026 01:33:11 +0200
Message-ID: <20260812233326.3575958-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=47058; i=memxor@gmail.com; h=from:subject; bh=5CFnANAWJYP0zSLbd0hNW00Qp7lyTt8J8RpKLoWJOvI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQZt1ttfGgOeaX1YtLi2PNje6wOuvyG28SMj9V1ve8 2XaXjEdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjeSIb/zg2rzvdYiLJZMF2w fZX8V+HElN0ThJWXGq6OrfISk56mz/DP8G/i5VaXjOyaKBuexCfrb1xfuPLWd7PfzJzfzj4/I5L GCwA=
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
 kernel/bpf/diagnostics.c                      | 898 ++++++++++++++++++
 kernel/bpf/diagnostics.h                      |  18 +
 kernel/bpf/verifier.c                         | 128 ++-
 .../selftests/bpf/progs/verifier_uninit.c     |   1 +
 4 files changed, 1030 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 823e0a7a0638..53529475b0ec 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
 
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
@@ -25,6 +26,7 @@
 #define VERIFIER_LIMIT "Verifier Limit"
 
 #define BPF_DIAG_TEXT_WIDTH 100
+#define BPF_DIAG_TEXT_INDENT "  "
 #define BPF_DIAG_MSG_LEN 512
 #define BPF_DIAG_CONTEXT 2
 #define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
@@ -78,6 +80,28 @@ struct bpf_diag_history_event {
 	};
 };
 
+enum bpf_diag_history_scope {
+	BPF_DIAG_HISTORY_SCOPE_ALL,
+	BPF_DIAG_HISTORY_SCOPE_REG,
+	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+	BPF_DIAG_HISTORY_SCOPE_REF,
+	BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+};
+
+struct bpf_diag_history_opts {
+	enum bpf_diag_history_scope scope;
+	u32 frameno;
+	int regno;
+	int stack_arg_slot;
+	u32 ref_id;
+	enum bpf_diag_context_kind ctx_kind;
+	u32 ctx_depth;
+};
+
+static void diag_print_history(struct bpf_verifier_env *env,
+			       const struct bpf_diag_history_opts *opts);
+static bool diag_target_matches(const struct bpf_diag_mod_target *event_target,
+				const struct bpf_diag_mod_target *target);
 struct disasm_line {
 	char text[DISASM_LINE_LEN];
 	int idx;
@@ -390,6 +414,12 @@ static void diag_append_history(struct bpf_verifier_env *env,
 	log->events[log->cnt++] = *event;
 }
 
+static const struct bpf_diag_history_event *diag_history_event(const struct bpf_diag_log *log,
+							u32 idx)
+{
+	return &log->events[idx];
+}
+
 static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
 					const char *next_prefix, const char *text)
 {
@@ -425,6 +455,11 @@ static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char
 	}
 }
 
+static void diag_print_wrapped_text(struct bpf_verifier_env *env, const char *text)
+{
+	diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT, BPF_DIAG_TEXT_INDENT, text);
+}
+
 static void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id)
 {
 	size_t len;
@@ -453,6 +488,26 @@ const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf
 	return buf;
 }
 
+static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
+	__printf(2, 0);
+
+static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
+{
+	char *buf;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
+	if (!buf) {
+		diag_write(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
+		return;
+	}
+
+	diag_print_wrapped_text(env, buf);
+	kfree(buf);
+}
+
 static int diag_line_width(unsigned int line)
 {
 	int width = 1;
@@ -613,6 +668,47 @@ void bpf_diag_header(struct bpf_verifier_env *env, const char *category, const c
 	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
 }
 
+static void diag_reason(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+static void diag_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+	__printf(2, 3);
+
+static void diag_section(struct bpf_verifier_env *env, const char *title)
+{
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_write(env, "\n%s:\n", title);
+}
+
+static void diag_reason(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_section(env, "Reason");
+
+	va_start(args, fmt);
+	diag_vprint_indented(env, fmt, args);
+	va_end(args);
+}
+
+static void diag_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	diag_section(env, "Suggestion");
+
+	va_start(args, fmt);
+	diag_vprint_indented(env, fmt, args);
+	va_end(args);
+	diag_write(env, "\n");
+}
+
 static void diag_print_source_annotation(struct bpf_verifier_env *env, int line_width, int indent,
 					 const char *label, const char *msg)
 {
@@ -738,6 +834,277 @@ void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *lab
 	diag_fmt_restore(env, mark);
 }
 
+static u32 diag_current_frameno(const struct bpf_verifier_env *env)
+{
+	return env->cur_state->frame[env->cur_state->curframe]->frameno;
+}
+
+void bpf_diag_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *problem, const char *reason, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_header(env, REGISTER_TYPE_SAFETY, problem);
+	diag_reason(env, "%s", reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s", problem);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
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
+void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
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
+	bpf_diag_header(env, REGISTER_TYPE_SAFETY, "invalid dereference");
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_SCALAR:
+		diag_reason(env, "%s is an integer scalar here, not a pointer to memory.",
+				   reg_name);
+		break;
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		diag_reason(
+			env, "%s may be NULL here (%s). The program could dereference NULL on this path, so the verifier cannot prove this access is safe.",
+			reg_name, type_name);
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		diag_reason(
+			env, "%s has offset %lld here, but this pointer type must be dereferenced in its original form.",
+			reg_name, offset);
+		break;
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		diag_reason(
+			env, "%s has type %s here, which is not valid for this memory access.",
+			reg_name, type_name);
+		break;
+	}
+
+	diag_section(env, "At");
+	if (kind == BPF_DIAG_DEREF_MODIFIED_PTR)
+		bpf_diag_source(env, insn_idx, "error",
+				       "dereference requires the original %s pointer", type_name);
+	else
+		bpf_diag_source(env, insn_idx, "error", "invalid dereference of %s (%s)",
+				       reg_name, type_name);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		diag_suggestion(
+			env, "Add a NULL check before the access and dereference the pointer only on the non-NULL path.");
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		diag_suggestion(
+			env, "Preserve the original pointer in another register, or use only offsets this pointer type permits before dereferencing it.");
+		break;
+	case BPF_DIAG_DEREF_SCALAR:
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		diag_suggestion(
+			env, "Preserve a pointer-valued register where needed, or reload and revalidate the pointer after scalar arithmetic, helper calls, or other operations that can invalidate it.");
+		break;
+	}
+}
+
+void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int regno)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = diag_current_frameno(env),
+		.regno = regno,
+	};
+	const struct bpf_diag_log *log = diag_event_log(env);
+	struct bpf_diag_mod_target target;
+	bool invalidated = false;
+	int i;
+
+	target = bpf_diag_reg_target(opts.frameno, regno);
+	for (i = log ? log->cnt : 0; i > 0; i--) {
+		const struct bpf_diag_history_event *event = diag_history_event(log, i - 1);
+
+		if (event->kind != BPF_DIAG_HISTORY_MOD ||
+		    !diag_target_matches(&event->mod.target, &target))
+			continue;
+		invalidated = event->mod.new.type == NOT_INIT;
+		break;
+	}
+
+	bpf_diag_header(env, REGISTER_TYPE_SAFETY, "unreadable register");
+	if (invalidated)
+		diag_reason(
+			env, "R%d is not readable here. A previous operation invalidated this register, so the verifier cannot use it as an input.",
+			regno);
+	else if (log && !log->dropped)
+		diag_reason(env,
+			    "R%d has never been initialized on this path, so the verifier cannot use it as an input.",
+			    regno);
+	else
+		diag_reason(
+			env, "R%d is not readable here. It may never have been initialized, or an earlier operation may have invalidated it.",
+			regno);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "R%d is not readable", regno);
+
+	if (regno >= 0)
+		diag_print_history(env, &opts);
+
+	if (invalidated)
+		diag_suggestion(
+			env, "Avoid using the register after it is invalidated, or initialize it again before this instruction.");
+	else if (log && !log->dropped)
+		diag_suggestion(env, "Initialize R%d on every path before this instruction.", regno);
+	else
+		diag_suggestion(
+			env, "Initialize the register on every path, or initialize it again after any operation that invalidates it.");
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
+void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
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
+	arg_buf = bpf_diag_fmt_buf(env, BPF_DIAG_FMT_BUF_SIZE);
+	if (arg_buf)
+		diag_format_stack_arg((char *)arg_buf, BPF_DIAG_FMT_BUF_SIZE, stack_arg_slot,
+				      arg_name);
+	else
+		arg_buf = "";
+	bpf_diag_header(env, REGISTER_TYPE_SAFETY, "missing stack argument");
+	if (callee_name && *callee_name)
+		diag_reason(env,
+				   "Function %s expects %d arguments, but %s is not initialized at "
+				   "this call.",
+				   callee_name, nargs, arg_buf);
+	else
+		diag_reason(env,
+				   "The callee expects %d arguments, but %s is not initialized at "
+				   "this call.",
+				   nargs, arg_buf);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s is not initialized", arg_buf);
+
+	if (stack_arg_slot >= 0)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "Write the outgoing stack argument after any operation that "
+				    "may invalidate stored pointer values, and before making this "
+				    "call.");
+}
+
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
 {
 	struct bpf_diag_history_event event = {
@@ -1006,3 +1373,534 @@ void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
 
 	diag_append_history(env, &event);
 }
+
+static int diag_history_context_start_idx(const struct bpf_diag_log *log,
+					  const struct bpf_diag_history_opts *opts)
+{
+	int i;
+
+	if (!opts->ctx_depth)
+		return 0;
+
+	/* Find the most recent outermost entry, or a depth-zero exit. */
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = diag_history_event(log, i - 1);
+
+		if (event->kind != BPF_DIAG_HISTORY_CONTEXT || event->ctx.kind != opts->ctx_kind)
+			continue;
+
+		if (event->ctx.enter && event->ctx.depth == 1)
+			return i - 1;
+		if (!event->ctx.enter && event->ctx.depth == 0)
+			return 0;
+	}
+
+	return 0;
+}
+
+struct bpf_diag_history_filter {
+	const struct bpf_diag_history_opts *opts;
+	u32 lineage_start;
+	bool lineage_valid;
+};
+
+static bool diag_target_matches(const struct bpf_diag_mod_target *event_target,
+				const struct bpf_diag_mod_target *target)
+{
+	int slot_off;
+
+	if (event_target->frameno != target->frameno)
+		return false;
+
+	if (event_target->kind == BPF_DIAG_MOD_TARGET_STACK_RANGE &&
+	    target->kind == BPF_DIAG_MOD_TARGET_STACK_SLOT) {
+		slot_off = -(target->spi + 1) * BPF_REG_SIZE;
+		return event_target->range.min_off < slot_off + BPF_REG_SIZE &&
+		       event_target->range.max_off > slot_off;
+	}
+
+	if (event_target->kind != target->kind)
+		return false;
+
+	switch (target->kind) {
+	case BPF_DIAG_MOD_TARGET_REG:
+		return event_target->regno == target->regno;
+	case BPF_DIAG_MOD_TARGET_STACK_ARG:
+		return event_target->stack_arg == target->stack_arg;
+	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
+		return event_target->spi == target->spi;
+	default:
+		return false;
+	}
+}
+
+static bool diag_mod_keeps_lineage(struct bpf_verifier_env *env,
+				   const struct bpf_diag_history_event *event)
+{
+	const struct bpf_insn *insn;
+	u8 class;
+
+	if (event->mod.reason != BPF_DIAG_MOD_WRITE ||
+	    event->mod.target.kind != BPF_DIAG_MOD_TARGET_REG)
+		return false;
+
+	insn = &env->prog->insnsi[event->insn_idx];
+	class = BPF_CLASS(insn->code);
+	if (class != BPF_ALU && class != BPF_ALU64)
+		return false;
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_MUL:
+	case BPF_OR:
+	case BPF_AND:
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+	case BPF_XOR:
+	case BPF_NEG:
+	case BPF_END:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void diag_build_lineage(struct bpf_verifier_env *env, struct bpf_diag_log *log,
+			       struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+	struct bpf_diag_mod_target target;
+	int i;
+
+	for (i = 0; i < log->cnt; i++)
+		log->events[i].in_lineage = false;
+
+	if (!opts)
+		return;
+
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_REG)
+		target = bpf_diag_reg_target(opts->frameno, opts->regno);
+	else if (opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG)
+		target = bpf_diag_stack_arg_target(opts->frameno, opts->stack_arg_slot);
+	else
+		return;
+
+	/*
+	 * Find the nearest mutation of the active target. A fill or spill changes
+	 * the target to its origin, so the same walk follows register/stack
+	 * lineage recursively until it reaches the write that created the value.
+	 */
+	for (i = log->cnt; i > 0; i--) {
+		struct bpf_diag_history_event *event;
+
+		event = &log->events[i - 1];
+		if (event->kind != BPF_DIAG_HISTORY_MOD ||
+		    !diag_target_matches(&event->mod.target, &target))
+			continue;
+
+		event->in_lineage = true;
+		filter->lineage_start = i - 1;
+		filter->lineage_valid = true;
+
+		if (event->mod.origin_valid) {
+			target = event->mod.origin;
+			continue;
+		}
+		if (event->mod.reason != BPF_DIAG_MOD_WRITE &&
+		    event->mod.reason != BPF_DIAG_MOD_SPILL)
+			continue;
+		if (diag_mod_keeps_lineage(env, event))
+			continue;
+		break;
+	}
+
+}
+
+static int diag_history_start_idx(const struct bpf_diag_log *log,
+				  const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+	int i;
+
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return 0;
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT)
+		return diag_history_context_start_idx(log, opts);
+	if (filter->lineage_valid)
+		return filter->lineage_start;
+	if (opts->scope != BPF_DIAG_HISTORY_SCOPE_REF)
+		return 0;
+
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = diag_history_event(log, i - 1);
+		if (event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
+		    event->ref.ref_id == opts->ref_id)
+			return i - 1;
+	}
+
+	return 0;
+}
+
+static bool diag_history_event_visible(const struct bpf_diag_history_event *event,
+				       const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return event->kind != BPF_DIAG_HISTORY_CONTEXT;
+
+	switch (event->kind) {
+	case BPF_DIAG_HISTORY_BRANCH:
+		return true;
+	case BPF_DIAG_HISTORY_MOD:
+		return filter->lineage_valid && event->in_lineage;
+	case BPF_DIAG_HISTORY_REF_ACQUIRE:
+	case BPF_DIAG_HISTORY_REF_RELEASE:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		       event->ref.ref_id == opts->ref_id;
+	case BPF_DIAG_HISTORY_CONTEXT:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
+		       event->ctx.kind == opts->ctx_kind;
+	default:
+		return false;
+	}
+}
+
+static const char *diag_s64_bound_name(s64 value)
+{
+	if (value == S64_MIN)
+		return "S64_MIN";
+	if (value == S64_MAX)
+		return "S64_MAX";
+	return NULL;
+}
+
+static const char *diag_u64_bound_name(u64 value)
+{
+	if (value == U64_MAX)
+		return "U64_MAX";
+	return NULL;
+}
+
+static const char *diag_s64_str(struct bpf_verifier_env *env, s64 value)
+{
+	return diag_s64_bound_name(value) ?: bpf_diag_fmt(env, "%lld", value);
+}
+
+static const char *diag_u64_str(struct bpf_verifier_env *env, u64 value)
+{
+	return diag_u64_bound_name(value) ?: bpf_diag_fmt(env, "%llu", value);
+}
+
+static bool diag_range_unknown(s64 smin, s64 smax, u64 umin, u64 umax)
+{
+	return smin == S64_MIN && smax == S64_MAX && umin == 0 && umax == U64_MAX;
+}
+
+static bool diag_cnum64_unknown(struct cnum64 range)
+{
+	return diag_range_unknown(cnum64_smin(range), cnum64_smax(range), cnum64_umin(range),
+				  cnum64_umax(range));
+}
+
+static bool diag_snapshot_unknown(const struct bpf_diag_reg_snapshot *snapshot)
+{
+	return tnum_is_unknown(snapshot->var_off) && diag_cnum64_unknown(snapshot->r64);
+}
+
+static const char *diag_scalar_range(struct bpf_verifier_env *env, struct cnum64 range)
+{
+	return bpf_diag_fmt(env, "signed range [%s, %s], unsigned range [%s, %s]",
+			    diag_s64_str(env, cnum64_smin(range)),
+			    diag_s64_str(env, cnum64_smax(range)),
+			    diag_u64_str(env, cnum64_umin(range)),
+			    diag_u64_str(env, cnum64_umax(range)));
+}
+
+static const char *diag_var_offset(struct bpf_verifier_env *env,
+				   const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (tnum_is_const(snapshot->var_off))
+		return bpf_diag_fmt(env, "at offset %lld", (s64)snapshot->var_off.value);
+
+	if (diag_snapshot_unknown(snapshot))
+		return bpf_diag_fmt(env, "with unknown offset");
+
+	return bpf_diag_fmt(env,
+			    "with variable offset: known bits %#llx, unknown mask %#llx, %s",
+			    snapshot->var_off.value, snapshot->var_off.mask,
+			    diag_scalar_range(env, snapshot->r64));
+}
+
+static const char *diag_snapshot_btf_type(struct bpf_verifier_env *env,
+					  const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (!snapshot->btf || !snapshot->btf_id)
+		return NULL;
+
+	return bpf_diag_fmt_btf_type(env, snapshot->btf, snapshot->btf_id);
+}
+
+static const char *diag_reg_map_name(const struct bpf_map *map)
+{
+	if (!map || !map->name[0])
+		return NULL;
+
+	return map->name;
+}
+
+static const char *diag_reg_snapshot(struct bpf_verifier_env *env,
+				     const struct bpf_diag_reg_snapshot *snapshot)
+{
+	const char *type_name = reg_type_str(env, snapshot->type);
+	const char *offset = diag_var_offset(env, snapshot);
+	const char *btf = diag_snapshot_btf_type(env, snapshot);
+	const char *map_name;
+
+	if (snapshot->type == SCALAR_VALUE) {
+		if (tnum_is_const(snapshot->var_off))
+			return bpf_diag_fmt(env, "integer scalar value %lld",
+					    (s64)snapshot->var_off.value);
+		if (diag_snapshot_unknown(snapshot))
+			return bpf_diag_fmt(env, "integer scalar with unknown value");
+		if (cnum64_is_const(snapshot->r64))
+			return bpf_diag_fmt(env, "integer scalar value %lld",
+					    cnum64_smin(snapshot->r64));
+		return bpf_diag_fmt(env, "integer scalar with %s",
+				    diag_scalar_range(env, snapshot->r64));
+	}
+
+	if (snapshot->type == NOT_INIT)
+		return bpf_diag_fmt(env, "uninitialized value");
+
+	if (base_type(snapshot->type) == PTR_TO_CTX)
+		return bpf_diag_fmt(env, "context pointer %s", offset);
+
+	if (base_type(snapshot->type) == PTR_TO_STACK)
+		return bpf_diag_fmt(env, "stack pointer %s", offset);
+
+	if (base_type(snapshot->type) == PTR_TO_MAP_VALUE) {
+		const char *kind = type_may_be_null(snapshot->type) ? "nullable map value" :
+								      "map value";
+
+		map_name = diag_reg_map_name(snapshot->map_ptr);
+		if (map_name)
+			return bpf_diag_fmt(env, "%s from %s %s", kind, map_name, offset);
+		return bpf_diag_fmt(env, "%s %s", kind, offset);
+	}
+
+	if (base_type(snapshot->type) == CONST_PTR_TO_MAP) {
+		map_name = diag_reg_map_name(snapshot->map_ptr);
+		if (map_name)
+			return bpf_diag_fmt(env, "map pointer for map %s", map_name);
+		return bpf_diag_fmt(env, "map pointer");
+	}
+
+	if (type_is_non_owning_ref(snapshot->type)) {
+		if (btf)
+			return bpf_diag_fmt(env, "borrowed allocated object pointer type=%s", btf);
+		return bpf_diag_fmt(env, "borrowed allocated object pointer");
+	}
+
+	if (type_is_ptr_alloc_obj(snapshot->type)) {
+		if (btf)
+			return bpf_diag_fmt(env, "owned allocated object pointer type=%s", btf);
+		return bpf_diag_fmt(env, "owned allocated object pointer");
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_BTF_ID && btf)
+		return bpf_diag_fmt(env, "%s type=%s %s", type_name, btf, offset);
+
+	return bpf_diag_fmt(env, "%s %s", type_name, offset);
+}
+
+static const char *diag_mod_target_desc(struct bpf_verifier_env *env,
+					const struct bpf_diag_mod_target *target)
+{
+	switch (target->kind) {
+	case BPF_DIAG_MOD_TARGET_REG:
+		return bpf_diag_fmt(env, "R%u", target->regno);
+	case BPF_DIAG_MOD_TARGET_STACK_ARG:
+		return bpf_diag_fmt(env, "stack arg%d", diag_stack_argno(target->stack_arg));
+	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
+		return bpf_diag_fmt(env, "stack slot fp%d", -(target->spi + 1) * BPF_REG_SIZE);
+	default:
+		return "value";
+	}
+}
+
+static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_history_event *event)
+{
+	const struct bpf_diag_mod_target *target = &event->mod.target;
+	const char *target_desc, *reason = NULL, *old, *new;
+	const char *label = "update";
+
+	if (target->kind == BPF_DIAG_MOD_TARGET_STACK_RANGE) {
+		bpf_diag_source(
+			env, event->insn_idx, "invalidated",
+			"variable-offset stack write may affect bytes fp%d through fp%d",
+			target->range.min_off, target->range.max_off - 1);
+		return;
+	}
+
+	old = diag_reg_snapshot(env, &event->mod.old);
+	new = diag_reg_snapshot(env, &event->mod.new);
+	target_desc = diag_mod_target_desc(env, target);
+
+	switch (event->mod.reason) {
+	case BPF_DIAG_MOD_REF_RELEASE:
+		reason = target->kind == BPF_DIAG_MOD_TARGET_REG ? "resource release invalidated "
+								   "this pointer" :
+								   "resource release invalidated "
+								   "this value";
+		break;
+	case BPF_DIAG_MOD_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_MOD_NON_OWN_REF:
+		reason = "leaving the protected region invalidated this borrowed pointer";
+		break;
+	case BPF_DIAG_MOD_CALLER_SAVED:
+		reason = "call invalidated this caller-saved register";
+		break;
+	case BPF_DIAG_MOD_WRITE:
+		if (target->kind == BPF_DIAG_MOD_TARGET_STACK_SLOT)
+			reason = "a later stack write overwrote this spilled value";
+		break;
+	case BPF_DIAG_MOD_SPILL:
+		label = "spilled";
+		break;
+	case BPF_DIAG_MOD_VAR_WRITE:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_source(env, event->insn_idx, "invalidated",
+				       "%s: %s; previous value was %s", target_desc, reason, old);
+		return;
+	}
+
+	bpf_diag_source(env, event->insn_idx, label, "%s changed from %s to %s", target_desc,
+			       old, new);
+}
+
+static void diag_print_ref_event(struct bpf_verifier_env *env,
+				 const struct bpf_diag_history_event *event)
+{
+	const char *label;
+
+	label = event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE ? "acquired" : "released";
+	bpf_diag_source(env, event->insn_idx, label, "owned resource (id=%u)",
+			       event->ref.ref_id);
+}
+
+static const char *diag_context_name(enum bpf_diag_context_kind kind)
+{
+	switch (kind) {
+	case BPF_DIAG_CONTEXT_RCU:
+		return "RCU read lock region";
+	case BPF_DIAG_CONTEXT_PREEMPT:
+		return "non-preemptible region";
+	case BPF_DIAG_CONTEXT_IRQ:
+		return "IRQ-disabled region";
+	case BPF_DIAG_CONTEXT_LOCK:
+		return "lock region";
+	case BPF_DIAG_CONTEXT_NONE:
+	default:
+		return "context";
+	}
+}
+
+static void diag_print_context_event(struct bpf_verifier_env *env,
+				     const struct bpf_diag_history_event *event)
+{
+	bpf_diag_source(env, event->insn_idx, "context", "%s %s; depth is now %u",
+			       event->ctx.enter ? "entered" : "left",
+			       diag_context_name(event->ctx.kind), event->ctx.depth);
+}
+
+static void diag_print_history(struct bpf_verifier_env *env,
+			       const struct bpf_diag_history_opts *opts)
+{
+	const struct bpf_diag_history_event *event;
+	struct bpf_diag_history_filter filter = {
+		.opts = opts,
+	};
+	struct bpf_diag_log *log;
+	struct diag_fmt_mark mark;
+	bool first = true;
+	bool visible = false;
+	int start_idx;
+	u32 i;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	if (!env->diag)
+		return;
+	log = &env->diag->log;
+
+	diag_build_lineage(env, log, &filter);
+
+	start_idx = diag_history_start_idx(log, &filter);
+	for (i = start_idx; i < log->cnt; i++) {
+		event = diag_history_event(log, i);
+		if (diag_history_event_visible(event, &filter)) {
+			visible = true;
+			break;
+		}
+	}
+
+	if (!visible && !log->dropped && opts && opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG)
+		return;
+
+	diag_section(env, "Causal path");
+	mark = diag_fmt_save(env);
+	for (i = start_idx; i < log->cnt; i++) {
+		event = diag_history_event(log, i);
+		if (!diag_history_event_visible(event, &filter))
+			continue;
+
+		diag_fmt_restore(env, mark);
+
+		if (!first)
+			diag_write(env, "\n");
+		first = false;
+
+		switch (event->kind) {
+		case BPF_DIAG_HISTORY_BRANCH:
+			bpf_diag_source(env, event->insn_idx, "branch",
+					       "took the %s branch of this conditional, goto %s",
+					       event->branch.cond_true ? "true" : "false",
+					       event->branch.cond_true ? "followed" : "not followed");
+			break;
+		case BPF_DIAG_HISTORY_MOD:
+			diag_print_mod(env, event);
+			break;
+		case BPF_DIAG_HISTORY_REF_ACQUIRE:
+		case BPF_DIAG_HISTORY_REF_RELEASE:
+			diag_print_ref_event(env, event);
+			break;
+		case BPF_DIAG_HISTORY_CONTEXT:
+			diag_print_context_event(env, event);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!visible)
+		diag_write(env, "  no retained diagnostic events on this path\n");
+	if (log->dropped)
+		diag_write(env, "  %u causal-history event%s not retained after diagnostic event "
+			   "storage was exhausted\n",
+			   log->dropped, log->dropped == 1 ? "" : "s");
+	diag_fmt_restore(env, mark);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 0cf5427a1a1b..2f243306346e 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -4,6 +4,7 @@
 #ifndef __BPF_DIAGNOSTICS_H
 #define __BPF_DIAGNOSTICS_H
 
+#include <linux/bpf.h>
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
@@ -90,6 +91,13 @@ enum bpf_diag_context_kind {
 	BPF_DIAG_CONTEXT_LOCK,
 };
 
+enum bpf_diag_invalid_deref_kind {
+	BPF_DIAG_DEREF_SCALAR,
+	BPF_DIAG_DEREF_NULLABLE_PTR,
+	BPF_DIAG_DEREF_MODIFIED_PTR,
+	BPF_DIAG_DEREF_INVALID_PTR,
+};
+
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
@@ -97,6 +105,7 @@ const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list
 	__printf(2, 0);
 const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
+const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type);
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
@@ -105,6 +114,15 @@ void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
 void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
+void bpf_diag_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *problem, const char *reason, const char *suggestion);
+void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
+				   const char *reg_name, const struct bpf_reg_state *reg,
+				   enum bpf_diag_invalid_deref_kind kind, s64 offset);
+void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int regno);
+void bpf_diag_stack_arg_uninit(struct bpf_verifier_env *env, u32 insn_idx, int nargs,
+				      int stack_arg_slot, const char *callee_name,
+				      const char *arg_name);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a32f360d0f00..c8b28862939f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3110,6 +3110,7 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
 			verbose(env, "R%d !read_ok\n", regno);
+			bpf_diag_unreadable_reg(env, env->insn_idx, regno);
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
@@ -4128,7 +4129,8 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
 }
 
 static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
-				     int nargs)
+				     int nargs, const char *callee_name, const struct btf *btf,
+				     const struct btf_param *args)
 {
 	int i, spi;
 
@@ -4136,8 +4138,14 @@ static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_fu
 		spi = i - MAX_BPF_FUNC_REG_ARGS;
 		if (spi >= caller->out_stack_arg_cnt ||
 		    caller->stack_arg_regs[spi].type == NOT_INIT) {
+			const char *arg_name = NULL;
+
+			if (args && args[i].name_off)
+				arg_name = btf_name_by_offset(btf, args[i].name_off);
 			verbose(env, "callee expects %d args, stack arg%d is not initialized\n",
 				nargs, spi + 1);
+			bpf_diag_stack_arg_uninit(env, env->insn_idx, nargs, spi,
+							 callee_name, arg_name);
 			return -EFAULT;
 		}
 	}
@@ -4292,6 +4300,9 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	if (!fixed_off_ok && reg->var_off.value != 0) {
 		verbose(env, "dereference of modified %s ptr %s off=%lld disallowed\n",
 			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.value);
+		bpf_diag_invalid_deref(env, env->insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno), reg,
+					      BPF_DIAG_DEREF_MODIFIED_PTR, reg->var_off.value);
 		return -EACCES;
 	}
 
@@ -6222,6 +6233,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 				reg_type_str(env, reg->type));
+			bpf_diag_invalid_deref(env, insn_idx, reg_from_argno(argno),
+						      reg_arg_name(env, argno), reg,
+						      BPF_DIAG_DEREF_NULLABLE_PTR, 0);
 			return -EACCES;
 		}
 
@@ -6372,8 +6386,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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
+		bpf_diag_invalid_deref(env, insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno), reg, kind, 0);
 		return -EACCES;
 	}
 
@@ -9253,20 +9275,28 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
+							bpf_subprog_name(env, subprog),
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
+					bpf_subprog_name(env, subprog), btf, args);
 	if (ret)
 		return ret;
 
@@ -12104,7 +12134,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	args = (const struct btf_param *)(meta->func_proto + 1);
 	nargs = btf_type_vlen(meta->func_proto);
 
-	ret = check_outgoing_stack_args(env, caller, nargs);
+	ret = check_outgoing_stack_args(env, caller, nargs, func_name, btf, args);
 	if (ret)
 		return ret;
 
@@ -13785,9 +13815,8 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
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
@@ -13799,6 +13828,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	const char *reason;
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
@@ -13822,12 +13852,24 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env,
 			"R%d 32-bit pointer arithmetic prohibited\n",
 			dst);
+		reason = bpf_diag_fmt(
+			env, "R%d holds %s. 32-bit ALU operations on pointers discard pointer tracking, so the verifier cannot keep the result as a safe pointer.",
+			ptr_regno, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "32-bit pointer arithmetic", reason,
+			"Use a 64-bit ALU instruction with an allowed, bounded scalar offset.");
 		return -EACCES;
 	}
 
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_fmt(
+			env, "R%d may be NULL (%s). Pointer arithmetic is allowed only after the program proves the pointer is non-NULL on this path.",
+			ptr_regno, reg_type_str(env, ptr_reg->type));
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "pointer arithmetic before NULL check", reason,
+			"Make sure that a NULL check precedes any arithmetic performed on the pointer.");
 		return -EACCES;
 	}
 
@@ -13857,6 +13899,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	default:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_fmt(
+			env, "R%d holds %s. This pointer kind does not allow offset arithmetic.",
+			ptr_regno, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "pointer arithmetic is not allowed", reason,
+			"Do not change this pointer's offset; use it only in operations accepted for its kind.");
 		return -EACCES;
 	}
 
@@ -13874,9 +13922,25 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	if (base_type(ptr_reg->type) == PTR_TO_MEM && (ptr_reg->type & PTR_UNTRUSTED))
 		return 0;
 
-	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
-	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
+		reason = bpf_diag_fmt(
+			env, "The scalar offset used with R%d is unbounded or outside the verifier's safe pointer-offset range [-%u, %u].",
+			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF);
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
+			"Clamp or bounds-check the scalar offset before applying it to the pointer.");
 		return -EINVAL;
+	}
+	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
+		reason = bpf_diag_fmt(
+			env, "R%d already has an offset outside the verifier's safe range [-%u, %u] for %s.",
+			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
+			bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
+			"Keep the base pointer within the verifier's allowed offset range before applying more arithmetic.");
+		return -EINVAL;
+	}
 
 	/* pointer types do not carry 32-bit bounds at the moment. */
 	__mark_reg32_unbounded(dst_reg);
@@ -13919,6 +13983,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
+			reason = bpf_diag_fmt(
+				env, "This operation subtracts pointer register R%d from scalar register R%d. "
+				"The verifier only tracks pointer-minus-scalar arithmetic for allowed pointer types.",
+				ptr_regno, dst);
+			bpf_diag_register_type(
+				env, env->insn_idx, ptr_regno, "pointer subtracted from scalar", reason,
+				"Keep the pointer as the base; only add or subtract bounded scalars when permitted.");
 			return -EACCES;
 		}
 		/* We don't allow subtraction from FP, because (according to
@@ -13928,6 +13999,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		if (ptr_reg->type == PTR_TO_STACK) {
 			verbose(env, "R%d subtraction from stack pointer prohibited\n",
 				dst);
+			reason = bpf_diag_fmt(
+				env, "R%d is a stack pointer. The verifier does not allow BPF_SUB to move stack pointers.",
+				ptr_regno);
+			bpf_diag_register_type(
+				env, env->insn_idx, ptr_regno, "subtraction from stack pointer", reason,
+				"Use addition from R10 to form stack addresses within the tracked stack frame.");
 			return -EACCES;
 		}
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
@@ -13953,16 +14030,38 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* bitwise ops on pointers are troublesome, prohibit. */
 		verbose(env, "R%d bitwise operator %s on pointer prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_fmt(
+			env, "R%d holds %s. Bitwise operator %s would destroy the pointer value the verifier is tracking.",
+			ptr_regno, bpf_diag_reg_type_plain(env, ptr_reg->type),
+			bpf_alu_string[opcode >> 4]);
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "bitwise operation on pointer", reason,
+			"Do bitwise operations on scalar values, not on pointer-valued registers.");
 		return -EACCES;
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		verbose(env, "R%d pointer arithmetic with %s operator prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_fmt(
+			env, "R%d holds %s. Operator %s is not one of the limited pointer arithmetic operations the verifier can track.",
+			ptr_regno, bpf_diag_reg_type_plain(env, ptr_reg->type),
+			bpf_alu_string[opcode >> 4]);
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "invalid pointer arithmetic operator", reason,
+			"Use only verifier-supported addition or subtraction with a bounded scalar offset, or perform this operation on a scalar value.");
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
+		reason = bpf_diag_fmt(
+			env, "After this arithmetic, R%d would be outside the verifier's safe offset range [-%u, %u] for %s.",
+			dst, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
+			bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_register_type(
+			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
+			"Tighten the scalar bounds before the arithmetic so the resulting pointer remains within the allowed range.");
 		return -EINVAL;
+	}
 	reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
@@ -14934,15 +15033,15 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				if (err)
 					return err;
 				off_reg = *dst_reg;
-				return adjust_ptr_min_max_vals(env, insn, src_reg, &off_reg);
+				return adjust_ptr_min_max_vals(env, insn, insn->src_reg, src_reg,
+							       &off_reg);
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
@@ -14957,8 +15056,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		__mark_reg_known(&off_reg, insn->imm);
 		src_reg = &off_reg;
 		if (ptr_reg) /* pointer += K */
-			return adjust_ptr_min_max_vals(env, insn,
-						       ptr_reg, src_reg);
+			return adjust_ptr_min_max_vals(env, insn, insn->dst_reg, ptr_reg, src_reg);
 	}
 
 	/* Got here implies adding two SCALAR_VALUEs */
diff --git a/tools/testing/selftests/bpf/progs/verifier_uninit.c b/tools/testing/selftests/bpf/progs/verifier_uninit.c
index 7718cd7d19ce..691018a46049 100644
--- a/tools/testing/selftests/bpf/progs/verifier_uninit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_uninit.c
@@ -9,6 +9,7 @@
 SEC("socket")
 __description("read uninitialized register")
 __failure __msg("R2 !read_ok")
+__msg("R2 has never been initialized on this path")
 __failure_unpriv
 __naked void read_uninitialized_register(void)
 {
-- 
2.53.0

