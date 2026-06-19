Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AB3CF680
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902792; cv=none; b=U00/WW7qc9Phc6Exv5dakJPKl07pkIjqd+7J/Qi+1Ll+6Jze+ayl6J6cUQ0+NVCsHyEcg00Ia04LAziUZXFOa3yk+R8plS1m/c3oaLkRM+oR91gw+0glZDc0ood+2ca+xD7Lvw/LM9JQMk4FwQC0U2uxIZ/0qW/qzbsvqC1BGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902792; c=relaxed/simple;
	bh=h43eRvmuAyhh+YxvETfaM5TFQ/gZ9lr4lbml1prb9wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVgq3KZpKr/Dty8y08YfC27dEZwtq5akPt/zSkCh68x10QWQlARUrRKNWQQ9Hb3Ry5x//v3KhPpHsNJUJjqkII1D7JSYEeEw9oJyIw1Lt9cNgxR2IwNcW+Ke7fy1dpOn+1GWB8tIzRoSF9n3ygs3FAsZWxu42Bhj2S9um8VdFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdAhT3qt; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdAhT3qt"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-49222b6e871so20996885e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902779; x=1782507579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGbMAJpitenYLzx8bevKCWWVXjG4TeZIuZ3jcEQbhHo=;
        b=AdAhT3qtrHRfJfFkyUsIRedV+I/taYoZ97WIhgu1TvJrXjoopzohnq4aIogICs3biA
         YWkwbEjeqS7o/s2CxPU3vgXrgevj9jG0UGlLvtB4sMq6eMi3QKqNcFGq9i4TKX0N/PwS
         Xxd3MLjJGBpERYo8YvgL+EOlVRfSqc0zEdS/CwzLzvMeZ8FhCb75/LwJfaWmv77D/Skt
         drQunCtS9Zv+kiH8QM8lthTJsC2v6z7zCO7NZzq+gc57h3sSglAIoA43nZp7hjwSGf1u
         slrb2UZrG0y4Hu9Pxo6AWKPERru1cVnuINwl6dVeCUBedHdaeP8kyEmBgaiF0yUdmirs
         CU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902779; x=1782507579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGbMAJpitenYLzx8bevKCWWVXjG4TeZIuZ3jcEQbhHo=;
        b=aD41S8bVn8YVIJheIlh+DIdMCveASxzXajw9eCejXLScA7D3mZmMLKvYlr/2LXd2cc
         5pKHTUY8LHuk8kcuiAxYur3oMcmrUbcgkKLRu3Lop+MTnfiayimRx46kTR2m2sdpJF4N
         P8bMTRNgaR9kAIFNS+MoSU/HlVYL/61RYUeNUXUWO1LkpxgS5kacWUjfzukvAOgrPTYv
         Fxr0+s5o7wyO2s4H2+Zw31P0MiL1Za643C3bUXhtLQLMlES+/cbhUC4noQdsjyvpvwEG
         XJ8FfxcjyuW01lJ/cVDnTIS2gaQQJ2WIakHUbd+xEX0ALHYUbB3lyhe+d8uus2sIq8SM
         Djug==
X-Gm-Message-State: AOJu0YwA2SFIW2cRZt+Wkg9Ggdbn9zux9+cQtbVdHsT04bFoXKEAI2bB
	YCQ5IrUBKoTew57eTSGAtBrJvSBFdWJX9B5aobBx/3SnxjmTnFh5SdRMfwtcujCa
X-Gm-Gg: AfdE7cnIfa77i3cTeOjhU0lCvYR4F4zaODneoaGfVMPUsEVId42UOrrWMQdJlJvP7YB
	HrphACdZZN/XLZcQ00hNvHpZs97oe3Wdr6TrkR2ITWxL4KEhWHKteRBvvmtm4ur+Ag1oLnttg2/
	kzM0mNOnDfx391ECxc7KE0sTrZsotv48yVUUGR6YgoK6rXXKgP7HGJZXKv7ZyhAwGgKjINAhpaU
	Wxs6Vt+61hao1bmjBZnU2nop+4+F8+JFIB5aF4bPgF1xwiiJJIQxYsKqQJUzsig84grSg4DRYKd
	40SU0+Nth9RcwrOnqSYx1dJjSvCS4M0XUpaDep6vziXwg+qntLRJmJpVpJRPkL4rEFJKuzPRarL
	nlg71Xb6nGAte7vkGH0cDK9FU4Zo52CqkRiqzX5LuSE9mS/nlN7v7VL9BfY3k01dW9IC+mi157I
	UtbsSLDpV14Uo2OHkHEfnwxJS2Rjhjmro4g1qPEsJOJhg8L5zAhNjzGdVocy2YCRdB2lD52WtXR
	B2wX3jf2KcT9mZN2uKqZFiCTDDvsSieUzpZb8ZvlPxSegCh/iOGVsw=
X-Received: by 2002:a05:600c:3e83:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492423140e0mr86406815e9.5.1781902779255;
        Fri, 19 Jun 2026 13:59:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57ba0sm1960665f8f.32.2026.06.19.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/17] bpf: Add verifier diagnostic event log
Date: Fri, 19 Jun 2026 22:59:16 +0200
Message-ID: <20260619205934.1312876-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10779; i=memxor@gmail.com; h=from:subject; bh=h43eRvmuAyhh+YxvETfaM5TFQ/gZ9lr4lbml1prb9wA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05d/EC/n/s5dUTVVym7NfbU3l2SOtf750+e72uDPly nMhxmjljlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkiiPDfxd+RzORRb/7Stjn frtcwhVUd36DZ6zAzH0dLmEfl3UudmD4p2K1M04wzHhK16KSqR6LTI9fWiY4o4u75+aCxcl2xfU H+AE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an environment-owned diagnostic history for verifier reports. Event
payloads keep the user-facing branch history shape, but storage lives in
bpf_verifier_env instead of verifier states so explored states do not copy
diagnostic buffers.

Grow the event array as entries are appended and keep saved positions as array
indices. Later patches can truncate back to those positions when verifier
search backtracks. Add the branch event renderer now, while leaving branch
recording to the follow-up patch that wires active-path pruning.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 182 +++++++++++++++++++++++++++++++++------
 kernel/bpf/diagnostics.h |  19 ++++
 2 files changed, 174 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 534a7bc58781..fa5a25b314a0 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -69,6 +69,12 @@ struct bpf_diag_insn_ctx {
 	struct bpf_diag_insn_buf buf;
 };
 
+struct bpf_diag_log {
+	struct bpf_diag_history_event *events;
+	u32 cnt;
+	u32 cap;
+};
+
 struct bpf_diag_scratch {
 	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
 	struct bpf_diag_source source;
@@ -77,6 +83,7 @@ struct bpf_diag_scratch {
 };
 
 struct bpf_diag {
+	struct bpf_diag_log log;
 	struct bpf_diag_scratch scratch;
 };
 
@@ -155,6 +162,51 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
 	return buf;
 }
 
+static void bpf_diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
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
+static struct bpf_diag_log *bpf_diag_event_log(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = bpf_diag_env(env);
+
+	return diag ? &diag->log : NULL;
+}
+
+u64 bpf_diag_event_log_pos(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = bpf_diag_env(env);
+
+	if (!diag)
+		return 0;
+	return diag->log.cnt;
+}
+
+void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u64 pos)
+{
+	struct bpf_diag *diag = env->diag;
+	struct bpf_diag_log *log;
+	u64 end;
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
@@ -162,21 +214,46 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 	if (!diag)
 		return;
 
+	kfree(diag->log.events);
 	kfree(diag);
 	env->diag = NULL;
 }
 
-static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
+static const struct bpf_diag_history_event *
+bpf_diag_history_event(const struct bpf_diag_log *log, u32 idx)
 {
-	va_list args;
+	return &log->events[idx];
+}
 
-	if (!bpf_diag_enabled(env))
+static void bpf_diag_append_history(struct bpf_verifier_env *env,
+				    const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_history_event *events;
+	struct bpf_diag_log *log;
+	u32 cap;
+
+	log = bpf_diag_event_log(env);
+	if (!log)
 		return;
 
-	va_start(args, fmt);
-	bpf_verifier_vlog(&env->log, fmt, args);
-	va_end(args);
+	if (log->cnt < log->cap) {
+		log->events[log->cnt++] = *event;
+		return;
+	}
+
+	cap = log->cap ? log->cap * 2 : 64;
+	if (cap < log->cap)
+		return;
+
+	events = krealloc_array(log->events, cap, sizeof(*events),
+				GFP_KERNEL_ACCOUNT);
+	if (!events)
+		return;
+	log->events = events;
+	log->cap = cap;
+	log->events[log->cnt++] = *event;
 }
+
 static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
 					    const char *first_prefix,
 					    const char *next_prefix,
@@ -203,7 +280,7 @@ static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
 		    last_space > 0)
 			len = last_space;
 
-		bpf_diag_log(env, "%s%.*s\n", prefix, len, line);
+		bpf_diag_write(env, "%s%.*s\n", prefix, len, line);
 
 		text = line + len;
 		while (*text == ' ')
@@ -232,8 +309,8 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 
 	buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
 	if (!buf) {
-		bpf_diag_log(env, "%s<failed to allocate diagnostic text>\n",
-			     BPF_DIAG_TEXT_INDENT);
+		bpf_diag_write(env, "%s<failed to allocate diagnostic text>\n",
+			       BPF_DIAG_TEXT_INDENT);
 		return;
 	}
 
@@ -513,13 +590,14 @@ static void bpf_diag_print_source_insn_line(struct bpf_verifier_env *env,
 				    source_prefix, source_line_width,
 				    line->line_num, line->line);
 
-	bpf_diag_log(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
-		     source_lane, BPF_DIAG_COLUMN_GAP, "");
+	bpf_diag_write(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
+		       source_lane, BPF_DIAG_COLUMN_GAP, "");
 	if (diag_insn->valid)
-		bpf_diag_log(env, "%s%*d | %s",
-			     diag_insn->idx == focus_insn_idx ? ">>> " : "    ",
-			     insn_width, diag_insn->idx, diag_insn->text);
-	bpf_diag_log(env, "\n");
+		bpf_diag_write(env, "%s%*d | %s",
+			       diag_insn->idx == focus_insn_idx ?
+			       ">>> " : "    ", insn_width, diag_insn->idx,
+			       diag_insn->text);
+	bpf_diag_write(env, "\n");
 }
 
 void bpf_diag_report_header(struct bpf_verifier_env *env,
@@ -534,13 +612,13 @@ void bpf_diag_report_header(struct bpf_verifier_env *env,
 	problem = problem ?: "";
 
 	if (!problem[0]) {
-		bpf_diag_log(env, "\nVerification failed: %s\n", category);
+		bpf_diag_write(env, "\nVerification failed: %s\n", category);
 		return;
 	}
 
 	first = toupper(problem[0]);
-	bpf_diag_log(env, "\nVerification failed: %s: %c%s\n", category,
-		     first, problem + 1);
+	bpf_diag_write(env, "\nVerification failed: %s: %c%s\n", category,
+		       first, problem + 1);
 }
 
 static void bpf_diag_report_reason(struct bpf_verifier_env *env,
@@ -554,7 +632,7 @@ static void bpf_diag_report_section(struct bpf_verifier_env *env,
 	if (!bpf_diag_enabled(env))
 		return;
 
-	bpf_diag_log(env, "\n%s:\n", title);
+	bpf_diag_write(env, "\n%s:\n", title);
 }
 
 static void bpf_diag_report_reason(struct bpf_verifier_env *env,
@@ -585,7 +663,7 @@ static void bpf_diag_report_suggestion(struct bpf_verifier_env *env,
 	va_start(args, fmt);
 	bpf_diag_vprint_indented(env, fmt, args);
 	va_end(args);
-	bpf_diag_log(env, "\n");
+	bpf_diag_write(env, "\n");
 }
 
 static void bpf_diag_print_source_annotation(struct bpf_verifier_env *env,
@@ -610,8 +688,8 @@ static void bpf_diag_print_source_annotation(struct bpf_verifier_env *env,
 			     line_width - 8));
 	text = kasprintf(GFP_KERNEL_ACCOUNT, "%s: %s", label, msg);
 	if (!text) {
-		bpf_diag_log(env, "  %*s | %*s^-- %s\n",
-			     line_width + 4, "", indent, "", label);
+		bpf_diag_write(env, "  %*s | %*s^-- %s\n",
+			       line_width + 4, "", indent, "", label);
 		return;
 	}
 
@@ -660,18 +738,18 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 	memset(diag_insn, 0, sizeof(scratch->insns));
 
 	if (!bpf_diag_get_source(env, insn_idx, src)) {
-		bpf_diag_log(env, "  insn %u\n", insn_idx);
+		bpf_diag_write(env, "  insn %u\n", insn_idx);
 		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
 		goto out_free_msg;
 	}
 
 	func = bpf_diag_func_name(env, insn_idx);
 	if (func && *func)
-		bpf_diag_log(env, "  %s @ %s:%d:%d\n", func, src->file,
-			     src->line_num, src->line_col);
+		bpf_diag_write(env, "  %s @ %s:%d:%d\n", func, src->file,
+			       src->line_num, src->line_col);
 	else
-		bpf_diag_log(env, "  %s:%d:%d\n", src->file, src->line_num,
-			     src->line_col);
+		bpf_diag_write(env, "  %s:%d:%d\n", src->file, src->line_num,
+			       src->line_col);
 
 	start_line = src->line_num - BPF_DIAG_SOURCE_CONTEXT;
 	end_line = src->line_num + BPF_DIAG_SOURCE_CONTEXT;
@@ -704,3 +782,53 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 out_free_msg:
 	kfree(msg);
 }
+
+void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
+			    bool cond_true)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_BRANCH,
+		.branch.cond_true = cond_true,
+	};
+
+	bpf_diag_append_history(env, &event);
+}
+
+void bpf_diag_print_history(struct bpf_verifier_env *env)
+{
+	const struct bpf_diag_history_event *event;
+	const struct bpf_diag_log *log;
+	bool printed = false;
+	u32 i;
+
+	bpf_diag_report_section(env, "Causal path");
+
+	if (!env->diag) {
+		bpf_diag_write(env, "  no recorded diagnostic events on this path\n");
+		return;
+	}
+	log = &env->diag->log;
+
+	for (i = 0; i < log->cnt; i++) {
+		event = bpf_diag_history_event(log, i);
+
+		switch (event->kind) {
+		case BPF_DIAG_HISTORY_BRANCH:
+			bpf_diag_report_source(env, event->insn_idx, "branch",
+					       "explored as %s, goto %s",
+					       event->branch.cond_true ? "true" :
+					       "false",
+					       event->branch.cond_true ? "followed" :
+					       "not followed");
+			printed = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!printed)
+		bpf_diag_write(env,
+			       "  no retained diagnostic events on this path\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 7f1380508789..4bc44be757c4 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -9,6 +9,20 @@
 
 struct bpf_verifier_env;
 
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
+enum bpf_diag_history_kind {
+	BPF_DIAG_HISTORY_BRANCH,
+};
+
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 char *bpf_diag_scratch_buf(struct bpf_verifier_env *env,
 			   unsigned int slot, size_t *size);
@@ -19,11 +33,16 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
 				    unsigned int slot,
 				    const char *fmt, ...)
 	__printf(3, 4);
+u64 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
+void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u64 pos);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    const char *category, const char *problem);
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 			    const char *label, const char *fmt, ...)
 	__printf(4, 5);
+void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
+			    bool cond_true);
+void bpf_diag_print_history(struct bpf_verifier_env *env);
 
 #endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0

