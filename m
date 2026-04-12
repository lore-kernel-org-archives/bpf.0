Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BE2F12CF
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015954; cv=none; b=CKzMy40kfr5lOBm00orIik2keVs5S35uOOpibxRvucVfse9ZVCMMDjk5flwd/thhpNKjKGC9CR76aEO7n1IDsV7UmJ9ONm9SA3HZVxh8sx+IL9EDIupgbJRyxXqzVR0Qffs9W0yGfqjjdT899wWhN/prpiZYZOCVOWsay5fT/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015954; c=relaxed/simple;
	bh=EfkBROJfJKaZ0we4zotmtZKjEv9FZo5LgHiSTtQC6bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/x6W+yYz+a8ChTnbe0TXImTQ6xqajKQn3JZTaan/uyiNJ21+12f8yCB+Mz6xiUIJRD1OxrDHCLuLLHsEzuAW48YKaWuoKDoh1n2AUul4/G8TX5MzeDY2fLTmw17FMqAPAqgK/mKus9fDyqz/z8mVC5oMEoqJnHdpSYpVpQpVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uvY8fayM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uvY8fayM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8296d553142so1792246b3a.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015953; x=1776620753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1AXgGpWDyHQEMSIyNXM3Xi1vkMCzQJirTKzNTvoB1g=;
        b=uvY8fayMGJjNwVrafVI+N8IRoa7P9uZdUkcxFslRAjC5mPoOUmU9Ud9PPlr84+TTgR
         14oIqjW8cqvbx4xjdKj6Hw9rBW8FLa23kX1ZqUQXc0WakkRc5YjYoLzo6UUsBeQFOeGf
         JHCRNdajRxt1ekDDPPh2VZI6S5uRnPuNic8FUMlDKeujYg3uQURATaAKGQtpdSvpNf+o
         ItaFUk08mdpGfuI8zyFNVWMmNSK2eDYMb4TOAi/SqIfIJ3Th64oX3SskVYzuFH0YgY+D
         LSy3eXFz0HnejzGzE57iemypvz8jwZI/GfilHH2G2U+uNGZW6FAWMEx/T282KCXK6C4H
         J1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015953; x=1776620753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1AXgGpWDyHQEMSIyNXM3Xi1vkMCzQJirTKzNTvoB1g=;
        b=TWt9r/9ZNE3b6Vqr9ZF1wIizSA4at+zw9miVM8bQSyRiZrt5/I30Ab7ZejQYlOi7Yp
         LmAu6Q4mK5V8NORGrN83F/FEstsQ3RtjYOlLkthxwn+vee2SdsVff0VyFBl6sHLbcZa7
         z9cBmwmydcw/iQGtQ7E4AVp+prBhCQTb2PQ30JqpMosNqLsrTLg3vwExpQyz+kTEeUEB
         yPQGDwuBLiKCJI7Wvef4z4aoyIUx8S++uR+i2xI02VNz0KAJ8yemkZuCzwkifFs1ehXh
         w4VgOC45dwAUI/61WddHH+V+22Xsw413uqBl/UTbExIT8UvJ33nqKvyBvX67MjJh/6fW
         sfsg==
X-Gm-Message-State: AOJu0YwjnlHGVxhH2ouGyYNvvs7CyvpJNqRdiTqfCUro07xr3W5RBmYA
	VstqI6+b8QVKtEYexAQMr5nkpjIMEZ58hJLDf8IU1JXZBpw0X4LTg2Mwuml6L7X06K2oyiqIgF7
	WlQc5iS4=
X-Gm-Gg: AeBDiesVk/58NtWxFCRxyZMfvpRjfjGtlkEaOxhCe57OznAtwalR+gYVT3d4xGQD6QB
	DDKWf0H+cDvKFqWdF18WOE1e8DQ4fZWsg83Hgojy9I9HSYiR0MDCS5a/PS/zB+UljH8bQVoix7b
	Dr/UQhhOnfqVlkb4xe8UtuTXkDKKovkoDVnhGi7/q2l1PBUP80SsR76rXaCdvqI6bZp27Fy5A2M
	SxtHq8FbGiI2FuZKn8iT3Iu3KWm57s9J8lvL2tducC3/Oavgyq2tZhym3bwmZBSziOvLeMOuJtP
	H43Nx5Po3yOtspb9QTDvBz19xLH3NHabK+UgoN9iTkrNtlfZS7PLKleM13Rta98YLacZ7bKJNU5
	6/beTaD8VEQd+hQfi5XDK3jwcSt4M/hB7vvZMtCguCPok5yaY/vTez8b3tpkntz/EsTbaq5qV90
	Z6iw==
X-Received: by 2002:a05:6a00:8e01:b0:82f:3c63:4a0c with SMTP id d2e1a72fcca58-82f3c639d9cmr1254294b3a.51.1776015952712;
        Sun, 12 Apr 2026 10:45:52 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:52 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 2/9] selftests/bpf: Add tests for non-arena/arena operations
Date: Sun, 12 Apr 2026 13:45:39 -0400
Message-ID: <20260412174546.18684-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that ensures instructions with arena source and
non-arena destination registers are accepted by the verifier.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index c4b8daac4388..62e282f4448a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -477,4 +477,134 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+/*
+ * Test that scalar += PTR_TO_ARENA correctly upgrades the
+ * destination register to a PTR_TO_ARENA.
+ */
+SEC("syscall")
+__success __retval(0)
+int scalar_add_arena_ptr(void *ctx)
+{
+	int __arena *scalar, *arena_ptr;
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[scalar] = 12;"
+		"%[scalar] += %[arena_ptr];"
+		: [scalar] "=r"(scalar),
+		  [arena_ptr] "=&r"(arena_ptr)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Tests that PTR_TO_ARENA + PTR_TO_ARENA is allowed.
+ */
+SEC("syscall")
+__success __retval(0)
+int arena_ptr_add_arena_ptr(void *ctx)
+{
+	int __arena *arena_ptr2, *arena_ptr1;
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr1] = 8192;"
+		"%[arena_ptr1] = addr_space_cast(%[arena_ptr1], 0x0, 0x1);"
+		"%[arena_ptr2] = 4096;"
+		"%[arena_ptr2] = addr_space_cast(%[arena_ptr2], 0x0, 0x1);"
+		"%[arena_ptr2] += %[arena_ptr1];"
+		: [arena_ptr2] "=r"(arena_ptr2),
+		  [arena_ptr1] "=&r"(arena_ptr1)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int scalar_xor_arena_ptr(void *ctx)
+{
+	int __arena *scalar, *arena_ptr;
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[scalar] = 12;"
+		"%[scalar] ^= %[arena_ptr];"
+		: [scalar] "=r"(scalar),
+		  [arena_ptr] "=&r"(arena_ptr)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Tests that PTR_TO_ARENA and non-arena pointers can be added.
+ */
+SEC("syscall")
+__success __retval(0)
+int arena_ptr_add_to_non_arena_ptr(void *ctx)
+{
+	register int __arena *arena_ptr asm("r3");
+	register void *dst asm("r4");
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[dst] = %[ctx];"
+		"%[dst] += %[arena_ptr];"
+		: [arena_ptr] "=&r"(arena_ptr),
+		  [dst] "=&r"(dst)
+		: [ctx] "r"(ctx), "r"(base)
+		:
+	);
+
+	(void)ctx;
+
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int non_arena_ptr_add_to_arena_ptr(void *ctx)
+{
+	register int __arena *arena_ptr asm("r3");
+	register void *src asm("r4");
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[src] = %[ctx];"
+		"%[arena_ptr] += %[src];"
+		: [arena_ptr] "=&r"(arena_ptr),
+		  [src] "=&r"(src)
+		: [ctx] "r"(ctx), "r"(base)
+		:
+	);
+
+	(void)ctx;
+
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

