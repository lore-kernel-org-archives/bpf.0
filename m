Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1E377016
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790255; cv=none; b=CV8dtnyAoCn6o/XzoxbsY5Tyhld8FjXDxQbDwh8tHSjT0B9vppWDB6rEnCXkAMy06osjdkYc6WE6hFhlKK4qq84eSURHZFvPHDlUFEiwGV5L53WSP5elNgD725w8ChdH5Vs2aSSdVHy8feqPfhmz9cmOhE6sReyDIiyNgaWHazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790255; c=relaxed/simple;
	bh=K7vVFJgYFtBzd4f+4loy/K7xD9XtlthuZycPO2xKeU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBr5qx+IN5NYfxrBrDQvRi7V4hXsj28w+NC1slAT81WOF2/bQ5eUiaLNXmhwOiKyMPlDQavhXPwtUrYMLgkoGgjpAJ3/1iS+iN7kuiIrEiLPJflSUNKAn3kUQiZUZTtt9+a3hMXG9xFYZJ7Th+G4ZuVmAcqSpQXSQIMvQlRprHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=S/ClsFfp; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="S/ClsFfp"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d9916deb14so8187419eec.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790251; x=1777395051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGkcS+pzecZOL0J1KVW5CfoAarQ6xMmTapKk9+ySCQU=;
        b=S/ClsFfpshpl4qoA+WcB3Byd+9u1MvnnMKLvpVIzm7M9vSgdHuNWHpe+MXcf1sjWSm
         O5GGxVhJlHFibSdruGjvOb/7xoevJtzIM4Az1w/VcoVpfpmWgoiT8DCfnTgeGNUoKwGv
         C7iqCfYmpYlUGOfLYOKacJpiNHpgvxXpu+jRsWJf2USt6Ezct5U7Ei3mjurbXx+IZBMN
         K1ImhxKMni6ZfeXvn2xadyh3i1hMVDH+p/KgWEJC4rtHFvL2c8vcI54RycDehuE8MvNl
         CkHQX3HXRpu/IymzZW93hlon+AXyTGUNJvjdq0eO3uW1u0NIbd8ByAVSutho9P72vDSy
         QfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790251; x=1777395051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGkcS+pzecZOL0J1KVW5CfoAarQ6xMmTapKk9+ySCQU=;
        b=NlRW5pHlVVue4sSqUahnP6FNcZ7OcFjvE1BG4yspzFJd/oKRwjd0ThqLu439c1fcyh
         gOE4R1uL8lG4F7la7n92m0ibn9iwDjHVeZHpn3wLG55NcdhW9rrs+i8XZLwurvSHadNk
         xyD3tn2VFTGZMtdBdlTWv4SQxw2A6zFBYk5IaI92hAKoNzr0hSueWLhWawABysywHJNk
         KtiTR86m8HmaH8i4tENK2INhAwuTMKuWBzayPt7UTTw2RWDUZgaWD8TXzxXzDCK21rAc
         XPn6O/g/4FkZ4BBFQ4AODRNCeTe09NBRqIJsae9NKXHzReR8nU5rzHHaW9jBm1EAs2Lo
         lA3Q==
X-Gm-Message-State: AOJu0YwcBEDqj9zyqU938d2M9kiSE3wIFR2IiQqlVrXDNtdHZXrr5pWb
	qBHEpeitGmKnbj5kHQhyVClYs3GRIQoucEQhaUrZi37VNX0/sY3aWruJiHZqYgqXEUq+HTLjZA2
	kblg9RgeH6QCj
X-Gm-Gg: AeBDievVJ5KKQV8A1yV6VgSEZ43G0GZz2ReaQCSJOGWNOA1hWL/eML8AZJbDtdArCIh
	QLHfNT/zz8Typetqqlbk0OzWPQke4BgFylUn/NisGPoZTEM5SaiglTSQ4q17jhOaRnmWharp97Q
	HDgxWHRnugrikza+bva45ubhTMOGISaAs7mgEVaCIdZVsUg9NehdWZ1KfUuUZ0OEW8iXKtu0BSa
	74tNitxWWi9eOA/taITrAZWpRild2aAZA+vxVymAvU1jnYTaOqzvJaZyPGecPMoG+flWCNVK5B6
	8WTNsteGAkJfDNcQBVxUvjbW4sDrk3SsDWlEkpLkSxKvT2zVX6Jy1eXznlmNbDP8wqhSPHgcE6l
	l3rXQgqGaiKysZCQOK3Vv83sbPcNRIUlSgWHPIL44aI0jL1Wu6j32zY+rV7G6/UaMybKGikadeP
	4hKThEIy64QDps9IpWXO+fsIeft9sljwhz128syEZo
X-Received: by 2002:a05:7300:5728:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2e479723e13mr10469513eec.14.1776790250136;
        Tue, 21 Apr 2026 09:50:50 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for libarena
Date: Tue, 21 Apr 2026 12:50:35 -0400
Message-ID: <20260421165037.4736-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a byte-oriented buddy allocator for libarena. The buddy
allocator provides an alloc/free interface for small arena allocations
ranging from 16 bytes to 512 KiB. Lower allocations values are rounded
up to 16 bytes. The buddy allocator does not handle larger allocations
that can instead use the existing bpf_arena_{alloc, free}_pages() kfunc.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/Makefile |   2 +
 .../selftests/bpf/libarena/include/buddy.h    |  92 ++
 .../selftests/bpf/libarena/include/common.h   |  14 +
 .../bpf/libarena/selftests/selftest.c         |   1 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 903 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |  23 +
 6 files changed, 1035 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index cbd23c928e53..4fe048ef57e9 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -51,6 +51,8 @@ ASAN_FLAGS += -mllvm -asan-destructor-kind=none
 override BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
 override BPF_CFLAGS += -O2 -g
 override BPF_CFLAGS += -Wno-incompatible-pointer-types-discards-qualifiers
+# Required to define our own arena-based free()
+override BPF_CFLAGS += -Wno-incompatible-library-redeclaration
 # Required for suppressing harmless vmlinux.h-related warnings.
 override BPF_CFLAGS += -Wno-missing-declarations
 override BPF_CFLAGS += $(INCLUDES)
diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tools/testing/selftests/bpf/libarena/include/buddy.h
new file mode 100644
index 000000000000..00e2437128ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/buddy.h
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+struct buddy_chunk;
+typedef struct buddy_chunk __arena buddy_chunk_t;
+
+struct buddy_header;
+typedef struct buddy_header __arena buddy_header_t;
+
+enum buddy_consts {
+	/*
+	 * Minimum allocation is 1 << BUDDY_MIN_ALLOC_SHIFT.
+	 * Larger sizes increase internal fragmentation, but smaller
+	 * sizes increase the space overhead of the block metadata.
+	 */
+	BUDDY_MIN_ALLOC_SHIFT	= 4,
+	BUDDY_MIN_ALLOC_BYTES	= 1 << BUDDY_MIN_ALLOC_SHIFT,
+
+	/*
+	 * How many orders the buddy allocator can serve. Minimum block
+	 * size is 1 << BUDDY_MIN_ALLOC_SHIFT, maximum block size is
+	 * 1 << (BUDDY_MIN_ALLOC_SHIFT + BUDDY_CHUNK_NUM_ORDERS - 1):
+	 * Each block has size 1 << BUDDY_MIN_ALLOC_SHIFT, and the
+	 * allocation orders are in [0, BUDDY_CHUNK_NUM_ORDERS).
+	 * We keep two blocks of the maximum size to retain the
+	 * property in the code that all blocks have a buddy.
+	 * Higher values increase the maximum allocation size,
+	 * but also the size of the metadata for each block.
+	 */
+	BUDDY_CHUNK_NUM_ORDERS	= 1 << 4,
+	BUDDY_CHUNK_BYTES	= BUDDY_MIN_ALLOC_BYTES << (BUDDY_CHUNK_NUM_ORDERS),
+
+	/* Offset of the buddy header within a free block, see buddy.bpf.c for details */
+	BUDDY_HEADER_OFF	= 8,
+
+	/* The maximum number of blocks a chunk may have to track. */
+	BUDDY_CHUNK_ITEMS	= 1 << (BUDDY_CHUNK_NUM_ORDERS),
+	BUDDY_CHUNK_OFFSET_MASK	= BUDDY_CHUNK_BYTES - 1,
+
+	/*
+	 * Alignment for chunk allocations based on bpf_arena_alloc_pages.
+	 * The arena allocation kfunc does not have an alignment argument,
+	 * but that is required for all block calculations in the chunk to
+	 * work.
+	 */
+	BUDDY_VADDR_OFFSET	= BUDDY_CHUNK_BYTES,
+
+	/* Total arena virtual address space the allocator can consume. */
+	BUDDY_VADDR_SIZE	= BUDDY_CHUNK_BYTES << 10
+};
+
+struct buddy_header {
+	u32 prev_index;	/* "Pointer" to the previous available allocation of the same size. */
+	u32 next_index; /* Same for the next allocation. */
+};
+
+/*
+ * We bring memory into the allocator 1 MiB at a time.
+ */
+struct buddy_chunk {
+	/* The order of the current allocation for a item. 4 bits per order. */
+	u8		orders[BUDDY_CHUNK_ITEMS / 2];
+	/*
+	 * Bit to denote whether chunk is allocated. Size of the allocated/free
+	 * chunk found from the orders array.
+	 */
+	u8		allocated[BUDDY_CHUNK_ITEMS / 8];
+	/* Freelists for O(1) allocation. */
+	u64		freelists[BUDDY_CHUNK_NUM_ORDERS];
+	buddy_chunk_t	*next;
+};
+
+struct buddy {
+	buddy_chunk_t *first_chunk;		/* Pointer to the chunk linked list. */
+	arena_spinlock_t lock;			/* Allocator lock */
+	u64 vaddr;				/* Allocation into reserved vaddr */
+};
+
+typedef struct buddy __arena buddy_t;
+
+#ifdef __BPF__
+
+int buddy_init(buddy_t *buddy);
+int buddy_destroy(buddy_t *buddy);
+int buddy_free_internal(buddy_t *buddy, u64 free);
+#define buddy_free(buddy, ptr) buddy_free_internal((buddy), (u64)(ptr))
+u64 buddy_alloc_internal(buddy_t *buddy, size_t size);
+#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
+
+
+#endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
index 7b2a91b85978..31c73b2db5bd 100644
--- a/tools/testing/selftests/bpf/libarena/include/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -42,6 +42,20 @@ extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
+u64 malloc_internal(size_t size);
+#define malloc(size) ((void __arena *)malloc_internal((size)))
+void free(void __arena *ptr);
+
+/*
+ * The verifier associates arenas with programs by checking LD.IMM
+ * instruction operands for an arena and populating the program state
+ * with the first instance it finds. This requires accessing our global
+ * arena variable, but subprogs do not necessarily do so while still
+ * using pointers from that arena. Insert an LD.IMM instruction  to
+ * access the arena and help the verifier.
+ */
+#define arena_subprog_init() do { asm volatile ("" :: "r"(&arena)); } while (0)
+
 #else /* ! __BPF__ */
 
 #include <stdint.h>
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index d1377d8073ef..4c95c36aa097 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -17,6 +17,7 @@
 
 #include <common.h>
 #include <asan.h>
+#include <buddy.h>
 #include <selftest_helpers.h>
 
 #ifdef BPF_ARENA_ASAN
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
new file mode 100644
index 000000000000..489b7383a53a
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -0,0 +1,903 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+#include <asan.h>
+#include <buddy.h>
+
+/*
+ * Buddy allocator arena-based implementation.
+ *
+ * Memory is organized into chunks. These chunks
+ * cannot be coalesced or split. Allocating
+ * chunks allocates their memory eagerly.
+ *
+ * Internally, each chunk is organized into blocks.
+ * Blocks _can_ be coalesced/split, but only inside
+ * the chunk. Each block can be allocated or
+ * unallocated. If allocated, the entire block holds
+ * user data. If unallocated, the block is mostly
+ * invalid memory, with the exception of a header
+ * used for freelist tracking.
+ *
+ * The header is placed at an offset inside the block
+ * to prevent off-by-one errors from the previous block
+ * from trivially overwriting the header. Such an error
+ * is also not catchable by ASAN, since the header remains
+ * valid memory even after the block is freed. It is still
+ * theoretically possible for the header to be corrupted
+ * without being caught by ASAN, but harder.
+ *
+ * Since the allocator needs to track order information for
+ * both allocated and free blocks, and allocated blocks cannot
+ * store a header, the allocator also stores per-chunk order
+ * information in a reserved region at the beginning of the
+ * chunk. The header includes a bitmap with the order of blocks
+ * and their allocation state. It also includes the freelist
+ * heads for the allocation itself.
+ */
+
+
+enum {
+	BUDDY_POISONED = (s8)0xef,
+
+	/* Number of pages to be allocated per chunk. */
+	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE
+};
+
+static inline int buddy_lock(buddy_t *buddy)
+{
+	return arena_spin_lock(&buddy->lock);
+}
+
+static inline void buddy_unlock(buddy_t *buddy)
+{
+	arena_spin_unlock(&buddy->lock);
+}
+
+/*
+ * Reserve part of the arena address space for the allocator. We use
+ * this to get aligned addresses for the chunks, since the arena
+ * page alloc kfuncs do not support aligning to a boundary (in this
+ * case 1 MiB, see buddy.h on how this is derived).
+ */
+static int buddy_reserve_arena_vaddr(buddy_t *buddy)
+{
+	buddy->vaddr = 0;
+
+	return bpf_arena_reserve_pages(&arena,
+				       (void __arena *)BUDDY_VADDR_OFFSET,
+				       BUDDY_VADDR_SIZE / __PAGE_SIZE);
+}
+
+/*
+ * Free up any unused address space. Used only during teardown.
+ */
+static void buddy_unreserve_arena_vaddr(buddy_t *buddy)
+{
+	bpf_arena_free_pages(
+		&arena, (void __arena *)(BUDDY_VADDR_OFFSET + buddy->vaddr),
+		(BUDDY_VADDR_SIZE - buddy->vaddr) / __PAGE_SIZE);
+
+	buddy->vaddr = 0;
+}
+
+/*
+ * Carve out part of the reserved address space and hand it over
+ * to the buddy allocator.
+ *
+ * We are assuming the buddy allocator is the only allocator in the
+ * system, so there is no race between this function reserving a
+ * page range and some other allocator actually making the BPF call
+ * to really create and reserve it.
+ *
+ * However, bump allocation must still be atomic because this function
+ * is called without the buddy lock from multiple threads concurrently.
+ */
+__weak int buddy_alloc_arena_vaddr(buddy_t __arg_arena *buddy, u64 *vaddrp)
+{
+	u64 vaddr, old, new;
+
+	if (!buddy || !vaddrp)
+		return -EINVAL;
+
+	do {
+		vaddr = buddy->vaddr;
+		new = vaddr + BUDDY_CHUNK_BYTES;
+
+		if (new > BUDDY_VADDR_SIZE)
+			return -EINVAL;
+
+		old = __sync_val_compare_and_swap(&buddy->vaddr, vaddr, new);
+	} while (old != vaddr && can_loop);
+
+	if (old != vaddr)
+		return -EINVAL;
+
+	*vaddrp = BUDDY_VADDR_OFFSET + vaddr;
+
+	return 0;
+}
+
+static u64 arena_next_pow2(__u64 n)
+{
+	n--;
+	n |= n >> 1;
+	n |= n >> 2;
+	n |= n >> 4;
+	n |= n >> 8;
+	n |= n >> 16;
+	n |= n >> 32;
+	n++;
+
+	return n;
+}
+
+__weak
+int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool allocated)
+{
+	bool already_allocated;
+
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting state of invalid idx (%ld, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	already_allocated = chunk->allocated[idx / 8] & (1 << (idx % 8));
+	if (unlikely(already_allocated == allocated)) {
+		arena_stderr("Double %s of idx %ld for chunk %p",
+				allocated ? "alloc" : "free",
+				idx, chunk);
+		return -EINVAL;
+	}
+
+	if (allocated)
+		chunk->allocated[idx / 8] |= 1 << (idx % 8);
+	else
+		chunk->allocated[idx / 8] &= ~(1 << (idx % 8));
+
+	return 0;
+}
+
+static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocated)
+{
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("getting state of invalid idx (%llu, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	*allocated = chunk->allocated[idx / 8] & (1 << (idx % 8));
+	return 0;
+}
+
+__weak
+int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
+{
+	u8 prev_order;
+
+	if (unlikely(order >= BUDDY_CHUNK_NUM_ORDERS)) {
+		arena_stderr("setting invalid order %u\n", order);
+		return -EINVAL;
+	}
+
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	/*
+	 * We store two order instances per byte, one per nibble.
+	 * Retain the existing nibble.
+	 */
+	prev_order = chunk->orders[idx / 2];
+	if (idx & 0x1) {
+		order &= 0xf;
+		order |= (prev_order & 0xf0);
+	} else {
+		order <<= 4;
+		order |= (prev_order & 0xf);
+	}
+
+	chunk->orders[idx / 2] = order;
+
+	return 0;
+}
+
+static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
+{
+	u8 result;
+
+	_Static_assert(BUDDY_CHUNK_NUM_ORDERS <= 16,
+		       "order must fit in 4 bits");
+
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("getting order of invalid idx %u\n", idx);
+		return BUDDY_CHUNK_NUM_ORDERS;
+	}
+
+	result = chunk->orders[idx / 2];
+
+	return (idx & 0x1) ? (result & 0xf) : (result >> 4);
+}
+
+static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
+{
+	u64 address;
+
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("translating invalid idx %u\n", idx);
+		return NULL;
+	}
+
+	/*
+	 * The data blocks start in the chunk after the metadata block.
+	 * We find the actual address by indexing into the region at an
+	 * BUDDY_MIN_ALLOC_BYTES granularity, the minimum allowed.
+	 * The index number already accounts for the fact that the first
+	 * blocks in the chunk are occupied by the metadata, so we do
+	 * not need to offset it.
+	 */
+
+	address = (u64)chunk + (idx * BUDDY_MIN_ALLOC_BYTES);
+
+	return (void __arena *)address;
+}
+
+static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
+{
+	bool allocated;
+	u64 address;
+
+	if (unlikely(idx_is_allocated(chunk, idx, &allocated))) {
+		arena_stderr("accessing invalid idx 0x%lx\n", idx);
+		return NULL;
+	}
+
+	if (unlikely(allocated)) {
+		arena_stderr("accessing allocated idx 0x%lx as header\n", idx);
+		return NULL;
+	}
+
+	address = (u64)idx_to_addr(chunk, idx);
+	if (!address)
+		return NULL;
+
+	/*
+	 * Offset the header within the block. This avoids accidental overwrites
+	 * to the header because of off-by-one errors when using adjacent blocks.
+	 *
+	 * The offset has been chosen as a compromise between ASAN effectiveness
+	 * and allocator granularity:
+	 * 1) ASAN dictates valid data runs are 8-byte aligned.
+	 * 2) We want to keep a low minimum allocation size (currently 16).
+	 *
+	 * As a result, we have only two possible positions for the header: Bytes
+	 * 0 and 8. Keeping the header in byte 0 means off-by-ones from the previous
+	 * block touch the header, and, since the header must be accessible, ASAN
+	 * will not trigger. Keeping the header on byte 8 means off-by-one errors from
+	 * the previous block are caught by ASAN. Negative offsets are rarer, so
+	 * while accesses into the block from the next block are possible, they are
+	 * less probable.
+	 */
+
+	return (buddy_header_t *)(address + BUDDY_HEADER_OFF);
+}
+
+static void header_add_freelist(buddy_chunk_t *chunk, buddy_header_t *header,
+		u64 idx, u8 order)
+{
+	buddy_header_t *tmp_header;
+
+	idx_set_order(chunk, idx, order);
+
+	header->next_index = chunk->freelists[order];
+	header->prev_index = BUDDY_CHUNK_ITEMS;
+
+	if (header->next_index != BUDDY_CHUNK_ITEMS) {
+		tmp_header = idx_to_header(chunk, header->next_index);
+		tmp_header->prev_index = idx;
+	}
+
+	chunk->freelists[order] = idx;
+}
+
+static void header_remove_freelist(buddy_chunk_t  *chunk,
+				   buddy_header_t *header, u8 order)
+{
+	buddy_header_t *tmp_header;
+
+	if (header->prev_index != BUDDY_CHUNK_ITEMS) {
+		tmp_header = idx_to_header(chunk, header->prev_index);
+		tmp_header->next_index = header->next_index;
+	}
+
+	if (header->next_index != BUDDY_CHUNK_ITEMS) {
+		tmp_header = idx_to_header(chunk, header->next_index);
+		tmp_header->prev_index = header->prev_index;
+	}
+
+	/* Pop off the list head if necessary. */
+	if (idx_to_header(chunk, chunk->freelists[order]) == header)
+		chunk->freelists[order] = header->next_index;
+
+	header->prev_index = BUDDY_CHUNK_ITEMS;
+	header->next_index = BUDDY_CHUNK_ITEMS;
+}
+
+static u64 size_to_order(size_t size)
+{
+	u64 order;
+
+	/*
+	 * Legal sizes are [1, 4GiB] (the biggest possible arena).
+	 * Of course, sizes close to GiB are practically impossible
+	 * to fulfill and allocation will fail, but that's taken care
+	 * of by the caller.
+	 */
+
+	if (unlikely(size == 0 || size > (1UL << 32))) {
+		arena_stderr("illegal size request %lu\n", size);
+		return 64;
+	}
+	/*
+	 * To find the order of the allocation we find the first power of two
+	 * >= the requested size, take the log2, then adjust it for the minimum
+	 * allocation size by removing the minimum shift from it. Requests
+	 * smaller than the minimum allocation size are rounded up.
+	 */
+	order = arena_fls(arena_next_pow2(size)) - 1;
+	if (order < BUDDY_MIN_ALLOC_SHIFT)
+		return 0;
+
+	return order - BUDDY_MIN_ALLOC_SHIFT;
+}
+
+__weak
+int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_idx,
+		u64 min_order, u64 max_order)
+{
+	buddy_header_t *header;
+	u64 ord;
+	u32 idx;
+
+	for (ord = min_order; ord < max_order && can_loop; ord++) {
+		/* Mark the buddy as free and add it to the freelists. */
+		idx = cur_idx + (1 << ord);
+
+		header = idx_to_header(chunk, idx);
+		if (unlikely(!header)) {
+			arena_stderr("idx %u has no header", idx);
+			return -EINVAL;
+		}
+
+		asan_unpoison(header, sizeof(*header));
+
+		header_add_freelist(chunk, header, idx, ord);
+	}
+
+	return 0;
+}
+
+static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
+{
+	u64 order, ord, min_order, max_order;
+	buddy_chunk_t  *chunk;
+	size_t left;
+	int power2;
+	u64 vaddr;
+	u32 idx;
+	int ret;
+
+	/*
+	 * Step 1:  Allocate a properly aligned chunk, and
+	 * prep it for insertion into the buddy allocator.
+	 * We don't need the allocator lock until step 2.
+	 */
+
+	ret = buddy_alloc_arena_vaddr(buddy, &vaddr);
+	if (ret)
+		return NULL;
+
+	/* Addresses must be aligned to the chunk boundary. */
+	if (vaddr % BUDDY_CHUNK_BYTES)
+		return NULL;
+
+	/* Unreserve the address space. */
+	bpf_arena_free_pages(&arena, (void __arena *)vaddr,
+			     BUDDY_CHUNK_PAGES);
+
+	chunk = bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
+				      BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0);
+	if (!chunk) {
+		arena_stderr("[ALLOC FAILED]");
+		return NULL;
+	}
+
+	if (buddy_lock(buddy)) {
+		/*
+		 * We cannot reclaim the vaddr space, but that is ok - this
+		 * operation should always succeed. The error path is to catch
+		 * accidental deadlocks that will cause -ENOMEMs to the program as
+		 * the allocator fails to refill itself, in which case vaddr usage
+		 * is the least of our worries.
+		 */
+		bpf_arena_free_pages(&arena, (void __arena *)vaddr, BUDDY_CHUNK_PAGES);
+		return NULL;
+	}
+
+	asan_poison(chunk, BUDDY_POISONED, BUDDY_CHUNK_PAGES * __PAGE_SIZE);
+
+	/* Unpoison the chunk itself. */
+	asan_unpoison(chunk, sizeof(*chunk));
+
+	/* Mark all freelists as empty. */
+	for (ord = zero; ord < BUDDY_CHUNK_NUM_ORDERS && can_loop; ord++)
+		chunk->freelists[ord] = BUDDY_CHUNK_ITEMS;
+
+	/*
+	 * Initialize the chunk by carving out a page range to hold the metadata
+	 * struct above, then dumping the rest of the pages into the allocator.
+	 */
+
+	_Static_assert(BUDDY_CHUNK_PAGES * __PAGE_SIZE >=
+			       BUDDY_MIN_ALLOC_BYTES *
+				       BUDDY_CHUNK_ITEMS,
+		       "chunk must fit within the allocation");
+
+	/*
+	 * Step 2: Reserve a chunk for the chunk metadata, then breaks
+	 * the rest of the full allocation into the different buckets.
+	 * We allocating the memory by grabbing blocks of progressively
+	 * smaller sizes from the allocator, which are guaranteed to be
+	 * continuous.
+	 *
+	 * This operation also populates the allocator.
+	 *
+	 * Algorithm:
+	 *
+	 * - max_order: The last order allocation we made
+	 * - left: How many bytes are left to allocate
+	 * - cur_index: Current index into the top-level block we are
+	 * allocating from.
+	 *
+	 * Step 3:
+	 * - Find the largest power-of-2 allocation still smaller than left (infimum)
+	 * - Reserve a chunk of that size, along with its buddy
+	 * - For every order from [infimum + 1, last order), carve out a block
+	 *   and put it into the allocator.
+	 *
+	 *  Example: Chunk size 0b1010000 (80 bytes)
+	 *
+	 *  Step 1:
+	 *
+	 *   idx  infimum                             1 << max_order
+	 *   0        64        128                    1 << 20
+	 *   |________|_________|______________________|
+	 *
+	 *   Blocks set aside:
+	 *   	[0, 64)         - Completely allocated
+	 *   	[64, 128)       - Will be further split in the next iteration
+	 *
+	 *   Blocks added to the allocator:
+	 *   	[128, 256)
+	 *   	[256, 512)
+	 *   	...
+	 *   	[1 << 18, 1 << 19)
+	 *   	[1 << 19, 1 << 20)
+	 *
+	 *  Step 2:
+	 *
+	 *   idx  infimum			   idx + 1 << max_order
+	 *   64	      80	96		   	64 + 1 << 6 = 128
+	 *   |________|_________|______________________|
+	 *
+	 *   Blocks set aside:
+	 *   	[64, 80)	- Completely allocated
+	 *
+	 *   Blocks added to the allocator:
+	 *      [80, 96) - left == 0 so the buddy is unused and marked as freed
+	 *   	[96, 128)
+	 */
+	 max_order = BUDDY_CHUNK_NUM_ORDERS;
+	left = sizeof(*chunk);
+	idx = 0;
+	while (left && can_loop) {
+		power2 = arena_fls(left) - 1;
+		/*
+		 * Note: The condition below only triggers to catch serious bugs
+		 * early. There is no sane way to undo any block insertions from
+		 * the allocated chunk, so just leak any leftover allocations,
+		 * emit a diagnostic, unlock and exit.
+		 *
+		 */
+		if (unlikely(power2 >= BUDDY_CHUNK_NUM_ORDERS)) {
+			arena_stderr(
+				"buddy chunk metadata require allocation of order %d\n",
+				power2);
+			arena_stderr(
+				"chunk has size of 0x%lx bytes (left %lx bytes)\n",
+				sizeof(*chunk), left);
+			buddy_unlock(buddy);
+
+			return NULL;
+		}
+
+		/* Round up allocations that are too small. */
+
+		left -= (power2 >= BUDDY_MIN_ALLOC_SHIFT) ? 1 << power2 : left;
+		order = (power2 >= BUDDY_MIN_ALLOC_SHIFT) ? power2 - BUDDY_MIN_ALLOC_SHIFT : 0;
+
+		if (idx_set_allocated(chunk, idx, true)) {
+			buddy_unlock(buddy);
+			return NULL;
+		}
+
+		/*
+		 * Starting an order above the one we allocated, populate
+		 * the allocator with free blocks. If this is the last
+		 * allocation (left == 0), also mark the buddy as free.
+		 *
+		 * See comment above about error handling: The error path
+		 * is only there as a way to mitigate deeply buggy allocator
+		 * states by emitting a diagnostic in add_leftovers_to_freelist()
+		 * and leaking any memory not added in the freelists.
+		 */
+		min_order = left ? order + 1 : order;
+		if (add_leftovers_to_freelist(chunk, idx, min_order, max_order)) {
+			buddy_unlock(buddy);
+			return NULL;
+		}
+
+		/* Adjust the index. */
+		idx += 1 << order;
+		max_order = order;
+	}
+
+	buddy_unlock(buddy);
+
+	return chunk;
+}
+
+__weak int buddy_init(buddy_t __arg_arena *buddy)
+{
+	buddy_chunk_t *chunk;
+	int ret;
+
+	if (!asan_ready())
+		return -EINVAL;
+
+	/* Reserve enough address space to ensure allocations are aligned. */
+	ret = buddy_reserve_arena_vaddr(buddy);
+	if (ret)
+		return ret;
+
+	_Static_assert(BUDDY_CHUNK_PAGES > 0,
+		       "chunk must use one or more pages");
+
+	chunk = buddy_chunk_get(buddy);
+
+	if (buddy_lock(buddy)) {
+		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
+		return -EINVAL;
+	}
+
+	/* Chunk is already properly unpoisoned if allocated. */
+	if (chunk)
+		chunk->next = buddy->first_chunk;
+
+	/* Put the chunk at the beginning of the list. */
+	buddy->first_chunk = chunk;
+
+	buddy_unlock(buddy);
+
+	return chunk ? 0 : -ENOMEM;
+}
+
+/*
+ * Destroy the allocator. This does not check whether there are any allocations
+ * currently in use, so any pages being accessed will start taking arena faults.
+ * We do not take a lock because we are freeing arena pages, and nobody should
+ * be using the allocator at that point in the execution.
+ */
+__weak int buddy_destroy(buddy_t __arg_arena *buddy)
+{
+	buddy_chunk_t *chunk, *next;
+
+	if (!buddy)
+		return -EINVAL;
+
+	/*
+	 * Traverse all buddy chunks and free them back to the arena
+	 * with the same granularity they were allocated with.
+	 */
+	for (chunk = buddy->first_chunk; chunk && can_loop; chunk = next) {
+		next = chunk->next;
+
+		/* Wholesale poison the entire block. */
+		asan_poison(chunk, BUDDY_POISONED,
+			    BUDDY_CHUNK_PAGES * __PAGE_SIZE);
+		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
+	}
+
+	/* Free up any part of the address space that did not get used. */
+	buddy_unreserve_arena_vaddr(buddy);
+
+	/* Clear all fields. */
+	buddy->first_chunk = NULL;
+
+	return 0;
+}
+
+__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order_req)
+{
+	buddy_header_t *header, *tmp_header, *next_header;
+	u32 idx, tmpidx, retidx;
+	u64 address;
+	u64 order = 0;
+	u64 i;
+
+	for (order = order_req; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
+		if (chunk->freelists[order] != BUDDY_CHUNK_ITEMS)
+			break;
+	}
+
+	if (order >= BUDDY_CHUNK_NUM_ORDERS)
+		return (u64)NULL;
+
+	retidx = chunk->freelists[order];
+	header = idx_to_header(chunk, retidx);
+	if (unlikely(!header))
+		return (u64) NULL;
+
+	chunk->freelists[order] = header->next_index;
+
+	if (header->next_index != BUDDY_CHUNK_ITEMS) {
+		next_header = idx_to_header(chunk, header->next_index);
+		next_header->prev_index = BUDDY_CHUNK_ITEMS;
+	}
+
+	header->prev_index = BUDDY_CHUNK_ITEMS;
+	header->next_index = BUDDY_CHUNK_ITEMS;
+	if (idx_set_order(chunk, retidx, order_req))
+		return (u64)NULL;
+
+	if (idx_set_allocated(chunk, retidx, true))
+		return (u64)NULL;
+
+	/*
+	 * Do not unpoison the address yet, will be done by the caller
+	 * because the caller has the exact allocation size requested.
+	 */
+	address = (u64)idx_to_addr(chunk, retidx);
+	if (!address)
+		return (u64)NULL;
+
+	/* If we allocated from a larger-order chunk, split the buddies. */
+	for (i = order_req; i < order && can_loop; i++) {
+		/*
+		 * Flip the bit for the current order (the bit is guaranteed
+		 * to be 0, so just add 1 << i).
+		 */
+		idx = retidx + (1 << i);
+
+		/* Add the buddy of the allocation to the free list. */
+		header = idx_to_header(chunk, idx);
+		/* Unpoison the buddy header */
+		asan_unpoison(header, sizeof(*header));
+
+		if (idx_set_order(chunk, idx, i))
+			return (u64)NULL;
+
+		/* Push the header to the beginning of the freelists list. */
+		tmpidx = chunk->freelists[i];
+
+		header->prev_index = BUDDY_CHUNK_ITEMS;
+		header->next_index = tmpidx;
+
+		if (tmpidx != BUDDY_CHUNK_ITEMS) {
+			tmp_header = idx_to_header(chunk, tmpidx);
+			tmp_header->prev_index = idx;
+		}
+
+		chunk->freelists[i] = idx;
+	}
+
+	return address;
+}
+
+/* Scan the existing chunks for available memory. */
+static u64 buddy_alloc_from_existing_chunks(buddy_t *buddy, int order)
+{
+	buddy_chunk_t *chunk;
+	u64 address;
+
+	for (chunk = buddy->first_chunk; chunk != NULL && can_loop;
+	     chunk = chunk->next) {
+		address = buddy_chunk_alloc(chunk, order);
+		if (address)
+			return address;
+	}
+
+	return (u64)NULL;
+}
+
+/*
+ * Try an allocation from a newly allocated chunk. Also
+ * incorporate the chunk into the linked list.
+ */
+static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chunk, int order)
+{
+	u64 address;
+
+	if (buddy_lock(buddy))
+		return (u64)NULL;
+
+
+	/*
+	 * Add the chunk into the allocator and try
+	 * to allocate specifically from that chunk.
+	 */
+	chunk->next = buddy->first_chunk;
+	buddy->first_chunk = chunk;
+
+	address = buddy_chunk_alloc(buddy->first_chunk, order);
+
+	buddy_unlock(buddy);
+
+	return (u64)address;
+}
+__weak
+u64 buddy_alloc_internal(buddy_t __arg_arena *buddy, size_t size)
+{
+	buddy_chunk_t *chunk;
+	u64 address = (u64)NULL;
+	int order;
+
+	if (!buddy)
+		return (u64)NULL;
+
+	order = size_to_order(size);
+	if (order >= BUDDY_CHUNK_NUM_ORDERS || order < 0) {
+		arena_stderr("invalid order %d (sz %lu)\n", order, size);
+		return (u64)NULL;
+	}
+
+	if (buddy_lock(buddy))
+		return (u64)NULL;
+
+	address = buddy_alloc_from_existing_chunks(buddy, order);
+	buddy_unlock(buddy);
+	if (address)
+		goto done;
+
+	/* Get a new chunk. */
+	chunk = buddy_chunk_get(buddy);
+	if (chunk)
+		address = buddy_alloc_from_new_chunk(buddy, chunk, order);
+
+done:
+	/* If we failed to allocate memory, return NULL. */
+	if (!address)
+		return (u64)NULL;
+
+	/*
+	 * Unpoison exactly the amount of bytes requested. If the
+	 * data is smaller than the header, we must poison any
+	 * unused bytes that were part of the header.
+	 */
+	if (size < BUDDY_HEADER_OFF + sizeof(buddy_header_t))
+		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF,
+			    BUDDY_POISONED, sizeof(buddy_header_t));
+
+	asan_unpoison((u8 __arena *)address, size);
+
+	return address;
+}
+
+static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
+{
+	buddy_header_t *header, *buddy_header;
+	u64 idx, buddy_idx, tmp_idx;
+	buddy_chunk_t *chunk;
+	bool allocated;
+	u8 order;
+	int ret;
+
+	if (!buddy)
+		return -EINVAL;
+
+	if (addr & (BUDDY_MIN_ALLOC_BYTES - 1)) {
+		arena_stderr("Freeing unaligned address %llx\n", addr);
+		return -EINVAL;
+	}
+
+	/* Get (chunk, idx) out of the address. */
+	chunk = (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	/* Mark the block as unallocated so we can access the header. */
+	ret = idx_set_allocated(chunk, idx, false);
+	if (ret)
+		return ret;
+
+	order  = idx_get_order(chunk, idx);
+	header = idx_to_header(chunk, idx);
+
+	/* The header is in the block itself, keep it unpoisoned. */
+	asan_poison((u8 __arena *)addr, BUDDY_POISONED,
+		    BUDDY_MIN_ALLOC_BYTES << order);
+	asan_unpoison(header, sizeof(*header));
+
+	/*
+	 * Coalescing loop. Merge with free buddies of equal order.
+	 * For every coalescing step, keep the left buddy and
+	 * drop the right buddy's header.
+	 */
+	for (; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
+		buddy_idx = idx ^ (1 << order);
+
+		/* Check if the buddy is actually free. */
+		idx_is_allocated(chunk, buddy_idx, &allocated);
+		if (allocated)
+			break;
+
+		/*
+		 * If buddy is not the same order as the chunk
+		 * being freed, then we're done coalescing.
+		 */
+		if (idx_get_order(chunk, buddy_idx) != order)
+			break;
+
+		buddy_header = idx_to_header(chunk, buddy_idx);
+		header_remove_freelist(chunk, buddy_header, order);
+
+		/* Keep the left header out of the two buddies, drop the other one. */
+		if (buddy_idx < idx) {
+			tmp_idx = idx;
+			idx = buddy_idx;
+			buddy_idx = tmp_idx;
+		}
+
+		/* Remove the buddy from the freelists so that we can merge it. */
+		idx_set_order(chunk, buddy_idx, order);
+
+		buddy_header = idx_to_header(chunk, buddy_idx);
+		asan_poison(buddy_header, BUDDY_POISONED,
+			    sizeof(*buddy_header));
+	}
+
+	/* Header properly freed but not in any freelists yet .*/
+	idx_set_order(chunk, idx, order);
+
+	header = idx_to_header(chunk, idx);
+	header_add_freelist(chunk, header, idx, order);
+
+	return 0;
+}
+
+__weak int buddy_free_internal(buddy_t __arg_arena *buddy, u64 addr)
+{
+	int ret;
+
+	if (!buddy)
+		return -EINVAL;
+
+	/* Freeing NULL is a valid no-op. */
+	if (!addr)
+		return 0;
+
+	ret = buddy_lock(buddy);
+	if (ret)
+		return ret;
+
+	ret = buddy_free_unlocked(buddy, addr);
+
+	buddy_unlock(buddy);
+
+	return ret;
+}
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 1c185b75d799..e142c9594b5c 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <common.h>
+#include <asan.h>
+#include <buddy.h>
 
 #include <asan.h>
 
 const volatile u32 zero = 0;
 
+buddy_t buddy;
+
 /* How many pages do we reserve at the beginning of the arena segment? */
 #define RESERVE_ALLOC (8)
 
@@ -61,4 +65,23 @@ __weak int arena_alloc_reserve(void)
 	return bpf_arena_reserve_pages(&arena, NULL, RESERVE_ALLOC);
 }
 
+SEC("syscall")
+__weak int arena_buddy_reset(void)
+{
+	buddy_destroy(&buddy);
+
+	return buddy_init(&buddy);
+}
+
+__weak u64 malloc_internal(size_t size)
+{
+	return buddy_alloc_internal(&buddy, size);
+}
+
+__weak void free(void __arg_arena __arena *ptr)
+{
+	buddy_free_internal(&buddy, (u64)ptr);
+}
+
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

