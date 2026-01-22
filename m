Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CC4B8DDF
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097745; cv=none; b=bH9DkmHz7upsl/jmPWVNrbVrqnMwcXel8HQU0bFjcuPRQOfLKVh9+AxwAIj6pOgyTlc/P8I0YlpkusfFA3T42XwZOMmFQX0pT6fnH+U0oBalTVr8O2kM8O5cR742R4bJ+t3K4rh/oAcb/18IZqvuC29O6q0A/IwfDqmLqsft888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097745; c=relaxed/simple;
	bh=FOyF2flkVaiiVEw8WXWwkFlSyeK4UQVP6kKwM4jHdeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5Ndx5Gk58AKtfjO6NzhIigh8k26165xUOghuTITR52EjPhHRDsSqQi6+k8E/fuZYGHyoEZQE+ne0dVftirFlQwFoKOnHHauBRljFC1+SwUif+BOi/DMps45c7GEhinM3NK1zCre+8z/vfU2xxiBi09/kCoiWgZeV3/5TtS5bEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G5F7X5Y/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G5F7X5Y/"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M8GCCv1058278
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tsCZFT/DcGUxhI1gpC2ubv17m10Tz8W4Me9bzR+GrWI=; b=G5F7X5Y/nrr/
	Lj+uWES/IJVuzw7QEJuW1GgbEyigkj1aVE1gFz/vx5dCQ/lWevTlVORncQV1zgfx
	ZnLevr0Ey7cETRNwxSun9OKJcS9Fgo3mFG3uXGdid2cZ5xLkXfV4ZyHaZwzlMXtd
	0OZsb4lhTc/bEO79qJuXt4yqbSUwEnsjcFVo1cvVfngglp7CKsSZH55YyBIsY0pe
	vOPsZ3uJRtUDA1RuXmw0eK++eJlAmnSEOPqJOcznHO4FD7O1SaqzMTlhb9ddCzA0
	cu0uLBO85JlAD9HVbq/HMZH2nWCLX6BoborZNFHXUFc4dBB9vKlJKchWT5csOTsB
	qowNwXIySQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bug822vm0-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:10 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:57 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 4A34A10A69EA2; Thu, 22 Jan 2026 08:01:45 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 06/13] selftests: bpf: Add arena ASAN runtime to libarena
Date: Thu, 22 Jan 2026 08:01:24 -0800
Message-ID: <20260122160131.2238331-7-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfXyI8cJXBH6dOt
 JDgw/rmaFbXGDj2UrBk+9K97rR7+xz49EC4ii5mlpYVAtjnWUuSuwgd5UsvSRzgDiEZxXruJe19
 dFDpQP8hgFscxHoS6l/WePtOErW/IjErfkBw6s45ANZF9KqUzcGkXUWXcMzuNsUAtsdpcAgNdcU
 dDoh06XBkIGHfnzLln/OjhsYOOJkHgU3VpnUA6ksixUJh2Kz9D2comiBHG4RGK8fVxYpDEJQSLN
 qXeSlZzVXVPKskM1WeL6x7MlJZc3RV0fCcvxdt950HpuCxy/L2CJ8Y/cILDmQhJGCXlS771QUmy
 5R38QQ+YFnPdDXC2zJrE3GL9h1/ECmvKCM2qphJAko+iVXCT61OpvkoFEvRnY+4Tj7GFKlz1Sy/
 Ajpp4O84lm2Kqwk9dQvZxYwhVMgO9w==
X-Authority-Analysis: v=2.4 cv=ROi+3oi+ c=1 sm=1 tr=0 ts=69724a02 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=CcIjpHbmH1-Scumy0XMA:9 a=SrR8gBnkhCTk2F94:21 a=I-g_0vLIplkVOQ0FYkeP:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: c0-pqw9fUjH28Kqofmu6RIy12T5M1Kn9
X-Proofpoint-ORIG-GUID: c0-pqw9fUjH28Kqofmu6RIy12T5M1Kn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add an address sanitizer (ASAN) runtime to the arena library. The
ASAN runtime implements the functions injected into BPF binaries
by LLVM sanitization is supported and enabled.

The runtime also includes functions called explicitly by memory
allocation code to mark memory as poisoned/unpoisoned to ASAN.
This code is a no-op when sanitization is turned off.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 .../selftests/bpf/libarena/include/asan.h     | 133 +++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 463 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
index 96b4a7e37427..3d176d3b2cc1 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -49,3 +49,4 @@ verification_cert.h
 *.BTF_ids
 *.BTF.base
 libarena/test_libarena
+libarena/test_libarena_asan
diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/=
testing/selftests/bpf/libarena/include/asan.h
new file mode 100644
index 000000000000..be50b23fb491
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/asan.h
@@ -0,0 +1,133 @@
+#pragma once
+
+struct asan_init_args {
+	u64 arena_all_pages;
+	u64 arena_globals_pages;
+};
+
+int asan_init(struct asan_init_args *args);
+
+/* Parameters usable by userspace. */
+extern volatile u64 __asan_shadow_memory_dynamic_address;
+extern volatile bool asan_reported;
+extern volatile bool asan_inited;
+extern volatile bool asan_report_once;
+extern volatile bool asan_emit_stack;
+
+#ifdef __BPF__
+
+#define ASAN_SHADOW_SHIFT 3
+#define ASAN_SHADOW_SCALE (1ULL << ASAN_SHADOW_SHIFT)
+#define ASAN_GRANULE_MASK ((1ULL << ASAN_SHADOW_SHIFT) - 1)
+#define ASAN_GRANULE(addr) ((s8)((u32)(u64)((addr)) & ASAN_GRANULE_MASK)=
)
+
+#define __noasan __attribute__((no_sanitize("address")))=20
+
+#ifdef BPF_ARENA_ASAN
+
+/*=20
+ * Defined as char * to get 1-byte granularity for pointer arithmetic.
+ */
+typedef s8 __arena s8a;
+
+/*
+ * Address to shadow map translation.
+ */
+static inline=20
+s8a *mem_to_shadow(void __arena __arg_arena *addr)
+{
+	return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) + __asan_shadow_me=
mory_dynamic_address);
+}
+
+/*
+ * Helper for directly reading the shadow map.
+ */
+static inline __noasan
+s8 asan_shadow_value(void __arena __arg_arena *addr)=20
+{
+	return *(s8a *)mem_to_shadow(addr);
+}
+
+__weak __noasan
+bool asan_ready(void)
+{
+	return __asan_shadow_memory_dynamic_address;
+}
+
+/*
+ * Shadow map manipulation helpers.
+ */
+int asan_poison(void __arena *addr, s8 val, size_t size);
+int asan_unpoison(void __arena *addr, size_t size);
+bool asan_shadow_set(void __arena *addr);
+s8 asan_shadow_value(void __arena *addr);
+
+/*
+ * Dummy calls to ensure the ASAN runtime's BTF information is present
+ * in every object file when compiling the runtime and local BPF code
+ * separately. The runtime calls are injected into the LLVM IR file=20
+ */
+#define DECLARE_ASAN_LOAD_STORE_SIZE(size)				\
+	void __asan_store##size(void *addr);				\
+	void __asan_store##size##_noabort(void *addr);	\
+	void __asan_load##size(void *addr);				\
+	void __asan_load##size##_noabort(void *addr);	\
+	void __asan_report_store##size(void *addr);			\
+	void __asan_report_store##size##_noabort(void *addr);		\
+	void __asan_report_load##size(void *addr);			\
+	void __asan_report_load##size##_noabort(void *addr);	=09
+
+DECLARE_ASAN_LOAD_STORE_SIZE(1);
+DECLARE_ASAN_LOAD_STORE_SIZE(2);
+DECLARE_ASAN_LOAD_STORE_SIZE(4);
+DECLARE_ASAN_LOAD_STORE_SIZE(8);
+
+#define DECLARE_ASAN_LOAD_STORE(size)				\
+	void __asan_store##size(void *addr);			\
+	void __asan_store##size##_noabort(void *addr);		\
+	void __asan_load##size(void *addr);			\
+	void __asan_load##size##_noabort(void *addr);		\
+	void __asan_report_store##size(void *addr);		\
+	void __asan_report_store##size##_noabort(void *addr);	\
+	void __asan_report_load##size(void *addr);		\
+	void __asan_report_load##size##_noabort(void *addr);	=09
+
+#define ASAN_DUMMY_CALLS_SIZE(size, arg)		\
+do {							\
+	__asan_store##size((arg));			\
+	__asan_store##size##_noabort((arg));		\
+	__asan_load##size((arg));			\
+	__asan_load##size##_noabort((arg));		\
+	__asan_report_store##size((arg));		\
+	__asan_report_store##size##_noabort((arg));	\
+	__asan_report_load##size((arg));		\
+	__asan_report_load##size##_noabort((arg));	\
+} while (0)=09
+
+#define ASAN_DUMMY_CALLS_ALL(arg)	\
+do { 					\
+	ASAN_DUMMY_CALLS_SIZE(1, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(2, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(4, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(8, (arg));	\
+} while (0)
+
+__weak __attribute__((no_sanitize_address))
+int asan_dummy_call() {
+	/* Use the shadow map base to prevent it from being optimized out. */
+	if (__asan_shadow_memory_dynamic_address)=20
+		ASAN_DUMMY_CALLS_ALL(NULL);
+
+	return 0;
+}
+#else /* BPF_ARENA_ASAN */
+
+static inline int asan_poison(void __arena *addr, s8 val, size_t size) {=
 return 0; }
+static inline int asan_unpoison(void __arena *addr, size_t size) { retur=
n 0; }
+static inline bool asan_shadow_set(void __arena *addr) { return 0; }
+static inline s8 asan_shadow_value(void __arena *addr) { return 0; }
+__weak bool asan_ready(void) { return true; }
+
+#endif /* BPF_ARENA_ASAN */
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
new file mode 100644
index 000000000000..7d39ee7b68bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -0,0 +1,463 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+#include <common.h>
+#include <asan.h>
+
+#ifdef BPF_ARENA_ASAN
+
+#pragma clang attribute push(__attribute__((no_sanitize("address"))), \
+			     apply_to =3D function)
+
+#define SHADOW_ALL_ZEROES ((u64)-1)
+
+/*
+ * Canary variable for ASAN violations. Set to the offending address.
+ */
+volatile u64 asan_violated =3D 0;
+
+/*
+ * Shadow map occupancy map.
+ */
+volatile u64 __asan_shadow_memory_dynamic_address;
+
+volatile bool asan_reported =3D false;
+volatile bool asan_inited =3D false;
+
+/*
+ * Set during program load.
+ */
+volatile bool asan_report_once =3D false;
+volatile bool asan_emit_stack =3D false;
+
+/*
+ * BPF does not currently support the memset/memcpy/memcmp intrinsics.
+ */
+__always_inline int asan_memset(s8a __arg_arena *dst, s8 val, size_t siz=
e)
+{
+	int i;
+
+	/*
+	 * Switching this to a may_goto confuses the verifier and
+	 * prevents verification on bpf-next as of late December 2025.
+	 */
+	bpf_for(i, 0, size) {
+		dst[i] =3D val;
+	}
+
+	return 0;
+}
+
+/* Validate a 1-byte access, always within a single byte. */
+static __always_inline bool memory_is_poisoned_1(s8a *addr)
+{
+	s8 shadow_value =3D asan_shadow_value(addr);
+
+	/* Byte is 0, access is valid. */
+	if (likely(!shadow_value))
+		return false;
+
+	/*=20
+	 * Byte is non-zero. Access is valid if granule offset in [0, shadow_va=
lue),
+	 * so the memory is poisoned if shadow_value is negative or smaller tha=
n
+	 * the granule's value.
+	 */
+
+	return ASAN_GRANULE(addr) >=3D shadow_value;
+}
+
+/* Validate a 2- 4-, 8-byte access, spans up to 2 bytes. */
+static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size=
)
+{
+	u64 end =3D (u64)addr + size - 1;
+
+	/*
+	 * Region fully within a single byte (addition didn't
+	 * overflow above ASAN_GRANULE).
+	 */
+	if (likely(ASAN_GRANULE(end) >=3D size - 1))
+		return memory_is_poisoned_1((s8a *)end);
+
+	/*
+	 * Otherwise first byte must be fully unpoisoned, and second byte
+	 * must be unpoisoned up to the end of the accessed region.
+	 */
+
+	return asan_shadow_value(addr) || memory_is_poisoned_1((s8a *)end);
+}
+
+/*
+ * Explicit ASAN check.
+ */
+__weak bool asan_shadow_set(void __arena __arg_arena *addr)
+{
+	return memory_is_poisoned_1(addr);
+}
+
+static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
+{
+	while (size && can_loop) {
+		if (unlikely(*(s8a *)addr))
+			return addr;
+		addr +=3D 1;
+		size -=3D 1;
+	}
+
+	return SHADOW_ALL_ZEROES;
+}
+
+static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
+{
+	u64 ret;
+	u64 start;
+	u64 end;
+
+	/* Size of [start, end] is end - start + 1. */
+	start =3D (u64)mem_to_shadow(addr);
+	end =3D (u64)mem_to_shadow(addr + size - 1);
+
+	ret =3D first_nonzero_byte(start, (end - start) + 1);
+	if (likely(ret =3D=3D SHADOW_ALL_ZEROES))
+		return false;
+
+	return __builtin_expect(ret !=3D end || ASAN_GRANULE(addr + size - 1) >=
=3D
+						      *(s8a *)end, false);
+}
+
+static __always_inline int asan_report(s8a __arg_arena *addr, size_t sz,
+				       bool write)
+{
+	/* Only report the first ASAN violation. */
+	if (asan_reported && asan_report_once)
+		return 0;
+
+	asan_reported =3D true;
+
+	asan_violated =3D (u64)addr;
+
+	if (asan_emit_stack) {
+		arena_stderr("Memory violation for address %p (0x%lx) for %s of size %=
ld",
+				addr, write ? "write" : "read", sz);
+		bpf_stream_print_stack();
+	}
+
+	return 0;
+}
+
+static __always_inline bool check_asan_args(s8a *addr, size_t size,
+					    bool *result)
+{
+	bool valid =3D true;
+
+	/* Size 0 accesses are valid even if the address is invalid. */
+	if (unlikely(size =3D=3D 0))
+		goto confirmed_valid;
+
+	/*
+	 * Wraparound is possible for extremely high size. Possible if the size
+	 * is a misinterpreted negative number.
+	 */
+	if (unlikely(addr + size < addr))
+		goto confirmed_invalid;
+
+	return false;
+
+confirmed_invalid:
+	valid =3D false;
+
+	/* FALLTHROUGH */
+confirmed_valid:
+	*result =3D valid;
+
+	return true;
+}
+
+static __always_inline bool check_region_inline(void *ptr, size_t size,
+						bool write)
+{
+	s8a *addr =3D (s8a *)(u64)ptr;
+	bool is_poisoned, is_valid;
+
+	if (check_asan_args(addr, size, &is_valid)) {
+		if (!is_valid)
+			asan_report(addr, size, write);
+		return is_valid;
+	}
+
+	switch (size) {
+	case 1:
+		is_poisoned =3D memory_is_poisoned_1(addr);
+		break;
+	case 2:
+	case 4:
+	case 8:
+		is_poisoned =3D memory_is_poisoned_2_4_8(addr, size);
+		break;
+	default:
+		is_poisoned =3D memory_is_poisoned_n(addr, size);
+	}
+
+	if (is_poisoned) {
+		asan_report(addr, size, write);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __alias is not supported for BPF so define *__noabort() variants as w=
rappers.
+ */
+#define DEFINE_ASAN_LOAD_STORE(size)                                    =
       \
+	__hidden void __asan_store##size(void *addr)                           =
\
+	{                                                                      =
\
+		check_region_inline(addr, size, true);                         \
+	}                                                                      =
\
+	__hidden void __always_inline __asan_store##size##_noabort(void *addr) =
\
+	{                                                                      =
\
+		check_region_inline(addr, size, true);                         \
+	}                                                                      =
\
+	__hidden void __asan_load##size(void *addr)                            =
\
+	{                                                                      =
\
+		check_region_inline(addr, size, false);                        \
+	}                                                                      =
\
+	__hidden void __asan_load##size##_noabort(void *addr)                  =
\
+	{                                                                      =
\
+		check_region_inline(addr, size, false);                        \
+	}                                                                      =
\
+	__hidden void __asan_report_store##size(void *addr)                    =
\
+	{                                                                      =
\
+		asan_report((s8a *)addr, size, true);                          \
+	}                                                                      =
\
+	__hidden void __asan_report_store##size##_noabort(void *addr)          =
\
+	{                                                                      =
\
+		asan_report((s8a *)addr, size, true);                          \
+	}                                                                      =
\
+	__hidden void __asan_report_load##size(void *addr)                     =
\
+	{                                                                      =
\
+		asan_report((s8a *)addr, size, false);                         \
+	}                                                                      =
\
+	__hidden void __asan_report_load##size##_noabort(void *addr)           =
\
+	{                                                                      =
\
+		asan_report((s8a *)addr, size, false);                         \
+	}
+
+DEFINE_ASAN_LOAD_STORE(1);
+DEFINE_ASAN_LOAD_STORE(2);
+DEFINE_ASAN_LOAD_STORE(4);
+DEFINE_ASAN_LOAD_STORE(8);
+
+void __asan_storeN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, true);
+}
+
+void __asan_loadN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, false);
+}
+
+/*
+ * We currently do not sanitize globals.
+ */
+void __asan_register_globals(void *globals, size_t n)
+{
+}
+
+void __asan_unregister_globals(void *globals, size_t n)
+{
+}
+
+/*
+ * We do not currently have memcpy/memmove/memset intrinsics
+ * in LLVM. Do not implement sanitization.
+ */
+void *__asan_memcpy(void *d, const void *s, size_t n)
+{
+	return NULL;
+}
+
+void *__asan_memmove(void *d, const void *s, size_t n)
+{
+	return NULL;
+}
+
+void *__asan_memset(void *p, int c, size_t n)
+{
+	return NULL;
+}
+
+/*
+ * Poisoning code, used when we add more freed memory to the allocator b=
y:
+ * 	a) pulling memory from the arena segment using bpf_arena_alloc_pages=
()
+ * 	b) freeing memory from application code
+ */
+__hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t siz=
e)
+{
+	s8a *shadow;
+	size_t len;
+
+	/*
+	 * Poisoning from a non-granule address makes no sense: We can only all=
ocate
+	 * memory to the application that with a granule-aligned starting addre=
ss,
+	 * and bpf_arena_alloc_pages returns page-aligned memory. A non-aligned
+	 * addr then implies we're freeing a different address than the one we
+	 * allocated.
+	 */
+	if (unlikely((u64)addr & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	/*
+	 * We cannot free an unaligned region because it'd be possible that we
+	 * cannot describe the resulting poisoning state of the granule in=20
+	 * the ASAN encoding.
+	 *
+	 * Every granule represents a region of memory that looks like the
+	 * following (P for poisoned bytes, C for clear):
+	 *
+	 * <Clear>  <Poisoned>
+	 * [ C C C ... P P ]
+	 *
+	 * The value of the granule's shadow map is the number of clear bytes i=
n
+	 * it. We cannot represent granules with the following state:
+	 *
+	 * [ P P ... C C ... P P ]
+	 *
+	 * That would be possible if we could free unaligned regions, so preven=
t that.
+	 *=20
+	 */
+	if (unlikely(size & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	shadow =3D mem_to_shadow(addr);
+	len =3D size >> ASAN_SHADOW_SHIFT;
+
+	asan_memset(shadow, val, len);
+
+	return 0;
+}
+
+/*
+ * Unpoisoning code for marking memory as valid during allocation calls.
+ *
+ * Very similar to asan_poison, except we need to round up instead of
+ * down, the partially poison the last granule if necessary.
+ *
+ * Partial poisoning is useful for keeping the padding poisoned. Allocat=
ions
+ * are granule-aligned, so we we're reserving granule-aligned sizes for =
the
+ * allocation. However, we want to still treat accesses to the padding a=
s=20
+ * invalid. Partial poisoning takes care of that. Freeing and poisoning =
the
+ * memory is still done in granule-aligned sizes and repoisons the alrea=
dy
+ * poisoned padding.
+ */
+__hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
+{
+	size_t partial =3D size & ASAN_GRANULE_MASK;
+	s8a *shadow;
+	size_t len;
+
+	/*
+	 * We cannot allocate in the middle of the granule. The ASAN shadow
+	 * map encoding only describes regions of memory where every granule
+	 * follows this format (P for poisoned, C for clear):
+	 *
+	 * <Clear>  <Poisoned>
+	 * [ C C C ... P P ]
+	 *
+	 * This is so we can use a single number in [0, ASAN_SHADOW_SCALE)
+	 * to represent the poison state of the granule.
+	 */
+	if (unlikely((u64)addr & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	shadow =3D mem_to_shadow(addr);
+	len =3D size >> ASAN_SHADOW_SHIFT;
+
+	asan_memset(shadow, 0, len);
+
+	/*=20
+	 * If we are allocating a non-granule aligned region, we need to adjust
+	 * the last byte of the shadow map to list how many bytes in the granul=
e
+	 * are unpoisoned. If the region is aligned, then the memset call above
+	 * was enough.
+	 */
+	if (partial)
+		shadow[len] =3D partial;
+
+	return 0;
+}
+
+/*
+ * Initialize ASAN state when necessary. Triggered from userspace before
+ * allocator startup.
+ */
+SEC("syscall")
+__hidden __noasan int asan_init(struct asan_init_args *args)
+{
+	u64 globals_pages =3D args->arena_globals_pages;
+	u64 all_pages =3D args->arena_all_pages;
+	u64 shadowmap, shadow_pgoff;
+	u64 shadow_pages;
+
+	if (asan_inited)
+		return 0;
+
+	/*=20
+	 * Round up the shadow map size to the nearest page.
+	 */
+	shadow_pages =3D all_pages >> ASAN_SHADOW_SHIFT;
+	if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) -1 )))
+		shadow_pages +=3D 1;
+
+	/*
+	 * Make sure the numbers provided by userspace are sane.
+	 */
+	if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
+		bpf_printk("error: arena size %lx too large", all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages > all_pages) {
+		bpf_printk("error: globals %lx do not fit in arena %lx", globals_pages=
, all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages + shadow_pages > all_pages) {
+		bpf_printk("error: globals %lx do not leave room for shadow map %lx (a=
rena pages %lx)",
+			globals_pages, shadow_pages, all_pages);
+		return -EINVAL;
+	}
+
+	shadow_pgoff =3D all_pages - shadow_pages - globals_pages;
+	__asan_shadow_memory_dynamic_address =3D shadow_pgoff * __PAGE_SIZE;
+
+	/*=20
+	 * Allocate the last (1/ASAN_GRANULE_SIZE)th of an arena's pages for th=
e map
+	 * We find the offset and size from the arena map.
+	 *
+	 * The allocated map pages are zeroed out, meaning all memory is marked=
 as valid
+	 * even if it's not allocated already. This is expected: Since the actu=
al memory
+	 * pages are not allocated, accesses to it will trigger page faults and=
 will be
+	 * reported through BPF streams. Any pages allocated through bpf_arena_=
alloc_pages
+	 * should be poisoned by the allocator right after the call succeeds.
+	 */
+	shadowmap =3D (u64)bpf_arena_alloc_pages(
+		&arena, (void __arena *)__asan_shadow_memory_dynamic_address,
+		shadow_pages, NUMA_NO_NODE, 0);
+	if (!shadowmap) {
+		arena_stderr("Could not allocate shadow map\n");
+		return -ENOMEM;
+	}
+
+	asan_inited =3D true;
+
+	return 0;
+}
+
+#pragma clang attribute pop
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

