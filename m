Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA042464E
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361858; cv=none; b=AU9qb5UpI/ug56gKQVJ/8yj2eo+cwotalXgOIY/BFaurB0Vdx4hWU3pY1QwGYp1BrVTb1tN4mZWfwPvfe70qtNOF164tNmfQdR2wOSFTbd6RLmkGF5r8LyGGsyKqzxFW//cGktOJWIVWXYhUIG/YEq07xP6FO/oIJo6NoYcCGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361858; c=relaxed/simple;
	bh=Bjmxpbx6LPeWo5LdLTe8bYAUB1BK/9V8R16fmbZOwUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FChamGuA/kEBmaqZ7dt6MJIsMYUM8cC6sqvodNujpHL5x1vKCnm5F86pAS2luZNyq+oVl1TYBOySJPfag/YVUF4LsMioOhK+oqJKonb8lA6988Uwzgytc5dhidtmgCYnjKa9J97vX1LHqTPpTyv1XvGOA2azopv0Xuw5INsg2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h3odemvZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h3odemvZ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84347ad88edso4589525b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361857; x=1783966657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=h3odemvZ5OisuO1jZxkuiHH4sykVeWbkKEaRoGpxUJ6O+FpcjZoGLEU3NreaKwVN+p
         hggOxWGOBc/w5xQO4FxtG5zGxQMdgor1IjAZ+1ocacIp0HK9CDvcxlC4IweOV9bOgNX6
         e3pOW595T31dy/FEJvHQpKW1Vl7+ofUM/GU1Oy1sIAu78mGZbbQWVCEvNf6XPMOVhZ/F
         hsHO4nQ+ObDgyHlaANqxWynufqMOUDRrQGX+bcJ8TjspAvXQiS7xnBmQobrY5GSjHIIn
         Gsg28YhToVo2yHqGGM4kvYwwaM3Kh2fkpS0N5TOA1PjpfIs4YTjg7PjFp1p9U56eoA4P
         t2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361857; x=1783966657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qj7RbRK4BFD8+DfDm/PJ4jE4/7slNtb+xXi7fB0EI54=;
        b=qEDLss4IoYiSVPzlWXDmZdqcpv18tTFaO3k0yOAq2rQtPI15VyjZxhDX63HtjLsZPn
         /6khbJpeDfpfgilgu5oDa/UN7bSaW+TB0KLHl0AowBBLC0ySM3TNtiDgSD6VnWrr7f3t
         qZgSd06G+eG/iksqwP20PXTFnYWq2EnesWxsVzrClisdC5VPHa0mx+61emAAyEjNvc9u
         1ce6iDUXk2i1cVtrr0chIXlRnAHRBNwE+joY+4pOJ0GRsnjUc22CIghnIDH7+j8xuJ0m
         bWsh1YA4uFJvPXMidMUGm9MzV01ULxlRofOeAiB+qUDmX5hNWd2aJGSz9/4Kf0Cr/J89
         Njcw==
X-Gm-Message-State: AOJu0Yx2cQxFmSTQrvP67vF6fbBjGYg0YdJTUdnpXo1Nikq7UA+daj5N
	86LD27YUO712GYxeCtqNlEuIKskDN9UCWJh7A9r1iNhJoUE4mHG+EsCsHkwIsL8YzkROrz4sXBr
	zVoXK+ao=
X-Gm-Gg: AfdE7clgZD6vDDys6h4Tfvf2pXGswf0MlYa9GJ3fXURmylhAMf0hs3tyBurf6tVj1Ar
	tVni7JvHycseR2teWE+V1Lh0F7duZuDnpMFu3OWt7UYbpTky//2Y5AEJ1Fo2M8CK0B6MyateTZL
	U46Nfrnwu6PcvF7B/8nCqOlT+WwdEkS0g6Ai+CTEo0eYg7fYkv9djVQBFcv0XWinwLMN23UOED6
	wXbjzbFvaUElTI7VEjOoQmT7u7IYjPN7KThcFaxvS2m/kgMuUCXnlZ4xuyFf0GEeJ+mY1Nj+e1M
	LxAaXPDN4f9MDb3KtHgTKn4nz9hRbL8Wq/rZfCuEkSPVT79oekncDsNlvp7IPZnttXZ7vVYXkdQ
	2qsoOyRu94Tam9uXpZFYc0QkUlA6kl+A2VZdk/EOj31KS2956dKsX+5tt3ICKwclOgouVAZZ8Kx
	x5FljX97lKkudYNtX/qfWxpg38GVUYqSIRzZa9mH+sYEBXlFs=
X-Received: by 2002:a05:6a00:aa0a:b0:847:8dec:141e with SMTP id d2e1a72fcca58-84826e38738mr1884485b3a.54.1783361856579;
        Mon, 06 Jul 2026 11:17:36 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:36 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 2/6] selftests/bpf: libarena: Fix can-loop zero variable definition
Date: Mon,  6 Jul 2026 14:17:26 -0400
Message-ID: <20260706181730.21731-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
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

