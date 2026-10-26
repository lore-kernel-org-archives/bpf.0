Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983629;
	b=j3iLzCWhYsstQGMUfNc2w3uIGaPav+56LMxf85oxfHlbrJuWCTmn2+dp9dpPtEBxvFxg
	 OTJ5HGVrU9ny3ffBTdlreFRSbgcZTcoe/oDhv2fcqA+E5Bq385e6xoNEEdf8CMUTmSpD6
	 AMPiUhsZ9tQmUyfr2kky7+UTthiJ8ex36calN7rLXacXWH8BRIORkDnP3ACLWYq6YGD30
	 GUTaoMJjPpSwmjGRG9XAfQ+yZjKqstqVowVtsHB31Rxx+TtOqarXtjrT9YzsZ0TlTGtzV
	 aWdiNlCZZm8sKNjjioSjcPlwDv1DuXQH3ZCCLL4jUJi/lQSh78pILugElGsaqXomyyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3GE591d1veMorimorQVo2THTErpeIldienDCH/ySnOw=;
	b=Q8eq4WNSci7CgUr0u79awINMD43HFtfcBUPe/CY+D0YlGNNAIaCYu+glJIhbpvUvEQ4M
	 vKhlPDAgajMHCBbzS/u8jAIPaD9uvEj7T30tPbRCExlkc4tu2aE34xYEDtCbeZ9zvaZ25
	 SN28VWgEmwFgb9ONorut8AGmyJUCdaBy2PNQPI3EogItJibmu7SUfcz9IE6/M2O5VEb5o
	 8sW982Y0/iXGz9VOi+JbYUiZQYNSPHp5GNE+I66WPKQ1Vw3p29G8Mu5pSTLhfCEUQslQj
	 lOWkdg7eyTvGLylmqwN+5Ely+Tuwi6hfyf5SiZPtfJ/QdGeoyBvWUhrlQJiwn8sO/5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icLHqcjI;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9627C606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9627C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icLHqcjI
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea138a3497so15792525ad.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983628; x=1793588428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GE591d1veMorimorQVo2THTErpeIldienDCH/ySnOw=;
        b=icLHqcjI/F9A/l6mT5UUDwV9nUch9VMfFrMHO1WYAp9NB8LX0kwVTzhLRu9dsjOOxC
         rvxih7gtadcuM9wjchbIt3SdeHUuW46JziFkrXWM7f1U7uj5rtEBU1U4kKMWQU7u872v
         XXXLirqojSVoyLt1uLG0rJ6io/KGdk1GlfsecUNhgSy6kLosumR/WcEKqnIhNL/8tzAb
         FlMFmDlzcA5lwg/j99rqCEukj3YaJNXMRo5gQtoeVbv8FrLBAiMYLgb5LWgzVGX2jVWD
         0nbS535vHBQvvOBKc9D2OGUH08LW6NYoaN3s3YGSE96hunxnCxEzrvuEY+YsFyH9V+U5
         Mlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983628; x=1793588428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3GE591d1veMorimorQVo2THTErpeIldienDCH/ySnOw=;
        b=fHKGfuj9FvTL+ameb8DpB0XCx4mJxldniZOrzMiKk9O7tR4Uo6nkUvIasxxECS0dob
         W/BvsF2oHt1WvVH3vsb1OT2dILPzWcyixW38/xTeqlZvIz6r0xZsImbn6zLNIoN55KDx
         1g5yQVeGog0ZZiAWNAbfS1CLvz6CSyAB7psozyZTcP8v3RMjLK/kVMdaNjDmghrJICUA
         EbHo0BTG952h9lonx2XhJcAOm5U4ViELgr3I2hDT0xoTLOBPCGM5N5FTkcbG1ToQIHoo
         YQ/hZ5xzd2bMb+DYVaeKKX84h8bTaIpFbRjlzhRzSHp0g63pY5NdPltUGOt3Or+CCgIQ
         ItZQ==
X-Gm-Message-State: AFq9FYLjSVGgam/VpwBYRNEMNL+l1und07LrHfJDoNcXA7iqrxqK8yBe
	3staRni6CxpkEOfJWkluvHSvVCFteLOXXaYdYcZxliNAMnAUljph9PAYbS64TQ==
X-Gm-Gg: AYBFou2Fw7bk6o1E2TvogX4z5v20lBWOxnKm8KTWuSmRIGpJHQPOOc6mrSFHUj7D9oC
	WscTprzO5xJrdtLV1PQacw6DeU+Hrgwko3WT5wF70sNefhm7IGcYTRngrZ61TPi/aibRDqiYwzI
	dfmxsb1HMTz9Ta2xGTQkTZEa4vfANfiOwSui2f+HdvR1qeZa0TnU1ouILDjX1eF3chR884TmMSn
	3dlMU7xiEIGoC14sDxqEzEMvAikj7W19vGe0ANlwBB1xaUPNphJ1llgChjxfGrciqA8BpeNekTj
	NYqOCCKCL2B0sHdsbaLn4hjY5DuFc2oScxwzPd5VvHVBZPWfES0A7rOOfoKu4DMDYCyXQmP76rD
	c+OdYcurFM3m7NJBzQn3tE8aDCl0lL2b3xZg7iU6JENTKThGNmchFs7kA9z/rcJ/D3QjyvSjFjh
	CKJOv/REebAIHpxY/NjUjrpb+o8DbeCJzmBuylxK/RGv9pUAuKRgxB0W0fHowO3fDdtHQ6h486M
	Fl5PqJbf0J/5hpk9LzKldYbhYbpXhzMJSIOs3XaTD5wGEC1k2X23yVVkRHJ/NhyfOzKen8/gMWK
	gzJXeFgx7teKBmrVrgscARau8rCYriWpIGdjqNexf++kbbgSXwWES6D6JDJBeFi42xfP9B07KhX
	RFgRFfi3NBAvvoLxcJ3WxW4vC
X-Received: by 2002:a17:902:e5cb:b0:2e9:528c:ba02 with SMTP id d9443c01a7336-2ea9c99609amr49394905ad.60.1792983627623;
        Sun, 25 Oct 2026 20:00:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1df613sm9954535ad.61.2026.10.25.20.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 07/81] bpf: One time slice of may_goto for a run of a prog
Date: Mon, 26 Oct 2026 02:58:28 +0000
Message-ID: <20261026025943.404450-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

may_goto stops a loop that the verifier cannot bound: after 250 ms the loop
must exit. The count and the timestamp are in the stack frame of the
function that contains the loop. Thus the limit applies to one call of a
subprog, not to one run of the prog. Loops that nest across calls multiply
the limit.

  main:                 sub:
  1: call sub           1: may_goto 2f
     may_goto 2f           goto 1b
     goto 1b            2: r0 = 0
  2: r0 = 1                exit
     exit

  main  | sub: 250 ms | sub: 250 ms | ... | sub: 250 ms |
        1             2                   65535         ^
                                   main reads the clock here

Each call of sub spins for 250 ms. main reads the clock one time in
65535 iterations. Thus the prog runs for 65535 * 250 ms: 9 insns cause a
soft lockup. bpf_loop(1 << 23, cb) with such a loop in cb has the same
result.

The count has the same problem. A subprog that makes fewer than
65535 iterations in each call never reads the clock. An endless loop that
calls a subprog with 60000 iterations runs for 3.5 sec. Three levels of
such loops lock up a cpu.

Give one time slice and one count to the full run. A run is one call of the
main prog, or of an async callback, by the kernel, together with all the
subprogs that it calls. The main prog gets a per-cpu budget.

  the kernel calls the prog  budget.start = 0
            |                budget.count = 65535
            v
  entry of a subprog         frame.count = budget.count
            |
            v
  may_goto                   frame.count -= 1
            |                At 0, read the clock:
            |                 < 250 ms   refill frame.count, budget.count
            |                >= 250 ms   budget.count = 0, exit the loop
            v
  exit of the subprog        budget.count = min(budget.count, frame.count)

Iterations now add up across calls. After 250 ms the budget is empty:
 - A subprog that starts after this time exits its loops immediately.
 - A frame that is already on the stack exits its loop when it reads the
   clock again.

The progs above return after 250 ms.

Only JITed progs that have may_goto in a subprog or in a callback get
different code: 0 of 144 progs of Cilium, 53 of 495 progs of scx. The cost
on x86-64 (Zen 5) with hot caches, in nsec:

  entry of the main prog, once per run    4 insns, 34 bytes   +0.52
  entry of a subprog with may_goto        3 insns, 19 bytes   +0.03
  each exit of such a subprog             6 insns, 36 bytes   +0.15
  async callback (bpf_timer), all progs   reset the budget    +0.35 on 34.6
  read of the clock, once in 65535        stack walk to find  26 -> 179
  iterations, all progs                   the budget

An iteration has no added cost. A run with one call of such a subprog costs
+0.97 nsec. It costs +90 nsec when the budget is not in the cache.

Limitations:
 - A second run of the same prog on the same cpu, in an interrupt or after
   preemption, starts the time slice again. The timestamp in the frame
   continues to limit each frame to 250 ms.
 - The JIT must support a stack walk and per-cpu insns. x86-64 with ORC,
   arm64 and powerpc64 do. Nothing changes on riscv, loongarch and s390.
 - Nothing changes for extension progs. They cannot find the start of a
   run.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  | 12 +++++++
 kernel/bpf/core.c    | 72 ++++++++++++++++++++++++++++++++++----
 kernel/bpf/fixups.c  | 82 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/helpers.c |  4 +++
 4 files changed, 160 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ff0436781293..4c7c3f86ddbd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1851,6 +1851,15 @@ enum bpf_sig_keyring {
 	BPF_SIG_KEYRING_BPF,
 };
 
+/*
+ * What all frames of a run of a prog on this cpu share, see bpf_check_timed_may_goto().
+ * It's reset when a run begins, see bpf_prog_begin_run().
+ */
+struct bpf_may_goto_budget {
+	u64 start;	/* when may_goto looked at the clock for the first time, 0: it didn't yet */
+	u64 count;	/* what is left until the next look at the clock, 0: the time is up */
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1916,6 +1925,8 @@ struct bpf_prog_aux {
 	const char *attach_func_name;
 	struct bpf_prog **func;
 	struct bpf_prog_aux *main_prog_aux;
+	/* main prog: there when a subprog has may_goto */
+	struct bpf_may_goto_budget __percpu *may_goto_budget;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
 	struct bpf_kfunc_desc_tab *kfunc_tab;
@@ -3415,6 +3426,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
+void bpf_prog_begin_run(const struct bpf_prog *prog);
 
 static __always_inline u32
 bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7cf37690d41f..472efced9e40 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -292,6 +292,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		kfree(fp->aux->poke_tab);
+		free_percpu(fp->aux->may_goto_budget);
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
@@ -3625,21 +3626,78 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 #endif
 }
 
+/*
+ * The kernel is about to call an async callback of @prog on this cpu: a run begins.
+ * The main prog does the same in its first insns.
+ */
+void bpf_prog_begin_run(const struct bpf_prog *prog)
+{
+	struct bpf_prog_aux *aux;
+
+	if (!prog)
+		return;
+	aux = prog->aux->main_prog_aux;
+	if (aux->may_goto_budget) {
+		this_cpu_write(aux->may_goto_budget->start, 0);
+		this_cpu_write(aux->may_goto_budget->count, BPF_MAX_TIMED_LOOPS);
+	}
+}
+
+static struct bpf_may_goto_budget *bpf_may_goto_budget(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_prog *prog = bpf_prog_find_from_stack();
+
+	if (prog && prog->aux->may_goto_budget)
+		return this_cpu_ptr(prog->aux->may_goto_budget);
+#endif
+	return NULL;
+}
+
+/*
+ * The count and the timestamp are those of a stack frame. With nothing else every call of
+ * a subprog has a time slice of its own, and a loop that calls a subprog that uses up its slice
+ * goes on for BPF_MAX_TIMED_LOOPS slices before it looks at the clock itself.
+ *
+ * So there is one time slice for a run of the prog. It starts when the first frame gets here.
+ * When it's over the frames that are entered from then on start to count from 0: they leave
+ * their loops at once. The frames that are there find out when they get here.
+ *
+ * The count is shared as well. A subprog that makes fewer than BPF_MAX_TIMED_LOOPS iterations
+ * per call would never get here, and neither would a loop that calls it, for that many times as
+ * many iterations. Three levels of that take days. So a subprog starts from what is left for
+ * the run, and what it has left when it returns is what is left for the run. No more than
+ * BPF_MAX_TIMED_LOOPS iterations for every frame on the stack pass between two looks at the clock.
+ *
+ * Another run of the prog on this cpu, in an interrupt or after preemption, starts the slice
+ * anew. The slice of the frame is still there for that.
+ */
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
-	u64 time = ktime_get_mono_fast_ns();
+	struct bpf_may_goto_budget *run = bpf_may_goto_budget();
+	u64 time = ktime_get_mono_fast_ns(), start;
 
-	/* Populate the timestamp for this stack frame, and refresh count. */
-	if (!p->timestamp) {
+	/* Populate the timestamp for this stack frame. */
+	if (!p->timestamp)
 		p->timestamp = time;
-		return BPF_MAX_TIMED_LOOPS;
+	start = p->timestamp;
+	if (run) {
+		if (!run->start)
+			run->start = time;
+		start = min(start, run->start);
 	}
 	/* Check if we've exhausted our time slice, and zero count. */
-	if (unlikely(time - p->timestamp >= (NSEC_PER_SEC / 4))) {
-		bpf_prog_report_may_goto_violation();
+	if (unlikely(time - start >= (NSEC_PER_SEC / 4))) {
+		/* once per run */
+		if (!run || run->count)
+			bpf_prog_report_may_goto_violation();
+		if (run)
+			run->count = 0;
 		return 0;
 	}
-	/* Refresh the count for the stack frame. */
+	/* Refresh the count for the stack frame, and for the frames to come. */
+	if (run)
+		run->count = BPF_MAX_TIMED_LOOPS;
 	return BPF_MAX_TIMED_LOOPS;
 }
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 41bc37e205e0..fe8d51f8c855 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1821,6 +1821,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
+	struct bpf_may_goto_budget __percpu *budget = NULL;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
 	u16 stack_depth_extra = 0;
 
@@ -2729,13 +2730,69 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	/*
+	 * One time slice for all frames of a run, see bpf_check_timed_may_goto(). It finds
+	 * the prog with a walk of the stack, like bpf_throw() does. An extension is entered by
+	 * the prog that it extends, it has no way to tell one run from another.
+	 */
+	for (i = 1; i < env->subprog_cnt; i++) {
+		if (!subprogs[i].stack_extra || !bpf_jit_supports_timed_may_goto() ||
+		    !bpf_jit_supports_percpu_insn() || !bpf_jit_supports_exceptions() ||
+		    !prog->jit_requested || prog->type == BPF_PROG_TYPE_EXT)
+			continue;
+		budget = alloc_percpu_gfp(struct bpf_may_goto_budget, GFP_KERNEL_ACCOUNT);
+		if (!budget)
+			return -ENOMEM;
+		prog->aux->may_goto_budget = budget;
+		prog->jit_required = 1;
+		break;
+	}
+	/*
+	 * What a subprog has left of the count when it returns is what is left for the run,
+	 * unless its callees have left less, or the time is up. R1-R3 are dead at exit.
+	 */
+	for (i = 1; budget && i < env->subprog_cnt; i++) {
+		int off_count = offsetof(struct bpf_may_goto_budget, count);
+		struct bpf_insn ld[] = { BPF_LD_IMM64(BPF_REG_1, (long)budget) };
+		int j, cnt;
+
+		if (!subprogs[i].stack_extra)
+			continue;
+		for (j = subprogs[i].start; j < subprogs[i + 1].start; j++) {
+			if (bpf_is_ldimm64(&prog->insnsi[j])) {
+				j++;
+				continue;
+			}
+			if (prog->insnsi[j].code != (BPF_JMP | BPF_EXIT))
+				continue;
+			cnt = 0;
+			insn_buf[cnt++] = ld[0];
+			insn_buf[cnt++] = ld[1];
+			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_1, BPF_REG_1);
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP,
+						      -subprogs[i].stack_depth);
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, off_count);
+			insn_buf[cnt++] = BPF_JMP_REG(BPF_JLE, BPF_REG_3, BPF_REG_2, 1);
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, off_count);
+			insn_buf[cnt++] = prog->insnsi[j];
+			new_prog = bpf_patch_insn_data(env, j, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = prog = new_prog;
+			j += cnt - 1;
+		}
+	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
 		int subprog_start = subprogs[i].start;
 		int stack_slots = subprogs[i].stack_extra / 8;
+		int off_start = offsetof(struct bpf_may_goto_budget, start);
+		int off_count = offsetof(struct bpf_may_goto_budget, count);
+		/* a run begins. For async callbacks see bpf_prog_begin_run() */
+		bool entry = budget && !i;
 		int slots = delta, cnt = 0;
 
-		if (!stack_slots)
+		if (!stack_slots && !entry)
 			continue;
 		/* We need two slots in case timed may_goto is supported. */
 		if (stack_slots > slots) {
@@ -2744,7 +2801,26 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		stack_depth = subprogs[i].stack_depth;
-		if (bpf_jit_supports_timed_may_goto()) {
+		if (budget) {
+			struct bpf_insn ld[] = { BPF_LD_IMM64(BPF_REG_0, (long)budget) };
+
+			/* R0 has nothing at the entry */
+			insn_buf[cnt++] = ld[0];
+			insn_buf[cnt++] = ld[1];
+			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+		}
+		if (entry) {
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, off_start, 0);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, off_count,
+						     BPF_MAX_TIMED_LOOPS);
+		}
+		if (!stack_slots) {
+			/* nothing to count in this one */
+		} else if (budget && !entry) {
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, off_count);
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_depth);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
+		} else if (bpf_jit_supports_timed_may_goto()) {
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 						     BPF_MAX_TIMED_LOOPS);
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
@@ -2774,7 +2850,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		 * to insn after BPF_ST that inits may_goto count.
 		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, cnt - 1));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..cd960f65093d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1242,6 +1242,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	key = map_key_from_value(map, value, &idx);
 
+	bpf_prog_begin_run(READ_ONCE(t->cb.prog));
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 	/* The verifier checked that return value is zero. */
 
@@ -1273,6 +1274,7 @@ static void bpf_wq_work(struct work_struct *work)
 
 	migrate_disable();
 
+	bpf_prog_begin_run(READ_ONCE(cb->prog));
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 
 	migrate_enable();
@@ -4611,6 +4613,7 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
 
 	migrate_disable();
+	bpf_prog_begin_run(ctx->prog);
 	ctx->callback_fn((u64)(long)ctx->map, (u64)(long)key,
 			 (u64)(long)ctx->map_val, 0, 0);
 	migrate_enable();
@@ -4863,6 +4866,7 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	smp_store_release(&rh->armed, 0);
 
 	rcu_read_lock_dont_migrate();
+	bpf_prog_begin_run(prog);
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 	rcu_read_unlock_migrate();
 
-- 
2.55.0

