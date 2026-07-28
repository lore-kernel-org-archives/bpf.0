Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6093C4540
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221741; cv=none; b=TIT1CpZkULZo1n3L3w7w4P9eKUcnVMGnz/6GcG04lbCPd9OQhVv1r1yjsGj8veF/GT8d9ECawRFJD9ROSQKnj74w4XvyxGnNjdOZvAFR5+xcm8hqtwKALSQRi7G3ueeVqNth8vCjOHmoK9ui/U/1Nrn4+PhDqV9o8jMU76mEVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221741; c=relaxed/simple;
	bh=zSRr+C0SJmR98fgTKSXkESI62V3RIo7cFlHWYjybWLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGEBoDeDkp7NMtg4MhLUmeDbel3kexwrH2RSFme15ac2pNfVK+mv38jWpx1wCBbphYaxJmtDk4ITY5WOy9Q5mERwhF+Ao60Orj2X2jNgObx+h4VaT57Ds1i+MoxlINdWC22IEcly3RAA0f7DsPLjE5sRP0NyfrAZojSh4aGimQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LJHcubxn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJHcubxn"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0QBTP3511891;
	Tue, 28 Jul 2026 06:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=H1DHM
	vZologUYyFfQeOGa27pqp/qpt1ixoISa7zYmuc=; b=LJHcubxnfClvvLbBixGEZ
	dXPWA6SbY/awvD4meo4e7smWIM2HRAdT8I/3MnAhbUi3si+HJsr1AN/aPmif3dEa
	Jdp2335s9cIaCfGB4jfC1ZrLBMaEhajv0k94kHmfop1jgkn4uK0nxL7jdDnjexE8
	rjCtoM7ZCDTP7ipfJBkA9Vb/HO9Pgmy7l4/SGS5/5V5AW1mMQw8Z7eOSOJIaJhBz
	NapAhpJyI8DxiVh01aiflSvitfMzqi7PEUEfsAjzW74r7o4/yRJtuV+e7tpdogls
	WHMvaq31yAMJX+Lb2nuV+COE7P56o0U6rNwdgz+EKkPEzHvD4o/zKwsEfBtfmc18
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pk90x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwZ005855;
	Tue, 28 Jul 2026 06:55:35 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-7;
	Tue, 28 Jul 2026 06:55:35 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 6/6] selftests/bpf: add tests for the workqueue BPF iterators
Date: Tue, 28 Jul 2026 14:55:25 +0800
Message-Id: <20260728065525.653171-7-imran.f.khan@oracle.com>
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
X-Proofpoint-GUID: mozxtGRryc9SapPypVjPKNfkzSc16zuh
X-Proofpoint-ORIG-GUID: mozxtGRryc9SapPypVjPKNfkzSc16zuh
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a685269 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=lJZZwRgeNoIPLKFnaP0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX0QB2VchF8miO
 /wHcF7PTOs8k7/6K+V78UVeXaY0p06GCksxagi3g1+UvGodAQq7hz705Sg2vpyjbzV7NKpzn6nJ
 3qpWK1Z11PZafVWGinccHpPPi+xc4WHPsXPL8NIUWWgnFu5u+kfnL8OmpuTIJTa8BuJG2e56Yr2
 dDcXdF+rkC1NLLj242l0Q0RmCxSk6ATr5NarrttuCEqSG/DFGHTqbbMnE94NzTblSzZ2ZsMQ7v/
 +SGnxPCjJDgMUt/+/vyM9NHVMMhCJbSR8z8/M0fhHnlYTSclS9g4PNPPVV5Bn8HGZpQDgYTxptC
 wpcDZMvePqx0oCWP3nxOjgmFJN1WVwxDC3nn6a+0ozlIRgUBBSmTZkU9adjVMjAFfKbhKJPnMUV
 GdKEBWtEAequrdiIis0NCTL8A/Qb6rOdC921BNcHM/VNlGMSlptdSLlgVos6O9oMiHiEOuqRxHJ
 9YUfSxwjGrqM7WZx7pgtW/z8zUbwoLFWSbVofH9k=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX+PoAnPERegXt
 Oy3uQQpkVMRHDIFyDbRznfRd5Msn8536w9hUmGhN6xOaDuPSQz33c1aPcqG+MOTZAfO/g6+Ofhz
 EA7VJrWlgBpXAJRDIXvsYm2ONQfPin3X2iNRRp5w8zFZw0m2x7rX

Cover both the open-coded and seq_file forms of the workqueue and
worker_pool iterators, plus the pending-work seq iterator:

 - count_workqueues / count_worker_pools drive the open-coded iterators
   (inside bpf_rcu_read_lock()); userspace checks the counts are non-zero.
 - dump_workqueues / dump_worker_pools attach the seq forms and drain
   them, exercising the RCU-per-chunk seq path that reuses the open-coded
   next().
 - dump_pending attaches the workqueue_pending_work seq iterator and
   drains it, exercising the per-pool snapshot path.
 - wq_iter_fail.c checks the verifier rejects the RCU-protected
   open-coded iterators when used outside an RCU critical section.

Also declare the open-coded iterator kfuncs in bpf_experimental.h.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 10 ++
 .../selftests/bpf/prog_tests/wq_iter.c        | 80 ++++++++++++++++
 tools/testing/selftests/bpf/progs/wq_iter.c   | 95 +++++++++++++++++++
 .../selftests/bpf/progs/wq_iter_fail.c        | 37 ++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wq_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_iter_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 67ff7882299e..6da93c486650 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -361,6 +361,16 @@ extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 
+struct bpf_iter_workqueue;
+extern int bpf_iter_workqueue_new(struct bpf_iter_workqueue *it) __weak __ksym;
+extern struct workqueue_struct *bpf_iter_workqueue_next(struct bpf_iter_workqueue *it) __weak __ksym;
+extern void bpf_iter_workqueue_destroy(struct bpf_iter_workqueue *it) __weak __ksym;
+
+struct bpf_iter_worker_pool;
+extern int bpf_iter_worker_pool_new(struct bpf_iter_worker_pool *it) __weak __ksym;
+extern struct worker_pool *bpf_iter_worker_pool_next(struct bpf_iter_worker_pool *it) __weak __ksym;
+extern void bpf_iter_worker_pool_destroy(struct bpf_iter_worker_pool *it) __weak __ksym;
+
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/wq_iter.c b/tools/testing/selftests/bpf/prog_tests/wq_iter.c
new file mode 100644
index 000000000000..73383c263bee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wq_iter.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "wq_iter.skel.h"
+#include "wq_iter_fail.skel.h"
+
+static void subtest_open_coded(struct wq_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_workqueues),
+				     &opts);
+	if (!ASSERT_OK(err, "run count_workqueues"))
+		return;
+	/* There are always several system workqueues (events, ...). */
+	ASSERT_GT(skel->bss->nr_workqueues, 0, "nr_workqueues");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_worker_pools),
+				     &opts);
+	if (!ASSERT_OK(err, "run count_worker_pools"))
+		return;
+	/* At least the per-CPU normal/highpri pools exist. */
+	ASSERT_GT(skel->bss->nr_worker_pools, 0, "nr_worker_pools");
+	ASSERT_GT(skel->bss->nr_percpu_pools, 0, "nr_percpu_pools");
+}
+
+static void drain_iter(struct bpf_program *prog, const char *name)
+{
+	struct bpf_link *link;
+	char buf[512];
+	int iter_fd;
+	ssize_t n;
+
+	link = bpf_program__attach_iter(prog, NULL);
+	if (!ASSERT_OK_PTR(link, name))
+		return;
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto out;
+	while ((n = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	ASSERT_GE(n, 0, "read iter");
+	close(iter_fd);
+out:
+	bpf_link__destroy(link);
+}
+
+static void subtest_seq(struct wq_iter *skel)
+{
+	/* seq forms are backed by the same open-coded next(). */
+	drain_iter(skel->progs.dump_workqueues, "attach workqueue iter");
+	ASSERT_GT(skel->bss->nr_wq_seq, 0, "nr_wq_seq");
+
+	drain_iter(skel->progs.dump_worker_pools, "attach worker_pool iter");
+	ASSERT_GT(skel->bss->nr_pool_seq, 0, "nr_pool_seq");
+
+	/*
+	 * worklists are usually empty on an idle system; this drives the whole
+	 * per-pool snapshot path and verifies it drains cleanly.
+	 */
+	drain_iter(skel->progs.dump_pending, "attach pending_work iter");
+}
+
+void test_wq_iter(void)
+{
+	struct wq_iter *skel;
+
+	skel = wq_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "wq_iter__open_and_load"))
+		return;
+
+	if (test__start_subtest("open_coded"))
+		subtest_open_coded(skel);
+	if (test__start_subtest("seq"))
+		subtest_seq(skel);
+
+	wq_iter__destroy(skel);
+
+	RUN_TESTS(wq_iter_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/wq_iter.c b/tools/testing/selftests/bpf/progs/wq_iter.c
new file mode 100644
index 000000000000..15f081bc634b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wq_iter.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+/* Results, checked by userspace. */
+int nr_workqueues;
+int nr_worker_pools;
+int nr_percpu_pools;
+int nr_wq_seq;
+int nr_pool_seq;
+int nr_pending;
+
+/* --- open-coded iterators (KF_RCU_PROTECTED) --- */
+
+SEC("syscall")
+int count_workqueues(const void *ctx)
+{
+	struct workqueue_struct *wq;
+	int n = 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(workqueue, wq)
+		n++;
+	bpf_rcu_read_unlock();
+
+	nr_workqueues = n;
+	return 0;
+}
+
+SEC("syscall")
+int count_worker_pools(const void *ctx)
+{
+	struct worker_pool *pool;
+	int n = 0, percpu = 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(worker_pool, pool) {
+		n++;
+		if (pool->cpu >= 0)		/* per-CPU pool */
+			percpu++;
+	}
+	bpf_rcu_read_unlock();
+
+	nr_worker_pools = n;
+	nr_percpu_pools = percpu;
+	return 0;
+}
+
+/* --- seq_file iterators --- */
+
+SEC("iter/workqueue")
+int dump_workqueues(struct bpf_iter__workqueue *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct workqueue_struct *wq = ctx->wq;
+
+	if (!wq)
+		return 0;
+	nr_wq_seq++;
+	BPF_SEQ_PRINTF(seq, "%s\n", wq->name);
+	return 0;
+}
+
+SEC("iter/worker_pool")
+int dump_worker_pools(struct bpf_iter__worker_pool *ctx)
+{
+	struct worker_pool *pool = ctx->pool;
+
+	if (!pool)
+		return 0;
+	nr_pool_seq++;
+	return 0;
+}
+
+SEC("iter/workqueue_pending_work")
+int dump_pending(struct bpf_iter__workqueue_pending_work *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct wq_pending_work_info *info = ctx->info;
+
+	if (!info)			/* final call */
+		return 0;
+
+	nr_pending++;
+	BPF_SEQ_PRINTF(seq, "pool %llu work 0x%llx func 0x%llx\n",
+		       info->pool_id, info->work, info->func);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/wq_iter_fail.c b/tools/testing/selftests/bpf/progs/wq_iter_fail.c
new file mode 100644
index 000000000000..fb2dcf9847e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wq_iter_fail.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * The workqueue and worker_pool open-coded iterators are KF_RCU_PROTECTED:
+ * using them outside a bpf_rcu_read_lock() region must be rejected.
+ */
+
+SEC("?syscall")
+__failure __msg("kernel func bpf_iter_workqueue_new requires RCU critical section protection")
+int workqueue_iter_no_rcu(const void *ctx)
+{
+	struct workqueue_struct *wq;
+	int n = 0;
+
+	bpf_for_each(workqueue, wq)
+		n++;
+	return n;
+}
+
+SEC("?syscall")
+__failure __msg("kernel func bpf_iter_worker_pool_new requires RCU critical section protection")
+int worker_pool_iter_no_rcu(const void *ctx)
+{
+	struct worker_pool *pool;
+	int n = 0;
+
+	bpf_for_each(worker_pool, pool)
+		n++;
+	return n;
+}
-- 
2.43.0

