Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E313371CE3
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150928; cv=none; b=V+qmj/tf1hx3cnAActwe02TyPf7cDK4HQRMt0PVHis8XLdndbfLURYTJmYqetaNSGEIj+9pwOVoGCJhvPzoy2aUev2xYUVjVJgf+siU0mujuL4++X1/fnimwQU6TPcdjY0ketBw/m1gMA5vZsI2fTLZ4g52OZEektBIfzC1mkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150928; c=relaxed/simple;
	bh=S7gzAWB/NZlZdBKGgxBay6zTN2Cj0oZ3AnC3MGSaFjs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQQ7L7ok7bY2xDsNP2xpPgIvZgNP5u697T8+sBOvGBqNFRDA6hrTqEO5S/O3uwdpDL4dgpW/IR0KS+99QGKbvFFvdbclpySsS5DUhEHJeCeeWTPqNuJi7OWc7QAeNUPbw0EQLiTCBDy6fGlFa+EHW+ieyqVZlOulPkhTAKMcM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxP+qC6d1pgGkAAA--.1546S3;
	Tue, 14 Apr 2026 15:15:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJ86d1pWLtsAA--.10358S5;
	Tue, 14 Apr 2026 15:15:14 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next 3/4] selftests/bpf: Introduce all of non-fetch-based testcases for atomics
Date: Tue, 14 Apr 2026 15:15:06 +0800
Message-ID: <20260414071507.29804-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxzsJ86d1pWLtsAA--.10358S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3CrWxtw1xZrWfKw17Jr43Arc_yoW8Gw4xJo
	WrGayYyF13Xr97Wa45C34qqr40gFW0yF1UKr4FyrZ0ya4UAa1Skr4YyF1aya42gFyUG3Wk
	Wr4jq3saqa4ktrWkl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

The BPF atomic instruction set supports both fetch (returning the old
value) and non-fetch (not returning a value) variants. While previous
tests primarily focused on fetch operations, extend the atomics test
to cover non-fetch variants across all of the supported widths (8, 16,
32, and 64 bits).

While at it, add some blank lines somewhere in the code to make it
more readable.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../selftests/bpf/prog_tests/atomics.c        | 30 ++++--
 tools/testing/selftests/bpf/progs/atomics.c   | 98 ++++++++++++++++---
 2 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
index 6409fb581b66..b8397c477cbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -19,20 +19,22 @@ static void test_add(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
 	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
+	ASSERT_EQ(skel->data->add64_noreturn_value, 3, "add64_noreturn_value");
 
 	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
 	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
+	ASSERT_EQ(skel->data->add32_noreturn_value, 3, "add32_noreturn_value");
 
 	ASSERT_EQ(skel->data->add16_value, 3, "add16_value");
 	ASSERT_EQ(skel->bss->add16_result, 1, "add16_result");
+	ASSERT_EQ(skel->data->add16_noreturn_value, 3, "add16_noreturn_value");
 
 	ASSERT_EQ(skel->data->add8_value, 3, "add8_value");
 	ASSERT_EQ(skel->bss->add8_result, 1, "add8_result");
+	ASSERT_EQ(skel->data->add8_noreturn_value, 3, "add8_noreturn_value");
 
 	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
 	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
-
-	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
 }
 
 static void test_sub(struct atomics_lskel *skel)
@@ -50,20 +52,22 @@ static void test_sub(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->sub64_value, -1, "sub64_value");
 	ASSERT_EQ(skel->bss->sub64_result, 1, "sub64_result");
+	ASSERT_EQ(skel->data->sub64_noreturn_value, -1, "sub64_noreturn_value");
 
 	ASSERT_EQ(skel->data->sub32_value, -1, "sub32_value");
 	ASSERT_EQ(skel->bss->sub32_result, 1, "sub32_result");
+	ASSERT_EQ(skel->data->sub32_noreturn_value, -1, "sub32_noreturn_value");
 
 	ASSERT_EQ(skel->data->sub16_value, -1, "sub16_value");
 	ASSERT_EQ(skel->bss->sub16_result, 1, "sub16_result");
+	ASSERT_EQ(skel->data->sub16_noreturn_value, -1, "sub16_noreturn_value");
 
 	ASSERT_EQ(skel->data->sub8_value, -1, "sub8_value");
 	ASSERT_EQ(skel->bss->sub8_result, 1, "sub8_result");
+	ASSERT_EQ(skel->data->sub8_noreturn_value, -1, "sub8_noreturn_value");
 
 	ASSERT_EQ(skel->bss->sub_stack_value_copy, -1, "sub_stack_value");
 	ASSERT_EQ(skel->bss->sub_stack_result, 1, "sub_stack_result");
-
-	ASSERT_EQ(skel->data->sub_noreturn_value, -1, "sub_noreturn_value");
 }
 
 static void test_and(struct atomics_lskel *skel)
@@ -81,17 +85,19 @@ static void test_and(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->and64_value, 0x010ull << 32, "and64_value");
 	ASSERT_EQ(skel->bss->and64_result, 0x110ull << 32, "and64_result");
+	ASSERT_EQ(skel->data->and64_noreturn_value, 0x010ull << 32, "and64_noreturn_value");
 
 	ASSERT_EQ(skel->data->and32_value, 0x010, "and32_value");
 	ASSERT_EQ(skel->bss->and32_result, 0x110, "and32_result");
+	ASSERT_EQ(skel->data->and32_noreturn_value, 0x010, "and32_noreturn_value");
 
 	ASSERT_EQ(skel->data->and16_value, 0x010, "and16_value");
 	ASSERT_EQ(skel->bss->and16_result, 0x110, "and16_result");
+	ASSERT_EQ(skel->data->and16_noreturn_value, 0x010, "and16_noreturn_value");
 
 	ASSERT_EQ(skel->data->and8_value, 0x01, "and8_value");
 	ASSERT_EQ(skel->bss->and8_result, 0x11, "and8_result");
-
-	ASSERT_EQ(skel->data->and_noreturn_value, 0x010ull << 32, "and_noreturn_value");
+	ASSERT_EQ(skel->data->and8_noreturn_value, 0x01, "and8_noreturn_value");
 }
 
 static void test_or(struct atomics_lskel *skel)
@@ -109,17 +115,19 @@ static void test_or(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->or64_value, 0x111ull << 32, "or64_value");
 	ASSERT_EQ(skel->bss->or64_result, 0x110ull << 32, "or64_result");
+	ASSERT_EQ(skel->data->or64_noreturn_value, 0x111ull << 32, "or64_noreturn_value");
 
 	ASSERT_EQ(skel->data->or32_value, 0x111, "or32_value");
 	ASSERT_EQ(skel->bss->or32_result, 0x110, "or32_result");
+	ASSERT_EQ(skel->data->or32_noreturn_value, 0x111, "or32_noreturn_value");
 
 	ASSERT_EQ(skel->data->or16_value, 0x111, "or16_value");
 	ASSERT_EQ(skel->bss->or16_result, 0x110, "or16_result");
+	ASSERT_EQ(skel->data->or16_noreturn_value, 0x111, "or16_noreturn_value");
 
 	ASSERT_EQ(skel->data->or8_value, 0x13, "or8_value");
 	ASSERT_EQ(skel->bss->or8_result, 0x11, "or8_result");
-
-	ASSERT_EQ(skel->data->or_noreturn_value, 0x111ull << 32, "or_noreturn_value");
+	ASSERT_EQ(skel->data->or8_noreturn_value, 0x13, "or8_noreturn_value");
 }
 
 static void test_xor(struct atomics_lskel *skel)
@@ -137,17 +145,19 @@ static void test_xor(struct atomics_lskel *skel)
 
 	ASSERT_EQ(skel->data->xor64_value, 0x101ull << 32, "xor64_value");
 	ASSERT_EQ(skel->bss->xor64_result, 0x110ull << 32, "xor64_result");
+	ASSERT_EQ(skel->data->xor64_noreturn_value, 0x101ull << 32, "xor64_noreturn_value");
 
 	ASSERT_EQ(skel->data->xor32_value, 0x101, "xor32_value");
 	ASSERT_EQ(skel->bss->xor32_result, 0x110, "xor32_result");
+	ASSERT_EQ(skel->data->xor32_noreturn_value, 0x101, "xor32_noreturn_value");
 
 	ASSERT_EQ(skel->data->xor16_value, 0x101, "xor16_value");
 	ASSERT_EQ(skel->bss->xor16_result, 0x110, "xor16_result");
+	ASSERT_EQ(skel->data->xor16_noreturn_value, 0x101, "xor16_noreturn_value");
 
 	ASSERT_EQ(skel->data->xor8_value, 0x10, "xor8_value");
 	ASSERT_EQ(skel->bss->xor8_result, 0x11, "xor8_result");
-
-	ASSERT_EQ(skel->data->xor_noreturn_value, 0x101ull << 32, "xor_nxoreturn_value");
+	ASSERT_EQ(skel->data->xor8_noreturn_value, 0x10, "xor8_noreturn_value");
 }
 
 static void test_cmpxchg(struct atomics_lskel *skel)
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/selftests/bpf/progs/atomics.c
index 748c4da148d1..d08cbc0e2241 100644
--- a/tools/testing/selftests/bpf/progs/atomics.c
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -14,31 +14,46 @@ __u32 pid = 0;
 
 __u64 add64_value = 1;
 __u64 add64_result = 0;
+__u64 add64_noreturn_value = 1;
+
 __u32 add32_value = 1;
 __u32 add32_result = 0;
+__u32 add32_noreturn_value = 1;
+
 __u16 add16_value = 1;
 __u16 add16_result = 0;
+__u16 add16_noreturn_value = 1;
+
 __u8  add8_value = 1;
 __u8  add8_result = 0;
+__u8  add8_noreturn_value  = 1;
+
 __u64 add_stack_value_copy = 0;
 __u64 add_stack_result = 0;
-__u64 add_noreturn_value = 1;
 
 SEC("raw_tp/sys_enter")
 int add(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 add_stack_value = 1;
 
 	add64_result = __sync_fetch_and_add(&add64_value, 2);
+	__sync_fetch_and_add(&add64_noreturn_value, 2);
+
 	add32_result = __sync_fetch_and_add(&add32_value, 2);
+	__sync_fetch_and_add(&add32_noreturn_value, 2);
+
 	add16_result = __sync_fetch_and_add(&add16_value, 2);
+	__sync_fetch_and_add(&add16_noreturn_value, 2);
+
 	add8_result  = __sync_fetch_and_add(&add8_value, 2);
+	__sync_fetch_and_add(&add8_noreturn_value, 2);
+
 	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
 	add_stack_value_copy = add_stack_value;
-	__sync_fetch_and_add(&add_noreturn_value, 2);
 #endif
 
 	return 0;
@@ -46,31 +61,46 @@ int add(const void *ctx)
 
 __s64 sub64_value = 1;
 __s64 sub64_result = 0;
+__s64 sub64_noreturn_value = 1;
+
 __s32 sub32_value = 1;
 __s32 sub32_result = 0;
+__s32 sub32_noreturn_value = 1;
+
 __s16 sub16_value = 1;
 __s16 sub16_result = 0;
+__s16 sub16_noreturn_value = 1;
+
 __s8  sub8_value = 1;
 __s8  sub8_result = 0;
+__s8  sub8_noreturn_value  = 1;
+
 __s64 sub_stack_value_copy = 0;
 __s64 sub_stack_result = 0;
-__s64 sub_noreturn_value = 1;
 
 SEC("raw_tp/sys_enter")
 int sub(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 sub_stack_value = 1;
 
 	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
+	__sync_fetch_and_sub(&sub64_noreturn_value, 2);
+
 	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
+	__sync_fetch_and_sub(&sub32_noreturn_value, 2);
+
 	sub16_result = __sync_fetch_and_sub(&sub16_value, 2);
+	__sync_fetch_and_sub(&sub16_noreturn_value, 2);
+
 	sub8_result  = __sync_fetch_and_sub(&sub8_value, 2);
+	__sync_fetch_and_sub(&sub8_noreturn_value, 2);
+
 	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
 	sub_stack_value_copy = sub_stack_value;
-	__sync_fetch_and_sub(&sub_noreturn_value, 2);
 #endif
 
 	return 0;
@@ -78,26 +108,38 @@ int sub(const void *ctx)
 
 __u64 and64_value = (0x110ull << 32);
 __u64 and64_result = 0;
+__u64 and64_noreturn_value = (0x110ull << 32);
+
 __u32 and32_value = 0x110;
 __u32 and32_result = 0;
+__u32 and32_noreturn_value = 0x110;
+
 __u16 and16_value = 0x110;
 __u16 and16_result = 0;
+__u16 and16_noreturn_value = 0x110;
+
 __u8  and8_value = 0x11;
 __u8  and8_result = 0;
-__u64 and_noreturn_value = (0x110ull << 32);
+__u8  and8_noreturn_value  = 0x11;
 
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
-#ifdef ENABLE_ATOMICS_TESTS
 
+#ifdef ENABLE_ATOMICS_TESTS
 	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
+	__sync_fetch_and_and(&and64_noreturn_value, 0x011ull << 32);
+
 	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
+	__sync_fetch_and_and(&and32_noreturn_value, 0x011);
+
 	and16_result = __sync_fetch_and_and(&and16_value, 0x011);
+	__sync_fetch_and_and(&and16_noreturn_value, 0x011);
+
 	and8_result = __sync_fetch_and_and(&and8_value, 0x01);
-	__sync_fetch_and_and(&and_noreturn_value, 0x011ull << 32);
+	__sync_fetch_and_and(&and8_noreturn_value, 0x01);
 #endif
 
 	return 0;
@@ -105,25 +147,38 @@ int and(const void *ctx)
 
 __u64 or64_value = (0x110ull << 32);
 __u64 or64_result = 0;
+__u64 or64_noreturn_value = (0x110ull << 32);
+
 __u32 or32_value = 0x110;
 __u32 or32_result = 0;
+__u32 or32_noreturn_value = 0x110;
+
 __u16 or16_value = 0x110;
 __u16 or16_result = 0;
+__u16 or16_noreturn_value = 0x110;
+
 __u8  or8_value = 0x11;
 __u8  or8_result = 0;
-__u64 or_noreturn_value = (0x110ull << 32);
+__u8  or8_noreturn_value  = 0x11;
 
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
+	__sync_fetch_and_or(&or64_noreturn_value, 0x011ull << 32);
+
 	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
+	__sync_fetch_and_or(&or32_noreturn_value, 0x011);
+
 	or16_result = __sync_fetch_and_or(&or16_value, 0x011);
+	__sync_fetch_and_or(&or16_noreturn_value, 0x011);
+
 	or8_result = __sync_fetch_and_or(&or8_value, 0x02);
-	__sync_fetch_and_or(&or_noreturn_value, 0x011ull << 32);
+	__sync_fetch_and_or(&or8_noreturn_value, 0x02);
 #endif
 
 	return 0;
@@ -131,25 +186,38 @@ int or(const void *ctx)
 
 __u64 xor64_value = (0x110ull << 32);
 __u64 xor64_result = 0;
+__u64 xor64_noreturn_value = (0x110ull << 32);
+
 __u32 xor32_value = 0x110;
 __u32 xor32_result = 0;
+__u32 xor32_noreturn_value = 0x110;
+
 __u16 xor16_value = 0x110;
 __u16 xor16_result = 0;
+__u16 xor16_noreturn_value = 0x110;
+
 __u8  xor8_value = 0x11;
 __u8  xor8_result = 0;
-__u64 xor_noreturn_value = (0x110ull << 32);
+__u8  xor8_noreturn_value  = 0x11;
 
 SEC("raw_tp/sys_enter")
 int xor(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
+	__sync_fetch_and_xor(&xor64_noreturn_value, 0x011ull << 32);
+
 	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
+	__sync_fetch_and_xor(&xor32_noreturn_value, 0x011);
+
 	xor16_result = __sync_fetch_and_xor(&xor16_value, 0x011);
+	__sync_fetch_and_xor(&xor16_noreturn_value, 0x011);
+
 	xor8_result = __sync_fetch_and_xor(&xor8_value, 0x01);
-	__sync_fetch_and_xor(&xor_noreturn_value, 0x011ull << 32);
+	__sync_fetch_and_xor(&xor8_noreturn_value, 0x01);
 #endif
 
 	return 0;
@@ -158,12 +226,15 @@ int xor(const void *ctx)
 __u64 cmpxchg64_value = 1;
 __u64 cmpxchg64_result_fail = 0;
 __u64 cmpxchg64_result_succeed = 0;
+
 __u32 cmpxchg32_value = 1;
 __u32 cmpxchg32_result_fail = 0;
 __u32 cmpxchg32_result_succeed = 0;
+
 __u16 cmpxchg16_value = 1;
 __u16 cmpxchg16_result_fail = 0;
 __u16 cmpxchg16_result_succeed = 0;
+
 __u8  cmpxchg8_value = 1;
 __u8  cmpxchg8_result_fail = 0;
 __u8  cmpxchg8_result_succeed = 0;
@@ -173,6 +244,7 @@ int cmpxchg(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	cmpxchg64_result_fail = __sync_val_compare_and_swap(&cmpxchg64_value, 0, 3);
 	cmpxchg64_result_succeed = __sync_val_compare_and_swap(&cmpxchg64_value, 1, 2);
@@ -192,10 +264,13 @@ int cmpxchg(const void *ctx)
 
 __u64 xchg64_value = 1;
 __u64 xchg64_result = 0;
+
 __u32 xchg32_value = 1;
 __u32 xchg32_result = 0;
+
 __u16 xchg16_value = 1;
 __u16 xchg16_result = 0;
+
 __u8  xchg8_value = 1;
 __u8  xchg8_result = 0;
 
@@ -204,6 +279,7 @@ int xchg(const void *ctx)
 {
 	if (pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
+
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 val64 = 2;
 	__u32 val32 = 2;
-- 
2.42.0

