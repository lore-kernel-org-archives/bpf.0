Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813D55198A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707176; cv=none; b=eL7RExraDDm8Vp1zuid9GZf0EXRt9d5U4DSGciSeUDYkp5cBUmL2+5WpiMmIRxHk8Cq9S7BpV8u9otbDTlHB7nT5rpxPLsKj0CQP4YvXZ6rbV8rP5M1vUyRkIdgMRLNr8CNLAQa3wIfz83S8iAqjrW5VicxuhREKZra+mJw5ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707176; c=relaxed/simple;
	bh=GixYfOzuqpausrHNaUJvUWUHDWCiMLEBqEefKQ0PlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iws9nc4LlZpEys+0pnFOzERJ+nvxsRtjLltC8299exBvAIMecRFqZXggFJZ7TMJ7f2hLvQErAz/BH7OnEWZq+0Ww/rSpzZPt521/bPtWUjGSpxZSm6ngvZsWANsW1fU41dFenqJ0ArLthgYGkR0ltw724dGaCtXrzZLNMr76cBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=quY0M8xz; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="quY0M8xz"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso3344112a91.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707174; x=1791311974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=quY0M8xzR+/8TSo8kU8sNdbT0R5IBFfd09cv+smBr5ICztPffMt7Rn0H1vAsfdiBtn
         VwOD6I6DUE00GzM/cuhWFT2pxae8hOPOv0d654sfyI0kkEb7Zt/9wBhuY69DdzWAte0k
         t4MYo+LWzTNBVMTFnLGm18JDv7L/9wPci5e5vcA7EDtKmLpFelAZRgbrh4kuITKoUuON
         b/vpQNjvTGP3U8w4XCNhGhj62jUDfRGpntJnSXMEEzGArsXUX/tAGeIGOlShKLKVjTi0
         synyI1Cpyl53g78wFjq+WtAK/HZX92ta3snO16aa0L3o34CmAbkxCt256avW0H98JRH8
         c7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707174; x=1791311974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=ltD6ULbEOvgO+xwIq7oR+EDiIwe3fSnkTSHZ9tuz1Nrjmi91jfk34h+kzbsjFlKQ1q
         umqLBAekGwoZF4WE7m+NKNoOta0e6m7QL6uE7H7rEkPaSzUxCY84vyLd3R2Mg48Nq4sM
         5oj7uOY7aPA1alDFK3FgCrVuIl3M/csvG98A+J7w0VtFDu7xRdGLsM5BeztueSgS8Liy
         nVCuJXDM+0MDzRIJiR67ReaQ85qqM8QhN8epl8UPc3PMvxaBR2En5k3hQINw7WCANeCq
         /vQFcdR03C5CHIeUtK2DnI40jrI4dJRfZUbcf1nXBNua74huwY3qTT/1PeuzUA2XgaNg
         ++Lw==
X-Gm-Message-State: AFq9FYIIciHAKjSTrKSZYlJbRykgmdh4RJeuC405pLJGcCE65ooq/g9B
	0IBYHL17o7fMZ/kr9tSPACB8o4dwRDssJEBClW/2q19el3/egUY6fRtMs4J0SWZSj4BJSdY3knn
	+K/OGiCg=
X-Gm-Gg: AYBFou3llevEFXcz4e5tanP1zwpooRrnn0nEJbMPaHUAkakMdzwh09l27YFuZHNufNC
	see3sJ9kYIP0k52OjyZaI5WWoH/Wwt8EjDvbXzR5PCBlvkPVJSanvSnvlmsP1KpqO59IBBxIAZF
	iol63yJrlQSFmLyMZow92O3l1hF0MTnLcQdM1IrLjm2WHt8nWFP4bk0xegV0jjq8iqdNyKdCOkt
	s53XgAgNID5S4rBxKPyk4Cbyyrxyl283SAIQlsJDuVW5AxhkSXUGsZWSgrT5CF0sL3wVbzBT92L
	moU9uxQCUsMX/JQqB28hIKRe/wlgd4uOFeN088DfAH4NIiR4t0qmUBkW9yvUY+XcEPy6NZJWrLZ
	9h/fbLL6SxQc4xoGZK4QxutSVHLCL9VwhvdHxso1BFUDDhT4dN23lPRU8IuKxfbTCpGSEY4ANC5
	sjnnuhDZUDLRjwgj8a4rGVsUJEr7ELdxfeDk7gdVFz2RCOKW6sVU2WCFX6QA9GtER/9loPSQ7U6
	WG9R4/LhPcH7NdmR/kjRadJYmTwiDTa/p2sVB1+5a6/u561lNLm
X-Received: by 2002:a17:90b:28cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-3a4c0045184mr201624a91.63.1790707173889;
        Tue, 29 Sep 2026 11:39:33 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Tue, 29 Sep 2026 18:39:25 +0000
Message-ID: <20260929183928.4896-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
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

