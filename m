Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555060;
	b=RXUs/OtQNklOuBhDZKAC/W8/+VZ2Z0HfGfHFoTTypuR/YWrm+tnCfb0DCoBletpKpyQK
	 AVwiKiv3/JdX4HfWDv9fPaJNCft7CoeictLC3b8CwsEpju2HEMnq2uuLU6LWLVzZyPtBY
	 psNF8a/3PFaNWpmKwxvll2rHtSrOrn8vKqndTZhG0yQnSJbZPfj6AgS9MxyIjrZfP+J+B
	 yYCCkWz2DQ+tcVpN3qd/R74zBizfOkLGjRFb+vuJusU7EDL/+ydf3afLCWp7Qr2nwjwGr
	 XtRU2RRLsSKOHDc73btOAZHg+ClWHpg+7IA0edxMCJ42x6C2sJYALR+Jz5M7HV6r6Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9fRXydjuRH7BpORHVZPwsis6/JuJxC/QJTbLSxAyO4I=;
	b=Oew1tPiwal+YKiTgwK8VRaXc64AtDlps0PLQG7/YH7fAQv7bPosaH5/p4nYppCIDz7cK
	 XpyVIJZ3TkHGPSqkcC7mZvrz5ozGLWFUs4hAqWL1toS8Ky2bDq9yM8w7BEnS06oqcQQBW
	 qiS31m5V1oxUXnyM7EvgxGYFiEJqXFxhoaTnmlvVyjRk15iYSbrZTW6CKppgeJgnhS3e/
	 0IYAlqtfJhBZm/O44h7bVdmR4CizJ7Jbhe5dILv8+FviUsH+6DPRQ2IO1DgW2j21e5Nrv
	 dyJf2z507iQNH3Pvl6avhsIEOxV93QLZD1b4TBHS97a3uD4XkwKiBqEQv/QtwFPUtQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7RY0vEi;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454B606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3454B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7RY0vEi
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e60f9af6e6so21104595ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555060; x=1794159860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9fRXydjuRH7BpORHVZPwsis6/JuJxC/QJTbLSxAyO4I=;
        b=C7RY0vEiSfD+V574M7lKfZxkd4wIxiQKqpImzYngViHe2Zo72j8k0p2TKuojdzvbMg
         UVagdLoLc6gf+brKkPMpsZnpHUhYhfwbSlSMR/wGxn64chiREdR6gu8qWgzbQU9/vUpx
         m1vUJ/ILFcGnwRf1OKcXMzi7LO7r1tjudW+hRUNPyR9ZyeelEn4e3YoNYY1ApslpnqRt
         uSjuik8HHYC997WOSVslSS3HPb0JQFLgkDH7VnPDFO+u63rkb3yhwL5O0ottAcVCWvAY
         bdVjC2lrW1mG3NMuUL9c1dQb2lmUe94gur0QfYBbCGpK6btre4cOcfcXPAKT/i2lZWuP
         Eq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555060; x=1794159860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9fRXydjuRH7BpORHVZPwsis6/JuJxC/QJTbLSxAyO4I=;
        b=sfD6NS/5dRRPl/OSHcAmxRHewl4i65HkpPQjukwii9XK0gYwz8OvoxNFHmdULE0KyO
         cGauHy7pgvF8LG1rioSx3QAHYrcAFFDx+Z/pQ44HywhqaKS14vXJOieelgatb8g7f+na
         +Db7Y4VMrwyApt4Xz/ub01pCmzkRm8pokapqNV/6IB9eRXwb+Y5PcYpTyfQpoU1IuEwi
         FG/67h9+5OWiYQGSzJ9boZ0ReG+wMlC09Z4/oRkUambXvX4gooeSu/YZ3FArcrSdJt8B
         bvRnESqAJLMnzSklnAUui91+h0dUH3/jbjLlxqfIJsvWyr6XZHu2/dhRM2WyBC+BlpPO
         Gwxg==
X-Gm-Message-State: APuU4Z+bOKYUQUPs1rNd4rhJwWJHxUBicSeg1m2G/g26hBWH2F66of5Y
	va0i09rPS+NJ9hUDCRXSKan9eSLksbLIOSvzkqskXtk4Bw/3YdiSsT5EeLLPXw==
X-Gm-Gg: AYBFou2IcQZv51JaBnpicWKEPNAg5xRxmjbJXwS8LyZ5cbuBhIIMm7ck9oifnHaDKQL
	iT2pTGU637i/QqceywzzQv7ftwvDGe2SutLMPaBXrkXoSX/88XdSIcco54Y6p+CG/QIdO9DOfHu
	tGkaoyTe5gAIW9C6rMOGVHu7QrdEEJyjI2Db+sn60CrwswroY/MNPpoKaP6+mTMcIi3q4mE5tYw
	6PV0yOJtioBa2EQGHHuwdWTA6WkJXDhuqHcO4yHLfmlFAQ+NhXK9dG3y7Gq8+fq9q6Jn9Ni5H6b
	XyquGrlMdQfdzkWaQTcEo0JSezr2Tonx81kytdLyvwyqHQdgy/Qc08TIP2CNJ0uQPyRShBGYTWD
	Rxsyn9618XnbAo5kLAxAdXyS/9BsIquiPZsb3YQlvoiqLRGw2G5DbqjizoRBpp1tB9z2ndKbUHH
	b5aWm44f/bPqh8RrWYCzYLUlTz/MPLYAqeXW+wpc6zZVkFIwz/BAMZwc0bKaPjV4qbXlYle2360
	Nx2ADg+MQCB6+ON2e7wwLJV/N9/COkJuelg8dyKNHnG9m3W60hnTsxF1mpU/lLRcrlTEdWzyjnM
	wTFkzTrxWjr62VX59YWeacDj4a2T+ik0euJ7d06O6KdTtQsQY5WvtpsHYIEEa0kOVvtehaS3TDS
	bFC2IrBC2e8LP0J87s0t+hHZOnYeH8YZ10JFcSK8723jI2Yn8LiTrcqu38kt5i8qWxXIdkfWcTa
	c=
X-Received: by 2002:a17:903:298f:b0:2e3:1d30:8654 with SMTP id d9443c01a7336-2eb36494399mr81262285ad.10.1793555059343;
        Sun, 01 Nov 2026 09:44:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392a489bsm18642485ad.63.2026.11.01.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:44:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test liveness of an implicit kfunc argument
Date: Sun,  1 Nov 2026 17:44:05 +0000
Message-ID: <20261101174405.4055052-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
References: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
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

The register of an implicit argument is not live before the call:

  kfunc                                 live
  ------------------------------------  -----
  bpf_stream_vprintk()                  r1-r4
  bpf_kfunc_implicit_arg_legacy()       r1-r2
  bpf_kfunc_implicit_arg_legacy_impl()  r1-r3

The last kfunc has no KF_IMPLICIT_ARGS: the prog passes all three
arguments.

kfunc_implicit_arg_in_a_loop calls bpf_stream_print_stack() 4 times. r2 is
its implicit argument. The test expects that the loop is counted and that
each live register has a formula.

Two more progs run. One jumps to the call, one has may_goto in front of the
call. The kfunc has to get aux in both.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/compute_live_registers.c        | 13 +++++
 .../selftests/bpf/progs/kfunc_implicit_args.c | 55 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_scev.c       | 33 +++++++++++
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 1ff24bbc7beb..de0496ce7d5e 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -538,6 +538,19 @@ void gotox(void)
 
 #endif /* gotox: x86, arm64, riscv64 */
 
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz) __weak __ksym;
+
+/* The verifier fills in the implicit argument of the kfunc. The prog does not pass r5. */
+SEC("syscall")
+__log_level(2)
+__msg(": .1234..... (85) call bpf_stream_vprintk")
+int kfunc_implicit_arg(void *ctx)
+{
+	bpf_stream_printk(1 /* BPF_STDOUT */, "x");
+	return 0;
+}
+
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
index 89b6a47e22dd..250fc0c7b355 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
@@ -27,15 +27,70 @@ int test_kfunc_implicit_arg_impl_illegal(void *ctx)
 }
 
 SEC("syscall")
+__log_level(2)
+__msg(": .12....... (85) call bpf_kfunc_implicit_arg_legacy#")
 __retval(7)
 int test_kfunc_implicit_arg_legacy(void *ctx)
 {
 	return bpf_kfunc_implicit_arg_legacy(3, 4);
 }
 
+/* The prog passes all three arguments of this kfunc. */
 SEC("syscall")
+__log_level(2)
+__msg(": .123...... (85) call bpf_kfunc_implicit_arg_legacy_impl#")
 __retval(11)
 int test_kfunc_implicit_arg_legacy_impl(void *ctx)
 {
 	return bpf_kfunc_implicit_arg_legacy_impl(5, 6, NULL);
 }
+
+/*
+ * The verifier adds 'r2 = aux' in front of the call. A jump to the call has to
+ * execute the new insn: the kfunc returns -EINVAL when aux is NULL.
+ */
+SEC("syscall")
+__retval(5)
+__naked void implicit_arg_jump_to_call(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 5;"
+	"r2 = 0;"
+	"if r0 != 0 goto 1f;"
+	"r2 = 0;"
+"1:"
+	"call %[bpf_kfunc_implicit_arg];"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_kfunc_implicit_arg)
+	: __clobber_all);
+}
+
+/*
+ * r0 and r1 are live at may_goto, r2 is the first register that is not. The
+ * insns that the verifier adds for may_goto are free to use r2: 'r2 = aux'
+ * comes behind them.
+ */
+SEC("syscall")
+__retval(5)
+__naked void implicit_arg_after_may_goto(void)
+{
+	asm volatile (
+	"r6 = 1;"
+"1:"
+	"r0 = r6;"
+	"r1 = r6;"
+	"may_goto 2f;"
+	"call %[bpf_kfunc_implicit_arg];"
+	"if r0 != r6 goto 2f;"
+	"r6 += 1;"
+	"if r6 < 5 goto 1b;"
+	"r0 = r6;"
+"2:"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_implicit_arg)
+	: __clobber_all);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index fa01a616af9d..bede3f48fe38 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1411,6 +1411,39 @@ __naked void widened_reg_is_not_linked(void)
 	: __clobber_all);
 }
 
+extern int bpf_stream_print_stack(int stream_id) __weak __ksym;
+
+/*
+ * The verifier fills in r2, the implicit argument of the kfunc. The call clobbers r2 and nothing
+ * sets it: if r2 is live at the head of the loop it has no formula.
+ */
+SEC("syscall")
+__success __retval(0)
+__log_level(2)
+__msg("loop header at 1, header_count is 4 ")
+__not_msg("can't widen")
+__naked void kfunc_implicit_arg_in_a_loop(void)
+{
+	asm volatile (
+	"r6 = 0;"
+"1:"
+	"r1 = 2;"
+	"call %[bpf_stream_print_stack];"
+	"r6 += 1;"
+	"if r6 < 4 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_stream_print_stack)
+	: __clobber_all);
+}
+
+/* to retain debug info for BTF generation */
+void kfunc_root(void)
+{
+	bpf_stream_print_stack(0);
+}
+
 /* The unknown SCEV of an unbound STACK_MISC slot must not prevent widening. */
 SEC("tracepoint")
 __success
-- 
2.55.0

