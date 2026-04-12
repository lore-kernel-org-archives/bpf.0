Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB471E376C
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956744; cv=none; b=H2COm7/fffR3PgUX/YZsSJ/+TYlPnOId+BV5kcBK/i55PsioUaWuxj+xg8x0bkB6m6G9KaQaQCK7JTPwyj0cDzM2nt3+jM1jcM6SinP7eG7yFKYzC6vvHN1IYZppJ4NduOKksQAnXLJxi5KYPpccL0gkDKvmdxs+VM8vcCu0RIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956744; c=relaxed/simple;
	bh=6FQmlQCDaw5G/b7s9wJcOxLrOo2RvH/fvTmkPB1qLlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVh1pv8gRaQiisfaRE2NMQO1zoXw25052FySIOqIX5ZpK4cf0R//Kz+Jxnqz9jzUBa01Bz8157/WXwAo5l3FnIIJh7kJZzcp4QJ18tQYlP+d2z/wP1pRLVHtJtA/f6+3RqLMBdAD3diTKvF58k4rXWHDya9DCbwBZuXIum3s7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=A0jeyE24; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="A0jeyE24"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso60524a91.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956743; x=1776561543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY6kyTbszWVS4VGgGorOA/XgXWWD/B5lBcXctB5E5wQ=;
        b=A0jeyE24utCmi7GMYsRP+e3Gzz6KzeA/yAk2W49L6kS4p8ROeYw7ttpwhX8u0AfxOj
         Mcc7vxMX1tgczhHzVc1dd1QfuJ7hkt4h3G/ueqFHIM2e4jibIfQgjzJiVW0EiY8fw8dL
         du4C0+b3XvWEo1nQqztSAQrWkG7NmymdcLxPnWRzFNwmIUlLDt5lDv5dep0Dg6LRPI6D
         YU+itra84SscuIqNjCXjr1dSHZnBSops14+AJCmSKOnelICjNg7eoHHcjbw+C/nLKiHO
         R9xXhlPB9aSCYDRk8TmXef05SUU8GyvzleiBspbWtIiLy/jn2lsCqQszHEN3Yk6xZX1y
         T0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956743; x=1776561543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IY6kyTbszWVS4VGgGorOA/XgXWWD/B5lBcXctB5E5wQ=;
        b=PLFJKMUJK99tFUBj3usWcLcZmGBRA1Q3BAXpq65GPRArZ0ieu0fQYRdup3Nk5rXgVT
         l6Rvyw+o7FJocuLN5H8rKcDUf1yRZCnbAMNx/j566s89hDR1kef1G8ceO/2DvnpcNLpy
         wzzhUS52cviDckTbL5KV1JLVyCeMkT9IeBmUKZ9coJsrmctv7BhySjGjC/BuvS78rkq6
         WV1qDQSeElQyA/wckrl+NL8lCS+IgYn+vo87DZlugt4m0qORibcRU51Ab/5GNEd60Fn1
         RCIP37QDBGjTYo9sg3WR5RbhSeN70BTwlpi9v7RyqLtCIR/29EE6HZVzB2xXj31syHon
         csHQ==
X-Gm-Message-State: AOJu0YzVT14odyuMKbOdt4vBn7qLRtorLesYaYRKgbGEvmZv2+Bk22vJ
	POhsAGdUzso5lWpIqjZy1yussSHKd2A8ulh4DQpm6s/zYle+MQ1an83Ue8GyyqoHyoXqtxeEIYh
	R7Z0R/70=
X-Gm-Gg: AeBDies5h4wngUQArxrI5Ms+GpXaOH7LE9EDrHbkeUCX0+ZGkjIVVZqCtYFS2rzLO2e
	tnysAgJ7cHYir8HFleR/2WbnqkxjTBpvHMJeAvzBE2sOyyqCxWP6L3oP2dsrZU0fPZ//73R1V6z
	y4wnsseryeXYlXrWYK4vz+Z+YlG1T6kY2ajwo+R7K/gnTHx73Z1W0Z0MZbFiY2SgyBa4tadfrAP
	sko2+c7wZyyIgatFWk2tPGo0595cqVaGcAJ4H3kEe4uO4n/a3CcsVWxq6jsSeLVCb0XaxhWOQ/g
	5dgkh8sYWoKymNbKrhTW8ChIe7deXvcMy0cknf4HvDb4at2Uw5OuZpoWyJF98NxL1mZ/Um9csIz
	Z6OfYG0h268wpG+ycCjtkHkyOcznJ4jMExqLU6uNDiT3ShB0vLqlhZhViQgA9lWiTQ5Op0+mU9D
	bj5w==
X-Received: by 2002:a05:6a21:6d83:b0:398:a934:9be6 with SMTP id adf61e73a8af0-39fe3ffd282mr8766324637.43.1775956742679;
        Sat, 11 Apr 2026 18:19:02 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:02 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 2/9] selftests/bpf: Add test for scalar/arena pointer addition
Date: Sat, 11 Apr 2026 21:18:50 -0400
Message-ID: <20260412011857.3387-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412011857.3387-1-emil@etsalapatis.com>
References: <20260412011857.3387-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that ensures scalar += ptr_to_arena instructions
are accepted by the verifier.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index c4b8daac4388..614e61166f2d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -477,4 +477,131 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 
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
+ * Test that PTR_TO_ARENA + PTR_TO_ARENA is allowed.
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
+SEC("syscall")
+__failure __msg("R4 += R3: Invalid operation between bpf_reg_state types")
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
+__failure __msg("R3 += R4: Invalid operation between bpf_reg_state types")
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

