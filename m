Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160686;
	b=22q/mQ6wzd/KFmSzphs+GNbRWM8yoAblbRr/V/Ovrv6/8LRC6A4YArAGINe+oVj3AeVO
	 lBMcyKqTYA6LbszJ3DY/Zu2lngSreQJF9BnerCqdf2/lOQsVLW7Dqj2EzIGO4r9AKk0vq
	 bxYyQ/pDUC6qsVv/vlJs5h3Kk+WZbvIfYvCP1VND3OH6y73YevwTlGOnFcQdhCh7cP1gB
	 cMRAcbXmddo71qalBLN3BNvJLziHoTQVO91tUl1msw7Qvfs2227g2LW0u/+5O6uP6xblE
	 vXBY8NdepVH++PQSVmdqRI4XRvqNTnLA0UF5BdK3ZGWKbqgLDLAfG8rW+JI4YWl2U+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tva8V1Cz5rk3d/SOOn7/3s3to/fCdFZhGBMYJNuzth4=;
	b=4hcRKEXnY6Jtbq4qApYN2waJV0c1uxEsT7UAvecWwrEAsKbwlKEeXdVJoJv9peDy1zDz
	 Gm/Ii2mbaABOZbZRLmq5MjjXcICAWj0hjESleZ8FfTy4hyj4DokAGLcAR8SssYIsX8BaM
	 L6FLXtrUmP1btsT3P/aqvtNI4jxWtAAQNUvcRbK/JrrVePpkBGNLeImurY0KC8h2W+Kz0
	 jeKs7OV5X9DJHTgZ2pG5kkQ0Drshi5CpDlsrpDwdHiqlcak/y4xNnAbOmIUf51RojNUAo
	 uRtRLGOxFPT7NzpuBmmCXIAWsJxgHgoHSPJWFibJqB/TAGCbUbOpF8bgcoFLLdP6Clg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLqjaLGZ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA99606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA99606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLqjaLGZ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f03eeda984so2923615ad.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160685; x=1795765485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tva8V1Cz5rk3d/SOOn7/3s3to/fCdFZhGBMYJNuzth4=;
        b=tLqjaLGZxRzcYNTflwCxqPw79nXDvckuJagvR4fLz4WkiIMqw0EfO8Ej6h2VVURl4R
         yC8piibxAMw+GYWCHANg7M46Mrfz1GMSO1Ca+ikHw/DfaKPrTwNrmS0ksu+Wx0x49joi
         SXZWtYfd0tMgBCS7skCjoCKMuvQRPwpB+y8fomsG6peuw5AjPCfU1hKjzdorczT+X9GB
         fGKm7kA80tBPkwyaTZlNSwk7YNzTXfdxGGnX07MaltOSePMH/rhtUKry9HQXWJ0T6Htf
         Xb94MxxTWedyzj4Q2mV1vjnUT7hCrNI+/OXzOOJcgCC6h8QqD0VgZmBjQaCwlLmeQQmn
         l94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160685; x=1795765485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tva8V1Cz5rk3d/SOOn7/3s3to/fCdFZhGBMYJNuzth4=;
        b=Xk9ZakvBxtMXSjwXjx5ls3jV33p3xnB1qVWhkq543ewxwZ5J+ksx/qkIPCVrW9jilP
         v9LHYSvgJi8hQ12PNZY31+8fr4FenQjlx/XuuGZmYfgPBJH23EpGI7kFYOHKfgcjk9oc
         ba0p3+4bKm8DrN9/MJllbafoPm1cik0V/eEhJzTacCuMyrhANwa/nNtkdKD242vli4F1
         dlI/KN9M8how5Rqq7nC9jXhBKetuGk+1sUKij6BB+6OpzctJlauzG+zT1It6UHR4kM+c
         XjGoDPDXB23qMH5QZuwdSPzcPsrdjEmBAAJPAi9bhVMQZIC1JVZFpSOvM3zfjRHgm3A8
         q5Bw==
X-Gm-Message-State: APuU4Z8WzJRpg/v/ort+u40Kbg0hqNQbgUjqkKQ4xMH65QPMJnnbOxvt
	tHzouXQgflG2w2kIfzLCryaBp4Zn/BxRlzx3Mnv4MTo4WmTe8QhC3ltYLQUc4w==
X-Gm-Gg: AYBFou2JsHB1IgpvusdA2Sw/mIeqIUhyE5RjUOBCrG+GDygjgnBiLucoU0GwSeJcKum
	aiGTGkQSNyG5HNdlYc/NgqQo6qpZRwc/cO+AbTvARds0Z28SgdNsTl+35hr51GNTXedoGcR4FBr
	RKVQ6tabQ+p6rfglnqoPN1QP9qh8baRtPVcsLTCPyiCareRDW5b6HXOe+kJoBXQbgyXraTaXXtN
	lkV4hyNqvshNXM/lL+bHOZL66BD/vlQ1QpNrsVbyuGkgv4LY8Mr6g0onpPFLfgXwdOs6s3CWCaw
	7jtihhZeL1jvnymSTeiDWBlC4VrSjpv6TZsScnsi4cGPpoCqQvz/3yWSVjwjsJDAa2OYTFE2ENc
	HLoROfkQIrV222sSlI1HVWnrIrrDy/uUJHnrsYg7gJybYwNIlPHrLnIhqgZcXhMfIWxNi1biOAD
	QrCtXejaoJYdpjyC+TFhaK546Q7u/o2Fya9t9cxgswx1EkaRBpckpzCEWaj9MokYydFxkWJ92B7
	Kg6dwCPO5JFtbqkn2a80bhvHYYhneIFe2bHPYaj7+CVF4Y4xLTRi1Vs1HprxyCStcpA1y0jqKoj
	5oTXD4zWLWjwwx//i/G+3M2rxiZD2SDvcSakM3qVWLDqeVRBl9yUykt1/V64sgr/QKUAByVGh3v
	EKl3+MOrULkUe2PQH1yeSjxmWBNlZl/TgvxuyYhuqh0r7aPGtYxZylOrEp+5mN2+9wNshZAlA2Q
	==
X-Received: by 2002:a17:902:ef45:b0:2ef:d7ed:80dc with SMTP id d9443c01a7336-2f03f1e0d55mr23863255ad.49.1795160685201;
        Thu, 19 Nov 2026 23:44:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a69sm10246215ad.18.2026.11.19.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:44:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/49] bpf: Make stack liveness faster
Date: Fri, 20 Nov 2026 07:41:34 +0000
Message-ID: <20261120074430.2704488-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/liveness.c | 60 ++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index cfa416f7620..bd186d3c201 100644
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
@@ -1103,9 +1111,18 @@ static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target
 	bool changed = false;
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
+	/* a change pays for the next visit of @target too */
+	bpf_add_cost(env, MAX_AT_TRACK_REGS + nslots,
+		     same && !changed ? BPF_COST_COPY : BPF_COST_XREG);
+	for (r = 0; r < nslots && !same; r++)
 		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
 	return changed;
 }
@@ -2078,8 +2095,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
 	struct arg_track unvisited = { .frame = ARG_UNVISITED };
 	struct arg_track none = { .frame = ARG_NONE };
-	bool changed;
 	int i, p, r, err = -ENOMEM;
+	unsigned long *changed = NULL;
 
 	at_in = kvmalloc_objs(*at_in, len, BPF_VERIFIER_GFP);
 	if (!at_in)
@@ -2090,7 +2107,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		goto err_free;
 
 	at_stack_out = kvmalloc_objs(*at_stack_out, nslots, BPF_VERIFIER_GFP);
-	if (!at_stack_out)
+	changed = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	if (!at_stack_out || !changed)
 		goto err_free;
 
 	for (i = 0; i < len; i++) {
@@ -2123,9 +2141,9 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
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
@@ -2136,17 +2154,17 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
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
@@ -2162,12 +2180,13 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
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
@@ -2210,6 +2229,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	err = 0;
 
 err_free:
+	kvfree(changed);
 	kvfree(at_stack_out);
 	kvfree(at_stack_in);
 	kvfree(at_in);
-- 
2.55.0

