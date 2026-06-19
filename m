Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5153C3C11
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902800; cv=none; b=pBpdqj/86lrS1s1TCLJrCXwQ9LT1EJ+YWhr3NvtLHhn0dKhi/Vf8BmylOWYWAmMU8Z4ISBNopvtKMU6qp/CzPl/7fipPHoAQedInRhd8lnoIQ2DHckDmZEZlpeYQ0OEbO7tr+S+gz9ipgQHUHYlNdOrVszt5K3dk86DpeIdMU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902800; c=relaxed/simple;
	bh=GHb7JVQPpeI3o2Ob2GysM085lTAiNjSdbAaQ4jqYq9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOYmgaHg5viIgs3zD/le2OpD3LV5RuyDDqaSTm3zrNXTFxyq3Zi7UMyEgs6gFv1vnm2nJnnaGJgWS6URiyOaYLSuG7mvIGfBkt1WQFxvtSIszHv5TPDCBUK8KWuhsZhU9sSA570Y1PkOQ5zEGWOSbb/DNZQ0Y8xIwOyq6igFQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm5GkAGU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5GkAGU"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4631679f204so1736356f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902784; x=1782507584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuTWTjnb/iZ2y89GnEXLtyViZSH7IbsnhAJO/xGyY7w=;
        b=lm5GkAGUIL3dkqor5XwP6LxghJxJnWYXFtPwyUbu60rkjxmSO5yCZOv0BsgF1+rQoL
         s324B3f1cLLEg5KRDB+bCcTTUqm+gmt++E+8Y6lJZQOTYGH4b1vlUap/pm+qu/GQcdKY
         gxeapsRPoYjTiGHbysUAoaIJssRzhL6mjY7qkUYTIF2lgvhZo4CbHYvhMmy5qLCB6leu
         xq/UmhzqV90AQMow59ucbMP6Te+2lA40/7z/Bwdy2/7Nde/b1ZqQitQLZ9P2bSf0vnOm
         HmcK1t9Atxds6BDuAZHL0W70Pimlu2yavgnDQjVbzHFcYEwt38rPaJ8OnTeF/n30kMpO
         vcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902784; x=1782507584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuTWTjnb/iZ2y89GnEXLtyViZSH7IbsnhAJO/xGyY7w=;
        b=FdNfwAzzZFUKR+dDTrBaNsShQHvwafKBCSPnbpEFVwOMnxo/CfBPhDmC6qGj1U69QZ
         rxlbLsUxjTGIVEVGrznK0VBNLbsrz6zgaytSxaREgtAGlbOl8b9nnFJGECfuL7Ae2+Kq
         6NnB19zUjvJf4+X6QFl8jCvAQCQcrjGbru8ytbGFBtfLNB4uP7OGrvaubHAQ1bSF840q
         CDpueEYYhwfRwjB8UbivtWJ1+/98OOY4wnJU2mXLn1dJwYjw2xUsNi4MQ2unmJg9nA64
         yhmhJadkejdLToflt8zwU8ptkRNAACdhOkick49KgCWOyo6atedrO5UcdtYt/rJc6cwc
         Oq1A==
X-Gm-Message-State: AOJu0YwcFS/jw8E1h7ku0CJVJky/WgeE5QgT3AjWfKxJdxN5iKijNpLi
	DYUHtiMUg3JDMyilnbkjokPckpsVDMGXc8tLwhIhjqvgi4Fb8E3BVlsJl/qviQ77
X-Gm-Gg: AfdE7ckX1Whmh2Q6PihdK6hh9+tVXKGKzJOv7xvqFy1cW0YV0hxhfzmUT29BVCSxb/F
	oABjSWC/L3Hr8lVnL8ztVgJNb8TDiZR0MFxzjmg0iwCapuuxEagnQaGfDatzgCUZDvHRHw76Q7Y
	cjspTjEzxpjMAVBDBsO0LtM+NTtIyLxm+r+Lmo17t8q41reABTwUXCj/mU+fS6fIMCAw8tT/MDI
	anShguMOSkHyzJxxY3loIVAZf7I33BWdaVuK/vsWXpO6SNbNErchQLqf3X/2aBt8U3A6u55aC9T
	WBtQoEkcby37RY2Uy+pUkZyFEmkrU89dgf0yhTOnrCa/Sq70Il1tRcjGErVMV6JvRWk8iuNtaGy
	wadS1UGYHG67PbPRe1uNp20Gf4CvQOFAPTlix9OfKPGRPktg6IHcG2ovlEiKrcpUWDgrvA2ikxZ
	ki6PJOEeLG8i6oKzNkGDIZe0vwAluVoUQtATa3o9M1YBd+zxcf01bZzZfQBx3XlQnN+qEek+PUk
	Ufhgxoz3zI7UHfnnSYOy4XnCNbOoZOiGRYDynHzQICoEZYZGeIeJjc=
X-Received: by 2002:a05:6000:2289:b0:460:395c:7404 with SMTP id ffacd0b85a97d-4651e5c5525mr7953764f8f.20.1781902783919;
        Fri, 19 Jun 2026 13:59:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57b95sm1663677f8f.30.2026.06.19.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/17] bpf: Report Register Type Safety errors
Date: Fri, 19 Jun 2026 22:59:21 +0200
Message-ID: <20260619205934.1312876-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24797; i=memxor@gmail.com; h=from:subject; bh=GHb7JVQPpeI3o2Ob2GysM085lTAiNjSdbAaQ4jqYq9Q=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05X/GUOco3bCZL99IpxzoXt5yZ3ZMjkvr/c2bJ4Tu9 jPKf3yqo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOxUmZkePFjwrO9TR6GUjX/ W7jfRDrN/vXG01rlt4jZmRlXou2jdzAyvF+zafvcK0vVVvCwln5ONT7xYY2l4bUrpUusWp3Pl5Z YswAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected register-state verifier failures with Register Type Safety
reports. The existing verbose verifier messages remain in place; the new
reports add reason, source context, causal path, and suggestions.

Cover invalid pointer dereferences, unreadable registers, missing outgoing
stack arguments for bpf2bpf and kfunc calls, and rejected pointer arithmetic.
Use scoped diagnostic history so reports start from the latest relevant value
change and then show later branch outcomes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 234 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h |  22 ++++
 kernel/bpf/verifier.c    | 178 +++++++++++++++++++++++++++--
 3 files changed, 423 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index d6a9a2315f54..92a4aef3cc90 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -837,6 +837,217 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 	kfree(msg);
 }
 
+static u32 bpf_diag_current_frameno(const struct bpf_verifier_env *env)
+{
+	return env->cur_state->frame[env->cur_state->curframe]->frameno;
+}
+
+static int bpf_diag_stack_argno(u8 slot);
+
+void bpf_diag_report_register_type(struct bpf_verifier_env *env,
+				   u32 insn_idx, int regno,
+				   const char *problem, const char *reason,
+				   const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+static const char *bpf_diag_arg_ordinal(int argno)
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
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
+				   int regno, const char *reg_name,
+				   const char *type_name,
+				   enum bpf_diag_invalid_deref_kind kind,
+				   s64 offset)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "invalid dereference");
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_SCALAR:
+		bpf_diag_report_reason(env,
+				       "%s is an integer scalar here, not a pointer to memory.",
+				       reg_name);
+		break;
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		bpf_diag_report_reason(env,
+				       "%s may be NULL here (%s). The program could dereference NULL on this path, so the verifier cannot prove this access is safe.",
+				       reg_name, type_name);
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		bpf_diag_report_reason(env,
+				       "%s has offset %lld here, but this pointer type must be dereferenced in its original form.",
+				       reg_name, offset);
+		break;
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		bpf_diag_report_reason(env,
+				       "%s has type %s here, which is not valid for this memory access.",
+				       reg_name, type_name);
+		break;
+	}
+
+	bpf_diag_report_section(env, "At");
+	if (kind == BPF_DIAG_DEREF_MODIFIED_PTR)
+		bpf_diag_report_source(env, insn_idx, "error",
+				       "dereference requires the original %s pointer",
+				       type_name);
+	else
+		bpf_diag_report_source(env, insn_idx, "error",
+				       "invalid dereference of %s (%s)",
+				       reg_name, type_name);
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		bpf_diag_report_suggestion(env,
+					   "Add a NULL check before the access and dereference the pointer only on the non-NULL path.");
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		bpf_diag_report_suggestion(env,
+					   "Preserve the original pointer in another register, or use only offsets this pointer type permits before dereferencing it.");
+		break;
+	case BPF_DIAG_DEREF_SCALAR:
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		bpf_diag_report_suggestion(env,
+					   "Preserve a pointer-valued register where needed, or reload and revalidate the pointer after scalar arithmetic, helper calls, or other operations that can invalidate it.");
+		break;
+	}
+}
+
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
+				    u32 insn_idx, int regno)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "unreadable register");
+	bpf_diag_report_reason(env,
+			       "R%d is not readable here. A previous operation may have invalidated this register, so the verifier cannot use it as an input.",
+			       regno);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "R%d is not readable", regno);
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Avoid using the register after it is invalidated, or reload and revalidate a fresh pointer before this instruction.");
+}
+
+static void bpf_diag_format_stack_arg(char *buf, size_t size, u8 slot)
+{
+	int argno = bpf_diag_stack_argno(slot);
+	const char *ordinal = bpf_diag_arg_ordinal(argno);
+
+	if (ordinal)
+		scnprintf(buf, size, "outgoing stack argument %u (%s argument)",
+			  slot + 1, ordinal);
+	else
+		scnprintf(buf, size, "outgoing stack argument %u", slot + 1);
+}
+
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
+				      u32 insn_idx, int nargs,
+				      int stack_arg_slot,
+				      const char *callee_name)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+		.frameno = bpf_diag_current_frameno(env),
+		.stack_arg_slot = stack_arg_slot,
+	};
+	const char *arg_buf;
+
+	arg_buf = bpf_diag_scratch_buf(env, 1, NULL);
+	if (arg_buf)
+		bpf_diag_format_stack_arg((char *)arg_buf, BPF_DIAG_SCRATCH_STR_LEN,
+					  stack_arg_slot);
+	else
+		arg_buf = "";
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "missing stack argument");
+	if (callee_name && *callee_name)
+		bpf_diag_report_reason(env,
+				       "Function %s expects %d arguments, but %s is not initialized at this call.",
+				       callee_name, nargs, arg_buf);
+	else
+		bpf_diag_report_reason(env,
+				       "The callee expects %d arguments, but %s is not initialized at this call.",
+				       nargs, arg_buf);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "%s is not initialized", arg_buf);
+
+	if (stack_arg_slot >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Write the outgoing stack argument after any operation that may invalidate stored pointer values, and before making this call.");
+}
+
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true)
 {
@@ -1726,7 +1937,24 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (!printed)
-		bpf_diag_write(env,
-			       "  no retained diagnostic events on this path\n");
+	if (!printed) {
+		if (opts && opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
+		    opts->stack_arg_slot >= 0) {
+			const char *arg_buf;
+
+			arg_buf = bpf_diag_scratch_buf(env, 0, NULL);
+			if (arg_buf)
+				bpf_diag_format_stack_arg((char *)arg_buf,
+							  BPF_DIAG_SCRATCH_STR_LEN,
+							  opts->stack_arg_slot);
+			else
+				arg_buf = "this outgoing stack argument";
+			bpf_diag_write(env,
+				       "  no retained writes for %s on this path\n",
+				       arg_buf);
+		} else {
+			bpf_diag_write(env,
+				       "  no retained diagnostic events on this path\n");
+		}
+	}
 }
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 684574388343..d6e858cd39f2 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -117,6 +117,13 @@ enum bpf_diag_context_kind {
 	BPF_DIAG_CONTEXT_LOCK,
 };
 
+enum bpf_diag_invalid_deref_kind {
+	BPF_DIAG_DEREF_SCALAR,
+	BPF_DIAG_DEREF_NULLABLE_PTR,
+	BPF_DIAG_DEREF_MODIFIED_PTR,
+	BPF_DIAG_DEREF_INVALID_PTR,
+};
+
 struct bpf_diag_history_opts {
 	enum bpf_diag_history_scope scope;
 	u32 frameno;
@@ -149,6 +156,21 @@ void bpf_diag_report_header(struct bpf_verifier_env *env,
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 			    const char *label, const char *fmt, ...)
 	__printf(4, 5);
+void bpf_diag_report_register_type(struct bpf_verifier_env *env,
+				   u32 insn_idx, int regno,
+				   const char *problem, const char *reason,
+				   const char *suggestion);
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
+				   int regno, const char *reg_name,
+				   const char *type_name,
+				   enum bpf_diag_invalid_deref_kind kind,
+				   s64 offset);
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
+				    u32 insn_idx, int regno);
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
+				      u32 insn_idx, int nargs,
+				      int stack_arg_slot,
+				      const char *callee_name);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e584dec04b34..2c5f24528071 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3145,6 +3145,8 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
 			verbose(env, "R%d !read_ok\n", regno);
+			bpf_diag_report_unreadable_reg(env, env->insn_idx,
+						       regno);
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
@@ -4197,8 +4199,9 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
 	return mark_chain_precision_batch(env, env->cur_state);
 }
 
-static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
-				     int nargs)
+static int check_outgoing_stack_args(struct bpf_verifier_env *env,
+				     struct bpf_func_state *caller, int nargs,
+				     const char *callee_name)
 {
 	int i, spi;
 
@@ -4208,6 +4211,9 @@ static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_fu
 		    caller->stack_arg_regs[spi].type == NOT_INIT) {
 			verbose(env, "callee expects %d args, stack arg%d is not initialized\n",
 				nargs, spi + 1);
+			bpf_diag_report_stack_arg_uninit(env, env->insn_idx,
+							 nargs, spi,
+							 callee_name);
 			return -EFAULT;
 		}
 	}
@@ -4362,6 +4368,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	if (!fixed_off_ok && reg->var_off.value != 0) {
 		verbose(env, "dereference of modified %s ptr %s off=%lld disallowed\n",
 			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.value);
+		bpf_diag_report_invalid_deref(env, env->insn_idx,
+					      reg_from_argno(argno),
+					      reg_arg_name(env, argno),
+					      reg_type_str(env, reg->type),
+					      BPF_DIAG_DEREF_MODIFIED_PTR,
+					      reg->var_off.value);
 		return -EACCES;
 	}
 
@@ -6241,6 +6253,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 				reg_type_str(env, reg->type));
+			bpf_diag_report_invalid_deref(env, insn_idx,
+						      reg_from_argno(argno),
+						      reg_arg_name(env, argno),
+						      reg_type_str(env, reg->type),
+						      BPF_DIAG_DEREF_NULLABLE_PTR,
+						      0);
 			return -EACCES;
 		}
 
@@ -6396,8 +6414,19 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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
+		bpf_diag_report_invalid_deref(env, insn_idx,
+					      reg_from_argno(argno),
+					      reg_arg_name(env, argno),
+					      reg_type_str(env, reg->type),
+					      kind, 0);
 		return -EACCES;
 	}
 
@@ -7973,6 +8002,39 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
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
@@ -9389,14 +9451,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	ret = btf_prepare_func_args(env, subprog);
 	if (ret) {
 		if (bpf_in_stack_arg_cnt(sub) > 0) {
-			err = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+			err = check_outgoing_stack_args(env, caller,
+							sub->arg_cnt,
+							subprog_name(env, subprog));
 			if (err)
 				return err;
 		}
 		return ret;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt,
+					subprog_name(env, subprog));
 	if (ret)
 		return ret;
 
@@ -12207,7 +12272,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		return -ENOTSUPP;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, nargs);
+	ret = check_outgoing_stack_args(env, caller, nargs, func_name);
 	if (ret)
 		return ret;
 
@@ -13934,6 +13999,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  */
 static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
+				   u32 ptr_regno,
 				   const struct bpf_reg_state *ptr_reg,
 				   const struct bpf_reg_state *off_reg)
 {
@@ -13946,6 +14012,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	const char *reason;
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
@@ -13969,12 +14036,28 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env,
 			"R%d 32-bit pointer arithmetic prohibited\n",
 			dst);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. 32-bit ALU operations on pointers discard pointer tracking, so the verifier cannot keep the result as a safe pointer.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "32-bit pointer arithmetic",
+					      reason,
+					      "Use a 64-bit ALU instruction with an allowed, bounded scalar offset.");
 		return -EACCES;
 	}
 
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d may be NULL (%s). Pointer arithmetic is allowed only after the program proves the pointer is non-NULL on this path.",
+						 ptr_regno,
+						 reg_type_str(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer arithmetic before NULL check",
+					      reason,
+					      "Make sure that a NULL check precedes any arithmetic performed on the pointer.");
 		return -EACCES;
 	}
 
@@ -14011,6 +14094,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	default:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. This pointer kind does not allow offset arithmetic.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer arithmetic is not allowed",
+					      reason,
+					      "Do not change this pointer's offset; use it only in operations accepted for its kind.");
 		return -EACCES;
 	}
 
@@ -14020,9 +14111,30 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	dst_reg->type = ptr_reg->type;
 	dst_reg->id = ptr_reg->id;
 
-	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
-	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "The scalar offset used with R%d is unbounded or outside the verifier's safe pointer-offset range [-%u, %u].",
+						 ptr_regno, BPF_MAX_VAR_OFF,
+						 BPF_MAX_VAR_OFF);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe",
+					      reason,
+					      "Clamp or bounds-check the scalar offset before applying it to the pointer.");
+		return -EINVAL;
+	}
+	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d already has an offset outside the verifier's safe range [-%u, %u] for %s.",
+						 ptr_regno,
+						 BPF_MAX_VAR_OFF,
+						 BPF_MAX_VAR_OFF,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe",
+					      reason,
+					      "Keep the base pointer within the verifier's allowed offset range before applying more arithmetic.");
 		return -EINVAL;
+	}
 
 	/* pointer types do not carry 32-bit bounds at the moment. */
 	__mark_reg32_unbounded(dst_reg);
@@ -14065,6 +14177,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
+			reason = bpf_diag_scratch_printf(env,
+							 0,
+							 "This operation subtracts pointer register R%d from scalar register R%d. The verifier only tracks pointer-minus-scalar arithmetic for allowed pointer types.",
+							 ptr_regno, dst);
+			bpf_diag_report_register_type(env, env->insn_idx,
+						      ptr_regno,
+						      "pointer subtracted from scalar",
+						      reason,
+						      "Keep the pointer as the base; only add or subtract bounded scalars when permitted.");
 			return -EACCES;
 		}
 		/* We don't allow subtraction from FP, because (according to
@@ -14074,6 +14195,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		if (ptr_reg->type == PTR_TO_STACK) {
 			verbose(env, "R%d subtraction from stack pointer prohibited\n",
 				dst);
+			reason = bpf_diag_scratch_printf(env,
+							 0,
+							 "R%d is a stack pointer. The verifier does not allow BPF_SUB to move stack pointers.",
+							 ptr_regno);
+			bpf_diag_report_register_type(env, env->insn_idx,
+						      ptr_regno,
+						      "subtraction from stack pointer",
+						      reason,
+						      "Use addition from R10 to form stack addresses within the tracked stack frame.");
 			return -EACCES;
 		}
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
@@ -14099,16 +14229,45 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* bitwise ops on pointers are troublesome, prohibit. */
 		verbose(env, "R%d bitwise operator %s on pointer prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. Bitwise operator %s would destroy the pointer value the verifier is tracking.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type),
+						 bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "bitwise operation on pointer",
+					      reason,
+					      "Do bitwise operations on scalar values, not on pointer-valued registers.");
 		return -EACCES;
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		verbose(env, "R%d pointer arithmetic with %s operator prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "R%d holds %s. Operator %s is not one of the limited pointer arithmetic operations the verifier can track.",
+						 ptr_regno,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type),
+						 bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "invalid pointer arithmetic operator",
+					      reason,
+					      "Use only verifier-supported addition or subtraction with a bounded scalar offset, or perform this operation on a scalar value.");
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
+		reason = bpf_diag_scratch_printf(env, 0,
+						 "After this arithmetic, R%d would be outside the verifier's safe offset range [-%u, %u] for %s.",
+						 dst,
+						 BPF_MAX_VAR_OFF,
+						 BPF_MAX_VAR_OFF,
+						 bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, ptr_regno,
+					      "pointer offset is not safe",
+					      reason,
+					      "Tighten the scalar bounds before the arithmetic so the resulting pointer remains within the allowed range.");
 		return -EINVAL;
+	}
 	reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
@@ -15080,6 +15239,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				if (err)
 					return err;
 				return adjust_ptr_min_max_vals(env, insn,
+							       insn->src_reg,
 							       src_reg, dst_reg);
 			}
 		} else if (ptr_reg) {
@@ -15088,6 +15248,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			if (err)
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
+						       insn->dst_reg,
 						       dst_reg, src_reg);
 		} else if (dst_reg->precise) {
 			/* if dst_reg is precise, src_reg should be precise as well */
@@ -15104,6 +15265,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		src_reg = &off_reg;
 		if (ptr_reg) /* pointer += K */
 			return adjust_ptr_min_max_vals(env, insn,
+						       insn->dst_reg,
 						       ptr_reg, src_reg);
 	}
 
-- 
2.53.0

