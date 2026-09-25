Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA74F0544
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368789; cv=none; b=G+qWvbqtQcyMLFwHJKDxd3oSdm08PQUcK8aEDNBeacvLEtZTdkE77fqM5PGqup6FQ/i0yjiPtUs5bFNI4Hxfcc3e8px0ZjT/VIXQWAWFmHtwBnBFyl4M1YVYqtKOw1vZb9vVqx/rzd5iCd7Lz85XXXSRm8FBs7riXogQOcF/sSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368789; c=relaxed/simple;
	bh=GixYfOzuqpausrHNaUJvUWUHDWCiMLEBqEefKQ0PlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hujD3H9zLturoqBa24/IIUkRuAaMEcNlDKBNON0QabzlW9ptfTC8gbhNACCTeGLUPdJK104K8Sq4RDL0ZKqNZXePBL/g2a337bI0yJBhpMmnDGCF7KDeaSgkwybmdzidu0pt2s1wR63EzMrUTsX3U6W3D1su+mZ6eTJRPLPh7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ytPn/ocQ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ytPn/ocQ"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2df8de41d6eso8454175ad.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368787; x=1790973587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=ytPn/ocQqy774frD39nbDrF1eibW/4uvhp7SxmWBwCpwr8DmwkEQdm3nVHR0ed66D9
         ZtOAueRCeZVB75Ja2bpMRymBPIlxB7GfhxeAIYhwZhHCrifc/FEzElZF1dKTHxBf4ypw
         rrKK678sWIyGtIoeI0fakgeG1isS4YFZvzI44iGuOqfh/8a7vDwoBHUWEXjH5URPJPX/
         wYWa5QZZA/ubk+xqYNTOfQSpKFl+tuqGAaOS+TON2M5tIZ/LdGwwiOCayf9bcheHITDI
         dqZdMPOfBiejfNd+KfXdpJJEs2mbr/ErVOmM9+S3HAtA4trv05Zq+clyhUGMPDbxsy8l
         ycQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368787; x=1790973587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=ZxM/CDq2MePFHhLyirOxAReDLHyTSPnQOizmdso8VW+77JY86tNQFUADu/nU9cp5hc
         /odBsXHxVBHaXBpWawFLunAudotvbLN6TAL9lnNB6KJ4dRXTGRiEc4XM5IArSana1+mO
         yvEpuN+dIzxetG/mbuaIW9uVfJE6KdUvzOkf777vKAvFEADG5mvTBQ3ucH2cSFyOVTot
         4nTcZnRDn67q7arRk8KcDzNWASzcSV3T0x2H8aGmTjo82qHRQf+W6YcbGaeTyd3h6/6X
         PUPRWVuhniGb36j2/eYGsNjpJISnCQzh75vN17TLqxaRn+FJ6oKN8HUP30ShOm4YOaHO
         DUPA==
X-Gm-Message-State: AFuF++nPvRdEEXch88mSHvU6YrBpDImiQ4utbbHNWJzjzMxfqREQbi0/
	DAP65S8PcqJ5GwAHjTcmbHpotdAabo3Wsuew75I0Gs00WPgwulYPs3uq+MyP+chfjvIdvmXT+0G
	1Zuy/
X-Gm-Gg: AYBFou15HWtCS/L5nz3HOIHGvco4/XXs3WOhnsBfpgjCVmFdKtQbgiYkRfMEw8udu9h
	OFSGdLm5mTdtRcNW3qQ39Xl8oK655f+KtC+7apWgkhz9/v/fNG/r6hl8Mb0+nrwUPz41ARaX1Bz
	JcQWE00e08qO8bMsTmrRIuWDuvV++28AspoflNIDgrkkGNWteiBFiRDa24Ed/cEleaDIXzulylo
	Q3ImjXVkR57YOJyEc/MN34YbtgmOimmXjBFjNzhbJIVFi1nQIjPnp7gySPOXY1J6RRwv26ds33m
	IisoKM8LaAg2DZMFwoYe8me4quaDfTp0UA2X9lVuPZ/otVgKU6hD9qrrgOwJEZ8eHnDv5LTe+ln
	b9+LDVaUEK5WTltkgpnOGhmaItBmUqCSJG0y4GVmmyf6GXibpYG3DZoLn7F/SgG7htODNBxLeg+
	VW7T1pHxRpUTj6gkuEBhoh3WqlkK9/sNWDsQXOaCSUNikFjChevEQ945bywX0UmT7H5hgVjbnI6
	QOBuHlN+ZNK8YeC8+jySB8pXiwMVDWOQlMs3t802H+U35MFTjX8
X-Received: by 2002:a17:90b:3e4b:b0:3a0:cde8:1dd5 with SMTP id 98e67ed59e1d1-3a0cde82a9bmr1238673a91.21.1790368787452;
        Fri, 25 Sep 2026 13:39:47 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Fri, 25 Sep 2026 20:39:36 +0000
Message-ID: <20260925203939.4105-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
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

