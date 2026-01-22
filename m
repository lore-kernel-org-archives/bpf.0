Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30486313E28
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097736; cv=none; b=m8zWCPf1BF5lGJVdiwZ1jPObOffzSp0tPqn9GFesnnSNPG7h4xzHJOJZrj4cMvahzkjXRqpsfugSVuyAHDTLCRhHX7dssaJsPOVqABWLZ9xBQn4DxtrzZ8p9PRAve5aJs0wF6o9rhc5FWNHXLWyXrwzOdCXmmS+rtBQ6Ig4I8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097736; c=relaxed/simple;
	bh=2tNDJ2iJfeMuutixxVjPV+Aq+gmWxznFukjADBdL110=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQUCxrUwchaChM0MyYzmkTM+OpOHrcJJVNbif+WXijLOTJN0IXFcHppkdlEVatJ1FBWfnBZhBptDfCoU0/6QSU0z1K8t+1ZYqe3A3UEmZltkEqPcR9cR7DD+va+4LErd8ytxSJh5MDCEiYOPRs3RCQp7z5C+ei2RRnq/5bDR/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QhCliOZF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QhCliOZF"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7v5PY998765
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=l1cPnYJCcQp+lAh4UD2yVqwVKNd/P2jciNLUocNj1Sw=; b=QhCliOZFMRdF
	yKhevyMrNaOzhqC3z3jJirTGNk/csnQwhw1zIau92UCDsKTj1U9n8xKHUWOcHpY9
	B9lUPGbvQ33PWIx7OTSGCMfhWnkdfNoUOb/o3m0dtaz8SCdWB4IH9d4lGqFPuje6
	pWopCFQAF+Bfm8SVjyGyQK68VSqk9oinwI3BJ6ZL2kM0D0+vw4L8Qxwl0MqoLw1Q
	GmIkcNR4OZmpugwnlcAtpdwjqTxnVGOncYbvcSvPtmey/lAUpq74abKfqduI/Acd
	4YpO1ITXVGRLrO6YydqGhIpOn08Vji8c4tECuB5KLP5RHWUo9t6n4EGjPuAoD70G
	sZDPhTxeVA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bufy3ay60-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:09 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:57 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 007E310A69EC3; Thu, 22 Jan 2026 08:01:47 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 11/13] selftests: bpf: Add selftests for the libarena stack allocator
Date: Thu, 22 Jan 2026 08:01:29 -0800
Message-ID: <20260122160131.2238331-12-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ja6xbEKV c=1 sm=1 tr=0 ts=69724a01 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=DZk4LV5pne5ZGpA7JQMA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: yK5acXCtPGjVH7-05rM17H8Yo8kItQfF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX/gtHk5YhdLVG
 OK/YeE8g+vPbqqM2tqUlDPigU/rGhHsvFiUNFv75vX+KRm408Vxg8cQ3Zq5rxh0PHQQ0q4tMsT7
 ZQf7MPLP9f5HsN/ZTxW93388f9tJn/JJTzMWddgejg40di15u+iIawcym4DvC0uCtKpV4ufSVEs
 UuxI0qAw0kLtNlZscwZ7Mt+BFLLE21VJonY7ZnIyJbz7yHc9YKGkbmY8GtCfkcruqqswOgFUOJq
 R2Sum9VbqmiFySQPHzRw1VLFxbBk1yj7H2za8snwPweN3T6SaLeNkBCDrU+d81y2Cnzlka1p31M
 QG+5/8i/r2O+n5TyEhDzEpRbLdm5oYNC2xguHL3Zp4apQwEiDHN3B7TLjQHSm/8VhzWB7WUfsMo
 5gYi7UxseA+jixjQNgCIhcPWdOxUta0qk/N+QpXNBKm5oei7yQLw2wBFQZ7yLzMCBYND16Y8MIW
 6fsN+UmNZC0VjQ/XiXg==
X-Proofpoint-ORIG-GUID: yK5acXCtPGjVH7-05rM17H8Yo8kItQfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add ASAN selftests for the stack allocators to ensure proper
ASAN integration.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |   2 +
 .../libarena/selftests/st_asan_stack.bpf.c    | 253 ++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_stack.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 278978795b60..2049cda8d4fd 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -269,6 +269,7 @@ TEST(bump_selftest);
=20
 #ifdef BPF_ARENA_ASAN
 TEST(asan_test_bump);
+TEST(asan_test_stack);
 #endif
=20
 static void
@@ -316,6 +317,7 @@ int main(int argc, char *argv[])
=20
 #ifdef BPF_ARENA_ASAN
 	run_asan_test_bump();
+	run_asan_test_stack();
 #endif
=20
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack=
.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf=
.c
new file mode 100644
index 000000000000..a4c1780e4247
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
@@ -0,0 +1,253 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <stack.h>
+
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+#define STACK_PAGES_PER_ALLOC (4)
+#define STACK_ALLOCS (4)
+
+/*=20
+ * Keep this test-related array in BSS to avoid
+ * overly burdening the function stack.
+ */
+u64 __arena stk_blks[STACK_ALLOCS];
+
+/*
+ * Spinlock used by the stack allocator.
+ */
+private(ST_STACK) struct stk st_stack;
+u64 __arena st_asan_stack_lock;
+
+static __maybe_unused void stk_blks_dump(void)
+{
+	int i;
+
+	for (i =3D 0; i < STACK_ALLOCS && can_loop; i++)
+		bpf_printk("[%d] 0x%lx", i, stk_blks[i]);
+}
+
+struct qsort_limits {
+	int lo;
+	int hi;
+};
+
+__always_inline void swap(unsigned int i, unsigned int j)
+{
+	u64 tmp;
+
+	tmp =3D stk_blks[i];
+	stk_blks[i] =3D stk_blks[j];
+	stk_blks[j] =3D tmp;
+}
+
+static __always_inline int qsort_partition(unsigned int lo, unsigned hi)
+{
+	unsigned int i;
+	u64 pivotval;
+	int pivot;
+
+	if (lo >=3D STACK_ALLOCS || hi >=3D STACK_ALLOCS) {
+		bpf_printk("%s:%d invalid lo/hi indices %d/%d", __func__,
+			   __LINE__, lo, hi);
+		return 0;
+	}
+
+	pivotval =3D stk_blks[hi];
+	pivot =3D lo;
+
+	for (i =3D lo; i < hi && can_loop; i++) {
+		if (stk_blks[i] > pivotval)
+			continue;
+
+		swap(i, pivot);
+		pivot +=3D 1;
+	}
+
+	swap(pivot, hi);
+
+	return pivot;
+}
+
+static __always_inline int qsort_stack_blocks(void)
+{
+	struct qsort_limits stack[STACK_ALLOCS];
+	struct qsort_limits limits;
+	int stackind =3D 0;
+	int pivot;
+
+	limits =3D (struct qsort_limits){ 0, STACK_ALLOCS - 1 };
+	stack[stackind++] =3D limits;
+
+	while (stackind > 0 && can_loop) {
+		if (stackind <=3D 0 || stackind > STACK_ALLOCS) {
+			bpf_printk("%s:%d invalid stack index %d", __func__,
+				   __LINE__, stackind);
+			return 0;
+		}
+
+		limits =3D stack[--stackind];
+		if (limits.lo >=3D limits.hi)
+			continue;
+
+		pivot =3D qsort_partition(limits.lo, limits.hi);
+		stack[stackind++] =3D (struct qsort_limits){
+			.lo =3D limits.lo,
+			.hi =3D pivot - 1,
+		};
+
+		if (stackind <=3D 0 || stackind >=3D STACK_ALLOCS) {
+			bpf_printk("%s:%d invalid stack index", __func__,
+				   __LINE__);
+			return 0;
+		}
+
+		stack[stackind++] =3D (struct qsort_limits){
+			.lo =3D pivot + 1,
+			.hi =3D limits.hi,
+		};
+	}
+
+	return 0;
+}
+
+int asan_test_stack_uaf_oob_single(u8 __arena __arg_arena *alloced,
+				   u8 __arena __arg_arena *freed)
+{
+	const size_t overshoot =3D 5;
+	int i;
+
+	/* Use after free check. */
+	stk_free(&st_stack, freed);
+
+	bpf_for(i, 0, __PAGE_SIZE) {
+		freed[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(true, &freed[i]);
+	}
+
+	/*=20
+	 * Out of bounds check. Assuming the blocks before were
+	 * allocated consecutively, past the end of the block
+	 * the memory is guaranteed to be freed.
+	 */
+	bpf_for(i, 0, __PAGE_SIZE + overshoot) {
+		alloced[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(i >=3D __PAGE_SIZE, &alloced[i]);
+	}
+
+	return 0;
+}
+
+static int asan_sort_stack_blocks()
+{
+	int i;
+
+	qsort_stack_blocks();
+
+	if (!stk_blks[0]) {
+		bpf_printk("NULL stack block pointer");
+		return -EINVAL;
+	}
+
+	for (i =3D 1; i < STACK_ALLOCS; i++) {
+		if (!stk_blks[i]) {
+			bpf_printk("missing block");
+			return -EINVAL;
+		}
+
+		if (stk_blks[i] !=3D stk_blks[i - 1] + __PAGE_SIZE) {
+			bpf_printk("allocations not consecutive");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static __always_inline int asan_test_stack_uaf_oob(void)
+{
+	u64 base =3D (u64)(-1);
+	const u64 alloc_size =3D 4096;
+	u64 block;
+	int ret, i;
+
+	/* Set the stack to support 4KiB allocations. */
+	ret =3D stk_init(&st_stack, (arena_spinlock_t __arena *)&st_asan_stack_=
lock,
+			   alloc_size, STACK_PAGES_PER_ALLOC);
+	if (ret) {
+		bpf_printk("stk_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, STACK_ALLOCS) {
+		block =3D (u64)stk_alloc(&st_stack);
+		if (!block) {
+			bpf_printk("allocation %d failed", i);
+			return -ENOMEM;
+		}
+
+		stk_blks[i] =3D block;
+		base =3D block < base ? block : base;
+	}
+
+	ret =3D asan_sort_stack_blocks();
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < STACK_ALLOCS && can_loop; i +=3D 2) {
+		if (i + 1 >=3D STACK_ALLOCS)
+			break;
+
+		if (stk_blks[i] + alloc_size !=3D stk_blks[i + 1]) {
+			bpf_printk("Stack allocations not consecutive");
+			return -EINVAL;
+		}
+
+		ret =3D asan_test_stack_uaf_oob_single(
+			(u8 __arena *)stk_blks[i],
+			(u8 __arena *)stk_blks[i + 1]);
+		if (ret)
+			return ret;
+	}
+
+	stk_destroy(&st_stack);
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_stack(void)
+{
+	int ret;
+
+	ret =3D asan_test_stack_uaf_oob();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int asan_test_stack(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

