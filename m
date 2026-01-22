Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8353939D9
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097743; cv=none; b=jBOGfQubdFm98P2jxUj/GcmKFCTDz6l5ie7fwDgFQ1/1mx1N7+y5lUyWJA7f6Pd0gKHL3eM/hC/YHhJyTTTicS6qgQzAS5tzFTV6DT4JEoS1B1GPi8wkUQwjcEDJCIGJgFYrBsgqmQdvA5PLsH6kxEumHUftbdeCSfuG41/7SRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097743; c=relaxed/simple;
	bh=pSRrBFfEFZsTQJKC4h+W5RVXFOLuvJFbo5uHIG4WCWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndMLSUMfesdVTSIes+RQ67mhkvbAg975lKq8FxjZyZvf6TH8SunoZoV9X8BmN/eyfZbYOAXlDUhV/2ymAYAzlilAE8vh7bApIoUJ731nmagvnk07i9teto1Vn0xnSjSxQhOrG8PVAqgfC2/pF2/0oIBJVHWsdO47aTn/xjatY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UHRGkxNv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UHRGkxNv"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7v5Ph998765
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=aTgDicfg2YMa+siKoLQEen3miqqB+GyAjCXoq8jGtDI=; b=UHRGkxNvb8Sf
	VrDaEhKe6ATvbYGH7G37VCui6L5QjoWa6+zZnPwq73nabwAgtVxQ3RJIe6HYKCw3
	9I5GgM9ePBveaeuFAqed4DLQ411XMKXr7gT/sPS63hhyzRb0Vpskpvj7zSuOb3UT
	3SFfTGjw9/BAPEgrHR4ycyZwEOBE5DDl52AI7/h9c2Oh353y8EwCyqXEn22vSJwW
	VkKDTDLV+ob5WyMH6+N/zE+65jxSqFy1+QExPLFaqA/AWu+Er96mj21xDa1N7BiN
	84i++eS7ygk6yT7egd730/37Hcld+vI3NAB1yB/ffwQZqsbGycQm94b/StrifCIT
	QDpLZGT7Qg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bufy3ay60-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:13 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:57 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 0CD8610A69ECA; Thu, 22 Jan 2026 08:01:49 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 13/13] selftests: bpf: Add selftests for the libarena buddy allocator
Date: Thu, 22 Jan 2026 08:01:31 -0800
Message-ID: <20260122160131.2238331-14-etsal@meta.com>
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
X-Authority-Analysis: v=2.4 cv=Ja6xbEKV c=1 sm=1 tr=0 ts=69724a05 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=TcQ1XVL8KVMhJEAcrewA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
 a=XPt-wQF8OpHyw-b10Fkl:22
X-Proofpoint-GUID: 44iWAsPO3qwq-np0Mx2kgvL4fnxSiDaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX5kSKC0stJ5OK
 V8trvRI4TbgnOBKrfqi2qUesjDtOBQMCrGTnPbhE5deVE3kNFHwGFtK6fqg56tWzEgSc1RwXxWC
 nKvVAUZMVgjfeTcayHHNBlT1vHI+9ZGO50ZFY0V523Nt5BMFoemDL6I/CJPQDx5/IvA76qtZlQQ
 yNwdIpZChj6aUslSI2DmW8U+9mgZ5EnA/G7AegysaQuuXfYTNZWyzEgZlZKmzaoWAjq/E8Yje6t
 Hu/RbM7Gtwr73MbNm9AXe2/ytG7WLuzWfzcpjatK+Pi8/+rmVDnXPHZ4hBQoDYbcNVX3FwzHtCB
 xa707W9Wa/QI2fmjKjoUfSJ0sKDL3t+FKp8ITLQUVtnar9dlvtL53mqBqOUkPD1gfO11mZSnEHs
 AiibovqTohDPymTHc38qRifE3in90x6MzBpEAxFUi8UNn7pgIcmlacjLD066IGWW/oCZafPqbK7
 3usp5UebLIWOusXqxjA==
X-Proofpoint-ORIG-GUID: 44iWAsPO3qwq-np0Mx2kgvL4fnxSiDaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add regular and ASAN testing for the buddy allocator. This tests
the allocator's correctness by itself and its integration with ASAN.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |   4 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 238 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 231 +++++++++++++++++
 3 files changed, 473 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bud=
dy.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 2049cda8d4fd..5cec956abca5 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -266,10 +266,12 @@ error:							\
 }
=20
 TEST(bump_selftest);
+TEST(buddy_selftest);
=20
 #ifdef BPF_ARENA_ASAN
 TEST(asan_test_bump);
 TEST(asan_test_stack);
+TEST(asan_test_buddy);
 #endif
=20
 static void
@@ -314,10 +316,12 @@ int main(int argc, char *argv[])
 	libbpf_set_print(libbpf_print_fn);
=20
 	run_bump_selftest();
+	run_buddy_selftest();
=20
 #ifdef BPF_ARENA_ASAN
 	run_asan_test_bump();
 	run_asan_test_stack();
+	run_asan_test_buddy();
 #endif
=20
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy=
.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf=
.c
new file mode 100644
index 000000000000..e3887a7c5d93
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,238 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+private(ST_BUDDY) struct buddy st_buddy_asan;
+
+u64 __arena st_asan_buddy_lock;
+
+static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int i;
+
+	ASAN_VALIDATE();
+
+	mem =3D buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		bpf_printk("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	bpf_for(i, 0, alloc_size) {
+		mem[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(false, &mem[i]);
+	}
+
+	mem[alloc_size] =3D 0xba;
+	ASAN_VALIDATE_ADDR(true, &mem[alloc_size]);
+
+	buddy_free(&st_buddy_asan, mem);
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_uaf_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int i;
+
+	mem =3D buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		bpf_printk("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	bpf_for(i, 0, alloc_size) {
+		mem[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(false, &mem[i]);
+	}
+
+	ASAN_VALIDATE();
+
+	buddy_free(&st_buddy_asan, mem);
+
+	bpf_for(i, 0, alloc_size) {
+		/* The header doesn't get poisoned. */
+		if (BUDDY_HEADER_OFF <=3D i &&
+		    i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+			continue;
+
+		mem[i] =3D 0xba;
+		ASAN_VALIDATE_ADDR(true, &mem[i]);
+	}
+
+	return 0;
+}
+
+struct buddy_blob {
+	volatile u8 mem[48];
+	u8 oob;
+};
+
+static __always_inline int asan_test_buddy_blob_single(void)
+{
+	volatile struct buddy_blob __arena *blob;
+	const size_t alloc_size =3D sizeof(struct buddy_blob) - 1;
+
+	blob =3D buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] =3D 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[0]);
+
+	blob->mem[47] =3D 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[47]);
+
+	blob->oob =3D 0;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	buddy_free(&st_buddy_asan, (void __arena *)blob);
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_oob(void)
+{
+	size_t sizes[] =3D {
+		7, 8, 17, 18, 64, 256, 317, 512, 1024,
+	};
+	int ret, i;
+
+	ret =3D buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
+	if (ret) {
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, 7) {
+		ret =3D asan_test_buddy_oob_single(sizes[i]);
+		if (ret) {
+			bpf_printk("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] =3D { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
+	int ret, i;
+
+	ret =3D buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
+	if (ret) {
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, 7) {
+		ret =3D asan_test_buddy_uaf_single(sizes[i]);
+		if (ret) {
+			bpf_printk("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_blob(void)
+{
+	const int iters =3D 10;
+	int ret, i;
+
+	ret =3D buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
+	if (ret) {
+		bpf_printk("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < iters && can_loop; i++) {
+		ret =3D asan_test_buddy_blob_single();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	int ret;
+
+	ret =3D asan_test_buddy_oob();
+	if (ret) {
+		bpf_printk("%s:%d OOB test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret =3D asan_test_buddy_uaf();
+	if (ret) {
+		bpf_printk("%s:%d UAF test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret =3D asan_test_buddy_blob();
+	if (ret) {
+		bpf_printk("%s:%d blob test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.=
c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
new file mode 100644
index 000000000000..256d9a865647
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,231 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+private(ST_BUDDY) struct buddy st_buddy;
+static u64 __arena st_buddy_lock;
+
+struct segarr_entry {
+	u8 __arena *block;
+	size_t sz;
+	u8 poison;
+};
+
+typedef struct segarr_entry __arena segarr_entry_t;
+
+#define SEGARRLEN (512)
+static struct segarr_entry __arena segarr[SEGARRLEN];
+static void __arena *ptrs[17];
+size_t __arena alloc_sizes[] =3D { 3, 17, 1025, 129, 16350, 333, 9, 517 =
};
+size_t __arena alloc_multiple_sizes[] =3D { 3, 17, 1025, 129, 16350, 333=
, 9, 517, 2099 };
+size_t __arena alloc_free_sizes[] =3D { 3, 17, 64, 129, 256, 333, 512, 5=
17 };
+size_t __arena alignment_sizes[] =3D { 1, 3, 7, 8, 9, 15, 16, 17, 31,
+				     32, 64, 100, 128, 255, 256, 512, 1000 };
+
+static int buddy_selftest_create()
+{
+	const int iters =3D 10;
+	int ret, i;
+
+	for (i =3D 0; i < iters && can_loop; i++) {
+		ret =3D buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		ret =3D buddy_destroy(&st_buddy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int buddy_selftest_alloc()
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i =3D 0; i < 8 && can_loop; i++) {
+		ret =3D buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		mem =3D buddy_alloc(&st_buddy, alloc_sizes[i]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_destroy(&st_buddy);
+	}
+
+	return 0;
+}
+
+static int buddy_selftest_alloc_free()
+{
+	const int iters =3D 800;
+	void __arena *mem;
+	int ret, i;
+
+	ret =3D buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	bpf_for(i, 0, iters) {
+		mem =3D buddy_alloc(&st_buddy, alloc_free_sizes[(i * 5) % 8]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int buddy_selftest_alloc_multiple()
+{
+	int ret, j;
+	u32 i, idx;
+	u8 __arena *mem;
+	size_t sz;
+	u8 poison;
+
+	ret =3D buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * Cycle through each size, allocating an entry in the
+	 * segarr. Continue for SEGARRLEN iterations. For every
+	 * allocation write down the size, use the current index
+	 * as a poison value, and log it with the pointer in the
+	 * segarr entry. Use the poison value to poison the entire
+	 * allocated memory according to the size given.
+	 */
+	idx =3D 0;
+	bpf_for(i, 0, SEGARRLEN) {
+		sz =3D alloc_multiple_sizes[idx % 9];
+		poison =3D (u8)i;
+
+		mem =3D buddy_alloc(&st_buddy, sz);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			bpf_printk("%s:%d", __func__, __LINE__);
+			return -ENOMEM;
+		}
+
+		segarr[i].block =3D mem;
+		segarr[i].sz =3D sz;
+		segarr[i].poison =3D poison;
+
+		bpf_for(j, 0, sz) {
+			mem[j] =3D poison;
+			if (mem[j] !=3D poison) {
+				buddy_destroy(&st_buddy);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * For SEGARRLEN iterations, go to (i * 17) % SEGARRLEN, and free
+	 * the block pointed to. Before freeing, check all bytes have the
+	 * poisoned value corresponding to the element. If any values
+	 * are unexpected, return an error.
+	 */
+	bpf_for(i, 10, SEGARRLEN) {
+		idx =3D (i * 17) % SEGARRLEN;
+
+		mem =3D segarr[idx].block;
+		sz =3D segarr[idx].sz;
+		poison =3D segarr[idx].poison;
+
+		bpf_for(j, 0, sz) {
+			if (mem[j] !=3D poison) {
+				buddy_destroy(&st_buddy);
+				bpf_printk("%s:%d %lx %u vs %u", __func__,
+					   __LINE__, &mem[j], mem[j], poison);
+				return -EINVAL;
+			}
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int buddy_selftest_alignment()
+{
+	int ret, i;
+
+	ret =3D buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	bpf_for(i, 0, 17) {
+		ptrs[i] =3D buddy_alloc(&st_buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			bpf_printk("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			bpf_printk(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	bpf_for(i, 0, 17) {
+		buddy_free(&st_buddy, ptrs[i]);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+#define BUDDY_ALLOC_SELFTEST(suffix) ALLOC_SELFTEST(buddy_selftest_##suf=
fix)
+
+SEC("syscall")
+__weak int buddy_selftest(void)
+{
+	BUDDY_ALLOC_SELFTEST(create);
+	BUDDY_ALLOC_SELFTEST(alloc);
+	BUDDY_ALLOC_SELFTEST(alloc_free);
+	BUDDY_ALLOC_SELFTEST(alloc_multiple);
+	BUDDY_ALLOC_SELFTEST(alignment);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

