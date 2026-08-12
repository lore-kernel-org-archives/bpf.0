Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD042AFA2
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577617; cv=none; b=E1Xd0fer2OGF2lcXz+LeGLCahqb6hDsKrgcjVNbg3Kpdpx1X4sES27f5bYM4Vw9VfQ6+C0IfXP7nE8wrsVQgkocjSrcdNcex+jBWnVmoWkeOYdyiuKVwKGIn6jz1a42Yr87V8jmMAeJrLPClSzHaoYv03ERkJqmuCw5N23eoAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577617; c=relaxed/simple;
	bh=BNiJRKILfFvDT/GagPPuKIYdeBCrK7gAH1AeQ4lFW18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4u8fU7Zotfj2SHQipYxChazI+mKMDvdiVQmDRu35CSiNLatXi21JHM5dtEhhQBQxokU4y6EbSwt1eSwHdOWNTZkC50d517fjl+SM+fm8KKJ2Q0GTveV3n1WHxQaVouFNoAYNutv8b6+4OwPH02EQXIUpDmcmkecP3xEItFjUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVQv4ojv; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVQv4ojv"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso30027f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577613; x=1787182413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZHOrzj5oS9Sqvykv5M20Ct6bzz1ad0X498Ccqvz0ec=;
        b=WVQv4ojvQUtwFzk+6chhwj2xQOUgnMUet2OI0jYD1ZFEcjypIFxZrvLtUBkUSs5Vnn
         vgIEBt6xiimoNiuVvp6wcquNrIHsn0MN8NMIJEGEQfZSQdb7bzqLwM8WsNSLLHV2qOLF
         pgH/58rd29/zCaLGTmohDUG84wgEnjeeSTxu1BJyydAJA9fU90CwZhI3tf4B0KISTelQ
         nqpa85NTYxlozA9JuG2xiMIDuVgXcgeYTKo7rdh5gJoeYNPmh04i6AuXWNPHc2R9MgEW
         FWnBlu4AKo4nh84NzNK8fNALJpouQn5ioh0wxlBGrGNmzvjKp/FVhCyHOjFhZ0F722dJ
         0emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577613; x=1787182413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZHOrzj5oS9Sqvykv5M20Ct6bzz1ad0X498Ccqvz0ec=;
        b=fCAUq+V9YpzWcY89podC25AQeYjYULwLnA7M28GvthvqMImbUc37eC1KkYAQZbYRMP
         Bo3TyFzS/7aoG+TrnquevFX3bVpKI+U2PzA03W+kQ1fowPL2tmDlBNNqDRi0wImkD2ze
         m+j11h7sx6TXTO4IcP2q3xjnuS3oEc7jV4pSc7Uyv7X4aESf9Dt0F/EgQHg4hG23PyvL
         qMoTPsu/1PSFOC7b1bt+Se2O+KrOtoUbv96PizLlceQq3MdVwG+3PI5bnj/WJy0Act3S
         zy/OCL0BT5a51/vRmnotYjU9Sr0dC+eJmJYJ81O2T1bXi3BVGqgpMNwKXLzBVVsnAHBd
         nWFg==
X-Gm-Message-State: AOJu0Yz25fyfZtlHvju8nlvYH8XKKHycPgB6XR0OCqaQ75ZVKJFGX3o3
	JFFgVylt9Dmi/l63N7LYF3nqSAyXAIe+B7dVXm1aot82hBALaaq8bjmxCyBSdA5F
X-Gm-Gg: AR+sD11wYoNBfpXzB9puQjk+SVC+Mo+wPUack86yL56SczMLBUZb+thjFF//EE0PQuY
	6if3ZXZtK0BRICMALsftpclbRq9HtNRuiaNui1Wwfr+Fau+3zxAVEVxFCEorhCBFRgiO0GYOHGB
	RpO4wiMWLdrMyroNTjQ8hTM5lG8IZYvr76Sqo6pNPexWsweJhMa12xJ8rpoO5gUKHq2tfSZZlup
	IzWxySpdNRpI86QBvx3rPvfQhXLQVXdGCvXO35iWeu/A7D+Pa2kk1OEP7I/h9gkjD70aecYbSV/
	1ri3KpHrmIh6aw2mI/y6r5iJbBIgZTE22JlUMnwJcni5upW2+3GMWL10I36Q7hOXxfYSv3DXisa
	g61PoEpWwR0Ra0QOFnaZJLln6YvEVtM9Z00t/7iZcXeBRKMEWMtR/sj4h7UTISyB3MLz+mOC29g
	CnoktNOtBfMhjqafGHpwdzwghXeeJtGZy/4dB8sXHGsQ+hcq4cW8SvAAOTzPEsETEfiVNJWKkbB
	ZiRbCPxzv0OzO10Kyrpmz8vQKtIAW/ZOO4vvRalnmbaZEi1RAzthxgvq9B/wFKCuvVxN3mlC61D
	c+0b4ll9+PkSxUqziBZhIEPD5tA=
X-Received: by 2002:a05:6000:65b:b0:47f:b622:fcd2 with SMTP id ffacd0b85a97d-4815a045264mr1559983f8f.25.1786577613407;
        Wed, 12 Aug 2026 16:33:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2769sm1198753f8f.36.2026.08.12.16.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/16] bpf: Add verifier diagnostic event log
Date: Thu, 13 Aug 2026 01:33:06 +0200
Message-ID: <20260812233326.3575958-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6732; i=memxor@gmail.com; h=from:subject; bh=BNiJRKILfFvDT/GagPPuKIYdeBCrK7gAH1AeQ4lFW18=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQUulK+WGoPjbZiW9haU2Ksb91lb9t7XPG71ef/JCh 1FWz6KOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATMS6hJHhmHNn1zk+R893Qrfn 3LZkaUydMcFnoYX2p4uLvjCs3fJSgpHhkcuilcIPYh/2di7YljJTr0JkZ/Sp5c6CxhOefZ69bVM 1MwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an environment-owned diagnostic history for verifier reports. Event
payloads keep the user-facing branch history shape, while storage lives
in bpf_verifier_env and follows the active verifier path.

Grow the event array as entries are appended and keep saved positions as
array indices. Later patches can truncate back to those positions when
verifier search backtracks. Add the branch event renderer and branch
recording.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 108 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |   3 ++
 kernel/bpf/verifier.c    |  21 ++++++++
 3 files changed, 132 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 77dcffb9adee..0e0aa3a7106c 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -34,8 +34,24 @@
 #define BPF_DIAG_REG_TMP_LEN 192
 #define BPF_DIAG_FMT_CHUNK_SIZE 1024
 #define BPF_DIAG_FMT_BUF_SIZE 256
+#define BPF_DIAG_EVENT_LOG_MAX_SIZE (1U << 20)
 #define DISASM_LINE_LEN 160
 
+enum bpf_diag_history_kind {
+	BPF_DIAG_HISTORY_BRANCH,
+};
+
+struct bpf_diag_history_event {
+	u32 insn_idx : 24;
+	u32 kind : 8;
+	u8 in_lineage : 1;
+	union {
+		struct {
+			bool cond_true;
+		} branch;
+	};
+};
+
 struct disasm_line {
 	char text[DISASM_LINE_LEN];
 	int idx;
@@ -58,12 +74,21 @@ struct diag_fmt_mark {
 	size_t len;
 };
 
+struct bpf_diag_log {
+	struct bpf_diag_history_event *events;
+	u32 cnt;
+	u32 cap;
+	u32 dropped;
+	bool capped;
+};
+
 struct bpf_diag_scratch {
 	struct bpf_linfo_source source_lines[BPF_DIAG_CONTEXT_CNT];
 	struct disasm_line disasm_lines[BPF_DIAG_CONTEXT_CNT];
 };
 
 struct bpf_diag {
+	struct bpf_diag_log log;
 	struct bpf_diag_scratch scratch;
 	struct list_head fmt_chunks;
 };
@@ -229,6 +254,7 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 		return;
 
 	diag_fmt_free(env);
+	kvfree(diag->log.events);
 	kfree(diag);
 	env->diag = NULL;
 }
@@ -245,6 +271,75 @@ static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 	va_end(args);
 }
 
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
+static void diag_append_history(struct bpf_verifier_env *env,
+				const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_history_event *events;
+	struct bpf_diag_log *log;
+	u32 cap, max_events;
+
+	log = diag_event_log(env);
+	if (!log)
+		return;
+
+	if (log->cnt < log->cap) {
+		log->events[log->cnt++] = *event;
+		return;
+	}
+
+	max_events = BPF_DIAG_EVENT_LOG_MAX_SIZE / sizeof(*events);
+	if (log->capped || log->cap == max_events) {
+		if (log->dropped != U32_MAX)
+			log->dropped++;
+		return;
+	}
+
+	cap = min_t(u32, log->cap ? log->cap * 2 : 64, max_events);
+	events = kvrealloc(log->events, array_size(cap, sizeof(*events)), GFP_KERNEL_ACCOUNT);
+	if (!events) {
+		log->capped = true;
+		if (log->dropped != U32_MAX)
+			log->dropped++;
+		return;
+	}
+	log->events = events;
+	log->cap = cap;
+	log->events[log->cnt++] = *event;
+}
+
 static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
 					const char *next_prefix, const char *text)
 {
@@ -564,3 +659,16 @@ void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *lab
 out_restore:
 	diag_fmt_restore(env, mark);
 }
+
+void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_BRANCH,
+		.branch = {
+			.cond_true = cond_true,
+		},
+	};
+
+	diag_append_history(env, &event);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 7b391cf49ae5..9cc6b4747a06 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -15,10 +15,13 @@ char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
 const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
 	__printf(2, 0);
 const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
+void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
 void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
+void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6bc2ccf35971..6ca366ff5037 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17369,6 +17369,27 @@ static int do_check(struct bpf_verifier_env *env)
 
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
+		/*
+		 * Record the incoming edge so active and queued paths use the same
+		 * branch-recording path. A zero-offset conditional has identical
+		 * successors, so its outcome cannot be reconstructed from the edge.
+		 */
+		if (!state->speculative && prev_insn_idx >= 0 && prev_insn_idx < insn_cnt) {
+			struct bpf_insn *prev_insn = &insns[prev_insn_idx];
+			int fallthrough_idx = prev_insn_idx + 1;
+			int branch_idx = prev_insn_idx + bpf_jmp_offset(prev_insn) + 1;
+			u8 class = BPF_CLASS(prev_insn->code);
+			u8 opcode = BPF_OP(prev_insn->code);
+
+			if ((class == BPF_JMP || class == BPF_JMP32) &&
+			    opcode != BPF_JA && opcode != BPF_CALL && opcode != BPF_EXIT &&
+			    opcode <= BPF_JCOND && branch_idx != fallthrough_idx) {
+				if (env->insn_idx == branch_idx)
+					bpf_diag_record_branch(env, prev_insn_idx, true);
+				else if (env->insn_idx == fallthrough_idx)
+					bpf_diag_record_branch(env, prev_insn_idx, false);
+			}
+		}
 
 		if (bpf_is_prune_point(env, env->insn_idx)) {
 			err = bpf_is_state_visited(env, env->insn_idx);
-- 
2.53.0

