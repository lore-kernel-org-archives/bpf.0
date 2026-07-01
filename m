Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC403C10B2
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946243; cv=none; b=IY1JXuMFMPw+rxEh50FQk6HJT35nYREP5lAORzTgPY1CiOh89Gr/4nmZpenserMJR4l8Q0NZWk8/1T3ZCfB5cUHb4AarweO0BME+2Tc29/rldnQ/SxvUtp4sFTQnlo3ahj+TkueRap8UTQaHmS1oEDssDpQHBJ+r5Fq7vtbzvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946243; c=relaxed/simple;
	bh=ijJnLjDYknX4t6mV1XLiSWjvnUEG9Wr7olg8QS+J6mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKbAwWZgLxS1MYRnq0l5Wgd/eVObkNiLXzUzL4SzjAXP4iq1kO1cTmFVSXM3b/N8hYcJhME44Z2nlzV0Dg+achdbm+dJNcPQ+kAcWnYjsqNFWI91Wa/JhOi5eoA1ea9cv0LeUspSxIV0TFeqn9ZTHe+0/AEFiw3zCiD24xIzsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gtQ5Jqup; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gtQ5Jqup"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c21495722so6419771cf.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946241; x=1783551041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=gtQ5Jqup0lDJpFsa/Igm6MtdN4RJEKFIqBqZoZModfk1b2RCgR6i6NDGGIHtQyoETq
         cDru0shLzwHgGZYcIXLNMlMXyhf+llXNvJFJbVdfdS5r3mkdvngrmO8BtlDYWwX8nsjt
         PkStHoNrPuIv4NSeLWyCR7l6SkbBRWzAQoMByTyylm/WkxFCWwrPWNL03rFVOSO4XPkI
         Q5SNgwcKUwoXkKrNO5wQck51cVNIUTHTSU08b0k1fXQgr9mzncof1maPR5LoOKuFZHJA
         XpSt67m/yXZcbzVAngaTLzg9o0i1rheYQfkpP6O+NTTbIKHeqezxh6Glt3XIzW3gGE25
         mrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946241; x=1783551041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=OqP9rLmkIGox1FPkAlisq7/1i2F7GelT3ddBaZHsWSMBT+/DTTc7TMkUEsrQhSwepn
         ii+dImPBvmxsvgeHhoNVVccWB2ALnFuJk+uhivdUj/ZXMDNb+J0THZYol8fF/oViXkoD
         ZAJ24IL9F+vUg8PjkPXnHg/Ri8fzq15AbV2pCrd/TWqRV55xDUPLf8zLFUVdWyMoizXi
         s8WgkNGlHsVKQvylnE9r/KFFv8/CfllEv2/lYGIkDvojaCMaqctVyiCgaJK6TVOEY64m
         8/hgAv+X4akAl4+UON4jHiZ3dMZkhXIgh8sYDMDUuuSs4WQXCQ7wM+fh06567YpmfQsR
         YcGA==
X-Gm-Message-State: AOJu0YyYsNuchBFNXXYnxRgtgKhSatHd8Ut0DIozc5Oc97kN7YHlA5Hq
	KVVSfPVSZFNfHze1mfdSqeVekmRcQqCe+Y+nrD7vvmLjmSBoDLPghkkDKjWfzNpu5CRM1uHUI4j
	WorrkjwI=
X-Gm-Gg: AfdE7cli2eQ8erYJH5zWowjuEW/+Q5vxnyCD3tsD1cp9DiSTaWkx0sLsXQ9b5II6e/w
	F/oAlalQwWObx53d1ewymB12mupprHuAHZQ0OHusJIjpFnTOoQfLSxtmSrWWNKrEtjZFpcvNWo+
	Q70zXI8fhFDVEfEmURjKD/lyqY53FSVjaCP1B5Hdc96sJ5rA8+U+vEv+sg+OijimjPKsqCLTG4o
	NOQGLrojPiMv2Bvwtiz+dt1AVwQdeFdwJ+tbVvYM+X9AmD3ivYBq1TmQ5GLfofldBkwcJUP2mFn
	4sP2FT9o3uMSJOOJAq6iebEIBRi8kLoIkbRFd3MFFpZBfWOP8Gwxe3AqzZgl/8CmasscpTBnonH
	i72FxMC3bAS49Py4Xp/+fNdInL4ev6nmrvPk5KA089060b/mInoPGUBgIydqanO5GAy18MRMl37
	VBPWTbTuKzLAEePBSiaFoEnZYXMQZXmGMrF9z7ew==
X-Received: by 2002:a05:622a:16:b0:516:e974:6f72 with SMTP id d75a77b69052e-51c26b362e5mr45722171cf.50.1782946240618;
        Wed, 01 Jul 2026 15:50:40 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: libarena: Add bitmap selftests
Date: Wed,  1 Jul 2026 18:50:33 -0400
Message-ID: <20260701225034.12628-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701225034.12628-1-emil@etsalapatis.com>
References: <20260701225034.12628-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testing for the new arena bitmap data structure.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 394 ++++++++++++++++++
 1 file changed, 394 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
new file mode 100644
index 000000000000..e7d32f44d687
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
@@ -0,0 +1,394 @@
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/bitmap.h>
+
+#define TEST_BITS	(2 * BITS_PER_LONG_LONG)
+#define TEST_WORDS	BITS_TO_LONG_LONGS(TEST_BITS)
+#define MID_BIT		(BITS_PER_LONG_LONG + 1)
+#define LAST_BIT	(TEST_BITS - 1)
+
+static void test_bmp_setall(struct bitmap __arena *bmp)
+{
+	volatile u32 i;
+
+	for (i = zero; i < TEST_WORDS && can_loop; i++)
+		bmp->bits[i] = ~0ULL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_alloc_free(void)
+{
+	struct bitmap __arena *bmp;
+
+	bmp = bmp_alloc(TEST_BITS);
+	if (!bmp)
+		return -ENOMEM;
+
+	if (!bmp_empty(TEST_BITS, bmp))
+		goto err;
+
+	__bmp_set_bit(LAST_BIT, bmp);
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	__bmp_clear_bit(LAST_BIT, bmp);
+	if (bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	bmp_free(bmp);
+	return 0;
+
+err:
+	bmp_free(bmp);
+	return -EINVAL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_bit_ops(void)
+{
+	struct bitmap __arena *bmp;
+
+	bmp = bmp_alloc(TEST_BITS);
+	if (!bmp)
+		return -ENOMEM;
+
+	__bmp_set_bit(0, bmp);
+	if (!bmp_test_bit(0, bmp))
+		goto err;
+
+	__bmp_set_bit(MID_BIT, bmp);
+	if (!bmp_test_bit(MID_BIT, bmp))
+		goto err;
+
+	__bmp_set_bit(LAST_BIT, bmp);
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	if (bmp_test_bit(MID_BIT - 1, bmp))
+		goto err;
+
+	__bmp_clear_bit(MID_BIT, bmp);
+	if (bmp_test_bit(MID_BIT, bmp))
+		goto err;
+
+	if (!bmp_test_bit(0, bmp))
+		goto err;
+
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	__bmp_clear_bit(0, bmp);
+	__bmp_clear_bit(LAST_BIT, bmp);
+	if (!bmp_empty(TEST_BITS, bmp))
+		goto err;
+
+	if (bmp->bits[0])
+		goto err;
+
+	if (bmp->bits[1])
+		goto err;
+
+	bmp_free(bmp);
+	return 0;
+
+err:
+	bmp_free(bmp);
+	return -EINVAL;
+}
+
+static bool test_bitmap_test_and_clear_single(struct bitmap __arena *bmp, size_t ind)
+{
+	if (bmp_test_and_clear_bit(ind, bmp))
+		return false;
+
+	__bmp_set_bit(ind, bmp);
+
+	if (!bmp_test_and_clear_bit(ind, bmp))
+		return false;
+
+	if (bmp_test_bit(ind, bmp))
+		return false;
+
+	if (bmp_test_and_clear_bit(ind, bmp))
+		return false;
+
+	return true;
+}
+
+static bool test_bitmap_test_and_set_single(struct bitmap __arena *bmp, size_t ind)
+{
+	if (bmp_test_and_set_bit(ind, bmp))
+		return false;
+
+	if (!bmp_test_and_set_bit(ind, bmp))
+		return false;
+
+	if (!bmp_test_bit(ind, bmp))
+		return false;
+
+	__bmp_clear_bit(ind, bmp);
+
+	if (bmp_test_and_set_bit(ind, bmp))
+		return false;
+
+	return true;
+}
+
+SEC("syscall")
+__weak int test_bitmap_test_and_clear_bit(void)
+{
+	struct bitmap __arena *bmp;
+
+	bmp = bmp_alloc(TEST_BITS);
+	if (!bmp)
+		return -ENOMEM;
+
+	if (!test_bitmap_test_and_clear_single(bmp, 0))
+		goto err;
+
+	if (!test_bitmap_test_and_clear_single(bmp, MID_BIT))
+		goto err;
+
+	if (!test_bitmap_test_and_clear_single(bmp, LAST_BIT))
+		goto err;
+
+	if (!bmp_empty(TEST_BITS, bmp))
+		goto err;
+
+	bmp_free(bmp);
+	return 0;
+
+err:
+	bmp_free(bmp);
+	return -EINVAL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_test_and_set_bit(void)
+{
+	struct bitmap __arena *bmp;
+
+	bmp = bmp_alloc(TEST_BITS);
+	if (!bmp)
+		return -ENOMEM;
+
+	if (!test_bitmap_test_and_set_single(bmp, 0))
+		goto err;
+
+	if (!test_bitmap_test_and_set_single(bmp, MID_BIT))
+		goto err;
+
+	if (!test_bitmap_test_and_set_single(bmp, LAST_BIT))
+		goto err;
+
+	bmp_free(bmp);
+	return 0;
+
+err:
+	bmp_free(bmp);
+	return -EINVAL;
+}
+
+
+SEC("syscall")
+__weak int test_bitmap_and(void)
+{
+	struct bitmap __arena *src1 = NULL, *src2 = NULL, *dst = NULL;
+
+	src1 = bmp_alloc(TEST_BITS);
+	src2 = bmp_alloc(TEST_BITS);
+	dst = bmp_alloc(TEST_BITS);
+	if (!src1 || !src2 || !dst)
+		goto err;
+
+	test_bmp_setall(dst);
+
+	__bmp_set_bit(0, src1);
+	__bmp_set_bit(MID_BIT, src1);
+	__bmp_set_bit(LAST_BIT, src1);
+
+	__bmp_set_bit(MID_BIT, src2);
+	__bmp_set_bit(LAST_BIT, src2);
+
+	bmp_and(TEST_BITS, dst, src1, src2);
+
+	if (bmp_test_bit(0, dst))
+		goto err;
+	if (!bmp_test_bit(MID_BIT, dst))
+		goto err;
+	if (!bmp_test_bit(LAST_BIT, dst))
+		goto err;
+
+	if (dst->bits[0])
+		goto err;
+	if (dst->bits[1] != (BIT_MASK(MID_BIT) | BIT_MASK(LAST_BIT)))
+		goto err;
+
+	bmp_free(src1);
+	bmp_free(src2);
+	bmp_free(dst);
+	return 0;
+
+err:
+	bmp_free(src1);
+	bmp_free(src2);
+	bmp_free(dst);
+	return -EINVAL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_or(void)
+{
+	struct bitmap __arena *src1 = NULL, *src2 = NULL, *dst = NULL;
+
+	src1 = bmp_alloc(TEST_BITS);
+	src2 = bmp_alloc(TEST_BITS);
+	dst = bmp_alloc(TEST_BITS);
+	if (!src1 || !src2 || !dst)
+		goto err;
+
+	test_bmp_setall(dst);
+
+	__bmp_set_bit(0, src1);
+	__bmp_set_bit(LAST_BIT, src1);
+
+	__bmp_set_bit(MID_BIT, src2);
+	__bmp_set_bit(LAST_BIT, src2);
+
+	bmp_or(TEST_BITS, dst, src1, src2);
+
+	if (!bmp_test_bit(0, dst))
+		goto err;
+	if (!bmp_test_bit(MID_BIT, dst))
+		goto err;
+	if (!bmp_test_bit(LAST_BIT, dst))
+		goto err;
+
+	if (dst->bits[0] != BIT_MASK(0))
+		goto err;
+	if (dst->bits[1] != (BIT_MASK(MID_BIT) | BIT_MASK(LAST_BIT)))
+		goto err;
+
+	bmp_free(src1);
+	bmp_free(src2);
+	bmp_free(dst);
+	return 0;
+
+err:
+	bmp_free(src1);
+	bmp_free(src2);
+	bmp_free(dst);
+	return -EINVAL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_subset(void)
+{
+	struct bitmap __arena *big = NULL, *small = NULL;
+
+	big = bmp_alloc(TEST_BITS);
+	small = bmp_alloc(TEST_BITS);
+	if (!big || !small)
+		goto err;
+
+	if (!bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	__bmp_set_bit(0, small);
+	if (bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	__bmp_set_bit(0, big);
+	if (!bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	__bmp_set_bit(LAST_BIT, small);
+	if (bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	__bmp_set_bit(LAST_BIT, big);
+	__bmp_set_bit(MID_BIT, big);
+	if (!bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	if (bmp_subset(TEST_BITS, small, big))
+		goto err;
+
+	bmp_free(big);
+	bmp_free(small);
+	return 0;
+
+err:
+	bmp_free(big);
+	bmp_free(small);
+	return -EINVAL;
+
+}
+
+SEC("syscall")
+__weak int test_bitmap_intersects(void)
+{
+	struct bitmap __arena *arg1 = NULL, *arg2 = NULL;
+
+	arg1 = bmp_alloc(TEST_BITS);
+	arg2 = bmp_alloc(TEST_BITS);
+	if (!arg1 || !arg2)
+		goto err;
+
+	if (bmp_intersects(TEST_BITS, arg1, arg2))
+		goto err;
+
+	__bmp_set_bit(0, arg1);
+	__bmp_set_bit(MID_BIT, arg2);
+	if (bmp_intersects(TEST_BITS, arg1, arg2))
+		goto err;
+
+	__bmp_set_bit(LAST_BIT, arg1);
+	__bmp_set_bit(LAST_BIT, arg2);
+	if (!bmp_intersects(TEST_BITS, arg1, arg2))
+		goto err;
+
+	bmp_free(arg1);
+	bmp_free(arg2);
+	return 0;
+
+err:
+	bmp_free(arg1);
+	bmp_free(arg2);
+	return -EINVAL;
+}
+
+SEC("syscall")
+__weak int test_bitmap_copy(void)
+{
+	struct bitmap __arena *arg1 = NULL, *arg2 = NULL;
+
+	arg1 = bmp_alloc(TEST_BITS);
+	arg2 = bmp_alloc(TEST_BITS);
+	if (!arg1 || !arg2)
+		goto err;
+
+	__bmp_set_bit(0, arg1);
+	__bmp_set_bit(MID_BIT, arg1);
+
+	/* Make sure those get overwritten. */
+	__bmp_set_bit(1, arg2);
+	__bmp_set_bit(MID_BIT + 2, arg2);
+
+	bmp_copy(TEST_BITS, arg2, arg1);
+
+	/* Bitmaps are equal if a subset of each other. */
+	if (!bmp_subset(TEST_BITS, arg1, arg2) ||
+	    !bmp_subset(TEST_BITS, arg2, arg1))
+		goto err;
+
+	bmp_free(arg1);
+	bmp_free(arg2);
+	return 0;
+
+err:
+	bmp_free(arg1);
+	bmp_free(arg2);
+	return -EINVAL;
+}
-- 
2.54.0

