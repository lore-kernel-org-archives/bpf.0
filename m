Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25E279903
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958861; cv=none; b=ZSvwqhsKNcZPdEJIC2Mcr/JzRV1OKwyT+2UOcmN5A7Y0mEaDa6cO3+z16sgmIUdMrhCmReVzf4Hbid9bFumKXr/4zzswIIUvXiNnxBcK+DTWchYcSTJi9fiyFlIIFLIuLvi8UY3BAHG13XruxS9R+e2OqqoEZCwzu+F2jW7inmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958861; c=relaxed/simple;
	bh=rA2diYXlKM26hvh1N+s4o9HX51c4rjZCryaDSzZf5Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fn3pzZD6zIuw2A4klnRKNDXqKDn1u+3ZiqEjSGKttDoa7FKfRFkhBqWP/MGpyGO3TYzYrtfZofzJFqw281DQ4jCla81gCEkLIXCfaVeOl7g2Q5mGglxzz1Ky2Eo8cVnQD8YiF/nVZgOVrMU3biAGf4RfjA4wGME6vrg3gnDaemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZC8n2aoj; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZC8n2aoj"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137dd523634so7710246c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780958859; x=1781563659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QEGVQ0M+SgYUmHdGUTH8kzMgflfS+kHy0QHV9BLJSE=;
        b=ZC8n2aojZqM51DkLzfTZY1i8EoiOzMMkxhgUgpx2UwtR7iYJKRVD6GpD8ZhXopRuRI
         zIZ+/r0NCkErN7hVx5ylTFhf/d5538SRcFj/82vO4Icru6ywHjEpRzTvp5jpdQIjBKRH
         iiylQT+SyHRY1E8tknHuP4YtLTq0fqU8jXTPASgy9g9jfyaAUubMiVUZTbWLpgLxBLFP
         414HDdBwYWWiVm2XzqGHMOoRVtsWBFZebXF6o7JpTsGZe2+hEUgZyHTXP7nOzvntm+7x
         +GsYca7zlvLqW0oJrQviVjgmF0ifNdWNH49o4RSAoAyuGCFojZQNcoxfl4GkIGo66lOI
         DTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958859; x=1781563659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QEGVQ0M+SgYUmHdGUTH8kzMgflfS+kHy0QHV9BLJSE=;
        b=UB+hOlMAv+gdpP6qhFpGahstarta3UDYGdvo0MDjNnKC8nPagvz2kJkZiyK0yrGtAh
         Sbj6Sot//UdIEhfwFtACn1pNDFEOKpaXz+Lb3/AmBE/TTOG6Pdy6Mrxn48hdrkusAGMj
         yfVf8fZGmDGyFfAGytm1ypa1KWXfALUY/bRoMXVylazLJp4WpyvUMsjTy8wT/ScGBXZc
         XRjpDwvgZem/bYTGLp6dRh8+4VA0Qra/unEMVhWenbwupQ7wiYCphJDVljBNcJOlVSB+
         5hthJLqjLMfFvTf38DQb3z1gGfvThOQgXw+63WT78hE6ViMYhtT6OJwUy6oc7UE8dWIs
         Fi4g==
X-Gm-Message-State: AOJu0YwjHMJYJeJrdTwDWbH0WXVqAGBJ8o3fIb6GdIJA44cY2Ydx97Zd
	nRujTlarKrH63GMHbyhlR0Kh2yBVuj+Qc/4fycSexGYm4J7Rwe6PL0tRRZG06SmUd571JKsz758
	MoHg13wfxTA==
X-Gm-Gg: Acq92OG7A6zttJYQa37XlTj2MJ1tFDgDOZPHRNd+akCtuFwSyrDW3/UhifltiCkgpQw
	rnLuiOMdzBkbExgGmKoYkeWO00U3FjAc0Wxza60epmZsVZNGrxn+p2H4szlAj7PgyWe/0hfTa9s
	QmGmWgN44WhhDY/RyotL+DCRJZDoFKOrHfkisKh2/bH8L1yRwCR8dq9tgMO+p4RAFH/hurYa536
	9JNqgxzll9/6hHk+PekNMDn48aZ+iGNGiQDeDT7yGLSkbGmtW2xJQqiaPowdBAtIdGRvv8wqDt4
	4SmZ/aiLtiibBtIpnoqBbrKT5fP0t1Z+ii0TMqgsSR3JhkpswLgjMUDMsZIuDZ6lQHSgZXGoZKg
	NxYoNcXv/NZslmLD5WLihm8K+ENCUkl133KVQ2GFGDBLB4LTD8bpHVwZp4ICFxiZBDoDJqljwdM
	vf1DXweKcBNLahHSXsy7lXARwMaTyqsA==
X-Received: by 2002:a05:7022:699d:b0:132:5d42:55ba with SMTP id a92af1059eb24-138066d8107mr8252776c88.16.1780958858965;
        Mon, 08 Jun 2026 15:47:38 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::abe5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539432sm16095148c88.9.2026.06.08.15.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:47:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kuba@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] selftests/bpf: libarena: Avoid spurious spmc parallel selftest errors
Date: Mon,  8 Jun 2026 18:47:32 -0400
Message-ID: <20260608224732.4482-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libarena parallel spmc selftest is nondeterministic by design.
As a result it depends up to a point on the relative timing between the
producer and consumer threads. This introduces the possibility for two
kinds of spurious failures that this patch addresses.

1) Spurious timeouts. The test proceeds in phases, and threads use a
   common counter as a barrier to avoid proceeding to the next phase
   until all threads are ready to do so. If a thread takes too long to
   reach the barrier, the already waiting threads may time out.

   Increase the current timeout. The timeout's value is a balance
   between the maximum amount of time spent on the test and the
   possibility of spurious failures. Right now the timeout is too short.
   Err on the side of caution and significantly increase it to avoid
   spurious failures.

2) Spurious resize failures. Some selftests require the spmc queue to
   resize itself. This in turn requires for the producer side to be
   materially faster than the consumer side so that the queue gets full
   enough for a resize. However, in the benchmark the spmc queue's producer
   is outnumbered 3:1. To offset it we add busy waits for consume
   queues. However, we still see occasional failures due to the queue
   never resizing.

   Minimize the possibility for this in two ways: First, remove one of
   the consumers. The 2 consumers still exercise the "race between
   consumers" scenario. Second, increase the busy wait duration to
   decrease the rate by which the consumers act on the queue.

   While at it, also replace a stray invalid error value "153" with EINVAL.

Fixes: 42998f819256 ("selftests/bpf: libarena: parallel test harness and spmc parallel selftest")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../libarena/selftests/test_parallel_spmc.bpf.c    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
index 000a4d58665a..a81aa29c9671 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
@@ -7,7 +7,7 @@
 #include <libarena/asan.h>
 #include <libarena/spmc.h>
 
-#define TEST_SPMC_THREADS 4
+#define TEST_SPMC_THREADS 3
 #define TEST_SPMC_STEALERS (TEST_SPMC_THREADS - 1)
 
 /* 
@@ -17,7 +17,7 @@
  * and operations are wait-free we just spin around the quiescence
  * point instead. If we time out, we just fail the benchmark.
  */
-#define TEST_SPMC_SYNC_SPINS (1U << 18)
+#define TEST_SPMC_SYNC_SPINS (1U << 24)
 
 /*
  * We track all the values we retrieve from the queue
@@ -61,7 +61,7 @@ static volatile u64 round_steals;
  * We have multiple stealers and a single owner. We sometimes want the owner
  * to successfully outproduce the stealers, we add a busy loop in them.
  */
-#define TEST_SPMC_WASTE_ROUNDS (1024)
+#define TEST_SPMC_WASTE_ROUNDS (1UL << 12)
 
 /*
  * The spmc data structure depends on the runtime fully
@@ -112,10 +112,6 @@ static bool spmc_tests_enabled(void)
 	{								\
 		return spmc_##prefix##_stealer();					\
 	}								\
-	SEC("syscall") int parallel_test_spmc_##prefix##__3(void)	\
-	{								\
-		return spmc_##prefix##_stealer();					\
-	}
 
 static int spmc_common_init(u64 total)
 {
@@ -451,10 +447,10 @@ static int spmc_resize_owner(void)
 			resized = true;
 	}
 
-	/* Did we get to resize while racing/ */
+	/* Did we get to resize while racing? */
 	if (!resized) {
 		test_abort = true;
-		return -153;
+		return -EINVAL;
 	}
 
 	/* 
-- 
2.54.0

