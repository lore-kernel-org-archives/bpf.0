Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983728;
	b=dWpxwqIqN11IAUUgU1eLd2EGrNGZjgWP784Cf8QEfnrf6XJm2HZgCkZyjqGgBMRkcYYW
	 nlpygNqF1Untfl3hIJDRf13+z9Q9XNiNgJXNNnOUQt6YIXtH3bj2KpFqwqfg1hbRbhs+b
	 m8LP5wwXW6keF8e+IGB9fywRVZ/WtleXJAPRfFvWNTbtM+N1kwFuG76QR2IDvsm2U9qwR
	 o7W/JwvN62A9rFarBcPHm51PJmSdiLbGNZ35e499P1gdGdn4wdyALo7lUga8ZREaNlAZ8
	 8H8Bx34RqOFyKL9rNYoNkdR3+Q4H+x09dvn4jbIOpYJobpzKsXzA5e+s4IDyeACXhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B9SMT40slRnP86FTKpYqGjweYTQSTvoktDawhZ/pfFw=;
	b=lzcowD98XBoRl+gyc+U8upBwZmxx84MC2zEWkHUDZkMWdsCIXyp+4IU1FQwR6/iZxjlG
	 smmRdPemy2lhF9fTqRvtgwSEjSiRzBvMiN1wzaXv8Kb1jkNT/Xb/y4IrK8ESVmKHeewhc
	 IRddCvGRBOwjYAu78korSzqMaOX/TMOgSODA4R6nQFcUNOkd/TkAsGifO9azeOZuGMezW
	 0YQLsQz4wRRT35+gQOT7iCG7PQbWz+/pNGSX2F7/BFhnGQlTd9AH+Bl1126RBk09hpSZq
	 LhPgKvpjV535rpr0igCzAFzfYrJmJ3t11W3xy0Fulk5sXyqyifBe+aX2aZUIMQAfXaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Njot+ZOK;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA3606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Njot+ZOK
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso15498885ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983728; x=1793588528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9SMT40slRnP86FTKpYqGjweYTQSTvoktDawhZ/pfFw=;
        b=Njot+ZOK2ShQOZCqZG4+SH204LXQ+i+O67FW0lDg4cIJzzhbScZrrbSdR7LTEaLrXF
         JJrvaG/tiHRXRmDllqT08x2mb1THvbE9Zxls+2jiGdmqe6yQdFT86JvL9571HENznDQX
         GtDeRwfcoGUa6n9eq7H2CQ6CTjdzExwx3Ibn7xBqzOB84N9x+PtxSN3G/VLvjLRe9OUl
         LuNJTIGq+t7cOFhShqsJ6rU1wLUYBBY7yuKbtzqbiLKEglXcY5I2Civoluljg8EhMSDF
         1AueAR4Q2lkazq1WCby4kK4sA9wJtHa4txCAm+MUpFrxBsZf6sormdNRJ6Jemiafo9oP
         e+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983728; x=1793588528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9SMT40slRnP86FTKpYqGjweYTQSTvoktDawhZ/pfFw=;
        b=I7ZlzbEPN4HgpEcjqFibjsFY63r5/GKdyVSm0uwUthhhPy3myg6DTfCBp3iVmmb/o3
         ZLfoPPZb7UtH8dxWBwGzfSAKQGV9vjMWFzc9KMIlRhHhrzzenke0nWP2qXTkqDUG5WbM
         HQH3M4sE+VyIrT4PFj5C1ts/tLhBU7zdRuY1K0dOnZmBltvHL3duF/9yFXBrbZYWLGYe
         gQ3u1+IJk9TKRLWGOL0S6D6WIQjEKmPiAXJL1fAUlxjO1XfNx3DZ3nGFB8DVKe++C/nG
         O9gngRsZANq96kPtBDST+csBhIXn0RrRBjtpTZA7ZnqrugXmnfo18ZiYHbvhDScGWLek
         SPcg==
X-Gm-Message-State: AFq9FYICNkjgzmvgTNNrhE35+CwiYicPcmC+aj/ls2C8lSNhLfUlkcx4
	pt1KN+zK5ga857hgdWf5CCnVx1RO6sJv4NLsCXaJLP/GHNKxz4mhd0Pak/jtrg==
X-Gm-Gg: AYBFou0P3lLbS6CZJqjtyyoZztqIqLtX2mHbkihc6Qru+BgGMI/CbD5ZG8om4Bfvmih
	mf3ZAB+TgosP/fp3+SsKH29pn4gnD2/zJ/AGMZ5U/6/EWT+ZBXvz8ARtCkhHaWzVKx+EbXsWZJY
	Q5mhdplU09ceARwjPGm4orK6yekl30UJ+VR38VOpIx3BsaDYTshXlp1e3JvulWWs/FajB4Kclb6
	eK3MFKQW6JE9nYj98gFF/mUAEbSUQ0eaFaljPhwofY6GQ29sCvjTM2V1CAw28f8k7ZJPmI/eJic
	aETeCSPnknShuYxerGRbG1mqrqroEQIhArJ+35vS+jscsCDdOBjmAj9VTBMNzEZU5qJjlz/MwM9
	gPzMgmjKbHI/wxp24Sh//TfVaRshh/iXhZiyBGriOLdNkvtk8PlbDi3iNy5epwiKFbZ2j0rlKSF
	2BO4fopyAYSlYB3KqjQq97st08rs53U4xKNjB9jKi5QED0g4uNgrSTUKKuiT2wJ49VoAtAlzKEl
	hGWCymnmPWEtUV82C2Wn/cqyNSHd+Bypgwehyxpdl4HNV4zbY+7qyZySTisROaphy4gMcb6tIpJ
	oT7TNRJvhrG3KQJelw3mGVUiY4UJyjWv2lul7PAfRtOXQZCEbf0W0uDCYAn58BWqcwmpgXMMK7K
	pCwWu+vvH6XZsrbw8l6bKpcgF
X-Received: by 2002:a17:902:e749:b0:2dd:ad73:5b6d with SMTP id d9443c01a7336-2ea9c63900bmr46220565ad.29.1792983727468;
        Sun, 25 Oct 2026 20:02:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1df39dsm10902165ad.62.2026.10.25.20.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 24/81] bpf: Add stacks for programs to arena
Date: Mon, 26 Oct 2026 02:58:45 +0000
Message-ID: <20261026025943.404450-25-alexei.starovoitov@gmail.com>
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

A prog that keeps local variables in arena needs a stack in arena while it
runs. r12 (BPF_REG_ARENA_SP) is the stack pointer of this stack.

One stack for each cpu is not sufficient. A run of a prog is interrupted,
is preempted or sleeps, and a second run starts on the same cpu. The second
run cannot put its frames after the frames of the first run, because the
first run can continue before the second run ends:

  cpu 0    run 1: f()     run 2: h()      run 1: f() calls g()

  stack    | f |          | f | h |       | f | g |
                                                ^ g overwrites h

Thus each run takes a stack when it starts and gives it back when it exits.
Usually there is only one run on a cpu. Make this case a few insns without
a call:

  stack that a run gets     condition                      nsec per run
  ------------------------  -----------------------------  ------------
  the per-cpu stack         no other run is on this cpu    2.2
  one of 16 more per cpu    the per-cpu stack is taken     9.1 more
  new pages for this run    all 17 stacks are taken        1130 (1 page)

The times are for x86-64 (Zen 5). The first time is the difference to a
prog that has the same variables in the r10 stack.

Each run increments the per-cpu counter 'busy'. The run that finds 0 has
the per-cpu stack, and it stores 0 when it exits. The other runs call
bpf_arena_stack_get() and bpf_arena_stack_put(). One bit of r12,
BPF_ARENA_STACK_SLOW, shows at the exit which of the two ways is necessary.

This patch adds the data and the two functions.
"bpf: Support BPF_REG_ARENA_SP in the verifier" emits the insns that use
them. Progs without r12 get the same code.

Memory:
 - A stack gets pages of the arena at its first use, in
   bpf_arena_stack_get(), and keeps them.
 - The bookkeeping has 152 bytes per cpu. It is in kernel memory, because
   the prog and user space can write to arena.
 - When there is no memory for a stack, the prog does not run. The kernel
   counts a miss and writes a message to the stderr of the prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h |  30 ++++++++++
 kernel/bpf/arena.c  | 133 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4c7c3f86ddbd..7437b42e0563 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -673,6 +673,31 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		      struct bpf_spin_lock *spin_lock);
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
+/*
+ * The stack in arena of a cpu. The invocation of a program that finds it free
+ * takes it. The others, that interrupt or preempt that one, take a stack from
+ * bpf_arena_stack_get(). bpf_insert_arena_stack() emits the code.
+ */
+struct bpf_arena_cpu_stack {
+	/*
+	 * Every invocation increments it. The one that finds 0 has the stack
+	 * and sets it to 0 when it exits.
+	 */
+	u64 busy;
+	u32 base;	/* r12 when the main program starts, the low 32 bits of the address */
+	u32 size;
+};
+
+/*
+ * r12 is a multiple of 32 when the main program starts in the stack of the cpu.
+ * It has this bit set in a stack from bpf_arena_stack_get().
+ */
+#define BPF_ARENA_STACK_SLOW 16
+
+int bpf_arena_stack_init(struct bpf_arena *arena);
+void __percpu *bpf_arena_stack_percpu(struct bpf_arena *arena);
+u64 bpf_arena_stack_get(struct bpf_prog_aux *aux, u64 busy);
+void bpf_arena_stack_put(struct bpf_prog_aux *aux, u32 base);
 u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
 struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
@@ -1918,6 +1943,11 @@ struct bpf_prog_aux {
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for freplace_link_cnt and prog_array_member_cnt */
 	struct bpf_arena *arena;
+	/*
+	 * The size of the stack in arena that the program needs, a multiple of
+	 * the page size. 0 when r12 is not used.
+	 */
+	u32 arena_stack_size;
 	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recursion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 868589f07330..8b99b3b6fa02 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -67,6 +67,33 @@ struct bpf_arena {
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
+	struct arena_stacks __percpu *stacks;
+};
+
+/*
+ * The stack in arena, see BPF_REG_ARENA_SP. An invocation of a program takes one
+ * when it starts and gives it back when it exits.
+ *
+ * Nothing here is in arena: the program and user space can write there.
+ *
+ * Invocations on a cpu don't nest: a program that is preempted or sleeps exits
+ * after the one that started later. Hence a bit per stack and not a counter.
+ * Programs don't migrate, so the stack is returned on the cpu it was taken on.
+ *
+ * Most of the time there is one invocation on a cpu. It takes the stack of
+ * the cpu, see struct bpf_arena_cpu_stack, and doesn't need these.
+ */
+#define ARENA_STACK_SLOTS 16
+
+struct arena_stack {
+	u32 base;	/* low 32 bits of r12 when the main program starts */
+	u32 size;	/* 0 until the first use */
+};
+
+struct arena_stacks {
+	struct bpf_arena_cpu_stack cpu;
+	unsigned long busy;
+	struct arena_stack slot[ARENA_STACK_SLOTS];
 };
 
 static void arena_free_worker(struct work_struct *work);
@@ -400,6 +427,7 @@ static void arena_map_free(struct bpf_map *map)
 	free_vm_area(arena->kern_vm);
 	range_tree_destroy(&arena->rt);
 	__free_page(arena->scratch_page);
+	free_percpu(arena->stacks);
 	bpf_map_area_free(arena);
 }
 
@@ -1028,6 +1056,111 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	irq_work_queue(&arena->free_irq);
 }
 
+/* Called when a program that uses BPF_REG_ARENA_SP is loaded */
+int bpf_arena_stack_init(struct bpf_arena *arena)
+{
+	struct arena_stacks __percpu *stacks;
+
+	if (READ_ONCE(arena->stacks))
+		return 0;
+	stacks = bpf_map_alloc_percpu(&arena->map, sizeof(*stacks), __alignof__(*stacks),
+				      GFP_USER | __GFP_NOWARN);
+	if (!stacks)
+		return -ENOMEM;
+	if (cmpxchg(&arena->stacks, NULL, stacks))
+		free_percpu(stacks);
+	return 0;
+}
+
+void __percpu *bpf_arena_stack_percpu(struct bpf_arena *arena)
+{
+	return arena->stacks;
+}
+
+/*
+ * Called at the start of the main program, in any context. When @busy is 0
+ * the program has taken the stack of the cpu and it's too small.
+ * Returns the low 32 bits of r12 with bit 32 set, since they may be 0, or 0 when
+ * there is no memory. The program doesn't run then.
+ */
+u64 bpf_arena_stack_get(struct bpf_prog_aux *aux, u64 busy)
+{
+	struct arena_stacks *stacks = this_cpu_ptr(aux->arena->stacks);
+	struct bpf_arena_cpu_stack *cpu = &stacks->cpu;
+	struct bpf_arena *arena = aux->arena;
+	u32 size = aux->arena_stack_size;
+	struct arena_stack *st = NULL;
+	struct bpf_stream_stage ss;
+	long addr;
+	int i;
+
+	if (!busy) {
+		/* It's not there yet, or programs that used it needed less */
+		addr = arena_alloc_pages(arena, 0, size >> PAGE_SHIFT, NUMA_NO_NODE, false);
+		if (!addr) {
+			WRITE_ONCE(cpu->busy, 0);
+			goto err;
+		}
+		if (cpu->size)
+			arena_free_pages(arena, cpu->base, (cpu->size + 64) >> PAGE_SHIFT, false);
+		/* r12 is not 0: neither at the start of the stack nor at the end */
+		cpu->base = addr + 32;
+		cpu->size = size - 64;
+		return BIT_ULL(32) | cpu->base;
+	}
+
+	while ((i = ffz(READ_ONCE(stacks->busy))) < ARENA_STACK_SLOTS) {
+		if (test_and_set_bit(i, &stacks->busy))
+			continue;
+		st = &stacks->slot[i];
+		if (st->size >= size)
+			return BIT_ULL(32) | st->base;
+		break;
+	}
+
+	/*
+	 * It's the first use of the slot, or programs that used it needed less,
+	 * or all slots are busy and bpf_arena_stack_put() is going to free the pages.
+	 */
+	addr = arena_alloc_pages(arena, 0, size >> PAGE_SHIFT, NUMA_NO_NODE, false);
+	if (!addr) {
+		if (st)
+			clear_bit(i, &stacks->busy);
+		goto err;
+	}
+	if (!st)
+		return BIT_ULL(32) | (u32)(addr + BPF_ARENA_STACK_SLOW);
+
+	if (st->size)
+		arena_free_pages(arena, st->base, st->size >> PAGE_SHIFT, false);
+	st->base = addr + BPF_ARENA_STACK_SLOW;
+	st->size = size;
+	return BIT_ULL(32) | st->base;
+
+err:
+	bpf_prog_inc_misses_counter(aux->prog);
+	bpf_stream_stage(ss, aux->prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: No memory for the stack in arena. The program didn't run\n");
+	}));
+	return 0;
+}
+
+/* Called before the main program exits with a stack from bpf_arena_stack_get() */
+void bpf_arena_stack_put(struct bpf_prog_aux *aux, u32 base)
+{
+	struct arena_stacks *stacks = this_cpu_ptr(aux->arena->stacks);
+	u32 size = aux->arena_stack_size;
+	int i;
+
+	for (i = 0; i < ARENA_STACK_SLOTS; i++) {
+		if (stacks->slot[i].base != base || !stacks->slot[i].size)
+			continue;
+		clear_bit(i, &stacks->busy);
+		return;
+	}
+	arena_free_pages(aux->arena, base, size >> PAGE_SHIFT, false);
+}
+
 /*
  * Reserve an arena virtual address range without populating it. This call stops
  * bpf_arena_alloc_pages from adding pages to this range.
-- 
2.55.0

