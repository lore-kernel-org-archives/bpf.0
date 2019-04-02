Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9DAC43381
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95406206B8
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179275;
	bh=Y0H7MMNasOATlCSSQDtmAVuqKyBNdNDVf86CL6bx7Ds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJHq8IVqu6mqZABb5lCK69BNNQn+7j5R09qOLo+pA4BUMM3z32ahrfo0ixSoqRvo4
	 qhv6Fgj0tBykOiakyVHmFmNyoQzWXTGxRJwcAF7IxBeN6WDUZxG09mmf9CEVZma7pZ
	 tQu20lXtgBsQUb9f4sAJ4dh2BvAwidxEkGBY53es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDBE1z convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:27:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51404 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfDBE1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:27:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x324NoNg028065
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:27:53 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rkv7qgqnu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:27:53 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:27:51 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 9521D760E11; Mon,  1 Apr 2019 21:27:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 01/10] bpf: add verifier stats and log_level bit 2
Date:   Mon, 1 Apr 2019 21:27:40 -0700
Message-ID: <20190402042749.3670015-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to understand the verifier bottlenecks add various stats
and extend log_level:
log_level 1 and 2 are kept as-is:
bit 0 - level=1 - print every insn and verifier state at branch points
bit 1 - level=2 - print every insn and verifier state at every insn
bit 2 - level=4 - print verifier error and stats at the end of verification

When verifier rejects the program the libbpf is trying to load the program twice.
Once with log_level=0 (no messages, only error code is reported to user space)
and second time with log_level=1 to tell the user why the verifier rejected it.

With introduction of bit 2 - level=4 the libbpf can choose to always use that
level and load programs once, since the verification speed is not affected and
in case of error the verbose message will be available.

Note that the verifier stats are not part of uapi just like all other
verbose messages. They're expected to change in the future.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 21 ++++++++++
 kernel/bpf/verifier.c        | 76 ++++++++++++++++++++++++------------
 2 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7d8228d1c898..f7e15eeb60bb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -248,6 +248,12 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 	return log->len_used >= log->len_total - 1;
 }
 
+#define BPF_LOG_LEVEL1	1
+#define BPF_LOG_LEVEL2	2
+#define BPF_LOG_STATS	4
+#define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
+#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS)
+
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
 	return log->level && log->ubuf && !bpf_verifier_log_full(log);
@@ -284,6 +290,21 @@ struct bpf_verifier_env {
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
 	u32 subprog_cnt;
+	/* number of instructions analyzed by the verifier */
+	u32 insn_processed;
+	/* total verification time */
+	u64 verification_time;
+	/* maximum number of verifier states kept in 'branching' instructions */
+	u32 max_states_per_insn;
+	/* total number of allocated verifier states */
+	u32 total_states;
+	/* some states are freed during program analysis.
+	 * this is peak number of states. this number dominates kernel
+	 * memory consumption during verification
+	 */
+	u32 peak_states;
+	/* longest register parentage chain walked for liveness marking */
+	u32 longest_mark_read_walk;
 };
 
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 87221fda1321..e2001c1e40b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1092,7 +1092,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	 */
 	subprog[env->subprog_cnt].start = insn_cnt;
 
-	if (env->log.level > 1)
+	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < env->subprog_cnt; i++)
 			verbose(env, "func#%d @%d\n", i, subprog[i].start);
 
@@ -1139,6 +1139,7 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 			 struct bpf_reg_state *parent)
 {
 	bool writes = parent == state->parent; /* Observe write marks */
+	int cnt = 0;
 
 	while (parent) {
 		/* if read wasn't screened by an earlier write ... */
@@ -1155,7 +1156,11 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		state = parent;
 		parent = state->parent;
 		writes = true;
+		cnt++;
 	}
+
+	if (env->longest_mark_read_walk < cnt)
+		env->longest_mark_read_walk = cnt;
 	return 0;
 }
 
@@ -1455,7 +1460,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	 * need to try adding each of min_value and max_value to off
 	 * to make sure our theoretical access will be safe.
 	 */
-	if (env->log.level)
+	if (env->log.level & BPF_LOG_LEVEL)
 		print_verifier_state(env, state);
 
 	/* The minimum value is only important with signed
@@ -2938,7 +2943,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* and go analyze first insn of the callee */
 	*insn_idx = target_insn;
 
-	if (env->log.level) {
+	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
 		print_verifier_state(env, caller);
 		verbose(env, "callee:\n");
@@ -2978,7 +2983,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		return err;
 
 	*insn_idx = callee->callsite + 1;
-	if (env->log.level) {
+	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
 		print_verifier_state(env, callee);
 		verbose(env, "to caller at %d:\n", *insn_idx);
@@ -5001,7 +5006,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			insn->dst_reg);
 		return -EACCES;
 	}
-	if (env->log.level)
+	if (env->log.level & BPF_LOG_LEVEL)
 		print_verifier_state(env, this_branch->frame[this_branch->curframe]);
 	return 0;
 }
@@ -6181,6 +6186,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		states_cnt++;
 	}
 
+	if (env->max_states_per_insn < states_cnt)
+		env->max_states_per_insn = states_cnt;
+
 	if (!env->allow_ptr_leaks && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
 		return 0;
 
@@ -6194,6 +6202,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL);
 	if (!new_sl)
 		return -ENOMEM;
+	env->total_states++;
+	env->peak_states++;
 
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
@@ -6278,8 +6288,7 @@ static int do_check(struct bpf_verifier_env *env)
 	struct bpf_verifier_state *state;
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct bpf_reg_state *regs;
-	int insn_cnt = env->prog->len, i;
-	int insn_processed = 0;
+	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
 
 	env->prev_linfo = NULL;
@@ -6314,10 +6323,10 @@ static int do_check(struct bpf_verifier_env *env)
 		insn = &insns[env->insn_idx];
 		class = BPF_CLASS(insn->code);
 
-		if (++insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
+		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
-				insn_processed);
+				env->insn_processed);
 			return -E2BIG;
 		}
 
@@ -6326,7 +6335,7 @@ static int do_check(struct bpf_verifier_env *env)
 			return err;
 		if (err == 1) {
 			/* found equivalent state, can prune the search */
-			if (env->log.level) {
+			if (env->log.level & BPF_LOG_LEVEL) {
 				if (do_print_state)
 					verbose(env, "\nfrom %d to %d%s: safe\n",
 						env->prev_insn_idx, env->insn_idx,
@@ -6344,8 +6353,9 @@ static int do_check(struct bpf_verifier_env *env)
 		if (need_resched())
 			cond_resched();
 
-		if (env->log.level > 1 || (env->log.level && do_print_state)) {
-			if (env->log.level > 1)
+		if (env->log.level & BPF_LOG_LEVEL2 ||
+		    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
+			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "%d:", env->insn_idx);
 			else
 				verbose(env, "\nfrom %d to %d%s:",
@@ -6356,7 +6366,7 @@ static int do_check(struct bpf_verifier_env *env)
 			do_print_state = false;
 		}
 
-		if (env->log.level) {
+		if (env->log.level & BPF_LOG_LEVEL) {
 			const struct bpf_insn_cbs cbs = {
 				.cb_print	= verbose,
 				.private_data	= env,
@@ -6621,16 +6631,6 @@ static int do_check(struct bpf_verifier_env *env)
 		env->insn_idx++;
 	}
 
-	verbose(env, "processed %d insns (limit %d), stack depth ",
-		insn_processed, BPF_COMPLEXITY_LIMIT_INSNS);
-	for (i = 0; i < env->subprog_cnt; i++) {
-		u32 depth = env->subprog_info[i].stack_depth;
-
-		verbose(env, "%d", depth);
-		if (i + 1 < env->subprog_cnt)
-			verbose(env, "+");
-	}
-	verbose(env, "\n");
 	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return 0;
 }
@@ -7854,9 +7854,34 @@ static void free_states(struct bpf_verifier_env *env)
 	kfree(env->explored_states);
 }
 
+static void print_verification_stats(struct bpf_verifier_env *env)
+{
+	int i;
+
+	if (env->log.level & BPF_LOG_STATS) {
+		verbose(env, "verification time %lld usec\n",
+			div_u64(env->verification_time, 1000));
+		verbose(env, "stack depth ");
+		for (i = 0; i < env->subprog_cnt; i++) {
+			u32 depth = env->subprog_info[i].stack_depth;
+
+			verbose(env, "%d", depth);
+			if (i + 1 < env->subprog_cnt)
+				verbose(env, "+");
+		}
+		verbose(env, "\n");
+	}
+	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
+		"total_states %d peak_states %d mark_read %d\n",
+		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
+		env->max_states_per_insn, env->total_states,
+		env->peak_states, env->longest_mark_read_walk);
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	      union bpf_attr __user *uattr)
 {
+	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	struct bpf_verifier_log *log;
 	int i, len, ret = -EINVAL;
@@ -7899,7 +7924,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		ret = -EINVAL;
 		/* log attributes have to be sane */
 		if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 ||
-		    !log->level || !log->ubuf)
+		    !log->level || !log->ubuf || log->level & ~BPF_LOG_MASK)
 			goto err_unlock;
 	}
 
@@ -7980,6 +8005,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = fixup_call_args(env);
 
+	env->verification_time = ktime_get_ns() - start_time;
+	print_verification_stats(env);
+
 	if (log->level && bpf_verifier_log_full(log))
 		ret = -ENOSPC;
 	if (log->level && !log->ubuf) {
-- 
2.20.0

