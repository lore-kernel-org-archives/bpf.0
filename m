Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E631EA6F
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621049; cv=none; b=cNK/N97TNzasP3sulbvFflJjBJBbTttyFz+PoE0kfb6LNt9o3XUjX7nej5HLtgw8kmcwageAtzjAYzvPzLbOns0KwUc0lYTJhCcFPYHLB1m9K+thpjliPNt6np0tt1CRwBHQzXGLnWLFSTwEqcr2edf+jKwGAC0xaVv2pz8bAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621049; c=relaxed/simple;
	bh=mf8yMKZPIxIbiyH0ekDAI1hMR9qnE76DYdITOuowuq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/geFf3k9f6oexkY6jfmgQjIPGMXKJAoKmJloPJcw01t0WaoapE3xONzwYjX6SgKRevordK8LRkKCbUhmkTY86hImpqCTKOJqm1K1rwQphuGFKmrDCS5nwddo2VR1or08f7KWtHRtXdwCbf9Rur/AlUWU86TkaegpRoHQSVvxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrxa2ti9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrxa2ti9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea5b42e7so1325109b6e.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 22:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709621046; x=1710225846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9oDnqtMY2zxNPWuO0M89IcTSHoNEb5Q5xdDMziT6o4=;
        b=Hrxa2ti9euHiPU62+RhtdaeDV/holSlTkLC0BSfWk7Tq92nfGO8WbTPQx55CJmN3Ei
         99dNa2xf8VilnK1Pr/up42ykWuWYG4LyCWYIikdxV4BfDcKsk5sd2W3oHl46CEtpvlxE
         hisc9PAfHjWBYR3ITNKzdRmFPI/pdQqkAmpT6kYr0rCJ8AY0ux8AjWSb8qfaBFY86+6m
         kH3SqhzCP9jsPRc1machMOOOq2eCi2DeDQB5GmJXMkyDNGG4QKxoXX/+4NzCFXjD2N8+
         U5009EfWxobgi5uiX3wfjoYpTpECzKt/CMPO6Xl+3kNU1AI1yiLRm0Y0eMmBGESaAnxI
         09JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709621046; x=1710225846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9oDnqtMY2zxNPWuO0M89IcTSHoNEb5Q5xdDMziT6o4=;
        b=YTTRZxF9TVra0h6jVK7+vsi0s9+CozCSja7WNTKjKW3koFPfxcXaJSlrAau7OwY79+
         ffswQ4MGHTGiie4swnvmw2t5YJhttvyCk8Q+B1h2eUaXYB+IwiY0+UGsc6//IC0mI6C7
         ZuXRiOUefS5YVTgOiKZ/bPQ4U7iL3T6AkyaV7n9NO+x92AjDQ9pbrjmjmvQ9ElHUnJqZ
         lrq4ESr5zrMlX5Qfy023p6BVuDj7VjN3QlxJqbtaRaMU9aQg/IA1B8V+bL8uKKaFQ2/Z
         UVN5O9ubFry/dkZtM89x5tx+XOiZlIwgEvJZ78tVwusZTjG6PaPB1zli5AciwTquJMYN
         K2mA==
X-Gm-Message-State: AOJu0YyR6ARD30ZmUX/LZQVufuJZQYdylnJydfOY2FsT7e+Bg4os8yLr
	T7GHg/JFtb+pzgPnB7t1jkPmeJWO6cuTFhC6pHjVffD7+TA+qOME
X-Google-Smtp-Source: AGHT+IGx6+1/o1ZJJwOxzweC3Ne6bhGqFWJ8xrIy1y68u3/v4yNIJFii9awfkJ1M4ZnjoSu1z18A/w==
X-Received: by 2002:aca:2214:0:b0:3c1:7d8d:29b9 with SMTP id b20-20020aca2214000000b003c17d8d29b9mr1017553oic.21.1709621045654;
        Mon, 04 Mar 2024 22:44:05 -0800 (PST)
Received: from localhost.localdomain ([39.144.105.163])
        by smtp.gmail.com with ESMTPSA id j36-20020a63fc24000000b0059b2316be86sm8345831pgi.46.2024.03.04.22.44.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:44:05 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 1/2] bpf: Add bits iterator
Date: Tue,  5 Mar 2024 14:43:52 +0800
Message-Id: <20240305064353.69734-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three new kfuncs for the bits iterator:
- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits that can be iterated
  over is limited to (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator facilitates the iteration of the bits of a memory area,
such as cpumask. It can be used in any context and on any address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..a769561b65ae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2545,6 +2545,120 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+struct bpf_iter_bits {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_bits_kern {
+	union {
+		unsigned long *bits;
+		unsigned long bits_copy;
+	};
+	u32 nr_bits;
+	int bit;
+} __aligned(8);
+
+/**
+ * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
+ * @it: The new bpf_iter_bits to be created
+ * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated over
+ * @nr_bits: The number of bits to be iterated over. Due to the limitation of
+ * memalloc, it can't greater than (4096 * 8).
+ *
+ * This function initializes a new bpf_iter_bits structure for iterating over
+ * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits. It
+ * copy the data of the memory area to the newly created bpf_iter_bits @it for
+ * subsequent iteration operations.
+ *
+ * On success, 0 is returned. On failure, ERR is returned.
+ */
+__bpf_kfunc int
+bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign, u32 nr_bits)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+	u32 size = BITS_TO_BYTES(nr_bits);
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
+		     __alignof__(struct bpf_iter_bits));
+
+	if (!unsafe_ptr__ign || !nr_bits) {
+		kit->bits = NULL;
+		return -EINVAL;
+	}
+
+	kit->nr_bits = 0;
+	/* Optimization for u64/u32 mask */
+	if (nr_bits <= 64) {
+		err = bpf_probe_read_kernel_common(&kit->bits_copy, size, unsafe_ptr__ign);
+		if (unlikely(err))
+			return -EFAULT;
+
+		kit->nr_bits = nr_bits;
+		kit->bit = -1;
+		return 0;
+	}
+
+	/* Fallback to memalloc */
+	kit->bits = bpf_mem_alloc(&bpf_global_ma, size);
+	if (!kit->bits)
+		return -ENOMEM;
+
+	err = bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr__ign);
+	if (err) {
+		bpf_mem_free(&bpf_global_ma, kit->bits);
+		return err;
+	}
+
+	kit->nr_bits = nr_bits;
+	kit->bit = -1;
+	return 0;
+}
+
+/**
+ * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
+ * @it: The bpf_iter_bits to be checked
+ *
+ * This function returns a pointer to a number representing the value of the
+ * next bit in the bits.
+ *
+ * If there are no further bit available, it returns NULL.
+ */
+__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+	u32 nr_bits = kit->nr_bits;
+	const unsigned long *bits;
+	int bit;
+
+	if (nr_bits == 0)
+		return NULL;
+
+	bits = nr_bits <= 64 ? &kit->bits_copy : kit->bits;
+	bit = find_next_bit(bits, kit->nr_bits, kit->bit + 1);
+	if (bit >= kit->nr_bits)
+		return NULL;
+
+	kit->bit = bit;
+	return &kit->bit;
+}
+
+/**
+ * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
+ * @it: The bpf_iter_bits to be destroyed
+ *
+ * Destroy the resource associated with the bpf_iter_bits.
+ */
+__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
+{
+	struct bpf_iter_bits_kern *kit = (void *)it;
+
+	if (kit->nr_bits <= 64)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->bits);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2621,6 +2735,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.39.1

