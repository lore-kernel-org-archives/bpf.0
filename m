Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904F2F1FDE
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150923; cv=none; b=j0aeuQZ+yBsZUWr0kRlouG4AKrCoXfkmr+vRvoaFbExneKyXWnmcdNAYUTdtvDbpBEzx4IPffszKP49Lbz3csoeeWHBtl/9FWwLO1mGL/m5u+jEp3R+5anRqObaBSTqr1zGMiWbAAutt1EIZZaH8jjtWF7HremeyfJICNz8nw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150923; c=relaxed/simple;
	bh=u1EzCTKTvHeiqJpfkpHY/ga7KSe0XMGI+KGXyt40bek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLuzllGENJGScyWp3qz6rFQ2PlwYF4SctBAThOrmWAZynDUlWb1t6x79LuHAugGzp+DTnSKj/jIzXcUrb6MI+YZcIwkTixAoH6BKMKZMJkZhO+bbroYpXjkp1qp6s9ZwAFeBYt1PBncukjoo1BxwjbzuKDlWuZFWeY4g5Bz9ev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxnOmD6d1pgWkAAA--.288S3;
	Tue, 14 Apr 2026 15:15:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJ86d1pWLtsAA--.10358S6;
	Tue, 14 Apr 2026 15:15:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: Implement exhaustive stack-based testcases for atomics
Date: Tue, 14 Apr 2026 15:15:07 +0800
Message-ID: <20260414071507.29804-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260414071507.29804-1-yangtiezhu@loongson.cn>
References: <20260414071507.29804-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJ86d1pWLtsAA--.10358S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4DCF18Wry5AryUGF4xKrX_yoWfAFWrpr
	95ZFnrAr15Xa1Fvr929w15GFn5Cws7AFy8GrsIgF9Iyr47AF93GryDKFy293WkAr18tw15
	Cryjq39Iqw4q93cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=

Atomic operations on stack addresses involve different verifier safety
check paths compared to global variables, the verifier must track stack
slot states and ensure that narrow atomic accesses (8-bit and 16-bit)
do not violate stack boundaries or corrupt adjacent spilled registers,
extend the atomics test to cover atomic add and sub operations on the
stack-allocated variables across all of the supported widths (8, 16, 32,
and 64 bits).

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../selftests/bpf/prog_tests/atomics.c        | 22 +++++---
 tools/testing/selftests/bpf/progs/atomics.c   | 54 ++++++++++++++-----
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
index b8397c477cbe..5abd56b3b2a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -20,21 +20,26 @@ static void test_add(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
 	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
 	ASSERT_EQ(skel->data->add64_noreturn_value, 3, "add64_noreturn_value");
+	ASSERT_EQ(skel->bss->add64_stack_value_copy, 3, "add64_stack_value_copy");
+	ASSERT_EQ(skel->bss->add64_stack_result, 1, "add64_stack_result");
 
 	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
 	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
 	ASSERT_EQ(skel->data->add32_noreturn_value, 3, "add32_noreturn_value");
+	ASSERT_EQ(skel->bss->add32_stack_value_copy, 3, "add32_stack_value_copy");
+	ASSERT_EQ(skel->bss->add32_stack_result, 1, "add32_stack_result");
 
 	ASSERT_EQ(skel->data->add16_value, 3, "add16_value");
 	ASSERT_EQ(skel->bss->add16_result, 1, "add16_result");
 	ASSERT_EQ(skel->data->add16_noreturn_value, 3, "add16_noreturn_value");
+	ASSERT_EQ(skel->bss->add16_stack_value_copy, 3, "add16_stack_value_copy");
+	ASSERT_EQ(skel->bss->add16_stack_result, 1, "add16_stack_result");
 
 	ASSERT_EQ(skel->data->add8_value, 3, "add8_value");
 	ASSERT_EQ(skel->bss->add8_result, 1, "add8_result");
 	ASSERT_EQ(skel->data->add8_noreturn_value, 3, "add8_noreturn_value");
-
-	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
-	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
+	ASSERT_EQ(skel->bss->add8_stack_value_copy, 3, "add8_stack_value_copy");
+	ASSERT_EQ(skel->bss->add8_stack_result, 1, "add8_stack_result");
 }
 
 static void test_sub(struct atomics_lskel *skel)
@@ -53,21 +58,26 @@ static void test_sub(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->sub64_value, -1, "sub64_value");
 	ASSERT_EQ(skel->bss->sub64_result, 1, "sub64_result");
 	ASSERT_EQ(skel->data->sub64_noreturn_value, -1, "sub64_noreturn_value");
+	ASSERT_EQ(skel->bss->sub64_stack_value_copy, -1, "sub64_stack_value_copy");
+	ASSERT_EQ(skel->bss->sub64_stack_result, 1, "sub64_stack_result");
 
 	ASSERT_EQ(skel->data->sub32_value, -1, "sub32_value");
 	ASSERT_EQ(skel->bss->sub32_result, 1, "sub32_result");
 	ASSERT_EQ(skel->data->sub32_noreturn_value, -1, "sub32_noreturn_value");
+	ASSERT_EQ(skel->bss->sub32_stack_value_copy, -1, "sub32_stack_value_copy");
+	ASSERT_EQ(skel->bss->sub32_stack_result, 1, "sub32_stack_result");
 
 	ASSERT_EQ(skel->data->sub16_value, -1, "sub16_value");
 	ASSERT_EQ(skel->bss->sub16_result, 1, "sub16_result");
 	ASSERT_EQ(skel->data->sub16_noreturn_value, -1, "sub16_noreturn_value");
+	ASSERT_EQ(skel->bss->sub16_stack_value_copy, -1, "sub16_stack_value_copy");
+	ASSERT_EQ(skel->bss->sub16_stack_result, 1, "sub16_stack_result");
 
 	ASSERT_EQ(skel->data->sub8_value, -1, "sub8_value");
 	ASSERT_EQ(skel->bss->sub8_result, 1, "sub8_result");
 	ASSERT_EQ(skel->data->sub8_noreturn_value, -1, "sub8_noreturn_value");
-
-	ASSERT_EQ(skel->bss->sub_stack_value_copy, -1, "sub_stack_value");
-	ASSERT_EQ(skel->bss->sub_stack_result, 1, "sub_stack_result");
+	ASSERT_EQ(skel->bss->sub8_stack_value_copy, -1, "sub8_stack_value_copy");
+	ASSERT_EQ(skel->bss->sub8_stack_result, 1, "sub8_stack_result");
 }
 
 static void test_and(struct atomics_lskel *skel)
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/selftests/bpf/progs/atomics.c
index d08cbc0e2241..1d5238e09a70 100644
--- a/tools/testing/selftests/bpf/progs/atomics.c
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -15,21 +15,26 @@ __u32 pid = 0;
 __u64 add64_value = 1;
 __u64 add64_result = 0;
 __u64 add64_noreturn_value = 1;
+__u64 add64_stack_value_copy = 0;
+__u64 add64_stack_result = 0;
 
 __u32 add32_value = 1;
 __u32 add32_result = 0;
 __u32 add32_noreturn_value = 1;
+__u32 add32_stack_value_copy = 0;
+__u32 add32_stack_result = 0;
 
 __u16 add16_value = 1;
 __u16 add16_result = 0;
 __u16 add16_noreturn_value = 1;
+__u16 add16_stack_value_copy = 0;
+__u16 add16_stack_result = 0;
 
 __u8  add8_value = 1;
 __u8  add8_result = 0;
 __u8  add8_noreturn_value  = 1;
-
-__u64 add_stack_value_copy = 0;
-__u64 add_stack_result = 0;
+__u8  add8_stack_value_copy = 0;
+__u8  add8_stack_result = 0;
 
 SEC("raw_tp/sys_enter")
 int add(const void *ctx)
@@ -38,22 +43,30 @@ int add(const void *ctx)
 		return 0;
 
 #ifdef ENABLE_ATOMICS_TESTS
-	__u64 add_stack_value = 1;
+	__u64 add64_stack_value = 1;
+	__u32 add32_stack_value = 1;
+	__u16 add16_stack_value = 1;
+	__u8  add8_stack_value  = 1;
 
 	add64_result = __sync_fetch_and_add(&add64_value, 2);
 	__sync_fetch_and_add(&add64_noreturn_value, 2);
+	add64_stack_result = __sync_fetch_and_add(&add64_stack_value, 2);
+	add64_stack_value_copy = add64_stack_value;
 
 	add32_result = __sync_fetch_and_add(&add32_value, 2);
 	__sync_fetch_and_add(&add32_noreturn_value, 2);
+	add32_stack_result = __sync_fetch_and_add(&add32_stack_value, 2);
+	add32_stack_value_copy = add32_stack_value;
 
 	add16_result = __sync_fetch_and_add(&add16_value, 2);
 	__sync_fetch_and_add(&add16_noreturn_value, 2);
+	add16_stack_result = __sync_fetch_and_add(&add16_stack_value, 2);
+	add16_stack_value_copy = add16_stack_value;
 
 	add8_result  = __sync_fetch_and_add(&add8_value, 2);
 	__sync_fetch_and_add(&add8_noreturn_value, 2);
-
-	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
-	add_stack_value_copy = add_stack_value;
+	add8_stack_result = __sync_fetch_and_add(&add8_stack_value, 2);
+	add8_stack_value_copy = add8_stack_value;
 #endif
 
 	return 0;
@@ -62,21 +75,26 @@ int add(const void *ctx)
 __s64 sub64_value = 1;
 __s64 sub64_result = 0;
 __s64 sub64_noreturn_value = 1;
+__s64 sub64_stack_value_copy = 0;
+__s64 sub64_stack_result = 0;
 
 __s32 sub32_value = 1;
 __s32 sub32_result = 0;
 __s32 sub32_noreturn_value = 1;
+__s32 sub32_stack_value_copy = 0;
+__s32 sub32_stack_result = 0;
 
 __s16 sub16_value = 1;
 __s16 sub16_result = 0;
 __s16 sub16_noreturn_value = 1;
+__s16 sub16_stack_value_copy = 0;
+__s16 sub16_stack_result = 0;
 
 __s8  sub8_value = 1;
 __s8  sub8_result = 0;
 __s8  sub8_noreturn_value  = 1;
-
-__s64 sub_stack_value_copy = 0;
-__s64 sub_stack_result = 0;
+__s8  sub8_stack_value_copy = 0;
+__s8  sub8_stack_result = 0;
 
 SEC("raw_tp/sys_enter")
 int sub(const void *ctx)
@@ -85,22 +103,30 @@ int sub(const void *ctx)
 		return 0;
 
 #ifdef ENABLE_ATOMICS_TESTS
-	__u64 sub_stack_value = 1;
+	__s64 sub64_stack_value = 1;
+	__s32 sub32_stack_value = 1;
+	__s16 sub16_stack_value = 1;
+	__s8  sub8_stack_value  = 1;
 
 	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
 	__sync_fetch_and_sub(&sub64_noreturn_value, 2);
+	sub64_stack_result = __sync_fetch_and_sub(&sub64_stack_value, 2);
+	sub64_stack_value_copy = sub64_stack_value;
 
 	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
 	__sync_fetch_and_sub(&sub32_noreturn_value, 2);
+	sub32_stack_result = __sync_fetch_and_sub(&sub32_stack_value, 2);
+	sub32_stack_value_copy = sub32_stack_value;
 
 	sub16_result = __sync_fetch_and_sub(&sub16_value, 2);
 	__sync_fetch_and_sub(&sub16_noreturn_value, 2);
+	sub16_stack_result = __sync_fetch_and_sub(&sub16_stack_value, 2);
+	sub16_stack_value_copy = sub16_stack_value;
 
 	sub8_result  = __sync_fetch_and_sub(&sub8_value, 2);
 	__sync_fetch_and_sub(&sub8_noreturn_value, 2);
-
-	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
-	sub_stack_value_copy = sub_stack_value;
+	sub8_stack_result = __sync_fetch_and_sub(&sub8_stack_value, 2);
+	sub8_stack_value_copy = sub8_stack_value;
 #endif
 
 	return 0;
-- 
2.42.0

