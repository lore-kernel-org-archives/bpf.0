Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFD36EAA9
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097741; cv=none; b=GfE7wDllv2wxxMzuW4cY3Jxc1iUC4nWd44Ko1BP9wgJ9YRfx3HFe94N+0IxpIEaIW7Zv7lGCNIWM1pGxcwPsIZjrRmh2+rlvYZ1OZbKwIkv7iPAr94B5+gCAAH29RVcUOAPXcNe/XMJYI300oyOXkw/4gMJYmvZzSNLiSOZHcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097741; c=relaxed/simple;
	bh=x7N71N2ayRd8HEr4Tagj9qyfQSlHFXsTvTK7y8ZOEQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMzIeRWR+3KFt8NEW9ieXrYtx1WJtaE/TLGHGfamcjRo/Y5/iO3WNHsy3D82QS7gbckfZM5bEakL9gsIkSFf8Z1KmBa5544m+DfxjzeNYv9DedGgs7sOq3fAJKM0zyTeu1kVim0XGS0rUuBLy3Rr6gbPTh7fxfEvNoyQ+TJV1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ooFBI5Zd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ooFBI5Zd"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60MEbFM02875515
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cc9r3Lv5T/1shh1G24JsE1osnquiozemgtBGWvKDeag=; b=ooFBI5ZdFrO2
	g9eplZ8MIOVL+CWbX1HxltlMVXAht0dRJS/lTLFRZppig0zc5YwW8nJJioRNNtq/
	ARC7Aat3YlQGUwi8hzrCbxICvvhUyYx0TEhbOtiSYXuPbCXVnuVMwQ2thUnRAo7Y
	TwekKqtPF65Z6N8c3/YDajcESBJCxkqBLfSHnvmm1fIGL2VMeiNe464yhvFNZ0v4
	cQ8C/hBQiTQDHHkb6OXroldxij5CVk4jW2cadLz34vDSG/nfK4HVZD0sZFvcuSwi
	TM391qTi3cl+WzvwETWfn73T1IR9j3SQ4Pe/X5NsYpRW2B0A6Z3IKX4xZKe+47v3
	4OulYSEs7Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4buntngphx-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:12 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:49 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id EBC4910A69EB7; Thu, 22 Jan 2026 08:01:46 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 09/13] selftests: bpf: Add libarena selftests for the bump allocator
Date: Thu, 22 Jan 2026 08:01:27 -0800
Message-ID: <20260122160131.2238331-10-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX9HmgWkHIYbxR
 9dqTX2cLW7xilJ24NORMUkrkvlXFgNhOZ0ElglCSQKkrGrebhR2uLQjCWJDrBKNEfZUJYiYoEY7
 3BIrREoQfYgx4wFn7B+Qvtq27MiWpoI/Is32JYu4Q0x/2tIbPwsgw5elIUuyjRDE0SWpDaSVDeI
 1PaLgwtg2ASNcEZvs/F7YOZZGifFtd5V+0IadWqv8gv20RTkkW87NHPX7MHb5nt1AYUoAhR2Jdk
 dJwJojVo8lFYJUYFMjH3E+QTpqm/xGJ3yVXoSsuoLKzmUTfkEyMy8hFmPlf0m94rGSfnuq75jOy
 2aikMqOkI7+RsjsVtotmNkglOX+Vi5nRa/2Zxu7wa91CO1vihPnECvIG4SAtzQeDTnhOkKK5LF0
 2SRb837eW70QqxIfzeFm6rs+Fmche9M/Rh4YFfOaKR6Q8/we6kuMYD9oDfaBHpMk+mApP5/JRob
 dPHff7ulCRDzg2vduwA==
X-Proofpoint-GUID: M6c56_w7A7QjGnS2-cwANV1o8pXLeqK_
X-Proofpoint-ORIG-GUID: M6c56_w7A7QjGnS2-cwANV1o8pXLeqK_
X-Authority-Analysis: v=2.4 cv=Ls+fC3dc c=1 sm=1 tr=0 ts=69724a04 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=f1wBDlZMcerdtIHOkroA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add testing for the libarena bump allocator. The testing covers
the behavior of the allocator both by itself and in combination
with ASAN to test that there are no false positives or negatives.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |  12 +
 .../bpf/libarena/selftests/st_asan_bump.bpf.c | 193 ++++++++++++
 .../bpf/libarena/selftests/st_bump.bpf.c      | 275 ++++++++++++++++++
 3 files changed, 480 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bum=
p.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 4d7db66e75ed..278978795b60 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -265,6 +265,12 @@ error:							\
 	return ret;					\
 }
=20
+TEST(bump_selftest);
+
+#ifdef BPF_ARENA_ASAN
+TEST(asan_test_bump);
+#endif
+
 static void
 banner(const char *progpath)
 {
@@ -306,5 +312,11 @@ int main(int argc, char *argv[])
=20
 	libbpf_set_print(libbpf_print_fn);
=20
+	run_bump_selftest();
+
+#ifdef BPF_ARENA_ASAN
+	run_asan_test_bump();
+#endif
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.=
bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
new file mode 100644
index 000000000000..a8f0e6e01e4b
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
@@ -0,0 +1,193 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <bump.h>
+
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+int asan_test_bump_blob_one(void)
+{
+	volatile struct blob __arena *blob;
+	const size_t alignment =3D 1;
+
+	blob =3D bump_alloc(sizeof(blob) - 1, alignment);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] =3D 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[0]);
+
+	blob->oob =3D 0;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	blob =3D (volatile struct blob __arena *)&blob->oob;
+	blob->mem[0] =3D 0xba;
+	ASAN_VALIDATE_ADDR(true, &blob->mem[0]);
+
+	blob->oob =3D 4;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	/*
+	 * Go even further, cast the OOB variable into
+	 * another struct blob and access its own oob.
+	 */
+	blob =3D (volatile struct blob __arena *)&blob->oob;
+	blob->oob =3D 5;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	return 0;
+}
+
+int asan_test_bump_blob(void)
+{
+	const int iters =3D 20;
+	int ret, i;
+
+	ret =3D bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < iters && can_loop; i++) {
+		ret =3D asan_test_bump_blob_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+int asan_test_bump_array_one(void)
+{
+	size_t bytes =3D 37;
+	size_t overrun =3D 13;
+	size_t alignment =3D 1;
+	char __arena *mem;
+	int i;
+
+	mem =3D bump_alloc(sizeof(*mem) * bytes, alignment);
+	if (!mem)
+		return -ENOMEM;
+
+	for (i =3D 0; i < bytes + overrun && can_loop; i++) {
+		mem[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(i >=3D bytes, &mem[i]);
+	}
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+int asan_test_bump_array(void)
+{
+	const size_t iters =3D 20;
+	int ret, i;
+
+	ret =3D bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < iters && can_loop; i++) {
+		ret =3D asan_test_bump_array_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+int asan_test_bump_all(void)
+{
+	const int iters =3D 50;
+	int ret, i;
+
+	ret =3D bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < iters && can_loop; i++) {
+		ret =3D asan_test_bump_array_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+
+		ret =3D asan_test_bump_blob_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_bump(void)
+{
+	int ret;
+
+	ret =3D asan_test_bump_blob();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret =3D asan_test_bump_array();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret =3D asan_test_bump_all();
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
+int asan_test_bump(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c=
 b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
new file mode 100644
index 000000000000..99caae452343
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
@@ -0,0 +1,275 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <bump.h>
+
+#include "selftest.h"
+
+#define ST_MAX_PAGES 8
+#define ST_MAX_BYTES (ST_MAX_PAGES * __PAGE_SIZE)
+#define ST_MAX_ALIGNMENT (ST_MAX_BYTES >> 4)
+
+#define ST_CYCLES 5
+
+#define ST_PATTERN1 0xAA
+#define ST_PATTERN2 0x55
+
+#define ST_EXHAUST_ALLOCS 16
+#define ST_WRAP_PAGES 4
+#define ST_WRAP_BYTES 2048
+
+static inline void st_memset(void __arena *mem, u8 byte, size_t size)
+{
+	u8 __arena *bytes =3D (u8 __arena *)mem;
+	int i;
+
+	for (i =3D 0; i < size && can_loop; i++) {
+		bytes[i] =3D byte;
+	}
+}
+
+static inline bool st_isset(void __arena *mem, u8 byte, size_t size)
+{
+	u8 __arena *bytes =3D (u8 __arena *)mem;
+	int i;
+
+	for (i =3D 0; i < size && can_loop; i++) {
+		if (bytes[i] !=3D byte)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Defining oft-repeated snippets as macros to avoid having to propagate
+ * errors to the caller. Both GCC and Clang support statement expression=
s.
+ */
+
+#define ALLOC_OR_FAIL(bytes, alignment)                                 =
\
+	({                                                              \
+		void __arena *mem;                                      \
+		mem =3D bump_alloc((bytes), (alignment));                 \
+		if (!mem) {                                             \
+			bpf_printk("%s:%d bump_alloc failed", __func__, \
+				   __LINE__);                           \
+			bump_destroy();                                 \
+			return -ENOMEM;                                 \
+		}                                                       \
+		mem;                                                    \
+	})
+
+#define INIT_OR_FAIL(bytes)                                             =
\
+	do {                                                            \
+		if (bump_init(((bytes) / __PAGE_SIZE))) {			\
+			bpf_printk("%s:%d bump_init failed", __func__,	\
+				   __LINE__);                           \
+			return -ENOMEM;                                 \
+		}                                                       \
+	} while (0)
+
+#define CHECK_OR_FAIL(mem, val, size)                                \
+	do {                                                         \
+		if (st_isset((mem), (val), (size))) {                \
+			bpf_printk("%s:%d val %d missing", __func__, \
+				   __LINE__);                        \
+			return -EINVAL;                              \
+		}                                                    \
+	} while (0)
+
+#define CMP_OR_FAIL(mem1, mem2, size)                                \
+	do {                                                         \
+		if (st_memcmp((mem1), (mem2), (size))) {             \
+			bpf_printk("%s:%d regions differ", __func__, \
+				   __LINE__);                        \
+			return -EINVAL;                              \
+		}                                                    \
+	} while (0)
+
+#define ALIGNED_OR_FAIL(mem, alignment)                                 =
\
+	do {                                                            \
+		if ((u64)(mem) & ((alignment) - 1)) {                   \
+			bpf_printk("%s:%d invalid alignment", __func__, \
+				   __LINE__);                           \
+			return -EINVAL;                                 \
+		}                                                       \
+	} while (0)
+
+/*
+ * Basic test:=20
+ *
+ * - Create the allocator
+ * - Make a single allocation,
+ * - Ensure proper alignment
+ * - Ensure allocation succeeds and values are all 0s.
+ * - Destroy the allocator. Ensure the allocator returns
+ * zeroed out memory.
+ */
+static int bump_selftest_alloc_single(u64 bytes, u64 alignment)
+{
+	u8 __arena *barray;
+	void __arena *mem;
+	int i;
+
+	for (i =3D 0; i < ST_CYCLES && can_loop; i++) {
+		INIT_OR_FAIL(bytes);
+
+		mem =3D ALLOC_OR_FAIL(bytes, alignment);
+
+		/* Alignment is assumed to be 2^n. */
+		ALIGNED_OR_FAIL(mem, alignment);
+
+		barray =3D (u8 __arena *)mem;
+		CHECK_OR_FAIL(barray, 0, bytes);
+
+		/* Check whether we're touching unallocated memory. */
+		st_memset(barray, ST_PATTERN1, bytes);
+		CHECK_OR_FAIL(barray, ST_PATTERN1, bytes);
+
+		bump_destroy();
+	}
+
+	return 0;
+}
+
+static int bump_selftest_alloc_multiple(u64 bytes, u64 alignment)
+{
+	void __arena *mem1, *mem2;
+	int ret;
+
+	/* Initialize the allocator */
+	ret =3D bump_init(ST_MAX_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	mem1 =3D ALLOC_OR_FAIL(bytes, alignment);
+	st_memset(mem1, ST_PATTERN1, bytes);
+
+	mem2 =3D ALLOC_OR_FAIL(bytes, alignment);
+	st_memset(mem2, ST_PATTERN1, ST_PATTERN2);
+
+	ALIGNED_OR_FAIL(mem1, alignment);
+	ALIGNED_OR_FAIL(mem2, alignment);
+
+	/* Verify first block still has pattern1 */
+	CHECK_OR_FAIL(mem1, ST_PATTERN1, bytes);
+	CHECK_OR_FAIL(mem2, ST_PATTERN2, bytes);
+
+	bump_destroy();
+	return 0;
+}
+
+static int bump_selftest_alloc_aligned(void)
+{
+	void __arena *mem;
+	u64 alignment;
+	int round;
+
+	INIT_OR_FAIL(ST_MAX_PAGES * __PAGE_SIZE);
+
+	/*=20
+	 * Allocate 1 byte at a time to test allocator alignment.=20
+	 * Test ascending and descending allocation orders.
+	 */
+	for (round =3D 0; round < 2 && can_loop; round++) {
+		for (alignment =3D 1; alignment <=3D __PAGE_SIZE && can_loop;
+		     alignment <<=3D 1) {
+			mem =3D ALLOC_OR_FAIL(1, alignment);
+			ALIGNED_OR_FAIL(mem, alignment);
+		}
+
+		for (alignment =3D __PAGE_SIZE; alignment >=3D 1 && can_loop;
+		     alignment >>=3D 1) {
+			mem =3D ALLOC_OR_FAIL(1, alignment);
+			ALIGNED_OR_FAIL(mem, alignment);
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+static int bump_selftest_alloc_exhaustion(u64 bytes, u64 alignment)
+{
+	size_t padded =3D round_up(bytes, alignment);
+	size_t allocs =3D bytes / padded;
+	void __arena *mem;
+	int i;
+
+	/* Allocate one page at a time here. */
+	INIT_OR_FAIL(__PAGE_SIZE);
+
+	if (bump_memlimit(bytes)) {
+		bpf_printk("%s:%d bump_memlimit failed", __func__,
+			   __LINE__);
+		return -EINVAL;
+	}
+
+	/* Make an unfullfilable allocation. */
+	mem =3D bump_alloc(bytes + 1, 1);
+	if (mem) {
+		bpf_printk("%s:%d bump_alloc succeeded", __func__,
+			   __LINE__);
+		bump_destroy();
+		return -EINVAL;
+	}
+
+	/*
+	 * Amounts to allocations of size alignment, but also
+	 * checks that alignment padding is properly accounted for.
+	 */
+	for (i =3D 0; i < allocs && can_loop; i++)
+		ALLOC_OR_FAIL(1, alignment);
+
+	/* Even a single byte allocation should fail. */
+	mem =3D bump_alloc(1, 1);
+	if (mem) {
+		bpf_printk("%s:%d bump_alloc succeeded", __func__,
+			   __LINE__);
+		bump_destroy();
+		return -EINVAL;
+	}
+
+	bump_destroy();
+	return 0;
+}
+
+#define BUMP_ALLOC_SELFTEST(suffix, ...) \
+	ALLOC_SELFTEST(bump_selftest_##suffix, __VA_ARGS__)
+
+
+SEC("syscall")
+int bump_selftest(void)
+{
+	u64 bytes =3D 128;
+	u64 alignment =3D 1;
+
+	for (bytes =3D __PAGE_SIZE; bytes <=3D ST_MAX_PAGES && can_loop;
+	     bytes <<=3D 1) {
+		for (alignment =3D 1; alignment <=3D ST_MAX_ALIGNMENT && can_loop;
+		     alignment <<=3D 1) {
+			/* Each test manages its own allocator lifecycle */
+			BUMP_ALLOC_SELFTEST(alloc_single, bytes, alignment);
+			BUMP_ALLOC_SELFTEST(alloc_multiple, bytes, alignment);
+		}
+	}
+
+	BUMP_ALLOC_SELFTEST(alloc_aligned);
+
+	for (alignment =3D __PAGE_SIZE; bytes <=3D ST_MAX_PAGES && can_loop;
+	     bytes <<=3D 1)
+		BUMP_ALLOC_SELFTEST(alloc_exhaustion,
+				    ST_MAX_PAGES * __PAGE_SIZE, alignment);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

