Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACC45954
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540800; cv=none; b=PW9KBWGoqNpeGLlz+wbcyr77kCufrJL8w0spByQmniDZvBOx6sS+cgpeBsTzKTJ/F7jflNvD2ocPX0j3j+EZe66tKOutlcBCxX0xPmF+gbXrYQoTcoDwhzM+UtbLrDETcEuj5w2nZSJ3/FA6g+3y76RAH42/AQOfVbVIL5CAUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540800; c=relaxed/simple;
	bh=rjpdOrI7ow/nyOF4R2tJbHxSuseJLcU2SNV7gu1YB6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjQiqmJh2Eo8XmaVBnAMYGOIXHYec6ecNKIF1G+mRupg4KzFv9tRJ2xmkUrFeoUy3HhMXCf4nluhNKt1f6I75fnLAiSc0vvKOa3tEVe7UdHsypryXx7rNeka+hi3v+P+2aW4lCtgzV/1ljjMRofvJmtKOO163q7vx6Wj07R5yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhQdMNH/; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhQdMNH/"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22222357d76so2623089fac.2
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540798; x=1712145598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQShJgdiW/LpbqHpCbz1DV8sOZfoV/VXwPExK08qU9M=;
        b=fhQdMNH/QuNpNMUJjLaSk5T7Qq4dF0RcTOhYmv17jrgUZLOALjjbU4Wl/O8qFZBR8I
         AZGYkYNN00HwyxBRqzFGeXXRb7QfTvsNL2TaHnA9rqFmu1yjd1ESN1WJT+78nIRvwnFQ
         gRl/1y2yTvpJU3soBWPdVuyF6tp76t4+h9Hf16IoqEYWS5BEMBgfw2GL2N8swD3/CUZq
         lSYP0TkFyq38AsuGO8ch0FYQjfez00Ya0sOuc+N4o8PpaKS/CMA2HO+K8HnqV0TY7jFB
         sHLwn0Z75SP1184greNeczsLgv23XA6y3pmrLUyp7rianLePCKKMC80x4bz044J9kqcd
         hFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540798; x=1712145598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQShJgdiW/LpbqHpCbz1DV8sOZfoV/VXwPExK08qU9M=;
        b=VPfgUnWuJmvuOiMmTORodMR7Na2G0Dv6yWPtwr3Zg0iD4ZiGW70YrzMp8DfutkLKo8
         FyR4xiqh6Lhy3avL3LbSLd1k/0w9Ukwok+5LVCiKOQlX5+sBkAu1hN9eDHyacfpLm+5H
         slZoSF57O5e9uKqkAGDV4LPSG2uv7tyeiru012qDMSRljBXTaYfY/3B/GNX9IIlnawWF
         8grlz7GT5HTT5nkdvwZkCRwZOyusx2+gS/Yj0xOzXfSFJfFRZ9LhpPWLzMi8rGjCKfa2
         oriWG+IWFh94WWIyqUh4iG5+D51P7rCocSehq9MOTHFvAJsmHU3UE4MwQTj3dbPY5OJE
         MxQA==
X-Gm-Message-State: AOJu0YzTh7H7ER5uYPESAKwgNGdjf0YhpY8A7wB98nOBU7NdcNER3TrI
	4iuPSksvxcHjRPGdGRmPn8GJEku2HdhTVnxBiDS+SfYEfHneOrU0Ux2pgt7QcKVw7Q==
X-Google-Smtp-Source: AGHT+IFmnLv3byYn5yXK39PbWazCHxfCgs63/BmCHiTVTDrJKZ2xRSnj9ekwdAiICrq22yS1p41jSQ==
X-Received: by 2002:a05:6870:2317:b0:229:ec87:cc29 with SMTP id w23-20020a056870231700b00229ec87cc29mr2446719oao.49.1711540797722;
        Wed, 27 Mar 2024 04:59:57 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.203])
        by smtp.gmail.com with ESMTPSA id fa26-20020a056a002d1a00b006ea7b343877sm7675695pfb.9.2024.03.27.04.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:59:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Add bits iterator
Date: Wed, 27 Mar 2024 19:58:47 +0800
Message-Id: <20240327115848.84695-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240327115848.84695-1-laoar.shao@gmail.com>
References: <20240327115848.84695-1-laoar.shao@gmail.com>
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
 kernel/bpf/helpers.c | 120 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9234174ccb21..35bd8dd08fb8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2549,6 +2549,123 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
+	u32 size = BITS_TO_LONGS(nr_bits) * sizeof(unsigned long);
+	struct bpf_iter_bits_kern *kit = (void *)it;
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
+	kit->bits_copy = 0;
+	/* Optimization for u64/u32 mask */
+	if (nr_bits <= 64) {
+		err = bpf_probe_read_kernel_common(&kit->bits_copy, size, unsafe_ptr__ign);
+		if (err)
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
+	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
+	if (bit >= nr_bits) {
+		kit->nr_bits = 0;
+		return NULL;
+	}
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
@@ -2625,6 +2742,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
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

