Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A7326D4A
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537794; cv=none; b=ip24MlccuwX26G3+xQ2n/h883tKeJCp/RsvxERDfuVvBNGp8JulwLd/7XHLztk2uHAZJ2sl2xABro7uyVLCb/MsoWvHeEpxa6+zUUNrlVUfQlLyZ40l/TUD+pgpxidufEe76KLMoiZ74Xm/WfswA55I1AD2MNTswi6U/pdN9GHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537794; c=relaxed/simple;
	bh=TVxA1zVPh7pAWY/yJthLuFbkjRPu2RZ6GnU11x2xflE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTO14Gb7zALwCDIaJplBFrTfFGEQcEHac9cxAYdE6FQ5nyz4pUCdl5S72D0w86xiWz+dG8yOwFQ8UuWLn0cxBv3Cn3UwyV2vFdmpFHVY31VNF4wZeSVDeWMsR15Bv+dE8KMrs6F+tP2a/HM/c26chyCgvZM3rD+a6G0Y6OC70Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SvBQZBXE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SvBQZBXE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b7de222so71633951cf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537792; x=1770142592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBXgdNU4llk0PoM8RqUonAjvoQo+wl+GZJGs/1U3yqY=;
        b=SvBQZBXEK7OHI/8ltPnQk+wRhEMAbLGQSCjDgyK06A8KXiQBV9fWOhqH0E4yZB/7le
         g5zb0b7F+8ecrtTJNSGSfNK8Dj/rBU4MFiFvZfVrM1fCgDyaY/i9MwPCHoKeaT46wflS
         +R5CYfurS0z0CHyTFiyiW/WxjtikKvfS+gK1eBjbu/wA/BfEzo0JQ8eiBgKCo3xkaSCC
         QaIefEUOxLqarTICwtijH2k+G5TmkCNrLQ1by2prfg0NMDyCg7MvjBIOoOy0SeCo79VB
         aThROlKDqiiDev2fCxCsjA7LX/0rzegFb41hFzf9mvkL4haM2TLA2MrzcVnAJc4ysuZ1
         YsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537792; x=1770142592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBXgdNU4llk0PoM8RqUonAjvoQo+wl+GZJGs/1U3yqY=;
        b=G+uEnVW5RpRbCUNTRxsb8wcUYeQNetC+12ywExYKJTdEkkrO1eO08AHnDr1YxpshBb
         pGvI8B/xkNuiv/zZd3S7aFWOwRbKrPv5B9VtINwlGbgBOL8fqSeH4whkE7D0yg+5zTd+
         xlUkmg2QFJ2gvLdLbMmH7OGG9M8qmPdSmYHlmT5oLiDA38Ii7I5KFxgDgDWG5GE4UX1r
         O5rlmqVwitCyI67MrR4vhIpMPzgO/OkNEU0IvR8vlECFuZLYkpok3OJ6Ai9Z936MDZsU
         CBak/0fBNRPhJyYHuoV62h/z9MvZMrP7caL0Bbyg7fBqAWo3H16ynfnvcMl473AdCC6O
         kxaw==
X-Gm-Message-State: AOJu0Yz3RESHLe8yuTudFfC23UO8QBiHwWAxgCxXkLMb/zCf0NTB9qB5
	wuoB/TQv9p7TtAAp2ouSW7IQngR0twdUSR37vE3f7AdWqzm7ndt4DyBnmYTOrKy3wA7XqvRIsGs
	pZYTg
X-Gm-Gg: AZuq6aIA0r9vIiR0+YF7PAI33pPl+t2IpQFCOoI6ZFLGS6JinKgGoifeOWwC541fm2r
	dqzuqrzFfkeXiyyc2n5p3tL1fk2zIC5J7Vxa/sn9F6jT1ThzYr4jTDEThNJAvedyU68WaRqO3eM
	GUzDejBETz40Mio6HvFq0T11VXrxv0ZPDBwmAr5OdQMh97sRtRX9LFTfBPla8UmPrCG4IWs1UF8
	dwlYdSRr0s5eOJRnuGr6vhFgqiRu1Jd5gyxq7m2TOHNbtB256OIh6jvlrT7aMs5cGRsP9TcZZ3o
	FeyVB1ue4e0PD8R15AU+G/f/oI868WBSck7FuFG0cpCa2TZtRDQUJi/BgpCYH5f7ktscgH0c73v
	vuua5k2hP2etOJOhARYRrMmWAw0YeUJ02k1ptDwbDOz6081Ely+vbg3oyHcMUIgjCAG0Ga2G3xz
	6JATzkX6q7PQ==
X-Received: by 2002:ac8:5dc6:0:b0:501:4a4a:c249 with SMTP id d75a77b69052e-5032f883cc0mr34458611cf.23.1769537791449;
        Tue, 27 Jan 2026 10:16:31 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:31 -0800 (PST)
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
Subject: [PATCH v2 08/13] selftest: bpf: Add bump allocator for libarena
Date: Tue, 27 Jan 2026 13:16:04 -0500
Message-ID: <20260127181610.86376-9-emil@etsalapatis.com>
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

Add an arena-based bump allocator to the arenalib. The allocator
is aimed towards data allocated at program startup whose lifetime
is that of the BPF program. An example is CPU-related information
for sched-ext scheduler.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/bump.h     |  26 +++
 .../selftests/bpf/libarena/src/bump.bpf.c     | 196 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bump.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bump.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/bump.h b/tools/testing/selftests/bpf/libarena/include/bump.h
new file mode 100644
index 000000000000..ac643f29acc0
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/bump.h
@@ -0,0 +1,26 @@
+#pragma once
+
+#ifdef __BPF__
+
+u64 bump_alloc_internal(size_t bytes, size_t alignment);
+#define bump_alloc(bytes, alignment) ((void __arena *)bump_alloc_internal((bytes), (alignment)))
+int bump_init(size_t contig_pages);
+int bump_destroy(void);
+int bump_memlimit(u64 lim_memusage);
+
+#endif /* __BPF__ */
+
+#define BUMP_ALLOCS_MAX (64)
+
+struct bump {
+	size_t max_contig_bytes;
+	void __arena *memory;
+	size_t off;
+	size_t lim_memusage;
+	size_t cur_memusage;
+
+	void __arena *past_allocs[BUMP_ALLOCS_MAX];
+
+	size_t past_allocs_ind;
+};
+
diff --git a/tools/testing/selftests/bpf/libarena/src/bump.bpf.c b/tools/testing/selftests/bpf/libarena/src/bump.bpf.c
new file mode 100644
index 000000000000..721c668475a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/bump.bpf.c
@@ -0,0 +1,196 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+/*
+ * Static allocation module used to allocate arena memory for
+ * whose lifetime is that of the BPF program. Data is rarely
+ * allocated, mostly at program init, and never freed. The
+ * memory returned by this code is typeless so it avoids us
+ * having to define an allocator for each type.
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <bump.h>
+
+/* Maximum memory that can be allocated by the arena. */
+#define ARENA_MAX_MEMORY (1ULL << 20)
+
+private(STATIC_ALLOC_LOCK) struct bpf_spin_lock static_lock;
+
+private(STATIC_ALLOC) struct bump bump;
+
+const s8 STATIC_POISON_UNINIT = 0xff;
+
+__weak u64 bump_alloc_internal(size_t bytes, size_t alignment)
+{
+	void __arena *memory;
+	size_t	alloc_bytes;
+	size_t	alloc_pages;
+	void __arena *ptr;
+	size_t padding;
+	size_t ind;
+	u64 addr;
+
+	/* 
+	 * Allocated addresses must be aligned to the nearest granule,
+	 * and since we're stack allocating this implies that allocations
+	 * sizes are also aligned.
+	 */
+	alignment = round_up(alignment, 1 << ASAN_SHADOW_SHIFT);
+
+	bpf_spin_lock(&static_lock);
+
+	/* Round up the current offset. */
+	addr = (__u64)bump.memory + bump.off;
+
+	padding	= round_up(addr, alignment) - addr;
+	alloc_bytes = bytes + padding;
+
+	if (alloc_bytes > bump.max_contig_bytes) {
+		bpf_spin_unlock(&static_lock);
+		bpf_printk("invalid request %ld, max is %ld\n", alloc_bytes,
+			   bump.max_contig_bytes);
+		return (u64)NULL;
+	}
+
+	/*
+	 * The code assumes that the maximum static allocation
+	 * size is significantly larger than the typical allocation
+	 * size, so it does not attempt to alleviate memory
+	 * fragmentation.
+	 */
+	if (bump.off + alloc_bytes > bump.max_contig_bytes) {
+		if (bump.cur_memusage + bump.max_contig_bytes >
+		    bump.lim_memusage) {
+			bpf_spin_unlock(&static_lock);
+			bpf_printk("allocator memory limit exceeded");
+			return (u64)NULL;
+		}
+
+		alloc_pages = bump.max_contig_bytes / __PAGE_SIZE;
+
+		memory = bpf_arena_alloc_pages(&arena, NULL, alloc_pages,
+						    NUMA_NO_NODE, 0);
+		if (!memory) {
+			bpf_spin_unlock(&static_lock);
+			bpf_printk("failed to allocate memory");
+			return (u64)NULL;
+		}
+
+		/* Keep a list of allocated blocks to free on allocator destruction. */
+		ind = bump.past_allocs_ind++ % BUMP_ALLOCS_MAX;
+		bump.past_allocs[ind] = memory;
+
+		asan_poison(memory, STATIC_POISON_UNINIT, bump.max_contig_bytes);
+
+		/*
+		 * Switch to new memory block, reset offset,
+		 * and recalculate base address.
+		 */
+		bump.memory = memory;
+		bump.off = 0;
+		addr = (__u64)bump.memory;
+
+		/*
+		 * We changed the base address. Recompute the padding.
+		 */
+		padding	= round_up(addr, alignment) - addr;
+		alloc_bytes = bytes + padding;
+
+		bump.cur_memusage += bump.max_contig_bytes;
+	}
+
+	ptr = (void __arena *)(addr + padding);
+	asan_unpoison(ptr, bytes);
+
+	bump.off += alloc_bytes;
+
+	bpf_spin_unlock(&static_lock);
+
+	return (u64)ptr;
+}
+
+__weak int bump_destroy(void)
+{
+	size_t alloc_pages = bump.max_contig_bytes / __PAGE_SIZE;
+	void __arena *mem;
+	size_t lim;
+	int i;
+
+	/* Free all allocated blocks. */
+
+	lim = bump.past_allocs_ind < BUMP_ALLOCS_MAX ? 
+		bump.past_allocs_ind : BUMP_ALLOCS_MAX;
+
+	for (i = 0; i < lim && can_loop; i++) {
+		mem = bump.past_allocs[i];
+		asan_unpoison(mem, bump.max_contig_bytes);
+		bpf_arena_free_pages(&arena, mem, alloc_pages);
+	}
+
+	return 0;
+}
+
+__weak int bump_init(size_t contig_pages)
+{
+	size_t contig_bytes = contig_pages * __PAGE_SIZE;
+	void __arena *memory;
+	size_t ind;
+	int ret;
+
+	memory = bpf_arena_alloc_pages(&arena, NULL, contig_pages, NUMA_NO_NODE,
+				       0);
+	if (!memory) {
+		bpf_printk("Failed to allocate %d pages", contig_pages);
+		return -ENOMEM;
+	}
+
+	ret = asan_poison(memory, STATIC_POISON_UNINIT, contig_bytes);
+	if (ret)
+		bpf_printk("Error %d: by poisoning", ret);
+
+	bump.max_contig_bytes = contig_bytes;
+	bump.off = 0;
+	bump.memory = memory;
+	bump.lim_memusage = ARENA_MAX_MEMORY;
+	bump.cur_memusage = contig_bytes;
+
+	ind = bump.past_allocs_ind++ % BUMP_ALLOCS_MAX;
+	bump.past_allocs[ind] = memory;
+
+	return 0;
+}
+
+__weak int bump_memlimit(u64 lim_memusage)
+{
+	bpf_spin_lock(&static_lock);
+
+	if (lim_memusage > BUMP_ALLOCS_MAX * bump.max_contig_bytes)
+		goto error;
+
+	/* We always allocate at a page granularity. */
+	if (lim_memusage % __PAGE_SIZE)
+		goto error;
+
+	/* Have we already overshot the limit? */
+	if (lim_memusage < bump.cur_memusage)
+		goto error;
+
+	bump.lim_memusage = lim_memusage;
+
+	bpf_spin_unlock(&static_lock);
+
+	return 0;
+
+error:
+	bpf_spin_unlock(&static_lock);
+
+	return -EINVAL;
+}
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

