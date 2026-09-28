Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB97418361
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627214; cv=none; b=M45RpXgU8/MmXMWkklLe427CAl4FEuPDxvTbjfi4kbowkxkgUPjE6FbWnCUXFjrBuruyjtXqYf5JZ1IAQJ2sfjQPKnj3CT5S4z1n55ZRAvStOCWlxJEwZo7f6vUD4hbx8MRyRboZsfoBu7peZg/u64dbYY5mvT2WIBI19hkI/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627214; c=relaxed/simple;
	bh=GixYfOzuqpausrHNaUJvUWUHDWCiMLEBqEefKQ0PlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcxcQnNKZkNaTKcEusn2Ajy9v/6a4sT7Vdv/zY4BeW5l+FzH1HgfO5jd9X0g4qdqc/FPGyO4nqn+yIGlCSl8FuvNRVWQIJ5up9hoVjFDhlRVTty9jEpp5FeAFbGW/+WKCQj9VfaygADDS5g3vdINvTsdJxMnL3mCLAG4X6PfAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WUjiOs+J; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WUjiOs+J"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49896dd9dso75752a91.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627212; x=1791232012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=WUjiOs+JJnOaUIfYfzUTUWCbklbm2zFnYU4B+UXK+31rmYlmXYaqtvfSaD9SQhlDOZ
         S1Nuk1g9UPb4V7LB6dODXtJl3iqEi+zUAwoNbJZzYvMOWLGZ2XoHtB6cTuhg+GaP2wkD
         gSCgKkzd+zO9B1HG0vO1QgRDLE8187lTZ6i5iFuB1LGdaAQaPdJNKaJGu3L49VVAlTKK
         YRkteQsBhGJcqKb5faRpnrPXWwAuG8tfefNATmG6+4CRmvou4dA+6MkswLjR84OFIAfC
         5C8F1BRay/pw+fFWjEKdkfp57SnlKEv/ezL1TWdKN9AMRryWoixoL63RBv/M/6pPAAqB
         EvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627212; x=1791232012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=Ezvi29C+0OWVTt6sOC4FjHfVOWS1HYCmbEk5KDOjzfTnWaTU8EL3ZBgC/vXHwuYkfd
         iN+yEE20EBLZwYJ3KoXFPTCBZ1w0IlXhqKwdXiex6cHMh2WXKW0yhVXr3mp53pMvcH3I
         kSg5mGtjj4gCJXAIHO1HdB2ccCRjXvl5twpM3s+TN7mwFAyC5CFxXuy3mieVZnlEPK52
         41/ZZZB010j4v3qTRwJ0/wXGFqpcs25Sc2j+QILMVpi8H/bo5n90g8w1/qdVNPUtxUkO
         j6NCkqILb0X/+9AVXOY/0CZ+6YYHcpqYfaK91lBJXNmK9R+8RFTCNwHpg7u6ieQ5ZYEI
         kzqA==
X-Gm-Message-State: AFq9FYL+VPI6uXlBMgU54C+eGyTM6YQ0d6ARTvGK/Pr/2d4DmPWtIWGS
	DsCErnGKJVxBihelQzRy/NGXHkuXBfDg8D5DUkkuEtyQhei7S46B2LB96D8CkvK4VOVRIqf6M0e
	CEHlBSF4=
X-Gm-Gg: AYBFou1XjuvaBbveS8UR9LLn9LOc/yemvP5Dv4n3luPo+gDkpsfHpfFuPZLHD30tGRL
	AiMNuagxnvDH7Ft8JwzaKUGxNPNwAuT7szs4FFITw7LarXafDH8zIm+amee8DZ43fBGftpNbkAi
	G+pwgehafW6Qzh/BhEvbOclArW1RHYg3UIQb1P6T72glwKeLvelRAC531gzVBcSLHbTOtzV0nqV
	izXh+5zwkzA4k/2KipTtjHYkKw46hFlSmSWXkMcLickPvwXc6IMPmCKxj5UFuVQexxp8iih6pNG
	81JGup+5DvDtiK6hVK2wsOnoBqBGRdiwYCoEMJkh+mD8n6m2dDaUVggPf5rU2jjjSy9tmx+/B63
	GuLhY/gRhBCJUi2WPp2b/SjGFXOV6twv37qwHCCOavs6EjcwEIxNceyugkzd8+MXhM1D56uzCuw
	E/9odL8Pz1wQmanmNTXsq5dsfW7VjBT29BnJ+x6O9nRfU4HY/xxlciOGOLyFv984W3z5DEuo/KC
	ioYrRrlE4r1Ke/WwI0SRHlabTHsTPhuPyQb1izgug==
X-Received: by 2002:a17:90b:2749:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a49c1e5d9cmr144826a91.38.1790627212170;
        Mon, 28 Sep 2026 13:26:52 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:51 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Mon, 28 Sep 2026 20:26:40 +0000
Message-ID: <20260928202643.9114-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928202643.9114-1-emil@etsalapatis.com>
References: <20260928202643.9114-1-emil@etsalapatis.com>
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

