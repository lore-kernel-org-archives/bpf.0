Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FC38A718
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931964; cv=none; b=IrFYkys1m+Tqgyec1pS2qkpc7wxCxH2SCdIdfnnpBEnVbA412WrJJ4Flcp0eaCqGs9B52DzIYCqjH8Ps7fVlfysbCPO9DY4+wjKwCih4+oKTAXq/wkSYg/sxqJluAf1A3yZqnMn83T8uj3P9VYxN3zUwnnRdewiqTneZZkwLK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931964; c=relaxed/simple;
	bh=ijJnLjDYknX4t6mV1XLiSWjvnUEG9Wr7olg8QS+J6mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGe2NFoV8unQuHp9pCd3Qp7HqDaJe26bjgB5+bHE7FPMl48eXmaeKK/4k8EQDOPOqRKh8N1+d6Jw1wDJdXSYGysjWVzMmoUME5J2NhR28UweHcmj9lyM/qjTWwplwbJ9Ju4mA3tu02m7dSuw+adks2IeW4CjrTxJRWwrXkSB8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CNJrY1Do; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CNJrY1Do"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e6a434cabso57728085a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931962; x=1783536762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=CNJrY1Dotr3nsYRyOLdkg+j0HG3XJgcx/ex1K9TpQlQAOtQk/cLwBUqGpaajpzUkG0
         6HC9ci+rHh3gqNPuEhPqqHWwQAvWUKeVVa5YW9LO020QOOGmEgW4sy+UF65N2kxiQ3Zx
         53q6sJpZmv2QC6eThQ5SqrHzbNrFnqI+2D53rhRmS7MPWCoEfNir9yBz7UaiQXTNGCqz
         OImlx9a+M+aWrAwqZ08FpU+pTv19pp9YtAZ4AN8vqYL1+d6acVZqkhge7j8G46zVvrbj
         EmqBbrh8jC3EQZjzyyckfYZQ2HT87+HUn1Y8XV2cJ6wt0S2PlBgqngkV0gZmyKtnhDbZ
         3I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931962; x=1783536762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG5DAAe4oYSj5vQ/8aDJzHLtCh3g6krTQVWW1uwIBd4=;
        b=B/JhYaQuHJ6QAUafTpZwbtKd0aETla1HU9xX21xopKt1duCCeu9brRMBM8SzRBbwg6
         5GKEb1XV4yY752wMClvj6CqNSFdaLjgmp8r5Bhn84BtWPwRiCbA1Tq+sn/4pz8nrP+1s
         jgmb4+v2m3Ch70oq6HACid2OOawYwdVD8JlLhnYke33knWL/eH0lUMry95F160/IQuih
         DYhhlzUB+Zys2ti+adJTzphNBkgttlrTvxrR+JJKZMp/renE3TeXkb+p9EpoEhtG2HXf
         AAWVckThe6ZaVnmuKqG8A+GJLaU3SO/x5UUMA/4g5kegLHLAHd+3ov+0p6zwOpc7D/3h
         wJ4w==
X-Gm-Message-State: AOJu0Yxc/ExhhVeC10WC8Sg+iLC9gLNkLg0wvcXdXhpfMQ9TbQqNi8yI
	ycYri6DIhsRRh4fbg0319GraJL7hzS0mhFkgEqDCOdyfYY0jH5lovVDGc5txodjckYc36z4BN03
	zUI0EdWE=
X-Gm-Gg: AfdE7cm8YfAxtWTS3YFXxkutQsnewoSscygNhZnkVoBGVDJYZmgOjx9/PmVo+/E7Nmw
	GLNfSMStjdZRq8VkCG4yHWuLPPi8TYh3jbbD3+VJTJXd2kZPoG2ZhsizltCge9gi4Z00eZB3uz1
	5frQM36McQC8T94VKoUhxYPSBAPJ5cp+KYfbWXf91L4uqthnyExPcZMOlrp8AIRqwhWdxXpBu1R
	aViy29kCmgcYxvwDcPm+tk6BCQ/edeyz2AlT802BkRFkr0rrTWybRtNN7157KfuuBIlejjhEeIR
	9aP7Led3KS5G7mh+qwbmxA006D0hx4CRQudF9vFV/AtsbuSsIcKeb8X4n54DVEWoxtGXIUTL6vj
	7kF9+uz2bLsReD7jwWtTkohL8mrOEyOXvayHcEijYBnI6VQbWy85oYkXML+bQRbpT+rUIcEGqTu
	TaMzZD9t47etM8GvXM11MyRzMfjM/7L2rubybSpw==
X-Received: by 2002:a05:620a:28cf:b0:929:b3a4:9bf4 with SMTP id af79cd13be357-92e7b0542f1mr315596685a.21.1782931961913;
        Wed, 01 Jul 2026 11:52:41 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: libarena: Add bitmap selftets
Date: Wed,  1 Jul 2026 14:52:34 -0400
Message-ID: <20260701185235.4516-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701185235.4516-1-emil@etsalapatis.com>
References: <20260701185235.4516-1-emil@etsalapatis.com>
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

