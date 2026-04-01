Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC5E56A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046516; cv=none; b=K/2zSr99XswlcnuNHGyDFdW1OS4ndNo3GrI+KeznxLMpCSvbvLfdNjMZg1yCIX3cAOh4lf5OSN/JVt+pwvxAHVG5DkK64SEWuzjIniFmU3NqlfZ0zQjeC3YbkLcNpRlrth/7Uglc/MVNMBEvP2IqEZpxpyUR3kXhUkqJn3yesog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046516; c=relaxed/simple;
	bh=J6IQJRQ8lNljav6H45hMIjKHljRqbp2JQtxovkFMb9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfM6NtshPkHLNWyghHWX8hDTriwYPkA9wlU1Rie/ihowsBocVeHzGG0x5tEstTY6sZgrL7M0VRTsbsma/jBqlQHNroosmG6PwM1CXd7a19ZFN/HHlRodUsOpk541dyw4shViAcSqfm5tyamKJM/mO+X5GcVennOIDwqAYuzKjh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl7FDd5N; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl7FDd5N"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-4671cbce32bso1520917b6e.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046513; x=1775651313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMAd1CwS2RvHLqq+3xmJ+AfPZycKGrNluwZGMXSbIeI=;
        b=Yl7FDd5NdNoDtV+zJ0JB7s5Y8sr+Cfx/WunAn0WugLR5UapUP6ckEXz/CW2ODZXxTv
         KtisHLbnRqQK3UaJc4McvPjWGZ8IMw0Xj+rnmBdAnXvrr7eglr2PgyCAb79woGgNyTjj
         3fqQRwE0Hp2vui46s+hvVWEDGfF+DsIn5ZSUEeYWFk0ztHsVQlfzbZyXXYPImWtaJXjX
         ufssbF77vwz9caQR2AjqZfhloQDjRU+tzPNJV+XoUmOwAM3BxbE9HL+CR5Ff7hDo0Jvx
         m0yEthVt/1X56RBJ84b0MlVmRN8hlCgVfAhPLuSlbB2/kcIpwOVtHXTG1I70DJKTcFNJ
         B2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046513; x=1775651313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMAd1CwS2RvHLqq+3xmJ+AfPZycKGrNluwZGMXSbIeI=;
        b=ZgrVPpO/cdz4T5iDE78KnAOsBRjIBXG0mZ0+Rq2vfzinzoqvyNzSYPG+ni0SPyHUit
         fVBjCVOMSR9GzR3q1NLZovJTP++aUElNhFxJPGmYKTjg/dcwq8aIJ/lnEBiFQEeD8J3Y
         GUJ+I6PXtkhq86PUtZkfVaWSq9Do5YIR5AeOlYKnox6OtsMlsvpXZRkIX8YJ3ayADtU6
         /gzlutP2hQfyWKyzxGCVU7zJ1zW7AAL+u757lE9UdZzJ4tZGwdkhKQPVAHvog1xQf2t/
         1gQzXXloxHpBRiQjzzY3tqHBOXPXgj8vqAU8yMGuGu1XuL7XTTXbHJfirtEu+zeH/bZz
         Wn6w==
X-Gm-Message-State: AOJu0Yxg9Jz6KS9ZVdOozA426LNVc6AVwMWotOvXEIWDeLm99dl3AnmH
	MIp7Gp7arNG66Ny5QX7NDYeBx7jBgF2hSEzM2IdQLKOF04U+5CW041rgFZqGwqT9OUo=
X-Gm-Gg: ATEYQzzCZWUOFKCJWg7oo7oZmt/sm3kGybruBnvB8UbCSvmCa3LeTJImsFuS3XpqB/b
	4alzekizmtvzUTY2/K4SejZOrs15vVfVHUicMQj+qCmKo2TcRKA42KXbXwAZWT/YRaY2wU9PPik
	lab5gZrhz3s6Tk7qhxIfZNj9kj7ePLYM/d4qaF4MIssnfuFtbNcBLG7MJ0isZRqkJudqSGLqJtA
	2eaG4suWlOBTIfOjeWOShF/oTy5KI02q4e6stb6x5Sn3jrIrgjoKjUZNLPDF/mqOVkDSoWqbE4E
	v/SO/Qw0OsQtX1LdPnoBE20i1Yv2sYNXAuT5hYw49TZyzUVhZTBTBlBbAS4uhkojyuUgMhyVEPF
	OrHrefieIwU8JBN4jVktWpyS/hdJTZA18YciM/kDM7hhx/qeANxiRzGTuZahJSjq687KXQIodfd
	fUPbayUYauuZ8FjgegwMwfdO4k8UQp3WbD/J/uxUzFr8hY9q4baVlnL/g=
X-Received: by 2002:a05:6808:5249:b0:467:2663:6f0a with SMTP id 5614622812f47-46ae02234f7mr1574517b6e.55.1775046513356;
        Wed, 01 Apr 2026 05:28:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa036505dsm8718124b6e.10.2026.04.01.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 6/7] selftests/bpf: Add tests for unaligned syscall ctx accesses
Date: Wed,  1 Apr 2026 14:28:15 +0200
Message-ID: <20260401122818.2240807-7-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4396; h=from:subject; bh=J6IQJRQ8lNljav6H45hMIjKHljRqbp2JQtxovkFMb9Q=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs3z0bq3fLC90lCmf5hH7rWHZ2+ePzzxRFWede9u7cvuvf r9a+jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEoY3hvzv3tpBd/NJCEzKjdx8VZN NkPLnbMWXN9Drxe44XBcqvrGD4Z6e0eFHQ/EDRKUobQqecYr+RVhb4a6tyivnhtzbX+neIMwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add coverage for unaligned access with fixed offsets and variable
offsets, and through helpers or kfuncs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 6e683dd8002a..887cd07ed885 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -320,6 +320,30 @@ int syscall_ctx_fixed_off_read(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: unaligned read ctx with fixed offset")
+__success
+int syscall_ctx_unaligned_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+	volatile __u32 val;
+
+	val = *(__u32 *)(p + 2);
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: unaligned write ctx with fixed offset")
+__success
+int syscall_ctx_unaligned_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	*(__u32 *)(p + 2) = 0;
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: read ctx with variable offset")
 __success
@@ -350,6 +374,38 @@ int syscall_ctx_var_off_write(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: unaligned read ctx with variable offset")
+__success
+int syscall_ctx_unaligned_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+	volatile __u32 val;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: unaligned write ctx with variable offset")
+__success
+int syscall_ctx_unaligned_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	*(__u32 *)p = 0;
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: reject negative variable offset ctx access")
 __failure __msg("min value is negative")
@@ -398,6 +454,28 @@ int syscall_ctx_helper_fixed_off_write(void *ctx)
 	return bpf_probe_read_kernel(p, 4, 0);
 }
 
+SEC("?syscall")
+__description("syscall: helper unaligned read ctx with fixed offset")
+__success
+int syscall_ctx_helper_unaligned_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper unaligned write ctx with fixed offset")
+__success
+int syscall_ctx_helper_unaligned_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
 SEC("?syscall")
 __description("syscall: helper read ctx with variable offset")
 __success
@@ -424,6 +502,34 @@ int syscall_ctx_helper_var_off_write(void *ctx)
 	return bpf_probe_read_kernel(p, 4, 0);
 }
 
+SEC("?syscall")
+__description("syscall: helper unaligned read ctx with variable offset")
+__success
+int syscall_ctx_helper_unaligned_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper unaligned write ctx with variable offset")
+__success
+int syscall_ctx_helper_unaligned_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
 SEC("?syscall")
 __description("syscall: helper read zero-sized ctx access")
 __success
@@ -466,6 +572,33 @@ int syscall_ctx_kfunc_var_off(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: kfunc unaligned access ctx with fixed offset")
+__success
+int syscall_ctx_kfunc_unaligned_fixed_off(void *ctx)
+{
+	char *p = ctx;
+
+	p += 2;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: kfunc unaligned access ctx with variable offset")
+__success
+int syscall_ctx_kfunc_unaligned_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	off += 2;
+	p += off;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
 SEC("?syscall")
 __description("syscall: kfunc access zero-sized ctx")
 __success
-- 
2.52.0

