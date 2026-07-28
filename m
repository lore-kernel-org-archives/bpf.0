Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1D3C2761
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221729; cv=none; b=BIlOzyDrogkz6+7clL1UzroMKG3p4WTUemCKr1h6nf7OFJCiwcITFIHxk4+TVyQYiiKihILgj0zzmYWiiSXcqVVWZG2ImMuylDL1rVv9xwqf3wB15tBaHcxDbqVPWAGoVA1shvdUB7eEa27+6c44zRHN0UUu3k974Ed90yplZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221729; c=relaxed/simple;
	bh=F4hAoLgG0LbeRNDHia+FOet+jzxv2rATt4OBXQ15nT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN52Z0UoLOQeP7KhT/TiGwUnL3ldNHVWUnB9um2AMxlaSgu2n1CIOR6/fL836351sertdN3AWHNcXzHWrUjUGCEonkN7pXOl6RB+4NnOEtNkhAGIzTyfdWxTNvxPqYNgH4WQl3QcA444kVSOlLhYNEmmQvMZ4WjuQUPDTqL9510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/Rjrg4C; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/Rjrg4C"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S2tsXo3615114;
	Tue, 28 Jul 2026 06:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=zw529LBpqhz77He7tmczB5SOaUbyZ
	m8oX8zU5wgmC8M=; b=F/Rjrg4C7e1zGaT3BNw6W5ltebCR1sIy9KcvVQkLHL6mj
	KQwsolbncKFyGy4vsyAbXT/E5+mIsP3qGyRj+ycF/mWd5bZJRZbAxeIs5rXq+NdM
	oilrCCAgDg5vgI2qon0nTRvNfstY4tf8K4qm47FTSPbP1GLGefYCt+KO/iYyEbif
	Lr0qjC/7EQ0US3uH+sOXRw3btS8CQxfkLpKNjVgLKyYTzc2ZUil2N0RAJ5uTrObX
	0rigMjZz4ZDzoCVrWM8N5+8UbIKG/KhtG7t158akgTzD9z3d6aj5HOb45s9tPldi
	qN3FwyHx5oES9GtDXUGxegLpeoyxvIA/A8XDRSLTg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5xu9c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 06:55:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6jWwR005855;
	Tue, 28 Jul 2026 06:55:23 GMT
Received: from imran-metabox.au.oracle.com (dhcp-10-191-105-207.vpn.oracle.com [10.191.105.207])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fnh6pbcd5-1;
	Tue, 28 Jul 2026 06:55:23 +0000 (GMT)
From: Imran Khan <imran.f.khan@oracle.com>
To: bpf@vger.kernel.org
Cc: tj@kernel.org
Subject: [PATCH bpf-next 0/6] workqueue: introduce BPF iterators for workqueues, worker pools and pending work
Date: Tue, 28 Jul 2026 14:55:19 +0800
Message-Id: <20260728065525.653171-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: RmA47GTxAdbkMfny0YqdI53N2OYLCvyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX5tPoP+RQSfbY
 S97bH+zbJqQcz/6ygeHNObhs1sNHJKk1QSY+wQBTM4Aq7s6119jJxV5P5emQEO7+h6lxI4ZHsUr
 nK5xUdb9PUVoML1+ix+JPQAo3ULwD9EDGoGF3r+cY/yzaSue3cB4nxmIkz0up7HePtlwwpU8htz
 pVamUxV8EDhB6pQ+3RsLp2B9S1tAzTEOPQeu5cJu7CH/ND48JD1+jGicMRnzv/+MjOXLO3ylMkf
 rTNsJiVjXTKME6Ow/O7EtlRhC5e51idt/TTkzHZxPS+6h0l+5F+Yl5JF+MsyuTYRDubqHxKIBUr
 AMd98TYmoyi6cqJbPxmPkHwBz5FQ0TgftW3DoECjHoGtoEWUk9VXZVurzt4wU1w2bYWofRqLF7M
 cu4HFoG3nBn/fsHVQAqj3h52zaUv8N7hdE0zz0r2lH6mxDm0EKoqFiqP940R+OwTCL2WseQ6SB8
 z+DtEN4hIXeKqIBMmJ+a8leWQLvDnyR93BMbG0bc=
X-Proofpoint-GUID: RmA47GTxAdbkMfny0YqdI53N2OYLCvyP
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a68525d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=NEAV23lmAAAA:8 a=H-lqUA5wwyf7O6gCLfkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXxaO1ZgBjOsFW
 7tmVCXcY7qx5ncgDFzNlLjggkBEX6bqf5/yW6zBTVa/9zDSU4abeOqzsWfhPdZ0BTmHTfdWbUXU
 Wo2JKVuJghjFSjcKevHnPSnkE81WgYiPJSU6yLD07H++yQmIrKSM

Nearly every subsystem defers work to workqueues, and their state can
already be observed on a live system, just not at a granularity that is
convenient to consume. sysrq dumps every workqueue and pool to the kernel
log in a fixed format, with no way to select or aggregate; the WQ_SYSFS
interface only covers workqueues that ask for it and exposes attributes
rather than runtime state; and the drgn scripts under tools/workqueue/ need
a debuginfo-equipped userspace and read the state from the outside, without
the locks that protect it.

This series adds BPF iterators for workqueues, worker pools and pending
work items, so that this state can be walked from inside the kernel, under
the right locking, with filtering and aggregation done in place and only
the interesting part copied to userspace.

For the workqueue and worker_pool targets both forms are provided: the
open-coded form (bpf_iter_*_{new,next,destroy} kfuncs), usable from any BPF
program and thus combinable with other tracing and with maps, and the
seq_file form, pinnable to bpffs and readable via bpftool iter or read(),
for standalone dump-on-demand tools.

Patches:

 1-2: workqueue iterator. Walks the global workqueues list. The list is
      RCU-protected for reads and workqueue_struct is freed via call_rcu(),
      so the open-coded iterator is KF_RCU_PROTECTED and the caller must
      hold bpf_rcu_read_lock() across new()..destroy(). The seq form
      supplies the RCU section itself, per read chunk, and re-derives the
      position from *pos on each start so nothing is dereferenced across
      the gap between chunks.

 3-4: worker_pool iterator. Walks worker_pool_idr in ascending pool-id
      order, mirroring the pool enumeration done by wq_dump.py. The idr
      walk stays in kernel C (idr_get_next()), so no BPF-side idr support
      is needed. Same RCU rules and same seq scheme as above.

   5: pending work iterator ("workqueue_pending_work"), seq_file only.
      This one is deliberately not open-coded: pool->worklist is protected
      by pool->lock, and struct work_struct has neither a refcount nor
      RCU-freeing, so a pending work item cannot be kept alive for a
      suspended iterator. Instead a bounded snapshot of a pool's pending
      works (pool id, work address, work function) is copied out while
      pool->lock is held, and the BPF program then runs over that stable
      snapshot with no lock held. Pools are visited in worker_pool_idr
      order, which is a stable resume key across read() chunks; a pool with
      more than WQ_PENDING_SNAP_MAX pending works is truncated, best-effort,
      like the kernel's own worklist dump.

   6: selftests covering both forms of the workqueue and worker_pool
      iterators, the pending-work iterator, and a verifier test that the
      RCU-protected open-coded iterators are rejected outside an RCU
      critical section.

All new code sits behind CONFIG_BPF_SYSCALL. Tested with
"test_progs -t wq_iter" and result has been pasted below:
....
+ [ -x /etc/rcS.d/S50-startup ]
+ /etc/rcS.d/S50-startup
./test_progs -t wq_iter
[    1.105718] bpf_testmod: loading out-of-tree module taints kernel.
[    1.106438] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
719/1   wq_iter/open_coded:OK
719/2   wq_iter/seq:OK
719/3   wq_iter/workqueue_iter_no_rcu:OK
719/4   wq_iter/worker_pool_iter_no_rcu:OK
719     wq_iter:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
....

A PR for this changeset has been created at [1].

Thanks,
Imran

Imran Khan (6):
  workqueue: introduce a BPF open-coded iterator for traversing
    workqueues list
  workqueue: introduce a seq_file form for the workqueue iterator
  workqueue: introduce open-coded BPF iterator for worker pools
  workqueue: introduce seq_file form of the worker_pool iterator
  workqueue: introduce BPF iterator for pending work items
  selftests/bpf: add tests for the workqueue BPF iterators

 kernel/workqueue.c                            | 556 ++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  10 +
 .../selftests/bpf/prog_tests/wq_iter.c        |  80 +++
 tools/testing/selftests/bpf/progs/wq_iter.c   |  95 +++
 .../selftests/bpf/progs/wq_iter_fail.c        |  37 ++
 5 files changed, 778 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wq_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wq_iter_fail.c


base-commit: 87267b89459813cb50ab5377e076b639c07b4491

[1]: https://github.com/kernel-patches/bpf/pull/12981
-- 
2.43.0

