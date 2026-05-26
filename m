Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A13ACF15
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824259; cv=none; b=nTjYpwR4CHxi1LxXLfEbNdcSMKZ+JzSqmBJNQKjFpzgb+eGT8VZ4/Y8FCaH8PiHpRNoTzxWh2/WudqEkJ14qghdOHVR738kEIGPKhN7adYmR3LyZ9m02hj0FnvGgDox5h+I7nS8FV4dLDPkSf+gocFYkeFOeADgRqIWUqEr4iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824259; c=relaxed/simple;
	bh=iJS7ojukI/JPybk25WQ4Mzg6FELELVbt1Ri52W0PAVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubqQXd3nLB03bWmzjidrULA0Ymfhuw6FBvP3Ubqwr5F8HdjqK6/Rro3oB1wVEbyswli4Be8JqN3JYtA6vMPD0v4Fc6Fk6t8W0E4ah4QCMa49FqzGWheuQDYSdSuhhrAZODQx7gx9EIB/aQSK8KyM9YTriPhai1vx11o3RK9eO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EORpC7L1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EORpC7L1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so2870023a91.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779824257; x=1780429057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeAMxyCOlQSb5Ht7uA27Gi2g/itFzY5gixplaTQXGIE=;
        b=EORpC7L1j+DmMdw0SfVUPEP1C6HmrGe+h93WyRr81KX+DSte/jEXH30lCX0HXWWAQk
         /p+BGlHkzVCRxvPWg3C9mdM3GC/JhCQlAakLG1Nd3+DUm0EQpO/oF/SJcyBj9EH3oEkO
         HXTxkWdCNHRv/m4zBcyBxjVH1yMxvVjI9UgsIbsQ0uLwP5+8FriOfm3A9w4zH5Ip7E8R
         jIxoTDX/2L2rv6eckx9PqVncFKc9EC+6/ajR3jNowPPMwgH/CoisodircjFiK3W9vJ6e
         DLLLmr7fjW31RNFR3i5zGs2FduhWuJcs2nLjGd/rdD+h31MbSSf38xyUwiIPVVv1Zupp
         J9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824257; x=1780429057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MeAMxyCOlQSb5Ht7uA27Gi2g/itFzY5gixplaTQXGIE=;
        b=l2yZwzBWpMFSKXx9pbVoF6CQneHkt/4zQGiJL6M6Njm458sZzofMq7Vhrmbc1KtSQq
         vXbq5H0fuPnfiDQxfUVV6wGdiCI1rbd3YW7o4BTDKve2M6g0eqca43mUeRp/mxrCW2zJ
         ofp8fN3ZDZKuWjNzpLVJfSItQu0nfBIctkv6VYIbPaTZDjk3TD1RCghfX3CSOMbPnLxN
         JLONOprNpcG9NfBaerkteUwtTRlVwgswaMI6VigcfCyxGcDzKNLI5ynJGQcfdIfAKOoF
         CHzi86la5yh9y9TT12Mhm8GugUvsfs56do3J0cFi/C2ZJiqfuOhrJ+CpCzpQoFzbQMkU
         pdkQ==
X-Gm-Message-State: AOJu0Yx8YPlCrbmgQ5fPjQI3m21Vx+1RV+i5AAj7Q37RWrA2gmZe0E6A
	iGWKarSvEdQ+Xq1bhqocwP0qXQa/iCEQmfmAdFdr9t51/BOCL+FW/1LjmBRp1Fks87I=
X-Gm-Gg: Acq92OG1Q8qgS/WB1ll+NnByrWnu6joGAGzb5ixCDuIixv/5mEH7aMW6H8uWKzP/RzX
	NqsP+FEPyuGAayXf54PQQcdSXYz+z5V/fv5wWly2VL6+lOx5czQcxK9QXq7XiNMauo9zrSEUQ3y
	j/4wQixJxwBdVC+WctS3jXZTM/S3EZ3AEl5ttJirK8/3rECLDlq903UedBKx/u0uK+kYzMNuEt8
	DvWgyJcR3XuZF4q2/43DwcWoEmUt/18Y8ROYoboJ2LLYJ0neJfcOduxQFNcuMLCXsXoK0FBPmWv
	9lGSTmHn5eIXGWYpabpf9zHvSSKCiJE1RL80JmFESrTOX5Fbvhw0ubqecKp/I7HWCDKw8Reyaug
	4Juovb4s979aZ8Yp7bYvIvHssbxpUpEJkZ8blRsbGMgoVz8t4MhRcbIZ17VDquULlCv0BLOxb/S
	EEaDYfTXPYuqfmjZPmYg8xmzKkb2AEehaMHCkoeKwPYuoTjcHqkI1sURAiT6pp/5gKvgRWq6t8o
	HbcEg==
X-Received: by 2002:a17:90b:2f8e:b0:366:1172:597e with SMTP id 98e67ed59e1d1-36a67472642mr18132451a91.9.1779824257025;
        Tue, 26 May 2026 12:37:37 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm12617283a91.15.2026.05.26.12.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:37:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH RFC bpf-next v2 4/6] bpf: report hot simulated callchains when 1M instructions limit is met
Date: Tue, 26 May 2026 12:37:18 -0700
Message-ID: <20260526-better-1m-reporting-v2-4-e7ec61c45d41@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
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
index 2b3584712ad2..54b7ad65b7fc 100644
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
+	struct bpf_callchain cc = {};
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
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
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
+			verbose(env, "  subprog#%td/%d", sub - env->subprog_info, insn_idx);
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
+		verbose(env, "subprog#%td:\n", sub - env->subprog_info);
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
+	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS + 2) = {};
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
2.54.0
