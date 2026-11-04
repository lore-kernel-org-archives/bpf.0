Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829352;
	b=1Tiz925VTInbfSGhuVx8sNtnTAJE2sEju+GmBtxgZhJX+T0FcZs3Ic4FKMkIFN83gBpj
	 HD3zcrFbBgE4s70RmLQPpMtkgSKt2wWt5ZfxLD1p5NI8iNbZXwVsdXR/Z/s5NEzTcLBjL
	 h4UfvrzfHLB7mcpUhNt5S43VjHKPlAWDYnn7x3QZFAPfW4YtAAVpMoIg6cEWCnsiMDgCG
	 Jya0S5MyuNnUDe66aIcwjNs8GbUnfUoBCxRgU7j/35ae2G2B0LwNsf1VkrtuEfkQ75jcM
	 l5uqbq5HCIE0T9PcJRswgT4jHbFcvQb4K2IzxpgOEkMpXT+Auis/YGUmEAZGmfk4TTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CLH+gkcupWvdv/n8h1E1rvITAJKLDoH+q0KF3kccNDA=;
	b=pjHKto8gAH+wNF5Avq2sz/WHQu+e0748NBO11zqdPHCAIGgdUvR/vql91HGEAmQo50wb
	 t+3P8ZRPDBIWqDIkDEzsDc2Ju84LDCxG/MDIA6wfQ1m/SGgg7hriCDKDs/HDKTZEuAL9K
	 GC6hOYA3GpVEq5DmEBr41rQ+z+CHbAntHNFHlcTQfrZWpYcoOW0UYKe0xPOED3AU85mZP
	 BJ9Ar+PxMsV1uBQcZ3AkZFwZ/qK60cAueGcgNiTnsYKG3sxQGjBvJp8YiHYWtW7ZumUj1
	 sDA7BiTBxMjVLGTtMyj2J86+FRNnFgBAL7mVRWtyc0II4WyhjsklX81QaH0F1kXrE1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SAfEMLjY;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA86074938
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFA86074938
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SAfEMLjY
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc502d509c0so521833a12.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829351; x=1794434151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLH+gkcupWvdv/n8h1E1rvITAJKLDoH+q0KF3kccNDA=;
        b=SAfEMLjY+LtRhjjyZuhsGS2+c1Lw6gCf4qwp8SUylokZ61yYKb7Ast1ge82aqgmBZH
         DEYEDtO74o1+lAxR1mnsoABgFIPXf97IbQyk6wH5zJNAioA7I2GK2FoZHo5UNprzn3sm
         XirFcpHmAIefhbHq3VqExvkg88Nt3Qry6odP4Yvf19iNJlyxGXN/HLgEJ5zBHFcbvpGU
         zpybVm/LrB46zSN2SHr6IZzpuBEahKwKVE78YzslgCsVYXX0nYgXviPBYWVe73Y3rTBj
         AonqqOqHpqp92xuJ6PUm/zcRTjPScsyP+YxVar2IabqGjlcRuXlzADps2x3Hw/SWx+Z9
         DClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829351; x=1794434151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLH+gkcupWvdv/n8h1E1rvITAJKLDoH+q0KF3kccNDA=;
        b=l88Db5BIGz4RU52f6HTML8QHkoPeRe1bxbGajzlBoV2t2R9cpyzOq5Rhk/ef7ZV6B5
         x1Hz89f8zmH3Xq719U9ND4XhbSU8MiGSq2ejwj1gJABWhRElQN5ImZzDHfdP8aTiBlye
         Kq/FSlqFF5QGIMevGPFO0QgvH5AGzZMmqpgwd6wPKTaDKjWb+5yW1HxgiCZqQKuYMG9U
         +JGJQTCrWN+ztSeYSlIVQB1r7sRbRDaFiQ+MJN37M3HCvbjzpYmHk6npwQ5Q+y/mDxMU
         7VySgcAp91b1Hdbf2gosjCsVzMz758gEyOieYrcoAmm1iZ7UK6nEuNHzgFW/2J3fjle2
         BpNg==
X-Gm-Message-State: APuU4Z/xPto+0lD5GDvTlXzOMzyOSGhoxoSD1rAIni3wLnzIIb8UUzr3
	4d7MH/W6XYILou0X+S1Vp1LDAkKQs7IvRkj8n3+Ek3zCF5I1Y182k8nzsEujIw==
X-Gm-Gg: AYBFou0g8M9/QtdR4kcXKD1cwcpl4uEqq/FvLAYmU9wytyT3ir2pY67pdo357YjPGmR
	nERPvWi+J4GlV8OMzRsaXmtjFcSICLsvTVdyrmSIpYercsYJfdZ3GXcOz5nHBZskLb8HY1YqVMC
	j0C7HQoRZZ7kXeAbgi6akkxekI7v7P8quxVmbUWFxrO6zFRBg524uRkoFfsKYEc902KulFVEND2
	qBINJFzOw94OZMf07bzV7PxdYyqG0l4uf0c2aL11qveh2iJxXw0BfOZEzyR4o76nTHVCtnfQQbt
	k766FOlCdvPIOT2GXFaU1mFlbT4mSJ2ezOamszsaBXJaDKvd6dXPUmuyMFTqohDth7EAa6Qeu7V
	QJQTGQ7K5Hh8cwrWHT8kEPgUlW42B0rrmoLYLcSf54wljdeet1V1dWtz8fZUNAm4RV16qDrRT64
	FLq56ffA2L5iGJLqx3wSFSjsm/3ysnBYHmODX7GflUnBCAZxhzd7U3BZfpy5MXrbbTkz1nG/you
	DLShwmjgwETxIEW59VmPr9OhspWzbGlU/K8+h8+PdxTkAVFwa5eEcmCTnwDp+288xBO+wWdvgbQ
	z9xZ2AHqzlS9kuWUtMxApaKfzjeFjfxxEWlHOpR6lsbwKlItQG9yBdvhLQTU3n028ZyC5lueJM6
	dxfTQ+03HQFggWClotBvUwydO9UN7yDTOhCclda6u8NC47E1ee5903p23TOCoIWoOutj6sQyt/J
	fB
X-Received: by 2002:a17:90a:c78a:b0:3b0:a9de:9880 with SMTP id 98e67ed59e1d1-3b0a9de9c2emr972674a91.33.1793829350948;
        Wed, 04 Nov 2026 13:55:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b6507sm729213a91.16.2026.11.04.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/9] bpf: Use the call graph to find callbacks that take a stack in arena
Date: Wed,  4 Nov 2026 21:55:18 +0000
Message-ID: <20261104215523.1852636-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

The kernel calls a callback and knows nothing about r12. So a callback
takes a stack in arena at its entry, like the main prog does, when it uses
r12 or calls what uses it. For every subprog that uses r12 the walk of the
chains of calls marks the nearest callback among the callers.

In the call graph the need goes from the callee to the caller and stops at
a callback:
 - A subprog that is not a callback counts on r12 of its caller when it
   uses r12, or when it calls a subprog that counts on r12.
 - A callback that uses r12, or calls a subprog that counts on r12, takes
   a stack.

  main -> bpf_loop() -> outer_cb -> bpf_loop() -> inner_cb -> A -> B
                                                  takes a        uses
                                                  stack          r12

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76f4e1f238ba..3e80e60f9883 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5810,6 +5810,7 @@ struct bpf_call_graph {
 	unsigned long *live; /* what the kernel calls and what that gets to */
 	unsigned long *in_cb; /* callbacks and what they get to */
 	unsigned long *tail_calls; /* subprogs that have a tail call */
+	unsigned long *arena_sp; /* subprogs that count on r12 of the caller */
 };
 
 static unsigned long *subprog_calls(struct bpf_call_graph *cg, int s)
@@ -5838,13 +5839,14 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 3) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 4) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
 	cg->live = cg->reach + cnt * words;
 	cg->in_cb = cg->live + words;
 	cg->tail_calls = cg->in_cb + words;
+	cg->arena_sp = cg->tail_calls + words;
 
 	for (s = 0; s < cnt; s++) {
 		for (i = si[s].start; i < si[s + 1].start; i++) {
@@ -6008,6 +6010,35 @@ static int check_tail_calls(struct bpf_verifier_env *env, struct bpf_call_graph
 	return 0;
 }
 
+/*
+ * The kernel calls a callback. It knows nothing about r12. So a callback takes a
+ * stack in arena, like the main prog does, when it uses r12 or calls what
+ * does. The callbacks below it are not its business: they take their own.
+ */
+static void mark_arena_stack_entries(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	bool changed;
+	int s;
+
+	do {
+		changed = false;
+		for_each_set_bit(s, cg->live, cg->cnt) {
+			if (test_bit(s, cg->arena_sp) || si[s].arena_stack_entry)
+				continue;
+			if (!si[s].uses_arena_sp &&
+			    !bitmap_intersects(subprog_calls(cg, s), cg->arena_sp, cg->cnt))
+				continue;
+			if (si[s].is_cb) {
+				si[s].arena_stack_entry = true;
+				continue;
+			}
+			__set_bit(s, cg->arena_sp);
+			changed = true;
+		}
+	} while (changed);
+}
+
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
@@ -6060,15 +6091,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tailcall will unwind the current stack frame but it will not get rid
 	 * of caller's stack as shown on the example above.
 	 */
-	/* The kernel calls a callback. It knows nothing about r12. */
-	if (subprog[idx].uses_arena_sp) {
-		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (!subprog[tmp].is_cb)
-				continue;
-			subprog[tmp].arena_stack_entry = true;
-			break;
-		}
-	}
 	arena_depth += subprog[idx].arena_stack_depth;
 	if (arena_depth > env->max_arena_stack_depth)
 		env->max_arena_stack_depth = arena_depth;
@@ -6233,6 +6255,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	ret = ret ?: check_tail_calls(env, &cg);
 	if (ret)
 		goto out;
+	mark_arena_stack_entries(env, &cg);
 
 	dinfo = kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
 	if (!dinfo) {
-- 
2.55.0

