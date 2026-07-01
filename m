Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E124DCF9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946240; cv=none; b=QOD+MZuf5SaffN33/5MKO6tgGf9R2A/bApWuHR9suM+SgZS+v5oDxNK/W8AsNzgtejv1PlZTM9DajZhWYz+1tfKpuurk4trwFDCZe/8p0IRRjCasTVAHfOtIJToZIG+niNk11FVUuOWM+lmhdwJLyY+PiKEpuWolQ/GU4MklTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946240; c=relaxed/simple;
	bh=Bjmxpbx6LPeWo5LdLTe8bYAUB1BK/9V8R16fmbZOwUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW7Mp06mpk5MrwVoWkEWUrUFs9+Mz51bB9W1yf4XiQKE+92L0JeASM0jZlU2GRf6YRqWquVxcUu9j1UtKhaO3W8bBlkAQY92JsnPvz2pmPGaQIK7IPPsBYUErVId7qtzBJkTMxIy+o0mEpfPQERDlaN0nASpEk8KJkuY9r3v5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Vsr3H/o1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Vsr3H/o1"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0c45c580so7234791cf.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946238; x=1783551038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=Vsr3H/o1AZULc1A3mDlaVmakJosOIwU/vWp4WE83TAsHzKxDv+tebGIPTqgr13CLZK
         xFD1OVhSHtjcXlHhqQQzyFN4FZljSqeQhFMmTOWk4FKugYCY+tqyqhi6jjluZBGA+Fcf
         IMue4W7ra0z/PjbisivhL6Iv11clcTwtnQ19UgWLzFnuB4bAyjbmP6wLqrUAdLUi+asw
         ONHAsL3YeIyJylMqyPo1eaaz7aGiDEZBo+fOsj4U36IWM+qzJTqcy4/dKlAfCM4/Pndm
         Q3l9Isu2Stzx8voWwc8D6UEYUXhnj4hH/KVr/vPhQnAD3u5A2ys+SUGRpUBtWcqqlmqw
         QoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946238; x=1783551038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=ZCjvq3/v5SnKE3s3CE+ZwQGViOJw6c7XDotjKExboNkHgxuSvDcZMxuOUtzxIiIJaf
         BwrhyPBC7O/q7ohV+U1NS0PdC5CFynZCWloMTuWcndFDpOGb0PMMHgZCHEj9il+1gAhg
         UR1BZ5UsVGK0lfKtEH4aQnes6JdmRZyJqwuxYiAE++dPIs5WQVWQ8kHutDkAeospB4fp
         x7brraofNiWWE6+Z1Cd3uqkU1JQ56y7OUTodB+tBmApQTnZmCtgLna8vmw4hYNe9mjcn
         ioQEtjw+rxJ32zzFLWnSnYxl6CeEDFVx9Q7rbQoTEYIvpANEsOssgut9mgOL+OYHHKPM
         K7Uw==
X-Gm-Message-State: AOJu0YxbjCq75UEqnqgU0PBPgO0QMwZ8kRV90DkHSuLyxqhdYbo1tAOo
	jVPYsN5ucSHRpKtwU7p3oJaiYzNBX12JFM9xF+LktegMjKCBI0meazlqWW9s9wDBWbGe1T/phs5
	Owrz6j68=
X-Gm-Gg: AfdE7ckApsFPfL8SyizSnekqNTFWTLE/JhpthFIT6zvPnANXpLZ5TwzHDBLRem8Gvwp
	IfaWkE3XvB9pnWAVk/fa7uaqABlzpE2itqcAHTeU9JNQxkVsj2oDFwXeLgmyPbbLr/hCDFfD1lW
	dnCNBch9iYpC1F6yi/U6uMyqF+4f0Xeuu6+du7IJaxeJX4S6BjXGYHMJQu6Rp/ZpsOMDW8NyLgd
	hMwfQPzbiVMNRPpNsj/cCgTTKn0ofgHdHu9cUffKURVJxP3kH/xOhlRznA0naMDZM9MGIJmd1BB
	G8JgPMOGrsLzuXGNkwX9QLm+2ydz+W75qP4mG7WqZTtSca9LbMA2cptV4EgWL0Kist/KJOnyI18
	9KdQ/INV+XC1qFj10d/obn/QTeYlR4XdpdEwXmyEWJWUcVZm4bn7v/pnDlWTveMYNe7QKlHCHWY
	aywx8F+BsAxzyy+zlbjMKXptDZGwDKPM+xKSNa4A==
X-Received: by 2002:ac8:5dc8:0:b0:517:5b2c:6aae with SMTP id d75a77b69052e-51c26a53b22mr47083591cf.13.1782946237728;
        Wed, 01 Jul 2026 15:50:37 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/5] selftests/bpf: libarena: Fix can-loop zero variable definition
Date: Wed,  1 Jul 2026 18:50:30 -0400
Message-ID: <20260701225034.12628-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701225034.12628-1-emil@etsalapatis.com>
References: <20260701225034.12628-1-emil@etsalapatis.com>
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

