Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795084646;
	b=003BckGd3PAlG8ee3eB/MVCBrvbYryxW0w5RZuG55aO5PIRAGnXs50DwI5LigV55kPQW
	 Z1aeDOGPRG4fItlQToXU+8NwwIRqsxIcLk6YCB2xXy5IglAIHbbJS4eM+7VWLn3vl4BTV
	 xlUpdwKqaS2cMMYHP9jYPs47bxg1+EkZ8Y8TTIT4kGUXnEKUDu9d5VLIbQvOPvjx5Vw/L
	 W/H1WMi+NfURiRLHjl/L4N4aRmJtIxUMnaDqC/PDbvdvuTEynEtCRlSelMDee8r6ZbobD
	 mm4sAMTLwBybY7nkcr5SEi931vrQSolCYT39JPYCPgJtv9zijJHjif/ZWTbT/XJT/HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084646;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rk135+iUCLveMrBJB25WQD3aieJX+w/NXoAKptzQUfk=;
	b=2zgoKzzQvLQ6K20okAqy3oxoHSv+6w7UE1ZIVfWUjgX99Ohd8P3D7Ah9fVHUvTZz1jW2
	 88pC9120Bs3uOLbBRh90viHJzWKcob31OIz5068bJ+AxZUb0ncdAMxtN27ZG3BfnwZ4D0
	 MSvplr7WRKArgSSnXaxgkx1e01dHOTh+temnkY8vtu/QXcZGbAPxUymiBCm23jjYLJoLB
	 qH3Ws4qzKCao2NplvLFxeE388B6prCugHiU0c5Pnv0VLUMNH5Zh0XSRI/cZwh5O4ZK9y5
	 +mCf8hAGj+L8SpLMnU8Z7ITutoczml0Uev0+HMX+4nvEPU4sJxY9V2KjwKtv1ug6utw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MLJKrL5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624A606A324;
	Thu, 19 Nov 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLJKrL5/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795084646;
	b=V92+qKcMeHIl5px5XGV7jJ+PFksxGYPOWRrY9uP4rr1HAZ7lHY9AzPUb1p7v1xp8nKoo
	 BX9YQsDdiDZwO368r4a5j+Ne5X/MfYhEElxiACHXUZaxyrDzo3U6+ie3SBCIjXZTLRqPr
	 ZXVH5zz4jBSsECwzY58Z2llKcqU5ZXC8eafuvEVvV5xGQjM2hul9IIA3jN0zg7cKIIo2Y
	 R1qpDBwtgjIg/7BUunxBJLsWMWmq9uCtMmSY4I50ZbGj6VYZ6245Xhw0vrSPPLeNFDWg3
	 OX6KRFxjE5acF/uLRAP44jG4yKgZepbErZm5mOLknKVjPkof+QqiRKDJM0D/yKJtKJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795084646;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=rk135+iUCLveMrBJB25WQD3aieJX+w/NXoAKptzQUfk=;
	b=cXnKtnV7+cpa1lbi6fiXkakkxdixCS9+g37LFqD8IjIwJNQaCAOFbm2Srp3AX/fu47R1
	 FVCoCIraQeCZVl+EPwLyvD7NgIf4yPa+8GzqNls+SktPkkZbivOntkdmZur7rHMmgRqrt
	 fxExon+k90V3CafJRcqFYRJfk6305NPQ38hjXJ+ASR6aLDQm+wjKvBKQ0HGvl8+2z5999
	 USS03MPEjQxGq3wqvwl0HUTYZE/Uoih7bZMO9J0sVLLozTTGM2SJhgKk4N1vQbQbWsNTX
	 bjre7aFlo+QEu1DsF8j4FAqVhT/oEBFTkf2131If7fjJ8y3GW2WhBfw/SLyQW/ETPyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5DDB41F000C4;
	Thu, 19 Nov 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084646;
	bh=rk135+iUCLveMrBJB25WQD3aieJX+w/NXoAKptzQUfk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=MLJKrL5/hhZtiKuqqGRIpP5Zeep9N9nXnMd89dReQeSBmQPNbi+qgERw5ULokojHy
	 CPigMhF4J9nkbuTcyXux/rPOPHVj6OokOqEZpGoZOfzoXJOw+8kgU1sEWj1tAaghN1
	 AHVUc9unld8dKM1jgNRkxLPNaySVcch37VwHbUF7D1r4G9SE3Y01+FZGoOy8zI84Te
	 O379Th8gP7QdEvJSgGJrdcHeyc0Mu1fOs2TbCKm7wi1hYEzUFzs6wMsc+BNmyb+jXw
	 pb5AzVlv0bm204fDt4imxRDOB/V+IofhCNY2OL2msBwn0GUugoNY4R3+YywaxJTICG
	 rgcKZoa2UuDAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E0B7E4B244;
	Thu, 19 Nov 2026 10:37:24 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 12:37:24 +0200
Subject: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw
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
Message-Id: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGPR/moC/4WNQQ6CMBBFr0Jm7RgGI1BX3MOwKO0Akwg0bYMYw
 t2tXMDl+z///R0Ce+EAj2wHz6sEWeYExSUDM+p5YBSbGIq8KImoxM716PUbo0PPQ0DnmScXkfo
 qJ6VqpTsFaZ3yXrbT/ITfaOYtQpuaUUJc/Oe8XOns/9pXQkKbU1daW9+rm2mGScvrapYJ2uM4v
 vBaRBzIAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795084644; l=7871;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=6EzdZ5kXAytUcjASHjJSyHChrRCCQ5aVdBi0WKUNNmo=;
 b=vMA5md7CjaQ3aLL1nyJkX/CdbsbM2YZYb81DrOEviachWJFUb67oHo3Gq+7Olntr3jZO5+BQT
 wEc1LJzi6OTBRw8zF0ZURweTCLE4WvL7DFkOHCIfFdA8+LW06lSI8HY
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
preempted, and the helpers no longer fail with -EBUSY when nested more
than three deep.

The cost is sizeof(struct pt_regs) of stack per call, 168 bytes on
x86-64, in helpers that can also run in IRQ and NMI context, and
zeroing it on every call. It has to be zeroed: perf_fetch_caller_regs()
sets only a few registers, and a sample with PERF_SAMPLE_REGS_INTR
copies all of them to user space.

Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
---
A reproducer, x86-64: two raw tracepoint programs on sys_enter call
bpf_perf_event_output() once each, with the program's number as data.
Two threads make syscalls on CPU 0, and a SCHED_FIFO thread preempts
them every 20us. The IP of a sample is regs->ip, the return address of
the helper call. The reproducer reads that address for both programs
from their JIT images and checks every sample.

Without this patch, 7 to 18 samples per program and 10s run have the IP
of the other program, out of 1.4M. With it, none. bpf_get_stack() and
bpf_get_stackid() in the same setup return an empty kernel stack
instead: the unwinder looks for the other task's sp on the current
stack and doesn't find it.

5 runs of 10s, debug config, CONFIG_PREEMPT=y, preempt=full, on
bpf-next 0fb18ce8a2e9:

                                     without     with
  bpf_perf_event_output, wrong IP    7-18        0      per program
  bpf_get_stack, empty stacks        362-535     0
  bpf_get_stackid, empty stacks      168-364     0

The bpf_get_stackid() case with bpftrace, whose kstack calls it; @a[]
and @b[] count the empty stacks:

bpftrace -e '
  rawtracepoint:sys_enter /comm == "dd"/ { @a[kstack(1)] = count(); }
  rawtracepoint:sys_enter /comm == "dd"/ { @b[kstack(1)] = count(); }' &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 chrt -f 1 perl -e 'select(undef, undef, undef, 2e-5) while 1' &
---
Changes in v2:
- Use a pt_regs on the stack of each helper and remove the per-CPU
  slots, instead of disabling preemption while a slot is in use
  (per Andrii's suggestion).
- Link to v1: https://lore.kernel.org/r/20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com
---
 kernel/trace/bpf_trace.c | 78 +++++++-----------------------------------------
 1 file changed, 11 insertions(+), 67 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b4ff9d4e8..3f1901ae6 100644
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

---
base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
change-id: 20261116-bpf-raw-tp-regs-preempt-1f7019989ab9

Best regards,
-- 
Mike Bazov <mike.bazov@gmail.com>


