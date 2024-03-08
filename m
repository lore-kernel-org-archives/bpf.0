Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3021342
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860103; cv=none; b=bk80Gq2ZMjAcoRVq/hztFft3NVGVV+CwjTK0/XWRbcLEk4594yEtxlIb2GWrHbVqxIvC/dq4KtLeF3QEDP3ALptE8zLDofj760tVsQAsgC/tOsgBkubNp2INC2brbymgGteqF1mEOVZuik+qImIiiC8t76kGUAXp/HL5wM9MWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860103; c=relaxed/simple;
	bh=nWMNS3BXSkAfCRPymd6t88kNyZ/QjdrXCst/A/j6w84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPZ65b0bsh4odzDP3hq7T9aYW1jvxrJOS+fKSTr6FVCTZRpBPlTL35nturYgHlGT1Np370XbFQ0cwYZdVwRHiuX3SrDyU37HWohaECXZUyNt0jT1XNkykIjMdaunzL6xL191pavQe6ON0yi5eQS3CQX27WSqTlKqugcVgQ0Dx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT5zKNmW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT5zKNmW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc5d0162bcso2599355ad.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860100; x=1710464900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtleqlVAE25DskLHp5/WHdwalSclPvstnTFd3je4hQM=;
        b=bT5zKNmWCm2YyrWcuow44zCTEanOUVdy043pRocahLVLeq6A5goyu0DL1XG8Vjgd1M
         XU9ymhCfBrtoBEEYNAmZHy8d4vElxdp/h1Odhnc29PvlmVSR1Isr8HqeL9VpNrh3LIbx
         3v52W71vy+MkhDMmBiCRXYEgZTmY4rRluhZ4eW0K+UWWHWCY1/blWidUdg9qzpWjEWWz
         Sd1vu4qIeIzwv6oQSR//Fb54JPbASVHKqHeHspLSZa3NY1uw6gLiwpxj/eIoAvB8oEom
         6r5hlfTdTAkQhNUe2Ln8iDysifsCWPWYHv24tMhYI45Jm8XPWSCcqts9mi1W23fmniF/
         NztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860100; x=1710464900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtleqlVAE25DskLHp5/WHdwalSclPvstnTFd3je4hQM=;
        b=swZHyJzsZdN5oqnDADWxXJHYcTIP0cryTLMB1rPZpcFY2SuSWN73jUy4c35gfz7jSz
         L4omucM86cbnmBDMdWQBoK1+6VbXX5mM/eqOnWbi13HlgAwMiNHlhzHPyplpx4Enua/x
         bXmY/I37yX9udGgm8usOk1u8NW1WL8ba97YS3GAv7D8zUoSKO8Isa35OaOniwVhJUHbb
         CQmmxoqh8meZ6TfegResJ2V7dfEJyVsZ7xUOajf8pVW7BkrFre16mTBD8xeHnq1u7whg
         DFZWe7LUjQ37pr5ZtRIjkzALI11OfQejMS2gLISCfhZDRd5wke0Ek5vCYsg1c7Qp2Gwt
         RDxQ==
X-Gm-Message-State: AOJu0YzFKIQhnn3oMINp7zyTFyEOcT4y8N7sBr1RJHgVuyt9oqEizib4
	oP35DCmO5dVutwKrfmLHn8p2Fca2A+fu+PZvOzCc3LklC+MJ9Xd6B9YFQSix
X-Google-Smtp-Source: AGHT+IFGaXmvZiG3Xgb6OvGMWcDQAMJ6F4O95gtPpkktlT0BxdfVIwwiKhbbxXasI3FrDROwYL8AvA==
X-Received: by 2002:a17:902:ecc1:b0:1dc:1e7c:cd3 with SMTP id a1-20020a170902ecc100b001dc1e7c0cd3mr11098122plh.47.1709860099919;
        Thu, 07 Mar 2024 17:08:19 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001db81640315sm15237376plh.91.2024.03.07.17.08.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 01/14] bpf: Introduce bpf_arena.
Date: Thu,  7 Mar 2024 17:07:59 -0800
Message-Id: <20240308010812.89848-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce bpf_arena, which is a sparse shared memory region between the bpf
program and user space.

Use cases:
1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed
   anonymous region, like memcached or any key/value storage. The bpf
   program implements an in-kernel accelerator. XDP prog can search for
   a key in bpf_arena and return a value without going to user space.
2. The bpf program builds arbitrary data structures in bpf_arena (hash
   tables, rb-trees, sparse arrays), while user space consumes it.
3. bpf_arena is a "heap" of memory from the bpf program's point of view.
   The user space may mmap it, but bpf program will not convert pointers
   to user base at run-time to improve bpf program speed.

Initially, the kernel vm_area and user vma are not populated. User space
can fault in pages within the range. While servicing a page fault,
bpf_arena logic will insert a new page into the kernel and user vmas. The
bpf program can allocate pages from that region via
bpf_arena_alloc_pages(). This kernel function will insert pages into the
kernel vm_area. The subsequent fault-in from user space will populate that
page into the user vma. The BPF_F_SEGV_ON_FAULT flag at arena creation time
can be used to prevent fault-in from user space. In such a case, if a page
is not allocated by the bpf program and not present in the kernel vm_area,
the user process will segfault. This is useful for use cases 2 and 3 above.

bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pages
either at a specific address within the arena or allocates a range with the
maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees
pages and removes the range from the kernel vm_area and from user process
vmas.

bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of
bpf program is more important than ease of sharing with user space. This is
use case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended.
It will tell the verifier to treat the rX = bpf_arena_cast_user(rY)
instruction as a 32-bit move wX = wY, which will improve bpf prog
performance. Otherwise, bpf_arena_cast_user is translated by JIT to
conditionally add the upper 32 bits of user vm_start (if the pointer is not
NULL) to arena pointers before they are stored into memory. This way, user
space sees them as valid 64-bit pointers.

Diff https://github.com/llvm/llvm-project/pull/84410 enables LLVM BPF
backend generate the bpf_addr_space_cast() instruction to cast pointers
between address_space(1) which is reserved for bpf_arena pointers and
default address space zero. All arena pointers in a bpf program written in
C language are tagged as __attribute__((address_space(1))). Hence, clang
provides helpful diagnostics when pointers cross address space. Libbpf and
the kernel support only address_space == 1. All other address space
identifiers are reserved.

rX = bpf_addr_space_cast(rY, /* dst_as */ 1, /* src_as */ 0) tells the
verifier that rX->type = PTR_TO_ARENA. Any further operations on
PTR_TO_ARENA register have to be in the 32-bit domain. The verifier will
mark load/store through PTR_TO_ARENA with PROBE_MEM32. JIT will generate
them as kern_vm_start + 32bit_addr memory accesses. The behavior is similar
to copy_from_kernel_nofault() except that no address checks are necessary.
The address is guaranteed to be in the 4GB range. If the page is not
present, the destination register is zeroed on read, and the operation is
ignored on write.

rX = bpf_addr_space_cast(rY, 0, 1) tells the verifier that rX->type =
unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then the
verifier converts such cast instructions to mov32. Otherwise, JIT will emit
native code equivalent to:
rX = (u32)rY;
if (rY)
  rX |= clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in rX */

After such conversion, the pointer becomes a valid user pointer within
bpf_arena range. The user process can access data structures created in
bpf_arena without any additional computations. For example, a linked list
built by a bpf program can be walked natively by user space.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |   7 +-
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  10 +
 kernel/bpf/Makefile            |   3 +
 kernel/bpf/arena.c             | 558 +++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  11 +
 kernel/bpf/syscall.c           |  36 +++
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |  10 +
 9 files changed, 635 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/arena.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 95e07673cdc1..ea6ab6e0eef9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -37,6 +37,7 @@ struct perf_event;
 struct bpf_prog;
 struct bpf_prog_aux;
 struct bpf_map;
+struct bpf_arena;
 struct sock;
 struct seq_file;
 struct btf;
@@ -528,8 +529,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		      struct bpf_spin_lock *spin_lock);
-
-
+u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
+u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
@@ -2215,6 +2216,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
+			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG_KMEM
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 94baced5a1ad..9f2a6b83b49e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -132,6 +132,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 85ec7fc799d7..e30d943db8a4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1009,6 +1009,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_ARENA,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -1396,6 +1397,12 @@ enum {
 
 /* BPF token FD is passed in a corresponding command's token_fd field */
 	BPF_F_TOKEN_FD          = (1U << 16),
+
+/* When user space page faults in bpf_arena send SIGSEGV instead of inserting new page */
+	BPF_F_SEGV_ON_FAULT	= (1U << 17),
+
+/* Do not translate kernel bpf_arena pointers to user pointers */
+	BPF_F_NO_USER_CONV	= (1U << 18),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1467,6 +1474,9 @@ union bpf_attr {
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
 		 * number of hash functions (if 0, the bloom filter will default
 		 * to using 5 hash functions).
+		 *
+		 * BPF_MAP_TYPE_ARENA - contains the address where user space
+		 * is going to mmap() the arena. It has to be page aligned.
 		 */
 		__u64	map_extra;
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4ce95acfcaa7..368c5d86b5b7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -15,6 +15,9 @@ obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
+ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
+obj-$(CONFIG_BPF_SYSCALL) += arena.o
+endif
 obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
new file mode 100644
index 000000000000..86571e760dd6
--- /dev/null
+++ b/kernel/bpf/arena.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/err.h>
+#include <linux/btf_ids.h>
+#include <linux/vmalloc.h>
+#include <linux/pagemap.h>
+
+/*
+ * bpf_arena is a sparsely populated shared memory region between bpf program and
+ * user space process.
+ *
+ * For example on x86-64 the values could be:
+ * user_vm_start 7f7d26200000     // picked by mmap()
+ * kern_vm_start ffffc90001e69000 // picked by get_vm_area()
+ * For user space all pointers within the arena are normal 8-byte addresses.
+ * In this example 7f7d26200000 is the address of the first page (pgoff=0).
+ * The bpf program will access it as: kern_vm_start + lower_32bit_of_user_ptr
+ * (u32)7f7d26200000 -> 26200000
+ * hence
+ * ffffc90001e69000 + 26200000 == ffffc90028069000 is "pgoff=0" within 4Gb
+ * kernel memory region.
+ *
+ * BPF JITs generate the following code to access arena:
+ *   mov eax, eax  // eax has lower 32-bit of user pointer
+ *   mov word ptr [rax + r12 + off], bx
+ * where r12 == kern_vm_start and off is s16.
+ * Hence allocate 4Gb + GUARD_SZ/2 on each side.
+ *
+ * Initially kernel vm_area and user vma are not populated.
+ * User space can fault-in any address which will insert the page
+ * into kernel and user vma.
+ * bpf program can allocate a page via bpf_arena_alloc_pages() kfunc
+ * which will insert it into kernel vm_area.
+ * The later fault-in from user space will populate that page into user vma.
+ */
+
+/* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
+#define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
+#define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)
+
+struct bpf_arena {
+	struct bpf_map map;
+	u64 user_vm_start;
+	u64 user_vm_end;
+	struct vm_struct *kern_vm;
+	struct maple_tree mt;
+	struct list_head vma_list;
+	struct mutex lock;
+};
+
+u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
+{
+	return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
+}
+
+u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
+{
+	return arena ? arena->user_vm_start : 0;
+}
+
+static long arena_map_peek_elem(struct bpf_map *map, void *value)
+{
+	return -EOPNOTSUPP;
+}
+
+static long arena_map_push_elem(struct bpf_map *map, void *value, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static long arena_map_pop_elem(struct bpf_map *map, void *value)
+{
+	return -EOPNOTSUPP;
+}
+
+static long arena_map_delete_elem(struct bpf_map *map, void *value)
+{
+	return -EOPNOTSUPP;
+}
+
+static int arena_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static long compute_pgoff(struct bpf_arena *arena, long uaddr)
+{
+	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
+}
+
+static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
+{
+	struct vm_struct *kern_vm;
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_arena *arena;
+	u64 vm_range;
+	int err = -ENOMEM;
+
+	if (attr->key_size || attr->value_size || attr->max_entries == 0 ||
+	    /* BPF_F_MMAPABLE must be set */
+	    !(attr->map_flags & BPF_F_MMAPABLE) ||
+	    /* No unsupported flags present */
+	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_NO_USER_CONV)))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->map_extra & ~PAGE_MASK)
+		/* If non-zero the map_extra is an expected user VMA start address */
+		return ERR_PTR(-EINVAL);
+
+	vm_range = (u64)attr->max_entries * PAGE_SIZE;
+	if (vm_range > (1ull << 32))
+		return ERR_PTR(-E2BIG);
+
+	if ((attr->map_extra >> 32) != ((attr->map_extra + vm_range - 1) >> 32))
+		/* user vma must not cross 32-bit boundary */
+		return ERR_PTR(-ERANGE);
+
+	kern_vm = get_vm_area(KERN_VM_SZ, VM_SPARSE | VM_USERMAP);
+	if (!kern_vm)
+		return ERR_PTR(-ENOMEM);
+
+	arena = bpf_map_area_alloc(sizeof(*arena), numa_node);
+	if (!arena)
+		goto err;
+
+	arena->kern_vm = kern_vm;
+	arena->user_vm_start = attr->map_extra;
+	if (arena->user_vm_start)
+		arena->user_vm_end = arena->user_vm_start + vm_range;
+
+	INIT_LIST_HEAD(&arena->vma_list);
+	bpf_map_init_from_attr(&arena->map, attr);
+	mt_init_flags(&arena->mt, MT_FLAGS_ALLOC_RANGE);
+	mutex_init(&arena->lock);
+
+	return &arena->map;
+err:
+	free_vm_area(kern_vm);
+	return ERR_PTR(err);
+}
+
+static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
+{
+	struct page *page;
+	pte_t pte;
+
+	pte = ptep_get(ptep);
+	if (!pte_present(pte)) /* sanity check */
+		return 0;
+	page = pte_page(pte);
+	/*
+	 * We do not update pte here:
+	 * 1. Nobody should be accessing bpf_arena's range outside of a kernel bug
+	 * 2. TLB flushing is batched or deferred. Even if we clear pte,
+	 * the TLB entries can stick around and continue to permit access to
+	 * the freed page. So it all relies on 1.
+	 */
+	__free_page(page);
+	return 0;
+}
+
+static void arena_map_free(struct bpf_map *map)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	/*
+	 * Check that user vma-s are not around when bpf map is freed.
+	 * mmap() holds vm_file which holds bpf_map refcnt.
+	 * munmap() must have happened on vma followed by arena_vm_close()
+	 * which would clear arena->vma_list.
+	 */
+	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
+		return;
+
+	/*
+	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
+	 * It unmaps everything from vmalloc area and clears pgtables.
+	 * Call apply_to_existing_page_range() first to find populated ptes and
+	 * free those pages.
+	 */
+	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
+				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
+	free_vm_area(arena->kern_vm);
+	mtree_destroy(&arena->mt);
+	bpf_map_area_free(arena);
+}
+
+static void *arena_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static long arena_map_update_elem(struct bpf_map *map, void *key,
+				  void *value, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static int arena_map_check_btf(const struct bpf_map *map, const struct btf *btf,
+			       const struct btf_type *key_type, const struct btf_type *value_type)
+{
+	return 0;
+}
+
+static u64 arena_map_mem_usage(const struct bpf_map *map)
+{
+	return 0;
+}
+
+struct vma_list {
+	struct vm_area_struct *vma;
+	struct list_head head;
+};
+
+static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
+{
+	struct vma_list *vml;
+
+	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
+	if (!vml)
+		return -ENOMEM;
+	vma->vm_private_data = vml;
+	vml->vma = vma;
+	list_add(&vml->head, &arena->vma_list);
+	return 0;
+}
+
+static void arena_vm_close(struct vm_area_struct *vma)
+{
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct vma_list *vml;
+
+	guard(mutex)(&arena->lock);
+	vml = vma->vm_private_data;
+	list_del(&vml->head);
+	vma->vm_private_data = NULL;
+	kfree(vml);
+}
+
+#define MT_ENTRY ((void *)&arena_map_ops) /* unused. has to be valid pointer */
+
+static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
+{
+	struct bpf_map *map = vmf->vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct page *page;
+	long kbase, kaddr;
+	int ret;
+
+	kbase = bpf_arena_get_kern_vm_start(arena);
+	kaddr = kbase + (u32)(vmf->address & PAGE_MASK);
+
+	guard(mutex)(&arena->lock);
+	page = vmalloc_to_page((void *)kaddr);
+	if (page)
+		/* already have a page vmap-ed */
+		goto out;
+
+	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
+		/* User space requested to segfault when page is not allocated by bpf prog */
+		return VM_FAULT_SIGSEGV;
+
+	ret = mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL);
+	if (ret)
+		return VM_FAULT_SIGSEGV;
+
+	/* Account into memcg of the process that created bpf_arena */
+	ret = bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE, 1, &page);
+	if (ret) {
+		mtree_erase(&arena->mt, vmf->pgoff);
+		return VM_FAULT_SIGSEGV;
+	}
+
+	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	if (ret) {
+		mtree_erase(&arena->mt, vmf->pgoff);
+		__free_page(page);
+		return VM_FAULT_SIGSEGV;
+	}
+out:
+	page_ref_add(page, 1);
+	vmf->page = page;
+	return 0;
+}
+
+static const struct vm_operations_struct arena_vm_ops = {
+	.close		= arena_vm_close,
+	.fault          = arena_vm_fault,
+};
+
+static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long addr,
+					     unsigned long len, unsigned long pgoff,
+					     unsigned long flags)
+{
+	struct bpf_map *map = filp->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	long ret;
+
+	if (pgoff)
+		return -EINVAL;
+	if (len > (1ull << 32))
+		return -E2BIG;
+
+	/* if user_vm_start was specified at arena creation time */
+	if (arena->user_vm_start) {
+		if (len > arena->user_vm_end - arena->user_vm_start)
+			return -E2BIG;
+		if (len != arena->user_vm_end - arena->user_vm_start)
+			return -EINVAL;
+		if (addr != arena->user_vm_start)
+			return -EINVAL;
+	}
+
+	ret = current->mm->get_unmapped_area(filp, addr, len * 2, 0, flags);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	if ((ret >> 32) == ((ret + len - 1) >> 32))
+		return ret;
+	if (WARN_ON_ONCE(arena->user_vm_start))
+		/* checks at map creation time should prevent this */
+		return -EFAULT;
+	return round_up(ret, 1ull << 32);
+}
+
+static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	guard(mutex)(&arena->lock);
+	if (arena->user_vm_start && arena->user_vm_start != vma->vm_start)
+		/*
+		 * If map_extra was not specified at arena creation time then
+		 * 1st user process can do mmap(NULL, ...) to pick user_vm_start
+		 * 2nd user process must pass the same addr to mmap(addr, MAP_FIXED..);
+		 *   or
+		 * specify addr in map_extra and
+		 * use the same addr later with mmap(addr, MAP_FIXED..);
+		 */
+		return -EBUSY;
+
+	if (arena->user_vm_end && arena->user_vm_end != vma->vm_end)
+		/* all user processes must have the same size of mmap-ed region */
+		return -EBUSY;
+
+	/* Earlier checks should prevent this */
+	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > (1ull << 32) || vma->vm_pgoff))
+		return -EFAULT;
+
+	if (remember_vma(arena, vma))
+		return -ENOMEM;
+
+	arena->user_vm_start = vma->vm_start;
+	arena->user_vm_end = vma->vm_end;
+	/*
+	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
+	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
+	 * potential change of user_vm_start.
+	 */
+	vm_flags_set(vma, VM_DONTEXPAND);
+	vma->vm_ops = &arena_vm_ops;
+	return 0;
+}
+
+static int arena_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
+{
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
+		return -ERANGE;
+	*imm = (unsigned long)arena->user_vm_start;
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(bpf_arena_map_btf_ids, struct, bpf_arena)
+const struct bpf_map_ops arena_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc = arena_map_alloc,
+	.map_free = arena_map_free,
+	.map_direct_value_addr = arena_map_direct_value_addr,
+	.map_mmap = arena_map_mmap,
+	.map_get_unmapped_area = arena_get_unmapped_area,
+	.map_get_next_key = arena_map_get_next_key,
+	.map_push_elem = arena_map_push_elem,
+	.map_peek_elem = arena_map_peek_elem,
+	.map_pop_elem = arena_map_pop_elem,
+	.map_lookup_elem = arena_map_lookup_elem,
+	.map_update_elem = arena_map_update_elem,
+	.map_delete_elem = arena_map_delete_elem,
+	.map_check_btf = arena_map_check_btf,
+	.map_mem_usage = arena_map_mem_usage,
+	.map_btf_id = &bpf_arena_map_btf_ids[0],
+};
+
+static u64 clear_lo32(u64 val)
+{
+	return val & ~(u64)~0U;
+}
+
+/*
+ * Allocate pages and vmap them into kernel vmalloc area.
+ * Later the pages will be mmaped into user space vma.
+ */
+static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id)
+{
+	/* user_vm_end/start are fixed before bpf prog runs */
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct page **pages;
+	long pgoff = 0;
+	u32 uaddr32;
+	int ret, i;
+
+	if (page_cnt > page_cnt_max)
+		return 0;
+
+	if (uaddr) {
+		if (uaddr & ~PAGE_MASK)
+			return 0;
+		pgoff = compute_pgoff(arena, uaddr);
+		if (pgoff + page_cnt > page_cnt_max)
+			/* requested address will be outside of user VMA */
+			return 0;
+	}
+
+	/* zeroing is needed, since alloc_pages_bulk_array() only fills in non-zero entries */
+	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return 0;
+
+	guard(mutex)(&arena->lock);
+
+	if (uaddr)
+		ret = mtree_insert_range(&arena->mt, pgoff, pgoff + page_cnt - 1,
+					 MT_ENTRY, GFP_KERNEL);
+	else
+		ret = mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
+					page_cnt, 0, page_cnt_max - 1, GFP_KERNEL);
+	if (ret)
+		goto out_free_pages;
+
+	ret = bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZERO,
+				  node_id, page_cnt, pages);
+	if (ret)
+		goto out;
+
+	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
+	/* Earlier checks make sure that uaddr32 + page_cnt * PAGE_SIZE will not overflow 32-bit */
+	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
+				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
+	if (ret) {
+		for (i = 0; i < page_cnt; i++)
+			__free_page(pages[i]);
+		goto out;
+	}
+	kvfree(pages);
+	return clear_lo32(arena->user_vm_start) + uaddr32;
+out:
+	mtree_erase(&arena->mt, pgoff);
+out_free_pages:
+	kvfree(pages);
+	return 0;
+}
+
+/*
+ * If page is present in vmalloc area, unmap it from vmalloc area,
+ * unmap it from all user space vma-s,
+ * and free it.
+ */
+static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
+{
+	struct vma_list *vml;
+
+	list_for_each_entry(vml, &arena->vma_list, head)
+		zap_page_range_single(vml->vma, uaddr,
+				      PAGE_SIZE * page_cnt, NULL);
+}
+
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
+{
+	u64 full_uaddr, uaddr_end;
+	long kaddr, pgoff, i;
+	struct page *page;
+
+	/* only aligned lower 32-bit are relevant */
+	uaddr = (u32)uaddr;
+	uaddr &= PAGE_MASK;
+	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
+	if (full_uaddr >= uaddr_end)
+		return;
+
+	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
+
+	guard(mutex)(&arena->lock);
+
+	pgoff = compute_pgoff(arena, uaddr);
+	/* clear range */
+	mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL, GFP_KERNEL);
+
+	if (page_cnt > 1)
+		/* bulk zap if multiple pages being freed */
+		zap_pages(arena, full_uaddr, page_cnt);
+
+	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
+	for (i = 0; i < page_cnt; i++, kaddr += PAGE_SIZE, full_uaddr += PAGE_SIZE) {
+		page = vmalloc_to_page((void *)kaddr);
+		if (!page)
+			continue;
+		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
+			zap_pages(arena, full_uaddr, 1);
+		vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE);
+		__free_page(page);
+	}
+}
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
+					int node_id, u64 flags)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
+		return NULL;
+
+	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id);
+}
+
+__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
+		return;
+	arena_free_pages(arena, (long)ptr__ign, page_cnt);
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(arena_kfuncs)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_KFUNCS_END(arena_kfuncs)
+
+static const struct btf_kfunc_id_set common_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &arena_kfuncs,
+};
+
+static int __init kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+}
+late_initcall(kfunc_init);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 134b7979f537..a8ecf69c7754 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2976,6 +2976,17 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
 {
 }
 
+/* for configs without MMU or 32-bit */
+__weak const struct bpf_map_ops arena_map_ops;
+__weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
+{
+	return 0;
+}
+__weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
+{
+	return 0;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 static int __init bpf_global_ma_init(void)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f63f4da4db5e..67923e41a07e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -164,6 +164,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	if (bpf_map_is_offloaded(map)) {
 		return bpf_map_offload_update_elem(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
+		   map->map_type == BPF_MAP_TYPE_ARENA ||
 		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
 		return map->ops->map_update_elem(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
@@ -479,6 +480,39 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
+int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
+			unsigned long nr_pages, struct page **pages)
+{
+	unsigned long i, j;
+	struct page *pg;
+	int ret = 0;
+#ifdef CONFIG_MEMCG_KMEM
+	struct mem_cgroup *memcg, *old_memcg;
+
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
+#endif
+	for (i = 0; i < nr_pages; i++) {
+		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+
+		if (pg) {
+			pages[i] = pg;
+			continue;
+		}
+		for (j = 0; j < i; j++)
+			__free_page(pages[j]);
+		ret = -ENOMEM;
+		break;
+	}
+
+#ifdef CONFIG_MEMCG_KMEM
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+#endif
+	return ret;
+}
+
+
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
@@ -1176,6 +1210,7 @@ static int map_create(union bpf_attr *attr)
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
+	    attr->map_type != BPF_MAP_TYPE_ARENA &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
@@ -1265,6 +1300,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
+	case BPF_MAP_TYPE_ARENA:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf084c693507..fbcf2e5e635a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18108,6 +18108,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_CGRP_STORAGE:
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
+		case BPF_MAP_TYPE_ARENA:
 			break;
 		default:
 			verbose(env,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 85ec7fc799d7..e30d943db8a4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1009,6 +1009,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_ARENA,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -1396,6 +1397,12 @@ enum {
 
 /* BPF token FD is passed in a corresponding command's token_fd field */
 	BPF_F_TOKEN_FD          = (1U << 16),
+
+/* When user space page faults in bpf_arena send SIGSEGV instead of inserting new page */
+	BPF_F_SEGV_ON_FAULT	= (1U << 17),
+
+/* Do not translate kernel bpf_arena pointers to user pointers */
+	BPF_F_NO_USER_CONV	= (1U << 18),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1467,6 +1474,9 @@ union bpf_attr {
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
 		 * number of hash functions (if 0, the bloom filter will default
 		 * to using 5 hash functions).
+		 *
+		 * BPF_MAP_TYPE_ARENA - contains the address where user space
+		 * is going to mmap() the arena. It has to be page aligned.
 		 */
 		__u64	map_extra;
 
-- 
2.43.0

