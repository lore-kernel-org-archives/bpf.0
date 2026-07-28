Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8023C3BE6
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221739; cv=none; b=T3eVXvmjpNdCZWoJ3wOYsJhqK8grIax+cDcSSiQwYsKlT7ytrhCXJBC9bQmg3nEucC4ctacDMVo41StULjNHHiLqx7BuBwDsdC+7LFGOY6VWGe9Hi2VXJ5UWWQbQkwGo5YqU+4pSq1ZVl6R4YM7S3Se4ZHBCx5uC6opvWtD2QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221739; c=relaxed/simple;
	bh=zU/LrMTFBCyf8QVP616R+1HrtFhw1bGmGOu8u1sQaug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJ17qDkKXIUJZtNwVvtPw12DW7SYROi2Wi38MhAU78y9jChKsctCBaLr8Hlp8SqAYz7waXmkA5fwDwd5DwCTN9T1h4w2s695efKjMCd4OvTGONdczduo0fv4G3mfQZ3AlzI1EgN6w6M9v8DnC+xKT61kQ4a+hlx25iFRTSwvzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o7Kh2CpT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7Kh2CpT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RKe1c22925843;
	Tue, 28 Jul 2026 06:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2onA0
	rzzmk91yv+oLPsXhmMm6kcVJ3vbgfE+CHuL31Y=; b=o7Kh2CpTefhki9e3LevwX
	NBQVKrnNKv+aAvW1Iapc6WUK1ljyeWHUKXPMt2zMLKnWDuurlSSDI3Y0HX26i8vr
	tfeFUKkUt5D1HSeNaHeT8oRqSwUZejYGHM6ZKvIRtT8MN1k4XMpuuhHFRGodF/nH
	waIHPLhaXI8y+oeDbMkpjUMdfaQ/pucF+AqPZhChcirZWLT/EvDwAx081ZGDxszO
	cN20lOjFBTjnsG3QM2I94DfRZd02oPmog4GiWw67QoLlH/RVO6pfZ+7+pFcXMU4O
	FDNnSIMdXMlMIqPY7ypLCQeV4JiVkRaG6oGBm8pHBdWhwjqw0qlU5RXb9CbHenU2
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1db9e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwX005855;
	Tue, 28 Jul 2026 06:55:33 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-6;
	Tue, 28 Jul 2026 06:55:33 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 5/6] workqueue: introduce BPF iterator for pending work items
Date: Tue, 28 Jul 2026 14:55:24 +0800
Message-Id: <20260728065525.653171-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728065525.653171-1-imran.f.khan@oracle.com>
References: <20260728065525.653171-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607280060
X-Proofpoint-GUID: esEG22pKxuRB5431GcHhnKV8viF79Kd5
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a685267 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=_kkC-1MoAAAA:8
 a=fS32IPTvaLbz1dJzp8UA:9 a=dgjZJX60VdNvtmRteuOS:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX5/jj1ET5NJ00
 Gs9HQXQIFefcnrbC3LDjhfcYYdx60R028PZea00vS/AmnufewiJ2bUIuSYhxGCTe68sUAgxeMs0
 kVL8+OUbMOOMKHC9Aj0Mhyg+Bs7pWiZOHEdttW70lujw8ECWhpXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXwdNK58lcU/Dn
 J50VV1RKu0FOg2Ov7/beiLjBrCsuY4S1FzqBQQujDc2M68/eUI9Si+iz8JMRg4WflM395qyetOQ
 tfvsbyR7NT2CvX7K955M38KM2i/R0odDiQPxSx7rlyS/xKvjIW4kWYFZniLOOq9zdr+XIGOkG5E
 ckvHKmAN25Y2VZiPqWTTORXBCVodP6YvcCl8pIrzUaOU/c9mr49RAHjKgWBqDgQFs9j3/yzZHbd
 +oPmoVgSXF+46qbA+ucBMw3DFbZgZyFdUOfYowne1dQAEcXleyzxovi3N7YkG6LrMFFWHjcc8pt
 tf2j9bPtvd4eBAtDagth/PUcwFiCflL7bVDpGlNPbfMIm0U2V6E5LeW08YDTTs+auQDHHxY6l5D
 dWzGDpqWNukTufa29sjgAlEtRsA6q04+gM+YY6zjh5koJ3EiOj7P8hPxU0hbPXpdS4207Kxagbt
 Rpg4AlnkwiopPWCr1JVay2a7F12KoAd5m6N7kpvw=
X-Proofpoint-ORIG-GUID: esEG22pKxuRB5431GcHhnKV8viF79Kd5

Add a seq_file BPF iterator ("workqueue_pending_work") that walks the
pending work items of every worker_pool. Unlike the workqueue and
worker_pool iterators this is deliberately not open-coded because
pool->worklist is protected by pool->lock and struct work_struct has
neither a refcount nor RCU-freeing, so a pending work cannot be kept alive
for a suspended open-coded iterator.

Instead, for each pool a bounded snapshot of its pending works (pool id,
work address, work function) is copied out while pool->lock is held and
the BPF program runs over the stable snapshot with no lock held.
worker_pool(s) are visited in worker_pool_idr order.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 174 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1c9f4bf77f10..6e879490c811 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8833,6 +8833,173 @@ static struct bpf_iter_reg worker_pool_iter_reg_info = {
 	.seq_info		= &worker_pool_iter_seq_info,
 };
 
+/*
+ * seq-file BPF iterator over the pending work items of every worker_pool.
+ *
+ * pool->worklist is protected by pool->lock and work_struct has neither a
+ * refcount nor RCU-freeing, so a pending work cannot be handed to a suspended
+ * (open-coded) iterator safely.
+ * Instead, for each pool a bounded snapshot of its pending works is copied out
+ * while pool->lock is held, mirroring the printk_deferred section of
+ * show_one_worker_pool() and then the lock is dropped.
+ * The BPF program then runs over the stable snapshot with no lock held.
+ *
+ * Pools are visited in worker_pool_idr order (a stable resume key); each pool's
+ * snapshot lives in the persistent seq_private, so the walk resumes correctly
+ * across read() chunks. A pool with more than WQ_PENDING_SNAP_MAX pending works
+ * is truncated (best-effort, like the kernel's own worklist dump).
+ */
+#define WQ_PENDING_SNAP_MAX 128
+
+/*
+ * One projected pending work item, as seen by the BPF program. Addresses only
+ * -- the live work_struct is not exposed (it may be freed after the lock).
+ */
+struct wq_pending_work_info {
+	__u64 pool_id;
+	__u64 work;
+	__u64 func;
+};
+
+struct wq_pending_iter_priv {
+	int          next_pool;	/* worker_pool_idr cursor for the next fill */
+	unsigned int idx;	/* position within snap[]                   */
+	unsigned int count;	/* valid entries in snap[]                  */
+	struct wq_pending_work_info snap[WQ_PENDING_SNAP_MAX];
+};
+
+struct bpf_iter__workqueue_pending_work {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct wq_pending_work_info *, info);
+};
+
+/*
+ * Snapshot the next non-empty pool's pending works into priv->snap[], advancing
+ * priv->next_pool past it. Returns true if a pool was captured, false at end.
+ * pool->lock is held only for the field copy; RCU keeps each pool alive.
+ */
+static bool wq_pending_fill(struct wq_pending_iter_priv *priv)
+{
+	struct worker_pool *pool;
+	struct work_struct *work;
+	int id;
+
+	rcu_read_lock();
+	for (id = priv->next_pool; (pool = idr_get_next(&worker_pool_idr, &id)); id++) {
+		unsigned int n = 0;
+
+		raw_spin_lock_irq(&pool->lock);
+		list_for_each_entry(work, &pool->worklist, entry) {
+			if (n >= WQ_PENDING_SNAP_MAX)
+				break;
+			priv->snap[n].pool_id = pool->id;
+			priv->snap[n].work = (__u64)(unsigned long)work;
+			priv->snap[n].func = (__u64)(unsigned long)work->func;
+			n++;
+		}
+		raw_spin_unlock_irq(&pool->lock);
+
+		if (n) {
+			priv->count = n;
+			priv->idx = 0;
+			priv->next_pool = id + 1;
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
+static void *wq_pending_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct wq_pending_iter_priv *priv = seq->private;
+
+	if (*pos == 0) {
+		priv->next_pool = 0;
+		priv->idx = 0;
+		priv->count = 0;
+	}
+	while (priv->idx >= priv->count) {
+		if (!wq_pending_fill(priv))
+			return NULL;
+	}
+	return &priv->snap[priv->idx];
+}
+
+static void *wq_pending_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct wq_pending_iter_priv *priv = seq->private;
+
+	++*pos;
+	priv->idx++;
+	while (priv->idx >= priv->count) {
+		if (!wq_pending_fill(priv))
+			return NULL;
+	}
+	return &priv->snap[priv->idx];
+}
+
+static int wq_pending_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__workqueue_pending_work ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (!prog)
+		return 0;
+	ctx.meta = &meta;
+	ctx.info = v;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void wq_pending_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__workqueue_pending_work ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	if (v)
+		return;
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, true);
+	if (prog) {
+		ctx.meta = &meta;
+		ctx.info = NULL;
+		bpf_iter_run_prog(prog, &ctx);
+	}
+}
+
+static const struct seq_operations wq_pending_seq_ops = {
+	.start	= wq_pending_seq_start,
+	.next	= wq_pending_seq_next,
+	.stop	= wq_pending_seq_stop,
+	.show	= wq_pending_seq_show,
+};
+
+DEFINE_BPF_ITER_FUNC(workqueue_pending_work, struct bpf_iter_meta *meta,
+		     struct wq_pending_work_info *info)
+
+static const struct bpf_iter_seq_info wq_pending_seq_info = {
+	.seq_ops	= &wq_pending_seq_ops,
+	.seq_priv_size	= sizeof(struct wq_pending_iter_priv),
+};
+
+BTF_ID_LIST_SINGLE(wq_pending_work_info_btf_id, struct, wq_pending_work_info)
+
+static struct bpf_iter_reg wq_pending_reg_info = {
+	.target			= "workqueue_pending_work",
+	.feature		= BPF_ITER_RESCHED,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__workqueue_pending_work, info),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &wq_pending_seq_info,
+};
+
 static int __init bpf_workqueue_iter_init(void)
 {
 	int ret;
@@ -8852,7 +9019,12 @@ static int __init bpf_workqueue_iter_init(void)
 		return ret;
 
 	worker_pool_iter_reg_info.ctx_arg_info[0].btf_id = worker_pool_btf_id[0];
-	return bpf_iter_reg_target(&worker_pool_iter_reg_info);
+	ret = bpf_iter_reg_target(&worker_pool_iter_reg_info);
+	if (ret)
+		return ret;
+
+	wq_pending_reg_info.ctx_arg_info[0].btf_id = wq_pending_work_info_btf_id[0];
+	return bpf_iter_reg_target(&wq_pending_reg_info);
 }
 late_initcall(bpf_workqueue_iter_init);
 
-- 
2.43.0

