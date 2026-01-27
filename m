Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A312327BEC
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537798; cv=none; b=TSnfUdFMCGT4yJVcAhfUipMd8FB+VUQonHWxXg5VVdPMrPKusHQIXN811nG52c1OZJJw9579ND62fVIWnr2OkhQgzQlDQLkbadXIjBsLpRBZdcginM9Bxu89teROVm7QJu0DPmGMzmsueX/zSqJTaQoLB1czSWZ/TWvBzHKXtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537798; c=relaxed/simple;
	bh=91wwKrkS1WWQCJoLI22YnfSus9hKdwyx16p/ZrqooM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc0suRCKss9OURmQvHzZkDKZO5K3dhvnsWu0aRwYf7wfjgKCFhwqwWxAfE3RVHRM1M3iJmkGqBdns7polZdZzkZFytXShMujIoZ46oeFMV3F5keJ+0W0a9oVStNIg7ksN7ETfVXA50Vvo+JIHmrLyytTZOGL8D2NoMkOLOKZBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=aefWrFGB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="aefWrFGB"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50335b926c2so3047911cf.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537795; x=1770142595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB7+gxiGZzG4Dpdlgh7RCihRm3zfQ6Z9kjqwpMEe910=;
        b=aefWrFGBpKJmuAydSBTQctipOR63GnZ670tKI6BdMu0xWaOl9N8xgqf8Mey9F4YV+Q
         D5sKPHKUoINwI25Jeq29qOw+lguYndVMNr7q8t88eyjaHGEUePpt05drHT6+Aq+f4JfF
         hnUeNYs/M9oiJ7Jq3Verw4AV9ZHyewjx9SQ8YY+cRah3Ga1i0IwRW9nHzftDJz+gPBic
         1naZJzxVJFerpulaJVhhaLXCal6/wzJ/NgP2JYsoeQ3TEWKIMoXIwYmItRaGb5+Dlt05
         zIXZ1Z0Dxryz6WAcNqodF3xuSRcRLQv+D7Gpr1UeNoq8YaGRRkoN1F4+0F8ARhbz+0Vg
         w1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537795; x=1770142595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nB7+gxiGZzG4Dpdlgh7RCihRm3zfQ6Z9kjqwpMEe910=;
        b=K4JR4yjQ3JoSjivCOpeVkMpNg9fJk6lCODwHlUSFPJdnhU361QOyXbCCYPUSQdihLu
         4jyZKFAkl8xnncBERZUyridHeBmZCnqemzfa8Cexf/1Dci8ojuYc3kPzNJeaq7e2bHlG
         7xQMhEr5TI1fauV80EF/glvCOvcKz0mNBLKlTO3R1igaXSIayZWFxBkUbdNkGu9k/45l
         9bSteZgOvWyjVC5z+N1axlyRn3HschV8XRDT88uPi3rM2jGMK9JMFXYofDNqNBKM0tiQ
         76gCuRQ2jWfpSOESemNk6R+e6oVRP5TEJcicgA8lr0F1jfLbd+gFp/cl8zxeMqXvC/lR
         6Jpg==
X-Gm-Message-State: AOJu0Yw5ZlgiYWzaJSQlhDgXYn3N7H/xvvERTnNctlrKYup9nbDy/IxY
	H1hB6k12afHtsNr2NpNiWgZqHoJcxob1tQ/szAPtm6re09EmL7ghB45E3vRV9p/g0RkwSHz8SVY
	cUKG+
X-Gm-Gg: AZuq6aJO9LXS9TQRtkSVytq7Uq3um1YvVW94FedkcD7In434xO+OvorOdRqgKn9zcMO
	JG3A2VipG9k8XQm11ofyIoRk980zar1M2TPQMx2odNhnSY+a91gm40ynZ4j/RqbXgkNkGVBN/8s
	yBTS7iFc2qbexZQCO8DEIU6wqYca+DJRD2KvbJbnx21nwsq7vJ+MlK3k4F2opSE32GtmQWadMxS
	W6J1NtQbOtE6sxonM5F0XrTGgfQwc+S76TSgkR1wqmWf/kFwYZ/n/UhsBWJi5lG20J04pixSzsy
	859GHaIWpEt76Y13gKF6PjY9IXvvcVHZamfmQmEDohJHxsABm70Qxpx8yE8yI9stgZCaQFMDvmS
	HTj7FJ3cbbtAuVUJaDzt6gJYq02tAM/IRQfKei3SrA6je7Ol106yRBRk2oYfolRIXooVDRPcbhb
	hseVA6GDAsJQ==
X-Received: by 2002:a05:622a:1116:b0:501:47e5:cbf8 with SMTP id d75a77b69052e-5032fa1d7f1mr34933061cf.57.1769537794920;
        Tue, 27 Jan 2026 10:16:34 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:34 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 12/13] selftests: bpf: Add buddy allocator for libarena
Date: Tue, 27 Jan 2026 13:16:08 -0500
Message-ID: <20260127181610.86376-13-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add a byte-oriented buddy allocator for libarena. The buddy
allocator provides an alloc/free interface for small arena
allocations (down to 16 bytes).

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/buddy.h    |  62 ++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 784 ++++++++++++++++++
 2 files changed, 846 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tools/testing/selftests/bpf/libarena/include/buddy.h
new file mode 100644
index 000000000000..6154169a0f9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/buddy.h
@@ -0,0 +1,62 @@
+#pragma once
+
+/* Buddy allocator-related structs. */
+
+struct buddy_chunk;
+typedef struct buddy_chunk __arena buddy_chunk_t;
+
+struct buddy_header;
+typedef struct buddy_header __arena buddy_header_t;
+
+enum buddy_consts {
+	BUDDY_MIN_ALLOC_SHIFT	= 4,
+	BUDDY_MIN_ALLOC_BYTES	= 1 << BUDDY_MIN_ALLOC_SHIFT,
+	BUDDY_CHUNK_NUM_ORDERS	= 1 << 4,	/* 4 bits per order */
+	BUDDY_CHUNK_BYTES	= BUDDY_MIN_ALLOC_BYTES << BUDDY_CHUNK_NUM_ORDERS,
+	BUDDY_HEADER_OFF	= 8, /* header byte offset, see buddy.bpf.c for details */
+	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE,
+	BUDDY_CHUNK_ITEMS	= 1 << BUDDY_CHUNK_NUM_ORDERS,
+	BUDDY_CHUNK_OFFSET_MASK	= BUDDY_CHUNK_BYTES - 1,
+	BUDDY_VADDR_OFFSET	= BUDDY_CHUNK_BYTES,	/* Start aligning at chunk */
+	BUDDY_VADDR_SIZE	= BUDDY_CHUNK_BYTES << 10 /* 1024 chunks maximum */
+};
+
+struct buddy_header {
+	u32 prev_index;	/* "Pointer" to the previous available allocation of the same size. */
+	u32 next_index; /* Same for the next allocation. */
+};
+
+/*
+ * We bring memory into the allocator 1MiB at a time.
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
+	buddy_chunk_t	*prev;
+	buddy_chunk_t	*next;
+};
+
+struct buddy {
+	buddy_chunk_t *first_chunk;		/* Pointer to the chunk linked list. */
+	arena_spinlock_t __arena *lock;		/* Allocator lock */
+	u64 vaddr;				/* Allocation into reserved vaddr */
+};
+
+#ifdef __BPF__
+
+int buddy_init(struct buddy *buddy, arena_spinlock_t __arena *lock);
+int buddy_destroy(struct buddy *buddy);
+int buddy_free_internal(struct buddy *buddy, u64 free);
+#define buddy_free(buddy, ptr) do { buddy_free_internal((buddy), (u64)(ptr)); } while (0)
+u64 buddy_alloc_internal(struct buddy *buddy, size_t size);
+#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
+
+
+#endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
new file mode 100644
index 000000000000..f43e1db209be
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -0,0 +1,784 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <buddy.h>
+
+volatile int zero = 0;
+
+enum {
+	BUDDY_POISONED = (s8)0xef,
+};
+
+static inline int buddy_lock(struct buddy *buddy)
+{
+	return arena_spin_lock(buddy->lock);
+}
+
+static inline void buddy_unlock(struct buddy *buddy)
+{
+	arena_spin_unlock(buddy->lock);
+}
+
+/*
+ * Reserve part of the arena address space for the allocator. We use
+ * this to get aligned addresses for the chunks, since the arena
+ * page alloc kfuncs do not support alignment.
+ */
+static int buddy_reserve_arena_vaddr(struct buddy *buddy)
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
+static void buddy_unreserve_arena_vaddr(struct buddy *buddy)
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
+ * system, so there is no race between this function unreserving a
+ * page range and the 
+ */
+static int buddy_alloc_arena_vaddr(struct buddy *buddy, u64 *vaddrp)
+{
+	u64 vaddr, old, new;
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
+	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
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
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
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
+		arena_stderr("setting order of invalid idx\n");
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
+		arena_stderr("setting order of invalid idx\n");
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
+static void header_add_freelist(buddy_chunk_t  *chunk,
+				buddy_header_t *header, u64 idx, u8 order)
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
+	if (unlikely(!size)) {
+		arena_stderr("size 0 has no order\n");
+		return 64;
+	}
+
+	/*
+	 * To find the order of the allocation we find the first power of two
+	 * >= the requested size, take the log2, then adjust it for the minimum
+	 * allocation size by removing the minimum shift from it. Requests
+	 * smaller than the minimum allocation size are rounded up.
+	 */
+	order = arena_fls(arena_next_pow2(size));
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
+	bpf_for(ord, min_order, max_order) {
+		/* Mark the buddy as free and add it to the freelists. */
+		idx = cur_idx + (1 << ord);
+
+		header = idx_to_header(chunk, idx);
+		if (unlikely(!header))
+			return -EINVAL;
+
+		asan_unpoison(header, sizeof(*header));
+
+		idx_set_allocated(chunk, idx, false);
+		header_add_freelist(chunk, header, idx, ord);
+	}
+
+	return 0;
+}
+
+static buddy_chunk_t *buddy_chunk_get(struct buddy *buddy)
+{
+	u64 order, ord, min_order, max_order;
+	buddy_chunk_t  *chunk;
+	size_t left;
+	int power2;
+	u64 vaddr;
+	u32 idx;
+	int ret;
+
+	buddy_unlock(buddy);
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
+	if ((ret = buddy_lock(buddy))) {
+		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
+		return NULL;
+	}
+
+	asan_poison(chunk, BUDDY_POISONED, BUDDY_CHUNK_PAGES * __PAGE_SIZE);
+
+	/* Unpoison the chunk itself. */
+	asan_unpoison(chunk, sizeof(*chunk));
+
+	/* Mark all freelists as empty. */
+	bpf_for(ord, 0, BUDDY_CHUNK_NUM_ORDERS)
+		chunk->freelists[ord] = BUDDY_CHUNK_ITEMS;
+
+	/*
+	 * Initialize the chunk by carving out the first page to hold the metadata struct above,
+	 * then dumping the rest of the pages into the allocator.
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
+	 * Step:
+	 * - Find the largest power-of-2 allocation still smaller than left (infimum)
+	 * - Reserve a chunk of that size, along with its buddy
+	 * - For every order from [infimum + 1, last order), carve out a block 
+	 *   and put it into the allocator.
+	 *
+	 *  Example: Chunk size 0b1010000 (80 bytes)
+	 *
+	 *  Step 1:
+	 *
+	 *   idx  infimum			   1 << max_order
+	 *   0 	      64	128		      1 << 20	
+	 *   |________|_________|______________________|
+	 *
+	 *   Blocks set aside:
+	 *   	[0, 64)		- Completely allocated
+	 *   	[64, 128)	- Will be further split in the next iteration
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
+	max_order = BUDDY_CHUNK_NUM_ORDERS;
+	left = sizeof(*chunk);
+	idx = 0;
+	while (left && can_loop) {
+		power2 = arena_fls(left);
+		if (unlikely(power2 >= BUDDY_CHUNK_NUM_ORDERS)) {
+			arena_stderr(
+				"buddy chunk metadata require allocation of order %d\n",
+				power2);
+			arena_stderr(
+				"chunk has size of 0x%lx bytes (left %lx bytes)\n",
+				sizeof(*chunk), left);
+
+			buddy_unlock(buddy);
+			return NULL;
+		}
+
+		/* Round up allocations that are too small. */
+
+		left -= (power2 >= BUDDY_MIN_ALLOC_SHIFT) ? 1 << power2 : left;
+		order = (power2 >= BUDDY_MIN_ALLOC_SHIFT) ? power2 - BUDDY_MIN_ALLOC_SHIFT : 0;
+
+		idx_set_allocated(chunk, idx, true);
+
+		/* 
+		 * Starting an order above the one we allocated, populate
+		 * the allocator with free blocks. If this is the last
+		 * allocation (left == 0), also mark the buddy as free.
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
+	return chunk;
+}
+
+__hidden int buddy_init(struct buddy			 *buddy,
+			    arena_spinlock_t __arg_arena __arena *lock)
+{
+	buddy_chunk_t *chunk;
+	int ret;
+
+	buddy->lock = lock;
+
+	if (!asan_ready())
+		return -EINVAL;
+
+	/* 
+	 * Reserve enough address space to ensure allocations are aligned.
+	 */
+	if ((ret = buddy_reserve_arena_vaddr(buddy)))
+		return ret;
+
+	_Static_assert(BUDDY_CHUNK_PAGES > 0,
+		       "chunk must use one or more pages");
+
+	/* Chunk is already properly unpoisoned if allocated. */
+	if (buddy_lock(buddy))
+		return -EINVAL;
+
+	chunk = buddy_chunk_get(buddy);
+	if (!chunk) {
+		buddy->first_chunk = NULL;
+		return -ENOMEM;
+	}
+
+	/* Put the chunk at the beginning of the list. */
+	chunk->next = buddy->first_chunk;
+	chunk->prev = NULL;
+	buddy->first_chunk = chunk;
+
+	buddy_unlock(buddy);
+
+	return 0;
+}
+
+/*
+ * Destroy the allocator. This does not check whether there are any allocations
+ * currently in use, so any pages being accessed will start taking arena faults.
+ * We do not take a lock because we are freeing arena pages, and nobody should
+ * be using the allocator at that point in the execution.
+ */
+__weak int buddy_destroy(struct buddy *buddy)
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
+__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk,
+				 int				order_req)
+{
+	buddy_header_t *header, *tmp_header, *next_header;
+	u32 idx, tmpidx, retidx;
+	u64 address;
+	u64 order = 0;
+	u64 i;
+
+	bpf_for(order, order_req, BUDDY_CHUNK_NUM_ORDERS) {
+		if (chunk->freelists[order] != BUDDY_CHUNK_ITEMS)
+			break;
+	}
+
+	if (order >= BUDDY_CHUNK_NUM_ORDERS)
+		return (u64)NULL;
+
+	retidx = chunk->freelists[order];
+	header = idx_to_header(chunk, retidx);
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
+
+	/* If we allocated from a larger-order chunk, split the buddies. */
+	bpf_for(i, order_req, order) {
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
+		if (idx_set_allocated(chunk, idx, false))
+			return (u64)NULL;
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
+__weak
+u64 buddy_alloc_internal(struct buddy *buddy, size_t size)
+{
+	buddy_chunk_t *chunk;
+	u64 address;
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
+	for (chunk = buddy->first_chunk; chunk != NULL && can_loop;
+	     chunk = chunk->next) {
+		address = buddy_chunk_alloc(chunk, order);
+		if (address)
+			goto done;
+	}
+
+	/* Get a new chunk. */
+	chunk = buddy_chunk_get(buddy);
+	if (!chunk)
+		return (u64)NULL;
+
+	/* Add the chunk into the allocator and retry. */
+	chunk->next = buddy->first_chunk;
+	chunk->prev = NULL;
+	buddy->first_chunk = chunk;
+
+	address = buddy_chunk_alloc(buddy->first_chunk, order);
+
+done:
+
+	if (!address) {
+		buddy_unlock(buddy);
+		return (u64)NULL;
+	}
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
+	buddy_unlock(buddy);
+
+	return address;
+}
+
+static __always_inline int buddy_free_unlocked(struct buddy *buddy, u64 addr)
+{
+	buddy_header_t *header, *buddy_header;
+	u64 idx, buddy_idx, tmp_idx;
+	buddy_chunk_t *chunk;
+	bool allocated;
+	u8 order;
+
+	if (!buddy)
+		return -EINVAL;
+
+	if (addr & (BUDDY_MIN_ALLOC_BYTES - 1)) {
+		arena_stderr("Freeing unaligned address %llx\n", addr);
+		return 0;
+	}
+
+	/* Get (chunk, idx) out of the address. */
+	chunk = (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	/* Mark the block as unallocated so we can access the header. */
+	idx_set_allocated(chunk, idx, false);
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
+	bpf_for(order, order, BUDDY_CHUNK_NUM_ORDERS) {
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
+__weak int buddy_free_internal(struct buddy *buddy, u64 addr)
+{
+	int ret;
+
+	if (!buddy)
+		return -EINVAL;
+
+	if ((ret = buddy_lock(buddy)))
+		return ret;
+
+	buddy_free_unlocked(buddy, addr);
+
+	buddy_unlock(buddy);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

