Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320250C2A3
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379347; cv=none; b=ZDrjdOXsI6w6aSB+eCKWtbIuRoEcEz+72iAcWcaAMcRBbqdvdmHDekAo2Aq/xCPHw4bzXeBbU8Mhe6VLR63ifJiDdp74WoTwd7+Kj3Zdfj1LiDuCOaBKrf6zlxnDvvZCNXAhDg00IsQKfhaNJCoWcoGmu/oNzeyC2MAtTVK8Mm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379347; c=relaxed/simple;
	bh=GixYfOzuqpausrHNaUJvUWUHDWCiMLEBqEefKQ0PlCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgRy2j0CkGwtUh29w4iod71Gf8jkwVXHs7gIM+S+75gsJmMUOSO+vQaR+4BwmqFExsKRmTe5z4kiSMBSC39HmsC0L38BhylfPT1dqgoaTiMStweELomQDepP1eX7Q6UUcMnBdR5cI5BMB8mYX8JazFxsZVXjWJSy75+t8WENoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=LYyMbdtT; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="LYyMbdtT"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so945798a91.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379345; x=1790984145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=LYyMbdtTUSRvx83Ihs0Tn7Z+5ssVUF1TEKYKfMJ4VhssPfXxYfmZtsN7YSlDrElmZm
         2U5VCF3hiT1JLOP7miiMt0sn8cXufZRCjBZTlqJuiD/gF3XxdiqfKxYGP1FPqb+2f4Zr
         gPUjFz957JWw8yN7v2ZCKDIZE64ioFD/LdC7pUmVGepZB1HQzXnBYNPA951m+xtg3PPl
         LugeAfRAChMf+zj6Hg8b8R9Vp9wz84oo03wWQu4S1eEK5IFdc4cTyCNNMW9LQHrsFZpp
         22owBBi0uF7d/NiI6dVbef8nq4H3wRc15y3MoH1uDj3PaRt69FBlF4nJlQBuYRw7sGRn
         Qpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379345; x=1790984145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwiZU4ip9xIcLboxZnn93K2fdrOAx0bl5xsQ0MMF+UA=;
        b=y1UDI5gfObnCZZWov5xNrGq60fOejfYbV3vqgURLWhj9nxKPJmygp6VCgKej7YRBii
         O8po3ncWVI+L85yM70xfPifXC1szNheI+pCbubilvWTbMVrwUIiNcstPD9jIzLAyVLBJ
         ofC9eySG+0yXgujBQEe4igM/RjEAklqP4TpPpo0p/aKB01BLJeqkSR+uIHvKKLs8BWRR
         iwnWFAKwQ7P6Hh9U8vXSAhNWOZUlYf9JrdUENYh7b7hhIMK3El6omcCyWC/xxH/UWLFI
         eSIn5Vu+aSe5BF8HFGdjx5QDg2JilFGONuZSrnUF+YIkkPOKWrBsdjP2a7Bx2Qjbyz0s
         uKoQ==
X-Gm-Message-State: AFuF++loOPuNEkYKZ1nhEU+NtGIxI3CMSepQmEXGgcLFc78IodUc9/Rl
	mwbFtFVhWtdu5JrwqHJjQZsg8tbae4nay/sPtGqr0yZZ2RcIeVZ+A4Zj5YR05rhUsf7p9ymOQ/x
	01s+hpnU=
X-Gm-Gg: AYBFou1oBFOrsmXC60EkD4ZzTYzneJw//xO07igYWlZCC5wKX3asngM/fqvgXJxE8eJ
	q0Y7//cGgbDCyw7xjFXZSYfoWoWeQb8u7uC4esAVMl6FwiEsAaRaXLhB30329PyY/FTz1AA/04V
	r6UKaivlj/iYlXgYYFPhKQyrRJaMI7AB1g2ctnHsHkN14BL3hLTmJKM5L945FMztk81zSE6oPMO
	834Z5rXSAjs8m3IR6/n3TtOYF819gnwT5pdVC80AHY8J0MqZnMJKASSettoy9LvcPCQqMFsUa30
	3wnkA9m/BIIzaOhvL0CaTSZGLvqghUSD/gFuiKtft8zwEbVusuAqyJdjAwI9yqI0uyhRYVW9ovn
	7sTudhaIxBcf+JbWsEUifox526bngciPru+YgThmMvr9OJ3EyXx5PuGwxxpxpEHKppDjf7klBg2
	v+UbMNhHv/aD0LTcEBtBUAUGCOfl51Y8w0VE/+Wj57KZBX72znajVCQk/H/5wCiTQo5uCrmOGkN
	qVjYBnUzFT36x2S+hGk3sU2trUVVUY6F5hgF8eT6Q==
X-Received: by 2002:a17:90b:3b87:b0:39e:4c7f:7305 with SMTP id 98e67ed59e1d1-3a098b53e2amr5715496a91.28.1790379345331;
        Fri, 25 Sep 2026 16:35:45 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Fri, 25 Sep 2026 23:35:35 +0000
Message-ID: <20260925233538.5708-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
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

