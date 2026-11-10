Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269557;
	b=XvGE1sFdvKN1Of3RegMPssiCWC9DVUtjIXoIBYnq0IhqXsWL7/2RhLxIbLMhWt4o1M5e
	 XJJGvuBoZ/zM8ufHlzKd0rEm8/vwGnqBFpdEm8CqbGVtKKHTxxW6S6HKfH2KIBZgsAXLy
	 oRH+iO52gV9CLnjyjPQxcaN5f4WK63FihZcWfrJIbb7y7xPHgO83XMsr74/Xcr34/Jw8K
	 qm1ut9ZlfJvDGObxaUgeafOnAZNQSxtGgUvkTd9atmiJR9mgi0xJjbHqg/5L0n9HZNI15
	 iIFEuIXOPX+qIf4hvCnwkCV8RYRerk5vviv9d5u5IX4X8QTcGo71hkK9mwzan4uhFTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269557;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=H9RCC7P1V2pQdmRsMDAygVu9NoMeYxCmqgEQ9C7evnI=;
	b=Sii3ja4UsI+GwmNHHM7VI7rt5cYEmutJsz9+RWNvyklVrOLUAiQadubJZnepzUvPM7UX
	 1ouCBPNqU+9OS3SCUg6EoOSxPAPB9WABMEr+934kENtqwHTI2Cptj8HLQ7ez6duvGE4LP
	 OYh5ymBtzEWodEeAe05O7Tn+SWj4n4jd9xdI4hGbqXwhMZP4KjOZKCezqTmorzF9vYgFA
	 3mSGT4O9SiHLspPk4nq6ilH+nFMDuV4sdoy0eb7P7FV+IAa0+OKDpl3++YBqA13b11gQh
	 YIIO70sFG6rgcPl43TVSAZlUoqDTSk7XLCRm11o2t6Q7usq6IFTWdQcOIlsLu6KE9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.211
Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF1606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FEF1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MTb/qYerhFjNDHDUM7wIaId5PEFeh0GwzODS3IxbnVg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794269552; v=1; x=1794874352;
 b=dhBRRJ8ARpInQSwIrveE1K3g/rV9MAoQEy3zvQMYUjKhbczqsuDnCLHecw/Vob6prTZ0UuBv
 b5Ry91i+iyeBNBFwuiaBd2YXGf0hpYOqrok5TmHAYtRVOQ8C8LDhobmJQ6aImLvgV2gtaLjwmLU
 0hpVlWE9lpESOe3EKUtg1xLs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ad0aa92cff932dc;
	Tue, 10 Nov 2026 00:12:32 +0000
X-Mizu-Trace-ID: 5ad0aa92cff932dc
X-Migadu-Flow: FLOW_OUT
Message-ID: <95e07cae-85ee-4f14-b5f3-070803ee567e@linux.dev>
Date: Mon, 9 Nov 2026 16:12:27 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mike Bazov <mikeba@sentinelone.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.kelly@crowdstrike.com, andrey.grodzovsky@crowdstrike.com
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
 <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com>
 <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
 <DMN0RC27TJRM.3KUSPS9QTBV4G@gmail.com>
 <CAPnbwjrX-ywbcgNQSZKE2jiggEOSVCRVw9OLfaksihiVSCoqvw@mail.gmail.com>
 <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <CAEf4Bza0XDMTxxZeukwRXjvoOOruY49q66xBXnYnuncbeo_Oiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/26 2:08 PM, Andrii Nakryiko wrote:
> (resending as plain text, hopefully)
> 
> On Thu, Nov 5, 2026 at 3:35 PM Mike Bazov <mikeba@sentinelone.com> wrote:
>>
>> On Thu Nov 5, 2026 at 5:14 AM UTC, Alexei Starovoitov wrote:
>>    > Also try NO_HRTICK in /sys/kernel/debug/sched/features.
>>    > That may be decent workaround for now.
>>
>>    The 7.0 numbers I posted were already with NO_HRTICK, and either way
>>    our agent runs on customer machines, so changing scheduler settings
>>    there isn't an option for us.
>>
>>    > hmm. you really cannot tolerate that small drop? it's tracing at the end.
>>
>>    For security monitoring each skip is an event we never see, and the one
>>    we miss can be exactly the one that shows an attack. For stateful
>>    protocol parsing, one skipped sendmsg/recvmsg can desync the parser for
>>    the rest of that connection.
>>
>>    > let's try to think how per-task counter would work.
>>    > I'm guessing 128 connections is 128 threads servicing them,
>>    > so 200 cpus will be hammering the same per-task counter which will
>>    > cause real perf loss.
>>    > Gotta do better than per-task.
>>    > Also it needs to be per-task + per-prog. How will it look like?
>>
>>    On Thu, Nov 05, 2026 at 01:26 PM Peter Zijlstra wrote:
>>    > I would strongly prefer all BPF programs that attach to known
>>    > preemptible sites to use a per-task recursion counter or something of
>>    > that sort.
>>
> 
> I agree, per-cpu recursion counter doesn't work given most of BPF
> programs only disable migration, not preemption (even if
> non-sleepable).
> 
>>    This is what I have in mind for v2:
>>
>>    - Every trampoline and raw_tp run already has a run ctx on the running
>>      task's stack. Add the prog pointer to it, and link the task's active
>>      run ctxs through one new pointer in task_struct (other prog types
>>      don't touch it), so each task has a short list of the progs it is
>>      currently inside.
> 
> hm, funny how AI figured out run_ctx, but didn't figure out that we
> already chain them and we do have that pointer in current->bpf_ctx...
> 
> but yes, I think this is the only practical approach for per-task
> recursion check. performance-wise it should be ok as normally we
> shouldn't have nested bpf program executions, so the hot path will be
> quick.
> 
>>    - On entry, walk only the current task's list. If the prog is already
>>      there, it's real recursion (the same task, or an irq/nmi on top of it,
>>      since current doesn't change there): skip it, as today. Otherwise push
>>      the entry, run the prog, and pop it on exit.
>>    - A preempted task's entry stays on its own list, so another task on
>>      the same cpu is no longer blocked by it.
>>    - Cost: the list is empty unless the task is genuinely nested, so the
>>      check is one load and one predictable branch, with no atomics and
>>      nothing shared between tasks or cpus. The walk is capped (e.g. 8),
>>      which also bounds nesting depth. It also works across sleep for
>>      sleepable progs.
>>
>>    To keep the per-cpu guarantee for existing progs:
> 
> I don't think per-cpu "guarantee" was ever there. per-program/per-cpu
> recursion protection only "protected" (by dropping event, effectively,
> so-so tradeoff) a case when per-cpu map is used exclusively from
> single BPF program. But even then, there are BPF program types (like,
> I believe raw tracepoint programs) that intentionally didn't have
> recursion protection.
> 
> Realistically, you have to have some allowance for having nested
> per-cpu map uses, e.g., in wprof I maintain a small stack of per-cpu
> values, see stack_trace_scratch and embedded atomic st_cnt counter in
> [0].
> 
> That's all to say that I don't think there is a need to keep
> guarantees. If per-cpu map is used naively today it works ok most of
> the time, but not all of the time.
> 
>   [0] https://github.com/anakryiko/wprof/blob/master/src/wprof.bpf.c#L574
> 
>>    - Make it opt-in: a prog load flag for fentry/fexit and raw_tp progs
>>      (like BPF_F_SLEEPABLE) saying the prog may run concurrently on one
>>      cpu, and that it doesn't rely on per-cpu exclusivity for its own data
>>      (per-cpu scratch buffers etc.).
>>    - Flagged progs get no private stack. The verifier could also enforce
>>      parts of the per-cpu promise if you prefer.
>>    - Unflagged progs keep today's prog->active check, so existing progs
>>      see no change.
>>
>>    What do you think?
>>
> 
> I'm actually wondering if we should re-evaluate the whole per-program
> recursion protection. I think this was added to prevent deadlocks
> inside bpf's maps and other internals. but we have switched to
> rq_spin_lock since then, so that shouldn't be a reason.
> 
> Perhaps we should just get rid of that whole per-program recursion
> protection and just make sure that a) BPF program can protect itself,
> if necessary (with naive per-cpu check, I did that trick in retsnoop,
> [1], because it was, and probably still is, possible to attach BPF
> program to kernel functions that shouldn't be attachable by BPF,
> leading to all sorts of issues; but I digress), and b) just make sure
> that BPF maps and other functionality doesn't get deadlocked if
> another BPF program got preempted in the same code path.
> 
> I didn't do any analysis if that's already the case (for b)), but
> let's discuss if this is an option at all?
> 
>   [1] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attach.bpf.c#L229-L243
> 
>>    Mike

Hi Andrii/Mike,
Before moving away from an in-kernel solution, can we consider the
direction this patch below takes?

-- >8 --
Subject: [RFC PATCH bpf-next] bpf/trampoline: walk new run_ctx nesting chain for per-task, per-program recursion guard

The per-cpu recursion guard for trampoline-based programs can lead to
cross-task misses when preemption is involved. Replace the per-cpu
recursion guard with per-task, per-program tracking to avoid these
misses.

Note in advance, private stacks were disabled for sake of experiment.

Give bpf_run_ctx a pointer to its outer ctx when nested. This allows
traversal outward from the current nesting level of a run ctx. Note that
bpf_run_ctx::outer_run_ctx is identical to
bpf_tramp_run_ctx::saved_run_ctx. The latter can just be moved from the
tramp-based struct to the common struct. But some plumbing will have to be
done. This RFC is intented to prove the concept and align on direction.
The plumbing was deferred to avoid distraction from the proposed approach
at this point.

Additionally, give bpf_run_ctx a pointer to the associated bpf_prog. Walk
the new run_ctx nesting chain at trampoline entry, comparing the candidate
prog against progs on the run ctx chain. Prevent recursive entry if the
prog is already on the list.

bpf_set_run_ctx() gains a prog parameter to allow storing the active prog.
Currently in this RFC, it is only used in the trampoline path. Other
non-trampoline call sites are adjusted to pass NULL. Having the prog on the
base bpf_run_ctx allows non-trampoline programs to exist on the chain.
Synchronization was added to the pair bpf_set_run_ctx()/bpf_reset_run_ctx()
in order to handle cross-task read/write of prog. If the overall direction
of this patch is acceptable, the air can be refactored to avoid redundancy.

This patch was used in a small test and got the results below. Two tasks,
one higher priority via SCHED_FIFO. Both tasks call getpgid() between while
probing via kfunc:vmlinux:__x64_sys_getpgid.

Before
Function calls: 30,995
bpftool recursion_misses: 4,938

After
Function calls: 25,936
bpftool recursion_misses: 0

Signed-off-by: JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c |  2 +-
 include/linux/bpf.h         | 23 +++++++++++++++--------
 include/net/tcp.h           |  2 +-
 io_uring/bpf-ops.c          |  2 +-
 kernel/bpf/bpf_iter.c       |  4 ++--
 kernel/bpf/cgroup.c         |  2 +-
 kernel/bpf/trampoline.c     | 27 ++++++++++++++++-----------
 kernel/trace/bpf_trace.c    |  6 +++---
 net/bpf/test_run.c          |  4 ++--
 9 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5bc744c42f7f..0cdc80d266dc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -5073,7 +5073,7 @@ bool bpf_jit_supports_exceptions(void)
 
 bool bpf_jit_supports_private_stack(void)
 {
-	return true;
+	return false;
 }
 
 bool bpf_jit_supports_arena_stack(void)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..d59de89b9438 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2785,7 +2785,10 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog_array **new_array);
 struct bpf_prog *bpf_prog_dummy(void);
 
-struct bpf_run_ctx {};
+struct bpf_run_ctx {
+	struct bpf_run_ctx *outer_run_ctx; /* non-null when nested */
+	struct bpf_prog *prog;
+};
 
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
@@ -2806,13 +2809,16 @@ struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx *saved_run_ctx;
 };
 
-static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
+static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx, struct bpf_prog *prog)
 {
 	struct bpf_run_ctx *old_ctx = NULL;
 
 #ifdef CONFIG_BPF_SYSCALL
-	old_ctx = current->bpf_ctx;
-	current->bpf_ctx = new_ctx;
+	old_ctx = READ_ONCE(current->bpf_ctx);
+	new_ctx->prog = prog;
+	new_ctx->outer_run_ctx = old_ctx;
+	barrier();
+	WRITE_ONCE(current->bpf_ctx, new_ctx);
 #endif
 	return old_ctx;
 }
@@ -2820,7 +2826,8 @@ static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
 static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 {
 #ifdef CONFIG_BPF_SYSCALL
-	current->bpf_ctx = old_ctx;
+	WRITE_ONCE(current->bpf_ctx, old_ctx);
+	barrier();
 #endif
 }
 
@@ -2849,7 +2856,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
 	run_ctx.is_uprobe = false;
 
 	migrate_disable();
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.bpf_cookie = item->bpf_cookie;
@@ -2891,7 +2898,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 
 	run_ctx.is_uprobe = true;
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
 		if (!prog->sleepable)
@@ -3502,7 +3509,7 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
 
 	run_ctx.is_uprobe = false;
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
 		/* Skip dummy_bpf_prog placeholder (len == 0) */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..fad45041fd68 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3157,7 +3157,7 @@ do {									\
 			if (!sk_fullsock(sk))				\
 				req = (struct request_sock *)sk;	\
 			rcu_read_lock_dont_migrate();			\
-			old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);\
+			old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);\
 			bpf_cgroup_struct_ops_foreach(tcp_ops, item, cgrp, \
 						      CGROUP_TCP_SOCK_OPS) { \
 				if (tcp_ops->op)			\
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 6c2a587fb1bf..a53309ecb3d7 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -28,7 +28,7 @@ __bpf_kfunc int bpf_io_uring_submit_sqes(struct iou_ctx *loop_ctx, u32 nr)
 	 * a call from a BPF helper, whose caller holds the socket lock already
 	 * and needs no capability.
 	 */
-	old_run_ctx = bpf_set_run_ctx(NULL);
+	old_run_ctx = bpf_set_run_ctx(NULL, NULL);
 	ret = io_submit_sqes(ctx, nr);
 	bpf_reset_run_ctx(old_run_ctx);
 
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f0b29a170935..d9e1d460f72b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -711,14 +711,14 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 		rcu_read_lock_trace();
 		migrate_disable();
 		might_fault();
-		old_run_ctx = bpf_set_run_ctx(&run_ctx);
+		old_run_ctx = bpf_set_run_ctx(&run_ctx, NULL);
 		ret = bpf_prog_run(prog, ctx);
 		bpf_reset_run_ctx(old_run_ctx);
 		migrate_enable();
 		rcu_read_unlock_trace();
 	} else {
 		rcu_read_lock_dont_migrate();
-		old_run_ctx = bpf_set_run_ctx(&run_ctx);
+		old_run_ctx = bpf_set_run_ctx(&run_ctx, NULL);
 		ret = bpf_prog_run(prog, ctx);
 		bpf_reset_run_ctx(old_run_ctx);
 		rcu_read_unlock_migrate();
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42..16c35a1f7ff2 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -125,7 +125,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	rcu_read_lock_dont_migrate();
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..bcca1cef0b0c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1340,16 +1340,22 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
+	struct bpf_run_ctx *iter;
+
 	rcu_read_lock_dont_migrate();
 
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx, prog);
 
-	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
-		bpf_prog_inc_misses_counter(prog);
-		if (prog->aux->recursion_detected)
-			prog->aux->recursion_detected(prog);
-		return 0;
+	/* walk nesting chain outward, skipping self layer */
+	for (iter = run_ctx->saved_run_ctx; iter; iter = iter->outer_run_ctx) {
+		if (iter->prog == prog) {
+			bpf_prog_inc_misses_counter(prog);
+			if (prog->aux->recursion_detected)
+				prog->aux->recursion_detected(prog);
+			return 0;
+		}
 	}
+
 	return bpf_prog_start_time();
 }
 
@@ -1388,7 +1394,6 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	bpf_prog_put_recursion_context(prog);
 	rcu_read_unlock_migrate();
 }
 
@@ -1401,7 +1406,7 @@ static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 	 */
 	rcu_read_lock_dont_migrate();
 
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx, NULL);
 
 	return NO_START_TIME;
 }
@@ -1422,7 +1427,7 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 	migrate_disable();
 	might_fault();
 
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx, NULL);
 
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
@@ -1451,7 +1456,7 @@ static u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog,
 	migrate_disable();
 	might_fault();
 
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx, NULL);
 
 	return bpf_prog_start_time();
 }
@@ -1472,7 +1477,7 @@ static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
 {
 	rcu_read_lock_dont_migrate();
 
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx, NULL);
 
 	return bpf_prog_start_time();
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..b1c0be68697e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2133,7 +2133,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	}
 
 	run_ctx.bpf_cookie = link->cookie;
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 
 	(void)bpf_prog_run(prog, args);
 
@@ -2647,7 +2647,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	rcu_read_lock();
 	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx, NULL);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
@@ -3175,7 +3175,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 
 	migrate_disable();
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx, NULL);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..3eb8b3d0f593 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -410,7 +410,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 		repeat = 1;
 
 	bpf_test_timer_enter(&t);
-	old_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 	do {
 		run_ctx.prog_item = &item;
 		local_bh_disable();
@@ -750,7 +750,7 @@ __bpf_prog_test_run_raw_tp(void *data)
 	struct bpf_trace_run_ctx run_ctx = {};
 	struct bpf_run_ctx *old_run_ctx;
 
-	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx, NULL);
 
 	if (info->prog->sleepable) {
 		scp = rcu_read_lock_tasks_trace();
-- 
2.56.0


