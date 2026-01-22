Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83248C3FD
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097743; cv=none; b=DOTEQdF7qmCYgRooO/vZQFMP20SeVEyH4AbozogZu7cg1pJin49lKLW0Pip6jVe0px0w5xIQJ7qz2aCZ1/gmoD8ErhY7pZS/MdiXkvrSt84eve5nx+iwwfzkGGeVWkRxgzOxUE7Yv0n0YpsXNV02XdJtpVCFaqXVg3mnrnN7ZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097743; c=relaxed/simple;
	bh=w3c4J70v1rkLyQjIWw4YDGw5AuBmITpKVG6xkRDpOi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPEPTIXgl20tv/B0HuJyE5ZuaBOcUjVv/HPi3amb2xS+xL7xbCL6lavaIf36V5I0uSDqblK3NnWlgJFw3Qn9qUYQQoxasDWHxSPjlq/4H6+ojLSaq3TCQT6YH4Hn0xbsErwhIU4SLwvZ0G+pCo9tcEO2IPCDFpAXPfkMXzEN2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MmBT60sB; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MmBT60sB"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60MEbFM62875515
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5yVsOuKiBkm39cTlBpMRsjOSvd6MJUept49+wt0Z5b4=; b=MmBT60sBGmdA
	NY6w+TUck1mfA1IqolXX+ZlxcBqAOFp/86TxudvOoVLyh4J3ezzddEE9KRaSlOnS
	6ELVBtlQdKO8NRvDXCyZM0LsyLuPzssiBqOtPDedYyuZh/zELR6Zlm/880vVV2Yw
	0wc3hFxExjqbyOxA+f7HianPffzL0Vy9EZOx+2vdObjub0oDN2XLVIknXoEu1Z/w
	XippBjYSyASGf9QfExrwZ8trgASqDq91n6MsIfWhtvqazHdkPLGxzPQVMPyluhyU
	F59a5pjdf29ZA2gkWCMwHEFZXtLAWDGwZ4TkL+zx7wS1p53LoZpMQqDUMkPQE2I/
	KF3plxtX5g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4buntngphx-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:15 -0800 (PST)
Received: from twshared26141.04.snb1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:58 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 726AD10A69EBB; Thu, 22 Jan 2026 08:01:47 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 10/13] selftest: bpf: Add libarena stack allocator
Date: Thu, 22 Jan 2026 08:01:28 -0800
Message-ID: <20260122160131.2238331-11-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfXzO/PYtZf2Hfo
 ZBwbpGec0hy/4nsz5KS9Os9maq+i7DeOadf7HHSaPA20xJNidmwO7edfPRxJgidZn0l0gOA1Vdp
 F/VB6JxcL+Jx/W67FfdHerp5o6M7dBIko4i2xKkVXBIwMiTwPjX17jtwC9Dq9NtRTgUpLk+YvGx
 WmWEABYARVcwgTdcDsXcon13NO4OkA867U/T9Nx45pnHw2u62XSuQS3KN/HjHeVn5RRfgqO8km/
 /ocBtfhjq/TifkPFOtoIVmnej/ClAXeyhqs35b6WfBjOspn32nPNlrTeL2SqoUZ7Dw6qFstSFW8
 EdktkSPmQl4EfDQy1bNiNUP4H4fSd7C1ISEfYT6Sy6lxlPsyzrhrNNgS9HMgJja2c1b8lFFyZj5
 czFGEdZQvSMPborbXLwETsO7VPr0h11zoJvgSoi6hf/tZJOOpEd0oKiOR24rRXth9BtnphKQA44
 9+rRDB1hjH//Bt2d8Vg==
X-Proofpoint-GUID: a0BfCUvqQIUnSVUdUM-M3W5CCZKPfvFu
X-Proofpoint-ORIG-GUID: a0BfCUvqQIUnSVUdUM-M3W5CCZKPfvFu
X-Authority-Analysis: v=2.4 cv=Ls+fC3dc c=1 sm=1 tr=0 ts=69724a07 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=4rkyNyak_Bq7wGdEfxIA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add a page-oriented stack allocator to libarena. The allocator
is targeted towards large, page-aligned allocations for BPF
programs and can serve as an intermediate location for pages
freed by custom allocators like slab allocators to avoid constantly
allocating and freeing arena pages.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/stack.h    |  44 +++
 .../selftests/bpf/libarena/src/stack.bpf.c    | 338 ++++++++++++++++++
 2 files changed, 382 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/stack.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/stack.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/stack.h b/tools=
/testing/selftests/bpf/libarena/include/stack.h
new file mode 100644
index 000000000000..9f9d8fb47935
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/stack.h
@@ -0,0 +1,44 @@
+#pragma once
+
+struct stk_seg;
+typedef struct stk_seg __arena stk_seg_t;
+
+/*
+ * We devote a single page to stk_seg, and size
+ * the void * array so it fits exactly in it.
+ * Account for prev/next pointers (2 * sizeof(void *)).
+ */
+#define STK_SEG_MAX ((__PAGE_SIZE - 2 * sizeof(void *)) / sizeof(void *)=
)
+
+struct stk_seg {
+	void __arena	*elems[STK_SEG_MAX];
+	stk_seg_t	*prev;
+	stk_seg_t	*next;
+};
+
+/*
+ * Extensible stack struct.
+ */
+struct stk {
+	arena_spinlock_t __arena *lock;
+
+	stk_seg_t *first;	/* First stack segment. */
+	stk_seg_t *last;
+
+	stk_seg_t *current;	/* Current stack segment. */
+	__u64 cind;
+
+	__u64 capacity;		/* Free slots in the stack. */
+	__u64 available;	/* Available items in the stack. */
+	__u64 data_size;
+	__u64 nr_pages_per_alloc;
+};
+
+
+u64 stk_alloc(struct stk *stack);
+int stk_init(struct stk *stackp, arena_spinlock_t __arena *lock,
+		__u64 data_size, __u64 nr_pages_per_alloc);
+void stk_destroy(struct stk *stack);
+int stk_free_internal(struct stk *stack, __u64 elem);
+
+#define stk_free(stack, elem) stk_free_internal(stack, (__u64)elem)
diff --git a/tools/testing/selftests/bpf/libarena/src/stack.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/stack.bpf.c
new file mode 100644
index 000000000000..37f8ce43e0f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
@@ -0,0 +1,338 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <stack.h>
+
+/*
+ * Necessary for cond_break/can_loop's semantics. According to kernel co=
mmit
+ * 011832b, the loop counter variable must be seen as imprecise and boun=
ded
+ * by the verifier. Initializing it from a constant (e.g., i =3D 0;), th=
en,
+ * makes it precise and prevents may_goto from helping with converging t=
he
+ * loop. For these loops we must initialize the loop counter from a vari=
able
+ * whose value the verifier cannot reason about when checking the progra=
m, so
+ * that the loop counter's value is imprecise.
+ */
+static __u64 zero =3D 0;
+
+enum {
+	STACK_POISONED =3D (s8)0xef,
+};
+
+__hidden int stk_init(struct stk *stack,
+			  arena_spinlock_t __arg_arena __arena *lock,
+			  __u64 data_size, __u64 nr_pages_per_alloc)
+{
+	if (!stack)
+		return -EINVAL;
+
+	stack->data_size =3D data_size;
+	stack->nr_pages_per_alloc =3D nr_pages_per_alloc;
+	stack->lock =3D lock;
+
+	return 0;
+}
+
+__hidden void stk_destroy(struct stk *stack)
+{
+	stk_seg_t *seg, *next;
+	__u64 nr_pages;
+
+	/* Operation happens unlocked since we are called last. */
+
+	if (!stack)
+		return;
+
+	nr_pages =3D stack->nr_pages_per_alloc;
+
+	for (seg =3D stack->first; seg && can_loop; seg =3D next) {
+		next =3D seg->next;
+		asan_unpoison(seg, sizeof(*seg));
+		bpf_arena_free_pages(&arena, seg, nr_pages);
+	}
+
+	stack->first =3D NULL;
+	stack->last =3D NULL;
+
+	stack->current =3D NULL;
+	stack->cind =3D 0;
+
+	stack->capacity =3D 0;
+	stack->available =3D 0;
+	stack->data_size =3D 0;
+	stack->nr_pages_per_alloc =3D 0;
+}
+
+static int stk_push(struct stk *stack, void __arena *elem)
+{
+	stk_seg_t *stk_seg =3D stack->current;
+	int ridx =3D stack->cind;
+
+	stack->current->elems[stack->cind] =3D elem;
+
+	ridx +=3D 1;
+
+	/* Possibly loop into the next segment. */
+	if (ridx =3D=3D STK_SEG_MAX) {
+		ridx =3D 0;
+		stk_seg =3D stk_seg->next;
+		if (!stk_seg)
+			return -ENOSPC;
+	}
+
+	stack->current =3D stk_seg;
+	stack->cind =3D ridx;
+
+	stack->capacity -=3D 1;
+	stack->available +=3D 1;
+
+	return 0;
+}
+
+static void __arena *stk_pop(struct stk *stack)
+{
+	stk_seg_t *stk_seg =3D stack->current;
+	void __arena *elem;
+	int ridx =3D stack->cind;
+
+	/* Possibly loop into previous segment. */
+	if (ridx =3D=3D 0) {
+		ridx =3D STK_SEG_MAX;
+		stk_seg =3D stack->current->prev;
+		/* Possibly loop back into the last segment. */
+		if (!stk_seg)
+			return NULL;
+	}
+
+	ridx -=3D 1;
+
+	stack->current =3D stk_seg;
+	stack->cind =3D ridx;
+
+	elem =3D stack->current->elems[stack->cind];
+
+	stack->capacity +=3D 1;
+	stack->available -=3D 1;
+
+	return elem;
+}
+
+static int stk_seg_to_data(struct stk *stack, size_t nelems)
+{
+	int ret, i;
+	u64 data;
+
+	/* Do we have enough empty segments for the conversion? */
+	if (!stack->first || stack->first =3D=3D stack->last)
+		return -ENOMEM;
+
+	data =3D (u64)stack->last;
+
+	stack->last->prev->next =3D NULL;
+	stack->last =3D stack->last->prev;
+
+	/* We removed a segment. */
+	stack->capacity -=3D STK_SEG_MAX;
+
+	for (i =3D zero; i < nelems && can_loop; i++) {
+		asan_poison((void __arena *)data, STACK_POISONED,
+			    sizeof(struct stk_seg));
+
+		/* This operation should never fail. */
+		ret =3D stk_push(stack, (void __arena *)data);
+		if (ret)
+			return ret;
+
+		data +=3D stack->data_size;
+	}
+
+	return 0;
+}
+
+static void stk_extend(struct stk *stack, stk_seg_t *stk_seg)
+{
+	if (stack->last)
+		stack->last->next =3D stk_seg;
+
+	stk_seg->prev =3D stack->last;
+	stk_seg->next =3D NULL;
+
+	stack->last =3D stk_seg;
+	stack->capacity +=3D STK_SEG_MAX;
+
+	if (!stack->first)
+		stack->current =3D stack->first =3D stk_seg;
+
+	/*
+	 * Do not adjust the current segment/idx because we did not add
+	 * any elements. The new segment will be pushed into during the next
+	 * allocation.
+	 */
+}
+
+static int stk_free_unlocked(struct stk *stack, void __arena *elem)
+{
+	if (!stack)
+		return -EINVAL;
+
+	asan_poison(elem, STACK_POISONED, stack->data_size);
+
+	/* If no more room, repurpose the allocation into a segment. */
+	if (stack->capacity =3D=3D 0) {
+		asan_unpoison(elem, sizeof(struct stk_seg));
+
+		stk_extend(stack, (stk_seg_t *)elem);
+		return 0;
+	}
+
+	return stk_push(stack, elem);
+}
+
+__weak int stk_free_internal(struct stk *stack, __u64 elem)
+{
+	int ret;
+
+	if (!stack)
+		return -EINVAL;
+
+	ret =3D arena_spin_lock(stack->lock);
+	if (ret)
+		return ret;
+
+	ret =3D stk_free_unlocked(stack, (void __arena *)elem);
+
+	arena_spin_unlock(stack->lock);
+
+	return ret;
+}
+
+static int stk_get_arena_memory(struct stk *stack, __u64 nr_pages, stk_s=
eg_t **data_seg, stk_seg_t **stk_seg)
+{
+	size_t nstk_segs;
+	u64 mem;
+
+	_Static_assert(sizeof(struct stk_seg) <=3D __PAGE_SIZE,
+		       "segment must fit into a page");
+
+	/*
+	 * The code allocates new memory only as segments. The allocation and
+	 * free code freely typecasts the segment buffer into data that can be
+	 * allocated, and vice versa to avoid either ending up with too many
+	 * empty segments under memory pressure, or having no space in the segm=
ent
+	 * buffer for a buffer currently being freed.
+	 */
+
+	if (!stack)
+		return -EINVAL;
+
+	nstk_segs =3D stk_seg ? 2 : 1;
+
+	mem =3D (__u64)bpf_arena_alloc_pages(&arena, NULL, nstk_segs * nr_pages=
,
+					   NUMA_NO_NODE, 0);
+	if (!mem)
+		return -ENOMEM;
+
+	/* Poison the entire data segment allocated */
+	*data_seg =3D (stk_seg_t *)mem;
+	asan_poison((void __arena *)mem, STACK_POISONED, nr_pages * __PAGE_SIZE=
);
+
+	if (!stk_seg)
+		return 0;
+
+	/* Skip the segment metadata when poisoning. */
+	*stk_seg =3D (stk_seg_t *)(mem + nr_pages * __PAGE_SIZE);
+	asan_poison((void __arena *)(mem + sizeof(**stk_seg)), STACK_POISONED,
+		nr_pages * __PAGE_SIZE);
+
+	return 0;
+}
+
+static int stk_fill_new_elems(struct stk *stack)
+{
+	stk_seg_t *data_seg, *stk_seg;
+	bool need_stk_seg;
+	__u64 nr_pages;
+	size_t nelems;
+	int ret, i;
+	u64 mem;
+
+	nr_pages =3D stack->nr_pages_per_alloc;
+	nelems =3D (nr_pages * __PAGE_SIZE) / stack->data_size;
+	if (nelems > STK_SEG_MAX) {
+		return -EINVAL;
+	}
+
+	/*
+	 * If we have more than two empty segments available,
+	 * try to repurpose one of them into an allocation.
+	 */
+	ret =3D stk_seg_to_data(stack, nelems);
+	if (!ret)
+		return 0;
+
+	need_stk_seg =3D !stack->capacity;
+
+	/* Get memory for a new data segment, and possibly a stack segment if n=
ecessary. */
+	ret =3D stk_get_arena_memory(stack, nr_pages, &data_seg, need_stk_seg ?=
 &stk_seg : NULL);
+	if (ret)
+		return ret;
+
+	if (need_stk_seg)
+		stk_extend(stack, stk_seg);
+
+	mem =3D (u64)data_seg;
+	for (i =3D zero; i < nelems && can_loop; i++) {
+		ret =3D stk_push(stack, (void __arena *)mem);
+		if (ret)
+			return ret;
+		mem +=3D stack->data_size;
+	}
+
+	return 0;
+}
+
+static inline __u64 stk_alloc_unlocked(struct stk *stack)
+{
+	void __arena *elem;
+	int ret;
+
+	/* If segment buffer is empty, we have to populate it. */
+	if (stack->available =3D=3D 0) {
+		/* The call drops the lock on error. */
+		ret =3D stk_fill_new_elems(stack);
+		if (ret)
+			return 0ULL;
+	}
+
+	/* An elem value of 0 implies error, drop the lock. */
+	elem =3D stk_pop(stack);
+	if (elem)
+		asan_unpoison(elem, stack->data_size);
+
+	return (__u64)elem;
+}
+
+__weak __u64 stk_alloc(struct stk *stack)
+{
+	u64 elem;
+
+	if (!stack) {
+		bpf_printk("using uninitialized stack allocator");
+		return 0ULL;
+	}
+
+	if (arena_spin_lock(stack->lock))
+		return 0ULL;
+
+	elem =3D stk_alloc_unlocked(stack);
+
+	arena_spin_unlock(stack->lock);
+
+	return (u64)elem;
+}
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

