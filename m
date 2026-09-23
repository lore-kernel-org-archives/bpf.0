Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194C584960
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202974; cv=none; b=LMco4oVwPTa+0zKIObdzEIeCPLuXUhkASy6kMIiR+GGSynY4Iyt44M2x9C/lWzdKqPFREhUWTuBC9LV1ZxZcQKhSNoH+x0BLRcoA/pgMM5HHbMNkiMyljW9CDTJdCefJwynvDTKu+ldz7oa3HDD5dgJf3rr49IuSYYx/JIO9RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202974; c=relaxed/simple;
	bh=cUNALR4BbTP4GojoBbQ0VzMkEqQv/61agdHFA7EZF9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6TX09FbPK/u1xXgc8ph2XPywuqkNJyy+VrQj6V62Vrq4RlYO1ZQ003oR8UOXKLvbGefIFxXSzk/1GBfMyXnkSc+lIPV4Zudrvv3rE1HrqSgG/+WYR3Y1IWYrdAK4o4wICHFwlB+//EySYsbEc4ABrHrhN6X19/ozE0+LxYCAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/yn3pS9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/yn3pS9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a147688bso1074144a91.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202970; x=1790807770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rELvBdaZOcnF3He3iJZ5QPZRLTE9gHCI//84d6DhK8M=;
        b=B/yn3pS9K6gYo7aWZM1bjl7F1BP6sK8gpMS0B56S24Uk9mdVUyfLnoQ8ow8Bd3gGK6
         mrV+LDP6MlPU6xBmdoWPDSyxeRgrupUqO6Ee7K8NvHVpbjX5SqLaM6bIkNdvlroaRl1N
         LjS8XSRj4flod/udJcoDcfiGJa5iiSoEVwVEkleYuX9n+1d3xK0eK4HjT35+7ETuYe2C
         St8tt5I6Y0LPgB/a9arJ1AAAkgP1CPSCc3v9RrQIBL6CkUpXX8BmtrhebWLfs0/EBnZv
         OvO3nPDlqek3FYwOFPZoj1JOY9k5cLmiyCTrbxPLp8y5v4qLx1+tD1EVCT2q8weTiXDR
         FryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202970; x=1790807770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rELvBdaZOcnF3He3iJZ5QPZRLTE9gHCI//84d6DhK8M=;
        b=NoUKnmnYI3PuWWPuRxW0EumnFOwZJDaiAbvQOQYW4zvyXrfz1IljR6CxkHGtiIfAPh
         hq5xytqfroCj3NNiVy1rTUS1IuQkZnVwjbiSgpNHtMCG9T2b7sGsO5EdebJo+MBDNr8m
         eEZPMrkqSqkSD6uL9e2Z52jEm4lFIcwV3g2BJ6lsn/Cyuc7FgFOcDeyqcpCMSetH9YAY
         i5oVa1F8zASRUpOTTF3rYuv/r3jCvJ5bSwuhCdRg9ICFwqKTv2Jf8wNiyznKJMU342wp
         Wp2F9DD537zVKTcBqQQXdV4o3XmIUmxcXkg2J8ld3Fxb4jcQZH/QLO4j8x2HQxkPTSA1
         MpaA==
X-Gm-Message-State: AFuF++nKvMuuLhnBjPsfVBVEwranERklOVem8lYZ3pSxvrsaySJw2/cE
	WanOdmYbjO3U2RtySGkGowAuDuIpoCnOlu8oHCij4F97IoTRzeb2a94oFF0xbw==
X-Gm-Gg: AYBFou0Qy73Tpf3FVkn471R2Zy8QQ/vnpR2/DRhxd3dGf06ZeyHs4kixX1Q7wXQuyC4
	hD3F04btnNRfREO+l3O19qKEkLpTgEmy0GEpJV3h6qTGqZTjOZAyuz29MsrhLggXRsEPhIORbOw
	DmK2Frw48QwoTLbCp5QLf9VKSSrWdJgoWw3Em15ubAVH+QiPiWjntiKr07gMXdDT4W4tiSBc8MJ
	UX9keuQr0CdXlE+7oMyenAGch3kijFqT1gpePQzdB5dxjaN3FP7zXNyCvXk3f481xC/QXlKLc6P
	pLwNJCqD0rROXZAzXQxpHiMnILR+OWMeHtU8A7kOVUdInYtBOUpEfSaNWKDAM83gjB/aeOS3SKb
	wX7p/9EG1WqaVSvntHca66fwUW9BnJiC1g6KMRnF0MFBiKI22Nxr1NjLg4G3C0o4fj4D0g2lXib
	9sikHy/YFQp5FkbS00vR94K+QhZcEZVnwcSXA0xRVMV+GrZlNgYxXEUdV4TKXD6HTFevzA9QsVV
	0It9l/U1Owp6ezjdDiHZtezL+OJdoY3i+CcQTW2ETwyzH4KySslClzp9CEctTn7ywuFKwdHkZtT
	SxFhExGmEQcybkP07zIcxmwTz90iYH8qBzmOHBmQn6k=
X-Received: by 2002:a17:90b:2e83:b0:3a0:3a81:761c with SMTP id 98e67ed59e1d1-3a09929066bmr498257a91.64.1790202969577;
        Wed, 23 Sep 2026 15:36:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09733f48fsm1126100a91.11.2026.09.23.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/8] bpf: Detect loops that never exit
Date: Wed, 23 Sep 2026 22:35:50 +0000
Message-ID: <20260923223554.562379-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When loops are widened all states that enter the loop can end up going
around it. If none of the states that came from the state that entered
the loop left it, the program never leaves the loop either:

  l1: r0 += 1
      goto l1

Remember in bpf_scc_visit that some state left the loop: the walk took
the jump out of SCC, got to exit or bpf_throw(), or the state was pruned
by the state that is fully explored. When the state that entered the loop
is done, there are backedges and nothing left the loop fail the walk.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/states.c          | 40 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 20 ++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 981902cd5b71..60f483d7e4a9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -900,6 +900,8 @@ struct bpf_scc_visit {
 	struct bpf_verifier_state *entry_state;
 	struct bpf_scc_backedge *backedges; /* list of backedges */
 	u32 num_backedges;
+	/* some state left the SCC since entry_state was set */
+	bool exited;
 };
 
 /* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
@@ -1230,6 +1232,7 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_same_loop(struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
+void bpf_scc_mark_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int insn_idx);
 int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedge,
 			struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 22987ce070e7..39e6052922e5 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -170,6 +170,7 @@ static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		return -ENOMEM;
 	if (!visit->entry_state) {
 		visit->entry_state = st;
+		visit->exited = false;
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "SCC enter %s\n", format_callchain(env, callchain));
 	}
@@ -212,6 +213,16 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	}
 	if (visit->entry_state != st)
 		return 0;
+	/*
+	 * All states that came from @st are done. If some of them went
+	 * around the loop and none left it, nothing that enters the loop
+	 * the way @st did ever leaves it.
+	 */
+	if (env->widen_loops && !st->speculative && visit->backedges && !visit->exited) {
+		verbose(env, "loop at insn %d never exits\n", st->insn_idx);
+		env->widen_used = true;
+		return -EINVAL;
+	}
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "SCC exit %s\n", format_callchain(env, callchain));
 	visit->entry_state = NULL;
@@ -221,6 +232,32 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	return propagate_backedges(env, visit);
 }
 
+/*
+ * @st left the loop that @insn_idx of its current frame is in. The loop is
+ * left when the frame that bpf_scc_visit is for leaves it. Loops in callees
+ * of that frame are part of one trip around the loop of the caller.
+ */
+void bpf_scc_mark_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int insn_idx)
+{
+	struct bpf_scc_callchain *callchain = &env->callchain_buf;
+	struct bpf_scc_visit *visit;
+	u32 i, callsite;
+
+	if (st->speculative || !env->insn_aux_data[insn_idx].scc)
+		return;
+	memset(callchain, 0, sizeof(*callchain));
+	for (i = 0; i < st->curframe; i++) {
+		callsite = bpf_frame_insn_idx(st, i);
+		if (env->insn_aux_data[callsite].scc)
+			return;
+		callchain->callsites[i] = callsite;
+	}
+	callchain->scc = env->insn_aux_data[insn_idx].scc;
+	visit = scc_visit_lookup(env, callchain);
+	if (visit)
+		visit->exited = true;
+}
+
 /* Lookup an bpf_scc_visit instance corresponding to @st callchain
  * and add @backedge to visit->backedges. @st callchain must exist.
  */
@@ -1462,6 +1499,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
 			sl->hit_cnt++;
+			/* what follows the old state was seen, it may leave the loop */
+			if (env->widen_loops && !sl->state.branches)
+				bpf_scc_mark_exit(env, cur, insn_idx);
 
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 85b2691f81b1..06dc269991b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19192,6 +19192,21 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+/* Did the jump at @prev take the walk out of the loop @prev is in? */
+static bool left_loop(struct bpf_verifier_env *env, int prev, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn;
+
+	if (prev < 0 || prev >= env->prog->len || !aux[prev].scc ||
+	    aux[prev].scc == aux[insn_idx].scc)
+		return false;
+	/* the callee is not in SCC of the call, the insn after the call is */
+	insn = &env->prog->insnsi[prev];
+	return !((BPF_CLASS(insn->code) == BPF_JMP || BPF_CLASS(insn->code) == BPF_JMP32) &&
+		 BPF_OP(insn->code) == BPF_CALL);
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -19230,6 +19245,8 @@ static int do_check(struct bpf_verifier_env *env)
 
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
+		if (env->widen_loops && left_loop(env, prev_insn_idx, env->insn_idx))
+			bpf_scc_mark_exit(env, state, prev_insn_idx);
 		/*
 		 * Record the incoming edge so active and queued paths use the same
 		 * branch-recording path. A zero-offset conditional has identical
@@ -19358,6 +19375,9 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (err < 0) {
 			return err;
 		} else if (err == PROCESS_BPF_EXIT) {
+			/* exit or bpf_throw() inside of a loop */
+			if (env->widen_loops)
+				bpf_scc_mark_exit(env, state, env->insn_idx);
 			goto process_bpf_exit;
 		} else if (err == INSN_IDX_UPDATED) {
 		} else if (err == 0) {
-- 
2.55.0

