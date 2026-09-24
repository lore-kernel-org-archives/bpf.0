Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE89391E72
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228192; cv=none; b=iTiYJUzcuLGianZgbQGhAJvnMo2TylGlGblH1a6sqp0m5gS4NSeHPZfPti1QVCwqgtClWO+aG1Z7AajgfHzml/aFrakMmi8Nz5p++kuA4tPSFgI6f4ruH8/TFGarnM7hv4gqu8RqK2EVx7JlbMVq63NrzUnQSmJ/RtkyNWet7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228192; c=relaxed/simple;
	bh=OBehAG8ViorwurEGTUZlC1OFWLTtxa8kXPB9t6rmwPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoMWagMz7V+X2clmuuEqseQfA10YOiIdeVj9h179LCA+lBkMQK/h6QbROdFu4H1HAW5G0iDITOg3pu6p2NKS9PL+I/3sdMx8LHL85DpyCGxL1qCzFIYikKpp7pgcBe52lw5hGd0j40Mnlf3du9PgkB6lBvO9mbbp9tYA4urCNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gEiUKxoP; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gEiUKxoP"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so8428615ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790228189; x=1790832989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pX03XvnewfW3DnLcCUXEe8U68bRxT+9YVFuO679h77c=;
        b=gEiUKxoPpYot2OD2nWDZtpsGvj1X9u0guFPh0P7z7Q/4vS/J2mBKqgnOi1Xb0xKz6i
         MDazIt92v4BA/NtqsmEwOikBQI+2CkxgnaxOXtoY3QzunE4qhiGH4dO18VvVvM1a24dC
         8iaS+E7ekhRh9TVH6JgEUTQsA/tLCiFXwAzgiGEaM1/9rqC6Fl6XzWhTi7aIEzKwT6J6
         qpxKDXyiJRtdCjfMgQkrnsCvlozP7SomyrNf3WsX2WvkstDbiIbpJX7VWPAQch/Hcyim
         H39/I4N9dxUs6AsCDj8Id0iErovozfXVo0/lfyRv2v9rgI9GexM4YSIiF2Km07bFrFFc
         9Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228189; x=1790832989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pX03XvnewfW3DnLcCUXEe8U68bRxT+9YVFuO679h77c=;
        b=LtkM6XNcrZTaBT4yzxGQN2sGUa2RGVzLMOPMaHPzzgBZNDx5sK3LaaRjBSdVOVIGQn
         bvWii9aB38SIqwFdIILmcs2PyL3iLIN3vHnRFEofjsww/XcFUc8vmonbdo2n1q8/K4/d
         1kAS8AhHllOqaSprgpNdnBar4FSA2WgSt1rTux9H3WylGP2Sac+WmdigSZIvkRc6PbRt
         /TrzMEd4vCMZBIQO1W5Jg3Gh/RP+VgLp1PPtVJE5vWXQNTK1E2lHf5JOx/f+485hg7kQ
         NfS8qaOcisSa7oW+y++QNM8lOL68+rllne8Nib/ex/TlZF3GrdIuH4phOUMuYczz/P1Y
         8eUQ==
X-Gm-Message-State: AFuF++nlhcQi4tBVkxayXpn/Fpot3Jh3QVCFrgdHOfZ+ATp1pGNyZbaf
	puLTQMwM+V91Hj547gY58gQg22VA9I9Ryc2mosTuPk6Eq6V06EOyzidgAC7FVtFjxGkdnSAVNpz
	9sYwak30gpw==
X-Gm-Gg: AYBFou3aBkfTxzZqReUN0HQi7TGn6l7HrdzQQchnM/VqhVTbqx7+WV7JmpCSwB1kb0S
	1Nao/shJaqjaJx/9GUXoU5rJhArClFcXUCtgXacUvXLo+xvB3X/a01mNvRnjrr4LuJcWzERZAZc
	STPxAL42XAPltZtjLNInT/T4/sHgVAPOdUj3QXgM6jc+M/wYigdUFT1CyfLY5L1IHtykaCm7E2u
	jixu9V+0Igv5+EKK72CcN4PzzMFeku/X2xd+hXZVnAD840eKu31EcyZcbDNwmzszg7i0Y6gc2UF
	/boXIF0HaWJUL+SiXC+vaRf9/GkEJPO4y4mmhi8y3wIm8z10F6MJb356DfMD7qYDGQidjdaJv4r
	x71tZZof8vlWFLXOW+60MZGcIpz4nFQEhVmm6hTuCU31AnHBvMaLBOsErAbT2PpRBBaOOWiU2sG
	8s9ag16owJLCyaN36q8xYPxOMie5g27tFr/gbsAbjhdibfeI+X3cNrOjJWtcmOiDzVHCwUgWoKh
	AfbmSRTy9Td4R1w9OYv8Hy7jwwMsc3IZls45cHBzQ==
X-Received: by 2002:a17:903:2443:b0:2df:5b4c:b0d2 with SMTP id d9443c01a7336-2df7dc366aemr11519845ad.43.1790228189457;
        Wed, 23 Sep 2026 22:36:29 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a4997sm20511265ad.27.2026.09.23.22.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:36:28 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Thu, 24 Sep 2026 05:36:21 +0000
Message-ID: <20260924053621.7076-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924053621.7076-1-emil@etsalapatis.com>
References: <20260924053621.7076-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now use different code paths in the internal allocator when
allocating arena memory, depending on whether the caller is sleepable
or not. These paths mostly differ functionally for large allocations,
so add extra testing for that case.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/progs/verifier_arena_large.c          | 59 +++++++++++++++----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6ab8730d4878..e002815b6929 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -11,6 +11,8 @@
 
 #define ARENA_SIZE (1ull << 32)
 
+volatile int zero = 0;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
@@ -284,6 +286,7 @@ int big_alloc2(void *ctx)
 	return 0;
 }
 
+/* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
 int big_alloc3(void *ctx)
@@ -291,24 +294,60 @@ int big_alloc3(void *ctx)
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
+	int err = 0;
 
 	/*
-	 * Allocate 2051 pages in one go to check how kmalloc_nolock() handles large requests.
-	 * Since kmalloc_nolock() can allocate up to 1024 struct page * at a time, this call should
-	 * result in three batches: two batches of 1024 pages each, followed by a final batch of 3
-	 * pages.
+	 * Allocate 1025 pages in one go to check how kmalloc_nolock() handles large requests.
+	 * Since kmalloc_nolock() can allocate up to 1024 struct page * at a time, this is the
+	 * smallest request that exercises multiple batches, limiting the time spent with IRQs
+	 * disabled.
 	 */
+	pages = bpf_arena_alloc_pages(&arena, NULL, 1025, NUMA_NO_NODE, 0);
+	if (!pages)
+		return 1;
+
+	for (i = zero; i < 1025 && can_loop; i++)
+		pages[i * PAGE_SIZE] = 123;
+
+	for (i = zero; i < 1025 && can_loop; i++) {
+		if (pages[i * PAGE_SIZE] == 123)
+			continue;
+		err = 2;
+		break;
+	}
+
+	bpf_arena_free_pages(&arena, pages, 1025);
+	return err;
+#endif
+	return 0;
+}
+
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
 	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
 	if (!pages)
-		return 0;
+		return 1;
 
-	bpf_for(i, 0, 2051)
-			pages[i * PAGE_SIZE] = 123;
-	bpf_for(i, 0, 2051)
-			if (pages[i * PAGE_SIZE] != 123)
-				return i;
+	for (i = zero; i < 2051 && can_loop; i++)
+		pages[i * PAGE_SIZE] = 123;
+
+	for (i = zero; i < 2051 && can_loop; i++) {
+		if (pages[i * PAGE_SIZE] == 123)
+			continue;
+		err = 2;
+		break;
+	}
 
 	bpf_arena_free_pages(&arena, pages, 2051);
+	return err;
 #endif
 	return 0;
 }
-- 
2.52.0

