Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE6C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D480220643
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551133752;
	bh=Yqz8DGVNS0tuLYScWtdUS8MEh8LQcGo47iRfXOYsaJU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoEDTSl3tz4QmI3s4gF4K9Css9wB9ZUJNujpd5CXQL3iZnXTiZcCqa4VIPCvo4uae
	 uBR/OzlcB/8BB5pAcdawmJFjUoJt1lmUUo/6Pp+qJkARAFmlWTgJh9ycdJRWaMk9fZ
	 PCDEPObKcjhPfHbFGRnq3/FFbhEhsQQK12zDrmo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBYW3L convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 25 Feb 2019 17:29:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfBYW3L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 17:29:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PMSOXN019434
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:09 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvprkrk0p-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:09 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 14:28:45 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 124DC76091F; Mon, 25 Feb 2019 14:28:44 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Date:   Mon, 25 Feb 2019 14:28:39 -0800
Message-ID: <20190225222842.2031962-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190225222842.2031962-1-ast@kernel.org>
References: <20190225222842.2031962-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

JITed BPF programs are indistinguishable from kernel functions, but unlike
kernel code BPF code can be changed often.
Typical approach of "perf record" + "perf report" profiling and tuning of
kernel code works just as well for BPF programs, but kernel code doesn't
need to be monitored whereas BPF programs do.
Users load and run large amount of BPF programs.
These BPF stats allow tools monitor the usage of BPF on the server.
The monitoring tools will turn sysctl kernel.bpf_stats_enabled
on and off for few seconds to sample average cost of the programs.
Aggregated data over hours and days will provide an insight into cost of BPF
and alarms can trigger in case given program suddenly gets more expensive.

The cost of two sched_clock() per program invocation adds ~20 nsec.
Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
from ~10 nsec to ~30 nsec.
static_key minimizes the cost of the stats collection.
There is no measurable difference before/after this patch
with kernel.bpf_stats_enabled=0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    |  9 +++++++++
 include/linux/filter.h | 20 +++++++++++++++++++-
 kernel/bpf/core.c      | 31 +++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c   | 34 ++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c  |  7 ++++++-
 kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index de18227b3d95..a2132e09dc1c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -16,6 +16,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/wait.h>
+#include <linux/u64_stats_sync.h>
 
 struct bpf_verifier_env;
 struct perf_event;
@@ -340,6 +341,12 @@ enum bpf_cgroup_storage_type {
 
 #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
 
+struct bpf_prog_stats {
+	u64 cnt;
+	u64 nsecs;
+	struct u64_stats_sync syncp;
+};
+
 struct bpf_prog_aux {
 	atomic_t refcnt;
 	u32 used_map_cnt;
@@ -389,6 +396,7 @@ struct bpf_prog_aux {
 	 * main prog always has linfo_idx == 0
 	 */
 	u32 linfo_idx;
+	struct bpf_prog_stats __percpu *stats;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -559,6 +567,7 @@ void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
 
 extern int sysctl_unprivileged_bpf_disabled;
+extern int sysctl_bpf_stats_enabled;
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
 int bpf_prog_new_fd(struct bpf_prog *prog);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f32b3eca5a04..7e5e3db11106 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -533,7 +533,24 @@ struct sk_filter {
 	struct bpf_prog	*prog;
 };
 
-#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
+DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
+
+#define BPF_PROG_RUN(prog, ctx)	({				\
+	u32 ret;						\
+	cant_sleep();						\
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
+		struct bpf_prog_stats *stats;			\
+		u64 start = sched_clock();			\
+		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
+		stats = this_cpu_ptr(prog->aux->stats);		\
+		u64_stats_update_begin(&stats->syncp);		\
+		stats->cnt++;					\
+		stats->nsecs += sched_clock() - start;		\
+		u64_stats_update_end(&stats->syncp);		\
+	} else {						\
+		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
+	}							\
+	ret; })
 
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
@@ -764,6 +781,7 @@ void bpf_prog_free_jited_linfo(struct bpf_prog *prog);
 void bpf_prog_free_unused_jited_linfo(struct bpf_prog *prog);
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags);
+struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags);
 struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 				  gfp_t gfp_extra_flags);
 void __bpf_prog_free(struct bpf_prog *fp);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ef88b167959d..1c14c347f3cf 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -78,7 +78,7 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	return NULL;
 }
 
-struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
+struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog_aux *aux;
@@ -104,6 +104,26 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 
 	return fp;
 }
+
+struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
+{
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
+	if (!prog)
+		return NULL;
+
+	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
+	if (!prog->aux->stats) {
+		kfree(prog->aux);
+		vfree(prog);
+		return NULL;
+	}
+
+	u64_stats_init(&prog->aux->stats->syncp);
+	return prog;
+}
 EXPORT_SYMBOL_GPL(bpf_prog_alloc);
 
 int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog)
@@ -231,7 +251,10 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 
 void __bpf_prog_free(struct bpf_prog *fp)
 {
-	kfree(fp->aux);
+	if (fp->aux) {
+		free_percpu(fp->aux->stats);
+		kfree(fp->aux);
+	}
 	vfree(fp);
 }
 
@@ -2069,6 +2092,10 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
 	return -EFAULT;
 }
 
+DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
+EXPORT_SYMBOL(bpf_stats_enabled_key);
+int sysctl_bpf_stats_enabled __read_mostly;
+
 /* All definitions of tracepoints related to BPF. */
 #define CREATE_TRACE_POINTS
 #include <linux/bpf_trace.h>
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec7c552af76b..31cf66fc3f5c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1283,24 +1283,54 @@ static int bpf_prog_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void bpf_prog_get_stats(const struct bpf_prog *prog,
+			       struct bpf_prog_stats *stats)
+{
+	u64 nsecs = 0, cnt = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		const struct bpf_prog_stats *st;
+		unsigned int start;
+		u64 tnsecs, tcnt;
+
+		st = per_cpu_ptr(prog->aux->stats, cpu);
+		do {
+			start = u64_stats_fetch_begin_irq(&st->syncp);
+			tnsecs = st->nsecs;
+			tcnt = st->cnt;
+		} while (u64_stats_fetch_retry_irq(&st->syncp, start));
+		nsecs += tnsecs;
+		cnt += tcnt;
+	}
+	stats->nsecs = nsecs;
+	stats->cnt = cnt;
+}
+
 #ifdef CONFIG_PROC_FS
 static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_prog *prog = filp->private_data;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
+	struct bpf_prog_stats stats;
 
+	bpf_prog_get_stats(prog, &stats);
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
 		   "prog_type:\t%u\n"
 		   "prog_jited:\t%u\n"
 		   "prog_tag:\t%s\n"
 		   "memlock:\t%llu\n"
-		   "prog_id:\t%u\n",
+		   "prog_id:\t%u\n"
+		   "run_time_ns:\t%llu\n"
+		   "run_cnt:\t%llu\n",
 		   prog->type,
 		   prog->jited,
 		   prog_tag,
 		   prog->pages * 1ULL << PAGE_SHIFT,
-		   prog->aux->id);
+		   prog->aux->id,
+		   stats.nsecs,
+		   stats.cnt);
 }
 #endif
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b9496c41383..0e4edd7e3c5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7320,7 +7320,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		subprog_end = env->subprog_info[i + 1].start;
 
 		len = subprog_end - subprog_start;
-		func[i] = bpf_prog_alloc(bpf_prog_size(len), GFP_USER);
+		/* BPF_PROG_RUN doesn't call subprogs directly,
+		 * hence main prog stats include the runtime of subprogs.
+		 * subprogs don't have IDs and not reachable via prog_get_next_id
+		 * func[i]->aux->stats will never be accessed and stays NULL
+		 */
+		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
 		if (!func[i])
 			goto out_free;
 		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..86e0771352f2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -224,6 +224,9 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 #endif
 static int proc_dopipe_max_size(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
+static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
+					  void __user *buffer, size_t *lenp,
+					  loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
 /* Note: sysrq code uses its own private copy */
@@ -1230,6 +1233,15 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one,
 	},
 #endif
+	{
+		.procname	= "bpf_stats_enabled",
+		.data		= &sysctl_bpf_stats_enabled,
+		.maxlen		= sizeof(sysctl_bpf_stats_enabled),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax_bpf_stats,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 	{
 		.procname	= "panic_on_rcu_stall",
@@ -3260,6 +3272,28 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 
 #endif /* CONFIG_PROC_SYSCTL */
 
+static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
+					  void __user *buffer, size_t *lenp,
+					  loff_t *ppos)
+{
+	int ret, bpf_stats = *(int *)table->data;
+	struct ctl_table tmp = *table;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	tmp.data = &bpf_stats;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		*(int *)table->data = bpf_stats;
+		if (bpf_stats)
+			static_branch_enable(&bpf_stats_enabled_key);
+		else
+			static_branch_disable(&bpf_stats_enabled_key);
+	}
+	return ret;
+}
+
 /*
  * No sense putting this after each symbol definition, twice,
  * exception granted :-)
-- 
2.20.0

