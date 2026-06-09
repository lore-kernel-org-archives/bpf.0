Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974A36EAB0
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986994; cv=none; b=qJGyR1olUZZ/2DyvhM5NEn3hI2+NaE6/phk5GIC3GtPYOQLojfeYr8XdFhcKdyT18raDdh9Grb9fbMTU/lv4EYzE3zLsFbsG4vjbY/NKehJDD42nGlpRBgVR7GLYVU/AfVQ5ZFyZTOY0eMFIwDO1EVEFrxoh3E61IWJGMaSBTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986994; c=relaxed/simple;
	bh=Hkzd8ny5+eb1sUz4GxJPXNxDTMF5Pg62d0dQMlh67wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaM4oJ34gsK61glKrXXVTWGkpHvC/UKWqhi4/HQ7C0VJMqk1bF+xnNvjVkeQ7cNwvPYeOkDirozhmXcMeQXmZHFr5HUE3CYzdisujEICTTjxDekSNI7YwPuUKAJ1s2NRqF2I21SUDEXD0cMatj1lwnU5fRBmloDyytN9kMOSwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0G/PHPaF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0G/PHPaF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d8b644473so5064837a91.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780986993; x=1781591793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdYODyfjwv2ON36BDjLCAyyFyBd+chXxXmNwR8kYud0=;
        b=0G/PHPaFz4bHCrtsrq7CmU4CHfhr4WFHUNAb+/j6w9tPKPAcCvOZEa3GcPYX03z8uh
         8wceXs34MnXaYf2qZeuh9w2A6APGMfCC32nOPDAXVGOTnlPDedvVQohVhCIyLnhUWLIZ
         oH0nEKtSXpt68fKrh18Y7RQ+yvoKzHfXRfDglctKr+QXftz6gL2uXuYkxtf+3DjEVzpv
         5iTVIyMbsMdaOF871+vcSWFSQgYgiyBEEcqa2d3zPTA10L+w/x5Bc14obVqIMivHYE/O
         sKPjWteHbVC5lr1R3JTADd+oEzuV62lOY3tDDXRY/Dhn45NAsDozDO/dxXshhgr6WCMi
         ZAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780986993; x=1781591793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdYODyfjwv2ON36BDjLCAyyFyBd+chXxXmNwR8kYud0=;
        b=Iw+ub3j/rGYzIbCPt3aOZnki7FHTwEjq843tl6WE1JrnxeyLXPoZT1d/6elm1PzS5y
         vj2cTQcQuz3WSG2CmAQ1R8K0Mjsmd+yyd881aK8L6vcCI53iYAczkQbzYFLsbSE4xf1J
         9UiCLKpJ0SBqgMIVD2PMlm640CpR7cNwLZkP4J93PcCgwR58z6otX59198rU7oghpzUj
         2HCZA7oOIK3PYPp+pWsME/rrxxF/z3rFbRVgGy+7Eleg0J5jc9jfWVc7A0YCRQN5zM4j
         AxZJ5sFUPxcGhiZHoJYb6XUZvrNImc5w5higzsSkiBMoRUW0iow6jw9jwFx7KS4npG27
         EpIA==
X-Gm-Message-State: AOJu0YwEQf+mRjE9nvjesUJUFlDjRe/q91JYmsocGfHvh0leT03qC6gF
	19Y5LjiC0d8EPEm0KMH0v8dY2HsjQrJba8U9mIVdkuIIjsav7qtzIQf6lfj2wGYSgA27cUwo546
	KxVOIb3CJyQ==
X-Gm-Gg: Acq92OGdRXKfhbtd6fTRu1GBqiH7CuYyT95z8k5+M5cZqPp7MxrJq8ZmYQFGqqsIJy7
	O0dqiaxTf6yiZNhWyeXozxbWLBLfldFrrfavWmZSAZq8EVepipOfh8/kEw4PLJ01Mmw+R9XFK4/
	3oT5hz6eZQhM+4fSjweOHLMTD/H/DvPlbGn8s7jDoGevaF/yZaA7idw7tslV7OGynmENniEcALP
	KB2zZy1TbrbBpSTbJ5vBMlSfDVnhlsjNoNfj8xLA2K+kt4pfyKJ/4LESUaWbDd/IYCJc3NY0sPR
	/nnnUjExIAhmuGUp0UtD486cOFqa93tr4NjKzNGnBZfsygD8wXikxtckGHw7AP+3QXs8SrKeZJK
	tQTz1+UpnZ83t4MDAaRtQXN//aam7N20agOpQB3g4PL+TMAHIXuKRXGBWzfvdeH8S/IFDwTiD11
	yWqWkHYttHlNAiW0BPE0ot1YQ0VqHWBMPUN2CfZgRiDSh5I8eSJGVVj9yhbwIECA==
X-Received: by 2002:a05:6a21:1b81:b0:3b4:84de:aa79 with SMTP id adf61e73a8af0-3b4cd09b4f5mr22705072637.44.1780986992557;
        Mon, 08 Jun 2026 23:36:32 -0700 (PDT)
Received: from krios (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df034a2csm17515353a12.3.2026.06.08.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:36:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kuba@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2] selftests/bpf: libarena: Avoid spurious spmc parallel selftest errors
Date: Tue,  9 Jun 2026 02:36:30 -0400
Message-ID: <20260609063630.10245-1-emil@etsalapatis.com>
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

CHANGELOG

v1 -> v2
- Scaled TEST_SPMC_SYNC_SPINS down to BPF_MAX_LOOPS to keep it
  compatible with bpf_for loops (CI)


 .../libarena/selftests/test_parallel_spmc.bpf.c    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
index 981c845e2d15..f08f2a92e194 100644
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
+#define TEST_SPMC_SYNC_SPINS BPF_MAX_LOOPS
 
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
@@ -452,10 +448,10 @@ static int spmc_resize_owner(void)
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

