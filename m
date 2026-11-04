Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755499;
	b=EYKNY7xqXa/VKnD+oS1Ad6Oo15S5uNZEyR6ZKjLDBZjzQFu/usCL2A4kubZjUMiNG/dp
	 NttPRCHMeDTKwEsoJCc15lahQNJnXaGTctzJP/c7Ap9cKbiGoFXUyK/Ugqf6u/pIiYObF
	 bRmTLgTOGO1C7Cz6HPy2eh4WgbgM62ryYhLkFeeTt//Uw10eeY9Ce2/309MiT2aVZX1c4
	 lyrEvzl6jFkaukmPLcyum34WsXf4NCvTwfsrvn1iZIyRBkedqpM1V8Xow35Xoc5nWlp3r
	 Nna5s/RTjto7+oRCicGKrgR6raFVH7dow4ifchqjUHDP78JaTfgG0BXRzVN2IWLpLgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BLJT5BQ3sZlbL0+7LTOlKEOu3PRLlLyTi3WyzGCbJQ0=;
	b=Iy+5sqMsXa1sUS3DXUxjknP7B8z9A8qnrzHPL5N/F3VKHEBLkr45kk9W+WVIFRWHjXUu
	 PdMDGcVcVFD2LE924Yyrma5DK7rGKAK67rbEJi8vCxBVwyl6ihKSl4I8SpxBAZwy4s7sn
	 9arOuxzLKv+LxlmtgkfXlO4QB0kvMzID1HeWDyAg6GZqQsSe6rXu6N6MQZP48juh7iZt9
	 CaeVKSHpBQD09LnVxKKpDTuLYfLAa3gJSTG5lzSyN1fdYVbYLNP6u1CmwegEiFBwMR5On
	 uo1oCNb3utoGb5iiR6kgVYf1nBvDPnrULTtz6prG7Qo/DMxvPFPBXxjVQvf+dq7B/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfRdudsP;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC629606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC629606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfRdudsP
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso131468a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755498; x=1794360298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLJT5BQ3sZlbL0+7LTOlKEOu3PRLlLyTi3WyzGCbJQ0=;
        b=JfRdudsPzj9CxvbIr39W3aq/1H9Vmb/X5h4WjXWUokqfY7c4Dbc6ayqjnG/u0iGUt+
         bbSkBAYpmhDwoDgJQgeWQfjG7t4ywuOR47vYVHP0wtlOh6ilV3ZJmiCqjgLP7jFTLyQy
         XWUXJvaSe9OWcf2teW0Rl8c6QYOqMc3oyUbmsY0ZTDQTlYeEnT7i+I5MprVf2d5psK4z
         HSw9C62PwNrLvu7S2B9cBY75/CosPgMcYX7pdsT/x8nFkSsVqkYheoiAxEhGivThE727
         vsHBTK5pJRJu96e7VDov9//BLaO3mWp1h5JsWv550v2RYJm21lqu3jTBB1hmshzqAqn/
         JgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755498; x=1794360298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLJT5BQ3sZlbL0+7LTOlKEOu3PRLlLyTi3WyzGCbJQ0=;
        b=HnFuVjY+hWTQW3c9V/hdUkguRjQ6sRLUS8YtVb/TxPtiEZNMrem53WHzyoJiSsDJra
         jo+6yUQS88kI+7ewab7yPWdEKiL33mST+nutnoC13ILcnSI4Qz0LkBBKu86sHAnX+rvn
         R57pNepER5XqlbA/sxvBT+EJzfVrM4xis2Vy27KfBVHKhBX974Ak2tmYB7Nj6YAVxonx
         7oQDg5TGJ2JAMBayi/tfw7pXuKDTs1Twa8FjNNk3r7jEgG3XgN1FAefefRWDdhEWNDPd
         J15FVHdrU2WTDEnIC9PSN2JcySI8xhFEVhPwVV6GuvfIzyO1U6kswQiPdHt5fOTQ2lnV
         vBGg==
X-Gm-Message-State: APuU4Z+UDotljGyyN+wQu8pk3KIYaTALyFOSlzwXZU0IRifELvIWTX8S
	TSjoJLbgHPnFsOVRXZQlzjxeDUo9XSVSwCn71S17edjeOiukNok9T41RXIE+tg==
X-Gm-Gg: AYBFou0lX92z6cIEScBDhqU9YPExKt2/msf2Zvb374Bfo63g69zE4KpChsZ61L5dIMf
	l3r28DNXc0DnEkVOWfSGtLstQeaz4xJM3Z3TtY3GJ6yj+QCuxazrUxK1T9qa7zCJFUXQDnxUbgV
	HZ+p7ar/IIBbykHhot62hV3WXkJolVwPY9Bm3cnsj6RULGwJGLrqP4nOun7n0gr5DKaF4Wv8Onr
	V0iZOAoHiGsCL5pqLM3zJA78jz6DvbhStmZOU+oVAAuiSI/Ef8bsk5P1/Rn5fbwSmMqLPFcUIrc
	VdO9YgA+RZCw8vnQc0CCAZbvqVLBlZ26QCbwF0ehOrLoppGtbxmH/V4x93rJ9akefBo+tzDTFsg
	TARHOpaf797pRfs7AAWdmIW2OkzkDQFF72859ViWTXpZEUxL8Necz3xrnPCpupVk10aGPJeYAo2
	0DXlKsRt7BAOFPDoyIzHL9eX6KlR+X+j7/3p7lRvjOuDiCtI1U8yNUfrruDWFQ5o9PVDrX8l0wX
	3DCAM8eOxKB86uobPi9EtkVAukXaJU+DoTOkbuYMDSyBP/V8y1DZauRJg4ep15MsoByOsb0WN9c
	63WIHhQtw/o4v6IjAgZxuTRE8a4Q8UZbKTlqrJL1xC/U3e5Ncb64tjm+ALusxfLPS7skml7np+x
	C5w9OGEyFW/q0s+FPvsXYNm7hrGzb08oe7CAJm/V4+jIYnNN7m/urpFaaLI233UJB9Ih2eooGIY
	Y=
X-Received: by 2002:a17:90b:134f:b0:3ac:7613:1ec3 with SMTP id 98e67ed59e1d1-3ae897e081cmr10583587a91.37.1793755497884;
        Tue, 03 Nov 2026 17:24:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094ce9f65sm698378a91.1.2026.11.03.17.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 09/14] bpf: Add stacks for programs to arena
Date: Wed,  4 Nov 2026 01:23:55 +0000
Message-ID: <20261104012401.1354861-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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
  needs: 32 Kbyte of frames at   fail. Pages on a fault: a prog can fail
  most. It gets pages at the     in the middle of a run.
  first use.
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
   bpf_arena_stack_get(), and keeps them until a prog needs a larger stack.
 - The bookkeeping has 152 bytes per cpu. It is in kernel memory, because
   the prog and user space can write to arena.
 - struct bpf_arena has one more pointer and no longer fits in 512 bytes.
   Each arena, with or without stacks, takes 512 bytes more.
 - When there is no memory for a stack, the prog does not run. The kernel
   counts a miss and writes a message to the stderr of the prog. A callback
   that gets no stack does not run either: it returns 0 to the helper, and
   the prog continues.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h |  30 ++++++++++
 kernel/bpf/arena.c  | 142 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5413fa5d2b2b..5c059a05f89d 100644
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
@@ -1919,6 +1944,11 @@ struct bpf_prog_aux {
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
index ec2bda1a6ebf..366c4c2b6a41 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -68,6 +68,33 @@ struct bpf_arena {
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
@@ -401,6 +428,7 @@ static void arena_map_free(struct bpf_map *map)
 	free_vm_area(arena->kern_vm);
 	range_tree_destroy(&arena->rt);
 	__free_page(arena->scratch_page);
+	free_percpu(arena->stacks);
 	bpf_map_area_free(arena);
 }
 
@@ -1040,6 +1068,120 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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

