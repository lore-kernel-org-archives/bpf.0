Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0622EC090
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931961; cv=none; b=iwY8DMVJasjRI2v1fJjdfGgCb8p14GpK2gt7tv+i4paG+nR65GESP/K2oTX7ux65A4CSGA8Iv20lev+lsaWz7aZknZ8zgnQc6oqI/yJwk/YPpN6DDVjtL79NqvcjX0pclX2S4pVeT6SEQosYWA7MQs3JggFANx5Db4KX5t9KgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931961; c=relaxed/simple;
	bh=Bjmxpbx6LPeWo5LdLTe8bYAUB1BK/9V8R16fmbZOwUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3KD/4XXan4Aiy4O2JvqYWE4ryPsm9w8xpl/45kBkArHQL7Iesg9HzXcOav2ZJhtlHEqi4uMoDU+COXq3fGAecb6lqPiWl7pzk6l9v/SE+rIo86kGCUb7Nhnu4+/nTUiQxfu5fd54o9JhStDpypFeBeHz/Bn5oSn/ljMV6WYUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=msAWtwVM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="msAWtwVM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50979c71so93339885a.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931959; x=1783536759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=msAWtwVMrwFVZFgiEIKNw0fCH9PKyzs9Sk0Gvv/lhr5jxUZ886KDxvqZe5J3PAXIYm
         xCSsp5TROiSwHqCoXJq2cjbpCF4gnz8XB4n8lUsx57kaDByaD+F06sHS5HvmPvbTOmLo
         WzIJRbsGAFGnOWdwmDq5YMh4U+H0l92EhX8dTW0Znl1uEqgmFIV3HlDZkcRJfrsy38QV
         rzC0IZ0YPRyKpOtKCA9cLdnWa07rtf6837rWEW0hI773NddssjKYS+ytUg8HdzTGmj4e
         teoP2lxZU5Uvc7b2JuzCrncGOwPDWTQd1CQcuO0J5Flf3pjoAKfQiod1CVM5HLTltXTO
         Cmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931959; x=1783536759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=Tivt70NC4ZKJt2FokGcj/OOwgBGPwTCSNEaz8uwnHywgPL75fmkh+Lc9CXhabHIVBp
         KfddShClYTiInSUy9J/AZA9cVapd9hOGINqQEG9s+y57+WrNnc36d7EYWdO2kuy9Bs/Y
         4tq9EQEklbNLYTqt1S/zg76U5mb99Lmt5Y/2u9UIgfnlXFYzl+rIMDuaN97fCzI7woRX
         sSf9vXxUn4gEclAvkjqqbhlo5YJYEgxxV56ZWrj00AchsHwhZlk3lVECXr3n1O7yvucL
         d7k8J0ZoaX1Zpm1LRWZHfsxTYMzNvx/JJ15wP5p71NAepYLKH29fcYQXwoBmUNLGXbU5
         P2xQ==
X-Gm-Message-State: AOJu0YwBPEe6FuIWgbxpUqeJBBWXlUFewVflk3ze+/AapgpF3Js4Xabs
	Am1qN8Duz8/7inb0lb9StEKIc5Bb1RdmgsRoRqOm7uc1gP4aj6YP5zztUuvDXTqloIUd5uKcmPx
	Ppmi85ac=
X-Gm-Gg: AfdE7cn/5DdZTjj9PCPF/Go6nG7j4Nj1N+cn7zepjUPTQm/rwKYA3FKAydeGKhWs8gx
	0CGwgbfSRgK+m6lqjS/KI9CMCpHphdo981TuVMyEmwSIWcgtj8ZnrQ3VEB/168fREHdIZAsJ0HS
	BJS40FoJpFV8Nw4q9E5bJXJGkeCJgAejk7woU44MmXc+qbLcQVGseMg+Ho6dTxb2CJMZVStMqKA
	MGqT4qaTOJthCpU9NXh25VpxfXHyEIzwfYJw8ZbP+bKKyBFmULBZzyaperlYJuLc1aThNtlN0eO
	yHsVFiDMGnBFQ2zPYbyiodVs3P5zPDSxfMbwwDA/og5d32cwMhq8GtMQdIuU257IzXI4bJmyWrt
	cUcWlbyA1lvEAxeaitPXHLIJi8ZwjzHMtgbdp+8Y1mHGCZRmi6qtzO/GEoM9agLG0zXx92Z8JVE
	QbhN1o08ucmt6bjghXIhkrT4SeyYRIImQSI3jqbw==
X-Received: by 2002:a05:620a:d8c:b0:92e:6637:da8 with SMTP id af79cd13be357-92e7825c418mr438461385a.28.1782931959011;
        Wed, 01 Jul 2026 11:52:39 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 1/5] selftests/bpf: libarena: Fix can-loop zero variable definition
Date: Wed,  1 Jul 2026 14:52:31 -0400
Message-ID: <20260701185235.4516-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701185235.4516-1-emil@etsalapatis.com>
References: <20260701185235.4516-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF can_loop based loops require the index variable to stay imprecise.
This means we must initialize them from a currently imprecise variable
instead of directly assigning 0 to them, like so:

static volatile u32 zero = 0;

for (i = zero; i < NUM_LOOPS; i++) {
	/* loop body */
}

The libarena implementation of this technique is currently faulty. For
the technique to work, the variable must not be in a map. This includes
the .rodata DATASEC map used for const variables. However, libarena
still defines the zero variable as constant.

Modify the zero variable definition into a volatile variable. This
change adds a complication caused by the compiler optimizing array
derefences from

for (i = zero; i < NUM_LOOPS; i++) {
	val = *(ptr + i);
}

into

for (i = zero; i < NUM_LOOPS; i++) {
	val = *ptr++;
}

and causing verification failures. Use the barrier_var() clobber macro
to prevent this optimization from taking place. Using barrier_var() is
the only way to break the optimization, as annotating the index as
volatile does not suffice.

After that, remove the bpf_for() invocations introduced in libarena for
parallel spmc testing.

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/libarena/common.h     | 2 +-
 .../bpf/libarena/selftests/test_asan_buddy.bpf.c         | 8 ++++++--
 .../selftests/bpf/libarena/selftests/test_buddy.bpf.c    | 8 ++++++--
 .../bpf/libarena/selftests/test_parallel_spmc.bpf.c      | 9 ++++-----
 tools/testing/selftests/bpf/libarena/src/common.bpf.c    | 3 +--
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index a3eb1641ac36..931ace9a49e2 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -43,7 +43,7 @@ struct {
  * imprecise. To force the variable to be imprecise, initialize it with
  * the opaque volatile variable 0 instead of the constant 0.
  */
-extern const volatile u32 zero;
+volatile u32 zero __weak;
 extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
index 256d62a03ce7..3266a28f53d7 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
@@ -154,7 +154,8 @@ __weak int asan_test_buddy_oob(void)
 	size_t sizes[] = {
 		7, 8, 17, 18, 64, 256, 317, 512, 1024,
 	};
-	int ret, i;
+	int ret;
+	u32 i;
 
 	ret = buddy_init(&buddy);
 	if (ret) {
@@ -163,6 +164,7 @@ __weak int asan_test_buddy_oob(void)
 	}
 
 	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		barrier_var(i);
 		ret = asan_test_buddy_oob_single(sizes[i]);
 		if (ret) {
 			arena_stdout("%s:%d Failed for size %lu", __func__,
@@ -190,7 +192,8 @@ __stderr("Call trace:\n"
 __weak int asan_test_buddy_uaf(void)
 {
 	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 1024, 16384 };
-	int ret, i;
+	int ret;
+	u32 i;
 
 	ret = buddy_init(&buddy);
 	if (ret) {
@@ -199,6 +202,7 @@ __weak int asan_test_buddy_uaf(void)
 	}
 
 	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		barrier_var(i);
 		ret = asan_test_buddy_uaf_single(sizes[i]);
 		if (ret) {
 			arena_stdout("%s:%d Failed for size %lu", __func__,
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index b45a306816c0..5628f0987012 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -171,7 +171,8 @@ __weak int test_buddy_alloc_multiple(void)
 SEC("syscall")
 __weak int test_buddy_alignment(void)
 {
-	int ret, i;
+	int ret;
+	u32 i;
 
 	ret = buddy_init(&buddy);
 	if (ret)
@@ -179,6 +180,7 @@ __weak int test_buddy_alignment(void)
 
 	/* Allocate various sizes and check alignment */
 	for (i = zero; i < 17 && can_loop; i++) {
+		barrier_var(i);
 		ptrs[i] = buddy_alloc(&buddy, alignment_sizes[i]);
 		if (!ptrs[i]) {
 			arena_stdout("alignment test: alloc failed for size %lu",
@@ -198,8 +200,10 @@ __weak int test_buddy_alignment(void)
 	}
 
 	/* Free all allocations */
-	for (i = zero; i < 17 && can_loop; i++)
+	for (i = zero; i < 17 && can_loop; i++) {
+		barrier_var(i);
 		buddy_free(&buddy, ptrs[i]);
+	}
 
 	buddy_destroy(&buddy);
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
index f08f2a92e194..5fa96eb74095 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
@@ -155,7 +155,7 @@ int spmc_quiesce_on_owner(u64 epoch)
 {
 	u64 i;
 
-	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+	for (i = zero; i < TEST_SPMC_SYNC_SPINS && can_loop; i++) {
 		if (test_abort)
 			return -EINTR;
 		if (smp_load_acquire(&owner_epoch) >= epoch)
@@ -175,8 +175,7 @@ int spmc_quiesce_on_stealer(u64 epoch)
 	int err = -ETIMEDOUT;
 
 	target = STEALER_EPOCH(epoch);
-	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
-
+	for (i = zero; i < TEST_SPMC_SYNC_SPINS && can_loop; i++) {
 		if (test_abort) {
 			err = -EINTR;
 			break;
@@ -391,7 +390,7 @@ int spmc_wait_for_stealers_to_start(u64 target)
 {
 	u64 i;
 
-	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+	for (i = zero; i < TEST_SPMC_SYNC_SPINS && can_loop; i++) {
 		if (test_abort)
 			return -EINTR;
 		if (READ_ONCE(stealers_started) >= target)
@@ -537,7 +536,7 @@ static int spmc_wait_for_round_steals(u64 target)
 
 	arena_subprog_init();
 
-	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
+	for (i = zero; i < TEST_SPMC_SYNC_SPINS && can_loop; i++) {
 		if (test_abort)
 			return -EINTR;
 		if (round_steals >= target)
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 50be57213dfb..1b4bb19b3c52 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -4,9 +4,8 @@
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
 
-const volatile u32 zero = 0;
-
 struct buddy __arena buddy;
+volatile u32 zero = 0;
 
 int arena_fls(__u64 word)
 {
-- 
2.54.0

