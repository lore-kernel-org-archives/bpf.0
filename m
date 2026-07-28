Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEE3C3F58
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221732; cv=none; b=EQME/gMQD4y3gSYrDi6YfQTjn5b0Z7hFgrhuWj5/Brko3/GK7aT1YdqXp5LIO+SAZyMzPYzDNv4yqs2tF+DnvfwPysV4JtLtiZdfS5UvQJZsnbn9ql+TvloG2U+HJb8w5DnuG/fYzpsi5tEYJSkr82jKwyVAJr6IGbDT+1o5zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221732; c=relaxed/simple;
	bh=k4sQRa5b7rHpg7xCj4GY9TDYIHe+rnglJe867AbjbSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kB0XULV2frk3eE5yqzrabLqHubUvIgYxfQQSI69e5i3IeiEF6uOuNqS1uGoHEHbUoUtuu123qYRnv4broE73sJsG6SENwiqTJ+XC3Yh+GRJD3rAKAfOfItLwLzjrBR8cnOQO4Eg7oSKuYbkaVYlsI/rCcBzkiU3czgTNFjGKfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATHbZMPj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATHbZMPj"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RKeILk2970212;
	Tue, 28 Jul 2026 06:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8/6Lk
	m8rQ3g/XousWfX6BdrKr202BIPzvG6TisS3i5E=; b=ATHbZMPjYC+hFEvG2vblT
	l87a9Bg7pUgR9cApaqY99I9rB8mjQCG8VFgz4yyjx6RoP/ho0iRjnklG+LlGCTDW
	y6drUfA+as6x7uByMEXM0l/yewsHgouF7aLfFRPcP9xZUU6k8i5JkYfnGAboIjX+
	lJ0ndzPMxP8QmNdgeCn60E4pLnEOR+52OjnKkemne9akfIBOt4MoVZZBKlb4U8nM
	oB+cKVq64bLyQFUJpOMmQfI1+UtHhiwDg8sIJbDan5x52XCfDPayMCIfi/8fGxBZ
	3lbxo6hpCNA0ovgK7CTd6pdGRDiKF0tugvELhyja9vcabY34lmSk142dJf3Fzkut
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5xu9d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwU005855;
	Tue, 28 Jul 2026 06:55:27 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-3;
	Tue, 28 Jul 2026 06:55:27 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 2/6] workqueue: introduce a seq_file form for the workqueue iterator
Date: Tue, 28 Jul 2026 14:55:21 +0800
Message-Id: <20260728065525.653171-3-imran.f.khan@oracle.com>
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
X-Proofpoint-ORIG-GUID: gUcCgNoXZ7ugpYG5K7_Uz4P_aRV7rijz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX24mvVSSepeRO
 drtd59diDPyUftetgPCAqFqfoCT1h2qKcJyB7ZMT/H/7APGYRvUlkaWp9mrZuQsAa+hXYCjTOFK
 +AjDFkZHKRLGeUbQho+5rmQ56XtNijQ58BWbX425vPp9cyZoUq2tDeIqxC0yYGMvgTIIcOP9rpt
 e6ZdhvqOp+jIrezY2/y7khVZTojohefrzSqfSMpQuoisTZ/SLqZlv20c3T1vmpxZGmz9rNkYscZ
 gWfLQCEBtUNU8PQBN4qqgO9ttjZ7cCfdSKSFqkhZPTLLP0IMuDQAPkKszmjrhe7XUU+1U9Bm5r7
 9BjwPStw0zKohak+OG/4CJYqQBVQfnwyEClaLgPnOa4sGe8Er9h9DwnFzzgMe2uTuprxWxe7Bhl
 Au22ja1xUxTVjXMw8zyL/DNdyQh1DNI153g0EuLXdm3FcukMrot78WuJrVIvl38hAzF3gTVv87E
 k0Eo/iDbUOnhgoQKeEjDkvSQs5LCHNYYr49in0jM=
X-Proofpoint-GUID: gUcCgNoXZ7ugpYG5K7_Uz4P_aRV7rijz
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a685261 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=mN-Ousg2l8VgQ7UrM7oA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX8mwHbvrohfKM
 yhs+qaprK37hvGPm/I+se2lkvqbKhlBG0fVmAoJDR58PNrV70PirBQ40tlqtJ/iY1+HcIiYnp9i
 xw/huygNX2dPmuaitBU8HtWZCqOZsvLp6hVf+/2tsUq/AST/M2bH

Add a 'workqueue' BPF iterator target (bpftool-iter / pinnable) that
reuses the open-coded bpf_iter_workqueue_next().

Since the open-coded next() is KF_RCU_PROTECTED, the seq path supplies the
RCU section: seq_start() takes rcu_read_lock() and holds it across the read
chunk, so the returned workq and the cursor stay alive while the program
runs and next() steps; position is re-derived from *pos on each start, so
the cursor is never dereferenced across the RCU gap between chunks.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 119 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c4ec4812db64..bb109d851d1c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -57,6 +57,7 @@
 #include <linux/delay.h>
 #include <linux/irq_work.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf.h>
 
 #include "workqueue_internal.h"
 
@@ -8564,14 +8565,128 @@ static const struct btf_kfunc_id_set workqueue_iter_kfunc_set = {
 	.set	= &workqueue_iter_kfunc_ids,
 };
 
+/*
+ * seq_file form of the workqueue iterator. It reuses the open-coded
+ * bpf_iter_workqueue_next().
+ *
+ * Since the open-coded next() is KF_RCU_PROTECTED, the seq path supplies
+ * the RCU section itself.
+ * seq_start() takes rcu_read_lock() and holds it across the whole read chunk
+ * (start..stop). Position is re-derived from *pos on each start, so nothing
+ * is dereferenced across the rcu gap between chunks. The attached BPF program
+ * must be non-sleepable.
+ */
+union workqueue_iter_priv {
+	struct bpf_iter_workqueue it;
+	struct bpf_iter_workqueue_kern kit;
+};
+
+struct bpf_iter__workqueue {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct workqueue_struct *, wq);
+};
+
+static void *workqueue_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	union workqueue_iter_priv *p = seq->private;
+	struct workqueue_struct *wq;
+	loff_t cnt = 0;
+
+	rcu_read_lock();	/* held until seq_stop() */
+	list_for_each_entry_rcu(wq, &workqueues, list) {
+		if (cnt == *pos) {
+			p->kit.pos = wq;
+			return wq;
+		}
+		cnt++;
+	}
+	p->kit.pos = NULL;
+	return NULL;
+}
+
+static void *workqueue_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	union workqueue_iter_priv *p = seq->private;
+
+	++*pos;
+	return bpf_iter_workqueue_next(&p->it);
+}
+
+static int workqueue_iter_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__workqueue ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (!prog)
+		return 0;
+	ctx.meta = &meta;
+	ctx.wq = v;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void workqueue_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__workqueue ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	if (!v) {
+		meta.seq = seq;
+		prog = bpf_iter_get_info(&meta, true);
+		if (prog) {
+			ctx.meta = &meta;
+			ctx.wq = NULL;
+			bpf_iter_run_prog(prog, &ctx);
+		}
+	}
+	rcu_read_unlock();	/* paired with seq_start() */
+}
+
+static const struct seq_operations workqueue_iter_seq_ops = {
+	.start	= workqueue_iter_seq_start,
+	.next	= workqueue_iter_seq_next,
+	.stop	= workqueue_iter_seq_stop,
+	.show	= workqueue_iter_seq_show,
+};
+
+DEFINE_BPF_ITER_FUNC(workqueue, struct bpf_iter_meta *meta,
+		     struct workqueue_struct *wq)
+
+static const struct bpf_iter_seq_info workqueue_iter_seq_info = {
+	.seq_ops	= &workqueue_iter_seq_ops,
+	.seq_priv_size	= sizeof(union workqueue_iter_priv),
+};
+
+BTF_ID_LIST_SINGLE(workqueue_btf_id, struct, workqueue_struct)
+
+static struct bpf_iter_reg workqueue_iter_reg_info = {
+	.target			= "workqueue",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__workqueue, wq),
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
+	},
+	.seq_info		= &workqueue_iter_seq_info,
+};
+
 static int __init bpf_workqueue_iter_init(void)
 {
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
 					&workqueue_iter_kfunc_set);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
-						&workqueue_iter_kfunc_set);
+	if (ret)
+		return ret;
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&workqueue_iter_kfunc_set);
+	if (ret)
+		return ret;
+
+	workqueue_iter_reg_info.ctx_arg_info[0].btf_id = workqueue_btf_id[0];
+	return bpf_iter_reg_target(&workqueue_iter_reg_info);
 }
 late_initcall(bpf_workqueue_iter_init);
 
-- 
2.43.0

