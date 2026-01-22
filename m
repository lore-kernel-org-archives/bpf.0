Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D73A4F4E
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097748; cv=none; b=Qs6q3KngutQFIbUrpRnzjWHPCQoSOw9Xg8CzduGUIWRWhUQaD7VX70KKcBXbqKe8YH0vwAh1I2p8HvWLCvojjMsKtUP2uGchotHZQMnHu9H4kq/H5bH5FO5v/XbJKScTmwpsGvzgAnCxBeUuL+hhlg4PBU3ixQQHkQd7jKwwXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097748; c=relaxed/simple;
	bh=FvGVQUL+NSNx4IpBTfrMN97ccozs/KIb8kZS6YdKtU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvOplpBjCAtC4k8Cvzgu7jyHJ1IzLQUkrIACskvfnGbbdU+byOueiUt7ojZycoonfJ/O3VgOvjOhh74aZeGwO1foPZIA5oxX+IOwHBt23BGwxIN9DVpUKNXcS0IlD9Tqx6dTSbiLV4ydEMYAnvD4R8lsiOTUdNDkJFyypQznY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vL3V2WnT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vL3V2WnT"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M701rj450883
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=47DPoF/L16vsYo4pfQQo64DZHruE+cz1yA9tYcGJoa0=; b=vL3V2WnT3TGS
	DbhycFSC5sgRCgtowrc70aA9NMycWFz716g2cRh9C4xDn1u8Kpcl8YA92LgNBSCr
	4VYpgIBitkKtFV10MIByMdVEw1/Y2pNfOEqv+TKj26JZ6oLP3QehXCAFafE6xUPq
	ulJJAf5V5TOZYIXbWA8BvKVHXOZwnupFcNNJxyfztdk33gyA+aCmZFA0rxFsNJm2
	jevLbf0iqRQqeVmcrmTl3hjWQCh51RVJBUlAjfdmpplzuBbKTDSff1mkx381rdwL
	Pv9Hv2mVHLy5AMOaCYeZBU0HJOufOLShVv98nJ+YPj4SwnYthyf8umP0n6q9hAGA
	UapsiKJFoA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4buf463770-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:18 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:49 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 769F110A69EC6; Thu, 22 Jan 2026 08:01:48 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 12/13] selftests: bpf: Add buddy allocator for libarena
Date: Thu, 22 Jan 2026 08:01:30 -0800
Message-ID: <20260122160131.2238331-13-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX7MdrdnCSb4H9
 DsiDTeE/oY0jqwZ214dkD7cRaA68ausefu+RxydUnbV8+mfhW/oDgbQJTCoC+4Qs5SMC/fzuEfT
 5/nOzA7RxzL5jdR+T5nNkN5H0h9IB3cpdf03jhi/9KahMJu+RZHcylo6+gorBaTpnMAhIjtwqYC
 0BGny8seWymNxhCcR75GAhhXmbI3WwGiVDayqvDYotcsfBPAKLHceXhaV7RsZfWli75No4KVvk/
 KnmWewYxlEmuV0gbcW/MxnHmhO8f+p7mb4PcWRl6C0WxhssAkXmd47y9hDXbXHcgF6K6LC7X38u
 HmMfynRdajIzv7WpyH9ijoUZ5rJfNK/xMkZNpRIhKIx87rHII50GkdWlg5r8t5a2iPMdyyvEzVw
 Gb3qJKGeOF11zb5Qx6RxPpB6sfdElc29SlZZmzJ4ms27jSR31qdF4ruYKJdPtS39rVEaHGlYDUG
 7ih3pNnXTKgSxXlfplQ==
X-Authority-Analysis: v=2.4 cv=HP3O14tv c=1 sm=1 tr=0 ts=69724a0a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=qCnbOrTtRKLr9KQ4974A:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Eh--jLcmYncVkO4ABnn1DmyAaKN3mCJ_
X-Proofpoint-ORIG-GUID: Eh--jLcmYncVkO4ABnn1DmyAaKN3mCJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

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

diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tools=
/testing/selftests/bpf/libarena/include/buddy.h
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
+	BUDDY_MIN_ALLOC_SHIFT	=3D 4,
+	BUDDY_MIN_ALLOC_BYTES	=3D 1 << BUDDY_MIN_ALLOC_SHIFT,
+	BUDDY_CHUNK_NUM_ORDERS	=3D 1 << 4,	/* 4 bits per order */
+	BUDDY_CHUNK_BYTES	=3D BUDDY_MIN_ALLOC_BYTES << BUDDY_CHUNK_NUM_ORDERS,
+	BUDDY_HEADER_OFF	=3D 8, /* header byte offset, see buddy.bpf.c for deta=
ils */
+	BUDDY_CHUNK_PAGES	=3D BUDDY_CHUNK_BYTES / __PAGE_SIZE,
+	BUDDY_CHUNK_ITEMS	=3D 1 << BUDDY_CHUNK_NUM_ORDERS,
+	BUDDY_CHUNK_OFFSET_MASK	=3D BUDDY_CHUNK_BYTES - 1,
+	BUDDY_VADDR_OFFSET	=3D BUDDY_CHUNK_BYTES,	/* Start aligning at chunk */
+	BUDDY_VADDR_SIZE	=3D BUDDY_CHUNK_BYTES << 10 /* 1024 chunks maximum */
+};
+
+struct buddy_header {
+	u32 prev_index;	/* "Pointer" to the previous available allocation of th=
e same size. */
+	u32 next_index; /* Same for the next allocation. */
+};
+
+/*
+ * We bring memory into the allocator 1MiB at a time.
+ */
+struct buddy_chunk {
+	/* The order of the current allocation for a item. 4 bits per order. */
+	u8		orders[BUDDY_CHUNK_ITEMS / 2];
+	/*=20
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
+#define buddy_free(buddy, ptr) do { buddy_free_internal((buddy), (u64)(p=
tr)); } while (0)
+u64 buddy_alloc_internal(struct buddy *buddy, size_t size);
+#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((=
alloc), (size)))
+
+
+#endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
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
+volatile int zero =3D 0;
+
+enum {
+	BUDDY_POISONED =3D (s8)0xef,
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
+	buddy->vaddr =3D 0;
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
+	buddy->vaddr =3D 0;
+}
+
+/*=20
+ * Carve out part of the reserved address space and hand it over
+ * to the buddy allocator.
+ *
+ * We are assuming the buddy allocator is the only allocator in the
+ * system, so there is no race between this function unreserving a
+ * page range and the=20
+ */
+static int buddy_alloc_arena_vaddr(struct buddy *buddy, u64 *vaddrp)
+{
+	u64 vaddr, old, new;
+
+	do {
+		vaddr =3D buddy->vaddr;
+		new =3D vaddr + BUDDY_CHUNK_BYTES;
+
+		if (new > BUDDY_VADDR_SIZE)
+			return -EINVAL;
+
+		old =3D __sync_val_compare_and_swap(&buddy->vaddr, vaddr, new);
+	} while (old !=3D vaddr && can_loop);
+
+	if (old !=3D vaddr)
+		return -EINVAL;
+
+	*vaddrp =3D BUDDY_VADDR_OFFSET + vaddr;
+
+	return 0;
+}
+
+static u64 arena_next_pow2(__u64 n)
+{
+	n--;
+	n |=3D n >> 1;
+	n |=3D n >> 2;
+	n |=3D n >> 4;
+	n |=3D n >> 8;
+	n |=3D n >> 16;
+	n |=3D n >> 32;
+	n++;
+
+	return n;
+}
+
+__weak
+int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool al=
located)
+{
+	if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	if (allocated)
+		chunk->allocated[idx / 8] |=3D 1 << (idx % 8);
+	else
+		chunk->allocated[idx / 8] &=3D ~(1 << (idx % 8));
+
+	return 0;
+}
+
+static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocat=
ed)
+{
+	if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	*allocated =3D chunk->allocated[idx / 8] & (1 << (idx % 8));
+	return 0;
+}
+
+__weak
+int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
+{
+	u8 prev_order;
+
+	if (unlikely(order >=3D BUDDY_CHUNK_NUM_ORDERS)) {
+		arena_stderr("setting invalid order %u\n", order);
+		return -EINVAL;
+	}
+
+	if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx (%d, max %d)\n", idx,
+			     BUDDY_CHUNK_ITEMS);
+		return -EINVAL;
+	}
+
+	/*=20
+	 * We store two order instances per byte, one per nibble.
+	 * Retain the existing nibble.
+	 */
+	prev_order =3D chunk->orders[idx / 2];
+	if (idx & 0x1) {
+		order &=3D 0xf;
+		order |=3D (prev_order & 0xf0);
+	} else {
+		order <<=3D 4;
+		order |=3D (prev_order & 0xf);
+	}
+
+	chunk->orders[idx / 2] =3D order;
+
+	return 0;
+}
+
+static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
+{
+	u8 result;
+
+	_Static_assert(BUDDY_CHUNK_NUM_ORDERS <=3D 16,
+		       "order must fit in 4 bits");
+
+	if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
+		arena_stderr("setting order of invalid idx\n");
+		return BUDDY_CHUNK_NUM_ORDERS;
+	}
+
+	result =3D chunk->orders[idx / 2];
+
+	return (idx & 0x1) ? (result & 0xf) : (result >> 4);
+}
+
+static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
+{
+	u64 address;
+
+	if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
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
+	address =3D (u64)chunk + (idx * BUDDY_MIN_ALLOC_BYTES);
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
+	address =3D (u64)idx_to_addr(chunk, idx);
+
+	/*=20
+	 * Offset the header within the block. This avoids accidental overwrite=
s
+	 * to the header because of off-by-one errors when using adjacent block=
s.
+	 *
+	 * The offset has been chosen as a compromise between ASAN effectivenes=
s
+	 * and allocator granularity:
+	 * 1) ASAN dictates valid data runs are 8-byte aligned.
+	 * 2) We want to keep a low minimum allocation size (currently 16).
+	 *=20
+	 * As a result, we have only two possible positions for the header: Byt=
es
+	 * 0 and 8. Keeping the header in byte 0 means off-by-ones from the pre=
vious
+	 * block touch the header, and, since the header must be accessible, AS=
AN
+	 * will not trigger. Keeping the header on byte 8 means off-by-one erro=
rs from
+	 * the previous block are caught by ASAN. Negative offsets are rarer, s=
o=20
+	 * while accesses into the block from the next block are possible, they=
 are
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
+	header->next_index =3D chunk->freelists[order];
+	header->prev_index =3D BUDDY_CHUNK_ITEMS;
+
+	if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
+		tmp_header =3D idx_to_header(chunk, header->next_index);
+		tmp_header->prev_index =3D idx;
+	}
+
+	chunk->freelists[order] =3D idx;
+}
+
+static void header_remove_freelist(buddy_chunk_t  *chunk,
+				   buddy_header_t *header, u8 order)
+{
+	buddy_header_t *tmp_header;
+
+	if (header->prev_index !=3D BUDDY_CHUNK_ITEMS) {
+		tmp_header =3D idx_to_header(chunk, header->prev_index);
+		tmp_header->next_index =3D header->next_index;
+	}
+
+	if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
+		tmp_header =3D idx_to_header(chunk, header->next_index);
+		tmp_header->prev_index =3D header->prev_index;
+	}
+
+	/* Pop off the list head if necessary. */
+	if (idx_to_header(chunk, chunk->freelists[order]) =3D=3D header)
+		chunk->freelists[order] =3D header->next_index;
+
+	header->prev_index =3D BUDDY_CHUNK_ITEMS;
+	header->next_index =3D BUDDY_CHUNK_ITEMS;
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
+	 * >=3D the requested size, take the log2, then adjust it for the minim=
um
+	 * allocation size by removing the minimum shift from it. Requests
+	 * smaller than the minimum allocation size are rounded up.
+	 */
+	order =3D arena_fls(arena_next_pow2(size));
+	if (order < BUDDY_MIN_ALLOC_SHIFT)
+		return 0;
+
+	return order - BUDDY_MIN_ALLOC_SHIFT;
+}
+
+__weak
+int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_=
idx,
+		u64 min_order, u64 max_order)
+{
+	buddy_header_t *header;
+	u64 ord;
+	u32 idx;
+
+	bpf_for(ord, min_order, max_order) {
+		/* Mark the buddy as free and add it to the freelists. */
+		idx =3D cur_idx + (1 << ord);
+
+		header =3D idx_to_header(chunk, idx);
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
+	ret =3D buddy_alloc_arena_vaddr(buddy, &vaddr);
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
+	chunk =3D bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
+				      BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0);
+	if (!chunk) {
+		arena_stderr("[ALLOC FAILED]");
+		return NULL;
+	}
+
+	if ((ret =3D buddy_lock(buddy))) {
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
+		chunk->freelists[ord] =3D BUDDY_CHUNK_ITEMS;
+
+	/*
+	 * Initialize the chunk by carving out the first page to hold the metad=
ata struct above,
+	 * then dumping the rest of the pages into the allocator.
+	 */
+
+	_Static_assert(BUDDY_CHUNK_PAGES * __PAGE_SIZE >=3D
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
+	 * - cur_index: Current index into the top-level block we are=20
+	 * allocating from.
+	 *=20
+	 * Step:
+	 * - Find the largest power-of-2 allocation still smaller than left (in=
fimum)
+	 * - Reserve a chunk of that size, along with its buddy
+	 * - For every order from [infimum + 1, last order), carve out a block=20
+	 *   and put it into the allocator.
+	 *
+	 *  Example: Chunk size 0b1010000 (80 bytes)
+	 *
+	 *  Step 1:
+	 *
+	 *   idx  infimum			   1 << max_order
+	 *   0 	      64	128		      1 << 20=09
+	 *   |________|_________|______________________|
+	 *
+	 *   Blocks set aside:
+	 *   	[0, 64)		- Completely allocated
+	 *   	[64, 128)	- Will be further split in the next iteration
+	 *  =20
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
+	 *   64	      80	96		   	64 + 1 << 6 =3D 128
+	 *   |________|_________|______________________|
+	 *
+	 *   Blocks set aside:
+	 *   	[64, 80)	- Completely allocated
+	 *  =20
+	 *   Blocks added to the allocator:
+	 *      [80, 96) - left =3D=3D 0 so the buddy is unused and marked as f=
reed
+	 *   	[96, 128)
+	 */
+	max_order =3D BUDDY_CHUNK_NUM_ORDERS;
+	left =3D sizeof(*chunk);
+	idx =3D 0;
+	while (left && can_loop) {
+		power2 =3D arena_fls(left);
+		if (unlikely(power2 >=3D BUDDY_CHUNK_NUM_ORDERS)) {
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
+		left -=3D (power2 >=3D BUDDY_MIN_ALLOC_SHIFT) ? 1 << power2 : left;
+		order =3D (power2 >=3D BUDDY_MIN_ALLOC_SHIFT) ? power2 - BUDDY_MIN_ALL=
OC_SHIFT : 0;
+
+		idx_set_allocated(chunk, idx, true);
+
+		/*=20
+		 * Starting an order above the one we allocated, populate
+		 * the allocator with free blocks. If this is the last
+		 * allocation (left =3D=3D 0), also mark the buddy as free.
+		 */
+		min_order =3D left ? order + 1 : order;
+		if (add_leftovers_to_freelist(chunk, idx, min_order, max_order)) {
+			buddy_unlock(buddy);
+			return NULL;
+		}
+
+		/* Adjust the index. */
+		idx +=3D 1 << order;
+		max_order =3D order;
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
+	buddy->lock =3D lock;
+
+	if (!asan_ready())
+		return -EINVAL;
+
+	/*=20
+	 * Reserve enough address space to ensure allocations are aligned.
+	 */
+	if ((ret =3D buddy_reserve_arena_vaddr(buddy)))
+		return ret;
+
+	_Static_assert(BUDDY_CHUNK_PAGES > 0,
+		       "chunk must use one or more pages");
+
+	/* Chunk is already properly unpoisoned if allocated. */
+	if (buddy_lock(buddy))
+		return -EINVAL;
+
+	chunk =3D buddy_chunk_get(buddy);
+	if (!chunk) {
+		buddy->first_chunk =3D NULL;
+		return -ENOMEM;
+	}
+
+	/* Put the chunk at the beginning of the list. */
+	chunk->next =3D buddy->first_chunk;
+	chunk->prev =3D NULL;
+	buddy->first_chunk =3D chunk;
+
+	buddy_unlock(buddy);
+
+	return 0;
+}
+
+/*
+ * Destroy the allocator. This does not check whether there are any allo=
cations
+ * currently in use, so any pages being accessed will start taking arena=
 faults.
+ * We do not take a lock because we are freeing arena pages, and nobody =
should
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
+	for (chunk =3D buddy->first_chunk; chunk && can_loop; chunk =3D next) {
+		next =3D chunk->next;
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
+	buddy->first_chunk =3D NULL;
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
+	u64 order =3D 0;
+	u64 i;
+
+	bpf_for(order, order_req, BUDDY_CHUNK_NUM_ORDERS) {
+		if (chunk->freelists[order] !=3D BUDDY_CHUNK_ITEMS)
+			break;
+	}
+
+	if (order >=3D BUDDY_CHUNK_NUM_ORDERS)
+		return (u64)NULL;
+
+	retidx =3D chunk->freelists[order];
+	header =3D idx_to_header(chunk, retidx);
+	chunk->freelists[order] =3D header->next_index;
+
+	if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
+		next_header =3D idx_to_header(chunk, header->next_index);
+		next_header->prev_index =3D BUDDY_CHUNK_ITEMS;
+	}
+
+	header->prev_index =3D BUDDY_CHUNK_ITEMS;
+	header->next_index =3D BUDDY_CHUNK_ITEMS;
+	if (idx_set_order(chunk, retidx, order_req))
+		return (u64)NULL;
+
+	if (idx_set_allocated(chunk, retidx, true))
+		return (u64)NULL;
+
+	/*=20
+	 * Do not unpoison the address yet, will be done by the caller
+	 * because the caller has the exact allocation size requested.
+	 */
+	address =3D (u64)idx_to_addr(chunk, retidx);
+
+	/* If we allocated from a larger-order chunk, split the buddies. */
+	bpf_for(i, order_req, order) {
+		/*
+		 * Flip the bit for the current order (the bit is guaranteed
+		 * to be 0, so just add 1 << i).=20
+		 */
+		idx =3D retidx + (1 << i);
+
+		/* Add the buddy of the allocation to the free list. */
+		header =3D idx_to_header(chunk, idx);
+		/* Unpoison the buddy header */
+		asan_unpoison(header, sizeof(*header));
+		if (idx_set_allocated(chunk, idx, false))
+			return (u64)NULL;
+
+		if (idx_set_order(chunk, idx, i))
+			return (u64)NULL;
+
+		/* Push the header to the beginning of the freelists list. */
+		tmpidx =3D chunk->freelists[i];
+
+		header->prev_index =3D BUDDY_CHUNK_ITEMS;
+		header->next_index =3D tmpidx;
+
+		if (tmpidx !=3D BUDDY_CHUNK_ITEMS) {
+			tmp_header =3D idx_to_header(chunk, tmpidx);
+			tmp_header->prev_index =3D idx;
+		}
+
+		chunk->freelists[i] =3D idx;
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
+	order =3D size_to_order(size);
+	if (order >=3D BUDDY_CHUNK_NUM_ORDERS || order < 0) {
+		arena_stderr("invalid order %d (sz %lu)\n", order, size);
+		return (u64)NULL;
+	}
+
+	if (buddy_lock(buddy))
+		return (u64)NULL;
+
+	for (chunk =3D buddy->first_chunk; chunk !=3D NULL && can_loop;
+	     chunk =3D chunk->next) {
+		address =3D buddy_chunk_alloc(chunk, order);
+		if (address)
+			goto done;
+	}
+
+	/* Get a new chunk. */
+	chunk =3D buddy_chunk_get(buddy);
+	if (!chunk)
+		return (u64)NULL;
+
+	/* Add the chunk into the allocator and retry. */
+	chunk->next =3D buddy->first_chunk;
+	chunk->prev =3D NULL;
+	buddy->first_chunk =3D chunk;
+
+	address =3D buddy_chunk_alloc(buddy->first_chunk, order);
+
+done:
+
+	if (!address) {
+		buddy_unlock(buddy);
+		return (u64)NULL;
+	}
+
+	/*=20
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
+static __always_inline int buddy_free_unlocked(struct buddy *buddy, u64 =
addr)
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
+	chunk =3D (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx =3D (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	/* Mark the block as unallocated so we can access the header. */
+	idx_set_allocated(chunk, idx, false);
+
+	order  =3D idx_get_order(chunk, idx);
+	header =3D idx_to_header(chunk, idx);
+
+	/* The header is in the block itself, keep it unpoisoned. */
+	asan_poison((u8 __arena *)addr, BUDDY_POISONED,
+		    BUDDY_MIN_ALLOC_BYTES << order);
+	asan_unpoison(header, sizeof(*header));
+
+	/*=20
+	 * Coalescing loop. Merge with free buddies of equal order.
+	 * For every coalescing step, keep the left buddy and=20
+	 * drop the right buddy's header.
+	 */
+	bpf_for(order, order, BUDDY_CHUNK_NUM_ORDERS) {
+		buddy_idx =3D idx ^ (1 << order);
+
+		/* Check if the buddy is actually free. */
+		idx_is_allocated(chunk, buddy_idx, &allocated);
+		if (allocated)
+			break;
+
+		/*=20
+		 * If buddy is not the same order as the chunk
+		 * being freed, then we're done coalescing.
+		 */
+		if (idx_get_order(chunk, buddy_idx) !=3D order)
+			break;
+
+		buddy_header =3D idx_to_header(chunk, buddy_idx);
+		header_remove_freelist(chunk, buddy_header, order);
+
+		/* Keep the left header out of the two buddies, drop the other one. */
+		if (buddy_idx < idx) {
+			tmp_idx =3D idx;
+			idx =3D buddy_idx;
+			buddy_idx =3D tmp_idx;
+		}
+
+		/* Remove the buddy from the freelists so that we can merge it. */
+		idx_set_order(chunk, buddy_idx, order);
+
+		buddy_header =3D idx_to_header(chunk, buddy_idx);
+		asan_poison(buddy_header, BUDDY_POISONED,
+			    sizeof(*buddy_header));
+	}
+
+	/* Header properly freed but not in any freelists yet .*/
+	idx_set_order(chunk, idx, order);
+
+	header =3D idx_to_header(chunk, idx);
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
+	if ((ret =3D buddy_lock(buddy)))
+		return ret;
+
+	buddy_free_unlocked(buddy, addr);
+
+	buddy_unlock(buddy);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

