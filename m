Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4663BED32
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221738; cv=none; b=C/73AnQleeHwrpPfNmB+vHTPGaIQ9syZkrAUzEU9mD2PrjnfCRjNRmmgUEK33bnVr67/RdqbyYmPY4SNuyPkQSuFr+JwCXBukXx/cjWd2/Nk0+5S40dHH4Dx7aMdF2RGRzmAjONykZnrkyCdUmPp70YMv7Y/+sL0sNJ5UpgekDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221738; c=relaxed/simple;
	bh=jGtjOrY2MFEOhr489+SG2r1bWOP5NdKf51+ekyh6d+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZFMKkVzI/jVhuPdM4/XxXWIgAGT7OlgxwCiJK+BAbZan6o+8mIAxS7WnfDFKc7hgr/emH2tbvrv1h/CHugETqCubY1UohGrdyGhsKJIzjQTiKELov5+t5ssJQbOHhADr8Mv6NegsSQwHB60nitNZPXu/Bex1aWkDPx3jKiQl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZJiI8Pu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZJiI8Pu"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RKd6Mh3119252;
	Tue, 28 Jul 2026 06:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=IQe7z
	cB20/CvlpzzW4XyVzJKWmE0zk5GqQzqDWYGY40=; b=mZJiI8Puy4jmvG33N5A8U
	bcuE/gBkNLDfHVJ0OGgApuzjpItQY9fkWj792CRv89ON2JEU5jNvuVoyk7O8ehpi
	grOkwud8/7rhDTHHAFjjZsliTYN/HyHE9h9nch7XtAc5nWvaeIizGLNsg5j7kTkr
	/DL4N4givQDSEw09g0/C2VPPdBjq5Sz3kQht60YMx3+JytgWhE4jkRyHSmDzqIdF
	9gO5zhowVX75rsnPhZmyepngL6yquF0mAuRhmw3oTJhMr7sQfoNJAy6NG7JKbdUo
	hhTUeg2UidxyPrQO/oASIiqV3Oyv/qJDMHeQCd7cmGOM4R9RXBaOfmBc7U/N0Bay
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pk8yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwW005855;
	Tue, 28 Jul 2026 06:55:31 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-5;
	Tue, 28 Jul 2026 06:55:31 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 4/6] workqueue: introduce seq_file form of the worker_pool iterator
Date: Tue, 28 Jul 2026 14:55:23 +0800
Message-Id: <20260728065525.653171-5-imran.f.khan@oracle.com>
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
X-Proofpoint-GUID: 1DOcJbtcndkXEQp20mdgDN94ZJQVtlvl
X-Proofpoint-ORIG-GUID: 1DOcJbtcndkXEQp20mdgDN94ZJQVtlvl
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a685265 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=nswENinKeBDoRR3h1fwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXwLP6eoDTpQIM
 SBjgGaH1ckUrWCGMfQ/vXhd6J8NapxqzmP75M54X7NUSknNWYDONnjo1O7dyO1LGraEZ9mzC2xT
 Z+dIyfoKrPaPaOVLaMpam8c7iQ3VvK5npXdwLjfLwdaf4sfCrCLzqSFIPc/mhq2VcK1ceZ/boOM
 tq1UakPENEvgBRnsK+R9uEoYGevgLUq1fpifyo6k4HWZZ7f/3QO27ZgRbuYQeSPu567w6l2oErH
 i+C/UwEd8sBqJc9F3YkZGaZ7sC7GvZJ0aj2BVpRigRAToTJf8XwU1x86jTC/COEBzk9V54XlQe0
 aSvqq/idRGlAzbSCKAa6E6LK4gCx6+OO/AWfw081XIJy5G23UuwLlTxjw8jFuva4CVDBWLnE4nN
 +GCNOKOPR5TueC00ASCoQIruq+f/33VZrasWsZCtylaLU+bhzMhI/6E1xuCmvoABjIfDD8pN/pk
 q4P3jplrvDHOP522ylTq0MQeUVLms9B8qDIrKJtQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX8PQeVkAya8ga
 6phDO7DehmyGpXiyv81E21hjeVUwZiTke5hsFsMdbsNQSdvkG39LPL1nEQRUO/vj3Oe3S62N8QU
 Cs/lnBDXLK5+EfGWh1Y59cjSthvHx/Om8MyMzC15Kv/Z7tdHnUDV

Add a 'worker_pool' BPF iterator target, backed by the open-coded
bpf_iter_worker_pool_next() via a shared union, using the same
RCU-per-chunk scheme as the workqueue seq iterator.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 108 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 039b2d0c8669..1c9f4bf77f10 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8732,6 +8732,107 @@ static struct bpf_iter_reg workqueue_iter_reg_info = {
 	.seq_info		= &workqueue_iter_seq_info,
 };
 
+/*
+ * seq_file form of the worker_pool iterator; same RCU-per-chunk scheme as the
+ * workqueue one, reusing the open-coded bpf_iter_worker_pool_next().
+ */
+union worker_pool_iter_priv {
+	struct bpf_iter_worker_pool it;
+	struct bpf_iter_worker_pool_kern kit;
+};
+
+struct bpf_iter__worker_pool {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct worker_pool *, pool);
+};
+
+static void *worker_pool_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	union worker_pool_iter_priv *p = seq->private;
+	struct worker_pool *pool;
+	loff_t cnt = 0;
+	int id = 0;
+
+	rcu_read_lock();
+	while ((pool = idr_get_next(&worker_pool_idr, &id))) {
+		if (cnt == *pos) {
+			p->kit.id = id + 1;
+			return pool;
+		}
+		cnt++;
+		id++;
+	}
+	return NULL;
+}
+
+static void *worker_pool_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	union worker_pool_iter_priv *p = seq->private;
+
+	++*pos;
+	return bpf_iter_worker_pool_next(&p->it);
+}
+
+static int worker_pool_iter_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__worker_pool ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (!prog)
+		return 0;
+	ctx.meta = &meta;
+	ctx.pool = v;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void worker_pool_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__worker_pool ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	if (!v) {
+		meta.seq = seq;
+		prog = bpf_iter_get_info(&meta, true);
+		if (prog) {
+			ctx.meta = &meta;
+			ctx.pool = NULL;
+			bpf_iter_run_prog(prog, &ctx);
+		}
+	}
+	rcu_read_unlock();
+}
+
+static const struct seq_operations worker_pool_iter_seq_ops = {
+	.start	= worker_pool_iter_seq_start,
+	.next	= worker_pool_iter_seq_next,
+	.stop	= worker_pool_iter_seq_stop,
+	.show	= worker_pool_iter_seq_show,
+};
+
+DEFINE_BPF_ITER_FUNC(worker_pool, struct bpf_iter_meta *meta,
+		     struct worker_pool *pool)
+
+static const struct bpf_iter_seq_info worker_pool_iter_seq_info = {
+	.seq_ops	= &worker_pool_iter_seq_ops,
+	.seq_priv_size	= sizeof(union worker_pool_iter_priv),
+};
+
+BTF_ID_LIST_SINGLE(worker_pool_btf_id, struct, worker_pool)
+
+static struct bpf_iter_reg worker_pool_iter_reg_info = {
+	.target			= "worker_pool",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__worker_pool, pool),
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
+	},
+	.seq_info		= &worker_pool_iter_seq_info,
+};
+
 static int __init bpf_workqueue_iter_init(void)
 {
 	int ret;
@@ -8746,7 +8847,12 @@ static int __init bpf_workqueue_iter_init(void)
 		return ret;
 
 	workqueue_iter_reg_info.ctx_arg_info[0].btf_id = workqueue_btf_id[0];
-	return bpf_iter_reg_target(&workqueue_iter_reg_info);
+	ret = bpf_iter_reg_target(&workqueue_iter_reg_info);
+	if (ret)
+		return ret;
+
+	worker_pool_iter_reg_info.ctx_arg_info[0].btf_id = worker_pool_btf_id[0];
+	return bpf_iter_reg_target(&worker_pool_iter_reg_info);
 }
 late_initcall(bpf_workqueue_iter_init);
 
-- 
2.43.0

