Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BB32B13A
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845473; cv=none; b=kfA33uFP+iSP7Gwi2aoJGj5ScmOLgsfGOzAznGDOAzaAGmMUaCrUXfaKmy6VXcN53/3gxsZIsh9nGbuyN0gjydblP1o4lTvwpPrSgXFQrc4PQCbNiMZScQsB2heeW7wokPywaTKy/mgmtTqThZ4h0WX8RkwELotso/LZyl1zsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845473; c=relaxed/simple;
	bh=KB5Fqysu4hnf+FbuPBuavc0PV6ROfapKIvB9532ISoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usxtj2WuJAsbj+0EEJ4cGGJyLYu9tbWLOGiK3goTKML4ZIAil5/MkL0bi9UiOB5A0KYcDT7tcfZ1cBpa9+VPGgUv4EWBwLMw5D2LfFs3Zvm8D2rCRnI1dqw3VLwrh01hW+z+c1f26IbU7p7H/sKeA0ZEXSsp3aUXtRjfTy15AE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItxO8OHF; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItxO8OHF"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso714948f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845470; x=1787450270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbLOQ5biQ8ExiB4NmiAKSnjY8llS/g52znAttejn2uM=;
        b=ItxO8OHFBoFTqwQUcYHkDJAm2oy5/lfEQrrbjNrbdrkg3J3b/RBMMvEYSRc8t27+gu
         f6sGDhcFtPgsJexyWK/WvsNCMgfFvL8VIXLPorr8hAQ8MSgegKDflYpQAzG7Ti9hLRNS
         g7B5ZR3xJ+9G+a06EiCy+66G+ptNWma99ICqBSTvkorz2/2kXuqvMKuvWYqPDuP03dxm
         NuEETAFg3qYnd3aNYzKSj7eOtAY6Q9dIBwRC3L8pOV9se63WdbcD+Eks1Cqr+T0kh9ip
         AIaDIy0NVGeAF4Ds4hRL0I4dEZIO3uBCtMBi8DHhj1vUSWil+JGTtDlIMFFIjG7vIE2V
         aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845470; x=1787450270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UbLOQ5biQ8ExiB4NmiAKSnjY8llS/g52znAttejn2uM=;
        b=O/Ph1CM5/ToPFxKDPc6/EADyzbGH6m30Oh6qkZYlzKgRUQRu+6D2w12/s13OpHVenk
         SpaJPTMl1G1S2xMHub/yRbTfO43qnxIeIldgNMD34wYONqppHw8VdgLE6vBLY82dm2kk
         GV+wfVNr0tDOV1rG7jJrJ6IMC8TGKi2IVg3gNZ7k2DOLn+KSsvNUnsxn+ci5zOLWxJFb
         xdHs8Y6jd8jDSgHu6y/2fQJ+S3gpgRH1yFnQi4NuA7EG6ldPXXaU9I5gija3nEdbz1Cx
         EPQ+1C25gcKBa9nBjELa3PuDlgWE8RvyRmX1hMA9wMh5s8seMfUkg0AVG7qAceXWQi+i
         OOHw==
X-Gm-Message-State: AOJu0YxAFPNJa6cb7jpOggwIZabfpeacIJ0zedBB+w6COjXA9pVvxHsS
	oYByfJHRLF/5YLBw87W3c4g+gje6qvicuXOYXCDiOJ3FyYXJjb4XEHbi2TIp694r
X-Gm-Gg: AR+sD13SHdji4F1eHxV/OqVzKWqQsBv6xJSg+CDba8Hh7YU1WemGBuqtXmdZCHMcIFr
	xRNA+PcSsgAvYF3pdy+5aBol/LyXN7HMCnA1WVKC638B+/LtXd8Rb00bXpWYOYXh4nrR2BVPQux
	iucxqxvRG5XWVz8r7pvTOX0q1GGwSFJkIL/ubVgkAGLmgMjTvGQWfnHfPGhAlDVSLINpmvh6K1V
	0iLf3UrnLuOiZATNz3cATGbFw4RChc9LV4rlKCCn6u8S7StUtRmJ8gAQDrPZKb1UvX7O/vy9inN
	zQ0/ml38+yavPnBAJG78IUZ1OGAyxtE7xzVaHhKVwY5r98zuMcl8IdyUnX5Krh9WZvPP7WJuT4o
	haV6EFKeIUjO3vW1BJ7MjJqlFr31Zy+K+ciXZHZMmw0z0bZf6RHbCXWokH3kjyAlGUoCfSiwKqN
	9aoH9gHEQxo4rMVM+pYooFC8Q4A6jbjk2Ct+IDzTN/cVGYuI5alT6LVy6cCEzYY/nohSEj3sb+j
	7a1QePCwLVPeN8b2cG1/b2ioImyQteLEteNYc2mof0j6SmM4GGXJ6KtFoWyGYM+5gYzcvBSipgQ
	rPYVgCyBaRsdrXTsHkuwRcrlfFw=
X-Received: by 2002:a05:600c:3485:b0:499:8758:8cb4 with SMTP id 5b1f17b1804b1-49987935eecmr245545925e9.5.1786845470407;
        Sat, 15 Aug 2026 18:57:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996105c0bsm5092625e9.4.2026.08.15.18.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/14] selftests/bpf: Test verifier stack-read diagnostic attribution
Date: Sun, 16 Aug 2026 03:57:30 +0200
Message-ID: <20260816015746.2632990-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4237; i=memxor@gmail.com; h=from:subject; bh=KB5Fqysu4hnf+FbuPBuavc0PV6ROfapKIvB9532ISoE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQiSg7saro15Cq90dCpxvr2VIseAzvFRxfM/Ve6cuT 9eS+tDXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn0fmdk2Pdlt9bZoM+eV+3e xjkffHnqf85byfapuw4XnHyjxNNn9Zzhr5CdqpBF2h0h8UvhyTmdinJ/ry25VPBI76tLafXNbcu DOAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics distinguish uninitialized stack bytes from opaque
dynptr, iterator, and IRQ-flag state, and identify variable-offset atomic
stack accesses without changing the existing verbose messages.

Add output assertions to the existing dynptr and iterator rejection
cases. Add a direct IRQ-flag read and a variable-offset atomic stack
access to cover the other classifications. Retain an assertion for the
legacy helper-worded verbose message in the atomic test.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c |  3 +++
 tools/testing/selftests/bpf/progs/irq.c       | 13 +++++++++
 .../selftests/bpf/progs/iters_state_safety.c  |  3 +++
 .../selftests/bpf/progs/verifier_xadd.c       | 27 +++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index beaa73dc35f5..72aa6b5a877b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -560,6 +560,9 @@ int global(void *ctx)
 /* A direct read should fail */
 SEC("?raw_tp")
 __failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of dynptr stack state")
+__msg("verifier-managed dynptr state")
+__msg("Use dynptr helpers or kfuncs")
 int invalid_read1(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index a4a007866a33..8d2b50d11fa4 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -14,6 +14,19 @@ extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr
 struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
 
+SEC("?tc")
+__failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of IRQ flag stack state")
+__msg("verifier-managed IRQ flag state")
+__msg("Pass the saved IRQ flag to the matching restore kfunc")
+int irq_flag_direct_read(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	return flags;
+}
+
 SEC("?tc")
 __failure __msg("R1 doesn't point to an irq flag on stack")
 int irq_save_bad_arg(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index 646026430e9b..4723ae578e53 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -332,6 +332,9 @@ int next_after_destroy_fail(void *ctx)
 
 SEC("?raw_tp")
 __failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of iterator stack state")
+__msg("verifier-managed iterator state")
+__msg("Use iterator kfuncs")
 int __naked read_from_iter_slot_fail(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_xadd.c b/tools/testing/selftests/bpf/progs/verifier_xadd.c
index 05a0a55adb45..f2430b9a0218 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xadd.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xadd.c
@@ -121,4 +121,31 @@ l0_%=:	r0 = 42;					\
 "	::: __clobber_all);
 }
 
+SEC("tc")
+__description("xadd with variable stack offset")
+__failure
+__msg("variable offset stack pointer cannot be passed into helper function")
+__msg("Verification failed: Memory Safety: Variable-offset atomic stack access")
+__msg("The atomic operation would access the stack")
+__msg("Use a fixed stack offset for the atomic operation")
+__naked void xadd_variable_stack_offset(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 16) = r1;			\
+	*(u64 *)(r10 - 8) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r1 = r10;					\
+	r1 += -16;					\
+	r1 += r0;					\
+	r2 = 1;						\
+	lock *(u64 *)(r1 + 0) += r2;			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

