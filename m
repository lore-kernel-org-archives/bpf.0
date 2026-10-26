Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984021;
	b=j00xsqqRIICM3uAmU86zCMzX0eN6Yb+kYGFdS5FdSqof7vWKdfHeRJ7w6YRG4hnQ7vHq
	 p+2WNNDNL+sbS6MDkUGfcjiBHQj7w/qvlZl0EdSUyoXq+3+UaOIGtMCvHy8iBtdKBExbj
	 qpoPzgOyPnacADh6ATy0RTDohfVD2kCERzv16qJwSmyKhnFodhHlMeabS/XNDO8j4hVsZ
	 HZKNgdjR2VM4lXx9tsCNVi3Sb0q3qjrilF2UC9a8V22hjRf8ynlgNBIiGlvRL1MtAwLq9
	 AZh1ImgVyicZRTic9IgWobwNmsbK95A/Sm1OF5OjaZUszMR9WLyaNLIAfnOKA3Z0pvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+E4W0GEVKy1+iqP3GPD1h7yXYqPQZpaTL7bO9u9x+hc=;
	b=N3H2CVI3plmNKVTBciY5a2jzeNY2Uf8p+WeZ8DkKHYImcxiiZzMinH3s3+7TkFOyaTlx
	 MG9cjzd/FrlJf68kJcafijrKSFSBMOCWZDLSbHj/CyX4YeWDXog+bXt/P6asvH4sr45F8
	 eVzMEPg6qe9JnLU/9tR1hWrLULPDebjjoRBD/7m3gS1c+R9AXovjZxSyU4HbKFdGpUXHl
	 LLIdEcL6IWileZq6HCxyAjSSIi8KQTsGMg9AIWEHD9b1IgLpdNDzKMZwal3mtf9hdKIzv
	 li8GUBWv4pdaZpq857gRml67G5k3QK7H13NRQqnj19Xb+sDnzwK4nSetN2gqZHnigHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=anty9zKc;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC245606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC245606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=anty9zKc
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1165012a91.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984020; x=1793588820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+E4W0GEVKy1+iqP3GPD1h7yXYqPQZpaTL7bO9u9x+hc=;
        b=anty9zKcs9ZATK1nfVi6GK2t7cuk7m2Ftt1lCucQC8O6GobzQw+xo8P4j614/A4H0g
         XWrMduVO6fusu0PXEP986LwVRMWSwME2Q+MqoNRVRZAlBuPJZ4eF1+sj1WuhNiplGwOL
         3SYGeRfPE1xKTh0dhqrdH9MkAHlTi/XddFiESfqZrIAYcXIs9uPWOu1CoQQwO0XV5TJW
         WqfxwmgWRwFSM0qg7alzjcJaHRSFozMxAlEj7TPCDI9pt/DKPDMg4vNhDxMXIAxwAhcC
         ekmIxebndV1tlgpUaUN8ikBv3UtH7xa9y0Z1sXvh11s/Uqmf5HuMayYLRuzZmUXgtS0/
         DYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984020; x=1793588820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+E4W0GEVKy1+iqP3GPD1h7yXYqPQZpaTL7bO9u9x+hc=;
        b=iDrWu1ItDt9aJAMnczRbqf+r4ZYTlIaVUcB0uFi61AQd/Pd4Wrnztlr0Oi9JP9y6H2
         aOELfSspdylZw0Qd7jRDhz5L6We18LZWJk7tDSS+tl8TDREVLDB1a8UaXKxoiirQlyw8
         s8GakaAuFKqb6Y4FDwiMlX1fwQqaj91bML84kp3sFybsKCD+sPndC8aMLH7quioFbxQc
         sQazaKTq8JAeXNl1yaOplyfgJnj798pHDf92YMpBTi+JThBAu7HVdkDOMU6qETJuxYyA
         1SDKERvrLrd+oO/F4V3a/ZFJuoFQcDy7B8usdzvfQ1LiOA2kT4hORXne1nGwnhyBMklX
         ku5w==
X-Gm-Message-State: AFq9FYLBNxoq/6s4s9Pb/LKfEg/Zu7gDt5u9IZvefYNtdZYbMLVEMjNu
	3nqN/7/MQUclCGN++B1KNyAlWEdHOs/DPvBGUY1eneZkR/16YdcAPNjYiQIoDQ==
X-Gm-Gg: AYBFou0iyh3s9ZoFamZ8+vQmwMll0l5I+NyiEi60JhRJ/qIY6hx6EBDWNAYK6r71KfU
	qfHRMH04DEDlrdnnDFXSnG1RUcU/oPNBfsk3zck+b/aWDphrKwwnFGCXIGecIKXytx4BSmb/pVc
	Ak+oS7JrOcyVbdtcXVJPwL5I6IBK+LyYl/AAcNrHzYG7h3YX0giIPopnJkaOHPMz0orECqe6HZY
	hFBho3ObSAquGcUdzH7oNsECDo/qRgbuEYt33vA/vbFK6EfRniZQpgNzv/q9JUMZVVwj5apB62j
	EwbxhUKis4UZ8+K/rOQMtC0AigOmdDyEw7CC6Ek1FM8jyZyYsxbh1vcmuTYVfZQAWXlyVzjIsIf
	zwUKLp7LHAAS4XU68eqc4m85d4c044Hp76zBEHnDDESo96PNRuI/7HPXjROH7xK5NBma8NxNjCo
	c8f7widj4aAsSKQuyYliOLowvC5IPqihRX9Zr7Dc4NrIRdUAV9pb/hzplr1A0KuiSgAcB0n+fUD
	QzQThESSHsCI8yfx1puCb29w+o5pt/nLr1vWZbsuald1IgSi2opOy2kuMqWXGdEN8n2QXCri5Mo
	S8R/TImQjztFCBzrK1xbpZGl8TAZIJ9pgdMhbFU18VtYHe0dvB++KW6JyHRUgMBQJphSc535b6x
	5RnWloBQBkZ+9xIrbG5f3PxQC
X-Received: by 2002:a17:90b:1c03:b0:3ab:2737:3392 with SMTP id 98e67ed59e1d1-3adeb0fc676mr4717989a91.53.1792984020158;
        Sun, 25 Oct 2026 20:07:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba47266sm4003971a91.1.2026.10.25.20.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 74/81] selftests/bpf: Adjust tests of recursion
Date: Mon, 26 Oct 2026 02:59:35 +0000
Message-ID: <20261026025943.404450-75-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier rejected recursion, because it cannot calculate the depth of
the stack at load time. Now a prog with recursion loads, and the kernel
limits the recursion at run time. Each recursive subprog starts with a
check of the stack and of the number of calls. When the check fails, the
subprog returns 0.

  test                                    the recursion          result
  --------------------------------------  ---------------------  ---------
  callx_unbounded_recursion               never stops            returns 0
  callx_bounded_recursion                 counts down to 0       returns 0
  callx_mutual_recursion                  two subprogs           loads
  callx_rodata_recursion                  pointer from .rodata   loads
  recursion_via_global_func_and_callback  global subprog and     loads
                                          bpf_loop() callback
  calls: recursive call. test1            a call insn is its     rejected
                                          own target
  BPF_PSEUDO_FUNC reference to the main   the main prog is a     rejected
  program                                 timer callback

The verifier rejected the first five progs. It continues to reject the last
two, with new messages: "calls itself" and
"recursive call of the main program".

Other changes:
 - MAX_CALL_FRAMES is 32. The two chains of calls that must be too deep get
   16 more subprogs.
 - "calls: conditional call 6" is a loop that can spin forever. The
   verifier rejected it with "infinite loop detected". Now the verifier
   adds may_goto to such a loop, and the prog loads.
 - callx_retval_is_tracked and callx_precision expected "to caller at" and
   mark_precise lines. The log does not have these lines. Expect the values
   of the registers.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_callx.c      |  22 ++--
 .../bpf/progs/verifier_callx_rodata.c         |   2 +-
 .../bpf/progs/verifier_global_subprogs.c      |   7 +-
 tools/testing/selftests/bpf/verifier/calls.c  | 101 +++++++++++++++++-
 .../selftests/bpf/verifier/pseudo_func.c      |   2 +-
 5 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 7e59188d9fca..5594bce7601c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -245,8 +245,7 @@ __naked void callx_scratches_args(void)
 /* return value of the callee is tracked */
 SEC("socket")
 __success __log_level(2)
-__msg("to caller at 4:")
-__msg("R0=6")
+__msg("4: R0=6 R10=fp0")
 __naked void callx_retval_is_tracked(void)
 {
 	asm volatile (
@@ -523,9 +522,9 @@ static unsigned long self(void)
 	);
 }
 
-/* unbounded recursion is caught by the main verification pass */
+/* unbounded recursion is stopped at run time */
 SEC("socket")
-__failure __msg("frames is too deep")
+__success __retval(0)
 __naked void callx_unbounded_recursion(void)
 {
 	asm volatile (
@@ -551,12 +550,8 @@ static unsigned long countdown(void)
 	);
 }
 
-/*
- * The depth of the recursion is known to the main verification pass,
- * but recursive calls are not allowed regardless.
- */
 SEC("socket")
-__failure __msg("recursive call from countdown() to countdown()")
+__success __retval(0)
 __naked void callx_bounded_recursion(void)
 {
 	asm volatile (
@@ -603,7 +598,7 @@ static unsigned long pong(void)
 }
 
 SEC("socket")
-__failure __msg("recursive call from")
+__success
 __naked void callx_mutual_recursion(void)
 {
 	asm volatile (
@@ -926,11 +921,8 @@ long long vals[] SEC(".data.vals") = {1, 2, 3, 4};
 
 SEC("socket")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 11: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (8d) callx r2")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("5: R0=3 R10=fp0")
+__msg("8: (0f) r1 += r0                      ; R0=24 R1=map_value(map=.data.vals,ks=4,vs=32,imm=24)")
 __retval(4)
 __naked void callx_precision(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 6cf58ca9ac5b..85141cd73298 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -571,7 +571,7 @@ static unsigned long selfcall(void)
 }
 
 SEC("socket")
-__failure __msg("recursive call from selfcall() to selfcall()")
+__success
 __naked void callx_rodata_recursion(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 574b26b5a7df..9f5898feb437 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -556,12 +556,11 @@ __noinline int global_calls_loop(int x)
 
 /*
  * loop_cb_calls_static() -> static_calls_global() -> global_calls_loop() ->
- * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion that the
- * main verification pass can't see, because it doesn't follow calls of global
- * functions. None of the functions use stack.
+ * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion through a global
+ * function and a helper. It's stopped at run time. None of the functions use stack.
  */
 SEC("?raw_tp")
-__failure __msg("recursive call from global_calls_loop() to loop_cb_calls_static()")
+__success
 int recursion_via_global_func_and_callback(const void *ctx)
 {
 	return loop_cb_calls_static(0, NULL);
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 0af237c02ddf..330421e9c164 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -559,8 +559,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "infinite loop detected",
-	.result = REJECT,
+	.result = ACCEPT,
 },
 {
 	"calls: using r0 returned by callee",
@@ -812,7 +811,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "recursive call",
+	.errstr = "calls itself",
 	.result = REJECT,
 },
 {
@@ -1325,6 +1324,54 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
 	BPF_EXIT_INSN(),
 	/* P */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P1 */
+	BPF_EXIT_INSN(),
+	/* P1 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P2 */
+	BPF_EXIT_INSN(),
+	/* P2 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P3 */
+	BPF_EXIT_INSN(),
+	/* P3 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P4 */
+	BPF_EXIT_INSN(),
+	/* P4 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P5 */
+	BPF_EXIT_INSN(),
+	/* P5 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P6 */
+	BPF_EXIT_INSN(),
+	/* P6 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P7 */
+	BPF_EXIT_INSN(),
+	/* P7 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P8 */
+	BPF_EXIT_INSN(),
+	/* P8 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P9 */
+	BPF_EXIT_INSN(),
+	/* P9 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P10 */
+	BPF_EXIT_INSN(),
+	/* P10 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P11 */
+	BPF_EXIT_INSN(),
+	/* P11 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P12 */
+	BPF_EXIT_INSN(),
+	/* P12 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P13 */
+	BPF_EXIT_INSN(),
+	/* P13 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P14 */
+	BPF_EXIT_INSN(),
+	/* P14 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P15 */
+	BPF_EXIT_INSN(),
+	/* P15 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P16 */
+	BPF_EXIT_INSN(),
+	/* P16 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1387,6 +1434,54 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
 	BPF_EXIT_INSN(),
 	/* P */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P1 */
+	BPF_EXIT_INSN(),
+	/* P1 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P2 */
+	BPF_EXIT_INSN(),
+	/* P2 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P3 */
+	BPF_EXIT_INSN(),
+	/* P3 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P4 */
+	BPF_EXIT_INSN(),
+	/* P4 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P5 */
+	BPF_EXIT_INSN(),
+	/* P5 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P6 */
+	BPF_EXIT_INSN(),
+	/* P6 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P7 */
+	BPF_EXIT_INSN(),
+	/* P7 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P8 */
+	BPF_EXIT_INSN(),
+	/* P8 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P9 */
+	BPF_EXIT_INSN(),
+	/* P9 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P10 */
+	BPF_EXIT_INSN(),
+	/* P10 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P11 */
+	BPF_EXIT_INSN(),
+	/* P11 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P12 */
+	BPF_EXIT_INSN(),
+	/* P12 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P13 */
+	BPF_EXIT_INSN(),
+	/* P13 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P14 */
+	BPF_EXIT_INSN(),
+	/* P14 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P15 */
+	BPF_EXIT_INSN(),
+	/* P15 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P16 */
+	BPF_EXIT_INSN(),
+	/* P16 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/pseudo_func.c b/tools/testing/selftests/bpf/verifier/pseudo_func.c
index 63c5c67d51de..44d36b01aa6d 100644
--- a/tools/testing/selftests/bpf/verifier/pseudo_func.c
+++ b/tools/testing/selftests/bpf/verifier/pseudo_func.c
@@ -30,7 +30,7 @@
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_timer = { 3, 9 },
 	.result = REJECT,
-	.errstr = "callback function cannot be the main program",
+	.errstr = "recursive call of the main program",
 	.func_info = { { 0, 4 /* main_prog */ } },
 	.func_info_cnt = 1,
 	.btf_strings = "\0int\0ctx\0main_prog",
-- 
2.55.0

