Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4F437136
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957171; cv=none; b=pfEonIyK4F8w/RotvAZzZK1QK+fFnAqS0FVWcIJr8V0MxXG2gCQglte6+oMMoLSeEawicW/itpLRZIQPqVtB8nyM00p7I/qQti5gNgpNdYPXkutFZPndjTis5wlgRuDViRRJ8V1qDKIhDJKSyg6irvwlitSZtNF9aXYiTeq9I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957171; c=relaxed/simple;
	bh=rptAUWOBRXeQtBXWIVODsqzKPSHU7+7ITYYyrc57GRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZWxKPL1huBd3KiBPaBTdmoyjixYHhm2pnYOtIsk6QW3o5luszSsCnvSTB+uUJZnKJxcjHQNKUZJRkwrGG4k6zpHnlQ9sNY552v92prtgNQz9BviR5cPO7l2jbUOyONz6YxGBeb1VhFqfOsWh1JfP1UvZZpA8gruMaqja+GTnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBUOV/qE; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBUOV/qE"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493b567a019so29961405e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957167; x=1784561967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQPDs/zMiaAqiQYZ5v/+FenYr9wo8pffZqihcuCQ9IU=;
        b=HBUOV/qE6BeEmVn7ifH1FVElGUQi/Z0e0Gplypy28fGLM6wnhSWRZoXadalWo540Ux
         n0BFNBmOn0sYpoSj0cX+Gxsrvs+rR4Jz+L0uCnFCCYTJBgBmG3uh/z81gt30opy5QWib
         hvpdp9wejxgvc6W7X1aBES4dUh9RMrzt+mLn5JyBFSTFTU5JD38C9PAKIPDNadXpMZJV
         6ph9I5AhwauF/dESLfpQEWALdL4BetLRPhPA6+g9MdQ+XCSsu9mdn6kcT+d0sYxEdil+
         cLBRrWP4v+OQpJMTnJepyRFXKJJwaEWaKUxf3kOCbFThOpq2jKDWaKBIiNCB1NoQXMb9
         1GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957167; x=1784561967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQPDs/zMiaAqiQYZ5v/+FenYr9wo8pffZqihcuCQ9IU=;
        b=Q4HFSGYiovZYrf/0SwUTD/Q+Cl5CWemHK3AIMGkXMcJLsW+tgxUFmgCEgm0wslLAB6
         EmgCdLnZzOShGkddBptveLc0Iz7Hvu2+3q1CLxCLtfsqocYR9JBESOAx8bUMTUvM4t7t
         3rSNv2Nvl6BHHN4FsHU84gxi8kqznEhBiujx7nh/8nSPyJqtdMYZf72H5zmSQlKdxcYC
         SCHo5nhVfI9gAg3n64BUxff1OeTTzU1QS14irXmmbn7jqTHSgc0D6mtSfj0XobVLUwYx
         K5+ZaasxdPP+0TP0yP5+fQmypFFVRBnzFzG8mh8riKSmx/mHWppzRV2Imf4kTas7/H5Q
         r6RA==
X-Gm-Message-State: AOJu0Yxx/6DNrj9ALEK9Ccdi60VbiF4hRRkHN99ViNhhbzmoozblzEz5
	excYzAKQzSv62yTDR9XgashSODn1LTHakRuHAL1FYpf3FajeBDesLogzdSIE8xfT
X-Gm-Gg: AfdE7cmuzFVlg37rPo6KO0zSD17keMWkMFll2XzDNN08T4/T8vssTRyiNLwga7eeMHt
	98Yex3fZ5DwG6vwi8S11mf5qLwNyFlPf6NymMytQF+WETGGiQ+S1KI6rdiudjOcWaRj3yPUPP0P
	At3i4nvioWsGIHA5Ei2mj+UfldPu4KuJPk1mpot7iX/w4pQXyx/Pi0i9c/UlBnu9oZSR1OgBjSN
	XX/prBFZ7wxsbBNWgow12qvU9vH/IbN7+qjsJ0f6ojwrqTAAstDRr55hKFTd/NWzomh5lfbdlbb
	Q9ryFOFSzDK6qIfZKdBG6FA/JRFTEmRTIoXnsSZzlhf7S9p+snzqJvQDS189yJXOvD4bPqwLG2e
	8vN1YykBN9ILq6PIz/Uh9ELlOLPJcL2lSLPRhp8iZWjIzj2kEcuciJr0rcrxrDiMrw+oBgNVkJ+
	LHSO4T92sbL5jdcJv8zrtyOs/BLChO5tMc1SZq+zHA1tuEgBIJoezTr46tNhSs0zcLmFYqJKCoc
	0GHoFM91J/6az6DO0L6T0XVb5xZlXHuPe2z9+nY3iM6+Sa23OvkSzo=
X-Received: by 2002:a05:6000:4285:b0:47d:f06d:55bc with SMTP id ffacd0b85a97d-47f2dce2669mr11586548f8f.40.1783957166539;
        Mon, 13 Jul 2026 08:39:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9884sm218101f8f.23.2026.07.13.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/17] bpf: Report Call Type Safety argument errors
Date: Mon, 13 Jul 2026 17:39:00 +0200
Message-ID: <20260713153910.2556007-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27888; i=memxor@gmail.com; h=from:subject; bh=rptAUWOBRXeQtBXWIVODsqzKPSHU7+7ITYYyrc57GRk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURfFOTkb+7q/+66/s5Lsi69rPx+L+stPn0BWvf48bz BxKRGM7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJEVsxn+V9d/vNniH2DsEORm 5Mj6X8Tu6y3hQ2mTlp457jV7yfzidwz/k2//6JklsIp9T8XCJbvVNyevuseSN7eAXdF1VeR/l02 xjAA=
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
 kernel/bpf/diagnostics.c | 152 +++++++++++++++++++++-
 kernel/bpf/diagnostics.h |   8 ++
 kernel/bpf/verifier.c    | 271 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 415 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index e454bcd0a0e0..111999e7682d 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -7,6 +7,7 @@
 #include <linux/btf.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
@@ -154,6 +155,11 @@ struct bpf_diag_reg_fmt {
 	char umax_buf[32];
 };
 
+struct bpf_diag_fmt_buf {
+	struct list_head node;
+	char data[];
+};
+
 struct bpf_diag_scratch {
 	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
 	struct bpf_reg_state regs[BPF_DIAG_SCRATCH_REG_CNT];
@@ -168,6 +174,7 @@ struct bpf_diag_scratch {
 struct bpf_diag {
 	struct bpf_diag_log log;
 	struct bpf_diag_scratch scratch;
+	struct list_head fmt_bufs;
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
@@ -186,7 +193,11 @@ int bpf_diag_init(struct bpf_verifier_env *env)
 		return 0;
 
 	env->diag = kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
-	return env->diag ? 0 : -ENOMEM;
+	if (!env->diag)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&env->diag->fmt_bufs);
+	return 0;
 }
 
 static struct bpf_diag_scratch *diag_scratch(struct bpf_verifier_env *env)
@@ -217,6 +228,100 @@ char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size
 	return buf;
 }
 
+static void diag_fmt_set_error(struct bpf_diag *diag, int error)
+{
+	if (!diag->log.error)
+		diag->log.error = error;
+}
+
+static char *diag_fmt_alloc(struct bpf_verifier_env *env, size_t size)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct bpf_diag_fmt_buf *buf;
+
+	if (!diag)
+		return NULL;
+
+	buf = kmalloc(struct_size(buf, data, size), GFP_KERNEL_ACCOUNT);
+	if (!buf) {
+		diag_fmt_set_error(diag, -ENOMEM);
+		return NULL;
+	}
+	list_add_tail(&buf->node, &diag->fmt_bufs);
+	return buf->data;
+}
+
+char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size)
+{
+	char *buf;
+
+	if (!size)
+		return NULL;
+
+	buf = diag_fmt_alloc(env, size);
+	if (buf)
+		buf[0] = '\0';
+	return buf;
+}
+
+const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
+{
+	struct bpf_diag *diag = diag_env(env);
+	va_list copy;
+	char *buf;
+	int len;
+
+	va_copy(copy, args);
+	len = vsnprintf(NULL, 0, fmt, copy);
+	va_end(copy);
+	if (len < 0 || len == INT_MAX) {
+		if (diag)
+			diag_fmt_set_error(diag, -EOVERFLOW);
+		return "";
+	}
+
+	buf = diag_fmt_alloc(env, len + 1);
+	if (buf)
+		vsnprintf(buf, len + 1, fmt, args);
+	return buf ?: "";
+}
+
+const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	const char *buf;
+	va_list args;
+
+	va_start(args, fmt);
+	buf = bpf_diag_vfmt(env, fmt, args);
+	va_end(args);
+	return buf;
+}
+
+const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id)
+{
+	char *buf = bpf_diag_fmt_buf(env, BPF_DIAG_SCRATCH_STR_LEN);
+
+	if (!buf)
+		return "";
+
+	bpf_diag_format_btf_type(buf, BPF_DIAG_SCRATCH_STR_LEN, btf, type_id);
+	return buf;
+}
+
+static void diag_fmt_free(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct bpf_diag_fmt_buf *buf, *tmp;
+
+	if (!diag)
+		return;
+
+	list_for_each_entry_safe(buf, tmp, &diag->fmt_bufs, node) {
+		list_del(&buf->node);
+		kfree(buf);
+	}
+}
+
 const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int slot,
 				    const char *str)
 {
@@ -319,6 +424,7 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 	if (!diag)
 		return;
 
+	diag_fmt_free(env);
 	kfree(diag->log.events);
 	kfree(diag->scratch.history_bitmap);
 	kfree(diag);
@@ -946,6 +1052,50 @@ static const char *diag_arg_ordinal(int argno)
 	}
 }
 
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
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
+	bpf_diag_report_header(env, CATEGORY_CALL_TYPE_SAFETY, "invalid call argument");
+	diag_report_reason(env, "The %s to %s does not satisfy the verifier contract: %s.",
+			   arg_desc, call_name, reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "invalid %s for %s", arg_desc, call_name);
+
+	if (print_history)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+	diag_fmt_free(env);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 73ddede41d17..7f1af8f50704 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -6,6 +6,7 @@
 
 #include <linux/bpf.h>
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 
 struct bpf_reference_state;
@@ -113,6 +114,10 @@ bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size);
 struct bpf_reg_state *bpf_diag_reg_scratch(struct bpf_verifier_env *env, unsigned int slot);
+char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
+const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args);
+const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int slot,
 				    const char *str);
 const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int slot,
@@ -151,6 +156,9 @@ void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *probl
 void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
 		  const char *reason, const char *suggestion, u32 depth);
 void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn);
+void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
+			       int stack_arg_slot, const char *call_name, const char *arg_name,
+			       const char *reason, const char *suggestion);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84eda5e83f87..07e2c1ed8fbe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8349,10 +8349,69 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
+static void bpf_diag_report_call_arg(struct bpf_verifier_env *env, u32 insn_idx, argno_t argno,
+				     const char *call_name, const char *reason,
+				     const char *suggestion)
+{
+	int arg = arg_from_argno(argno);
+	int stack_slot = -1;
+
+	if (arg > MAX_BPF_FUNC_REG_ARGS)
+		stack_slot = arg - MAX_BPF_FUNC_REG_ARGS - 1;
+
+	bpf_diag_report_call_type(env, insn_idx, arg, reg_from_argno(argno), stack_slot,
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
+	bpf_diag_report_call_arg(env, insn_idx, argno, call_name, reason, suggestion);
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
@@ -8402,6 +8461,12 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+	diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
+			  "Pass a value with one of the accepted pointer or scalar types for this "
+			  "call.",
+			  "it has type %s, but this argument accepts %s",
+			  bpf_diag_reg_type_plain(env, reg->type),
+			  diag_expected_reg_types(env, compatible->types, i));
 	return -EACCES;
 
 found:
@@ -8438,6 +8503,12 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_call_arg(env, env->insn_idx, argno,
+						 func_id_name(meta->func_id),
+						 "the pointer may be NULL, but this helper "
+						 "requires a non-NULL pointer",
+						 "Add a NULL check and call the helper only on the "
+						 "non-NULL path.");
 			return -EACCES;
 		}
 
@@ -8780,7 +8851,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno_from_reg(regno), arg_type, arg_btf_id, meta);
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta,
+			     func_id_name(meta->func_id));
 	if (err)
 		return err;
 
@@ -8793,6 +8865,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 			func_id_name(meta->func_id), reg_arg_name(env, argno));
+		bpf_diag_report_call_arg(env, insn_idx, argno, func_id_name(meta->func_id),
+					 "release helpers require a value that owns a live "
+					 "resource returned by a matching acquire helper",
+					 "Pass the resource-owning pointer returned by the "
+					 "matching acquire helper, and avoid calling the release "
+					 "helper after ownership has already been transferred or "
+					 "released.");
 		return -EINVAL;
 	}
 
@@ -9888,7 +9967,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta);
+			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta,
+					     bpf_verifier_subprog_name(env, subprog));
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
@@ -11927,8 +12007,8 @@ static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
 		       struct bpf_reg_state *regs, struct bpf_kfunc_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
-		       const char *ref_tname, const struct btf_param *args,
-		       int arg, int nargs, argno_t argno, struct bpf_reg_state *reg)
+		       const char *ref_tname, u32 ref_id, const struct btf_param *args, int arg,
+		       int nargs, argno_t argno, struct bpf_reg_state *reg)
 {
 	bool arg_mem_size = false;
 
@@ -12019,9 +12099,18 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+		const char *expected_type;
+
+		expected_type = diag_btf_type_name(env, meta->btf, ref_id);
 		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
 			reg_arg_name(env, argno),
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+		diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
+				  "Pass a verifier-tracked pointer to the expected kernel object "
+				  "type, not a pointer to stack storage or another memory buffer.",
+				  "the kfunc expects a pointer to %s, but this argument is %s and "
+				  "cannot be used as that kernel object pointer",
+				  expected_type, bpf_diag_reg_type_plain(env, reg->type));
 		return -EINVAL;
 	}
 	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
@@ -12676,6 +12765,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass an integer scalar value for this argument, "
+						  "not a pointer or resource object.",
+						  "the kfunc expects an integer scalar, but %s is "
+						  "%s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12687,6 +12783,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(reg->var_off)) {
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a compile-time constant or a value "
+							  "the verifier can prove is constant at "
+							  "this call.",
+							  "the kfunc requires this scalar argument "
+							  "to be a verifier-known constant, but %s "
+							  "is variable on this path",
+							  reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 				if (regno >= 0)
@@ -12713,6 +12817,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(reg->var_off)) {
 					verbose(env, "%s is not a const\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a verifier-known constant size for "
+							  "this kfunc buffer argument.",
+							  "the kfunc uses this argument as a "
+							  "return-buffer size, but %s is variable "
+							  "on this path",
+							  reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 
@@ -12738,28 +12849,48 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
 		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
+			const char *expected_type;
+
+			expected_type = diag_btf_type_name(env, btf, ref_id);
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
+			diag_call_arg_fmt(env, insn_idx, argno, func_name,
+					  "Add a NULL check and call the kfunc only on the "
+					  "non-NULL path.",
+					  "the pointer may be NULL, but this kfunc requires a "
+					  "non-NULL pointer to %s",
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
+					  "Pass the resource-owning pointer returned by the "
+					  "matching acquire kfunc, and avoid calling the release "
+					  "kfunc after ownership has already been transferred or "
+					  "released.",
+					  "release kfuncs require a resource-owning pointer to %s "
+					  "returned by a matching acquire kfunc",
+					  expected_type);
 			return -EINVAL;
 		}
 
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-
 		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno, reg);
+						     ref_id, args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12807,13 +12938,36 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
 				if (!is_kfunc_rcu(meta)) {
+					const char *expected_type;
+
+					expected_type = diag_btf_type_name(env, btf, ref_id);
 					verbose(env, "%s must be referenced or trusted\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a pointer acquired from a "
+							  "verifier-tracked source, or call this "
+							  "kfunc only inside the required "
+							  "protection if it accepts RCU pointers.",
+							  "the kfunc requires a trusted or "
+							  "resource-owning pointer to %s, but %s "
+							  "is %s",
+							  expected_type, reg_arg_name(env, argno),
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
+					const char *expected_type;
+
+					expected_type = diag_btf_type_name(env, btf, ref_id);
 					verbose(env, "%s must be a rcu pointer\n",
 						reg_arg_name(env, argno));
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Use this kfunc with a pointer that is "
+							  "valid in an RCU read lock region.",
+							  "the kfunc requires an RCU-protected "
+							  "pointer to %s, but %s is %s",
+							  expected_type, reg_arg_name(env, argno),
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return -EINVAL;
 				}
 			}
@@ -12860,6 +13014,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the original program context pointer or "
+						  "preserve it before modifying registers.",
+						  "the kfunc expects a context pointer, but %s is "
+						  "%s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 
@@ -12886,10 +13047,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			} else {
 				verbose(env, "%s expected pointer to allocated object\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a pointer returned by the matching BPF "
+						  "object allocation path.",
+						  "the kfunc expects an allocated object pointer, "
+						  "but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the owned object pointer before it is "
+						  "released or transferred.",
+						  "the allocated object pointer in %s must still "
+						  "carry verifier-tracked ownership, but this "
+						  "pointer no longer owns a live resource",
+						  reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (meta->btf == btf_vmlinux) {
@@ -13055,8 +13230,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 			ret = check_mem_reg(env, reg, argno, type_size);
-			if (ret < 0)
+			if (ret < 0) {
+				const char *expected_type;
+
+				expected_type = diag_btf_type_name(env, btf, ref_id);
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass stack, map, context, or other "
+						  "verifier-known memory of the expected type and "
+						  "size, not an integer cast to a pointer.",
+						  "the kfunc expects %u bytes of memory for %s, "
+						  "but it is %s and not verifier-known memory",
+						  type_size, expected_type,
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return ret;
+			}
 			break;
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
@@ -13070,9 +13257,26 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
 							       argno, next_argno);
 				if (ret < 0) {
-					verbose(env, "%s and ", reg_arg_name(env, argno));
-					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-						reg_arg_name(env, next_argno));
+					const char *mem_arg, *size_arg_name;
+
+					mem_arg = diag_arg_name(env, argno);
+					size_arg_name = diag_arg_name(env, next_argno);
+					verbose(env, "%s and ", mem_arg);
+					verbose(env,
+						"%s memory, len pair leads to invalid memory "
+						"access\n",
+						size_arg_name);
+					diag_call_arg_fmt(env, insn_idx, argno, func_name,
+							  "Pass a stack, map, context, or other "
+							  "verifier-known memory pointer, and keep "
+							  "the paired length within that object.",
+							  "it is the memory pointer in a "
+							  "memory/length pair with %s, but it is "
+							  "%s and does not point to "
+							  "verifier-readable memory for the "
+							  "requested length",
+							  size_arg_name,
+							  bpf_diag_reg_type_plain(env, reg->type));
 					return ret;
 				}
 			}
@@ -13085,6 +13289,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				if (!tnum_is_const(size_reg->var_off)) {
 					verbose(env, "%s must be a known constant\n",
 						reg_arg_name(env, next_argno));
+					diag_call_arg_fmt(env, insn_idx, next_argno, func_name,
+							  "Pass a compile-time constant or "
+							  "verifier-known constant for this memory "
+							  "size argument.",
+							  "the kfunc requires the paired memory "
+							  "size argument %s to be a verifier-known "
+							  "constant, but it is variable on this "
+							  "path",
+							  reg_arg_name(env, next_argno));
 					return -EINVAL;
 				}
 				meta->arg_constant.found = true;
@@ -13104,8 +13317,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
+				const char *expected_type;
+
+				expected_type = diag_btf_type_name(env, btf, ref_id);
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a pointer returned by the matching BPF "
+						  "object allocation or lookup operation for this "
+						  "kfunc.",
+						  "the kfunc expects a pointer to BPF-managed "
+						  "refcounted object type %s, but this argument is "
+						  "not such an object pointer",
+						  expected_type);
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
@@ -13130,6 +13354,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a const string\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass a constant string pointer that the "
+						  "verifier recognizes, such as a string stored in "
+						  "a read-only map value.",
+						  "the kfunc expects a pointer to a constant "
+						  "string stored in verifier-known memory, but %s "
+						  "is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			ret = check_arg_const_str(env, reg, argno);
@@ -13170,6 +13403,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (reg->type != PTR_TO_STACK) {
 				verbose(env, "%s doesn't point to an irq flag on stack\n",
 					reg_arg_name(env, argno));
+				diag_call_arg_fmt(env, insn_idx, argno, func_name,
+						  "Pass the same stack slot used by "
+						  "bpf_local_irq_save() or "
+						  "bpf_res_spin_lock_irqsave().",
+						  "the kfunc expects a stack pointer to an IRQ "
+						  "flag slot, but %s is %s",
+						  reg_arg_name(env, argno),
+						  bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
 			ret = process_irq_flag(env, reg, argno, meta);
-- 
2.53.0

