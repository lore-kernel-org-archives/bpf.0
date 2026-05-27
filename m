Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED76405F7
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859591; cv=none; b=rD1nbjoUP8PptFSs07MGPey1sisl5VJWOrSeM6SZiutB+QD4Ht6njPcMkiv5Z0FjIU+Aih9WjdUfnRESc4ynuQW6YMo3XopEA7Blb9Ea429w9Uat9eAV8mhRLXKtA8LYWh9WLt9wm/nc4PhsbRJTzLqZhJciuWrGLmXT0/OWnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859591; c=relaxed/simple;
	bh=0PEmYmUKjjy+UjaIZHA18BYu7wgf2SlU3T4ccIn/5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkNGQUj+bOxlpUk7KkM+WG/89HKdFVkttaySCzNw4MX4mICMT2mtZh5qGhWSsoYNrviGrhbb4JI6Wn/5cbQSon3HeZxIO3ka+AEMd50YKtsrmN9SIGfEQzx4LwwQ4iW0Omoy+VosnAXK1z+dfp4fobuZpb7U+dndhlEucYD11hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXfxSldS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXfxSldS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2be1dd4af34so101167805ad.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779859589; x=1780464389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBBzQO9B+rRmoWSlMXPb0NICXzc+ZzEXtJVCUCazNEY=;
        b=JXfxSldSe+XRZ+/FxugXDjGuKun1YPRuizDBClEyd5DO5OppHFm/CFs+Dyj9n1niXt
         2OdnEDH9eRKx6t7Sbmql0wRpL/1Df218S4NSRo3F7Xb28pTjNrla/8agXLkOBdR66P8D
         fiT/iA+dKUw0YFCa9d9Ee4ninG8hiRYZlzsPUbFkreo7vEmZ7EIG0hLOZdAMOm8nzvM3
         WXVeWT1fJIISzuQg5oHzP+arXwarspJTZM7UbV6BdtomGcT+gdoGuxCqBnR1Q6SROBon
         mrWw9ga1fLOK7X7z91M8FNVgZFWMe+iHGLd693wyMZxCJ2LktMgGhyLfX1Tc4UPPCFVU
         shIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859589; x=1780464389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBBzQO9B+rRmoWSlMXPb0NICXzc+ZzEXtJVCUCazNEY=;
        b=T8V7aVw5tZeL9YuoRba58hBIWQUZE0U/mb5D9o5VZvOCfTBb3V9CJu4nr1L8hrhA26
         cPgxnNAJaxGITIHifJPCt8aW3jnSdVcIHqXw/4aRMIF+RhgnVDYnqqQgNQjCA+PNJgX1
         LnfLchXBwJROqhRlLyjA5lpI+uLusJV+G1IE9TDXwjW+PXo6BuwQemwiQzSxikB866a/
         bVSnx8I+v25ph9e5OaP6PzeUZHJrleVoFzDT2Jlw4jm0PW5x2y2O5YWo7O3hYSkYc3vW
         1v+qHtMqxFC0B6HyTQyAEYxbte7DoVaOm3W9KdIQ492fjOGzBxz1eHRUEtVuhe6E3hVX
         QgiA==
X-Forwarded-Encrypted: i=1; AFNElJ/ssAWJn0Cfk2R2R5w5b2H50dD+wUSMsNZsVK3wbfzv6cNncu9YnQc2xM5mkAB06jv95uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRCdgPbNNfxFnwaeiY4ACVavvLxdFX0cQLKRcSvgJwDnWGaZ8
	7CMwIhfj5XFypdjViJg6nvSYBjChUmPx7hLBebsA4kiDId8WT1MKksgLX9iJdYZz
X-Gm-Gg: Acq92OF/oZ62SfxJRBajyldCSZpQ49Cgx7m5wD5C8GuVRrpphppDU2aHAK45yfTjIbw
	mM1Jcwy1QYAM9mnEQaaVpom/MAlEF0cXNVag3pRDJ0GA5ThHe5qSRSos+Jff0SNlsC63GWP5Y1Q
	fEMzoMa08WOMi8y/7xbpD6VpFoIM6UtC/pVTvN7jEg5xUcWcN9qcICFR8pGuiPB44SyRe9OQrCW
	xPFlihc1gp/8/AlMxF/PQUHV5JaG4H4VhVr9nRW7U7HIaNrmVi7kMb8mqLQd1lVfZzwtiN2Dq+t
	Q4lpTOlzRsEI1AQrCTtxxWroqlU/k5bPkdRoyYzOSJMBN1kM86Z9dYu8dsyScqSWzFMLva+P6ZY
	98rQ0oo/+ujmcCaikKqy0oFQyL7UbRW+VNtQ1ybxw47Pc9xfKIpNPWQjGr+XkNm2wsPLqUcX8hr
	ZZVB1VWDS0NlYE1ZmrPs+JPFW7lkViPIPEP+es
X-Received: by 2002:a17:903:1a2f:b0:2ba:7749:f89a with SMTP id d9443c01a7336-2beb035c500mr227120585ad.11.1779859589210;
        Tue, 26 May 2026 22:26:29 -0700 (PDT)
Received: from localhost.localdomain ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58e4fcfsm144891465ad.71.2026.05.26.22.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:26:27 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH bpf 1/1] bpf: reject overlarge global subprog argument sizes
Date: Wed, 27 May 2026 14:25:39 +0900
Message-ID: <20260527052539.3388700-2-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527052539.3388700-1-hataegu0826@gmail.com>
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram argument checking derives generic pointer sizes from BTF
and passes the resolved size to check_mem_reg() as a u32. The access-size
validation path then uses a signed int, and stack pointers negate the value
before calling check_helper_mem_access().

A BTF type such as int[0x3fffffff] resolves to 0xfffffffc bytes. On a stack
pointer, (int)mem_size becomes -4 and the negation validates only four
bytes. A caller can therefore pass a four-byte stack slot while the callee
is verified with a nearly 4GiB memory argument, allowing accesses outside
the caller object.

This was confirmed with a non-executing raw-BTF reproducer. On a
vulnerable kernel, the verifier accepted a program where the caller passed
a four-byte stack slot, while the callee argument was described by BTF as
int[0x3fffffff]. The verifier log showed:

  R1=mem_or_null(id=1,sz=0xfffffffc)
  r0 = *(u32 *)(r1 +4)

The program was only loaded to prove verifier acceptance and was not
attached or executed.

Reject sizes that cannot be represented by the signed verifier access-size
API before any conversion. Cast the non-stack case after the bound check to
make the conversion explicit, and add a verifier regression test for the
oversized BTF argument.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
---
 kernel/bpf/verifier.c                           |  7 ++++++-
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..1007f204a1f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7107,6 +7107,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	struct bpf_reg_state saved_reg;
 	int err;
 
+	if (mem_size > S32_MAX) {
+		verbose(env, "R%d memory size %u is too large\n", regno, mem_size);
+		return -EACCES;
+	}
+
 	if (bpf_register_is_null(reg))
 		return 0;
 
@@ -7119,7 +7124,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
+	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : (int)mem_size;
 
 	err = check_helper_mem_access(env, regno, size, BPF_READ, true, NULL);
 	err = err ?: check_helper_mem_access(env, regno, size, BPF_WRITE, true, NULL);
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff7532e..0ff8f85b4d46 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
 	return subprog_user_anon_mem(&t);
 }
 
+__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
+{
+	return p ? (*p)[1] : 0;
+}
+
+SEC("?tracepoint")
+__failure __log_level(2)
+__msg("R1 memory size 4294967292 is too large")
+int anon_user_mem_huge_size_invalid(void *ctx)
+{
+	int (*p)[0x3fffffff];
+	int tiny = 42;
+
+	p = (void *)&tiny;
+	return subprog_user_anon_mem_huge(p) + tiny;
+}
+
 __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
 {
 	return (*p1) * (*p2); /* good, no need for NULL checks */
-- 
2.43.0
