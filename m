Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CD110A
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856676; cv=none; b=hSEt6iw8UbfiPrueAuNtUhNXKjnKuF+ryRnvmL7/AWjH8rvx4E7fjDAxVnW9OoDYB69CNvLLW5eBnExaCuKZGNZAO56/pZXgBlps/CuVcvumRQsgguWZ1QWjFmygpUfZnfexoFgwpFwY8KVdM6bcK7XLF8NBQlCMX3HcMSbqrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856676; c=relaxed/simple;
	bh=dTOH/jT+xl9iMYSWoSvujdD0ZbqUZR86+BcR/iEq6VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5nlZmvdQ5OtuKsuWmZzfgCc/i/LPaQbYl11T2SjXrWp2G01naFiPmGTHaQObuIiU7fAmTe1nUwT/wYBJ4na73n9/iM+cxkxd4JD3R7wsxMJZsd6YhWsVz4ImhMEAlM3g6uhQy26O+FJiL1m/KZLwq5J9UcmWUEc0AmKE4CybCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuJQVKvH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuJQVKvH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e24985beadso2706825ad.1
        for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711856674; x=1712461474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2RRJnLxVo1hxqPOCx7ze6xs5wfBeyecuePLuk6TwxI=;
        b=WuJQVKvH0zAHp1nKX1RGYhjeSVYQbR4Y0JDvxja9lQoauR+6WPO8CSzQqFJGsgMSVu
         IB/Y/7vR9Tny9pNKAHEBghG4zBFoBQ+cZHMGvzYCnfxXnmBkmwUhl31oU2kCcmmH07nd
         tFH3IN1MWn7rgXzU83XwZAmGN+Lb0fIA7wWqo89GefBlDxl0JYVt1zZhE+cFXBZ4cPdA
         OgZ+UYltXVPrA5kHrpl5LOSq9VFfftcrCaCCX2/LWMjebR8vwrY/kBNgzIGvyqtQh3w9
         jszcwTiGn0ESOLLENAZ0rMorrY7nhVAEOjCmNIQAN8bqeLR6ovrMqMspJlwrYAXzDwMz
         OpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856674; x=1712461474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2RRJnLxVo1hxqPOCx7ze6xs5wfBeyecuePLuk6TwxI=;
        b=XjXCdgH++WHk9+vZpS9mmwXfNzocjB36qmVniFPBx317t8PPzafCaF/X5VxeihRtFF
         8e8jUzC7TZEr1g4Pi2x/uAzUMYaiTSxEf5bi2Tp5cXyPfSXdtlTi9TxDYZopR9ExoshZ
         yG0Is+XcGP/67n3DF8LaYIDs1qI841HfrIkGuOt7X7zJGeRtg2Tl64F1p4BPqWHGdvrm
         pCSR6ZKklgwPekKkPjb1GyfS24CuQQLKvL4mP/KrYZi6wr5DWHhfNVlFrGNoQzRoeV4Z
         saAKfXwej1sEQoMKK7WGMlNrAtyl5zRNPGj522A+w94B+y8I8dyZczaht3JJaq2IrrjZ
         vYCQ==
X-Gm-Message-State: AOJu0YwiPhI6SYH1Bh0AMBLV7a4KqLQFh0wzgmXo4Pk59T70D75773To
	9OgI3MiEPtMMAPEcO+H8hSEPaeIK54GWWFBKD6XvOKDyBsk/CrzC
X-Google-Smtp-Source: AGHT+IHX3sLMTqiLqhZDi76p1muBuH2nOBOIK1pDowXseK+j55RmX209idMJhtbkZ9RXHPa1Dd5dBw==
X-Received: by 2002:a17:903:446:b0:1e0:cea:257e with SMTP id iw6-20020a170903044600b001e00cea257emr9909542plb.2.1711856674257;
        Sat, 30 Mar 2024 20:44:34 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.37])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902e19300b001dcfc68e7desm6030239pla.75.2024.03.30.20.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2024 20:44:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/2] bpf: Add bits iterator
Date: Sun, 31 Mar 2024 11:41:53 +0800
Message-Id: <20240331034154.16284-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240331034154.16284-1-laoar.shao@gmail.com>
References: <20240331034154.16284-1-laoar.shao@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/helpers.c | 120 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d9e7aca8ae9e..dec5d3ccd25b 100644
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
@@ -2626,6 +2743,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.30.1 (Apple Git-130)

