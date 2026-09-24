Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A0412BEF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269615; cv=none; b=L8aNnmOR5ApxZA1CJ6NMhsqblQaf8jkpDUu8f9OdDS3C51MJ/HJHO2cvkALgPDg7E8laojr4beGT7bpscY72iNhgkBklM3tXGpq2mbzw175qOnYg7i3Z5cQYWPIdWj3dBwmZtK1au2dA9f2fz85dVPTuNEYFrMXHsIpNlHMDuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269615; c=relaxed/simple;
	bh=t6/OgB6it3JQ8/i8BerNowgOs5ZinF/Sf3BIZ/gf1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUsRJehQVuC8DnQGAwnD1EqHSav4g53H7Ai1/9UBI/4C0Agvaea5+pWqKgnczwH6kpq3dCR/8VvLHwznvS/jENcFdxCHUWSiFw8XvQLYjE7R9X4bY5bCeYlY9dLaivsb3olywEX1XVHLSPA19KYuSQgdXyJ3DVqaGbh+zmRIrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8P0GqA+; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8P0GqA+"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso13441f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269612; x=1790874412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CcJheJ9W8+R/1ynNqND2sqTCtW6PBRA8uRZM8ThNts=;
        b=b8P0GqA+QKPTtpA1lu/X0ApZtucGmD6+LKGnBDU+z9st0twQU1bzS+sEXoSC42xYAs
         EFqTquM0ikUR4H9JmzYAaLiRFShdvRDANUPOiQdo7uDRyf3eHC5x7AtTQWRJoXVAdNkG
         RelLe/kw7UCQzPlFFKiSi8JpIs+X92uv4a3pjq4C17iOqh0txwZfLQ/QFye6ziH/2sbE
         171uSgtbkP9InsnP2iIBwVY9kDLh+SpaX6m+/rZ0jhJwls2BX/o5DLrPd0F1+BDoO0lu
         JDGDQ4jZzCOTh3KoCJaWk1QaLPly514S/NJyyyMqaq/BYNzAXLPL1YX7S4rHYqOo2M4X
         RGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269612; x=1790874412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CcJheJ9W8+R/1ynNqND2sqTCtW6PBRA8uRZM8ThNts=;
        b=gWYU01B1lBjS2xO9hyr7xXQ0/kZJCuBUqw6t/w38IF5i9nb8RVV3+As3IPJJm3Qt4/
         sY7eIGdouSQaKqr9rjqHwaAPKSElVB5WWpVjpVUatFICKCMhbDzUYVL7DE9FO8nftwKf
         B/Xm824Yr+1q2RNDDRN7wY48A5ucgdz4dpVe1cdkfYtrQ4mlJeSkjmeY5qh009F9dtW+
         P8WCeahaUaLXB5YFC7dY2g3C2NlOMszH6IKyqp8gCmgw8Kp3DpXub8wAazd2oeg4Hi5p
         Ssv21gv+sz0eh/3nAo5RaQ7so6HihR0D6ggXudCbC4XaaHuXIsD/6chyTzPoh2PsAkUl
         Scng==
X-Gm-Message-State: AFuF++no9z+//GxF/P7vr5MDAEPFVSwr3yDujA30f8fJ5Iln4Bt4XtjV
	XXyCPIaGHW3lO9I/mZ7kecbnDXJi93H8Vtv8EBNd3ZJPIaR9Zhfvt5CDs4MkIaiv
X-Gm-Gg: AYBFou3eQqjI7IdS0EjERSifba9+zrFiZHDLMh0xm1kQZANmhRsFnynTlLjzR8ItNOw
	EtMQY5U0zzCxrKLYbI1bWNUHIIuLFYzZqs7XZzYyvPVlWSyE8jO+Tw0P0f0J6a59qTa6Smji80/
	t8ztRwJXcXTgbTddeEKLDYVM5/oa7gFThn4fF/YFL28paGEBB2mq/9LqaBYH9gWnOshOesCS5/K
	giAw6g9D9jsJB3ff5jMmZQMtzjmdqcigrEmufEQ8Ljt12lt0DtlzMJMHCiIm5vze0iEWluEyd/d
	yIYZ3TzreFwe0S0GyI8Vp36myiBteLrcHvVZUbDqDyQVBRRlgAti9Ge4YgBMtoTTMhhCm/8tVIK
	AblPJK5Opgwr26V8qqzDOMoNi4B9xnQcNtu3D5y+K8hkBnJFsDQ/mhVRaeeCnSdVw6/cRFf+1Ex
	84PrSrAkEnI6GoM2RHY1GqpUjDko1nfWonRkkw29CWdv3JSMyxA+k2RNPDshfRm9NXayrjQaeCF
	sd4uqBRo1y7wVfcOgHcZm2kC7Tz7YbSCix8QB+cMQ+12g+tWUQw1/JNO2SHSu2g0dYCjxK9hStd
	21so9KSCIYRgazRXT8YQVTLCZh7das6ytwxRUw11Wj3+ENmb
X-Received: by 2002:a05:6000:4381:b0:486:fa31:b468 with SMTP id ffacd0b85a97d-48871699455mr5497738f8f.28.1790269611952;
        Thu, 24 Sep 2026 10:06:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm474002f8f.4.2026.09.24.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/7] selftests/bpf: Test verifier stack-read diagnostic attribution
Date: Thu, 24 Sep 2026 19:06:36 +0200
Message-ID: <20260924170646.2366016-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5270; i=memxor@gmail.com; h=from:subject; bh=t6/OgB6it3JQ8/i8BerNowgOs5ZinF/Sf3BIZ/gf1Mw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRLH/lyudM76923qZMfXx17kZdz40Tfz5eMbHE/wHn wY4J0he6yhlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEAlkYGb5d2hLCWXXBpuRR ZZZirrj3rX9ii9RO/q0J1jjOn8k/gZPhf1ntrziB0/+Urdb6G3BGJZrtC1DrMjs2U1uVtYc3/UE ABwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics distinguish uninitialized stack bytes from opaque
dynptr, iterator, and IRQ-flag state, and identify variable-offset
stack accesses without changing the existing verbose messages.

Add output assertions to the existing uninitialized-stack, dynptr, and
iterator rejection cases. The uninitialized-stack assertion uses the
CAP_PERFMON-less read inside the allocated stack, because a read below
the allocated stack is rejected by the bounds check before the slot
classification runs. Add a direct IRQ-flag read and a variable-offset
atomic stack access to cover the other classifications. Retain an
assertion for the legacy helper-worded verbose message in the atomic
test.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c |  3 +++
 tools/testing/selftests/bpf/progs/irq.c       | 13 +++++++++
 .../selftests/bpf/progs/iters_state_safety.c  |  3 +++
 .../selftests/bpf/progs/verifier_spill_fill.c |  2 ++
 .../selftests/bpf/progs/verifier_xadd.c       | 27 +++++++++++++++++++
 5 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166..9418dfe4d7b7 100644
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
index 53df6d248e26..50727fa9b11d 100644
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
 __failure __msg("R1 type=map_value expected=fp")
 int irq_save_bad_arg(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index e5bb9fe6d5e5..b2ba4609a31e 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -354,6 +354,9 @@ int next_after_destroy_fail(void *ctx)
 
 SEC("?raw_tp")
 __failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of iterator stack state")
+__msg("verifier-managed iterator state")
+__msg("Use iterator kfuncs")
 int __naked read_from_iter_slot_fail(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39a1766dae3f..e1a698db0364 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1277,6 +1277,8 @@ __description("stack_noperfmon: reject read of invalid slots")
 __success
 __caps_unpriv(CAP_BPF)
 __failure_unpriv __msg_unpriv("invalid read from stack off -8+1 size 8")
+__msg_unpriv("Verification failed: Memory Safety: Uninitialized stack read")
+__msg_unpriv("Initialize every byte in the stack range before reading it")
 __naked void stack_noperfmon_reject_invalid_read(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_xadd.c b/tools/testing/selftests/bpf/progs/verifier_xadd.c
index 05a0a55adb45..7bde3da2f36e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xadd.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xadd.c
@@ -121,4 +121,31 @@ l0_%=:	r0 = 42;					\
 "	::: __clobber_all);
 }
 
+SEC("tc")
+__description("xadd with variable stack offset")
+__failure
+__msg("variable offset stack pointer cannot be passed into helper function")
+__msg("Verification failed: Memory Safety: Variable-offset stack access")
+__msg("The instruction would access the stack")
+__msg("Use a fixed stack offset for the instruction")
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

