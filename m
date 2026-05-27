Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719C3914EB
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867010; cv=none; b=g3z7B9vy+bXC/xy3MzPPWfr1I5O8sTbTwRF7ARXm6d+DKKKvVkXxOlM8LqaIBEGomphP3WE06ym/Q1PFcmGf9JFcYNCNOSk19VRDHnd6npPnJmWq1TsDoFBVKl4d1pVKdO1daUx1RnV5lngqtstSLPUMoN8JZB9PsiySvWiSdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867010; c=relaxed/simple;
	bh=qDsJzDDEcTL8L1hNY+bb5nLM0VWjtIOBZQZS4p0bk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE+ZtG/vcGmoVktuznfWJldt9RCgjIyJtasTYUEpnKI9bjhw+VGW6XPZuyLy0kRPWDv/wWdIKUxQabqnoOLeSBnCZSfzz3oaa2QAjLxfBwvy6onwN1tcYF8N4WtFUz0jUykKykz62qCbrGdOQOEC1FWMKDwQFc0WO2c5AZQzQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC4LvIdM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC4LvIdM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba6485d219so88004215ad.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867009; x=1780471809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwh7VybBvuZ7GLwmP84JffxrF1ekgF1ODLcd4+q9lsU=;
        b=kC4LvIdMmI6YN1A2ldln11WSsBOpQxcMT8W/enWDCpVcwDrFUGyvB74WSr8JDPAOmF
         P2qbaHhpH3rJjKeQAij5v3G/BD6bioV94zKOgmYQM5AtGhGVPaBOV20vRKkKN8O5Mt36
         KgXpsBEg8MLR/YURtspSEKSHAHbvnigSwiO88JgDdAY4Wwh7qX/ln0mUIxdujqySHp92
         P/nlO9l2gFvuLEY80DF1W9xW3JrTOf6mUkjw4Zd9YogkroXziVdujjCIideCaIiFnDB6
         6ZVNlBvj4OhumKFgt6Vc18QnVmSEJK7wu937lms72uvOWaze91pVZBYiq3fSiL36VDlP
         IOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867009; x=1780471809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lwh7VybBvuZ7GLwmP84JffxrF1ekgF1ODLcd4+q9lsU=;
        b=tLDWCvDwWd9N/adijLEkP5OSa5sEgUBjYAn4DWFkKNOQnzgrgQ7KvqqoyZy7Np7969
         xeiVqeEfRUt4XfywrVSH5Cas2x4JtK/m6TN7I+ySKu4lo9NH4IHIcAJg2BnsXPSUGAk8
         HyVQwJMSd7EgFRnxKHBjLdiRLxdjdLQTPQU6whlsEsI9pZL0Gpd8MLBkhNLHoL9vaT+J
         TdcFZzdw42v79aqRFA0Q9CVorZAHZM2eedBx4P8WEyqclLST4sNdrvUHurbhkiuJfCW7
         z6h5bMJjPMXm8pf4Qf4rWbXrOQx8VehKgoNy+po++H2a04nTcA3Lk05iTsY7y97RZ5Ev
         OMXA==
X-Gm-Message-State: AOJu0YyYZYiG9x3z9tYXtky/bksN8tXhM5RNQnrC2SlljU2UgKmTuJz2
	j1DWi1mHhCfXxgoZ1h9h2nn3fTPB0VFBB93r+AvFxqWMDotDc0nladdNkcne0OBC
X-Gm-Gg: Acq92OG9bORM7wYIdRZnddZA90lj8lVFX+7vAFeO9FHlWx7PO0Ieg6T1F1tUM4VXhgd
	nqCZvVX+kL2GyzlA9dTBZn8lkK+5Wt5An/i6Qqwamk5cUhcKLo/H5kGNnBLkRA3IMHqm+SQq+z8
	4wJRKuT1v7SPcUb2TQGKMCBU4scqpmMciHgoTTGUvRQ16AlU1PTr9P/3REyVtLkSclPOsS0JMzb
	PCrMsZR2DMoUS/u+roQehKHrBKvB3n7TqbFtkNRBi9B+jwyQwTXMTEY0JCOVQKYMJuPatCyHrEn
	E0fBDBV4locOeRvFc5aCg8WiQ8YYLPIP8g52js/nc24pO5ubuxvsX12jLOI6pwiyRgrIhYfu6Zg
	xRPWpImG9LxHkZ3VAFFh61ytGiGLeQ3wD71m5zpi2z7OImBfgA9Hadjz73i7nxrlc2ckfzLcSDQ
	SxkyqQVfSaEmw+yq8UTcoUzjWQQPwTDiA2sc/M7Cj+
X-Received: by 2002:a17:902:e885:b0:2bd:8dbd:17e6 with SMTP id d9443c01a7336-2beb067b61emr247816785ad.35.1779867008460;
        Wed, 27 May 2026 00:30:08 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated callchains when 1M instructions limit is met
Date: Wed, 27 May 2026 00:29:52 -0700
Message-ID: <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
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
2.53.0
