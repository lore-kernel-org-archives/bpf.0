Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDE41D4FA
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361862; cv=none; b=QTWf8GhlHeLYTXuLtvJsAGfsKFlonK0jFfl0x4tc4nYN9CCPo8sEvEgARdnYWLMt5wRulcmj9UWgwy8xCKzjNIcjrO+L46vN6Jwl8ZyyrC6UowW5U8s0RpTN29AUhvmh2JmGa8WCC9mEZ+b7Vlc4xVd6qS2qaYprvnhCLaeNyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361862; c=relaxed/simple;
	bh=ijJnLjDYknX4t6mV1XLiSWjvnUEG9Wr7olg8QS+J6mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+KtD6YJ0F6IxuLw43FzsdNz0q9rXIbO3fk2nGQNGtyvu+KHGE9FWMzR9YF2BgmfNFNpYsxCe3pRjLfehRMeMKLHIvytcYdyS155+w0AMvmDwKu15W70wpF9pFQkMKdCQ1J9HEmm1QiIN0gJtmlN4WmxwE7diZxaF+IOZFEUAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Oauia67K; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Oauia67K"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847aa193d98so2707432b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361860; x=1783966660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=Oauia67K5WbAyU3rvGtRMOINharDIK5BWoCUgRX0BayCVK8TZiUGPVOaJSp99eF+ce
         E6yrJMaxIeTMBigMYyej+OOrVEwo7UZTc+2b1H09/dhcT7ja+I4ioMhLz9GcR2iAD+o5
         Ob802p5djwcRYDy5LbQSAC/3465/XN1QIs+sFiYbEJ+g9DzKMa3wE5VBoKdpDcQpsabR
         Nsm6RRo3+n8DlVLuqeAO0mAUEXjjyyQOJuOqKNIRjAV6l0px9zbBZA5zNit2iLMsXrns
         bjHPzzP8jB9OWFDGRsuazjApi4e3wW0ZpdZLwDgsSA8YUnayWZ7SPmvLB/j8TrAkm8dh
         FpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361860; x=1783966660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=BKk7BsRlIG6CkwtuQr53iEB5BJ6XyUE2j70lFSUKva7oMMGfv9URE1Tfd8lC6SOCxp
         94CASFHD48Tz6axK35jSzw7SIbmn+ufTquCbPHvlJWMK3WY+e+dVFExrcTXZNSo5Ef8+
         yQdyjLhNy3I2lMiFl32yzoQuqF15WekWYUYHZ1/HdXmcY8g9XHBzvp4iayb+mk2SkaNq
         LDwijiOsvzc02Iacq2AVSuhso3dJUTLSdGYmioXdGsMnhK3zekOjgy/UoZvbdlWmwZUX
         RtP8xKQ6uidYt/SEvi/ppKgrDNaVNOrYdfvEOPHuxet4+lWElxsORV60pWwVWXMHhTUB
         mcsA==
X-Gm-Message-State: AOJu0YzIwwwR50jKYIFWjn/rQSFBWeoHD1THCq1vAe4/s9h8NFRLM5p8
	obVCk2OuyulyHfeGl6fUZDxz1Y+xGVPOH+8fpKMwJmWEE3S/0yh/wVdEpbpCBOVPoD6k/mGYvPA
	Tq4odjy8=
X-Gm-Gg: AfdE7cmFX0BISVWZe8FFcfX2svcxoBytWRM92ZgJqzKvWe4Ep6uLY/t2CejA9lw1mpa
	0/9xoW99vCjqnpDYo+5MFH5aXeJRGwjeoTZCBZrmtSdVArlQrkQo4GiZeu7T4ypgyaOutnPSjRo
	SIf3Q1znn1jg9U23CM3qGTzmFl0ZGMeXvQ1XW4DtLxgec6afc7BmYkJ5mzgjUQPpsXTk3HQW0H7
	49WgoaNm5YZOry27J3ykZq3qqRpwyp/Gp7YCEKx6H0qA8/qIsTu4NgHuQLc5RXUGl8Nc/TY1Cvf
	STT5dijkLQbcV7MAGLvKyT2OzBZl4w62ugviHBSR24mqqrbC/hKtvKtv/zqetgF+djOlT7GkTW8
	pQuJcG3MsZOE729k4Utvny4jo1x23jHLfOuevwjWFYIbbmQm3Eq7I/cj+q19cdgVjfrgsVsyjix
	4dmsVfDOcjiBXuxWzuO/t3AHIM3yQ3FXE8uwgKQSrsBrP8jJNK+zXBVyieRA==
X-Received: by 2002:a05:6a00:b83:b0:845:ec38:e45 with SMTP id d2e1a72fcca58-84826c30526mr1681609b3a.25.1783361859852;
        Mon, 06 Jul 2026 11:17:39 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:39 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 5/6] selftests/bpf: libarena: Add bitmap selftests
Date: Mon,  6 Jul 2026 14:17:29 -0400
Message-ID: <20260706181730.21731-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
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

