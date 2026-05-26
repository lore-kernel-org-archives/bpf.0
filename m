Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22A3D79E3
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787829; cv=none; b=aet51RQwr/Q18qRpDaVFnJmdQSyxFejwYZh+rzMQ/aIVrGeModquF83mmXKbpSqm+c3dkhC09URQpbbe3pZaQ4S6GIDzccFOn6mD5yLbkhOPlAhkc9PQbSrEVjfJoL3juJO/zq6c8bWKB2es6GdLgtxdTFlhoZVn7BP9RaIm9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787829; c=relaxed/simple;
	bh=9DZ433g2OsAG182AFD23mH4et7YZkFT32VnADyyGbQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouiJEXO2gYXpqlZ2dJDDLo1Ppu6YkSkOZ7MuARdX6ew5VBgs3iyIvF7l183khlJqd4j3tnzpEyYHjKIQjUgMa01MOc77+qvAj2eFRk2nP2JJpzgGQttLJ4poROc/JA8J2O/sbjBfCP53IQxfdJPUiS+X5jNG9x6cejRwWmMSHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heHehXYG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heHehXYG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so7238464b3a.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787827; x=1780392627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP043y1KtaoKz4JS1+oqw1HNS+vGpPmUIeusu51pbxs=;
        b=heHehXYGepeKqeKmQluG86jx9bB4+T7IwkXFTSJz1c2viMP085OzO5AC76t0Cscl8q
         WwZJdyk4Bk6RUYoTQqzwQGdzGNpS3KDckkDFTp6kdvI+d88dPdK8I8n9wzt3wptBaNxY
         HAJrBdldnoNTzpcIIZLcysgmMSTv2Vn7Anx+dxgblRIJbpIRJ5UUc42DT/xE3YD9Rvz7
         tVruclxtd9alRzwB5Z0GqZgwvrXQdRWNJf8crfYV24Na/gXjfiueUpFKJ3tpbW96TExo
         ejW4b55ZiYdZKxHokFVnXHk+ZklAtrX3sO4V4jNYLijxJ5zdDdiJC6GelfrtplMGcUCb
         Lm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787827; x=1780392627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jP043y1KtaoKz4JS1+oqw1HNS+vGpPmUIeusu51pbxs=;
        b=VQ8jUpP+qddjJr0Pbv0HMpabPzTHg3NB2OM4y9sbFHeFy4Qox7jkIyUgIIQ5gme9eM
         k+4eikZN33OQAEni9GfBIwrTMyBlt0YmFaBa5Z85XlAkrtPdFpgC6UXLxri/RMPlezft
         VNk63iY++g1nVlE1fPD1XW9EutdSBu9nkJ8Mq9/GZ573dIU+ZoaWsURVMFmTdg7ddZFJ
         esZBSaJe9tbReHm138lZeQiO/ZKgfs0kdjSR8W3KPFj7Vd9q+avB/8dgd0CXThzUf7hk
         SdeAdWqnq9lTkEoeLjk1md/KaHcszEAZNcNwgkakn0fu55QTWcYNA5PoWdlAtfvn/nIx
         u8AQ==
X-Gm-Message-State: AOJu0Yws65K7WqYQ7bmAc9p2ZUkAf2D7d6jZm+1xyO8LIV4tyKII6ldJ
	ROaOqiGTy4NYfhAO6c+aiIQVkAZDiJ8riVcUsvse1oEoSaGxNFo4/K/Pwsfzr94/7Is=
X-Gm-Gg: Acq92OHZ6agCxrRX42hYDjqonckobU5e3JIrdhZx9x3VfmNI65e8wn9Tpm9zKZUAnUt
	p0Mt3znxWV6sW/T07fZtwvPfteY/CqiEUhTZTkbrfpi2Imnb7fYBxPdEQENLAuPhXL84wx/+B+E
	2o1fNXMpuwQykEaQaO4xqW/cGUYzcrpHJK0gbiJBQxo4SoeJk6AC3R4ZvjoEY86KN3oW0d/BYbS
	Ph3dOjM7qeN3fyqJ/uK1z7WTCtn780/aaAl0AeEENc/8YF9+EP+TyghnvuCfotvjTU8RpFzSaPk
	X0SgQO2aKQEULxWoDxzhfPEPClugoCaYt4J2hHGsK3hmlR1ncwXyD1Tba4zmtfY/cwL38mfpPTH
	0bR0aClQGBMB44EGZPTbMDrsE0sfhGT5cmxmOWgIonwdWSLXF9qBktsklDOXPedSfAiiBwHcttR
	nOZrLOLURVU7Q0AWKmZXx4jI7KyI3UXZlCqxWXaJE/
X-Received: by 2002:a05:6a00:b8c:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-8415f5dcc06mr17481124b3a.29.1779787826957;
        Tue, 26 May 2026 02:30:26 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 4/6] bpf: report hot simulated callchains when 1M instructions limit is met
Date: Tue, 26 May 2026 02:30:05 -0700
Message-ID: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When the verifier exceeds the 1M instruction budget, the current error
output shows a random execution trace that happens to be active when
the limit is hit, which is not very helpful for debugging.

To rectify this, employ a profiler-inspired technique:
collect and count "callchain" stack traces that the verifier visits
during program validation and report the top 3 hot traces. Sample
callchains at instructions marked as force checkpoints and loop header
entries.

When 1M instructions is met, print a report containing:
- callchains verifier visited most often;
- disassembly of the subprograms referenced from the printed
  callchains.

Here is an example of the report:

  budget_nested_call_loop():
    ; asm volatile ("                                     \ @ verifier_budget_report.c:44
    0: (b7) r0 = 0
    1: (85) call pc+1
    2: (95) exit

  budget_nested_call_loop__inner():
    ; asm volatile ("                                     \ @ verifier_budget_report.c:54
    3: (b7) r0 = 0
    4: (07) r0 += 1
    5: (05) goto pc-2

  #1 most visited simulated stacktrace (visited 499999 times):
    budget_nested_call_loop/1 (.../verifier_budget_report.c:44)
    budget_nested_call_loop__inner/4 (.../verifier_budget_report.c:54)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  14 ++++
 kernel/bpf/verifier.c        | 155 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d0a1fb135cbf..347a155d8e21 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -9,6 +9,8 @@
 #include <linux/filter.h> /* for MAX_BPF_STACK */
 #include <linux/tnum.h>
 #include <linux/cnum.h>
+#include <linux/hashtable.h>
+#include <linux/jhash.h>
 
 /* Maximum variable offset umax_value permitted when resolving memory accesses.
  * In practice this is far bigger than any realistic pointer offset; this limit
@@ -660,6 +662,17 @@ struct bpf_loop {
 	bool irreducible;
 };
 
+struct bpf_callchain {
+	u32 insn_idx[MAX_CALL_FRAMES];
+	u32 curframe;
+};
+
+struct bpf_callchain_entry {
+	struct hlist_node node;
+	struct bpf_callchain cc;
+	u64 count;
+};
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -1043,6 +1056,7 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
+	DECLARE_HASHTABLE(callchain_htab, 8);
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b3584712ad2..8eb8f1ce17c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17247,6 +17247,152 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	return INSN_IDX_UPDATED;
 }
 
+static void compute_callchain(struct bpf_verifier_state *st, struct bpf_callchain *cc)
+{
+	int i;
+
+	cc->curframe = st->curframe;
+	for (i = 0; i <= st->curframe; i++)
+		cc->insn_idx[i] = bpf_frame_insn_idx(st, i);
+}
+
+static int update_callchain_profile(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_callchain_entry *entry;
+	struct bpf_callchain cc;
+	u32 hash;
+
+	compute_callchain(st, &cc);
+	hash = jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
+	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
+		if (entry->cc.curframe == cc.curframe &&
+		    !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curframe + 1) * sizeof(u32))) {
+			entry->count++;
+			return 0;
+		}
+	}
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->cc = cc;
+	entry->count = 1;
+	hash_add(env->callchain_htab, &entry->node, hash);
+	return 0;
+}
+
+static void free_callchain_profile(struct bpf_verifier_env *env)
+{
+	struct bpf_callchain_entry *entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	hash_for_each_safe(env->callchain_htab, bkt, tmp, entry, node) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+}
+
+static void print_callchain_entry(struct bpf_verifier_env *env,
+				  struct bpf_callchain_entry *entry, int idx)
+{
+	struct bpf_callchain *cc = &entry->cc;
+	const struct bpf_line_info *linfo;
+	struct bpf_subprog_info *sub;
+	int i, insn_idx;
+
+	verbose(env, "#%d most visited simulated stacktrace (visited %llu times):\n",
+		idx, entry->count);
+	for (i = 0; i <= cc->curframe; i++) {
+		insn_idx = cc->insn_idx[i];
+		sub = bpf_find_containing_subprog(env, insn_idx);
+		linfo = bpf_find_linfo(env->prog, insn_idx);
+		if (sub->name)
+			verbose(env, "  %s/%d", sub->name, insn_idx);
+		else
+			verbose(env, "  subprog#%ld/%d", sub - env->subprog_info, insn_idx);
+		if (linfo)
+			verbose(env, " (%s:%u)",
+				btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off),
+				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
+		verbose(env, "\n");
+	}
+}
+
+static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	u32 i, end = (sub + 1)->start;
+
+	if (sub->name)
+		verbose(env, "%s():\n", sub->name);
+	else
+		verbose(env, "subprog#%ld:\n", sub - env->subprog_info);
+	env->prev_linfo = NULL;
+	for (i = sub->start; i < end; i++) {
+		verbose_linfo(env, i, "  ; ");
+		verbose(env, "  %d: ", i);
+		bpf_verbose_insn(env, &env->prog->insnsi[i]);
+		if (bpf_is_ldimm64(&env->prog->insnsi[i]))
+			i++;
+	}
+}
+
+/*
+ * Print several most visited simulated stack traces,
+ * and a disasembly of related subprograms.
+ */
+static void print_hotspots(struct bpf_verifier_env *env)
+{
+	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) = {};
+	struct bpf_callchain_entry *top[3] = {};
+	struct bpf_callchain_entry *entry;
+	struct bpf_subprog_info *sub;
+	int i, j, bkt, nr_top = 0;
+
+	if (!(env->log.level & BPF_LOG_LEVEL))
+		return;
+
+	/* Collect the hottest callchains */
+	hash_for_each(env->callchain_htab, bkt, entry, node) {
+		for (i = 0; i < 3; i++) {
+			if (!top[i] || entry->count > top[i]->count) {
+				memmove(&top[i + 1], &top[i], (2 - i) * sizeof(top[0]));
+				top[i] = entry;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < 3 && top[i]; i++)
+		nr_top++;
+
+	if (!nr_top)
+		return;
+
+	if (!(env->log.level & BPF_LOG_LEVEL2))
+		bpf_vlog_reset(&env->log, 0);
+
+	/* Identify callchain subprograms and print disasm of those */
+	for (i = 0; i < nr_top; i++) {
+		struct bpf_callchain *cc = &top[i]->cc;
+
+		for (j = 0; j <= cc->curframe; j++) {
+			sub = bpf_find_containing_subprog(env, cc->insn_idx[j]);
+			__set_bit(sub - env->subprog_info, printed_subs);
+		}
+	}
+
+	for_each_set_bit(i, printed_subs, env->subprog_cnt) {
+		disasm_subprog(env, &env->subprog_info[i]);
+		verbose(env, "\n");
+	}
+
+	/* Print the hot callchains */
+	for (i = 0; i < nr_top; i++) {
+		print_callchain_entry(env, top[i], i + 1);
+		verbose(env, "\n");
+	}
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -17381,6 +17527,7 @@ static int do_check(struct bpf_verifier_env *env)
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
+			print_hotspots(env);
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
@@ -17390,6 +17537,12 @@ static int do_check(struct bpf_verifier_env *env)
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
 
+		if (bpf_is_force_checkpoint(env, env->insn_idx) || insn_aux->loop) {
+			err = update_callchain_profile(env, state);
+			if (err)
+				return err;
+		}
+
 		if (bpf_is_prune_point(env, env->insn_idx)) {
 			err = bpf_is_state_visited(env, env->insn_idx);
 			if (err < 0)
@@ -19673,6 +19826,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		return -ENOMEM;
 
 	env->bt.env = env;
+	hash_init(env->callchain_htab);
 
 	len = (*prog)->len;
 	env->insn_aux_data =
@@ -19945,6 +20099,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_clear_insn_aux_data(env, 0, env->prog->len);
 	vfree(env->insn_aux_data);
 err_free_env:
+	free_callchain_profile(env);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);

-- 
2.53.0
