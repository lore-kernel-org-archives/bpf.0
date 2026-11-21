Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288440;
	b=YcQhz7mFJe9ROHCS5fDCKlYKxGwItDcbD+nMEffW0xl7K9Q/tqWglBN2ZJAqnOC0g23K
	 P0IYOqZGk6hRgGjLWDchrb8kO9TcNuszo/v8+j5mxYs4XZ8o8qK6/C0wq7UJJWIN5+VNg
	 5R4EDU5RMZvnPBpCwUgDhzQT0BmP4Kqo0Gx2cHutnUych0rQlGSfVUVMjHtlqoI+bx5xr
	 TYUhpC0QTE//UrMtl4PDY47PnO/tmkbDF8jsmZLuSohCZM+FkCegHv9YKJje/8ljn21Bi
	 2UyaAjbMJn5rSZZmHjBqA7axX9n8ii6gHGnheqjWIVeB57BDqAA3cp2TtxbwtAgM3cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EoexMt72dYJ5peaesvybgitlxxqPRBDkF+xTLtb+tG4=;
	b=jYDXzOVlZV+8IIqQPybGCKyJu0SBC06vPz/wo+2NXXzd5Lnv7M0nNhLe8lvpqi2CAMbo
	 vw0b/fr3Dx30XqSkr5H2a48ybotighvDw+5P7jeeYst/HLbbJVC5S1sRT1wjH8C6ljMsd
	 VNDT40Dvmn/RVlbEwK/pf8BW7S2pECiCZ/LPY5v/x4GlO8FYFhcSST7EXkwPYD9VNNkOG
	 GHQe5YkObr2SCcSl8muTcJ9V4ArPgYySzOuHvGXtLtUoaS1zcVKU7+BO7PLTcYPG/FEgM
	 92/msedrkqDAI+IMDvIFq57OwSAjEhVHYlf55xo9ivocL/aZ1arQeN+1BBzdI6U8+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDSYXYzj;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB9606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BB9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDSYXYzj
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so1707698b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288439; x=1795893239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoexMt72dYJ5peaesvybgitlxxqPRBDkF+xTLtb+tG4=;
        b=MDSYXYzjXjm+VIhaEpZJAgEz+rbamzFdY3mY4vculEVu7aGk/VLIt4KKzmYe+57Xdx
         WieiAX2fCLDAry76z+oJsEtWDIrrCpA+G09vpJ++3I+Ws6Pdm3ecMrOTJdN8TSC5N00I
         ZQlulZ0yTBATXOiWGI7LuBPuZfmVRxAhDJRL+InM0ot3riPzswqCbiXIEuGz74ML66Qk
         rg8tT8uSBK1EBfm2PuspB25t92J27Wh/9W0KlOdzvEE9p2NEtJ7aTigaIKQTjxsmf5ql
         FZbMmHRlwoK2Fj6nFoHZXX1S6fd/Nea2a669eaDemjJ0fksJdXbad6Tqk6lWJjYy0nAq
         hjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288439; x=1795893239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoexMt72dYJ5peaesvybgitlxxqPRBDkF+xTLtb+tG4=;
        b=qSTaSJGO3DuJsGUKn3o6TK/6jioGxnI9yt+B/RX27m0cHy46hZvkR9K8pWTdiOSgcy
         sxCpwN5ISmBhIp5GxN32ZSOJLpNq8ry/yNVikfiuwC0UkF5TSRrhOD0rNmwqJ95cd0NL
         r9zQRbSpobINKb6ypM2MM/qILwbmbGi1vVV24MjIoR3VKqYAcZ5C/DzQcn8y9KHCWBJU
         Q0WSIrqFUZ+75X4qpYPpYvoaWnglAanvKEORiRvOtMYTGrMh4Bv0/bhU1HkM72e2ShbT
         2D3kx++QyLLDHnIWFgcWpRg0tjDUTXELySPgk/mpp3Ni3o75M4Lo8kDRUT+huR9QHATY
         tGAQ==
X-Gm-Message-State: APuU4Z/6EnmKVQvhqgbk89i9lSFJSx5Kvd2oMOc5cogVqeqbP+U2hL0H
	Q+WM43DDGvpd5e0/5WYqd1w/Gt77nxkkjwIXY+9IrhZvaRX5a9OSrkE/cGY68Q==
X-Gm-Gg: AZFdTZeUWAEBNn2zc6tVFZKVvkSx6oj6uw5yTp3IXD67LZe3jtuBDIbr/7a7SNSe5Xl
	r2rdmFZ/s2TlSic1CSRKvc4w7KOdQNy67O2EKChHWFkHhasuMNF42d7PkEHe6KNLaX90sS1Ks/9
	skhs5DXK7uSrOk2kAfYBg39KklMNS8Gb++VXqivZy/1jaHlW2J99h+Zdo5u0Py5le0JCiJ5AQf9
	3Rv6EDhijPEBImGPjVjBbRlBcAIv4p8LliL4UAD3uJsa7+5V6vLtZT0VLVYlUxcJneeUO6/UAF9
	R78eZZLmTwnva1z+5Z5vTuREyWr/9Bv5QR+QdVXth0UUQq/i/g1+me1PGygoXfAwfK2Cdusv5Al
	yoQWFJpJohjY7g7CFmtJohyVFQvP3+Qqth6Ug6nddPsvg7UnWXnw3pwtrtwz5gQ25BnXSXkjOHW
	AFQnIdP/gi8oDntFmNMthupdYTfTiCnrpAjxEEeUTX6ZJamtubmyYJRWEN9gV4NObBIzkuqPaIP
	TKNA+Avfvr2So4nDJNMb4GfUpxBx42MzlbeGv5xtY0G3T389a2N1VLpD/EB/wrXvGaD1h/u3kbw
	7r+FCT68sg2M5hP/PXusLqxYXuCdX3XoEEARHpdalDGWbaP+KoSWUmEiBbJFrt6GIEHAzEq5107
	m6A+Ry1/yE2myHSJ9ktwoYq/jMnl+j+eAJ38JcAbe+ENnZIITnW5uzOuaaak+Yz1+gbb8SFwgOc
	8=
X-Received: by 2002:a05:6a00:1703:b0:892:a8f1:c53d with SMTP id d2e1a72fcca58-8c87c2935acmr6365810b3a.22.1795288438908;
        Sat, 21 Nov 2026 11:13:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cb6640429fsm64970b3a.38.2026.11.21.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:13:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/7] bpf: Mark a skip of trips as a guess if the bound moves
Date: Sat, 21 Nov 2026 19:13:37 +0000
Message-ID: <20261121191343.3670609-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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

A valid program can be rejected. No unsafe program is accepted, because
the path-sensitive run accepts nothing.

After a pass with an error, the run looks for one path to the error.
It skips trips of a loop. It gets the number of trips from the step of
the iv and the bound, as if the bound stays:

  i = 0; n = 60;
  do { end = flag ? 60 : --n; } while (++i < end);
  buf[n - 30];

If flag is 0, the loop ends at i = 30, n = 30. At i = 5, n = 55 the run
counts 50 more trips and skips to i = 54, n = 6. No path has this state,
but the access to buf fails with it. The error counts as real, so the
budget of the next passes is cut. If the program needs more than that
budget, it is rejected.

Keep the bound in exit_threshold, which this run does not use, and
compare it with the bound of the saved trip. If it moved, mark the skip
as a guess. A guess does not cut the budget. If the bound is a range,
the jump moves one end of it. Keep the other end.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/equation_join.c   | 12 +++++++++---
 kernel/bpf/verifier.c        |  7 +++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7f9594436e..88b3a5226c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -456,7 +456,11 @@ struct loop_stack_entry {
 	/* an xreg: how many times the program came back to the header */
 	struct scalar trip_index;
 	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
-	u64 exit_threshold;	/* by the jumps that the state passed and that leave the loop */
+	/*
+	 * The trip index at which a jump that the state passed leaves the loop.
+	 * Path-sensitive run: the bound that the jump on the iv saw.
+	 */
+	u64 exit_threshold;
 	/* Path-sensitive run: the jump that tests the iv, the value it saw, the trips left */
 	u32 iv_jump_idx;
 	u64 iv_prev, trips_left;
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index a01f0fdc74..e601e3dda7 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -756,11 +756,17 @@ static void note_trips_left(struct bpf_verifier_env *env, struct loop_stack_entr
 	far_end = value + (step < 0 ? 0 : jmp32 ? x->r32.size : x->r64.size);
 	if (e->iv_jump_idx)
 		e->trips_left = step ? compute_trip_count(step, &far_end, op, jmp32, *bound) : 0;
-	if (e->iv_jump_idx && step && is_body_jump && !e->trips_left)
-		e->trips_left = compute_trip_count(step, &far_end, bpf_rev_opcode(op),
-						   jmp32, *bound);
+	if (e->iv_jump_idx && step && is_body_jump && !e->trips_left) {
+		op = bpf_rev_opcode(op);
+		e->trips_left = compute_trip_count(step, &far_end, op, jmp32, *bound);
+	}
 	e->iv_jump_idx = env->insn_idx;
 	e->iv_prev = value;
+	/* the jump moves the other end of the bound */
+	op = bpf_signed_opcode(op);
+	e->exit_threshold = jmp32 ? bound->r32.base : bound->r64.base;
+	if (op != BPF_JSGT && op != BPF_JSGE && (op != BPF_JNE || step > 0))
+		e->exit_threshold += jmp32 ? bound->r32.size : bound->r64.size;
 }
 
 static void move_bounds(struct bpf_verifier_env *env, struct scalar *s, bool is_ptr, u64 off)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e24c51a49..0b8063dbb3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21046,12 +21046,14 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
  *	for (i = 0; i < 100000; i++) { if (rnd() && n < 8) n++; }
  * Two trips show a step also for 'sum += i', and more than 2^32 trips also for a ring index.
  * If the steps are not constant, the skip or "infinite" is a guess.
+ * If the bound moved, the skip is a guess.
  * Returns 1 if it skipped these trips.
  */
 static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
 {
 	struct bpf_verifier_state *cur = env->cur_state, *old = &entry->header_state->st;
-	u32 period = entry->trip - bpf_top_loop(old->frame[old->curframe])->trip;
+	const struct loop_stack_entry *saved = bpf_top_loop(old->frame[old->curframe]);
+	u32 period = entry->trip - saved->trip;
 	bool infinite = entry->trips_left > BPF_MAX_TRIPS, guess;
 	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) = {};
 	int err;
@@ -21064,7 +21066,8 @@ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_en
 	err = bpf_jumps_see_same(env, old, cur, entry->iv_jump_idx, infinite ? NULL : iv_xregs);
 	if (err <= 0)
 		return err;
-	guess = !bpf_steps_are_constant(env, entry, iv_xregs, infinite);
+	guess = (!infinite && saved->exit_threshold != entry->exit_threshold) ||
+		!bpf_steps_are_constant(env, entry, iv_xregs, infinite);
 	if (infinite) {
 		entry->loop->infinite = true;
 		entry->loop->infinite_is_guess = guess || env->run_has_guess;
-- 
2.55.0

