Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388B3B47D0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776389; cv=none; b=ne9WG+15EvRnsxywcvLzkQbmY8tcSwltAeuTroco50kfVhuhXl/f0Nrdz8U+GdgoLx5zb43eJ4pKZR+70ngaVnjruuzeN/IX4rPKm2kbOv+y+wZKbMVHG23EBQTlNPZA//Yr7B6hHVZPESa1cpD/y2JrY/UcJuNXtLhrP2pwerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776389; c=relaxed/simple;
	bh=kwOJqVkKkALiY4nkxeREfhsGl9+wapPrte6z8v02NXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hut9s8zob3h4bCj/Mm50XKw7JXRs03Ldy12oDDl2aPq9IO+Z/m7bsZmA7h5QpwgbfbsvFFMLOK+uV6b9R2siqBkzzIcxuL7wHjYjF1jawYhRyQKzrecvcx2oH4jA8oci7Pnv4tM6wBubXLJ3435CdH7mDprWu/Zz+8+w6LWJSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxYI7jBo; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxYI7jBo"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso4055715e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776378; x=1787381178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IA/JGVRZLBz7dEDt4N2UuAWhUpBmc7eJQE9nGE6Rxo=;
        b=AxYI7jBo5E5kcRvTu3lC/mSq9EL8fekXTzX3yYhaXS7jFguJtNOethY42zBvHOIDZB
         SPrssmTOG2GTNOdsZTiL6cM0va9P5unp8ypdi48PEQqLlyhT8PhKiDzKGfNHazY374gx
         AM/ISvSnwiIdpqf2x9FjxhdZXSMsjWDj5E4TKCya0ybK6xf1f3rKazsZ9Hqw3/wObx2Q
         XF0nWjt+NDhr9C5QKE3z/5oKovBpi0oenjEY3at9Rs01OTQe7CHKW29rYo5ckvEWF+j6
         Ze2tZocQNHySf/64LYfAXj75RAvYtk0tKlo6YWEEmaLx9wd9v7xVsMaX7EfGHeFKNw3n
         OeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776378; x=1787381178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+IA/JGVRZLBz7dEDt4N2UuAWhUpBmc7eJQE9nGE6Rxo=;
        b=ICcvLDC5F52YY9NzLuJ4HWW28+I6Y8I6IB/tOl6gXAUgTIsMQgQdeUuWpzyyi7ciZQ
         FotAQ53HQrr4M6TqEs0F/KPrtVw5BcZN11Gf8ujkHj650ATRCqpL2AoGYkWA/f0w26AM
         gdcX23qqEeIas1bzuK3J9XnieyiytcCFs1FssMpXTONm+CLNnK6LYYK4a935nTh7advZ
         TBO8TonxsC/3JAtbHB3IsWiksbvPEY/3jlP3VLJOH1hHe3HNAMDJUlqIloesA5u8RGKt
         oKPsoHeUnWmT5Rsb7SktF6VJyrUp3o0U2rsV18aTOvYOvz9e2aK/TyMCo5IFoep+YwSv
         AQpw==
X-Gm-Message-State: AOJu0Yxe6BpAYmMN6D+o2mHBxlcpSeKfQESDK4c0fYxFhaReC4AJzQgG
	RRG3gw7NnztA542OXbGpC/iafFAP3Ki1WZJqRkK7oIZe3vZeVzvQsxyFOfqAZSwZ
X-Gm-Gg: AR+sD12dRGLNBRJPdxbvrSxXti74FG8d29ov5c27yoPFsxEcIJJTBTz/S5Lq4lUGhIi
	R4hUT0TY8stb34f51KJ8gz3pzGJMtT6VYnQx/zayPfGyLb1IfphtJZESNnIxhNcg7RDQ+rUf7NP
	9Qry9k8PpXY13MEQHgkKxuaKHEGeXBMMxJOnU0omnvo/u3735aBGvoPMvsWOcqrWO9DVrI/9BaD
	qy8XpceSQb2SoyIiEwUkN/g/Yv/2uEsmvPLkxOlk+VuJqOayIZAkP1GCeRSd0x0z2PgBOgV1/Om
	eK1LlWlNOGreimVFm3Pgt/+MwOB9vzFf7s6qrWm+5a9ToVORwk4hEZBC2QYHPbip8hVn9VY+2Eg
	o+y4JtvP0hTqt76pKilN/QCJ8cl5Qi/hrC7B9SRC81SmZSEdV+qIEuFi9FcZZ5oWCPC0Z00AC8+
	caaau+Eu6MbySCoR4YXJf+Z09gQbJ/ybuHf62c79pYXAXoCLzzMGJaB75DDq6XjrhBBAkLDVB0E
	Fz3W+d/ot7Sjvaxu+8GFFEtmxnmJBxyl/gZlAdd+Qw294il3yUo+199MliIzXeXiSweCLk1DHv5
	BT3b17xG2MFBTuW6qA5kmXlQ678=
X-Received: by 2002:a05:6000:2086:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-481607301c9mr16926188f8f.4.1786776378257;
        Fri, 14 Aug 2026 23:46:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005b0sm15564277f8f.8.2026.08.14.23.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 03/14] bpf: Add verifier diagnostic event log
Date: Sat, 15 Aug 2026 08:45:58 +0200
Message-ID: <20260815064612.378577-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7580; i=memxor@gmail.com; h=from:subject; bh=kwOJqVkKkALiY4nkxeREfhsGl9+wapPrte6z8v02NXU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy8v9u7XuLVXjvOR5znVRKmoxyUmbYz87r8rK+xvcm b+6vrWjlIVBjItBVkyRpeT/PibjE5W/A22XccPMYWUCGcLAxSkAEzmhxchwX0f91pedzc3dIr7+ P56///tX5vIJ9VihNc6VK+o/XJb+zvDPvnnFe6Y/C07VMIh38909xLfcrfZ/3TYrk80PlEoi5j5 jBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an environment-owned diagnostic history for verifier reports. Event
payloads keep the user-facing branch history shape, while storage lives
in bpf_verifier_env and follows the active verifier path.

Grow the event array geometrically up to a 64 MiB limit. Once storage
reaches the limit, or an allocation fails, overwrite the oldest event so
diagnostics retain the newest useful suffix without adding per-event
metadata.

Represent saved positions as absolute logical sequence numbers. A restore
truncates to a retained position. If its prefix has already been evicted,
clear the abandoned suffix and preserve the missing-history position. This
keeps marks stable across rotation without increasing their size.

Add the branch event renderer and branch recording.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 130 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |   3 +
 kernel/bpf/verifier.c    |  21 +++++++
 3 files changed, 154 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 815aa7938b50..8f21b46adeca 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -22,8 +22,24 @@
 #define BPF_DIAG_TAB_WIDTH 8
 #define BPF_DIAG_FMT_CHUNK_SIZE (PAGE_SIZE - sizeof(struct diag_fmt_chunk))
 #define BPF_DIAG_FMT_BUF_SIZE 256
+#define BPF_DIAG_EVENT_LOG_MAX_SIZE (64U << 20)
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
@@ -46,12 +62,23 @@ struct diag_fmt_mark {
 	size_t len;
 };
 
+struct bpf_diag_log {
+	struct bpf_diag_history_event *events;
+	/* Sequence number of the oldest retained event on the active path. */
+	u64 first_seq;
+	u32 cnt;
+	u32 cap;
+	u32 head;
+	bool growth_failed;
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
@@ -191,6 +218,7 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 		return;
 
 	diag_fmt_restore(env, (struct diag_fmt_mark){});
+	kvfree(diag->log.events);
 	kfree(diag);
 	env->diag = NULL;
 }
@@ -207,6 +235,95 @@ static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 	va_end(args);
 }
 
+static u64 log_end(const struct bpf_diag_log *log)
+{
+	return log->first_seq + log->cnt;
+}
+
+static u32 log_pos(const struct bpf_diag_log *log, u32 idx)
+{
+	u32 pos = log->head + idx;
+
+	return pos < log->cap ? pos : pos - log->cap;
+}
+
+u64 bpf_diag_event_log_save(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = env->diag;
+
+	return diag ? log_end(&diag->log) : 0;
+}
+
+void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
+{
+	struct bpf_diag *diag = env->diag;
+	struct bpf_diag_log *log;
+	u64 end_seq;
+
+	if (!diag)
+		return;
+
+	log = &diag->log;
+	end_seq = log_end(log);
+	if (WARN_ON_ONCE(log_pos > end_seq))
+		log_pos = end_seq;
+
+	/*
+	 * A deep abandoned path may have rotated away the shared prefix. In
+	 * that case, restart with an empty retained suffix and remember that
+	 * every event before the restored mark is unavailable.
+	 */
+	if (log_pos <= log->first_seq) {
+		log->first_seq = log_pos;
+		log->head = 0;
+		log->cnt = 0;
+		return;
+	}
+
+	log->cnt = log_pos - log->first_seq;
+}
+
+static void diag_append_history(struct bpf_verifier_env *env,
+				const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_history_event *events;
+	struct bpf_diag *diag = env->diag;
+	struct bpf_diag_log *log;
+	u32 cap, max_events;
+
+	if (!diag)
+		return;
+	log = &diag->log;
+
+	if (log->cnt < log->cap) {
+		log->events[log_pos(log, log->cnt++)] = *event;
+		return;
+	}
+
+	max_events = BPF_DIAG_EVENT_LOG_MAX_SIZE / sizeof(*events);
+	if (log->growth_failed || log->cap == max_events)
+		goto rotate;
+
+	cap = min(log->cap ? log->cap * 2 : 64, max_events);
+	events = kvrealloc(log->events, array_size(cap, sizeof(*events)), GFP_KERNEL_ACCOUNT);
+	if (!events) {
+		log->growth_failed = true;
+		goto rotate;
+	}
+	log->events = events;
+	log->cap = cap;
+	log->events[log->cnt++] = *event;
+	return;
+
+rotate:
+	if (log->cap) {
+		log->events[log->head++] = *event;
+		if (log->head == log->cap)
+			log->head = 0;
+	}
+	log->first_seq++;
+}
+
 static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
 					const char *next_prefix, const char *text)
 {
@@ -535,3 +652,16 @@ static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
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
index ba268b589ac9..6eda2fd65ee1 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -16,6 +16,9 @@ char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
 const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
 	__printf(2, 0);
 const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+u64 bpf_diag_event_log_save(struct bpf_verifier_env *env);
+void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos);
 void bpf_diag_free(struct bpf_verifier_env *env);
+void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f330230f8d5..60dcb87a2417 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17439,6 +17439,27 @@ static int do_check(struct bpf_verifier_env *env)
 
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

