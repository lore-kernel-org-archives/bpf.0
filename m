Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602F2765F8
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203061; cv=none; b=aANljW3E4gIYhr66egjhK+1vwJXTUq7L2YfI9zNY2BffCvzPTcPXk+idzP6iIe18kG4dWTDkp3q1PXnPzb6RtylZtrUwL4kfiHCaUjesUnAQUgrMMUTcru5ZF/509i4eHBH3AKrW1846TRp9JzcTHbvjRiC1Iw0uP4QeURUOzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203061; c=relaxed/simple;
	bh=GpArskV1M8s7AHiawdJgJXQ2u2W83fMsj2qTRHGIccQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWvnfi6q3mVmo30afcr4Yf2BHQbFupw8FptVP8q3qgVYb0bHt4r0bNa22elLTigckziRvSif3rXDjoE24QQNGMs2KNLh7q1zkjWRAjtMPzUH5ZAxbzKJWkhv/cDeXDpUMKiFftStb59fgIeDeq5RJjaeNetDzkgrUq5dYdk2HwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3xTJ3uvY; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3xTJ3uvY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Bwj4IDv9+HSPZfc67vZPQIva5FPI7w63RmdFKMr1YSk=;
	b=3xTJ3uvYkZAI2mu1BvFsf94gfquCRynsRz68uERDqr0Xu9/fnU52BZofuKsJEK7kWXQeTfBDG
	UAhOunxCEl9hRC+LEIE42YH7zCF+Y7NlcX2tVB7v4u7H2rKlrVuo8m3SbeD5aZqujXkwN7FXtLD
	Z8C5E4Q4RvWCvVv58wXX/+c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fn9s45QyHzcb0v;
	Fri,  3 Apr 2026 15:51:20 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DDA554056B;
	Fri,  3 Apr 2026 15:57:28 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 15:57:28 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 15:57:28 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <kernel@openeuler.org>
CC: <tanghui20@huawei.com>, <quzicheng@huawei.com>, <quzicheng315@163.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>, "Alexei
 Starovoitov" <ast@kernel.org>, <bpf@vger.kernel.org>, cheliequan
	<cheliequan@inspur.com>, Luo Gengkun <luogengkun2@huawei.com>
Subject: [PATCH OLK-6.6 213/451] sched_ext/scx_qmap: Add an example usage of DSQ iterator
Date: Fri, 3 Apr 2026 07:29:28 +0000
Message-ID: <20260403073326.3096906-214-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403073326.3096906-1-quzicheng@huawei.com>
References: <20260403073326.3096906-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100012.china.huawei.com (7.202.195.195)

From: Tejun Heo <tj@kernel.org>

mainline inclusion
from mainline-v6.12-rc1
commit 6fbd643318a1a5f3caea7f94bfe035efbb293ddb
category: feature
bugzilla:  https://gitee.com/openeuler/kernel/issues/ID7HLY

Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6fbd643318a1a5f3caea7f94bfe035efbb293ddb

--------------------------------

Implement periodic dumping of the shared DSQ to demonstrate the use of the
newly added DSQ iterator.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: cheliequan <cheliequan@inspur.com>
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 25 +++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index b1d0b09c966e..27e35066a602 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -36,6 +36,7 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
+const volatile bool print_shared_dsq;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -604,10 +605,34 @@ static void monitor_cpuperf(void)
 	scx_bpf_put_cpumask(online);
 }
 
+/*
+ * Dump the currently queued tasks in the shared DSQ to demonstrate the usage of
+ * scx_bpf_dsq_nr_queued() and DSQ iterator. Raise the dispatch batch count to
+ * see meaningful dumps in the trace pipe.
+ */
+static void dump_shared_dsq(void)
+{
+	struct task_struct *p;
+	s32 nr;
+
+	if (!(nr = scx_bpf_dsq_nr_queued(SHARED_DSQ)))
+		return;
+
+	bpf_printk("Dumping %d tasks in SHARED_DSQ in reverse order", nr);
+
+	bpf_rcu_read_lock();
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV)
+		bpf_printk("%s[%d]", p->comm, p->pid);
+	bpf_rcu_read_unlock();
+}
+
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	monitor_cpuperf();
 
+	if (print_shared_dsq)
+		dump_shared_dsq();
+
 	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 	return 0;
 }
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e4e3ecffc4cf..304f0488a386 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,6 +28,7 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:Pd:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -82,6 +83,9 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'P':
+			skel->rodata->print_shared_dsq = true;
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
-- 
2.34.1

