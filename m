Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF128B4E2
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957160; cv=none; b=YWRgHZF/Wu4AJqEiW0tiSHR2YviMvItAtR4AkwsRz5TV1nfLmiolQG1Yc0aCClROPGAFYohhDvig6BJS9wJqnXTw/XFVHAoBaMWSfn/TXE/eM68kJaJUSA7MoIh60K7y2cp+p4+O4JkwSjaYexC9u/VkXcRMDiJv7rQlM2zcwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957160; c=relaxed/simple;
	bh=bNDmjhNelxW1PIkKWo1I9Fe6uGsepnMoUy9AEagrShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trh5+H17oIZgnEA4a6AuDDE0np4ZMc0FQC3q0Qh8CMpY9KU0DFvcFLle4tW54yR4cqrrildwB2jXqg+VkBjjKeHp0uqa4uyK3glopwAFzSfYO03lUoVkYEXq+YqxeGP8YD+Jdu1+pgM/U2CKrQYiKvRVfJQoxFq3VjyzjvSacuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR0gmDB2; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR0gmDB2"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493f17dc838so11315715e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957156; x=1784561956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMeylngwdEebIvBhvy75JHSxpjVS9jR4n3BgvzH0NNQ=;
        b=eR0gmDB2ieZFkWEaZroLXHOAP7M3yOVlh3DJ/Xll3Y1Yrnu5DTmmqUvYrnPM+kVs1t
         FJsLV+2hzx4TL2fmkHTBb12ASiJi6/r2KR0k4Lhpw0tZj4WcBzkhCe2MUHOTWUNK0GCi
         hA+tGNb1p9xx2DiBRqgaRjRVtxtTBB4pJKuERILB7egq52JW8UNlMKNjUWhnJHIW2yxw
         eCmxBKQe+T6r6kpYpYPBzn/Ad/wLYkKqRyEwr1jB90v6pw3Dw+sFjiMP1gpaNn73h+x4
         RSGyHgBZXyhL+mnDbQnw3nf3QcT3I+cnLCaJqm/MB+q5mXXEB9IH8noU2xMCnS7XyoCR
         5GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957156; x=1784561956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMeylngwdEebIvBhvy75JHSxpjVS9jR4n3BgvzH0NNQ=;
        b=O9ND9HlK3imlMXk8UBXlthll59On4wkI2ArabI4oPbSnCc19aDa8HZc6UYDqw/n0xI
         RMf2hq4GF69cUhjDDtq6iuRuECqbgUajKVBiy2aj5tWpDO/PkGBAfhwwwNAvmpkukj3p
         WqCx2EFSPGWTKTs+iUOnoIaMWG81Ot7i761Ff9Iqba8snlb87omgPC2BGbN6DkJo44g8
         wak192jU+VWz4WlH48RWghxr/lBvhL65mNeW45LHf/dWNUH3QVshyDGBZpCRpdtG7skU
         nXzOlnMcSltodTOqg6mHGtHqN+chkdsNUBJM5Qs1Bjhp0rY18c+glRkrwqv9vWiZQpOj
         eQGQ==
X-Gm-Message-State: AOJu0Yz2UmKW0c6zpWanRPoGB2DMD3bskDGvBh4s3GdmrwSxBhBj6rm/
	BRjpFK03Vog9FUCmxuYfYD8fwFYo5m7eUXeeACBxqg1TIRX5FKMdCeJvbD2SCdha
X-Gm-Gg: AfdE7cmoxw2qmSvWVgEccjZaavMABxStANcIuK32NEMP7V3WnAssXGjuD0CXYV0Icjw
	WeEpCNIbGbV4UwZ3F4Y+slh2lNFQZ+cf67aBGVGyunL2abFzgazXmhnRRGZgoxUUHmAVvCFXaX/
	VBT45Oiv2IKxti/8/6aoqgRerxkWBRToECEPh6S2DxrjJMfzTsmBTMUcvNHW1KHSpgTUXKZEGhA
	QFXEqE87UfZyflyc0S7jarAgg8vrd124KG4NbW+zhqf2x5nO2JkQd0JdoEcmiXCXCZN4hPU1kgb
	SWq/Yz6yBxRTL3tId7QJgzBQBBlF9I9L3eA7RWa4DtE8BB4tolUTqKhxOKv3TEGKwTCZrA9W/Lz
	p+vqq+wZndv0fFZF/dvezDE+mBuTxWJ6Z4SQZ5geFbBNIsVEtnCX7uEft5ERZ2s23mGWlPw1mrR
	sw6ZC8g/QUhjAcLYOBfIf4uWhFhanQnCw/6Y8Vq9UxTSMURDGVQ80O7kBrMGXE4kLZ+uu+BEFGZ
	ZFr5LpesiKWCdykZkcHw9if95aOMOqb6BOxO9/PDqYR5dQkcC7Cz98=
X-Received: by 2002:a05:600c:530f:b0:495:699:5c8b with SMTP id 5b1f17b1804b1-49506995ce4mr4723195e9.7.1783957155974;
        Mon, 13 Jul 2026 08:39:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322bcbsm4043255e9.9.2026.07.13.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event log
Date: Mon, 13 Jul 2026 17:38:52 +0200
Message-ID: <20260713153910.2556007-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12113; i=memxor@gmail.com; h=from:subject; bh=bNDmjhNelxW1PIkKWo1I9Fe6uGsepnMoUy9AEagrShE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURS656GTXSaXwiyfn3tsiGJTD8Zjj1W2m1nupc/KZn zd1dizsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERiGBj+Z8z70XCRSSwm2vXs x48Gy2OUj2nHdarvuNz8/nJ9SpVaKSND71MTc42XAc/1p/Gy5qXOqNKsWmykGaMUUKfz45PA9Mf sAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an environment-owned diagnostic history for verifier reports. Event
payloads keep the user-facing branch history shape, while storage lives
in bpf_verifier_env and follows the active verifier path.

Grow the event array as entries are appended and keep saved positions as
array indices. Later patches can truncate back to those positions when
verifier search backtracks. Add the branch event renderer now, while
leaving branch recording to the follow-up patch that wires active-path
pruning.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 184 +++++++++++++++++++++++++++++++++++----
 kernel/bpf/diagnostics.h |   4 +
 kernel/bpf/verifier.c    |  20 ++++-
 3 files changed, 190 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 49106115621d..ed19220aca9a 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -36,6 +36,22 @@
 #define BPF_DIAG_SCRATCH_STR_LEN 256
 #define BPF_DIAG_TEXT_LEN 160
 
+enum bpf_diag_history_kind {
+	BPF_DIAG_HISTORY_BRANCH,
+};
+
+struct bpf_diag_history_event {
+	u32 insn_idx;
+	u8 kind;
+	union {
+		struct {
+			bool cond_true;
+		} branch;
+	};
+};
+
+static void diag_print_history(struct bpf_verifier_env *env);
+
 struct bpf_diag_source_line {
 	const char *line;
 	int line_num;
@@ -58,6 +74,13 @@ struct bpf_diag_insn_ctx {
 	struct bpf_diag_insn_buf buf;
 };
 
+struct bpf_diag_log {
+	struct bpf_diag_history_event *events;
+	u32 cnt;
+	u32 cap;
+	int error;
+};
+
 struct bpf_diag_scratch {
 	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
 	struct bpf_linfo_source source;
@@ -66,6 +89,7 @@ struct bpf_diag_scratch {
 };
 
 struct bpf_diag {
+	struct bpf_diag_log log;
 	struct bpf_diag_scratch scratch;
 };
 
@@ -144,6 +168,51 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int s
 	return buf;
 }
 
+static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+}
+
+static struct bpf_diag_log *diag_event_log(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+
+	return diag ? &diag->log : NULL;
+}
+
+u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+
+	if (!diag)
+		return 0;
+	return diag->log.cnt;
+}
+
+void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos)
+{
+	struct bpf_diag *diag = env->diag;
+	struct bpf_diag_log *log;
+	u32 end;
+
+	if (!diag)
+		return;
+
+	log = &diag->log;
+	end = log->cnt;
+	if (WARN_ON_ONCE(pos > end))
+		pos = end;
+
+	log->cnt = pos;
+}
+
 void bpf_diag_free(struct bpf_verifier_env *env)
 {
 	struct bpf_diag *diag = env->diag;
@@ -151,20 +220,55 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 	if (!diag)
 		return;
 
+	kfree(diag->log.events);
 	kfree(diag);
 	env->diag = NULL;
 }
 
-static void diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
+static const struct bpf_diag_history_event *diag_history_event(const struct bpf_diag_log *log,
+							       u32 idx)
 {
-	va_list args;
+	return &log->events[idx];
+}
 
-	if (!bpf_diag_enabled(env))
-		return;
+static int diag_append_history(struct bpf_verifier_env *env,
+			       const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_history_event *events;
+	struct bpf_diag_log *log;
+	u32 cap;
 
-	va_start(args, fmt);
-	bpf_verifier_vlog(&env->log, fmt, args);
-	va_end(args);
+	log = diag_event_log(env);
+	if (!log)
+		return 0;
+	if (log->error)
+		return log->error;
+
+	if (log->cnt < log->cap) {
+		log->events[log->cnt++] = *event;
+		return 0;
+	}
+
+	cap = log->cap ? log->cap * 2 : 64;
+	if (cap < log->cap) {
+		log->error = -EOVERFLOW;
+		return log->error;
+	}
+
+	events = krealloc_array(log->events, cap, sizeof(*events), GFP_KERNEL_ACCOUNT);
+	if (!events) {
+		log->error = -ENOMEM;
+		return log->error;
+	}
+	log->events = events;
+	log->cap = cap;
+	log->events[log->cnt++] = *event;
+	return 0;
+}
+
+int bpf_diag_error(const struct bpf_verifier_env *env)
+{
+	return env->diag ? env->diag->log.error : 0;
 }
 
 static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
@@ -190,7 +294,7 @@ static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char
 		if (line[len] && line[len] != '\n' && line[len] != ' ' && last_space > 0)
 			len = last_space;
 
-		diag_log(env, "%s%.*s\n", prefix, len, line);
+		diag_write(env, "%s%.*s\n", prefix, len, line);
 
 		text = line + len;
 		while (*text == ' ')
@@ -216,7 +320,7 @@ static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt,
 
 	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
 	if (!buf) {
-		diag_log(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
+		diag_write(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
 		return;
 	}
 
@@ -467,12 +571,12 @@ void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 	problem = problem ?: "";
 
 	if (!problem[0]) {
-		diag_log(env, "\nVerification failed: %s\n", category);
+		diag_write(env, "\nVerification failed: %s\n", category);
 		return;
 	}
 
 	first = toupper(problem[0]);
-	diag_log(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
+	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
 }
 
 static void diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
@@ -484,7 +588,7 @@ static void diag_report_section(struct bpf_verifier_env *env, const char *title)
 	if (!bpf_diag_enabled(env))
 		return;
 
-	diag_log(env, "\n%s:\n", title);
+	diag_write(env, "\n%s:\n", title);
 }
 
 static void diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
@@ -513,7 +617,7 @@ static void diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt
 	va_start(args, fmt);
 	diag_vprint_indented(env, fmt, args);
 	va_end(args);
-	diag_log(env, "\n");
+	diag_write(env, "\n");
 }
 
 static void diag_print_source_annotation(struct bpf_verifier_env *env, int line_width, int indent,
@@ -574,16 +678,16 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 	memset(diag_insn, 0, sizeof(scratch->insns));
 
 	if (!diag_get_source(env, insn_idx, src)) {
-		diag_log(env, "  insn %u\n", insn_idx);
+		diag_write(env, "  insn %u\n", insn_idx);
 		diag_print_source_annotation(env, 0, 0, label, msg);
 		goto out_free_msg;
 	}
 
 	func = diag_func_name(env, insn_idx);
 	if (func && *func)
-		diag_log(env, "  %s @ %s:%d:%d\n", func, src->file, src->line_num, src->line_col);
+		diag_write(env, "  %s @ %s:%d:%d\n", func, src->file, src->line_num, src->line_col);
 	else
-		diag_log(env, "  %s:%d:%d\n", src->file, src->line_num, src->line_col);
+		diag_write(env, "  %s:%d:%d\n", src->file, src->line_num, src->line_col);
 
 	start_line = src->line_num - BPF_DIAG_CONTEXT;
 	end_line = src->line_num + BPF_DIAG_CONTEXT;
@@ -619,3 +723,51 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 out_free_msg:
 	kfree(msg);
 }
+
+int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_BRANCH,
+		.branch.cond_true = cond_true,
+	};
+
+	return diag_append_history(env, &event);
+}
+
+static void diag_print_history(struct bpf_verifier_env *env)
+{
+	const struct bpf_diag_history_event *event;
+	const struct bpf_diag_log *log;
+	bool printed = false;
+	u32 i;
+
+	diag_report_section(env, "Causal path");
+
+	if (!env->diag) {
+		diag_write(env, "  no recorded diagnostic events on this path\n");
+		return;
+	}
+	log = &env->diag->log;
+
+	for (i = 0; i < log->cnt; i++) {
+		event = diag_history_event(log, i);
+
+		switch (event->kind) {
+		case BPF_DIAG_HISTORY_BRANCH:
+			if (printed)
+				diag_write(env, "\n");
+			bpf_diag_report_source(env, event->insn_idx, "branch",
+					       "took the %s branch of this conditional, goto %s",
+					       event->branch.cond_true ? "true" : "false",
+					       event->branch.cond_true ? "followed" : "not followed");
+			printed = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!printed)
+		diag_write(env, "  no retained diagnostic events on this path\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d852386bf5f2..e32ac64dd23c 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -16,10 +16,14 @@ const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int s
 				    const char *str);
 const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int slot,
 				    const char *fmt, ...) __printf(3, 4);
+u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
+void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
+int bpf_diag_error(const struct bpf_verifier_env *env);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
+int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f127c8db134..d0d399b879e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16135,6 +16135,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
+		err = bpf_diag_record_branch(env, *insn_idx, true);
+		if (err)
+			return err;
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -16150,7 +16153,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
-		return 0;
+		return bpf_diag_record_branch(env, *insn_idx, false);
 	}
 
 	/* Push scalar registers sharing same ID to jump history,
@@ -16182,6 +16185,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	other_branch_regs[insn->dst_reg] = env->true_reg1;
 	if (BPF_SRC(insn->code) == BPF_X)
 		other_branch_regs[insn->src_reg] = env->true_reg2;
+	err = bpf_diag_record_branch(env, *insn_idx, false);
+	if (err)
+		return err;
 
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
@@ -17437,6 +17443,10 @@ static int do_check(struct bpf_verifier_env *env)
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
 
+		err = bpf_diag_error(env);
+		if (err)
+			return err;
+
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -17547,6 +17557,12 @@ static int do_check(struct bpf_verifier_env *env)
 			goto process_bpf_exit;
 
 		err = do_check_insn(env, &do_print_state);
+		if (err >= 0) {
+			int diag_err = bpf_diag_error(env);
+
+			if (diag_err)
+				return diag_err;
+		}
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
@@ -17604,7 +17620,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 	}
 
-	return 0;
+	return bpf_diag_error(env);
 }
 
 static int find_btf_percpu_datasec(struct btf *btf)
-- 
2.53.0

