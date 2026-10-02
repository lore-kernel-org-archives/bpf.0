Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D147F764
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938348; cv=none; b=EmW2toceFSVXG93MQgxLwQdnwuq3npUAwwUCpMM5Vxpk1Qay2/RerHXvuvSTw6cMu1K8uSoNGvZSE0d+OATmLK3u9cdXVPoXffJjU3/sl9rfbGrvrQTMEs8yxrEdmDkWIIcDGvPWgR1kzZvX4wSAVl9vNBaXuhSd4u4US1gjGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938348; c=relaxed/simple;
	bh=GixYfOzuqpausrHNaUJvUWUHDWCiMLEBqEefKQ0PlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG/vNDuf0VzfpnjKbdkKwfBeA7NxYsH92xGJ1dj20d90uNVAQqKiUhtPyN9e9fFS4H++cRBuMb5yaRrxyddNszSp01QVTXWL7XETT/V/C+/hbFzV57NiyueYCcNfFwviFi5YnMvBh3gXPRB0msEWcDYoaQO2EeF9CoNEtxn/qUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NFck2VZX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NFck2VZX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so36185865e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938345; x=1791543145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=NFck2VZXlJwtmf39omubAve75bJpoJvwdeXydfrG/J7MWibsQUjt8A8OdvPF9K/UK9
         ETNAj2PMq9h6qUSFBXyGVhwVNcR4MjuxVKXd7/ghuKK2Y6DjXY6J6RnwUQfGLfx8uqbr
         DmrQnR0qI3DVHqEw/5rFUjyyI2BmswjQTsKulqcCXU6eniS5Js90HsbB+YYorPF1wffB
         atkO70c+4sIStPyP6D3fBBm1pTRwHLI1PUPHj/1fMy7ccNqzirux7PcTBCn5ZQsXx/BO
         xu/NmUHtoZdstI6zsUMT054eLKLn28zste40ta8/0jvEDYXPeRmv6oHUCK97DiOzo+zc
         hEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938345; x=1791543145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=iY/3q5unyVJMbB86rtmz4E+lM+UKHZkLIMa9gH2a8hTCqHZg2dWh+UWobl3IEng0Ac
         UUn6pYJ9cQCuLM3PKP4VXNObM9rQjpaZIEUbClMZ8ugotuSS2DEh+q3W+uiQYARju/Dc
         VkNhxpPZV4nfD8D4CIROW3mbiTdju+wPGaEpEVv3+ibKMTpjGmZZsgYDqrnTaRKH6fgr
         MvmdtEY3Ot1Vns5VyrNb6RTBCBBN5Pc2po4gdXsA01/L9EKk3vy/hD54j64DCTu15wi5
         RDLdoUY9MUm6Xn6p3tCZlsbfd/VaqUEKbEGMTXzKm1hXRc7oBLQWX9gnwQTn50lT5PML
         uq+g==
X-Gm-Message-State: AFuF++l12vvAZYHKnBVE0WB8+ZGmj3V4Za/ao7nBibJyC0pZb5h2IPR3
	htrVbYxqKJQqU5i0yz6O6fPvi3vlqK41gYvEkDIFyyJ4vQRweO2YgDXe62JPmqCqY65WDbvJlqF
	WuDYkAXE=
X-Gm-Gg: AYBFou2l1crRNzPD7x8n/hWaZ2Fx/n2xTPgSx8wgEuM2LSxXO95V5N7F1aYhXk4mu85
	GyixqBC9kCSWi6UtpjM9bvuRKLuyggkhsuNISBwX6M27tner27/JZKX87Ii8MGZdgQfAbryjY+f
	RvNRwVS0FdYS/yOkZtkj6MmuL3ZxoKatAgl7WT13nXhwA7BVNPtL/Sxp86Vg8Ici7XnqeKs+ZSB
	i9GVqtcIf7qUcyNmnl6V4wIB+4ekYoOK1o/XORniqdiK4rlvtSc/Oh8kg+bhfJA3aF4/YdCwA6F
	MNIslgnIqnJZrYQRfRNmPvUIYZ+x4jvUEOX9xjuF5+8OtbzA81aYzi5EDB5olcoJD3iJAHM9tID
	ooZn5gUP6ohTtDFyO3ult2DWNh0juWtsRhOh2l6BXxTOlCuBoZgtfxIEiV1VVwdi4dM97Ogccsh
	DZDJcz+2rhCmavHy2Bp4nfVfLW5F3PWvZ0+o8V7ItZH2xhn77+D/UjV2Rmfg==
X-Received: by 2002:a05:600c:e557:10b0:4a0:2484:2800 with SMTP id 5b1f17b1804b1-4a0274f40d0mr27586635e9.3.1790938345110;
        Fri, 02 Oct 2026 03:52:25 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:24 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Fri,  2 Oct 2026 10:52:15 +0000
Message-ID: <20261002105218.6171-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have relaxed the limitation of 1024-page batches for both sleepable
and nonsleepable arena allocations by removing the intermediate page
array. Add a test to confirm that large allocations succeed for both.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/progs/verifier_arena_large.c          | 64 +++++++++++++++----
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6ab8730d4878..dbdea14ca76f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -10,6 +10,9 @@
 #include <bpf_arena_common.h>
 
 #define ARENA_SIZE (1ull << 32)
+#define LARGE_PAGE_CNT 1025
+
+volatile int zero = 0;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
@@ -284,6 +287,7 @@ int big_alloc2(void *ctx)
 	return 0;
 }
 
+/* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
 int big_alloc3(void *ctx)
@@ -291,24 +295,56 @@ int big_alloc3(void *ctx)
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
+	int err = 0;
 
-	/*
-	 * Allocate 2051 pages in one go to check how kmalloc_nolock() handles large requests.
-	 * Since kmalloc_nolock() can allocate up to 1024 struct page * at a time, this call should
-	 * result in three batches: two batches of 1024 pages each, followed by a final batch of 3
-	 * pages.
-	 */
-	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
+	/* Verify that a nonsleepable allocation larger than 1024 pages succeeds. */
+	pages = bpf_arena_alloc_pages(&arena, NULL, LARGE_PAGE_CNT, NUMA_NO_NODE, 0);
 	if (!pages)
-		return 0;
+		return 1;
+
+	for (i = zero; i < LARGE_PAGE_CNT && can_loop; i++)
+		pages[i * PAGE_SIZE] = 123;
+
+	for (i = zero; i < LARGE_PAGE_CNT && can_loop; i++) {
+		if (pages[i * PAGE_SIZE] == 123)
+			continue;
+		err = 2;
+		break;
+	}
+
+	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
+	return err;
+#endif
+	return 0;
+}
 
-	bpf_for(i, 0, 2051)
-			pages[i * PAGE_SIZE] = 123;
-	bpf_for(i, 0, 2051)
-			if (pages[i * PAGE_SIZE] != 123)
-				return i;
+/* SYSCALL programs are always sleepable. */
+SEC("syscall")
+__success __retval(0)
+int big_alloc4(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *pages;
+	u64 i;
+	int err = 0;
+
+	/* Verify that a sleepable allocation larger than 1024 pages succeeds. */
+	pages = bpf_arena_alloc_pages(&arena, NULL, LARGE_PAGE_CNT, NUMA_NO_NODE, 0);
+	if (!pages)
+		return 1;
+
+	for (i = zero; i < LARGE_PAGE_CNT && can_loop; i++)
+		pages[i * PAGE_SIZE] = 123;
+
+	for (i = zero; i < LARGE_PAGE_CNT && can_loop; i++) {
+		if (pages[i * PAGE_SIZE] == 123)
+			continue;
+		err = 2;
+		break;
+	}
 
-	bpf_arena_free_pages(&arena, pages, 2051);
+	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
+	return err;
 #endif
 	return 0;
 }
-- 
2.52.0

