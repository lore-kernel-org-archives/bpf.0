Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEAC10F00
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE500206B8
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179279;
	bh=foZPTMQuAyE6AhfEi29SCb0fyGL6MqXlADW/b2+U6WA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJFAX/IkLC1lqR7Bk+78sxWzkbG6oGBL01JrABkPCeZyVkpbVngWXI+MOXwpBUC9w
	 zdIu72Bh1Bp/v2TnfCTxlJlG9FtYuSgsi8xDmMFOOJnVmUukTs3hP15FMUNp53uvne
	 P2IL6iXOyAi0sPklKDKupkkLcZJDZIFlXgG2kbM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfDBE15 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:27:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728760AbfDBE1z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:27:55 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x324QU5s027228
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:27:54 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rkqck9wd2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:27:54 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:27:54 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id A020D760E11; Mon,  1 Apr 2019 21:27:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 02/10] bpf: improve verification speed by droping states
Date:   Mon, 1 Apr 2019 21:27:41 -0700
Message-ID: <20190402042749.3670015-3-ast@kernel.org>
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

Branch instructions, branch targets and calls in a bpf program are
the places where the verifier remembers states that led to successful
verification of the program.
These states are used to prune brute force program analysis.
For unprivileged programs there is a limit of 64 states per such
'branching' instructions (maximum length is tracked by max_states_per_insn
counter introduced in the previous patch).
Simply reducing this threshold to 32 or lower increases insn_processed
metric to the point that small valid programs get rejected.
For root programs there is no limit and cilium programs can have
max_states_per_insn to be 100 or higher.
Walking 100+ states multiplied by number of 'branching' insns during
verification consumes significant amount of cpu time.
Turned out simple LRU-like mechanism can be used to remove states
that unlikely will be helpful in future search pruning.
This patch introduces hit_cnt and miss_cnt counters:
hit_cnt - this many times this state successfully pruned the search
miss_cnt - this many times this state was not equivalent to other states
(and that other states were added to state list)

The heuristic introduced in this patch is:
if (sl->miss_cnt > sl->hit_cnt * 3 + 3)
  /* drop this state from future considerations */

Higher numbers increase max_states_per_insn (allow more states to be
considered for pruning) and slow verification speed, but do not meaningfully
reduce insn_processed metric.
Lower numbers drop too many states and insn_processed increases too much.
Many different formulas were considered.
This one is simple and works well enough in practice.
(the analysis was done on selftests/progs/* and on cilium programs)

The end result is this heuristic improves verification speed by 10 times.
Large synthetic programs that used to take a second more now take
1/10 of a second.
In cases where max_states_per_insn used to be 100 or more, now it's ~10.

There is a slight increase in insn_processed for cilium progs:
                       before   after
bpf_lb-DLB_L3.o 	1831	1838
bpf_lb-DLB_L4.o 	3029	3218
bpf_lb-DUNKNOWN.o 	1064	1064
bpf_lxc-DDROP_ALL.o	26309	26935
bpf_lxc-DUNKNOWN.o	33517	34439
bpf_netdev.o		9713	9721
bpf_overlay.o		6184	6184
bpf_lcx_jit.o		37335	39389
And 2-3 times improvement in the verification speed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 44 +++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f7e15eeb60bb..fc8254d6b569 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -207,6 +207,7 @@ struct bpf_verifier_state {
 struct bpf_verifier_state_list {
 	struct bpf_verifier_state state;
 	struct bpf_verifier_state_list *next;
+	int miss_cnt, hit_cnt;
 };
 
 /* Possible states for alu_state member. */
@@ -280,6 +281,7 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	struct bpf_verifier_state_list **explored_states; /* search pruning optimization */
+	struct bpf_verifier_state_list *free_list;
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
 	u32 used_map_cnt;		/* number of used maps */
 	u32 id_gen;			/* used to generate unique reg IDs */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2001c1e40b3..a636db4a7a4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6152,11 +6152,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
-	struct bpf_verifier_state_list *sl;
+	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
 	int i, j, err, states_cnt = 0;
 
-	sl = env->explored_states[insn_idx];
+	pprev = &env->explored_states[insn_idx];
+	sl = *pprev;
+
 	if (!sl)
 		/* this 'insn_idx' instruction wasn't marked, so we will not
 		 * be doing state search here
@@ -6167,6 +6169,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	while (sl != STATE_LIST_MARK) {
 		if (states_equal(env, &sl->state, cur)) {
+			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
 			 * Registers read by the continuation are read by us.
@@ -6182,8 +6185,35 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				return err;
 			return 1;
 		}
-		sl = sl->next;
 		states_cnt++;
+		sl->miss_cnt++;
+		/* heuristic to determine whether this state is beneficial
+		 * to keep checking from state equivalence point of view.
+		 * Higher numbers increase max_states_per_insn and verification time,
+		 * but do not meaningfully decrease insn_processed.
+		 */
+		if (sl->miss_cnt > sl->hit_cnt * 3 + 3) {
+			/* the state is unlikely to be useful. Remove it to
+			 * speed up verification
+			 */
+			*pprev = sl->next;
+			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE) {
+				free_verifier_state(&sl->state, false);
+				kfree(sl);
+				env->peak_states--;
+			} else {
+				/* cannot free this state, since parentage chain may
+				 * walk it later. Add it for free_list instead to
+				 * be freed at the end of verification
+				 */
+				sl->next = env->free_list;
+				env->free_list = sl;
+			}
+			sl = *pprev;
+			continue;
+		}
+		pprev = &sl->next;
+		sl = *pprev;
 	}
 
 	if (env->max_states_per_insn < states_cnt)
@@ -7836,6 +7866,14 @@ static void free_states(struct bpf_verifier_env *env)
 	struct bpf_verifier_state_list *sl, *sln;
 	int i;
 
+	sl = env->free_list;
+	while (sl) {
+		sln = sl->next;
+		free_verifier_state(&sl->state, false);
+		kfree(sl);
+		sl = sln;
+	}
+
 	if (!env->explored_states)
 		return;
 
-- 
2.20.0

