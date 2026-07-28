Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434093C0635
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221730; cv=none; b=gaNpZdWNCAfYs4vY1mJIAZftHRPrb5hjx/Mh2UlTiBfD+Uzi8Y7RRStFYlUhdWrDuQO+jD8yfQBOT1fivJ2ptvV5zY6dpesuILiOsl29mMSo++M2HMktoR9ZjRb8YLzRDqKRXpQfnkAxD610pgWUAtQ286xXMkH36Ec1egk96ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221730; c=relaxed/simple;
	bh=+T08zibz7eJEXPqi4UP6ZtJIuEgLelxCGTKnuASnZac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hNxYoFO6B7XOqpdLE8dGf5sQbe//4TjS+E9VJuOuZgrp27CpK9nnda4cRbNBdf2F97L1nVD95fXdJUq1RRNcKR+p0n3KFWL1vJqJx89fo3U2B9bOaFKP5ssGByzyvX6KVplXdY6rUf9KQitaJ3lfSzgwajgGXSMEOWA2SK4v9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AXcRzh7p; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AXcRzh7p"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RKd7Uo2924747;
	Tue, 28 Jul 2026 06:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=VtQPi
	chPdmr1ZWZmnCuVvo/9GH88CGoz8z8Lhj9xSxY=; b=AXcRzh7peYXSnMqAfvKQw
	bZChiHTmZXBj5EU5vxkzyGbS6M9IwuFckmnRdcp2tbPzcePNwb74D7xc7JTsJffy
	gjRu5djAeun7DoV0CDO1HZYH9xGpk6alFT4El/BJOB4NE1HYLonotohzlT1Bz4W3
	n8tmLk0laYM8tkmK4PBGHOEhSlVCcx0Df7D9AZElQuxxSsP6xPVUaq0YeywJShj8
	xk8+A9PFKArvah9eLhVjL25wS+Jv5NhjrGii+pXL9svcfWk5N3UvGc7jILEhaAhP
	ca45dSJ0o1ynyBnk6TOVMBtmZyP+q/FYSAvSZgF/pud6eOWaEEDnlv1X3StF2Cmg
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1db9bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwS005855;
	Tue, 28 Jul 2026 06:55:25 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-2;
	Tue, 28 Jul 2026 06:55:25 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 1/6] workqueue: introduce a BPF open-coded iterator for traversing workqueues list
Date: Tue, 28 Jul 2026 14:55:20 +0800
Message-Id: <20260728065525.653171-2-imran.f.khan@oracle.com>
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
X-Proofpoint-GUID: 7Prqkx5aNeJnbsXjMTK9rfA0itLaxg12
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a68525f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=DX8AmLu_gNSThbPtVTYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX9dgNNq9+5zsQ
 3hsQIREQa7Vct0RFCBBFQX3v+QqUCahXGFkhS5e99Kku2s/GoVaPAq2/lN6Y+ZzoQE/50gNrr9C
 39xdnhO10x7UrOiZvxSBJdpqpIxXFYTu/8Hq6nHhlYyo+CK1A2zf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXzqo92p6AXb0O
 Guqn/2I7XLUeUp2KaV29TP73MbbMTi689niHIfZH+bUaf2XLLTZG9azfQ8jIIHRS6dYLMkNqNk+
 yA7chrXyH4/Z5cXVgbzaQOfCZRGDys7hL6EHhmn0rTCxGfqwkclIpRqwSsGVLy92VsnEisoFlsE
 tN2kzQFNbstnyMuqLrKgy+U3+moACpjB4XZgLQczNzEUaves3Rnv9e4EpFIyJzKcNSDBakr+fH2
 F6hxkBU88mrTr5X0ece6gllgkjeW/RkzZ8fD1tLd7FQzUZbt04jDmhQQ/Cvw5H/JA4isShdAu8x
 BMR4i26B8JUXWWhndRzNJ0tCV31YPIFerWYk7WTO0WWb8rIzgDRadjOzYgMqSMqKrSsZGSBaBUI
 einVEpqPMlNACGFLjyhN9L20Jtz0yhDk97GeaCVGomducO05bm40GCUt9qqc+ZSfKy4mccg9MLr
 vJR199eVAuZDGlepe+xFD5X3EIQRjgmSvR2GvwCM=
X-Proofpoint-ORIG-GUID: 7Prqkx5aNeJnbsXjMTK9rfA0itLaxg12

Add bpf_iter_workqueue_{new,next,destroy} kfuncs so BPF programs can walk
every workqueue on the global workqueues list.

The workqueues list is RCU-protected for reads and each workqueue_struct
is freed via call_rcu(), so the iterator is KF_RCU_PROTECTED i.e. the
caller must hold bpf_rcu_read_lock() across new()..destroy(), which keeps
the list and each returned wq alive between next() calls.

The kfuncs live in kernel/workqueue.c because struct workqueue_struct's
list anchor and the workqueues root are local to this file.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78068ae8f28a..c4ec4812db64 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -56,6 +56,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/btf_ids.h>
 
 #include "workqueue_internal.h"
 
@@ -8473,3 +8474,105 @@ static int __init workqueue_unbound_cpus_setup(char *str)
 	return 1;
 }
 __setup("workqueue.unbound_cpus=", workqueue_unbound_cpus_setup);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+/*
+ * BPF open-coded iterator over all workqueues.
+ *
+ * Walks the global @workqueues list, letting BPF programs read live workqueue
+ * state.
+ *
+ * The caller must hold bpf_rcu_read_lock() across new()->next()->destroy().
+ */
+
+/* Sentinel for "new() done, next() not yet called" vs "iteration ended". */
+#define BPF_WQ_ITER_START ((void *)1L)
+
+struct bpf_iter_workqueue {
+	__u64 __opaque[1];
+} __aligned(8);
+
+struct bpf_iter_workqueue_kern {
+	struct workqueue_struct *pos;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_iter_workqueue_new() - Initialize a workqueue iterator
+ * @it: The new bpf_iter_workqueue to initialize
+ *
+ * Iterates every workqueue on the global @workqueues list. Must be used inside
+ * a bpf_rcu_read_lock() region (KF_RCU_PROTECTED).
+ */
+__bpf_kfunc int bpf_iter_workqueue_new(struct bpf_iter_workqueue *it)
+{
+	struct bpf_iter_workqueue_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_workqueue_kern) >
+		     sizeof(struct bpf_iter_workqueue));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_workqueue_kern) !=
+		     __alignof__(struct bpf_iter_workqueue));
+
+	kit->pos = BPF_WQ_ITER_START;
+	return 0;
+}
+
+/**
+ * bpf_iter_workqueue_next() - Get the next workqueue
+ * @it: The bpf_iter_workqueue
+ *
+ * Returns a pointer to the next struct workqueue_struct, or NULL when done.
+ */
+__bpf_kfunc struct workqueue_struct *
+bpf_iter_workqueue_next(struct bpf_iter_workqueue *it)
+{
+	struct bpf_iter_workqueue_kern *kit = (void *)it;
+
+	if (!kit->pos)			/* already reached the end */
+		return NULL;
+
+	if (kit->pos == BPF_WQ_ITER_START)
+		kit->pos = list_first_or_null_rcu(&workqueues,
+						  struct workqueue_struct, list);
+	else
+		kit->pos = list_next_or_null_rcu(&workqueues, &kit->pos->list,
+						 struct workqueue_struct, list);
+	return kit->pos;
+}
+
+/**
+ * bpf_iter_workqueue_destroy() - Destroy a workqueue iterator
+ * @it: The bpf_iter_workqueue to destroy
+ */
+__bpf_kfunc void bpf_iter_workqueue_destroy(struct bpf_iter_workqueue *it)
+{
+	/* No references taken; RCU is held by the caller. */
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(workqueue_iter_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_workqueue_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_workqueue_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_workqueue_destroy, KF_ITER_DESTROY)
+BTF_KFUNCS_END(workqueue_iter_kfunc_ids)
+
+static const struct btf_kfunc_id_set workqueue_iter_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &workqueue_iter_kfunc_ids,
+};
+
+static int __init bpf_workqueue_iter_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&workqueue_iter_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+						&workqueue_iter_kfunc_set);
+}
+late_initcall(bpf_workqueue_iter_init);
+
+#endif /* CONFIG_BPF_SYSCALL */
-- 
2.43.0

