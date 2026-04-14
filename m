Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC026306B1B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150922; cv=none; b=t8bHdMq9HqEk5h4BG9w7aYqoorTO6J2jB+7ePsy36W4htaQTYD91JaFQvnDbIsvqMrbq40/q5Nm1Ds82W4cs9bIuD1Ouxo9tfCwwgz4EsVtTkjiMVtuslx8r2jhM4vj1YavBycLvU72UweNK1rhpfTWFUc4XZ8SeK8uWULQNh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150922; c=relaxed/simple;
	bh=8Je2oB5UH0EVIL0m9/8djGDmfe6JcWnihWmXad8EcRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqKsI5x+/x1+v7XJAvemTHCEdS/1NBJVMzu/iD0RVeUZ9IPAV6/1+5LXpWt/S2S8ISzgc/YKXUvdPnOvrAGb2aJXZ54HBH+4f8xDxD9wia3EypHfKY5hqIyu+MelWmq7cQmrTIZ8FScD3KCKDTGep28wQu7a628zq73NEgxOuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxQ_CC6d1pf2kAAA--.2007S3;
	Tue, 14 Apr 2026 15:15:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJ86d1pWLtsAA--.10358S4;
	Tue, 14 Apr 2026 15:15:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next 2/4] selftests/bpf: Add 8-bit and 16-bit fetch-based testcases for atomics
Date: Tue, 14 Apr 2026 15:15:05 +0800
Message-ID: <20260414071507.29804-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxzsJ86d1pWLtsAA--.10358S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3ZFW3KFy3XF48ArW8CFyUurX_yoWDKr4rp3
	yrXrnrAFy5Za10vrZagw15KFs5urs7Ar93GrZrKr9FvrnrCa4kJrnrJFyvvF1rZry0yw4r
	Cryjq3909wsrWabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

The BPF instruction set has been extended to support 8-bit and 16-bit
atomic operations. Update the atomics test to ensure these new sizes
are correctly handled by the verifier and JIT backends, each of test
verifies that both the value in memory and the value returned (fetch)
are correct.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../selftests/bpf/prog_tests/atomics.c        | 44 ++++++++++++++++
 tools/testing/selftests/bpf/progs/atomics.c   | 50 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
index 92b5f378bfb8..6409fb581b66 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -23,6 +23,12 @@ static void test_add(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
 	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
 
+	ASSERT_EQ(skel->data->add16_value, 3, "add16_value");
+	ASSERT_EQ(skel->bss->add16_result, 1, "add16_result");
+
+	ASSERT_EQ(skel->data->add8_value, 3, "add8_value");
+	ASSERT_EQ(skel->bss->add8_result, 1, "add8_result");
+
 	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
 	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
 
@@ -48,6 +54,12 @@ static void test_sub(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->sub32_value, -1, "sub32_value");
 	ASSERT_EQ(skel->bss->sub32_result, 1, "sub32_result");
 
+	ASSERT_EQ(skel->data->sub16_value, -1, "sub16_value");
+	ASSERT_EQ(skel->bss->sub16_result, 1, "sub16_result");
+
+	ASSERT_EQ(skel->data->sub8_value, -1, "sub8_value");
+	ASSERT_EQ(skel->bss->sub8_result, 1, "sub8_result");
+
 	ASSERT_EQ(skel->bss->sub_stack_value_copy, -1, "sub_stack_value");
 	ASSERT_EQ(skel->bss->sub_stack_result, 1, "sub_stack_result");
 
@@ -73,6 +85,12 @@ static void test_and(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->and32_value, 0x010, "and32_value");
 	ASSERT_EQ(skel->bss->and32_result, 0x110, "and32_result");
 
+	ASSERT_EQ(skel->data->and16_value, 0x010, "and16_value");
+	ASSERT_EQ(skel->bss->and16_result, 0x110, "and16_result");
+
+	ASSERT_EQ(skel->data->and8_value, 0x01, "and8_value");
+	ASSERT_EQ(skel->bss->and8_result, 0x11, "and8_result");
+
 	ASSERT_EQ(skel->data->and_noreturn_value, 0x010ull << 32, "and_noreturn_value");
 }
 
@@ -95,6 +113,12 @@ static void test_or(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->or32_value, 0x111, "or32_value");
 	ASSERT_EQ(skel->bss->or32_result, 0x110, "or32_result");
 
+	ASSERT_EQ(skel->data->or16_value, 0x111, "or16_value");
+	ASSERT_EQ(skel->bss->or16_result, 0x110, "or16_result");
+
+	ASSERT_EQ(skel->data->or8_value, 0x13, "or8_value");
+	ASSERT_EQ(skel->bss->or8_result, 0x11, "or8_result");
+
 	ASSERT_EQ(skel->data->or_noreturn_value, 0x111ull << 32, "or_noreturn_value");
 }
 
@@ -117,6 +141,12 @@ static void test_xor(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->xor32_value, 0x101, "xor32_value");
 	ASSERT_EQ(skel->bss->xor32_result, 0x110, "xor32_result");
 
+	ASSERT_EQ(skel->data->xor16_value, 0x101, "xor16_value");
+	ASSERT_EQ(skel->bss->xor16_result, 0x110, "xor16_result");
+
+	ASSERT_EQ(skel->data->xor8_value, 0x10, "xor8_value");
+	ASSERT_EQ(skel->bss->xor8_result, 0x11, "xor8_result");
+
 	ASSERT_EQ(skel->data->xor_noreturn_value, 0x101ull << 32, "xor_nxoreturn_value");
 }
 
@@ -140,6 +170,14 @@ static void test_cmpxchg(struct atomics_lskel *skel)
 	ASSERT_EQ(skel->data->cmpxchg32_value, 2, "lcmpxchg32_value");
 	ASSERT_EQ(skel->bss->cmpxchg32_result_fail, 1, "cmpxchg_result_fail");
 	ASSERT_EQ(skel->bss->cmpxchg32_result_succeed, 1, "cmpxchg_result_succeed");
+
+	ASSERT_EQ(skel->data->cmpxchg16_value, 2, "cmpxchg16_value");
+	ASSERT_EQ(skel->bss->cmpxchg16_result_fail, 1, "cmpxchg16_result_fail");
+	ASSERT_EQ(skel->bss->cmpxchg16_result_succeed, 1, "cmpxchg16_result_succeed");
+
+	ASSERT_EQ(skel->data->cmpxchg8_value, 2, "cmpxchg8_value");
+	ASSERT_EQ(skel->bss->cmpxchg8_result_fail, 1, "cmpxchg8_result_fail");
+	ASSERT_EQ(skel->bss->cmpxchg8_result_succeed, 1, "cmpxchg8_result_succeed");
 }
 
 static void test_xchg(struct atomics_lskel *skel)
@@ -160,6 +198,12 @@ static void test_xchg(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->xchg32_value, 2, "xchg32_value");
 	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg32_result");
+
+	ASSERT_EQ(skel->data->xchg16_value, 2, "xchg16_value");
+	ASSERT_EQ(skel->bss->xchg16_result, 1, "xchg16_result");
+
+	ASSERT_EQ(skel->data->xchg8_value, 2, "xchg8_value");
+	ASSERT_EQ(skel->bss->xchg8_result, 1, "xchg8_result");
 }
 
 void test_atomics(void)
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/selftests/bpf/progs/atomics.c
index f89c7f0cc53b..748c4da148d1 100644
--- a/tools/testing/selftests/bpf/progs/atomics.c
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -16,6 +16,10 @@ __u64 add64_value = 1;
 __u64 add64_result = 0;
 __u32 add32_value = 1;
 __u32 add32_result = 0;
+__u16 add16_value = 1;
+__u16 add16_result = 0;
+__u8  add8_value = 1;
+__u8  add8_result = 0;
 __u64 add_stack_value_copy = 0;
 __u64 add_stack_result = 0;
 __u64 add_noreturn_value = 1;
@@ -30,6 +34,8 @@ int add(const void *ctx)
 
 	add64_result = __sync_fetch_and_add(&add64_value, 2);
 	add32_result = __sync_fetch_and_add(&add32_value, 2);
+	add16_result = __sync_fetch_and_add(&add16_value, 2);
+	add8_result  = __sync_fetch_and_add(&add8_value, 2);
 	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
 	add_stack_value_copy = add_stack_value;
 	__sync_fetch_and_add(&add_noreturn_value, 2);
@@ -42,6 +48,10 @@ __s64 sub64_value = 1;
 __s64 sub64_result = 0;
 __s32 sub32_value = 1;
 __s32 sub32_result = 0;
+__s16 sub16_value = 1;
+__s16 sub16_result = 0;
+__s8  sub8_value = 1;
+__s8  sub8_result = 0;
 __s64 sub_stack_value_copy = 0;
 __s64 sub_stack_result = 0;
 __s64 sub_noreturn_value = 1;
@@ -56,6 +66,8 @@ int sub(const void *ctx)
 
 	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
 	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
+	sub16_result = __sync_fetch_and_sub(&sub16_value, 2);
+	sub8_result  = __sync_fetch_and_sub(&sub8_value, 2);
 	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
 	sub_stack_value_copy = sub_stack_value;
 	__sync_fetch_and_sub(&sub_noreturn_value, 2);
@@ -68,6 +80,10 @@ __u64 and64_value = (0x110ull << 32);
 __u64 and64_result = 0;
 __u32 and32_value = 0x110;
 __u32 and32_result = 0;
+__u16 and16_value = 0x110;
+__u16 and16_result = 0;
+__u8  and8_value = 0x11;
+__u8  and8_result = 0;
 __u64 and_noreturn_value = (0x110ull << 32);
 
 SEC("raw_tp/sys_enter")
@@ -79,6 +95,8 @@ int and(const void *ctx)
 
 	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
 	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
+	and16_result = __sync_fetch_and_and(&and16_value, 0x011);
+	and8_result = __sync_fetch_and_and(&and8_value, 0x01);
 	__sync_fetch_and_and(&and_noreturn_value, 0x011ull << 32);
 #endif
 
@@ -89,6 +107,10 @@ __u64 or64_value = (0x110ull << 32);
 __u64 or64_result = 0;
 __u32 or32_value = 0x110;
 __u32 or32_result = 0;
+__u16 or16_value = 0x110;
+__u16 or16_result = 0;
+__u8  or8_value = 0x11;
+__u8  or8_result = 0;
 __u64 or_noreturn_value = (0x110ull << 32);
 
 SEC("raw_tp/sys_enter")
@@ -99,6 +121,8 @@ int or(const void *ctx)
 #ifdef ENABLE_ATOMICS_TESTS
 	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
 	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
+	or16_result = __sync_fetch_and_or(&or16_value, 0x011);
+	or8_result = __sync_fetch_and_or(&or8_value, 0x02);
 	__sync_fetch_and_or(&or_noreturn_value, 0x011ull << 32);
 #endif
 
@@ -109,6 +133,10 @@ __u64 xor64_value = (0x110ull << 32);
 __u64 xor64_result = 0;
 __u32 xor32_value = 0x110;
 __u32 xor32_result = 0;
+__u16 xor16_value = 0x110;
+__u16 xor16_result = 0;
+__u8  xor8_value = 0x11;
+__u8  xor8_result = 0;
 __u64 xor_noreturn_value = (0x110ull << 32);
 
 SEC("raw_tp/sys_enter")
@@ -119,6 +147,8 @@ int xor(const void *ctx)
 #ifdef ENABLE_ATOMICS_TESTS
 	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
 	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
+	xor16_result = __sync_fetch_and_xor(&xor16_value, 0x011);
+	xor8_result = __sync_fetch_and_xor(&xor8_value, 0x01);
 	__sync_fetch_and_xor(&xor_noreturn_value, 0x011ull << 32);
 #endif
 
@@ -131,6 +161,12 @@ __u64 cmpxchg64_result_succeed = 0;
 __u32 cmpxchg32_value = 1;
 __u32 cmpxchg32_result_fail = 0;
 __u32 cmpxchg32_result_succeed = 0;
+__u16 cmpxchg16_value = 1;
+__u16 cmpxchg16_result_fail = 0;
+__u16 cmpxchg16_result_succeed = 0;
+__u8  cmpxchg8_value = 1;
+__u8  cmpxchg8_result_fail = 0;
+__u8  cmpxchg8_result_succeed = 0;
 
 SEC("raw_tp/sys_enter")
 int cmpxchg(const void *ctx)
@@ -143,6 +179,12 @@ int cmpxchg(const void *ctx)
 
 	cmpxchg32_result_fail = __sync_val_compare_and_swap(&cmpxchg32_value, 0, 3);
 	cmpxchg32_result_succeed = __sync_val_compare_and_swap(&cmpxchg32_value, 1, 2);
+
+	cmpxchg16_result_fail = __sync_val_compare_and_swap(&cmpxchg16_value, 0, 3);
+	cmpxchg16_result_succeed = __sync_val_compare_and_swap(&cmpxchg16_value, 1, 2);
+
+	cmpxchg8_result_fail = __sync_val_compare_and_swap(&cmpxchg8_value, 0, 3);
+	cmpxchg8_result_succeed = __sync_val_compare_and_swap(&cmpxchg8_value, 1, 2);
 #endif
 
 	return 0;
@@ -152,6 +194,10 @@ __u64 xchg64_value = 1;
 __u64 xchg64_result = 0;
 __u32 xchg32_value = 1;
 __u32 xchg32_result = 0;
+__u16 xchg16_value = 1;
+__u16 xchg16_result = 0;
+__u8  xchg8_value = 1;
+__u8  xchg8_result = 0;
 
 SEC("raw_tp/sys_enter")
 int xchg(const void *ctx)
@@ -161,9 +207,13 @@ int xchg(const void *ctx)
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 val64 = 2;
 	__u32 val32 = 2;
+	__u16 val16 = 2;
+	__u8  val8  = 2;
 
 	xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);
 	xchg32_result = __sync_lock_test_and_set(&xchg32_value, val32);
+	xchg16_result = __sync_lock_test_and_set(&xchg16_value, val16);
+	xchg8_result  = __sync_lock_test_and_set(&xchg8_value, val8);
 #endif
 
 	return 0;
-- 
2.42.0

