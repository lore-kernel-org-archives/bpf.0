Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483752;
	b=JwvSpsGdYOFEEzuDz0glhmwXSadgQoB2D54kFBlSfwl1NyeeGPX1K7lmNoBTP1QC+eVN
	 vvV5XDf6G+IDC9Uz9F/wtERKlsZ0Bv9DaKi0yj0W2FzZWwk1hBdsklcK+WW3TeIeGjP0j
	 HbEbp0LeQ/wzfhbz7rsMmz5qu2UneD75gk01qvmTFpY90fL8/a5r5Cbe8b15zYyFcZb/2
	 87FBN7R63NaE8yOzj1dwwvBnr/zhPio/N0uW7O7QSLkRM3S9c7HVMsF7umzCGKcuUFEnE
	 +S4tbww6wXt2XfRewp0+jzgbqgV+9nL/4hValSCsMLBvvOdE3Y1FIaLwRs4EY7hjo/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IQTgQTVA2chtacysaQLNSMmmd4eqeXf912PsodY2diY=;
	b=mbKxfJW7zgUNjyDYBl8bpSfxO34dq2aM+0A1v19XgWcZ2gOs1aaEXx19Bod4sjMNbt+6
	 PQASv/jNM83rtvdVMD58GTaaFujIUAERUx/mz85J8+pY4lFxzQqNzvxdn0qVX9Bv2wl1M
	 c4uiBIM3YWmfycsEHi7ZLESKAnr621ZyHq7TT11oEYqNMH3svemIs6uKm7PweOdbPsHGw
	 i9UNnPaLsiy5gMkNv6W2MeBy33aYfpsJMcb8rbj2O2OG6hc7V7E5VlV5lhIccbD1Iag/Z
	 VPOeXhJwfpoIgfhCHU4F7AnfAOz4+rh1W0Rsm2zuTmqlhzLKFOAfIVisy8U1k68fBFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CV2GxjFw;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B49606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CV2GxjFw
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so991594a91.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483751; x=1794088551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQTgQTVA2chtacysaQLNSMmmd4eqeXf912PsodY2diY=;
        b=CV2GxjFwif/RK5rUnPnXPkn8WfeLS+QOhU0MCQTRaBiKSHJ63Nk4WO0vLaC5VDqJ86
         HfMbkS9CuQxXgrsUGRWxMh8bUaUa1ojZrTBSl/Mj0rRUO2hJt9oB+Cm/7I3zsJn4sgKJ
         qj81t8a/Exz3446hj+7oYIeFEPSboc2l4iNxmFoJ1LV9CDQaY0vRe7YRGXBXmy7jtWOG
         PHF6SblaI49PI0xfsSnqVA/7gGAynLKPQ+Pppw3ZE34kIuVfXUyMYKTKH+vFmCieVbV+
         qbLt6mk3Kot41OqqWfN1EsgXraTBpNl9MhudbWPZOczorMTQAw9AES9Kz3THN6M4PxGs
         ifhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483751; x=1794088551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQTgQTVA2chtacysaQLNSMmmd4eqeXf912PsodY2diY=;
        b=TL8DKqOHSbnbGbfeB7W29ofmQAVW9PTx37IIREdoo/JgVWcpMu1oCWOBoutTvrUIHW
         6qxaZ2uVcBarZmThplprlQjmz1vg6sx/1Gls0HxdY9fm45kbibFdAzah02LDF4TwgDMf
         PYov9xWDjuwHUm45jDn5CeWmf7ESAs8HFd+dgnq8teJ5HKVm0MaFUKajOeieY7aL5kIR
         xIqNljSxSehuImaRkuJYG3ql4DOvs5oobWcglrup/wWo5SPZ4Dgk+xbX2TuwET4mi+Lm
         oBC9ywaDomgbuC2sfpGeLUtwg1epNWwHBPFO5Wa7iM/zBs/GdmPDcs2gRWPDc2f7Soya
         ZEBA==
X-Gm-Message-State: AFq9FYL3TZ6j665DohcR2pxCAW24ecysUBLMOZGu2kvprJbhd3pwCIYF
	VTGA/TL6E2aKQEO4qplfzdjsTz/ErdPEnaDLlLXl1r2z6UlsXof2CR6qlOKgxg==
X-Gm-Gg: AYBFou10eUugOlTbxlmqw2u7sncjFMIH36W24hz6UHYeDdJNSQss0y++SScMSGsr0gR
	wblq3fJ+lq7DV0gj/trk5STzTdOrgTqxTkET2MF1eBJ0KYeMYaTLEMO3kuynAZyQqMmLyrtwVsx
	YZPlstpf97E62b6GdgyopP+JBqAj+sXsQbj5GuvUxBfKkNDWwB2BeJN6Zg4c9odGEUhbxdDObgb
	7L2NfWIQeHMlSfmZMHh7H41KJT+ZWaYZK37dyYETE+dsyt6Je31yD8nvchP9ZGaUfhUYOlNFzhU
	Gh4Fp/F/441/fzg++2VOkaMK+VIess4TJ1UmJhTSzAxU4ivmVtbliv24ESplmAFtbU/Yqq+MJA6
	jiasPtynn9nJyCvaOMeafMlXf/StNLArKS+ILhaiH/n/REqQFF6jaglKtN1J+FINx3V2kXN1iTK
	FwpbT4RCsC1bBBEpXQjd4o6TCAA1EifysTE+27xdG4vG1J5TdNMssEQDHG87WL+CQz7ZXNq8gAt
	MWUXISjdIEYk7anwEHUyJK6x27h5RXASmjZ/Hd6cCTinV2DmKgJ8uQWaYVHng9LWvCLBGumc+H3
	VXAUeej1D6neLYaWyyZZQd5D2AmHpCzjf87S/cEwM2u6aXIul82I1zMf44C7qUdLmwkBSoOB3I9
	B3Mfp8JUUATW9x3i6/NVegnES1EkjEi1h9EtXSt0+OdMPM3c5gxh8Rn6FJjmqXM+AhWs95KHgH+
	s=
X-Received: by 2002:a17:90b:4ccc:b0:3a8:32f2:f4a5 with SMTP id 98e67ed59e1d1-3ae898385aemr5133444a91.53.1793483751283;
        Sat, 31 Oct 2026 14:55:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm4864488a91.4.2026.10.31.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:55:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 1/9] bpf: Emit timed may_goto for JITed progs only
Date: Sat, 31 Oct 2026 21:55:35 +0000
Message-ID: <20261031215543.682284-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The timed form of may_goto calls arch_bpf_timed_may_goto(). This function
takes its argument and returns its result in BPF_REG_AX, in a register of
the cpu. Only JITed code can call it.

The verifier emits the timed form when the arch has a JIT that supports it.
It does not look at the prog. With CONFIG_BPF_JIT_ALWAYS_ON=n the
interpreter can run such a prog: the JIT is off, or it fails. The
interpreter calls the function like a helper. The function takes what the C
code left in that register for a pointer, and bpf_check_timed_may_goto()
reads and writes through it.

Emit the timed form only when the prog asks for a JIT, and make the JIT
mandatory for such a prog. All other progs get the form that counts down
from BPF_MAX_LOOPS.

One test of verifier_may_goto_1 shows the insns of the timed form. Load it
only when progs are JITed.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c                                     | 9 ++++++---
 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 41bc37e205e0..bb6b57f5e144 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1823,6 +1823,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
 	u16 stack_depth_extra = 0;
+	/* arch_bpf_timed_may_goto() takes and returns AX in a cpu register: for JITs only */
+	bool timed_may_goto = prog->jit_requested && bpf_jit_supports_timed_may_goto();
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn *patch = insn_buf;
@@ -2078,7 +2080,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
+		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
 			int stack_off_cnt = -stack_depth - 16;
 			/*
 			 * AX is used as an argument to pass in stack_off_cnt
@@ -2108,6 +2110,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * after subtraction, rinse and repeat.
 			 */
 			stack_depth_extra = 16;
+			prog->jit_required = 1;
 			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
 					      tail, ARRAY_SIZE(tail));
 
@@ -2730,7 +2733,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
-		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
+		int delta = timed_may_goto ? 2 : 1;
 		int subprog_start = subprogs[i].start;
 		int stack_slots = subprogs[i].stack_extra / 8;
 		int slots = delta, cnt = 0;
@@ -2744,7 +2747,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		stack_depth = subprogs[i].stack_depth;
-		if (bpf_jit_supports_timed_may_goto()) {
+		if (timed_may_goto) {
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 						     BPF_MAX_TIMED_LOOPS);
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index faf9eec0a63e..c19b0522df61 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -82,6 +82,7 @@ __naked void may_goto_batch_1(void)
 
 SEC("raw_tp")
 __description("may_goto batch with offsets 2/0")
+__load_if_JITed()
 __arch_x86_64
 __arch_s390x
 __arch_arm64
-- 
2.55.0

