Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4647B413
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432467; cv=none; b=qNgSOBo0dSU4k1GH15pJ453hhU0ElfSdbcxw6xJZN/sNRFmoAlFZi1Ydpvs7zlvzSNrhXLikTeuKKPhKjiBwVw5vTW8c4vRlAGBDep5VS5YTaqhKXkC11yJZHxfG8b6UJ8Jkc64xktWxbwFkZ1wATrLlgXK11AT3d+n2ZYA7AHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432467; c=relaxed/simple;
	bh=2ztwPnz+CeLfCfSQSgYg3xJZHLqe/up8BWBlZ6kXbXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPspYqnhX3hd1CA3ptqQrTDT9A5faYHVEO5JqyKLTRwLVnO8n35j1v/pF3hUiFCf3jRjiMsLIm5GVp6G6iJaMLtInJDmGI9mxDOBfnQsnNY2ih18DQeYgbN1OTWgc9xOxHDcu88KN682PfclActptY7+Rt+WhK9ObJnNC/D/bO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otVjUuw8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otVjUuw8"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so918144a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432465; x=1791037265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZIU1JYbksq1uycE9yjt8vtN/BBAQJWnYcW/gyaI/vk=;
        b=otVjUuw8+/53Eq7G3ntCiyn2znFaoRrlce6KcUU5XTrBV02GHWmzJ7W8AvPvJcEprU
         iMv/jbNOYemVbNfDSUEDQslm4rdMCoSb3GdNYLY2Xebbted6ImKkYv8rutlvvVpO5r4w
         Hgm7U3mdLBvTffQnI9rmqzLN49lDcYlh3Jm/SK/7EtXIxa1PcKjl9r66uvrAac6O9w0g
         2mC5Exp+hPRLfPJFsb1Mbkqjai9iG9wYvZDk7rx8zrefyzLlcZu3jxMNoEwUw3YmcWjf
         Vlf2FG4jB4cE0uDKrfLQTrohbwU7BcU/VcYtkNBI0l7XJDyexVfd3sxx/JI/9y2uIdSS
         v/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432465; x=1791037265;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZIU1JYbksq1uycE9yjt8vtN/BBAQJWnYcW/gyaI/vk=;
        b=TLcZFAnEpZqqCNRsMOI7MH9yMq0qIxvhsfU+I8T3UsbF9taOHrDldyz01goX4gSyZW
         nbUNu37svmcDAGCZct82/M2fRX6B5Pf4OqesplVO0Cgz8VF9T+l8S2oRlIitNb2UmWB/
         Idru86PMSwUa+RK9eSZoNWKI+0LEy76YgKtskKZmhXV6oe5tq7HgiPVagssDIGhL0wje
         7YiXNmaPpPN8mEJ+/xHaqA9nahUctDQ2/ppxRukILtJwdjTVyHW+/Rf80NLOfFkqZbG+
         GIvtAY8iWx5aQhj7ugX5rpBIt2RXXXvOnbf8UgU+WifH1+4Qk9RjiX1CB1+z08cveRaS
         9NUg==
X-Gm-Message-State: AFq9FYIttDFEPmu8b3nAnwVM9FjyB7/Jtdp0OQFJPxKs6xyL2jZZhlsx
	FiOs9alIU/CGccpWeC4atDS0tQJIn/fhAOQkIt1UHIL5Ijw0gc5C9wJY1T5iBnxhk7M=
X-Gm-Gg: AYBFou2ZD1c2nImkpqrfP51fT/0jUAf5CXDrO6MyErcmkv1rTgCIqgVsx+ghcog7OsP
	tlg2pwtG1m73wTBXz+07DniShF/iaqAMsRZbPZWjycirQi2eTuQ+T3uObIi3TDyNRqtKldGffq+
	yQsxkvovm3QGTuuevk0tUdspjm9Je4UYonaSVYM0RtEL1GK4YFlXJ0QC+YZ+zlwkrgIYsK957Pe
	Izyd9B7uMfw9T3qNePHnDtwzo2kAc20/D3dlRaUPjLND9j21Ob/UrzdiQUYx8szPPFCjMPnN+oe
	eSVCeuMM332WSn7MmuBrZT9x8DYs+fK526eR+mW/UGSJVHaH82jDpkEGmEjbWy1bUzRRl5xhJFI
	wYFwJJFC4VNqv8mBp3U5BG6kYjiO8RU+BrfXeecSIsWLuH/EGmuPSKVPKd6Xr77duu9TzM4Iv5e
	EWudrN1HaT2oD/OWhzQfKqiYr3llxIdW4fzMMHs969aSi4iz3PLhJ8b4rtoOwtwdD5qLu7/nr4j
	IAagGulesmEMP9a3CtapQ1Yf4EAE5k5GvhQOARMuQ==
X-Received: by 2002:a17:90b:510a:b0:3a0:9640:802e with SMTP id 98e67ed59e1d1-3a0986ec975mr7553281a91.8.1790432464919;
        Sat, 26 Sep 2026 07:21:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Eduard Zingerman <ezingerman@fb.com>
Subject: [PATCH bpf-next 20/36] bpf: add a min-heap for ordered analysis worklists
Date: Sat, 26 Sep 2026 07:20:18 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-20-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <ezingerman@fb.com>

SCEV needs to process pending basic blocks in reverse postorder.
Provide a small integer min-heap whose comparator can order instruction
indices by their CFG ranks.

Grow the backing array on demand and pass caller context to the
comparator, so the heap need not encode the analysis-specific order.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 17 +++++++++
 kernel/bpf/Makefile          |  2 +-
 kernel/bpf/heap.c            | 87 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d8142f1b2347..f2497236542c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1916,4 +1916,21 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
+/*
+ * Simple binary heap implementation as described by
+ * https://en.wikipedia.org/wiki/Binary_heap
+ */
+struct bpf_min_heap {
+	int (*compare)(int, int, void *); /* ordering function for @elements */
+	int *elements; /* min-heap ordered by @compare */
+	void *arg; /* 3rd argument passed to @compare */
+	int capacity;
+	int count;
+};
+
+void bpf_min_heap_init(struct bpf_min_heap *heap, int (*compare)(int, int, void *), void *arg);
+void bpf_min_heap_free(struct bpf_min_heap *heap);
+int bpf_min_heap_push(struct bpf_min_heap *heap, int elt);
+bool bpf_min_heap_pop(struct bpf_min_heap *heap, int *elt);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 6210601eb40b..7a2c179a9059 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o loops.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o loops.o heap.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/heap.c b/kernel/bpf/heap.c
new file mode 100644
index 000000000000..029f9217b872
--- /dev/null
+++ b/kernel/bpf/heap.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf_verifier.h>
+
+/* Indexes for binary tree encoded as an array */
+static inline int left_child(int i) { return 2 * i + 1; }
+static inline int right_child(int i) { return 2 * i + 2; }
+static inline int parent(int i) { return (i - 1) / 2; }
+
+static inline int greater(struct bpf_min_heap *heap, int a, int b)
+{
+	return heap->compare(a, b, heap->arg) > 0;
+}
+
+void bpf_min_heap_init(struct bpf_min_heap *heap, int (*compare)(int, int, void *), void *arg)
+{
+	memset(heap, 0, sizeof(*heap));
+	heap->compare = compare;
+	heap->arg = arg;
+}
+
+void bpf_min_heap_free(struct bpf_min_heap *heap)
+{
+	kfree(heap->elements);
+	heap->elements = NULL;
+	heap->capacity = 0;
+	heap->count = 0;
+}
+
+int bpf_min_heap_push(struct bpf_min_heap *heap, int elt)
+{
+	int new_capacity, i;
+	int *elements;
+	void *tmp;
+
+	if (heap->count == heap->capacity) {
+		new_capacity = heap->capacity ? heap->capacity * 2 : 16;
+		tmp = krealloc(heap->elements,
+			       sizeof(*heap->elements) * new_capacity,
+			       GFP_KERNEL_ACCOUNT);
+		if (!tmp)
+			return -ENOMEM;
+		heap->elements = tmp;
+		heap->capacity = new_capacity;
+	}
+
+	elements = heap->elements;
+	i = heap->count;
+	elements[i] = elt;
+	heap->count++;
+	while (i != 0 && greater(heap, elements[parent(i)], elements[i])) {
+		swap(elements[i], elements[parent(i)]);
+		i = parent(i);
+	}
+	return 0;
+}
+
+static inline void sink_root(struct bpf_min_heap *heap)
+{
+	int *elements = heap->elements;
+	int i = 0;
+
+	while ((left_child(i)  < heap->count && greater(heap, elements[i], elements[left_child(i)])) ||
+	       (right_child(i) < heap->count && greater(heap, elements[i], elements[right_child(i)]))) {
+		if (right_child(i) >= heap->count || greater(heap, elements[right_child(i)], elements[left_child(i)])) {
+			swap(elements[i], elements[left_child(i)]);
+			i = left_child(i);
+		} else {
+			swap(elements[i], elements[right_child(i)]);
+			i = right_child(i);
+		}
+	}
+}
+
+bool bpf_min_heap_pop(struct bpf_min_heap *heap, int *elt)
+{
+	if (heap->count == 0)
+		return false;
+
+	int *elements = heap->elements;
+	*elt = elements[0];
+	elements[0] = elements[heap->count - 1];
+	--heap->count;
+	sink_root(heap);
+	return true;
+}

-- 
2.55.0
