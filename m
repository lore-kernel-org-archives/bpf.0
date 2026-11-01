Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502367;
	b=04afm0z9Ia5uCzgi7qOUzCI+j7kSmN59eGfOHH9veC2fjxPPJQwaFz15K9la2j4UXpoe
	 GVWAndgys9AguwXHwZksnnZEvVZZLOgX1NBogNMcFGXMly+bcf4bK3B83Qtk86r4n62Ty
	 v+xieLDOjOUcPpmgvoi7ZS5V4XSPkznb6fQwTZpAkGq48+OKgXAmR6YNV964/yzIk4SnS
	 38kajWxcUzklQ5IyZAHxJh5ZIvwthcF/aOFxiUXoFRvt8Tr4A59fCFyUWoPUg9jxv4Qlt
	 82TCTr7sfRT89yB9PWXJiYjNDhMHgG3mBdgY6Avs7P07KnzPAgb2I3ecUBExnhNKctg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cmJUphV6YPhI2qZIALwEJoiem11BwO5ukrovDPLMk5I=;
	b=sxGQsTnI7AxWoFR3XLBkyoWOt7T8urbujU0iE6PGU4tGb0o+TPEKg20gmCIgR9uU4Xoy
	 wfQhGtFCXytuS4TAfG+Di1SFOQNnO4Hm7P/FTnrUT8itw+yvlpctcE03wIuW9S7govZxe
	 XrbO86eVCsFGwSDJxSGhJKd6k2IZIVi82dBijHpDLj5+hKLJERjkyrkWHZEpkgkGyere4
	 7Y7H+ZuxIzrdzyp3APO97YjxYzWNVfCuMOVw820gARFq7eSgCpWSSdD4IGtNWE9VZQKWy
	 7JP3/Y/6cKBfqNc/u7oGJNj4S037eWtRBoCdDSpA4IUXu/wdUmFbw8H82tOkIGDd3ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xHXp8KO;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D8606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 272D8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xHXp8KO
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e946155442so17053005ad.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502366; x=1794107166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmJUphV6YPhI2qZIALwEJoiem11BwO5ukrovDPLMk5I=;
        b=0xHXp8KOn4s2OGA1KsfgYX63uWCCNSJQMUkHbDgb3b+tgjmgLMYix1eIcOah+psv4U
         qEy59UIUgxFweRVmJeWDKWviibhN50XdzY2t+IDZFo/8zeqaCh3NU7BKAEHXWYLfGVYu
         nUDmbDQy7wMqcqw36VmOcKLtjLMY2hNVqiPOXG1tlkbIiLlv7TWS6LEn+IodUttiqbeB
         m9+xN3P8bHjudoMS0yVqa0G2zuF/aYdA9prF516i1I6O/9G4obCvu+ELeY6wli9u/yiP
         Jp98pVWIKGH7tMaiAUOMCaJ2iaaSwviPseGN38cfLVK+nBLd98ySUGk1c3+jV9v0pbfP
         lC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502366; x=1794107166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmJUphV6YPhI2qZIALwEJoiem11BwO5ukrovDPLMk5I=;
        b=hbKVbkyDIGmrLsFDyAg/kxbcYJz/0U2Rzb+EMe2xwRrIj/aTf5dkVnfL1VeIdDGOKn
         qU7EVzchMNOhjcHFfkhISplib2rvX+s4JtVhl6lzUiovbLBQp5yFpSA5b414JOvTIpCa
         BncmaTlLcY2F0oHrYI71UU43h97Z4XPD7a4Z7VSdyUHm5Uzu0+Ok37jneHxK6fJblcLF
         vras58VrCbUGeDTzmpwrap19SLtxRiLCAjz+HTPeVd5FmrMkME3kb9nXsppWD+yvwVGS
         Om+KduRKT5KY5GxwqN2XFQDTLLYRFUBmrQi9qNL8XiSSNqk1y5Jgw6TQrSYbk8Sqs4OO
         ywAg==
X-Gm-Message-State: APuU4Z8QCYp0f+yYEQFfplys9vhBFNW6srCQDUPyidQyIsxqw/X54apX
	GD2VuKzzCMl3hKXUDsFnAvHR0UCtFZpLOm/ZURXdroQoTgyU2GqNwJNT4si+9A==
X-Gm-Gg: AYBFou1VuiW5qqtHqnJQs4TBMmvqgSeWC8W9/+0JzwD0wgPAxrwmmIY9rHtr/RJFhgP
	fSiAcZDXylS6Gld+gDZCn/vC49Vo1xKD/Ht40whLZJfob1oYNBpzqhxK45Uhp0c8MFEIEcXMkgD
	HtfPwGYInIu5DduwL32LTZ0Z//wdSuNYLjkSW/foDogiMtSPclnsgay/aaNDkQKt/Qn45u8oyXS
	aHlv+yrNAz/qlTZ6V1vuhsnXQpMabLyCQsinPhQ0fCXXeRwBCgS9rXaE6JvU/fXwZbkyNQWGQNp
	/AbCiyMoiuKQrjKr2dNXY47/AbPFAb6EJkYScmEeWwasNCLEacoJ3zi9I4o9q0iePn8jfbnYHrH
	Fb87sPyoF2ULc0mymwXqNcXEBPX3QmCUZO8cWZkxTjnBlEaQMAXzuDbtdcdc7ekrCHzKnryXMnS
	ffgRWMs0ueepkWoZI9zsxYeUfWLl9ovvH9XS3tpNZ0Vwm/UH98fi+1vcfD3jKjVz7a/PsF259s9
	7z32FgK9MYpHpzRwoXurdJif+XGHnuD8vS2IEgb705fCcm7K2mLbW7To6kkju5fuKhreMlPVclX
	luKGjzPbSZFFI72a7UBr/OXeW5rUg2KrS0V0fy4JIaxZnn9c2D/SdXLLejU4dfJdGnRl11F36Lv
	oMzZDN7+aWSkOuJwc7xoeGZk1hCG+lfkSVxGEKcmkgQehurLlPr6W4HHrOB9htFJb6HtUy7mJiC
	QmURBKjDhpPp4WrPNQz68=
X-Received: by 2002:a17:90b:58cb:b0:3ac:a6a5:5743 with SMTP id 98e67ed59e1d1-3ae898168f4mr5071380a91.32.1793502366206;
        Sat, 31 Oct 2026 20:06:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm8724224a91.11.2026.10.31.20.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 09/14] bpf: Add stacks for programs to arena
Date: Sun,  1 Nov 2026 03:05:05 +0000
Message-ID: <20261101030511.1578690-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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
  new pages for this run    all 17 stacks are taken        1300 to 1600

The times are for x86-64 (Zen 5), in a KVM guest. The first time is the
difference to a prog that has the same variables in the r10 stack. The
third time is for a stack of 1 page.

Each run increments the per-cpu counter 'busy'. The run that finds 0 has
the per-cpu stack, and it stores 0 when it exits. The other runs call
bpf_arena_stack_get() and bpf_arena_stack_put(). One bit of r12,
BPF_ARENA_STACK_SLOW, shows at the exit which of the two ways is necessary.

The other choices:

  in this patch                  what was rejected, and why
  -----------------------------  ----------------------------------------
  The kernel supplies the        The compiler or libbpf supplies them:
  stacks, one set for each       the code that takes a stack is in each
  arena.                         object file, for ever.
  A stack is contiguous. It      4 fixed stacks per cpu: 512 Mbyte of
  has the size that the prog     addresses. Segments: each function can
  needs, 32 Kbyte at most. It    fail. Pages on a fault: a prog can fail
  gets pages at the first use.   in the middle of a run.
  The pages are regular pages    Pages that user space does not see: no
  of the arena.                  gain. User space can corrupt all other
                                 data of the prog.
  A run takes a stack: a         Preemption off: no sleepable progs. Two
  counter, then more stacks,     calls, get and put: 4 nsec. One way for
  then new pages.                sleepable progs and one for the others:
                                 two mechanisms. Skip the second run: not
                                 possible for a scheduler.

The third row is for a burst. The kernel frees pages of arena later, in
a work item. It takes 1700 to 2000 nsec more for each such run, on the same
cpu, and that is slower than the allocation. While all 17 stacks of
a cpu stay taken, runs that follow each other without a pause take pages
faster than the work item frees them. When the arena is full, runs are
skipped and allocations of the prog fail until the work item catches up.

This patch adds the data and the two functions.
"bpf: Support BPF_REG_ARENA_SP in the verifier" emits the insns that use
them. Progs without r12 get the same code.

Memory:
 - A stack gets pages of the arena at its first use, in
   bpf_arena_stack_get(), and keeps them.
 - The bookkeeping has 152 bytes per cpu. It is in kernel memory, because
   the prog and user space can write to arena.
 - struct bpf_arena has one more pointer and no longer fits in 512 bytes.
   Each arena, with or without stacks, takes 512 bytes more.
 - When there is no memory for a stack, the prog does not run. The kernel
   counts a miss and writes a message to the stderr of the prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h |  30 ++++++++++
 kernel/bpf/arena.c  | 142 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ff0436781293..1cd0f67a3f49 100644
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
+ * It has this bit set in all other stacks. They go back with bpf_arena_stack_put().
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
@@ -1909,6 +1934,11 @@ struct bpf_prog_aux {
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
index 3c61c181a6fa..99774f7eec86 100644
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
+ * Invocations on a cpu don't nest: a program that is preempted or sleeps can exit
+ * before the one that started later. Hence a bit per stack and not a counter.
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
 
@@ -1029,6 +1057,120 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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
+ * Called at the start of the main program or of a callback, in any context. When
+ * @busy is 0 the program has taken the stack of the cpu and it's too small.
+ * Returns the low 32 bits of r12 with bit 32 set, or 0 when there is no memory.
+ * The program doesn't run then.
+ */
+u64 bpf_arena_stack_get(struct bpf_prog_aux *aux, u64 busy)
+{
+	struct arena_stacks *stacks = this_cpu_ptr(aux->arena->stacks);
+	struct bpf_arena_cpu_stack *cpu = &stacks->cpu;
+	struct bpf_arena *arena = aux->arena;
+	u32 size = aux->arena_stack_size;
+	struct arena_stack *st = NULL, old;
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
+		old = (struct arena_stack){ cpu->base, cpu->size };
+		/* r12 is not 0: neither at the start of the stack nor at the end */
+		cpu->base = addr + 32;
+		cpu->size = size - 64;
+		if (old.size)
+			arena_free_pages(arena, old.base, (old.size + 64) >> PAGE_SHIFT, false);
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
+	/*
+	 * bpf_arena_stack_put() finds a slot by its base. No slot may name pages that
+	 * another run can get.
+	 */
+	old = *st;
+	st->base = addr + BPF_ARENA_STACK_SLOW;
+	st->size = size;
+	if (old.size)
+		arena_free_pages(arena, old.base, old.size >> PAGE_SHIFT, false);
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
+/*
+ * Called before the main program or a callback exits with a stack that is not
+ * the stack of the cpu: BPF_ARENA_STACK_SLOW is set in @base.
+ */
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

