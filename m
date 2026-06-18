Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713153AE706
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772998; cv=none; b=KihEgP41QaasjhTDpfRlxBUv8wvQ9cq9TQ2Vgow1bEm0BqD3rQBlp/AOrHfH1snxFpzExTyB91zBpeOg0iAbR3tEIMY0SN3m6pzAhVw4CLWxZZ/wlI1JMlqXEaUffV9/bIwJtxpdyDv5q9VNOmSKfnRK7/SZ7ophzo3GlCEwTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772998; c=relaxed/simple;
	bh=qjXWPSZjU3V3wD8GrlMPvJ9YmcoVUpAkK/J8C2/pPIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZj6pOWjEmHd4XdQvnKpbRSY9u0foHOhEj+o9Z1gbh1cbDiQUiufTtUEm6PHmBGwE0lootdouSCPCwXkNB7LSzVKUbkXYX/tgPWe2TaAoH6LXBEFr6iqimIdEHlSMplcGEaZOl4Zs9CVrmAhDFY883hIWe/9RXzGhgbtveM2ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aAmAQ0j6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aAmAQ0j6"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8894560c89so238294a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772997; x=1782377797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfQon+s2wDout05Rpx3l72P6aRxpbYxTNs6LHvTVSj8=;
        b=aAmAQ0j6WRPHtZ9vrIwTRbFyN5CwlPTiPVNvIkYtoP0rKqSkCtoXgCT87G2Phd7kX4
         venY6Q9xuyEOsOypdADQbyKTXsrkgI1M2mD1eHRM5GmSRx6oC18Est3oOKK02lyth1+J
         i/PMAgeT15lon4u+2K45AS/GB0R86KABnHl4l5gd8hOY/YZb8ASOChmu1/bw5sFHqt60
         lvi9OclX0V8pNpwmexoAegV497EQdyjXA3GTn4JD3AWksmL3Uq+xnwFf9SPCkfVqzz18
         wl5EUA+XDqWQLzrqwCQFsU4TaO+TUniObGsH2XJE09NHASLN9VAJr8K5cFMpXaz0lg9P
         jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772997; x=1782377797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfQon+s2wDout05Rpx3l72P6aRxpbYxTNs6LHvTVSj8=;
        b=SFjYO7jzXN0QM9BN1Z3pZUxMGoQ3A9ZZu0kXmSypFUAeIzV+TAPzduFfd9V0LPPADw
         mY3ao2TTU9zNLdpcgt4RdObw5rrZnK/4zPrhoO6kvddHmeK1XcAPvqwqZVn/AbRhDDvQ
         wXUJGRHeL57wtZtonjj8o+lOZvebOcNGyeU1GciX86teOigdDz0ZYlqPRSiYmVq61Zi/
         qL8cbxKMRmCn9HDK1k5aqyaVhpwCLSdZ5IDl/VfhqCOhVXB6kI0iQrhA/6MkvHsvTT7d
         pPehSQoo1CoAjnMgOPZ/7YKDmBechhFJ4mFO9SuKrhSs6jS9umGQ196yYCp7hZlhaTmL
         0HBw==
X-Gm-Message-State: AOJu0YzkId4sOYShVwCO8IzPVk0DEXdCnv6wVKrXR6dcTjBMxeVQl22F
	ITtSlxbqKOUWyTNUenPA8RxgAaYPSmw+dSzsKqDGYvpPP+WF9s10++0of5JcS7FyvzsRvSYSEyL
	yQKhBytmdeg==
X-Gm-Gg: Acq92OF9sqYb1kZxpXUrP7n1S6PfBOzCXgMJ2GUsJg5bfjoVVTxoKwgSyrGTZBz4VCu
	ogYFmwPh+qbOSu59mM8vexiyiwTkkiEmKzlDPCFwjgibKNH1OBCf4fqUADvkMcJLkm6ZwTmcfDp
	dpWFKaBTCse9LHikklL/eBl6BNM6xsfMSJUSDMeRRFQcjttjNsILxGDq6P7HbctIg/ENttFTCtZ
	RUg8ttpBQiFDHYK+EPWzTmfxPEXGc4QvZOD4pknfNM20nMf+iToKG6i3QcbSJl/v6EAu890Dpg9
	qDRoQJW4hnuXUJo5UCVaICx+DTnPxfN1p394un82OW1W4u/ikY+diKgED95W1q9fZSQnfppsF6G
	pCCINTlj5ghs5l6xQRS470/skGvKb7kx8Tdm5t8MJRKtirei5SaJZZokg6/sVicuHQZK/pAH8gq
	1yQOEtq/NyWhpLDZwf/7spwm4ra+DKKzFXMm6402U=
X-Received: by 2002:a05:6300:6702:b0:3b7:b328:4c8f with SMTP id adf61e73a8af0-3b8b582e3c6mr8581432637.8.1781772996789;
        Thu, 18 Jun 2026 01:56:36 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:36 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/5] selftests/bpf: libarena: Fix can-loop zero variable definition
Date: Thu, 18 Jun 2026 04:56:23 -0400
Message-ID: <20260618085626.19633-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618085626.19633-1-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
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
to prevent this optimization from taking place. After that, remove the
bpf_for() invocations introduced in libarena for parallel spmc testing.

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
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

