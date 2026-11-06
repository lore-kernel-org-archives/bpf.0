Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937291;
	b=m6VFeFdKYbWUqtkDYk6fUieU5+KAAQ+Q5POYVXfBqON2CdZsXKsmOxHP0txOM8oCcqQf
	 QyCdcVT+Wif1PgYZ2OyGULLwxf84sjuEZFCsOrTJsV0876JYstvX0olyatLG9HWvDBn5f
	 1kIrWPncgv0aFLzoXgC4AD8/o7kX22d4d/POb4Essm59oqWQXhEDHIXzjG7C7KqKpnjfV
	 wtMVSbUf4YahVD7cRuNPQ9YNHn8k3D2z+ApcRzH+ZXgWU1yUD+YhFM7ySnZjHJ31HDuV+
	 A6TKCIONHSf+AdpYymRAlM7ZRgj0up60QuItwltOtM4ubMDscm7NEpCg/cl7XjEaq/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yRXpNLSwI4L/aXFgo3ajNKOoEJFlHpztBLKeyqRa1CM=;
	b=Oc/m62ZiqO6LPB9la0Eq4xMzXHzzJeOmeIBtOd5h3ccQLYma9rW+TJo+TO0fpAlslBwI
	 MNiMMPUul6A4X0jQ/tSsfWxWgJlKuYihua+6Lcmxlsutqp+TfASTOosCJYnCrdVIJRNJ9
	 eM8ZnF9XATgdI3TrdtQJHoC5n4p64pN7NhoDO/2YABLZHlkfaQ1AU7/tw0Sh1ouJQFLvn
	 G0MQwbQ7rMX4udCbk+cmmDMwHdMDOg1MHr4x4nq5w0uXmRrVHzB6f8KckbeGRvMVrgvD8
	 uDoq6i6z6aQ5D4Zejb4fLIlm3uDf63zGJrUnS0C1Fr5BYUbhGTyvEAz1Z58OK5lq+IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irDCAsjk;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A1606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 248A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irDCAsjk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso121719a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937290; x=1794542090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRXpNLSwI4L/aXFgo3ajNKOoEJFlHpztBLKeyqRa1CM=;
        b=irDCAsjkjTkmjOpHSZqgJ4AqtFt8I/NVCoEc1oe7GuJ06aCAYAHHNGzC9MonQhqhgo
         QQho+Cr1PqXmSgfvsJ+5gwD6CdGlXPB1SWb3I6kl9j84qNRhXPr9TIciIZOCrR7ZCJpc
         w4hVxRDUklwa6qEYQ3gTVQC5hFgMLgkQrReI0hDLrMDazzkPkJKShSqD3sV32O9FqIEi
         D5wIlpmscCXnPLaOVgfWMOAymlSD+oSZQPpvBhXjm+EmnkeIIN3YzVSIjtEIuMi5iXpl
         TLpLlnjUCFgW2EPloxWGeyP/Gjzm54hMdjvZy66E95ptAE64REK6R/d+yEYsAUuVZL/W
         WcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937290; x=1794542090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRXpNLSwI4L/aXFgo3ajNKOoEJFlHpztBLKeyqRa1CM=;
        b=rbkxsVoBkDAs+Lld7eOOZTbzPbWBmWphb3GwitTL5rVj0TI1Xa0VvICOh144kU6NW/
         eH7TfaWQz9I2xNgokp3GM3dZI+AHp5d8DNXs0QJPYwwnxoTA2VmYJwxRAXH6yKwtdOcl
         moSZwIz8YJzkRNeWl2TzoVhCdgQv8dT+MaObosLC9ZoxDTCVIfnjT2UwEOFFwjZg9t6W
         ZnpwqqoLonnZN8bVEICseXcTqSWoPhBIOLK0KXHNzbCZtzh4zk4KCXMCUnFG01mdHVdL
         TEQVd8k+F1UvEZd6UiP5uQeQ9oHZdstbbyHK1QialF02I8oAYbXHYTQWaQEI2YstKcEL
         8P/g==
X-Gm-Message-State: APuU4Z9p5HeFr2Nw3OfB+hCXr5aoD6ZK524amOkigpHGpFuQ40g7X11T
	yWKWwNsxysl1CSIEw4h4/jrMYAm+DCMMEY5y6BIBWyfB16gGH1aQ+KgCOBQKWg==
X-Gm-Gg: AYBFou1ayZLE8kVgoJGEpKz259XEEP8GEEnBtuCSCVv2XAJC9SD5VnK+/ZvBmU0UHt1
	QUbU9KL9cb1aXNxJ5LcCZ4rgtkroFpsAPoe/nEfsaIo1kn1hPLOBWxCGZxjNB2Vg6pubxbQS18c
	ylCjyEbLw2hNvCYrMCLTt8FpJaUaker197mi1CLaVpkSxgBChTPw1laRoreWl6nSGtv7bNnzs5m
	IQub4IcesyrrDogpKvkBg39MI43ZgfUYtdoCfGIgeLERJc6GdW77S/kxFAaynEsVvOmCDc4dEV4
	TZKimtNvDnijMmGnjZ0DGACumdASchoWLfcOLNyo4gExqpUMNwynh0N+03aFjfYsGwvu3dLZVOX
	o/E2ibT1b5v88nKHNJriWE4mcs8ef6v/sb7MTnuCTGCdl/XIl+dUuzq++4NPIMxj2UXzqFoUWGX
	U91JnA/7538lI0IglI+sZ8IUWPS+A8rJ6t2OqNqR8qiWZ3N1xNXbR6gmxXCsk8SoSPDWghjTs08
	QQoiodrDh6fxcYXyDI299/EydrQTb672fFeVMPvPSJQfNHzdl5/mC5NVyNhDz6I3Vq2hTJ3io2v
	u/f8EgrTY34wYVEO/QXN5BrCGOW2OuUWve3Jx3NTKxb4+kW+cTsS/jaAVq7SG/uCPJdBqsT/rjm
	bbevbtBbJi8THxbSymhvFgXDZcDj4TDFaOOdu/HVd11mwC11JzJOUSNNvtVE4yxsS3+iisVkaxq
	w=
X-Received: by 2002:a17:90a:d606:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3b0db70db23mr1231735a91.52.1793937290439;
        Thu, 05 Nov 2026 19:54:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d78b0a7fsm1584526a91.1.2026.11.05.19.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 37/45] bpf: What a call returns in each iteration is like what the loop loads
Date: Fri,  6 Nov 2026 03:51:01 +0000
Message-ID: <20261106035111.3315285-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  for (i = 0; i < 20000; i++) {
          sum += a[x];
          x = bpf_get_prandom_u32() & 15;
  }

x is loop-carried: an iteration uses what the iteration before made. The
loop is counted, and too long to go through its iterations one by one.
Scalar evolution knows nothing about r0 after a call, so x is not known in
the loop. The prog loaded before states were joined:

  math between map_value pointer and register with unbounded min value

A value that the loop loads from memory in each iteration is handled: the
first iteration is verified on its own, and tells what the value is in the
others. What a call returns is made anew in each iteration in the same way.

Give r0 after a call the expression that a load gets, with a parameter that
tells the two apart. A call can return NULL in one iteration and set a flag
with it, so a loop that is short enough is still walked first.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 0cbf158dae6d..507235ad6d76 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -852,8 +852,11 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		break;
 	case BPF_JMP:
 	case BPF_JMP32:
-		if (opcode == BPF_CALL)
+		if (opcode == BPF_CALL) {
 			forget_call_regs(e);
+			/* made anew, like what is loaded. The parameter tells the two apart. */
+			return replace_reg(scev, e, BPF_REG_0, expr1(scev, OPAQUE, 1));
+		}
 		/* for non-CALL there are no changes in register states */
 		break;
 	case BPF_LD:
@@ -3196,14 +3199,15 @@ static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
 
 /*
  * Nothing that @id is computed from is what a register had at the head of the loop, and
- * some of it is not known: it's made anew in every iteration.
+ * some of it is not known: it's made anew in every iteration. @call: by a call.
  */
-static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
+static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id, bool *call)
 {
 	struct scev *scev = env->scev;
 	bool opaque = false;
 	u32 order, regno;
 
+	*call = false;
 	scev->stack_sz = 0;
 	expr_stack_push(scev, id);
 	while (expr_next(scev, &id, &order)) {
@@ -3213,8 +3217,10 @@ static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
 			continue;
 		if (is_reg(scev, id, &regno) || is_op(scev, id, UNKNOWN))
 			return false;
-		if (is_opaque(scev, id))
+		if (is_opaque(scev, id)) {
 			opaque = true;
+			*call |= scev->exprs[id].params[0];
+		}
 	}
 	return opaque;
 }
@@ -3344,7 +3350,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
 	u64 until, false_until;
-	bool same = true, walk = false;
+	bool same = true, walk = false, call;
 	int err, i;
 	u32 r;
 
@@ -3547,15 +3553,18 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 		/*
-		 * What is loaded from memory in every iteration is the same kind of thing in all
-		 * of them. One iteration tells what. There is nothing more to find out when
-		 * iterations are looked at one by one.
+		 * What is loaded from memory or returned by a call in every iteration is the same
+		 * kind of thing in all of them. One iteration tells what. There is nothing more
+		 * to find out when iterations are looked at one by one. But for what goes with it:
+		 * a call returns NULL and a flag is set. So a walk comes first for a call.
 		 */
-		if (expr_is_fresh(env, header_env->reg2expr[r])) {
+		if (expr_is_fresh(env, header_env->reg2expr[r], &call)) {
 			__set_bit(r, iters->fresh_regs);
-			continue;
+			if (!call)
+				continue;
+		} else {
+			__set_bit(r, iters->forget_regs);
 		}
-		__set_bit(r, iters->forget_regs);
 		/*
 		 *	for (i = 0; i < 40; i++) { if (i) sum += prev; prev = (x ^ i) * 3; }
 		 * It's not set in the first iteration only. That counts if the loop is not walked:
-- 
2.55.0

