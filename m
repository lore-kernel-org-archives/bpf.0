Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5D233722
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235563; cv=none; b=tyKXEC1zZDXOpq3VeuOdQnnJVVnJAOtIg1KUXUbd3HiKBPiIa8+PV+v7+KNhgHydLQUUa+yTzEUsKtyvGiVYQ7ShZNYhjZUUV+i5mc9yE6EkcMgFZj2hA8R7E4F7pYDuvhr57mOQMiFdr74CNSNXvc1omUO2fjRdr0zH0iEZK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235563; c=relaxed/simple;
	bh=zUJOmTvUfrfnyR4xJIXA8bz3JqbLEgsuYvxscT6jdvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRw9Ujf0Fb9t0zXyYp/HqdT+2azflqUOapGPh4AUHajP6VfV4yLLJu5kEAv2LopBg4CbELqZ9pomZZmnncHA3ZPi/nqtUvDaXTJzzpLfxD6eBgZTI5gJesNZLmsOeWdqekHg1mGyyv1C1Lp/nPf7Hvr2kcR9M3aG/zV7r3jDDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM1fSipm; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM1fSipm"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so10914105ad.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780235560; x=1780840360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5m0c+tBqsdkoPGavcwU4mvnSNAG+RuBjE1F5U5kFX8=;
        b=MM1fSipmfSYsHXCe4ltitD8Qe579TAFrMtfTmrrsRWngakfaISBh9X7eSSK37WNtHA
         0mCaoegj/mUvwWYWs6y6/XH+q8myvO6oNyIKMuJbci2NwaUZMMwLnNFsUJvaDe8zKNNY
         nQCOuGUkulzytQTrU42HcNaRaM6L4b1WmqfGZalWnJp545mhbbBte48OcbjxdLr0xJL+
         FKZAAzh+A8zFDHXNrCSGp6YQz6iR0ADiuHwfslAXrxHrorH6vUlgfVvFecbyZXronuKz
         +YA3yRM6vHHJ+HgwmiVPBTtmAANx7taDUw6X5fP31HImFDd0Jnhbq6U+y3G2efufDUUZ
         iJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780235560; x=1780840360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5m0c+tBqsdkoPGavcwU4mvnSNAG+RuBjE1F5U5kFX8=;
        b=B92qmnoFwtHjm6M/KdfUTY9uYvHKaAco0VK16XHsXSaTMGw6nxqI6PCLM3jm4H6zrc
         k9QOT5iLWAtgPcl5XAq64/hMvxegs3Swdlg58b3uLHTKDrV0+Qg1oOsWLRQHmXnD4dXP
         LjdAfcd59rtJRfzyT98oC/nXVbcn8ouqujf24Vb2s4QoHbzr/A/UZuRuX6C951qRRS9Q
         2M7iuufZLdSpztmioQi+lLbFR1X3EZfbsw1A/f+4g4OiuFfulnHjlEPMiDotPdUUy8pL
         f6p32JhHBj0/6GwfTX3lqSkATOoau23DWkcOspndfTBlMceoS27RPHmEcYWTgeQqyZa/
         DrHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+yiwke+g6Xq96aGn/Mex8hMLPN6Y+5Nba8nQHVHOHlOntyPZUXOhx1Bo3+RtQRGPuOpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65/Pe89asEXiuw2p1wakHPiA9JSHelG7E/wnDo2ycIo97NzT8
	hvYMOi8253or1P61h0Xu7EvbEBLGcStGWfZszi3AlpGH5N+e1ZZxZJIj
X-Gm-Gg: Acq92OFldxpSGXcXreiJvc505Y6pl4KCBRgiQgjVK8SaMBdaS9ELRm36zExf7fD6sZY
	8R1kkr2Ubexp4vGizQwnXrAkzTm2Y+XrmcCqcvZ9mXsypy4Ps5jLm2JEFl/mcKsjBaQmUEJIsxZ
	7EyiL7tqth0IB/+V7frLfWQzJLIsEccJ+B+1KKBNwoZHINLPl5WWkZlsPlcGL8+aTNn3cljmC9g
	8nepqQ4lW+sB4oCeUHOrJDFOGuvJMHIbEePJq1U6cxkLY7TZM7cm7vkUlPxXVpQR/9Cn2o+Kt1s
	+Cw8qtCva+kgIFt3R+jUF+z9vBMZP3DVHwNSQ8t0k6Gj3wPgmqvzlFbIfepr4p3CGcpgJ+17rhK
	FeX1OeXYCt47iDG+Za2XDa6OtwTOkhYfFDrlWmMhaES+0SNhjeKjUZORF7OD3EGqGkcXkZ82b+l
	23wvN/VmH/MNT+lsYzdyqQ5tGw7M0=
X-Received: by 2002:a17:902:f786:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c0b5c1934amr43378855ad.16.1780235560490;
        Sun, 31 May 2026 06:52:40 -0700 (PDT)
Received: from laptop ([1.247.84.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c857729930esm7136137a12.16.2026.05.31.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:52:40 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	linux-kselftest@vger.kernel.org,
	Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Add arena invalid node id test
Date: Sun, 31 May 2026 22:52:34 +0900
Message-ID: <20260531135234.233421-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2845989f2eba ("bpf: Validate node_id in arena_alloc_pages()")
added validation for invalid or offline NUMA node ids in
arena_alloc_pages(), but there is no selftest covering invalid node id
allocation failure.

Add a verifier_arena test that calls bpf_arena_alloc_pages() with an
invalid node id and checks that allocation fails.

Tested with:
  ./test_progs -t verifier_arena/alloc_pages_invalid_node

Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_arena.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 62e282f4448a..91aa0941ded2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -11,6 +11,7 @@
 #include "bpf_arena_common.h"
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+#define INVALID_NODE_ID 0x7fffffff
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
@@ -199,6 +200,20 @@ int basic_alloc3(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int alloc_pages_invalid_node(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	void __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, INVALID_NODE_ID, 0);
+	if (page)
+		return 1;
+#endif
+	return 0;
+}
+
 SEC("socket")
 __success __retval(0)
 int basic_reserve1_nosleep(void *ctx)
-- 
2.54.0

