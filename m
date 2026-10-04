Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A699439F88
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121139; cv=none; b=LluLKDTWeeIkt72Lhno6Fk1GSo8BVKfBygh3PX4x3mNYKcxWPWZxV3xRv1+7AUD4ckIslx8N/+Hm3vDOmm3hQteLY2Tza25+WcNcW0S1VRDgGEaUmhy7UYhzM0lbo7PeXoSvJcmvnCbrCJIZB+ojr3Bpc6s88vO1JzVXj+XPt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121139; c=relaxed/simple;
	bh=Jjyq7OeIqXDFy2J2JdtrBOxGlckCvLh07yqIivf/+LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8A/lp6ZivGJSPzQMCiYaOcXmI9iJMZxV3gHzGpaw5XzhuLa+QkKwH9mK+/uIncjQLJ6xWIBWdzZDmZUeV1kopPuWNZVK8O5c1ZQO+xUGa/PrmUaQdfi3da8FTq7eNPXelr9/wsJC+D2xGvnpsCikdVkHBI+dsrtScLC0AK24Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeKdljOU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeKdljOU"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88c72646f03so388706b3a.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121138; x=1791725938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5eczGBebgZQgnplARw62G9ctL5onzQLkJIzY/2SAJ0=;
        b=HeKdljOUryH3vOy1z4slEEdv+uv3/NVC1IEOflofuuI9WheXOUP70SKprXGI5tPVZi
         Z1Azw62+vNguWxcsK23siYrjPgBSY0xUz/F5ejM7+591sZtsI5NDS2EoRl6ijGMVzMqv
         DsNExgjNj0c7Lw9Sy16tT2GgA0fcwshSzrkTkSnEzMLYqkCjp8046tRinI3uC3xLBmpW
         ZFZsXFj05ZK2jPkZ00KESGR9oEhENUp4I+hudlVVYDVbx0TOzvHRnGzm+/pLrj0m/p4v
         BIn1UfmG5utydA3+dVHFBX15L8F+xrObSqCSlJsA5JOmKLQiTHztd52BOnAshx44L17s
         wA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121138; x=1791725938;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5eczGBebgZQgnplARw62G9ctL5onzQLkJIzY/2SAJ0=;
        b=wRpBI0X9Qzs6EevD8XE8An9EJyzR5uhRYTtiq3saj29YcaZnnegRwi0z9kIJudUssf
         rXbAx4881+3M6ijYZ0Ab0mQg6jJhP4Qyr8AQ3YH481XENsmhx+158LoJyQ3qrxb8XBLH
         InOG8nc32z+gXlqt7eFe5wHaKfo1eWftqQRhCBbe+vJJEeILQUaUZF/TsDdsYrqIJI48
         zgHuAl412oXHDuokfEj0PknMuz7+r6K3MYjFVMOiVu78/fgrAi20OrxdVFg/LouAJ/p6
         gjqOXCMmijTMH0jmFxCzK0SoznGaarssyhxqdZYpFF7QOiLdPfD2R0DIz/4W29Hw3zPi
         WesA==
X-Gm-Message-State: AFuF++loRwYG6pYMsgeuat7bccBELu+tvDY40LESKlRhVBLOIjMfcA9Y
	T/n0UyOba85+nbX8UtedYXb/N4u5asDqyXHYiNENX4mNCzeMnI+denqvnkfIvg==
X-Gm-Gg: AYBFou2SPSyZ4znZ9elhsTvl1frnUcu03MFOer2wq5BZGiF9Aw4JJL/IG7BtzC2Qgpb
	H7NaTYLC4VbzEeuSgVIHXEfGaJ9dHqhNUUwDWXwihKxJT7uwG5jxNtcjS25Qd5hbxAc3AMVvtfw
	mRvdkmsV/JrUeduzg0hfm4KyaDcBZ09FE+8i17In4/IGPO1WH3PYIMW/5kuIus8vMcJYSQ+xlWg
	sh1/7JRVlK6S+oPCFwbJeOUV8s5TmxCdPmn9N1pZKIQYBUl/w8CxZDpJtBc0+eFWwAyar25Rm94
	YIo/nFJhQCH6fM0POejTJ2OVN7PWMY8snbsv4ZSNGVGFn40ZLAGV6K6M01Y4OFidACheTI+JLtO
	9XGEGPauE3shOzYrwNjwDiUNsjibYEfTZFZzmdQl6db1fYOxA4UbIjROqawubcycyEAmF2YSK8T
	/kY29V4eeMbSy1j3j5u30MWibDScRsoFjGcFw8PumlzTgmYpVYnp0uxeT6GFPfND4QmHxjtMlYE
	RoB8JiNohmlGEs=
X-Received: by 2002:a05:6300:670b:b0:3dd:a009:3181 with SMTP id adf61e73a8af0-3e0d6cdbef9mr4223236637.41.1791121137637;
        Sun, 04 Oct 2026 06:38:57 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 23/43] bpf: add a min-heap for ordered analysis worklists
Date: Sun,  4 Oct 2026 06:38:05 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-23-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

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
index 555a41c5660e..8f5d35fa9aab 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1938,4 +1938,21 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
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
2.53.0
