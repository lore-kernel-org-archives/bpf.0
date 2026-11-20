Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172380;
	b=TMonPMjv8BPuVUDNFEX7SF0Xf/4O7n6x1sV2llcA5bno6OdjTw1rqZRxSSB8blZKYxRK
	 m5EI3mDm0EmwwwY1xaUC5lv5TV2/2oRn0Ovo97noUpASONSKA09HIeOEE2yn+3ayjK5JY
	 Ij9c1WDoip87PxB6XwEqmTi24xMQjHIYrboLKwg49+1hy1q7eW+1VdVDVGkDMqkHVMzcZ
	 pDHgjjnkwJz5cYG63aw3klpcB6t/aVcMT0D6BjYsC81RvQhUdRBbrvWiY7luWukHHrmqp
	 YuAMYafk/osFF6NCd2LWRAPYc7b5eRzrPXGtmBSdSRPhiMIQSyBc7XEGJT+VlfIKZ7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172380;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+WXY/frcM6m/MP6tUHh6J6ZnANjrjcUoHSo2Iqek1i8=;
	b=aKDz1UAdVs9rMLDVfCG9H5YKzrgLmtK+C0e2ctxp7AJz0t9Yo+q6MwcnfYroaMDLwKMK
	 aUjVOhVtJuvwSrtzNbAY4jnCH8jpl7sxnyCBa3N8oSNLviUnzbMcc0t35BrlDx5MjahgK
	 JZpfHTkGqJLOomgRSWhm6soH5XoG2JldkNLHeOyV7KBMH0xqTzcAGUYEuIVgmENYu3wn4
	 yz2Ua2YdO0fCR5YNzMQFwOmVCQnpgAaOdm/r6P2OqHPSEABm2nL5clRU3UR3qdL2BskOr
	 +5JfD19+DcQJodxYTlG+Cbuo0ESmf12/PsyjFGzX2CUatyxvynA0Ii42IjmIQHJKk1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niYNBpFo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411460A2617;
	Fri, 20 Nov 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niYNBpFo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795172380;
	b=E9C727f5hPgkfPf8uY6zduHp4OStcz6Mi2J4iJoPhq03gUD0X7B4sxuZzPG4oD4xSyCf
	 zV9xn9u8DuohqBIRaIC+vW7ueb3noEymnCbzKdiW+w5i/h/+kSrHSDQcezLVjByl/XAHB
	 NMFu/heCpb77aXDMdERgyAEEUg8OED6PVKk5gf8QEMT0kjWBnQitAx519kfkMdnNDfVw9
	 /JehT3ttUf/MUT7qE/5G939rMzfqwx9vn9mSNxAIKTnPtIZYI7cKTCNER6gSYe9RcZI7V
	 Gh4Ic/qUaLuhlOxSgoL0ROCpVzNdZDYPR9buPVpPD22HqZ8ClEO9YvwLtOEHa4Vy+Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172380;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+WXY/frcM6m/MP6tUHh6J6ZnANjrjcUoHSo2Iqek1i8=;
	b=vqG0Bo9tiH4ez9tV0iL7drR62dr/NWifNIiGolrt67YdUuVpPAMZOTOQiC+w52DrDbHR
	 CDiwWSlpSv9BNBJs9aGV7qOMYxEgLWlAczoVLaAC52nMEw7G5nvNn1W0PCiJJymO6h6Ur
	 6aY6JHNag8bPBxs7RHqyZjgfaIf9hohLOInrh17ou4cbhSmgSFAEhsNXVrLks5IO33KhT
	 BW5PL87DdXC576pkFLImH8C3gS/Tm6Y/2EjDWOGvrv2PEI/41LtxPLzK49crpA6IcNjDX
	 dTFc3YeHb/Uz7s4FMihDY6f+5kfZ+nevDSrgJ8qKJrccD2aOrCCi5irky3ku26Z+cNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD8081F000D4;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172380;
	bh=+WXY/frcM6m/MP6tUHh6J6ZnANjrjcUoHSo2Iqek1i8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=niYNBpFo+qHyrotW0xUezvl/4FeCW/KlpSO9dnhzsrrKkADvnj/nITWbfFRTNB+Wv
	 TzyFPQIDTUPKu4vU7fk+oefLKHu4dHnMY6vS6umRWHq9yaki3pD2DKWTWI9f7LO/Y/
	 u6VPUR6bRYmDzUUHHDDjwHFwd0Qaqc0O2k5zg9YRcgNarukI4vZ5A2XIplRpDLkqbE
	 EEmAtt5Z2gaXK19NaMywXK93Ls7i23smGlmq087FgmzdV/GrGBmKtwL9kH/QDPxs82
	 71Bdi/RgBSpj3gne6dAcmmT1EGvUyddpavq5ceiT2SwhheD/jWZqW38PDVmGfsVFza
	 S/ek6DHhwlIaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 37A594982A;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 12:59:13 +0200
Subject: [PATCH bpf-next v3 3/3] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-bpf-raw-tp-regs-preempt-v3-3-ec109009a5d2@gmail.com>
References: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
In-Reply-To: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mike Bazov <mike.bazov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172363; l=6051;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=s7MEhvtT+6ohAuicBJNZB/8ny74bXSZ+o4bia4zLuL0=;
 b=kUpdylDYVXs/VsBmjVcUGoS6H969ZbM/RU63nlC+8Ys7uei9+pAIfC63a/g3trISmRLMxJSwq
 ll2ST46/idUAQnOxHfIXgXpJ4+NGOGZKcQxebA5+pP6HMXBBduVZQtZ
X-Developer-Key: i=mike.bazov@gmail.com; a=ed25519;
 pk=Rr9fagn0pNA+bs8tgc6DXZpRAhl/maU6BeqkttIR7DA=
X-Endpoint-Received: by B4 Relay for mike.bazov@gmail.com/gmail-20261116
 with auth_id=1544
X-Original-From: Mike Bazov <mike.bazov@gmail.com>
Reply-To: mike.bazov@gmail.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mike.bazov@gmail.com>

bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
tracepoint and tracing programs have no pt_regs, so they fill in one of
three per-CPU slots, picked by a per-CPU nest counter:

  get_bpf_raw_tp_regs()   level++, use regs[level - 1]
  put_bpf_raw_tp_regs()   level--

That only works if the users of a CPU leave in the reverse order they
came, as a task, an interrupt and an NMI do. These programs run with
migration disabled but preemption enabled, so tasks can leave in any
order:

  task A              task B              task C
  get: regs[0]
  <preempted>
                      get: regs[1]
                      <preempted>
  put: level 1
                                          get: regs[1]
                                          fills in its regs
                      uses regs[1]

B sends a sample or a stack trace with the registers of C. Profilers and
tracers then attribute it to the wrong task, and nothing reports an
error. The per-CPU recursion counter of a program doesn't prevent it:
the slots are shared by all programs, so it takes two of them.

Fill in a pt_regs on the stack of each helper instead, as
bpf_get_stack_raw_tp_sleepable() already does, and remove the slots.
Each caller then has its own registers, however it nests or gets
preempted. This also removes the three-level nesting limit the slots put
on the three helpers. bpf_perf_event_output() keeps its own limit, and
the mmap_read_trylock() for build IDs has a separate one.

The cost is sizeof(struct pt_regs) of stack per call, 168 bytes on
x86-64, in helpers that can also run in IRQ and NMI context, and
zeroing it on every call. It has to be zeroed: perf_fetch_caller_regs()
sets only a few registers, and a sample with PERF_SAMPLE_REGS_INTR
copies all of them to user space.

Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
---
 kernel/trace/bpf_trace.c | 78 +++++++-----------------------------------------
 1 file changed, 11 insertions(+), 67 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8910d5d05..5c49c139d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1624,51 +1624,13 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
-/*
- * bpf_raw_tp_regs are separate from bpf_pt_regs used from skb/xdp
- * to avoid potential recursive reuse issue when/if tracepoints are added
- * inside bpf_*_event_output, bpf_get_stackid and/or bpf_get_stack.
- *
- * Since raw tracepoints run despite bpf_prog_active, support concurrent usage
- * in normal, irq, and nmi context.
- */
-struct bpf_raw_tp_regs {
-	struct pt_regs regs[3];
-};
-static DEFINE_PER_CPU(struct bpf_raw_tp_regs, bpf_raw_tp_regs);
-static DEFINE_PER_CPU(int, bpf_raw_tp_nest_level);
-static struct pt_regs *get_bpf_raw_tp_regs(void)
-{
-	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
-	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
-
-	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
-		this_cpu_dec(bpf_raw_tp_nest_level);
-		return ERR_PTR(-EBUSY);
-	}
-
-	return &tp_regs->regs[nest_level - 1];
-}
-
-static void put_bpf_raw_tp_regs(void)
-{
-	this_cpu_dec(bpf_raw_tp_nest_level);
-}
-
 BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
 {
-	struct pt_regs *regs = get_bpf_raw_tp_regs();
-	int ret;
-
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-
-	perf_fetch_caller_regs(regs);
-	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
+	struct pt_regs regs = {};
 
-	put_bpf_raw_tp_regs();
-	return ret;
+	perf_fetch_caller_regs(&regs);
+	return ____bpf_perf_event_output(&regs, map, flags, data, size);
 }
 
 static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
@@ -1689,18 +1651,12 @@ extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
 BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   struct bpf_map *, map, u64, flags)
 {
-	struct pt_regs *regs = get_bpf_raw_tp_regs();
-	int ret;
-
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	struct pt_regs regs = {};
 
-	perf_fetch_caller_regs(regs);
+	perf_fetch_caller_regs(&regs);
 	/* similar to bpf_perf_event_output_tp, but pt_regs fetched differently */
-	ret = bpf_get_stackid((unsigned long) regs, (unsigned long) map,
-			      flags, 0, 0);
-	put_bpf_raw_tp_regs();
-	return ret;
+	return bpf_get_stackid((unsigned long) &regs, (unsigned long) map,
+			       flags, 0, 0);
 }
 
 static const struct bpf_func_proto bpf_get_stackid_proto_raw_tp = {
@@ -1715,17 +1671,11 @@ static const struct bpf_func_proto bpf_get_stackid_proto_raw_tp = {
 BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
 	   void *, buf, u32, size, u64, flags)
 {
-	struct pt_regs *regs = get_bpf_raw_tp_regs();
-	int ret;
-
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	struct pt_regs regs = {};
 
-	perf_fetch_caller_regs(regs);
-	ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
-			    (unsigned long) size, flags, 0);
-	put_bpf_raw_tp_regs();
-	return ret;
+	perf_fetch_caller_regs(&regs);
+	return bpf_get_stack((unsigned long) &regs, (unsigned long) buf,
+			     (unsigned long) size, flags, 0);
 }
 
 static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
@@ -1741,12 +1691,6 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepoint_args *, args,
 	   void *, buf, u32, size, u64, flags)
 {
-	/*
-	 * Don't take a per-CPU bpf_raw_tp_regs slot here: those slots are a
-	 * LIFO nest counter and are vulnerable to slot overwrite and
-	 * corruption across sleep.  Sleepable programs never run in
-	 * IRQ/NMI context, so a local pt_regs is sufficient.
-	 */
 	struct pt_regs regs = {};
 
 	perf_fetch_caller_regs(&regs);

-- 
2.43.0


