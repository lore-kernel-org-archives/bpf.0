Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207823;
	b=cHqxT3el/YvhGbpOQm2HmsmU2dnLVBezldGxG8IBb1KDcvx8ZNL53r5dxaqhj2iY5rLL
	 eet5+84laX6f0pfyJCHklEUtqAaOiguXu8sbjlRY5A+Lk8FzizenkMrAwRGUQkCfuxyU4
	 HomfZoU/s854Y61E0KStWoyZXP2KmNjx3PgzkX0+GRrtdOr8P5c7HOkZKCJwhh9HAAgBi
	 5K4WO2JvlibDJzxxTfhZm9IGXgupAutEUlHCB7E0fhEb9Gs3cV1/AV4sLUY4ZsC95eYfh
	 ypc+bZI7uBV+rbNv9OnuZqfwqsKJurH7Htooi7DYJhM2dgonLyCBdxchINFg60XZITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VLJ1XBlNSkWvsjZ0XQdvM+6zwNGWNhklV+C/7l41o0U=;
	b=et21T7Luy43vuZaaKF91EOIhEfYtxax0hP2B90fmhJaWWGMM3VjltxNUnt0fc5/M2kDZ
	 ItnNhqNBF3PJ4wuEqb1oSoMyfhTp4TgZ1lk8JKk0ccCbKurrIC9XjoPnirfowB1Iebwco
	 GkFCHAi6Wqp51nT+aVZQ0pjA98lvAWgJs+v5sTIj31va8U26uH9xsyacoTiK7pxlKLcZf
	 98zAhXwe0SiSTLmxCccIZJIGk2O+N8XudRUX04Sjqa2X/KRFpr6J4kVtMczR2F+0J+Mpd
	 U6K33NMqqgYP0xDGZaCqy0SmhKSa6DLmyIxGiUcmen91+OynqjHXSrgTq+0oTIN/VUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGV12+hd;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE0606A690
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63AE0606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGV12+hd
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f04bea9a93so9096685ad.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207815; x=1795812615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLJ1XBlNSkWvsjZ0XQdvM+6zwNGWNhklV+C/7l41o0U=;
        b=GGV12+hdKagp2GylvVGDSRdRwK4NR7JB77EARyecLCB0yVfbv3w+iQJ2ch/bBOBTe9
         b+cdWFDoTUVzyLfknIP7S9nboQSP4622NkeHsRNbhsaoqJ2l6Zd4ihQoH/u0e5ZlFs/r
         GqP7fHPfG9kX2KfqGYMHrvas+BL7S92Uv6J0pcLOdYq/kaRarDidJxRc1uSOxF1SeZX7
         V5dvdzwu/fB5NIilLsToCqyvj3iZFR8d+dPKnGN2ZsI+aTXHSYpLp9dj+uk9lQ78aSX6
         Cpwv/MZ2WxDPhH8XlY5IVEMb7FHMrG2lQ4A7Nfs2ARysGBZGhXsGWEPIIjKvxS5w6ptU
         xJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207815; x=1795812615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLJ1XBlNSkWvsjZ0XQdvM+6zwNGWNhklV+C/7l41o0U=;
        b=gGsWmO0hrbDKvPU0j/yREfs3i7IvYUcW1fXmYtiHUT3EG9PGrXWsCNVs5jGpH0JoRG
         uk6u1EeRnY1V61t23kmpTV19AOfIWio4/oaxdS06c+ZGZ4+7jLMMvbUTpOXxrMAFrtWU
         5qPrchf2WcVSMEWIfDEofgAT2O6CBBnhA8WPwVa0K5jpN0rL51H7+hdC3na9lA7gYvJi
         5wjUwLhqd49cnY8A6su7lbgz0IVF/jPokJKQx03SpV14sLsnB1yc857MoHLD5P8loWci
         ZvjKVeoS8zKokToqMq7ZuUDUny4c83rWcmXaNCHzjPF1+v5fiqRK1pSlLzVkFc6iAkef
         AkqA==
X-Gm-Message-State: APuU4Z/avNyXJ9+VRP497PsEtkgBs4X5H8LwC/JYTT60g5EGUAiRXej7
	a7eKsauKZSPM6B71Crps6Kaho646H1rnCaUh7SuSsULp0LGD1mzLkyJ3TiFeQg==
X-Gm-Gg: AZFdTZc2Y/Dh5fyW25KjeMB3e75pXaQq3pARVSz/o4llS1U2ApkO9KeB1Ofpt1ZXTgw
	GIN4E19Z1bdpIS9cPQyn4D+8bX59j49E2xN+eJ1C/cCeswY+G6uLgniBQqIdzTVqrY9wnbmIt3q
	n+XimI5v6qHvQ6voFlx3pwdYirhzqaApLqcfmnEAAhzdB+mx2236Q6VssMDTxR2/s3DSuvxcP1S
	Cb7IKm4/afITRfO1TUmE2VYKOVdwVFe3uxmvuqAToAqo74FTJG+aIQg8a2UUtOg2+FGnBU48pmV
	QYnDZD0yvsz/ZtkLLFWxmAPZcYj2JMgUWmfca2sWpwm4F90tF4vgU4WPGTgW+/te+pT0nHmhqZd
	oCW6ftLYseMVNUlSYG/WZ7euJJzBnuc8OIuBQcmYi9Hwvvz9xVmvJdk8Ge39TktUX7nPzGdc3y3
	xA6eCABCoc1NRzQT5zAhiFNsgeq0R8bAT2KahhqL3vKqOFPUvVyEWXt6WLQxDh++df10Dh4ZBWP
	L+o2WffXVl96eqXuY2OOCJGe5ELwMnkrdJ4dceExdvoTderLJMU4O19WvL4AOJzbI31++siDrx1
	q/8fvy3tFDf2ynDaUIk5U+fdFBpC9Cyk/gx0UTVPx8mrFrIkbde0BgIaUUOQZzBIvGGgsAPyJ+o
	bj0vUWDdeg1+9KyA+CHm5VsZgEySGyPOlCnQ8BqEQZyTWV50b2q5BMB5f1kiHgM/vqSCwBCsouQ
	==
X-Received: by 2002:a17:90b:35c3:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3b41c959689mr4085598a91.42.1795207814570;
        Fri, 20 Nov 2026 12:50:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm8457729a91.16.2026.11.20.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/49] bpf: Make stack liveness faster
Date: Fri, 20 Nov 2026 20:49:10 +0000
Message-ID: <20261120204959.614908-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

compute_subprog_args() follows the pointers to the stack. Each round
visits all insns and joins all slots, one by one. Most of that work
finds no change. Do only what can find a change:

  old                              new
  each round visits all insns      only the insns whose input changed
  first visit: join each slot      memcpy()
  later visit: join each slot      memcmp() first
  half slots to slots: by bits     by words

The fixed point is the same.

                                load time, ms
  program                       before   after
  pyperf600                     222      124
  pyperf100                     126      64
  strobemeta                    153      116
  profiler1 kprobe__vfs_link    18       8

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index cfa416f7620..d78a8ee0bbf 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -752,11 +752,19 @@ static int cmp_instances(const void *pa, const void *pb)
 /* OR the 8-byte slots touched by a half-slot (4-byte) mask into @slots. */
 static void half_spis_to_slots(unsigned long *slots, const unsigned long *mask, u32 nbits)
 {
-	u32 slot;
+	unsigned long x;
+	u32 i;
 
-	for (slot = 0; slot < MAX_BPF_STACK_SLOTS && slot * 2 + 1 < nbits; slot++)
-		if (test_bit(slot * 2, mask) || test_bit(slot * 2 + 1, mask))
-			__set_bit(slot, slots);
+	nbits = min(nbits, FRAME_HALF_SPIS);
+	for (i = 0; i < nbits; i += 32) {
+		x = bitmap_read(mask, i, min(nbits - i, 32));
+		x = (x | x >> 1) & 0x55555555;
+		x = (x | x >> 1) & 0x33333333;
+		x = (x | x >> 2) & 0x0f0f0f0f;
+		x = (x | x >> 4) & 0x00ff00ff;
+		x = (x | x >> 8) & 0x0000ffff;
+		slots[BIT_WORD(i / 2)] |= x << (i / 2 % BITS_PER_LONG);
+	}
 }
 
 /*
@@ -858,7 +866,7 @@ static int print_instances(struct bpf_verifier_env *env)
 struct arg_track {
 	union {
 		s16 off[MAX_ARG_OFFSETS]; /* byte offsets; off_cnt says how many */
-		u32 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
+		u64 mask;	/* arg bitmask if ARG_IMPRECISE. As wide as off[] for memcmp() */
 	};
 	s8 frame;	/* absolute frame index, or enum arg_track_state */
 	s8 off_cnt;	/* 0 = offset-imprecise, 1-4 = # of precise offsets */
@@ -912,7 +920,7 @@ static void verbose_arg_track(struct bpf_verifier_env *env, struct arg_track *at
 	switch (at->frame) {
 	case ARG_NONE:      verbose(env, "_");                          break;
 	case ARG_UNVISITED: verbose(env, "?");                          break;
-	case ARG_IMPRECISE: verbose(env, "IMP%x", at->mask);            break;
+	case ARG_IMPRECISE: verbose(env, "IMP%llx", at->mask);          break;
 	default:
 		/* frame >= 0: absolute frame index */
 		if (at->off_cnt == 0) {
@@ -1100,12 +1108,18 @@ static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target
 			       const struct arg_track *out, const struct arg_track *stack_out,
 			       u32 nslots)
 {
-	bool changed = false;
+	bool changed = false, same;
 	int r;
 
+	if (!arg_is_visited(&in[BPF_REG_FP])) {
+		memcpy(in, out, MAX_AT_TRACK_REGS * sizeof(*in));
+		memcpy(stack_in, stack_out, nslots * sizeof(*stack_in));
+		return true;
+	}
 	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
 		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
-	for (r = 0; r < nslots; r++)
+	same = !memcmp(stack_in, stack_out, nslots * sizeof(*stack_in));
+	for (r = 0; r < nslots && !same; r++)
 		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
 	return changed;
 }
@@ -2078,8 +2092,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
 	struct arg_track unvisited = { .frame = ARG_UNVISITED };
 	struct arg_track none = { .frame = ARG_NONE };
-	bool changed;
 	int i, p, r, err = -ENOMEM;
+	unsigned long *changed = NULL;
 
 	at_in = kvmalloc_objs(*at_in, len, BPF_VERIFIER_GFP);
 	if (!at_in)
@@ -2090,7 +2104,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		goto err_free;
 
 	at_stack_out = kvmalloc_objs(*at_stack_out, nslots, BPF_VERIFIER_GFP);
-	if (!at_stack_out)
+	changed = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	if (!at_stack_out || !changed)
 		goto err_free;
 
 	for (i = 0; i < len; i++) {
@@ -2123,9 +2138,9 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "subprog#%d: analyzing (depth %d)...\n", subprog, depth);
 
-	/* Forward fixed-point iteration in reverse post order */
+	/* Forward fixed-point iteration in reverse post order, over insns whose input changed */
+	__set_bit(0, changed);
 redo:
-	changed = false;
 	for (p = po_end - 1; p >= po_start; p--) {
 		int idx = env->cfg.insn_postorder[p];
 		int i = idx - start;
@@ -2136,17 +2151,17 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		err = -EINTR;
 		if (bpf_must_abort())
 			goto err_free;
-		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
+		if (!__test_and_clear_bit(i, changed))
 			continue;
 
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*at_stack_out));
 
 		ti = bpf_head_guard_target(env, idx) - start;
-		if (ti >= 0)
-			changed |= arg_track_join_all(env, idx, start + ti, at_in[ti],
-						      &at_stack_in[(size_t)ti * nslots],
-						      at_out, at_stack_out, nslots);
+		if (ti >= 0 && arg_track_join_all(env, idx, start + ti, at_in[ti],
+						  &at_stack_in[(size_t)ti * nslots],
+						  at_out, at_stack_out, nslots))
+			__set_bit(ti, changed);
 
 		arg_track_xfer(env, insn, idx, at_out, at_stack_out, nslots,
 			       at_stack_arg_entry, instance, callsites);
@@ -2162,12 +2177,13 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 			if (target < start || target >= end)
 				continue;
 			ti = target - start;
-			changed |= arg_track_join_all(env, idx, target, at_in[ti],
-						      &at_stack_in[(size_t)ti * nslots],
-						      at_out, at_stack_out, nslots);
+			if (arg_track_join_all(env, idx, target, at_in[ti],
+					       &at_stack_in[(size_t)ti * nslots],
+					       at_out, at_stack_out, nslots))
+				__set_bit(ti, changed);
 		}
 	}
-	if (changed)
+	if (!bitmap_empty(changed, len))
 		goto redo;
 
 	/* Record memory accesses using converged at_in (RPO skips dead code) */
@@ -2210,6 +2226,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	err = 0;
 
 err_free:
+	kvfree(changed);
 	kvfree(at_stack_out);
 	kvfree(at_stack_in);
 	kvfree(at_in);
-- 
2.55.0

