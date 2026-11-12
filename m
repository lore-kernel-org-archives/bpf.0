Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498821;
	b=d/mKcTYkFO3RYll3WaQdZ+0Eji+gYhPHgmuCFFSapMNCu7ymMReHQrfGf2Ygh6Lpxudu
	 o9TXmDMfn3MI5vjXkorjXDQ7hPWNRGSvykU9hkUCdL/LYx6tA3ECakLuPulI8UsWyjcbt
	 ox7d63qYkGI7bZcsN0pbyE0PYVs2U0ObRVitI3iFYowt7GrqqXazWkTbsDke5fANzvDYH
	 SZkUiVNhPsdmQQsLGFzAOGMTicj4XH/eNZLaROtqmokKKFzSy9mElyTKSS6aaCwODApFp
	 UZzTWKAvrLeMxqN2l4HEO5/kEYvlPzJPGWH6ClKlb+9XBF9BTBdnqzmdJlERTft3jpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MbZ5i3HtmC4zgJjXWOcD7Ha9ELu0f/IBRuUiUOYx/VE=;
	b=w9DHrngzJ0jha3uFy5AOHc5zmBDIiCFcrMihGbXQHF0ubQyMuZZoHfit56f1ulcbGr3t
	 F8EOPpZp+2EFiotRxty+0jRSttkI0waSuuvA2NE8iUXSizQS4FFxl/GkJvHat8XXhS14m
	 cLLOvLJ9uKJoMOgO65I15kkIVQUVRGlaH5EJKmqyck5s/AvrJZxMu3Wdq6DkDBUtUALvc
	 dVYuXr0F27SsPSXo6H3y1aZNT+ECRcXcqXsSXiUX0o4fujW/0pkBmmyLJk6xgQjjB/6H6
	 P3FsFFPhEs9mEKyPJEa6Sg6Xwwe9eMEQmp9R7mXt7pqoIy7f8c0auyxwOSpKeaSbNrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ruCPzOsp;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB9606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EFB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ruCPzOsp
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1657865b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498821; x=1795103621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbZ5i3HtmC4zgJjXWOcD7Ha9ELu0f/IBRuUiUOYx/VE=;
        b=ruCPzOsp1ApbjcAELQb9wmZvfQxejfG6F4BdVR584Jn7QOh3rShAasQOXGhZsKt4fW
         VHxo3P9CXmIYr4U2FJWYBGXvD9Y0ftbgG48uIs3qpb2qQNLR1oYBWnjwear7sQOn5Pl4
         pdwWzhkFlmqSphmaARAjX2EKbJIahgqmYXvzpBGZJjwYLj4MIGN45k9izEeZapuh9Vhd
         oA3AYh+cHAzjARXeBbOqGWPeg9p8+RJ9FERIFe3Sg8nCxqzpGOrhwGT9mHuHYTvoqhht
         YiTxIYulVrr2PcvLZtQ7ditbf+3Q9tEyuiJ6fs5FdJ/l5D8viuDubwhG2RJRxHBg9sP2
         L3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498821; x=1795103621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbZ5i3HtmC4zgJjXWOcD7Ha9ELu0f/IBRuUiUOYx/VE=;
        b=bUCNt/aU9OYoq2D2Ck90rLaOn8oasbBNKZfm1rMHjX+kqZrz7r0BlaUrUk14+NPPUd
         xUaVDSsyeNImj6WLlxoDEUUZ8TJYs8wXQFZBznp4tLor0OcTsiFTHYdxKd0QUE9tfShn
         7x8/AMOe7ZZ32b8TvlFQwx1cRxZQUkedHYs8Fi/B7sJ2MmpvkcAWdk61a8RF11g09623
         XmSDyM5panYlhP96I242Y1d86e7dyZLKd9235riaQEnXHnBfBylidycjQdBzeqic+FdK
         9QO9909kM9eQUTeilbQjV3tyyyO7tpQ6w5/R9mP0mpb8/xEQzX/p03+sFgQlgT+wPItC
         kKNQ==
X-Gm-Message-State: APuU4Z8BZrqPVp0I6P/vl4/oUMXFGIhQMsxswdAr4u0BTBzyPajrDvto
	4qfMj0mGwNIr8pwwHItB/wO2wTZZ2m3QK5LjP3mieazGv7P/NZ58UodZT9CRug==
X-Gm-Gg: AYBFou09xPIV8INTKdK/cTS5V8In2RXn+f1REeOPZ84YgUCMnnIN4ty8WawVLF+fjt0
	B+mMq0bf8q+3ApUrp1MU9TTpn9y/3W4nLgm+yJhCUingB5YFnslEm1j9qPem+10B5atpA5cZOq5
	xMiAWBjmcWUjWoF13Bl0PmGxK8p3Yija1Nn+ONSGeVtqRAIQ7RupuZyJpxuNXiKGHse+17ubXL7
	Q76KNW2tdQTLKHunAGyUYWE7s97G2US47DYo/URdn2I41mVc0GHMYyDeYlXVx3mLDjG3rYOhRLL
	dQE8j/RR94LZo8JaEsRxmC3aWFvbPiO4/hf5v8QD0jCq/375Upk5CPPGhWIOmKeJZwA7QKoKkV1
	475VGtwnplcppkTBg7wfttC1cKNJbN4ylhWi/ksyenVnSnI0ktomwh3WYIE/sqtdAh1ELM8cbkc
	Qh3exzSQoglilsuWSjrkqFetWnN6npUpsv3ueuRDlEfxQ+SdYSoUXs9IjDpODPvOZU3jGLvRAcb
	IPNN1PqKZLamVzelhWuoavcXqX/8by0TDwybCJg4arxaiPWv6+ROaP6uU3J75c3s9hPUSIuNodg
	GcRdlV1B/x9cqV3VhK7nwer3m9ZrU4+N6eLDduw9bVhw1T+MCXch6hoE/6Wv/t8DTY9JPa/HwfX
	iWTRJwfF/hqj7bq0lik+zqDPvHkowRTxtpRqHbh+sHvkz9gf6nMxo61aVU1lmVpjNYdjbApb+yV
	Xt0nWG+8lxpfUbfjL6POwg
X-Received: by 2002:a05:6a00:4f8f:b0:8b6:400d:7cc3 with SMTP id d2e1a72fcca58-8bc1ca72d13mr5796067b3a.27.1794498820415;
        Thu, 12 Nov 2026 07:53:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3804980b3a.5.2026.11.12.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:53:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/12] bpf: Evaluate scalar evolution expressions in the state after a jump
Date: Thu, 12 Nov 2026 15:53:25 +0000
Message-ID: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Falco and Tracee (patches 1 - 2) give a helper a pointer to the stack whose
offset stack liveness loses. The whole frame is live, and spilled pointers
that no insn loads again keep states apart. Insns: recvmsg_x of Falco
13267 -> 1954, trace_security_file_mprotect of Tracee 17872 -> 8515.

The HTTP/2 parsers of the Datadog agent (patches 3 - 12) are rejected since
the verifier joins states:

	current_header = NULL;
	if (interesting_headers < HTTP2_MAX_HEADERS_COUNT_FOR_PROCESSING)
		current_header = &headers_to_process[interesting_headers];

clang computes p = h + (n & 255) * 20 first and compares n with 2 then. In
the joined state n is [0, 2]. The jump refines n. p was computed before:

	invalid access to map value, value_size=40 off=44 size=4

In releases 7.50 to 7.85 and HEAD, built as the project builds them
(clang 12), 264 progs of the HTTP/2 code are rejected. The 264 load now.

Today a jump refines 'tested register + constant' and, by a match of its
own, 'register + tested register + constant'. This series adds no match for
'register + tested register * constant'. It adds three blocks:
 1. Operations on struct scalar (patches 3 - 6, 9), as Eduard suggested.
    "bpf: struct scalar, and one backedge-taken count on it" left 66
    functions on a register. 61 of them take a struct scalar now: the
    reduction, the casts, the ALU operations, the widening, the refinement
    by a jump. scalar_alu() is the transfer function of an ALU insn,
    scalar_intersect() intersects two values that agree modulo 2^N.
 2. An expression can be evaluated in a state (patches 10 - 11). Scalar
    evolution has the expression of p: (+ h (* (zext8 n) 20)). Its ops are
    applied by scalar_alu() and by the casts of the main pass, as in LLVM's
    getRangeRef(). scev.c gets no arithmetic of its own.
 3. A value has a leader (patches 7, 8, 11), as in GVN. An operand that no
    op describes is read from a live register or stack slot that holds
    'operand + constant' modulo 2^64, 2^32, 2^16 or 2^8.
After a jump the registers and stack slots that have a tested register
among the operands of their expression are evaluated in the refined state.
'tested + constant', 'x == tested (mod 2^8)' and 'p = x + i' are instances.
What goes: match_linked_add(), the searches for the other operand, the add
of recompute_ptr(), scev_value_add(), the (zext32 slot) case of
eval_expr(), 'bits' of struct expr, reg_step_reset().

Datadog's progs that load. The 492 are the same code by clang 14 - 24:
                                         of 264  of 492  kernel/ include/
      bpf-next                                0       0
   7  the outermost common base               0       0       +91   -65
   8  'r1 &= 0xff' is a zero extension        6      12       +14
   9  scalar_intersect()                      6      12       +45   -26
  10  eval_expr() on scalar_alu()             6      12      +140   -47
  11  linked expressions are evaluated      264     372      +523  -189
Without patch 7 patch 8 loses the link of 'm = n + 1' to 'n = x & 0xffff'.
Still rejected: 120 of the 492 (clang 20 and 24, -mcpu=v4): 'h += n * 20'
overwrites the only register that holds h: no live leader. And of two
indexes tested after the add the first is dead at the second jump.

veristat against bpf-next, over the set in the cover of
"bpf: Find linked registers by scalar evolution, remove scalar ids".
Nothing that loads stops loading, 2679 more load. Tetragon's 1081 are
builds with -mcpu=v3, which is not its flag.
                     progs               load     insns   states
  Tetragon           81856    78221 ->   79302   -0.16 %  -0.10 %
  Tracee             35204    32465 ->   32841   -4.89 %  -5.38 %
  Falco             104434   103691 ->  103693   -3.87 %  -4.27 %
  Datadog agent     806923   779907 ->  780957   -0.08 %  -0.05 %
  others             77162    64444 ->   64614   -0.03 %  -0.04 %
  all              1105579  1058728 -> 1061407   -0.64 %  -0.46 %
In 33216 progs of the selftests, Cilium, sched_ext, katran, bpfjailer and
Rust no verdict changes. Rust: +0.46 % insns, base64_hex 22113 -> 37625.

The price. kernel/ and include/: 1503 lines added, 980 removed, 617 and
628 of them by the substitution of patches 3 - 5. Kernel instructions to
load Cilium, Tetragon, Tracee, Falco, Datadog, Rust: +0.7 % to +4.0 %
(patch 1 up to +1.8 %, 3 - 5 up to +0.2 %, 7 - 11 +1 % to +2.3 %).
mem_peak: +0.8 % to +5.6 %, nearly all of it by patch 1. Kernel cycles: up
to +4.1 %.

Of the 319 lines that patches 7 - 11 remove about 260 were applied with
that series on Nov 11: 140 of its patch 12, 93 of its patch 16. They match
two shapes. Both are instances of the evaluation now, so the matches are
not kept beside it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (12):
  bpf: Don't keep a spilled pointer for a read that sees only bytes
  selftests/bpf: Test spilled pointers that only bytewise reads can
    reach
  bpf: Don't leave map_ptr in the address of an arena variable
  bpf: Make the operations on a scalar take struct scalar
  bpf: Split scalar_alu() out of adjust_scalar_min_max_vals()
  selftests/bpf: Test a jump that compares two pointers
  bpf: Take the outermost common base of two linked expressions
  bpf: Treat 'r1 &= 0xff' as a zero extension in scalar evolution
  bpf: Add scalar_intersect()
  bpf: Evaluate expressions by the transfer functions of the main pass
  bpf: Evaluate the expression of a linked register
  selftests/bpf: Test the evaluation of linked expressions

 include/linux/bpf_verifier.h                  |   24 +-
 kernel/bpf/flow.c                             |    2 +-
 kernel/bpf/join.c                             |    2 +-
 kernel/bpf/liveness.c                         |  108 +-
 kernel/bpf/scev.c                             |  965 ++++++++----
 kernel/bpf/states.c                           |   14 +
 kernel/bpf/verifier.c                         | 1368 +++++++++--------
 .../selftests/bpf/progs/verifier_arena.c      |    8 +
 .../bpf/progs/verifier_bounds_step.c          |    4 +-
 .../bpf/progs/verifier_jeq_infer_not_null.c   |   33 +
 .../selftests/bpf/progs/verifier_live_stack.c |  143 ++
 .../selftests/bpf/progs/verifier_scalar_ids.c |    2 +-
 .../selftests/bpf/progs/verifier_scev.c       |  110 +-
 13 files changed, 1799 insertions(+), 984 deletions(-)

-- 
2.55.0

