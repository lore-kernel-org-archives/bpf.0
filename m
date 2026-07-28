Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B33C1412
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221734; cv=none; b=pRQ6kgaDWg4o6nFEb0MHAc+Ov/3vwwWr/ZyZaJue+C1MGuhYQekWmgJTM4aP8vVDfqyTxfTORmgOCQ529LPjsNe9ctrbnID/k6c4J0adG1zz74Kw+882A2pogXwYE+fs6ZyWbBI1jHd6CmBtBp4pzSLnkGWPlXS8SJfdNQSdBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221734; c=relaxed/simple;
	bh=XG6dy3qtw+GNZl+9Xpk4e9fOGtQ/QouFn/wrmfB5fTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxiJH8UQbPT3Ue1442yvYhsGkiRrOHgtYQiWkG/jW+/xOE58eaBajdza8yGGIisoOPIRTrLS7aViinehmUZweYm1uUsXGuQOjWsT7jAyjloEGs9lLpnv8LfhDQ13oAewqUuvy2b4VUhT1jua77MgdK9vk3pQu64m2B1SrQMuVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEjLk9ts; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OEjLk9ts"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RKdtjb2969025;
	Tue, 28 Jul 2026 06:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OT+SM
	czK9DJfy/0OeFRd9UUAANu+GKXrw0KEuI+hSyo=; b=OEjLk9tsv4ZnM7xv9XjMv
	E7y14HbjG16prKNXxENNM97jkRSu9SG3OyR42FucsyY+gwxXuaXEx3xvTNdrLet7
	TYal7tS17roT5k9efbOJnTYIU89JesjuSJkgWOlIriHYpYtdXXH+dH8MezJmMHiT
	oi7C/Vy/lNw9d362W9LR7PSohBMnV+/fpV+/weFoorBjJbKtauBkuISCz8rmgtkQ
	VaSGHSvEniZhQeOAUr9+y/8/EFw+SErgGWO3fs2FkSSnsPh+9RWGMO5cSV6OghNw
	rKJ9S2+NZCoH9Pvs4AVgUoNEMG8NvO54NBhs7wIM+N+hUnODdVsin0FWk4LFsigs
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5xu9ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwV005855;
	Tue, 28 Jul 2026 06:55:29 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-4;
	Tue, 28 Jul 2026 06:55:29 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 3/6] workqueue: introduce open-coded BPF iterator for worker pools
Date: Tue, 28 Jul 2026 14:55:22 +0800
Message-Id: <20260728065525.653171-4-imran.f.khan@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9Eby4Z8b78l4RSsYoYhezTR7Vly0irGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX7VtI4gA05fuA
 AOzJJMbuJRkcf2rntie7CuUlK3kmyNuwnMmNslnUaajA/0R5idXMzBBdUMs8BC1lAz4m2DgMkBB
 bTk773DPDots8thFlFkMkaha6jpluEEsy7/G6wIIKeKqyKa893H8FjoGWQNw6WRtR1N3+jXziWA
 TgvF7hY5R6i0HHwoNpox6aGVt9B+BWySZVSKhAc+dfIOAK39xH7V/iZhFN7LEe5DwlEjpb35Vru
 ECTJiMyKV4HfRQCd4WGdOm3exQWcksGww5x0yFMAKA8FMDYF/5hDRqlpu38MZ8JD96ErKgF+lAR
 V88Sz4/Wu4m2tm12P9yVKB0txnKT5zhnZSTb2L719aNPcvYaVzILwKYfHmOO8lFsEtuGzYzh2OT
 E+KKibZiT30slKRqc7Or4cX7IQ8+mBwPcl/+X4XL9pDYtGkVxgQVPUZIE3efG4olVkche3IUp5o
 57+TlXXwQefKuTHzl7bftZ10Za1iq/fz9wJiESsk=
X-Proofpoint-GUID: 9Eby4Z8b78l4RSsYoYhezTR7Vly0irGE
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a685263 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=88zh6cTEC_PEPNzAG-gA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX1v62HiFvidGa
 k9e6t8iNWv1CuuSiePxOSNA1AXD87BwkaK93hqcCqioiMBGFotT/6jJSGNkkaIoFIO7YYSPzgaR
 Nk5WGpZP5Na+ac7PPVF/orsD1Hf5WYIz8Ev8gGkFZqG4jybSBZit

Add bpf_iter_worker_pool_{new,next,destroy} kfuncs so BPF programs can
walk every worker_pool in the system via worker_pool_idr, in ascending
pool-id order.
This mirrors the pool enumeration in the drgn tools/workqueue/wq_dump.py
script.

The idr walk (idr_get_next) runs as kernel C, so no BPF-side idr support
is needed. worker_pool_idr is RCU-readable and each worker_pool is freed
via call_rcu(), so the iterator is KF_RCU_PROTECTED, like the workqueue
iterator: the caller holds bpf_rcu_read_lock() across new()..destroy().

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb109d851d1c..039b2d0c8669 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8498,6 +8498,14 @@ struct bpf_iter_workqueue_kern {
 	struct workqueue_struct *pos;
 } __aligned(8);
 
+struct bpf_iter_worker_pool {
+	__u64 __opaque[1];
+} __aligned(8);
+
+struct bpf_iter_worker_pool_kern {
+	int id;		/* next worker_pool_idr id to search from */
+} __aligned(8);
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -8552,12 +8560,64 @@ __bpf_kfunc void bpf_iter_workqueue_destroy(struct bpf_iter_workqueue *it)
 	/* No references taken; RCU is held by the caller. */
 }
 
+/**
+ * bpf_iter_worker_pool_new() - Initialize a worker_pool iterator
+ * @it: The new bpf_iter_worker_pool to initialize
+ *
+ * Iterates every worker_pool in the system (worker_pool_idr) in ascending
+ * pool-id order.
+ * The caller should hold RCU read lock.
+ */
+__bpf_kfunc int bpf_iter_worker_pool_new(struct bpf_iter_worker_pool *it)
+{
+	struct bpf_iter_worker_pool_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_worker_pool_kern) >
+		     sizeof(struct bpf_iter_worker_pool));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_worker_pool_kern) !=
+		     __alignof__(struct bpf_iter_worker_pool));
+
+	kit->id = 0;
+	return 0;
+}
+
+/**
+ * bpf_iter_worker_pool_next() - Get the next worker_pool
+ * @it: The bpf_iter_worker_pool
+ *
+ * Returns a pointer to the next struct worker_pool, or NULL when done.
+ */
+__bpf_kfunc struct worker_pool *
+bpf_iter_worker_pool_next(struct bpf_iter_worker_pool *it)
+{
+	struct bpf_iter_worker_pool_kern *kit = (void *)it;
+	struct worker_pool *pool;
+
+	/* idr_get_next() is RCU-safe; see the for_each_pool() lock legend. */
+	pool = idr_get_next(&worker_pool_idr, &kit->id);
+	if (pool)
+		kit->id++;	/* advance past this pool for the next call */
+	return pool;
+}
+
+/**
+ * bpf_iter_worker_pool_destroy() - Destroy a worker_pool iterator
+ * @it: The bpf_iter_worker_pool to destroy
+ */
+__bpf_kfunc void bpf_iter_worker_pool_destroy(struct bpf_iter_worker_pool *it)
+{
+	/* Nothing to be done; RCU is held by the caller. */
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(workqueue_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_workqueue_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_workqueue_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_workqueue_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_worker_pool_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_worker_pool_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_worker_pool_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(workqueue_iter_kfunc_ids)
 
 static const struct btf_kfunc_id_set workqueue_iter_kfunc_set = {
-- 
2.43.0

