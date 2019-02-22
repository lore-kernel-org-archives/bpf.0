Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E5C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F22070D
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878616;
	bh=sQz6kwD+PltCSRvofVYXY2SiA4Q4N64hvAgblZOQFAM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXX+8eedxkxBCoEUTqww7V+k8gem86ROzt/Umx/h/GxjiMj1C5EYEFvI/zSGoyOVE
	 0QrEwV8bqIC6phEsgt4mtTeqpVsGZhbwYb6FUqPXbLIbgsG4P4ae7qJLZ51tLR5uui
	 59kDNa6rc7kZZVBm2LfZoSgUyStjUctiLqALW1qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfBVXg4 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 22 Feb 2019 18:36:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfBVXg4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Feb 2019 18:36:56 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MNTXZZ026023
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:55 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qttpmr166-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:55 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 22 Feb 2019 15:36:48 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 0CE79760956; Fri, 22 Feb 2019 15:36:47 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/4] bpf: enable program stats
Date:   Fri, 22 Feb 2019 15:36:41 -0800
Message-ID: <20190222233644.1487087-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222233644.1487087-1-ast@kernel.org>
References: <20190222233644.1487087-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

JITed BPF programs are indistinguishable from kernel functions, but unlike
kernel code BPF code can be changed often.
Typical approach of "perf record" + "perf report" profiling and tunning of
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
from ~40 nsec to ~60 nsec.
static_key minimizes the cost of the stats collection.
There is no measurable difference before/after this patch
with kernel.bpf_stats_enabled=0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    |  7 +++++++
 include/linux/filter.h | 16 +++++++++++++++-
 kernel/bpf/core.c      | 13 +++++++++++++
 kernel/bpf/syscall.c   | 24 ++++++++++++++++++++++--
 kernel/bpf/verifier.c  |  5 +++++
 kernel/sysctl.c        | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index de18227b3d95..14260674bc57 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -340,6 +340,11 @@ enum bpf_cgroup_storage_type {
 
 #define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
 
+struct bpf_prog_stats {
+	u64 cnt;
+	u64 nsecs;
+};
+
 struct bpf_prog_aux {
 	atomic_t refcnt;
 	u32 used_map_cnt;
@@ -389,6 +394,7 @@ struct bpf_prog_aux {
 	 * main prog always has linfo_idx == 0
 	 */
 	u32 linfo_idx;
+	struct bpf_prog_stats __percpu *stats;
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
@@ -559,6 +565,7 @@ void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
 
 extern int sysctl_unprivileged_bpf_disabled;
+extern int sysctl_bpf_stats_enabled;
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
 int bpf_prog_new_fd(struct bpf_prog *prog);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f32b3eca5a04..7b14235b6f7d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -533,7 +533,21 @@ struct sk_filter {
 	struct bpf_prog	*prog;
 };
 
-#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
+DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
+
+#define BPF_PROG_RUN(prog, ctx)	({				\
+	u32 ret;						\
+	cant_sleep();						\
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
+		u64 start = sched_clock();			\
+		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
+		this_cpu_inc(prog->aux->stats->cnt);		\
+		this_cpu_add(prog->aux->stats->nsecs,		\
+			     sched_clock() - start);		\
+	} else {						\
+		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
+	}							\
+	ret; })
 
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ef88b167959d..574747f98d44 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -95,6 +95,13 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 		return NULL;
 	}
 
+	aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
+	if (!aux->stats) {
+		kfree(aux);
+		vfree(fp);
+		return NULL;
+	}
+
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
 	fp->aux->prog = fp;
@@ -231,6 +238,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 
 void __bpf_prog_free(struct bpf_prog *fp)
 {
+	if (fp->aux && !fp->is_func)
+		free_percpu(fp->aux->stats);
 	kfree(fp->aux);
 	vfree(fp);
 }
@@ -2069,6 +2078,10 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
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
index ec7c552af76b..079e7fa14f39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1283,24 +1283,44 @@ static int bpf_prog_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void bpf_prog_get_stats(const struct bpf_prog *prog,
+			       struct bpf_prog_stats *stats)
+{
+	u64 nsecs = 0, cnt = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		nsecs += per_cpu(prog->aux->stats->nsecs, cpu);
+		cnt += per_cpu(prog->aux->stats->cnt, cpu);
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
+		   "runtime:\t%llu\n"
+		   "runcnt:\t%llu\n",
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
index 1b9496c41383..dff61920a316 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7330,6 +7330,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		if (bpf_prog_calc_tag(func[i]))
 			goto out_free;
 		func[i]->is_func = 1;
+		/* BPF_PROG_RUN doesn't call subprogs directly,
+		 * hence stats are reused from main prog
+		 */
+		free_percpu(func[i]->aux->stats);
+		func[i]->aux->stats = prog->aux->stats;
 		func[i]->aux->func_idx = i;
 		/* the btf and func_info will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
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

