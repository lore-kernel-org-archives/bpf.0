Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442126;
	b=U3FxB14bMudO0w3R5AfALshTfYJkE4kWtEmY79a4oBEFgKqr7KxqJX/0y2cg3YYai7uf
	 /8ICTcXHWlyBLxEUEnyE9kC97Xoo3B8YyxanYDCh8kwsyFO5f9a+B4bqNqkH55JnD6Jc7
	 mhamRcrsCdziL8njiOrvaUx0aHwvEhdOOM5+InmdcUTI88scCG+O/APXd/bjZBUBvYheh
	 R/CfijvBYyKcJ21Pn1pPEQqANovqLwJlyo7rxBlXLWgdQIqQfUICB2rv6Tg1yiWGH7tE+
	 3Y4IXcBQFiRs10/j2Vb+WgFfPikWynXFLPF8atJQzD/8+pPzehxWRVPESSHI4Dsq54w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8hsKQ3r04MWSm4MPAyXf+uKpXmvqJ+4Mr6jtiVLixwU=;
	b=ZkcXOXCa371qXSkd+2yWa1JeIg5N1VBhRyGWUIWC7mnJDs8k7nwvOeknUPstucHPuhR1
	 gfE9tHju+M6P7Ri280bZwP+DT7D/rXrdPqESVZyUZnhcx3bbXNRsmM3j0GRLlrGxq/aWD
	 MEcMnaobzYUkPipY3oNmNY/1Z/PC90jezgDmNTMfJHOvJBSlkYf7rMlzYlAwl0JLG1U8v
	 g1up6soFLzq+JDJDtF1hwuR0d6kWHXuO7RmYKbK9htl1OeruZFX26pDUXfMrz9nFtSoOh
	 XSGlEHcID8M8ma3TacUTBh06fvAQCl6XE383n4nQ1FQdu9rfanGQgRKYbaqslVrt9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5Tjc3dU;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF71606A324
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF71606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5Tjc3dU
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1487774a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442125; x=1795046925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hsKQ3r04MWSm4MPAyXf+uKpXmvqJ+4Mr6jtiVLixwU=;
        b=f5Tjc3dUt0kWiCU01TpXWBPzXzLuf8uu//z9CJHMpf0Uf8rDt+17L0izCOozjIsk/j
         +/fhDr409qxHFSV6wav9zmftfe1TlN2EGrvPU52vnca1hx0DO1UA3TkCK0brOmjBxtoO
         ntw/4c4HRrLlzevY+y5LNGvZ/977DKe4kVjpNeYaR64NfE0gUNI9sA6WgO4YobDXt1vR
         S6H4g3EdoEhm5kS3eG+zReKYhurAqu8vxfHB40yySjIf7hevNNmDVAXNr2qMiUbhaVxy
         L3GXkmTU1AmGLodQ0omQTf187CgH/khbykRQHi3yH54Ck6U59rvGKvsXNUXvv27pgbHB
         ZPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442125; x=1795046925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hsKQ3r04MWSm4MPAyXf+uKpXmvqJ+4Mr6jtiVLixwU=;
        b=KgwEzYHxGGhmiQYarfl0hYdtYigtH2yjjT9Wxm2USdzM0VSrU/cYDawOp8EJoyQ2O5
         weRdnQbJiy3iV2K7DUaPE0qFT6JEZ+bUX5iVETQHaR8u5kItRCVKTI/FMtBOlOEpLwqX
         3sLIKMN9Q6KsJBnT3cunyicqCScmevzK+Rkkga4YhcwMEIgscqUmXk94hm8HUtJ3CDXO
         MYOss0mfTVwB3WQrJMJ5DpxvAMDC2jqiNM7qpjzEnzFQbhieWQJdUbBXX0VZ8IyA/Or8
         uQ86D4ZuyUJXM5yLETbHw8kOLLs/TTzUNFaA07ouE1/27ouuke8plYUkqDBJxTkSTcEU
         47yg==
X-Gm-Message-State: APuU4Z+PgQiiy62AU/dKkISpUmkY+dQAR8bm/uzpq2odMPtvPzOUNV20
	uIRKBU9mk0DWSX5C7b+0oXYoqLR9mYu7Abmvqq13RIPsf70kQlC+P4R7Vd7Itg==
X-Gm-Gg: AYBFou18qmhD5aVU0zWy9k1fgwopy54aeNvZ58ofSiWqabCkPax3M8IaAPAGiNYJ2YC
	pVW9coSLDc1A8WPSkJ4Nu3WNM6uGYFravNUEfEAOFZG6K3kHqt/dqxZ2Zz87PdVpTV8V849BTsu
	XHCHsfvd59Q98MRvKSS4lsahTte9JruTazamPykB3Es9eVzWNGaJ57RO2n66Rbhi3n0Tf0GclpI
	vMk8lu/GpVZ5jeol3udX2ejteaTawQueEAtjs+Dnibza/plUhNOqgbQIxME1wJ2sTGpytAbqdKV
	v/sW5UWwT8GyzgvrNQskNpKL2tGwXkvF17s9jJN+D2mMn21GmMxsAizIUFXC6Engmtfu4/5v5X7
	+tPqb/gRZY70a7QB9hQr24Z4YtKb5OWN6Y4pWTl5AlwpVWcBNq7Og9MzTMjYpLZSYfS/sWbb7Dg
	ZLOY5tCCHVDCveJpUZAiRkuV5AxB+ny2QjtRaSFbh8aosdgRjPG5ewy1u92HAt91nLKf279iAqi
	i9wKETmZQW8fC+UOWhCOlcNO0EIxFeXOhTfB9qmtva866DWc/5hm8SCvMmxrrDevj3JHSmTwXkn
	/TJpNhl18sFm829+H0dau9WhcW8SwjUZhHlICkDfdLCHaxHDHFVI3IM+e3M+S/cX4IjrpICEbVN
	Bchp640/83JwC8JTkeAC7G70gR11CGZR7vdON5cVWDRzb+2r+ZRWDJfxO0CZBMadfX5EQQZ19We
	MlNHNmBz8X4YhcnIwqn6k=
X-Received: by 2002:a17:90a:e7d0:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b182f1ed7fmr3416770a91.24.1794442125332;
        Wed, 11 Nov 2026 16:08:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c4eea2sm1363947a91.5.2026.11.11.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:08:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 1/7] bpf: Don't WARN on a register invariants violation
Date: Thu, 12 Nov 2026 00:08:29 +0000
Message-ID: <20261112000836.3138846-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
References: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
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

  2: r8 &= 60
  3: r8 *= 7
  4: if r8 >= 44 goto pc+2
  5: if r8 < 34 goto pc+1
  6: r8 += 5
  verifier bug: REG INVARIANTS VIOLATION (alu): range bounds violation

7 * (x & 60) is a multiple of 28 and [34, 43] has none: the fall-through
branch of insn 5 is dead. The prog is safe, the verifier has no bug here,
and a kernel with CONFIG_DEBUG_KERNEL prints a WARN_ONCE(): a panic with
panic_on_warn=1.

The verifier gets to insn 6 with r8 in [35, 42], var_off=(0x20; 0xc) and
step=0+7. var_off leaves 36 and 40, the congruence leaves 35 and 42. The
register has no value, but no part of it is empty. After the addition
reg_bounds_sync() cuts the range by var_off to [41, 45], where no value is
5 modulo 7: now r64 is empty.

var_off, r64, r32 and the congruence are a product that reg_bounds_sync()
does not reduce to the end. reg_is_empty(), which finds dead branches,
compares var_off with r64 and with r32. So the verifier takes infeasible
paths with registers that have no value. That is imprecise, not wrong: no
execution gets there.

Commit 5f99f312bd3b ("bpf: add register bounds sanity checks and
sanitization") added the check: a line in the log, the ranges are
forgotten, -EFAULT with the test flag. In that form it showed bugs:
  92424801261d ("bpf: Fix reg_set_min_max corruption of fake_reg")
  44b7f7151dfc ("bpf: Add missed var_off setting in
                coerce_subreg_to_size_sx()")
Commit 0df1a55afa83 ("bpf: Warn on internal verifier errors") made it
a verifier_bug(). Fixes for it since then:
  6279846b9b25 ("bpf: Forget ranges when refining tnum after JSET")
  d43ad9da8052 ("bpf: Skip bounds adjustment for conditional jumps on
                same scalar register")
  efc11a667878 ("bpf: Improve bounds when tnum has a single possible
                value")
  b254c6d816e5 ("bpf: Simulate branches to prune based on range
                violations"), its log lists three more
  150aeba624e8 ("bpf: Fix REG INVARIANTS VIOLATION on speculative pointer
                arithmetic")
  84d326943649 ("bpf: Detect a dead branch when a range and var_off don't
                overlap")
Five of the six are about a dead branch, one is about a speculative path.
A new part of the product can add such states again: the listing above
needs the congruence, which is newer than b254c6d816e5.

WARN*() is not for what user space can trigger: "Do not WARN lightly" in
Documentation/process/coding-style.rst. Print the line with verbose(), as
before 0df1a55afa83, without "verifier bug: ". The rest stays: the ranges
are forgotten, and a prog that is loaded with BPF_F_TEST_REG_INVARIANTS
fails with -EFAULT: tests with that __flag(), veristat -r, a fuzzer.

'invalid base/step' keeps verifier_bug(): step == 0 or base >= step is
a malformed congruence, not an empty register.

Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9c6b1367a0b..5a30ce76da73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2355,6 +2355,12 @@ static bool reg_is_empty(struct bpf_reg_state *reg)
 				   U32_MAX);
 }
 
+/*
+ * var_off, r64, r32 and the line base + step * k are a product that reg_bounds_sync() doesn't
+ * reduce to the end. The verifier can take an infeasible path with a register that has no value
+ * while each part looks sane, and a later insn finds it out. That is not a verifier bug: no WARN,
+ * a line in the log, the ranges are forgotten. A malformed base or step is a bug.
+ */
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
@@ -2375,20 +2381,20 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 		goto out;
 	}
 
-	if (reg->step == 0 || reg->base >= reg->step) {
+	if (verifier_bug_if(reg->step == 0 || reg->base >= reg->step, env, "%s", ctx)) {
 		msg = "invalid base/step";
 		goto out;
 	}
 
 	return 0;
 out:
-	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s r64={.base=%#llx, .size=%#llx} "
-		     "r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx) step=%u+%u",
-		     ctx, msg,
-		     reg->r64.base, reg->r64.size,
-		     reg->r32.base, reg->r32.size,
-		     reg->var_off.value, reg->var_off.mask,
-		     reg->base, reg->step);
+	verbose(env, "REG INVARIANTS VIOLATION (%s): %s r64={.base=%#llx, .size=%#llx} "
+		"r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx) step=%u+%u\n",
+		ctx, msg,
+		reg->r64.base, reg->r64.size,
+		reg->r32.base, reg->r32.size,
+		reg->var_off.value, reg->var_off.mask,
+		reg->base, reg->step);
 	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
-- 
2.55.0

