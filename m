Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42B32B99E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698029; cv=none; b=hUjrtjyz5xDgcIexlXSrTg+HmjGOkpW1Tzr0x2cBL+LQrsyQm7u2Ug7Jpgkq9uLZKu5KDGAovsfbGRLg/IevqlBCBLOK5cktrENw2ge5uVaCu/LKRLkieRLXZFD2G2bf8+scrj0a4khHlWsztoTGyyBaj+kXrwFHhyd8l+O26hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698029; c=relaxed/simple;
	bh=GfL7DLoxQnKKavoqcIeEETCHTCPCfVE9440AWzfkJMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5XJHk3jAThoN/zRJEdrR1DTSncO63nVOMbb7gDNEnyHPFFeJoZHfMYEqTx8Z5iSgcgJKr/3CNztBH0u+eUkZGDnHtw8jG7FpT3DKnmX3TgFVvV7ZKkRW0qr77ZMPfPDfCRMQYd4xw5cNR5BZfjzEMzSQrpfXgkb3nAM9qztnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=L8JKB1Z7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="L8JKB1Z7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f869421so1812714b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780698026; x=1781302826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9W2qM0BG0qFBGEkQUmh34FKkg07JejQ87AxxZsnpaM=;
        b=L8JKB1Z7Ki9VFzxMg75awzYK4B1o8Oi5Vhpdu91phPq3XONGbsrViaQzkpMG5tTxUW
         v6qC0ECun5ota5zKCCg77QUdhiKvK+sY7QbaUt5RjLzOoYdzKAhLtkffhc//j1tl21f+
         n9dEbXCTQqVsUp0OFNXSIinl4KuaUoeaQLb2cQYZiLz+dc1D2xhQMfI5QmehAcscNqvX
         B4pPadcSSrHCHIe8UVeZjb8nGtpIh/RZbAGAU8i+Q7hrrWQ1erSWWMzOnX7kyBkAcyuM
         HFrOyJYLkug62NLmPnIRSu+NR68ZVX+JwSktu71/V3s//Cpg8DW+6EEq6iL+7MyL/f5T
         N0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780698026; x=1781302826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9W2qM0BG0qFBGEkQUmh34FKkg07JejQ87AxxZsnpaM=;
        b=UmTxjNAd0+nsMugx+CTA3Lfk6++iFQ6jLslhcD8HscBvJ2FgW3Ew4VXs9RVlZhhg1+
         2S0eQi548lLaxOK3w2dN1HUQbgymcx4Gp6mtw3ZTtsAqPpDzChTa2LzDcXyXeyKuck+t
         RonTt/4JRg1tPnM5Hq87ftbaSRXdyRVHPOPTL5364c6hpIqQfm9Kg83Ab8YR3p7rs7YK
         F/EJjX7ErJo3dum5Q6FYe3FgBqyW9Zq6quJte479J+glm7B0BWQ813N3Pdu0cHAs1hke
         TNXpoGCtxMkMtpRYfn3vesjhm6wIOtYpuMPiYMLI3XsZ4Rn+nPhL9oAY/K0wZWrtVvbu
         mIsA==
X-Gm-Message-State: AOJu0YxwgNq+Ei3jCpdb1Gx0egEAdLQhGBtgJ31XEzEbW7ylXfc6z7YE
	EAky/oNv9lL0XUS+BGVS88sc1Ep16DAmmSn5nZIXR9F0H4aEo5n/KHYBO38krbNaVnR5zvL0P/a
	mhhXV9RBhk6/Y
X-Gm-Gg: Acq92OH6t7LZdPQyeHQjmhVua9gLFnAbEOLD/t2uVqLI7iMpMlN8zvOGqfAmAlLYAUO
	XVRxulmSovbhmqJ2SkXdz7icdBdQaswkJWzLeGQCZPXa607kTyR4Vl774i+Zd8MIygapCaCHUYD
	UhOcDJfOV0qU+qgutPwF/s0B5WDqmuRFLOQF6QHteiPX8biENF37a03ntN2dUrqevwn3njat91S
	rg6Z0mqfo2P63bj1FrEdl01bE+rObakgG8JMCa1JznH9tuCMRFcu1O1rMPuKgHvwMPJfslDerhn
	SMgwNNh0oa0VQ3Vsb973gQC2cLiDeHr0QqUqDui9Sp31UJ573M5FeSz9025jH5ExsTFHl7+AhaZ
	jaBUkUKPC12OwjJ2qSZMRrvUOVhaLP25awmjz6Mlh3Vu0Ee+o1VxsiKcUMPXxmRxM52g4UCXDVc
	LoYR+D4yua8LrV83GBKk8X2dHD20A2P5NBzlw=
X-Received: by 2002:a05:6a00:234c:b0:82f:8e9f:bdd5 with SMTP id d2e1a72fcca58-842b0e1e281mr5650274b3a.1.1780698025542;
        Fri, 05 Jun 2026 15:20:25 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372868sm11648844b3a.17.2026.06.05.15.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:20:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: libarena: Add rbtree data structure
Date: Fri,  5 Jun 2026 18:20:18 -0400
Message-ID: <20260605222020.5231-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605222020.5231-1-emil@etsalapatis.com>
References: <20260605222020.5231-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a native red-black tree data structure to libarena.
The data structure supports multiple APIs (key-value based,
node based) with which users can query and modify it. The
tree uses the libarena memory allocator to manage its data.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |   83 ++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  |  968 +++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 1047 +++++++++++++++++
 3 files changed, 2098 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
new file mode 100644
index 000000000000..486428911d96
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause */
+
+#pragma once
+
+#define RB_MAXLVL_PRINT (16)
+
+struct rbnode;
+
+struct rbnode {
+	struct rbnode __arena *parent;
+	union {
+		struct {
+			struct rbnode __arena *left;
+			struct rbnode __arena *right;
+		};
+
+		struct rbnode __arena *child[2];
+	};
+	uint64_t key;
+	/* Used as a linked list or to store KV pairs. */
+	union {
+		struct rbnode __arena *next;
+		uint64_t value;
+	};
+	bool is_red;
+};
+
+/*
+ * Does the rbtree allocate its own nodes, or do they get
+ * allocated by the caller?
+ */
+enum rbtree_alloc {
+	RB_ALLOC,
+	RB_NOALLOC,
+};
+
+/*
+ * Specify the behavior of rbtree insertions when the key is
+ * already present in the tree.
+ *
+ * RB_DEFAULT: Default behavior, reject the new insert.
+ *
+ * RB_UPDATE: Update the existing value in the rbtree.
+ * This updates the node itself, not just the value in
+ * the existing node.
+ *
+ * RB_DUPLICATE: Allow nodes with identical keys in the rbtree.
+ * Finding/popping/removing a key acts on any of the nodes
+ * with the appropriate key - there is no ordering by time
+ * of insertion.
+ */
+enum rbtree_insert_mode {
+	RB_DEFAULT,
+	RB_UPDATE,
+	RB_DUPLICATE,
+};
+
+struct rbtree {
+	struct rbnode __arena *root;
+	enum rbtree_alloc alloc;
+	enum rbtree_insert_mode insert;
+};
+
+#ifdef __BPF__
+struct rbtree __arena *rb_create(enum rbtree_alloc alloc, enum rbtree_insert_mode insert);
+
+int rb_destroy(struct rbtree __arena *rbtree);
+int rb_insert(struct rbtree __arena *rbtree, u64 key, u64 value);
+int rb_remove(struct rbtree __arena *rbtree, u64 key);
+int rb_find(struct rbtree __arena *rbtree, u64 key, u64 *value);
+int rb_print(struct rbtree __arena *rbtree);
+int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value);
+int rb_pop(struct rbtree __arena *rbtree, u64 *key, u64 *value);
+
+int rb_insert_node(struct rbtree __arena *rbtree, struct rbnode __arena *node);
+int rb_remove_node(struct rbtree __arena *rbtree, struct rbnode __arena *node);
+
+struct rbnode __arena *rb_node_alloc(u64 key, u64 value);
+void rb_node_free(struct rbnode __arena *rbnode);
+
+int rb_integrity_check(struct rbtree __arena *rbtree);
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
new file mode 100644
index 000000000000..856c484a009a
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -0,0 +1,968 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/rbtree.h>
+
+typedef struct node_ctx __arena *node_ctx;
+
+struct node_ctx {
+	struct rbnode rbnode;
+	node_ctx next;
+};
+
+static const u64 keys[] = { 51, 43,  37, 3, 301,  46, 383, 990, 776, 729, 871, 96, 189, 213,
+	376, 167, 131, 939, 626, 119, 374, 700, 772, 154, 883, 620, 641, 5,
+	428, 516, 105, 622, 988, 811, 931, 973, 246, 690, 934, 744, 210, 311,
+	32, 255, 960, 830, 523, 429, 541, 738, 705, 774, 715, 446, 98, 578,
+	777, 191, 279, 91, 767 };
+
+static const u64 morekeys[] = { 173, 636, 1201, 8642, 5957, 3617, 4586, 8053, 6551, 7592, 1748, 1589, 8644, 9918, 6977,
+	4448, 5852, 4640, 9717, 2303, 7424, 7695, 2334, 8876, 8618, 5745, 7134, 2178, 5280, 2140, 1138,
+	5083, 8922, 1516, 2437, 2488, 4307, 4329, 5088, 8456, 5938, 1441, 1684, 5750, 721, 1107, 2089,
+	9737, 4687, 5016, 4849, 8193, 9603, 9147, 5992, 166, 6721, 812, 4144, 6237, 6509, 3466, 9255,
+	7767, 3960, 6759, 2968, 6046, 9784, 8395, 2619, 1711, 528, 6424, 9084, 3179, 1342, 5676, 9445,
+	5691, 6678, 8487, 1627, 998, 6178, 2229, 1987, 3319, 572, 169, 2161, 3018, 5439, 7287, 7265, 5995,
+	5003, 5857, 2836, 5634, 4735, 9261, 8287, 5359, 533, 1406, 9573, 4026, 714, 3956, 1722, 6395,
+	9648, 3887, 7185, 470, 4482, 4997, 841, 8913, 9946, 3999, 9357, 9847, 277, 8184, 8704, 6766, 3323,
+	5468, 8638, 7905, 8858, 6142, 3685, 3452, 4689, 8878, 8836, 158, 831, 7914, 3031, 8374, 4921,
+	4207, 3460, 5547, 3358, 1083, 4619, 7818, 2962, 4879, 4583, 2172, 8819, 9830, 1194, 2666, 9812,
+	5704, 8432, 5916, 6007, 6609, 4791, 1985, 3226, 2478, 9605, 5236, 8079, 3042, 1965, 3539, 9704,
+	4267, 6416, 760, 9968, 2983, 1190, 1964, 3211, 2870, 3106, 2794, 1542, 6916, 5986, 9096, 441,
+	5894, 8353, 7765, 3757, 5732, 88, 3091, 5637, 6042, 8447, 4073, 6923, 5491, 7010, 3663, 5029,
+	6162, 822, 4874, 7491, 5100, 3461, 6983, 2170, 1458, 1856, 648, 6272, 4887, 976, 2369, 5909, 4274,
+	3324, 6968, 2312, 2271, 8891, 6268, 6581, 1610, 8880, 6194, 6144, 9764, 6915, 829, 3774, 2265,
+	1752, 1314, 6377, 8760, 8004, 501, 4912, 9278, 1425, 9578, 7337, 307, 1885, 3151, 9617, 1647,
+	2458, 3702, 6091, 8902, 5663, 9378, 7640, 3336, 557, 1644, 6848, 1559, 8821, 266, 4330, 9790,
+	5920, 4222, 1143, 6248, 5792, 4847, 9726, 6303, 821, 6839, 6062, 7133, 3649, 9888, 2528, 1966,
+	5456, 4914, 3615, 1543, 3206, 3353, 6097, 2800, 1424, 9094, 7920, 7243, 1394, 5464, 1707, 576,
+	6524, 4261, 4187, 7889, 5336, 3377, 2921, 7244, 2766, 6584, 5514, 1387, 2957, 2258, 1077, 9979,
+	1128, 876, 4056, 4668, 4532, 1982, 7093, 4184, 5460, 7588, 4704, 6717, 61, 3959, 1826, 2294, 18,
+	8170, 9394, 8796, 7288, 7285, 7143, 148, 6676, 6603, 1051, 8225, 4169, 3230, 7697, 6971, 3454,
+	7501, 9514, 394, 2339, 4993, 5606, 6060, 1297, 8273, 3012, 157, 8181, 6765, 7207, 1005, 8833, 1914,
+	7456, 1846, 8375, 2741, 2074, 1712, 5286 };
+
+SEC("syscall")
+__weak int test_rbtree_find_nonexistent(void)
+{
+	u64 key = 0xdeadbeef;
+	u64 value = 0;
+	int ret;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_DEFAULT);
+	if (!rbtree)
+		return 1;
+
+	/* Should return -EINVAL */
+	ret = rb_find(rbtree, key, &value);
+	if (!ret)
+		return 2;
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_insert_existing(void)
+{
+	u64 key = 525252;
+	u64 value = 24;
+	int ret;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_DEFAULT);
+	if (!rbtree)
+		return 1;
+
+	ret = rb_insert(rbtree, key, value);
+	if (ret)
+		return 2;
+
+	/* Should return -EALREADY. */
+	ret = rb_insert(rbtree, key, value);
+	if (ret != -EALREADY) {
+		return 3;
+	}
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_update_existing(void)
+{
+	u64 key = 33333;
+	u64 value;
+	int ret;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	value = 52;
+	ret = rb_insert(rbtree, key, value);
+	if (ret)
+		return 2;
+
+	ret = rb_find(rbtree, key, &value);
+	if (ret)
+		return 3;
+
+	if (value != 52)
+		return 4;
+
+	value = 65;
+
+	/* Should succeed. */
+	ret = rb_insert(rbtree, key, value);
+	if (ret)
+		return 5;
+
+	/* Should be updated. */
+	ret = rb_find(rbtree, key, &value);
+	if (ret)
+		return 6;
+
+	if (value != 65)
+		return 7;
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_insert_one(void)
+{
+	u64 key = 202020;
+	u64 value = 0xbadcafe;
+	int ret;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	ret = rb_insert(rbtree, key, value);
+	if (ret)
+		return 2;
+
+	ret = rb_find(rbtree, key, &value);
+	if (ret)
+		return 3;
+
+	if (value != 0xbadcafe)
+		return 4;
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_insert_ten(void)
+{
+	u64 key, value;
+	int ret, i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		key = keys[i];
+		ret = rb_insert(rbtree, key, 2 * key);
+		if (ret)
+			return 2 + 3 * i;
+
+		/* Read it back. */
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return 2 + 3 * i + 1;
+
+		if (value != 2 * key)
+			return 2 + 3 * i + 2;
+	}
+
+	/* Go find all inserted pairs. */
+	for (i = 0; i < 10 && can_loop; i++) {
+		key = keys[i];
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return 35 + 2 * i;
+
+		if (value != 2 * key)
+			return 35 + 2 * i + 1;
+	}
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_duplicate(void)
+{
+	u64 key = 0x121212;
+	u64 value;
+	int ret, i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_DUPLICATE);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < 10 && can_loop; i++) {
+		ret = rb_insert(rbtree, key, 2 * key);
+		if (ret)
+			return 2 + 3 * i;
+
+		/* Read it back. */
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return 2 + 3 * i + 1;
+
+		if (value != 2 * key)
+			return 2 + 3 * i + 2;
+	}
+
+	/* Go find all inserted copies and remove them. */
+	for (i = 0; i < 10 && can_loop; i++) {
+		ret = rb_find(rbtree, key, &value);
+		if (ret) {
+			rb_print(rbtree);
+			return 35 + 3 * i;
+		}
+
+		if (value != 2 * key)
+			return 35 + 3 * i + 1;
+
+		ret = rb_remove(rbtree, key);
+		if (ret)
+			return 35 + 3 * i + 2;
+	}
+
+	return rb_destroy(rbtree);
+}
+
+static inline int
+clean_up_noalloc_tree(struct rbtree __arena *rbtree)
+{
+	node_ctx nodec;
+	int ret;
+
+	if (rbtree->alloc != RB_NOALLOC)
+		return -EINVAL;
+
+	/* Can't destroy an RB_NOALLOC tree that still has nodes. */
+	if (rb_destroy(rbtree) != -EBUSY)
+		return -EINVAL;
+
+	while (rbtree->root && can_loop) {
+		nodec = (node_ctx)arena_container_of(rbtree->root, struct node_ctx, rbnode);
+		ret = rb_remove_node(rbtree, &nodec->rbnode);
+		if (ret)
+			return ret;
+
+		arena_free(nodec);
+	}
+
+	return 0;
+}
+
+int insert_many(enum rbtree_alloc alloc, enum rbtree_insert_mode insert)
+{
+	const size_t numkeys = sizeof(keys) / sizeof(keys[0]);
+	node_ctx nodec;
+	u64 key, value;
+	int ret;
+	int i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(alloc, insert);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < numkeys && can_loop; i++) {
+		key = keys[i];
+		if (rbtree->alloc != RB_ALLOC) {
+			nodec = arena_malloc(sizeof(*nodec));
+			if (!nodec) {
+				arena_stderr("out of memory\n");
+				return -ENOMEM;
+			}
+			nodec->rbnode.key = key;
+			nodec->rbnode.value = 2 * key;
+			ret = rb_insert_node(rbtree, &nodec->rbnode);
+		} else {
+			ret = rb_insert(rbtree, key, 2 * key);
+		}
+		if (ret)
+			return 2 + 3 * i;
+
+		/* Read it back. */
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return 2 + 3 * i + 1;
+
+		if (value != 2 * key)
+			return 2 + 3 * i + 2;
+	}
+
+	/* Go find all inserted pairs. */
+	for (i = 0; i < numkeys && can_loop; i++) {
+		key = keys[i];
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return 302 + 2 * i;
+
+		if (value != 2 * key)
+			return 302 + 2 * i + 1;
+	}
+
+	/* RB_ALLOC trees are destroyed while still having elements. */
+	if (rbtree->alloc == RB_ALLOC)
+		return rb_destroy(rbtree);
+
+	/* Otherwise manually clean up the tree. */
+	if (clean_up_noalloc_tree(rbtree))
+		return 5;
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_remove_one(void)
+{
+	u64 key = 20, value = 5, newvalue;
+	int ret;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_DEFAULT);
+	if (!rbtree)
+		return 1;
+
+	ret = rb_find(rbtree, key, &newvalue);
+	if (!ret)
+		return 2;
+
+	ret = rb_insert(rbtree, key, value);
+	if (ret)
+		return 3;
+
+	ret = rb_find(rbtree, key, &newvalue);
+	if (ret || value != newvalue)
+		return 4;
+
+	ret = rb_remove(rbtree, key);
+	if (ret)
+		return 5;
+
+	ret = rb_find(rbtree, key, &newvalue);
+	if (!ret)
+		return 6;
+
+	return rb_destroy(rbtree);
+}
+
+static __always_inline int remove_many_verify_all_present(struct rbtree __arena *rbtree)
+{
+	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	u64 value;
+	int ret;
+	int i;
+
+	for (i = 0; i < numkeys && can_loop; i++) {
+		u64 key = morekeys[i];
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return -1;
+
+		if (value != 2 * key)
+			return -1;
+	}
+
+	return 0;
+}
+
+static __always_inline int remove_many_verify_remaining(struct rbtree __arena *rbtree)
+{
+	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	u64 value;
+	int ret;
+	int i;
+
+	for (i = 0; i < numkeys && can_loop; i += 2) {
+		u64 key = morekeys[i];
+
+		ret = rb_find(rbtree, key, &value);
+		if (!ret)
+			return -1;
+
+		if (i + 1 >= numkeys)
+			break;
+
+		key = morekeys[i + 1];
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return -1;
+
+		if (value != 2 * key)
+			return -1;
+	}
+
+	for (i = 1; i < numkeys && can_loop; i += 2) {
+		u64 key = morekeys[i];
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return -1;
+
+		if (value != 2 * key)
+			return -1;
+	}
+
+	return 0;
+}
+
+static __noinline int remove_many_alloc(struct rbtree __arena *rbtree)
+{
+	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	u64 value;
+	int ret;
+	int i;
+
+	for (i = 0; i < numkeys && can_loop; i++) {
+		u64 key = morekeys[i];
+
+		ret = rb_insert(rbtree, key, 2 * key);
+		if (ret)
+			return -1;
+
+		if (rb_integrity_check(rbtree)) {
+			arena_stderr("iteration %d\n", i);
+			return -EINVAL;
+		}
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return -1;
+
+		if (value != 2 * key)
+			return -1;
+	}
+
+	ret = remove_many_verify_all_present(rbtree);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < numkeys && can_loop; i += 2) {
+		u64 key = morekeys[i];
+
+		ret = rb_remove(rbtree, key);
+		if (ret) {
+			arena_stderr("Failed to remove %ld\n", key);
+			return -1;
+		}
+
+		ret = rb_find(rbtree, key, &value);
+		if (!ret)
+			return -1;
+	}
+
+	return remove_many_verify_remaining(rbtree);
+}
+
+static __noinline int remove_many_noalloc(struct rbtree __arena *rbtree)
+{
+	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	node_ctx first = NULL, last = NULL;
+	u64 value;
+	int ret;
+	int i;
+
+	for (i = 0; i < numkeys && can_loop; i++) {
+		u64 key = morekeys[i];
+		node_ctx nodec = arena_malloc(sizeof(*nodec));
+
+		if (!nodec) {
+			arena_stderr("out of memory\n");
+			return -ENOMEM;
+		}
+		nodec->rbnode.key = key;
+		nodec->rbnode.value = 2 * key;
+		nodec->next = NULL;
+
+		if (!first)
+			first = nodec;
+
+		if (last)
+			last->next = nodec;
+		last = nodec;
+
+		ret = rb_insert_node(rbtree, &nodec->rbnode);
+		if (ret)
+			return -1;
+
+		if (rb_integrity_check(rbtree)) {
+			arena_stderr("iteration %d\n", i);
+			return -EINVAL;
+		}
+
+		ret = rb_find(rbtree, key, &value);
+		if (ret)
+			return -1;
+
+		if (value != 2 * key)
+			return -1;
+	}
+
+	ret = remove_many_verify_all_present(rbtree);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < numkeys && can_loop; i += 2) {
+		u64 key = morekeys[i];
+		node_ctx nodec = first;
+
+		if (!nodec || key != nodec->rbnode.key)
+			return -1;
+
+		first = nodec->next ? nodec->next->next : NULL;
+		ret = rb_remove_node(rbtree, &nodec->rbnode);
+		if (ret) {
+			arena_stderr("Failed to remove %ld\n", key);
+			return -1;
+		}
+
+		ret = rb_find(rbtree, key, &value);
+		if (!ret)
+			return -1;
+	}
+
+	return remove_many_verify_remaining(rbtree);
+}
+
+static inline int remove_many(enum rbtree_alloc alloc,
+			      enum rbtree_insert_mode insert)
+{
+	int ret;
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(alloc, insert);
+	if (!rbtree)
+		return -ENOMEM;
+
+	ret = (alloc == RB_ALLOC) ? remove_many_alloc(rbtree)
+				: remove_many_noalloc(rbtree);
+	if (ret)
+		return ret;
+
+	if (alloc == RB_ALLOC)
+		return rb_destroy(rbtree);
+
+	ret = clean_up_noalloc_tree(rbtree);
+	if (ret)
+		return ret;
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_insert_many_update(void)
+{
+	return insert_many(RB_ALLOC, RB_UPDATE);
+}
+
+SEC("syscall")
+__weak int test_rbtree_insert_many_noalloc(void)
+{
+	return insert_many(RB_NOALLOC, RB_DUPLICATE);
+}
+
+SEC("syscall")
+__weak int test_rbtree_remove_many_update(void)
+{
+	return remove_many(RB_ALLOC, RB_UPDATE);
+}
+
+SEC("syscall")
+__weak int test_rbtree_remove_many_noalloc(void)
+{
+	return remove_many(RB_NOALLOC, RB_DUPLICATE);
+}
+
+SEC("syscall")
+__weak int test_rbtree_add_remove_circular(void)
+{
+	const size_t iters = 60;
+	const size_t prefill = 10;
+	const size_t numkeys = 50;
+	const size_t prefix = 400000;
+	u64 value, rmval;
+	int errval = 1;
+	u64 key;
+	int ret;
+	int i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < prefill && can_loop; i++) {
+		ret = rb_insert(rbtree, prefix + (i % numkeys), i);
+		if (ret)
+			return errval;
+
+		errval += 1;
+	}
+
+	errval = 2 * 1000 * 1000;
+
+	for (i = 0; i < prefill && can_loop; i++) {
+		/* Read it back. */
+		ret = rb_find(rbtree, prefix + (i % numkeys), &value);
+		if (ret)
+			return errval;
+
+		if (value != i)
+			return errval;
+	}
+
+	errval = 3 * 1000 * 1000;
+
+	for (i = prefill; i < iters && can_loop; i++) {
+		key = prefix + (i % numkeys);
+
+		ret = rb_find(rbtree, key, &value);
+		if (!ret) {
+			arena_stderr("Key %d already present\n", key);
+			return errval;
+		}
+
+		errval += 1;
+
+		ret = rb_insert(rbtree, key, i);
+		if (ret) {
+			arena_stderr("ITERATION %d\n", i);
+			rb_print(rbtree);
+			return errval;
+		}
+
+		rmval = i - prefill;
+
+		errval += 1;
+
+		ret = rb_find(rbtree, prefix + (rmval % numkeys), &value);
+		if (ret)
+			return errval;
+
+		errval += 1;
+
+		if (value != rmval)
+			return errval;
+
+		errval += 1;
+
+		ret = rb_remove(rbtree, prefix + (rmval % numkeys));
+		if (ret) {
+			arena_stderr("ITERATION %d\n", i);
+			return errval;
+		}
+
+		errval += 1;
+	}
+
+	for (i = 0; i < numkeys && can_loop; i++) {
+		rb_remove(rbtree, prefix + i);
+	}
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_add_remove_circular_reverse(void)
+{
+	const size_t iters = 110;
+	const size_t prefill = 10;
+	const size_t numkeys = 50;
+	const size_t prefix = 500000;
+	u64 value, rmval;
+	int errval = 1;
+	u64 key;
+	int ret;
+	int i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < prefill && can_loop; i++) {
+		ret = rb_insert(rbtree, prefix - (i % numkeys), i);
+		if (ret)
+			return errval;
+
+		errval += 1;
+	}
+
+	errval = 2 * 1000 * 1000;
+
+	for (i = 0; i < prefill && can_loop; i++) {
+		/* Read it back. */
+		ret = rb_find(rbtree, prefix - (i % numkeys), &value);
+		if (ret)
+			return errval;
+
+		if (value != i)
+			return errval;
+	}
+
+	errval = 3 * 1000 * 1000;
+
+	for (i = prefill; i < iters && can_loop; i++) {
+		key = prefix - (i % numkeys);
+
+		ret = rb_find(rbtree, key, &value);
+		if (!ret) {
+			arena_stderr("Key %d already present\n", key);
+			return errval;
+		}
+
+		errval += 1;
+
+		ret = rb_insert(rbtree, key, i);
+		if (ret) {
+			arena_stderr("error %d on insert\n", ret);
+			rb_print(rbtree);
+			return errval;
+		}
+
+		rmval = i - prefill;
+
+		errval += 1;
+
+		ret = rb_find(rbtree, prefix - (rmval % numkeys), &value);
+		if (ret)
+			return errval;
+
+		errval += 1;
+
+		if (value != rmval)
+			return errval;
+
+		errval += 1;
+
+		ret = rb_remove(rbtree, prefix - (rmval % numkeys));
+		if (ret)
+			return errval;
+
+		errval += 1;
+	}
+
+
+	errval = 4 * 1000 * 1000;
+	for (i = 0; i < prefill && can_loop; i++) {
+		ret = rb_remove(rbtree, prefix - i);
+		if (ret) {
+			arena_stderr("Did not remove %d, error %d\n", prefix - i, ret);
+			return errval + i;
+		}
+	}
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_least_pop(void)
+{
+	const size_t keys = 10;
+	u64 key, value;
+	int errval = 1;
+	int ret, i;
+
+	struct rbtree __arena *rbtree;
+
+	rbtree = rb_create(RB_ALLOC, RB_DEFAULT);
+	if (!rbtree)
+		return errval;
+
+	errval += 1;
+
+	for (i = 0; i < keys / 2 && can_loop; i++) {
+		ret = rb_insert(rbtree, i, i);
+		if (ret)
+			return errval;
+
+		errval += 1;
+
+		ret = rb_insert(rbtree, keys - 1 - i, keys - 1 - i);
+		if (ret)
+			return errval;
+
+		errval += 1;
+
+		ret = rb_least(rbtree, &key, &value);
+		if (ret)
+			return errval;
+
+		errval += 1;
+
+		if (key != 0 || value != 0)
+			return errval;
+
+		errval += 1;
+	}
+
+	errval = 1000;
+
+	for (i = 0; i < keys && can_loop; i++) {
+		ret = rb_least(rbtree, &key, &value);
+		if (ret) {
+			arena_stderr("rb_least failed with %d\n", ret);
+			return errval;
+		}
+
+		errval += 1;
+
+		if (key != i || value != i) {
+			arena_stderr("Got KV %ld/%ld expected %d\n", key, value, i);
+			return errval;
+		}
+
+		errval += 1;
+
+		ret = rb_pop(rbtree, &key, &value);
+		if (ret) {
+			arena_stderr("Error %d during pop on iter %d\n", ret, i);
+			return errval;
+		}
+
+		errval += 1;
+
+		if (key != i || value != i)
+			return errval;
+	}
+
+	return rb_destroy(rbtree);
+}
+
+/* Reject rb_pop() for RB_NOALLOC trees. */
+SEC("syscall")
+__weak int test_rbtree_noalloc_pop(void)
+{
+	const u64 expect_value = 1;
+	const u64 expect_key = 0;
+	struct rbtree __arena *rbtree;
+	struct rbnode __arena *node;
+	u64 value = 0;
+	int ret;
+
+	rbtree = rb_create(RB_NOALLOC, RB_DEFAULT);
+	if (!rbtree)
+		return 1;
+
+	node = rb_node_alloc(expect_key, expect_value);
+	if (!node) {
+		rb_destroy(rbtree);
+		return 2;
+	}
+
+	ret = rb_insert_node(rbtree, node);
+	if (ret) {
+		rb_node_free(node);
+		rb_destroy(rbtree);
+		return 3;
+	}
+
+	ret = rb_pop(rbtree, NULL, &value);
+	if (ret != -EINVAL)
+		return 4;
+
+	ret = rb_find(rbtree, expect_key, &value);
+	if (ret)
+		return 5;
+
+	if (value != expect_value)
+		return 6;
+
+	ret = rb_remove_node(rbtree, node);
+	if (ret)
+		return 7;
+
+	rb_node_free(node);
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_alloc_check(void)
+{
+	struct rbtree __arena *alloc, *noalloc;
+	struct rbnode __arena *node;
+	int ret;
+
+	alloc = rb_create(RB_ALLOC, RB_DEFAULT);
+	if (!alloc)
+		return 1;
+
+	noalloc = rb_create(RB_NOALLOC, RB_DEFAULT);
+	if (!noalloc)
+		return 2;
+
+
+	node = rb_node_alloc(0, 0);
+	if (!node)
+		return 3;
+
+	/*
+	 * RB_ALLOC trees can use rb_insert, RB_NOALLOC trees can
+	 * use rb_insert_node. RB_ALLOC and RB_NOALLOC trees cannot
+	 * use each other's APIs.
+	 *
+	 * NOTE: This begs the question, why not different types? We
+	 * want to partially share the API and that would require us
+	 * to duplicate it.
+	 */
+	if (rb_insert(alloc, 0, 0))
+		return 4;
+
+	if (!rb_insert_node(alloc, node))
+		return 5;
+
+	if (!rb_remove_node(alloc, node))
+		return 6;
+
+	if (rb_remove(alloc, 0))
+		return 7;
+
+	if (rb_insert_node(noalloc, node))
+		return 8;
+
+	if (!rb_insert(noalloc, 0, 0))
+		return 9;
+
+	if (!rb_remove(noalloc, 0))
+		return 10;
+
+	if (rb_remove_node(noalloc, node))
+		return 11;
+
+	rb_node_free(node);
+
+	ret = rb_destroy(alloc);
+	if (ret)
+		return ret;
+
+	return rb_destroy(noalloc);
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
new file mode 100644
index 000000000000..7f0f6dc3e17d
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
@@ -0,0 +1,1047 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/*
+ * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025-2026 Emil Tsalapatis <emil@etsalapatis.com>
+ */
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/rbtree.h>
+
+int rb_integrity_check(struct rbtree __arena *rbtree);
+void rbnode_print(size_t depth, struct rbnode __arena *rbn);
+static int rbnode_replace(struct rbtree __arena *rbtree,
+			  struct rbnode __arena *existing,
+			  struct rbnode __arena *replacement);
+
+struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
+				 enum rbtree_insert_mode insert)
+{
+	struct rbtree __arena *rbtree;
+
+	rbtree = arena_malloc(sizeof(*rbtree));
+	if (unlikely(!rbtree))
+		return NULL;
+
+	/*
+	 * RB_UPDATE overwrites existing values in the nodes, but RB_NOALLOC
+	 * trees manage the tree nodes directly (including holding pointers
+	 * to them). Disallow mixing the two modes to avoid dealing with
+	 * unintuitive semantics.
+	 */
+	if (alloc == RB_NOALLOC && insert == RB_UPDATE) {
+		arena_stderr("WARNING: Cannot combine RB_NOALLOC and RB_UPDATE");
+		arena_free(rbtree);
+		return NULL;
+	}
+
+	rbtree->alloc = alloc;
+	rbtree->insert = insert;
+	rbtree->root = NULL;
+
+	return rbtree;
+}
+
+__weak
+int rb_destroy(struct rbtree __arena *rbtree)
+{
+	int ret = 0;
+
+	arena_subprog_init();
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (rbtree->alloc == RB_NOALLOC) {
+		/*
+		 * We cannot do anything about RB_NOALLOC nodes. The whole
+		 * point of RB_NOALLOC is that the nodes are directly owned
+		 * by the caller that allocates and inserts them. We could
+		 * unilaterally grab all nodes and free them anyway, but that
+		 * would almost certainly cause UAF as the callers keep accessing
+		 * the now freed nodes. Throw an error instead.
+		 */
+		if (rbtree->root) {
+			arena_stderr("WARNING: Destroying RB_NOALLOC tree with > 0 nodes");
+			return -EBUSY;
+		}
+
+		goto out;
+	}
+
+	while (rbtree->root && can_loop) {
+		ret = rb_remove(rbtree, rbtree->root->key);
+		if (ret)
+			break;
+	}
+
+out:
+	arena_free(rbtree);
+	return ret;
+}
+
+static inline int rbnode_dir(struct rbnode __arena *node)
+{
+	/* Arbitrarily choose a direction for the root. */
+	if (unlikely(!node->parent))
+		return 0;
+
+	return (node->parent->left == node) ? 0 : 1;
+}
+
+/*
+ * The __noinline is to prevent inlining from bloating the add
+ * remove calls, in turn causing register splits and increasing
+ * stack usage above what is permitted.
+ */
+__noinline
+int rbnode_rotate(struct rbtree __arena *rbtree,
+		  struct rbnode __arena *node, int dir)
+{
+	struct rbnode __arena *tmp, *parent;
+	int parentdir;
+
+	parent = node->parent;
+	if (parent)
+		parentdir = rbnode_dir(node);
+
+	/* If we're doing a root change, are we the root? */
+	if (unlikely(!parent && rbtree->root != node))
+		return -EINVAL;
+
+	/*
+	 * Does the node we're turning into the root into exist?
+	 * Note that the new root is on the opposite side of the
+	 * rotation's direction.
+	 */
+	tmp = node->child[1 - dir];
+	if (unlikely(!tmp))
+		return -EINVAL;
+
+	/* Steal the closest child of the new root. */
+	node->child[1 - dir] = tmp->child[dir];
+	if (node->child[1 - dir])
+		node->child[1 - dir]->parent = node;
+
+	/* Put the node below the new root.*/
+	tmp->child[dir] = node;
+	node->parent = tmp;
+
+	tmp->parent = parent;
+	if (parent)
+		parent->child[parentdir] = tmp;
+	else
+		rbtree->root = tmp;
+
+	return 0;
+}
+
+static
+struct rbnode __arena *rbnode_find(struct rbnode __arena *subtree, u64 key)
+{
+	struct rbnode __arena *node = subtree;
+	int dir;
+
+	if (!subtree)
+		return NULL;
+
+	while (can_loop) {
+		if (node->key == key)
+			break;
+
+		dir = (key < node->key) ? 0 : 1;
+
+		if (!node->child[dir])
+			break;
+
+		node = node->child[dir];
+	}
+
+	return node;
+}
+
+static
+struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree, uint64_t key)
+{
+	struct rbnode __arena *node = subtree;
+	int dir;
+
+	if (!subtree)
+		return NULL;
+
+	while (can_loop) {
+		dir = (key <= node->key) ? 0 : 1;
+
+		if (!node->child[dir])
+			break;
+
+		node = node->child[dir];
+	}
+
+	return node;
+}
+
+__weak
+int rb_find(struct rbtree __arena *rbtree, u64 key, u64 *value)
+{
+	struct rbnode __arena *node;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (unlikely(!value))
+		return -EINVAL;
+
+	node = rbnode_find(rbtree->root, key);
+	if (!node || node->key != key)
+		return -ENOENT;
+
+	*value = node->value;
+
+	return 0;
+}
+
+__weak
+struct rbnode __arena *rb_node_alloc(u64 key, u64 value)
+{
+	struct rbnode __arena *rbnode = NULL;
+
+	rbnode = (struct rbnode __arena *)arena_malloc(sizeof(*rbnode));
+	if (!rbnode)
+		return NULL;
+
+	/*
+	 * WARNING: The order of assignments is weird on purpose.
+	 * See comment in rb_insert_node() for more context.
+	 * TL;DR: Prevent consecutive 0 assignments from being
+	 * promoted into an unverifiable memset by the compiler.
+	 */
+
+	rbnode->key = key;
+	rbnode->parent = NULL;
+	rbnode->value = value;
+	rbnode->left = NULL;
+	rbnode->is_red = true;
+	rbnode->right = NULL;
+
+	return rbnode;
+}
+
+__weak
+void rb_node_free(struct rbnode __arena *rbnode)
+{
+	arena_free(rbnode);
+}
+
+static
+int rb_node_insert(struct rbtree __arena *rbtree,
+		   struct rbnode __arena *node)
+{
+	struct rbnode __arena *grandparent, *parent = rbtree->root;
+	u64 key = node->key;
+	struct rbnode __arena *uncle;
+	int dir;
+	int ret;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (!parent) {
+		rbtree->root = node;
+		return 0;
+	}
+
+	if (rbtree->insert != RB_DUPLICATE)
+		parent = rbnode_find(parent, key);
+	else
+		parent = rbnode_least_upper_bound(parent, key);
+
+	if (key == parent->key && rbtree->insert != RB_DUPLICATE) {
+		if (rbtree->insert == RB_UPDATE) {
+			/*
+			 * Replace the old node with the new one.
+			 * Free up the old node.
+			 */
+			ret = rbnode_replace(rbtree, parent, node);
+			if (ret)
+				return ret;
+
+			if (rbtree->alloc == RB_ALLOC)
+				rb_node_free(parent);
+
+			return 0;
+		}
+
+		/* Otherwise it's RB_DEFAULT. */
+		return -EALREADY;
+	}
+
+	node->parent = parent;
+	/* Also works if key == parent->key. */
+	if (key <= parent->key)
+		parent->left = node;
+	else
+		parent->right = node;
+
+	while (can_loop) {
+		parent = node->parent;
+		if (!parent)
+			return 0;
+
+		if (!parent->is_red)
+			return 0;
+
+		grandparent = parent->parent;
+		if (!grandparent) {
+			parent->is_red = false;
+			return 0;
+		}
+
+		dir = rbnode_dir(parent);
+		uncle = grandparent->child[1 - dir];
+
+		if (!uncle || !uncle->is_red) {
+			if (node == parent->child[1 - dir]) {
+				rbnode_rotate(rbtree, parent, dir);
+				node = parent;
+				parent = grandparent->child[dir];
+			}
+
+			rbnode_rotate(rbtree, grandparent, 1 - dir);
+			parent->is_red = false;
+			grandparent->is_red = true;
+
+			return 0;
+		}
+
+		/* Uncle is red. */
+
+		parent->is_red = false;
+		uncle->is_red = false;
+		grandparent->is_red = true;
+
+		node = grandparent;
+	}
+
+	return 0;
+}
+
+int rb_insert_node(struct rbtree __arena *rbtree,
+		   struct rbnode __arena *node)
+{
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (unlikely(rbtree->alloc == RB_ALLOC))
+		return -EINVAL;
+
+	node->left = NULL;
+
+	/*
+	 * Workaround to break an optimization that causes
+	 * verification failures on some compilers. Assignments
+	 * of the kind
+	 *
+	 * *(r0 + 0) = 0;
+	 * *(r0 + 8) = 0;
+	 * *(r0 + 16) = 0;
+	 *
+	 * get promoted into a memset, and that in turn is not
+	 * handled properly for arena memory by LLVM 21 and GCC 15.
+	 * Add a barrier for now to prevent the assignments from being fused.
+	 */
+	barrier();
+
+	node->parent = NULL;
+	node->right = NULL;
+	
+	node->is_red = true;
+
+	return rb_node_insert(rbtree, node);
+}
+
+__weak
+int rb_insert(struct rbtree __arena *rbtree, u64 key, u64 value)
+{
+	struct rbnode __arena *node;
+	int ret;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (unlikely(rbtree->alloc != RB_ALLOC))
+		return -EINVAL;
+
+	node = rb_node_alloc(key, value);
+	if (!node)
+		return -ENOMEM;
+
+	ret = rb_node_insert(rbtree, node);
+	if (ret) {
+		rb_node_free(node);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline struct rbnode __arena *rbnode_least(struct rbnode __arena *subtree)
+{
+	while (subtree->left && can_loop)
+		subtree = subtree->left;
+
+	return subtree;
+}
+
+__weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
+{
+	struct rbnode __arena *least;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (!rbtree->root)
+		return -ENOENT;
+
+	least = rbnode_least(rbtree->root);
+	if (key)
+		*key = least->key;
+	if (value)
+		*value = least->value;
+
+	return 0;
+}
+
+
+/*
+ * If we are referencing ourselves, a and b have a parent-child relation,
+ * and we should be pointing at the other node instead.
+ */
+static inline void rbnode_fixup_pointers(struct rbnode __arena *a,
+					 struct rbnode __arena *b)
+{
+#define fixup(n1, n2, member) do { if (n1->member == n1) n1->member = n2; } while (0)
+	fixup(a, b, left);
+	fixup(a, b, right);
+	fixup(a, b, parent);
+#undef fixup
+}
+
+static inline void rbnode_swap_values(struct rbnode __arena *a,
+				      struct rbnode __arena *b)
+{
+#define swap(n1, n2, tmp) do { (tmp) = (n1); (n1) = (n2); (n2) = (tmp); } while (0)
+	struct rbnode __arena *tmpnode;
+	u64 tmp;
+
+	/* Swap the pointers. */
+	swap(a->is_red, b->is_red, tmp);
+
+	swap(a->left, b->left, tmpnode);
+	swap(a->right, b->right, tmpnode);
+	swap(a->parent, b->parent, tmpnode);
+#undef swap
+
+	/* Account for the nodes being parent and child. */
+	rbnode_fixup_pointers(b, a);
+	rbnode_fixup_pointers(a, b);
+}
+
+static inline void rbnode_adjust_neighbors(struct rbtree __arena *rbtree,
+					   struct rbnode __arena *node, int dir)
+{
+	if (node->left)
+		node->left->parent = node;
+	if (node->right)
+		node->right->parent = node;
+
+	if (node->parent) {
+		node->parent->child[dir] = node;
+		return;
+	}
+
+	rbtree->root = node;
+}
+
+/*
+ * Directly replace an existing node with a replacement. The replacement node
+ * should not already be in the tree.
+ */
+static int rbnode_replace(struct rbtree __arena *rbtree,
+			  struct rbnode __arena *existing,
+			  struct rbnode __arena *replacement)
+{
+	int dir = 0;
+
+	if (unlikely(replacement->parent || replacement->left || replacement->right))
+		return -EINVAL;
+
+	if (existing->parent)
+		dir = rbnode_dir(existing);
+
+	replacement->is_red = existing->is_red;
+	replacement->left = existing->left;
+	replacement->right = existing->right;
+	replacement->parent = existing->parent;
+
+	/* Fix up the new node's neighbors. */
+	rbnode_adjust_neighbors(rbtree, replacement, dir);
+
+	return 0;
+}
+
+/*
+ * Switch two nodes in the tree in place. This is useful during node deletion.
+ * This is more involved than switching the values of the two nodes because we
+ * must update all tree pointers.
+ */
+static void rbnode_switch(struct rbtree __arena *rbtree,
+			  struct rbnode __arena *a,
+			  struct rbnode __arena *b)
+{
+	int adir = 0, bdir = 0;
+
+	/*
+	 * Store the direction in the parent because we will not
+	 * be able to recompute it once we start swapping values.
+	 */
+	if (a->parent)
+		adir = rbnode_dir(a);
+
+	if (b->parent)
+		bdir = rbnode_dir(b);
+
+	rbnode_swap_values(a, b);
+
+	/*
+	 * Fix up the pointers from the children/parent to the
+	 * new nodes.
+	 */
+	rbnode_adjust_neighbors(rbtree, a, bdir);
+	rbnode_adjust_neighbors(rbtree, b, adir);
+}
+
+static inline int rbnode_remove_node_single_child(struct rbtree __arena *rbtree,
+						  struct rbnode __arena *node,
+						  bool free)
+{
+	struct rbnode __arena *child;
+	int dir;
+
+	if (unlikely(node->is_red)) {
+		arena_stderr("Node unexpectedly red\n");
+		return -EINVAL;
+	}
+
+	child = node->left ? node->left : node->right;
+	if (unlikely(!child->is_red)) {
+		arena_stderr("Only child is black\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Since it's the immediate child, we can just
+	 * remove the parent.
+	 */
+	child->parent = node->parent;
+
+	if (node->parent) {
+		dir = rbnode_dir(node);
+		node->parent->child[dir] = child;
+	} else {
+		rbtree->root = child;
+	}
+
+	/* Color the child black. */
+	child->is_red = false;
+
+	/* Only free if called from rb_remove. */
+	if (free)
+		rb_node_free(node);
+
+	return 0;
+}
+
+static inline bool rbnode_has_red_children(struct rbnode __arena *node)
+{
+	if (node->left && node->left->is_red)
+		return true;
+
+	return node->right && node->right->is_red;
+}
+
+static
+int rb_node_remove(struct rbtree __arena *rbtree,
+		   struct rbnode __arena *node)
+{
+	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephew;
+	bool free = (rbtree->alloc == RB_ALLOC);
+	struct rbnode __arena *replace, *initial;
+	bool is_red;
+	int dir;
+
+	/* Both children present, replace with next largest key. */
+	if (node->left && node->right) {
+		/*
+		 * Swap the node itself instead of just the
+		 * key/value pair to account for nodes embedded
+		 * in other structs.
+		 */
+
+		replace = rbnode_least(node->right);
+		rbnode_switch(rbtree, replace, node);
+
+		/*
+		 * FALLTHROUGH: We moved the node we are removing to
+		 * the leftmost position of the subtree. We can now
+		 * remove it as if it was always where we moved it to.
+		 */
+	}
+
+	initial = node;
+
+	/* Only one child present, replace with child and paint it black. */
+	if (!node->left != !node->right)
+		return rbnode_remove_node_single_child(rbtree, node, free);
+
+	/* (!node->left && !node->right) */
+
+	parent = node->parent;
+	if (!parent) {
+		/* Check that we're _actually_ the root. */
+		if (rbtree->root == node)
+			rbtree->root = NULL;
+		else
+			arena_stderr("WARNING: Attempting to remove detached node from rbtree\n");
+
+		if (free)
+			rb_node_free(node);
+		return 0;
+	}
+
+	dir = rbnode_dir(node);
+	parent->child[dir] = NULL;
+	is_red = node->is_red;
+
+	if (free)
+		rb_node_free(node);
+
+	/* If we removed a red node, we did not unbalance the tree.*/
+	if (is_red)
+		return 0;
+
+	sibling = parent->child[1 - dir];
+	if (unlikely(!sibling)) {
+		arena_stderr("rbtree: removed black node has no sibling\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * We removed a black node, causing a change in path
+	 * weight. Start rebalancing. The invariant is that
+	 * all paths going through the node are shortened
+	 * by one, and the current node is black.
+	 */
+	while (can_loop) {
+
+		/* Balancing reached the root, there can be no imbalance. */
+		if (!parent)
+			return 0;
+
+		/*
+		 * We already determined the dir, either above or
+		 * at the end of the loop.
+		 */
+
+		/*
+		 * If we have no sibling, the tree was
+		 * already unbalanced.
+		 */
+		sibling = parent->child[1 - dir];
+		if (unlikely(!sibling)) {
+			arena_stderr("rbtree: removed black node has no sibling\n");
+			return -EINVAL;
+		}
+
+		/* Sibling is red, turn it into the grandparent. */
+		if (sibling->is_red) {
+			/*
+			 * Sibling is red. Transform the tree to turn
+			 * the sibling into the parent's position, and
+			 * repaint them. This does not balance the tree
+			 * but makes it so we know the sibling is black
+			 * and so can use the transformations to balance.
+			 */
+			rbnode_rotate(rbtree, parent, dir);
+			parent->is_red = true;
+			sibling->is_red = false;
+
+			/* Our new sibling is now the close nephew. */
+			sibling = parent->child[1 - dir];
+			/* If sibling has any red siblings, break out. */
+			if (rbnode_has_red_children(sibling))
+				break;
+
+			/* We can repaint the sibling and parent, we're done. */
+			sibling->is_red = true;
+			parent->is_red = false;
+
+			return 0;
+		}
+
+		/* Sibling guaranteed to be black. If it has red children, break out. */
+		if (rbnode_has_red_children(sibling))
+			break;
+
+		/*
+		 * Both sibling and children are black. If parent is red, swap
+		 * colors with the sibling. Otherwise
+		 */
+		if (parent->is_red) {
+			parent->is_red = false;
+			sibling->is_red = true;
+			return 0;
+		}
+
+		/*
+		 * Parent, sibling, and all its children are black. Repaint the sibling.
+		 * This shortens the paths through it, so pop up a level in the
+		 * tree and repeat the balancing.
+		 */
+		sibling->is_red = true;
+		node = parent;
+		parent = node->parent;
+		dir = rbnode_dir(node);
+	}
+
+	if (node != initial) {
+		dir = rbnode_dir(node);
+		parent = node->parent;
+		sibling = parent->child[1-dir];
+	}
+	/*
+	 * Almost there. We know between the parent, sibling,
+	 * and nephews only one or two of the nephews are red. If
+	 * it is the close one, rotate it to the sibling position,
+	 * paint it black, and paint the previous sibling red.
+	 */
+
+	close_nephew = sibling->child[dir];
+	distant_nephew = sibling->child[1 - dir];
+
+	/*
+	 * If the distant red nephew is not red, rotate
+	 * and repaint. We need the distant nephew
+	 * to be red. We know the close nephew is red
+	 * because at least one of them are, so the
+	 * distant one is black if it exists.
+	 */
+	if (!distant_nephew || !distant_nephew->is_red) {
+		rbnode_rotate(rbtree, sibling, 1 - dir);
+		sibling->is_red = true;
+		close_nephew->is_red = false;
+		distant_nephew = sibling;
+		sibling = close_nephew;
+	}
+
+	/*
+	 * We now know it's the distant nephew that's red.
+	 * Rotate the sibling into our parent's position
+	 * and paint both black.
+	 */
+
+	rbnode_rotate(rbtree, parent, dir);
+	sibling->is_red = parent->is_red;
+	parent->is_red = false;
+	distant_nephew->is_red = false;
+
+	return 0;
+}
+
+__weak
+int rb_remove_node(struct rbtree __arena *rbtree,
+		   struct rbnode __arena *node)
+{
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (unlikely(rbtree->alloc == RB_ALLOC))
+		return -EINVAL;
+
+	return rb_node_remove(rbtree, node);
+}
+
+__weak
+int rb_remove(struct rbtree __arena *rbtree, u64 key)
+{
+	struct rbnode __arena *node;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (unlikely(rbtree->alloc != RB_ALLOC))
+		return -EINVAL;
+
+	if (!rbtree->root)
+		return -ENOENT;
+
+	node = rbnode_find(rbtree->root, key);
+	if (!node || node->key != key)
+		return -ENOENT;
+
+	return rb_node_remove(rbtree, node);
+}
+
+__weak
+int rb_pop(struct rbtree __arena *rbtree, u64 *key, u64 *value)
+{
+	struct rbnode __arena *node;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (!rbtree->root)
+		return -ENOENT;
+
+	if (rbtree->alloc != RB_ALLOC)
+		return -EINVAL;
+
+	node = rbnode_least(rbtree->root);
+	if (unlikely(!node))
+		return -ENOENT;
+
+	if (key)
+		*key = node->key;
+	if (value)
+		*value = node->value;
+
+	return rb_node_remove(rbtree, node);
+}
+
+inline void rbnode_print(size_t depth, struct rbnode __arena *rbn)
+{
+	arena_stderr("[DEPTH %d] %p (%s)\n PARENT %p", depth, rbn, rbn->is_red ? "red" : "black", rbn->parent);
+	arena_stderr("\tKV (%ld, %ld)\n LEFT %p RIGHT %p]\n", rbn->key, rbn->value, rbn->left, rbn->right);
+}
+
+enum rb_print_state {
+	RB_NONE_VISITED,
+	RB_LEFT_VISITED,
+	RB_RIGHT_VISITED,
+};
+
+__weak
+enum rb_print_state rb_print_next_state(struct rbnode __arena *rbnode,
+					enum rb_print_state state, u64 *next)
+{
+	if (unlikely(!next))
+		return RB_NONE_VISITED;
+
+	switch (state) {
+	case RB_NONE_VISITED:
+		if (rbnode->left) {
+			*next = (u64)rbnode->left;
+			state = RB_LEFT_VISITED;
+			break;
+		}
+
+		/* FALLTHROUGH */
+
+	case RB_LEFT_VISITED:
+		if (rbnode->right) {
+			*next = (u64)rbnode->right;
+			state = RB_RIGHT_VISITED;
+			break;
+		}
+
+		/* FALLTHROUGH */
+
+	default:
+		*next = 0;
+		state = RB_RIGHT_VISITED;
+	}
+
+	return state;
+}
+
+__weak
+int rb_print_pop_up(struct rbnode __arena **rbnodep, u8 *depthp, enum rb_print_state (*stack)[RB_MAXLVL_PRINT], enum rb_print_state *state)
+{
+	struct rbnode __arena *rbnode;
+	volatile u8 depth;
+	int j;
+
+	if (unlikely(!rbnodep || !depthp || !stack || !state))
+		return -EINVAL;
+
+	rbnode = *rbnodep;
+	depth = *depthp;
+
+	for (j = 0; j < RB_MAXLVL_PRINT && can_loop; j++) {
+		if (*state != RB_RIGHT_VISITED)
+			break;
+
+		depth -= 1;
+		if (depth < 0 || depth >= RB_MAXLVL_PRINT)
+			break;
+
+		*state = (*stack)[depth % RB_MAXLVL_PRINT];
+		rbnode = rbnode->parent;
+	}
+
+	*rbnodep = rbnode;
+	*depthp = depth;
+
+	return 0;
+}
+
+__weak
+int rb_print(struct rbtree __arena *rbtree)
+{
+	enum rb_print_state stack[RB_MAXLVL_PRINT];
+	struct rbnode __arena *rbnode = rbtree->root;
+	enum rb_print_state state;
+	struct rbnode __arena *next;
+	u64 next_addr;
+	u8 depth;
+	int ret;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	depth = 0;
+	state = RB_NONE_VISITED;
+
+	arena_stderr("=== RB TREE START ===\n");
+
+	if (!rbtree->root)
+		goto out;
+
+	/* Even with can_loop, the verifier doesn't like infinite loops. */
+	while (can_loop) {
+		if (state == RB_NONE_VISITED)
+			rbnode_print(depth, rbnode);
+
+		/* Find which child to traverse next. */
+		state = rb_print_next_state(rbnode, state, &next_addr);
+		next = (struct rbnode __arena *)next_addr;
+
+		/* Child found. Store the node state and go on. */
+		if (next) {
+			if (depth < 0 || depth >= RB_MAXLVL_PRINT)
+				return 0;
+
+			stack[depth++] = state;
+
+			rbnode = next;
+			state = RB_NONE_VISITED;
+
+			continue;
+		}
+
+		/* Otherwise, go as far up as possible. */
+		ret = rb_print_pop_up(&rbnode, &depth, &stack, &state);
+		if (ret)
+			return -EINVAL;
+
+		if (depth < 0 || depth >= RB_MAXLVL_PRINT) {
+			arena_stderr("=== RB TREE END (depth %d\n)===", depth);
+			return 0;
+		}
+
+	}
+
+out:
+	arena_stderr("=== RB TREE END ===\n");
+
+	return 0;
+}
+
+__weak
+int rb_integrity_check(struct rbtree __arena *rbtree)
+{
+	enum rb_print_state stack[RB_MAXLVL_PRINT];
+	struct rbnode __arena *rbnode = rbtree->root;
+	enum rb_print_state state;
+	struct rbnode __arena *next;
+	u64 next_addr;
+	u8 depth;
+	int ret;
+
+	if (unlikely(!rbtree))
+		return -EINVAL;
+
+	if (!rbtree->root)
+		return 0;
+
+	depth = 0;
+	state = RB_NONE_VISITED;
+
+	/* Even with can_loop, the verifier doesn't like infinite loops. */
+	while (can_loop) {
+		if (rbnode->parent && rbnode->parent->left != rbnode
+			&& rbnode->parent->right != rbnode) {
+			arena_stderr("WARNING: Inconsistent tree. Parent %p has no child %p\n", rbnode->parent, rbnode);
+			return -EINVAL;
+		}
+
+		if (rbnode->parent == rbnode) {
+			arena_stderr("WARNING: Inconsistent tree, node %p is its own parent\n", rbnode);
+			return -EINVAL;
+		}
+
+		if (rbnode->left == rbnode) {
+			arena_stderr("WARNING: Inconsistent tree, node %p is its own left child\n", rbnode);
+			return -EINVAL;
+		}
+
+		if (rbnode->right == rbnode) {
+			arena_stderr("WARNING: Inconsistent tree, node %p is its own right child\n", rbnode);
+			return -EINVAL;
+		}
+
+		if (rbnode->is_red) {
+			if (rbnode->left && rbnode->left->is_red) {
+				arena_stderr("WARNING: Inconsistent tree. Parent has %p has red child %p\n", rbnode, rbnode->left);
+				return -EINVAL;
+			}
+			if (rbnode->right && rbnode->right->is_red) {
+				arena_stderr("WARNING: Inconsistent tree. Parent has %p has red child %p\n", rbnode, rbnode->right);
+				return -EINVAL;
+			}
+		} else if (rbnode->parent && rbnode->parent->child[1 - rbnode_dir(rbnode)] == NULL) {
+			arena_stderr("WARNING: Inconsistent tree. Black node %p has no sibling\n", rbnode);
+			return -EINVAL;
+		}
+
+		/* Find which child to traverse next. */
+		state = rb_print_next_state(rbnode, state, &next_addr);
+		next = (struct rbnode __arena *)next_addr;
+
+		/* Child found. Store the node state and go on. */
+		if (next) {
+			if (depth < 0 || depth >= RB_MAXLVL_PRINT)
+				return 0;
+
+			stack[depth++] = state;
+
+			rbnode = next;
+			state = RB_NONE_VISITED;
+
+			continue;
+		}
+
+		/* Otherwise, go as far up as possible. */
+		ret = rb_print_pop_up(&rbnode, &depth, &stack, &state);
+		if (ret)
+			return -EINVAL;
+
+		if (depth < 0 || depth >= RB_MAXLVL_PRINT) {
+			return 0;
+		}
+
+	}
+
+	return 0;
+}
-- 
2.54.0

