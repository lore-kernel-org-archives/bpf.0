Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5E3043DC
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892523; cv=none; b=ap34FbEYa7ymITS1YOyPaT3ytjmh/zo7P6QZqG4f1XPaPYJv854GMRRnFT2uDb1sZMh9yZZtG2eIzoArL0VJfRQ9GJXav3J2EgIZnjXP8hG7UGS4p8KUG5meQeCuvBRcbJAbcVBaCTBcjZuHBYbz0jKKppgjOjV6+Gac+h0kYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892523; c=relaxed/simple;
	bh=hZqYjalnQ3oB36bP9VnVvOamSthOYCDZolQRNQgU/4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7g530+kaF+XSwkXj/HGe/uU98GQoFX4U2ajPamX13a/Nei9WhOM1Zj+ddc0dkcgQf7OshTr8bCVk9n0EKreyoATDoVGymCA9hR2e1k5BMtyZiRDju+jFxOKhQcEz/HGpSEFx20dJ/BKih5XZ0QmI3LDVTTXZeKeb3feuXl8Ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvNY6InK; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvNY6InK"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so85810f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892520; x=1786497320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bthzd3MnwyVersyWHjaQE2MkQtKGY05aWxkDGqnkmlY=;
        b=rvNY6InKhlqQlk1goN/Y5VZEuym6YEowO/Nr7VquIJfhhB+jUSOrz0k1SlnhXcsoC6
         TIGYkbXW6PQHg0LjXyw1xXOF/3MRque/BuIySKSUWHHAHsQbFHT0Ck/KQey1J88qUY8j
         AXH2kBd0wWQ9o9BvGyFnRfXoLWMsMgqMq0BCF/q3fBPxdQJfwiUrYQiKuLchbbQ/AOPo
         Fffw2t3uO/9El1wChoAW04gYcWPUVmZnXcKNEpYR1hHkVJgpIt4xEroR80lTOD2BGy6c
         0lP1a7nCJAEoeiD+hau/kOGaAL0hBifgrrRvkspPI3Gkgs6hwDKFeTr7Izxw+B+h0KTl
         vPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892520; x=1786497320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bthzd3MnwyVersyWHjaQE2MkQtKGY05aWxkDGqnkmlY=;
        b=gdSVHQJ8gDs+mLpElGR/Yqb+4KC7Srk+l7nVM2KZJOw0PHRoKyaN2TVDxcrL4NVvi5
         iJL1CbY1xVK+4sFH3iL74B7GPAJDYe6yFe8UIv80wCXD0jgI36/dJjqELtLFhWem40LE
         R9YzEu4NWt3U0Z/U8ohvcc6dL4bjuJlZ3UhDprKj8syCq9OCXy/OEC43FDp9oXpQ+FfR
         /HExuO4tQr2kG39iTeqK+T5v6sPZqw6+rbrN/dw7FPYXWi315nQNuR40yf2G2NdhWeqe
         03V+TAP2j1QbqWvxlEuX0II25GGYdE40Fatc3muGBSZFZnPB5E0d1v9glbH57sNXwUou
         aIZQ==
X-Gm-Message-State: AOJu0YynsbFqLEsjzSWh18Wquzb2PSOJY49MEKAWKyK97r5qPeTCNsEv
	uZ9MP2+MShwgm+X9wncv2lirvtxI0eYTxM3WkLhDO9wRcWU/CICmZCJ/OMkeNQbM
X-Gm-Gg: AR+sD10qoqVYN+Cv9bqc7fIuLpb8WGjtQsIBohdMiem5c8jHN1tgBRi0q9+ejCDn6+6
	JkqbdauTgCMBq/oYOv7RwB++hNRRYKXzL8pxf3qze0VBBQI/Cy5L6qb51YmQLf4zjfWyzb20sC4
	OFSo49wPDl8GzYyMHGAIiZq/AOTVJ3zhG+sog7GxmQ3KOf6WSOwiZMrGJ2zv53go744wcgWaqD2
	IbH5Pv31VqjhuG7GgfpAEcS1B18JiMrFpEl8WFfTOguSiFvqt3543PwXSbN7hwVq/ySbAW0QoqL
	HnYr4S01CCCR3ZRsaTbVc52fthOdXIR4jpo7xa9K47cxA1APRsFwYOU3HG0mZlIs5LkNiV0Jdhy
	1Z0BHWg07DTj38GBVm4PmQYAVXg6mTCRvF83sSlJ6OW208Tl3Wz8KwY5259XKx8XT/mc/eYr8nP
	tT0WS5XpsC6ZPHabDoh2At+MCfq4YHYoRqf9C5NVVglA6qUGjmzW6AS3/bNREC5kKToccTWsLGF
	sE1/t37bPidIsBj/yuXhH9WBtwhTCUmy/V6EoEjvhv79up4Bdt8mgyArvSNrVXvP6ePbrCY7A5g
	LAaubDZ8FlhiL+4Cqy8zCuDtaP8=
X-Received: by 2002:a05:600c:840f:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-4994e7111e4mr26224405e9.3.1785892520230;
        Tue, 04 Aug 2026 18:15:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda45asm59509415e9.4.2026.08.04.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 2/6] bpf: Propagate async callback instructions to scheduling subprograms
Date: Wed,  5 Aug 2026 03:15:10 +0200
Message-ID: <20260805011517.1717238-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4528; i=memxor@gmail.com; h=from:subject; bh=hZqYjalnQ3oB36bP9VnVvOamSthOYCDZolQRNQgU/4A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz7X6wLudxfLLnDWmngtSUswW2sT68pjuhd2Bz46Ef mb/xJfUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIvUMfwzE30yv/l2d3tFuFfC DhbhpjeGc8SuuM6t4T7JmtLpGveOkeF/L9t0HkOznP8T07/2azpc3vzCvXfbl3tKWzOXprtKfmQ FAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Asynchronous callbacks are explored as fresh frame-zero verifier states,
so normal callee-to-caller accounting cannot propagate their instruction
budget to the subprograms which scheduled them.

When an async callback is queued, save the active subprogram IDs in a fixed
async_stats_subprog_ids array and record its length. Copy this metadata with
the verifier state. When an async frame-zero path finishes, add its inclusive
subtotal to every saved scheduling subprogram.

If an async callback schedules another callback, preserve its saved IDs before
appending the active call chain. This propagates nested callback work to both
the immediate callback and the original scheduling subprograms.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 31 +++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9de45ade473b..42fa464c520f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -447,6 +447,8 @@ static_assert(MAX_BPF_STACK / 8 <= (1 << 6));
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
+	u32 async_stats_subprog_ids[MAX_CALL_FRAMES];
+	u32 async_stats_subprog_cnt;
 	struct bpf_verifier_state *parent;
 	/* Acquired reference states */
 	struct bpf_reference_state *refs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88e7ea6fbe73..47f3791530de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1632,6 +1632,9 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->may_goto_depth = src->may_goto_depth;
 	dst_state->equal_state = src->equal_state;
+	memcpy(dst_state->async_stats_subprog_ids, src->async_stats_subprog_ids,
+	       sizeof(dst_state->async_stats_subprog_ids));
+	dst_state->async_stats_subprog_cnt = src->async_stats_subprog_cnt;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -2261,6 +2264,8 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 {
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;
+	int i;
+	u32 cnt;
 
 	elem = kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT);
 	if (!elem)
@@ -2293,6 +2298,12 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 			0 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
 	elem->st.frame[0] = frame;
+	cnt = env->cur_state->async_stats_subprog_cnt;
+	memcpy(elem->st.async_stats_subprog_ids, env->cur_state->async_stats_subprog_ids,
+	       cnt * sizeof(elem->st.async_stats_subprog_ids[0]));
+	for (i = 0; i <= env->cur_state->curframe; i++)
+		elem->st.async_stats_subprog_ids[cnt++] = env->cur_state->frame[i]->subprogno;
+	elem->st.async_stats_subprog_cnt = cnt;
 	return &elem->st;
 }
 
@@ -9818,9 +9829,9 @@ static void account_processed_insn(struct bpf_verifier_env *env)
 	env->subprog_info[frame->subprogno].insns_own++;
 }
 
-static void account_processed_insns(struct bpf_verifier_env *env,
-				    struct bpf_func_state *callee,
-				    struct bpf_func_state *caller)
+static u32 account_processed_insns(struct bpf_verifier_env *env,
+				   struct bpf_func_state *callee,
+				   struct bpf_func_state *caller)
 {
 	u32 insns = callee->insns_subtotal;
 
@@ -9828,16 +9839,24 @@ static void account_processed_insns(struct bpf_verifier_env *env,
 	if (caller)
 		caller->insns_subtotal += insns;
 	callee->insns_subtotal = 0;
+	return insns;
 }
 
 static void account_current_path(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *state = env->cur_state;
-	int frame;
+	u32 insns;
+	int frame, i;
 
 	for (frame = state->curframe; frame >= 0; frame--)
-		account_processed_insns(env, state->frame[frame],
-					frame ? state->frame[frame - 1] : NULL);
+		insns = account_processed_insns(env, state->frame[frame],
+						frame ? state->frame[frame - 1] : NULL);
+
+	if (!state->async_stats_subprog_cnt)
+		return;
+
+	for (i = 0; i < state->async_stats_subprog_cnt; i++)
+		env->subprog_info[state->async_stats_subprog_ids[i]].insns_total += insns;
 }
 
 /* Are we currently verifying the callback for a rbtree helper that must
-- 
2.53.0

