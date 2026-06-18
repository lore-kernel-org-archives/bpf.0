Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB33BBFDA
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773001; cv=none; b=Gd2kYjdgWFQXhc+P66lTI/8jVXyAVkBL/hSK0nM6oHBdxUSWMhudXMZcsqovgeWbQqEUThOpZI47rdYHIUhgQ2sDh9EnN+y0MYKLR5zzYBuOpDD/Fwevhu+ll/URHWCV/R1CqkaThC3qrFoOLfaDapyXshx2oKyOZDSejE3Uu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773001; c=relaxed/simple;
	bh=4SmXuD8J6szEKiRXpF2FzQ0EoagzpfN+I0dq7DqcjzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMks14G86AdswHBal9Q2ViP7CoIxMiOHPpg6EweXSlKfNmiUCO9qe4CJHIdM+MLbYAyJdhmtBzUIKUfrRC5ycGkYkAiZpmcQaZF+0cpLU/pkULCmPrRy+w219dHqlvl5vP8obBVmvwv1ZHjvpvlPgHPUodhQHuiqWhJg4oO3ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X9FdQpHX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="X9FdQpHX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so356809b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772999; x=1782377799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP7MlKG0MKIupdhfj0wbHxPVEEUljFOH7rsmpx/uT7I=;
        b=X9FdQpHXzDOMm36gL7QrySq/9P9dcQaO1WdUhngmpBKi6RicFO0jHoYUDRWBCqI7NK
         mvupI6N88iAdBSFs8EbGwnPXUYbqEEg2GX1Q1x88wpugIAUXGugtuhrvLKsWLOtNExdC
         aDLCul5mCqe5xgl6PzQQ1ltc7ijcDrHufZtdsRP3R51kJVVz234XjTYjHgW6tRwIQZlj
         ujddH0ME8ltBssPMHBt8+d2fgazkA06nHFZrmOT6RsAgC24C4diaaiBJxeAE35jaEM97
         pUt+CuhlgjmJGJ5qlQG2XUnEMfykk7XV3Q8e09lY/mDLdcaQlUN+MdaDy3Yuo79mwZvk
         v5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772999; x=1782377799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UP7MlKG0MKIupdhfj0wbHxPVEEUljFOH7rsmpx/uT7I=;
        b=HFUO7FBrhGqGMV9/ptWTTtnw16sFf3GIuzv/hJdgu0pVI4zjefURYnWVTrpwURxKiG
         Ta/NZkTUU6tg5bpQxz8EXMG71/7WRA5Jahu6c8VkPpF7ZOv4sae/Zg8yc4FAYFED6waF
         Phol9gwc3AsxHHavm6MaELjzu6NWNke/2QBxXEBw8Xqwiu41uSHPyzmNRCViaH+jFz42
         R8Z/uAbpevbI2NJXxuUKxFp6COcnuAH1I5GV5p5CxBGcCzbxbSz4FWm8GflZZk0h56G2
         I3QbRKcoipKSh2+IJdUNmhZIN8cBWJl/TOYba3QRxNq64KDjmiBHyJLQTlZlECZcI2uw
         6d1A==
X-Gm-Message-State: AOJu0YwRvPyfEWote5snL8ApHAmbiYwDEfiz+zjsiRvpVX+R6s/EO983
	R00L27a90vI3WFVJT18x1rYcLCauw/EIgIT0UAOAH2zaJ+oXTo/munUJ8ukyITrZGXUGAX0Ygmy
	5ELQZV1NYoQ==
X-Gm-Gg: Acq92OHeVtqgRLfcjvZqsTE+SF8zxL7jrHXYPM6JQcYcTfwRp3cwm11eA0QtNCheBJP
	tZbDrO4B4Ii8fkQPvEre79lh09XDJ62p2iGpfskAziHU1vVHcCtFy7M7QqcdiTyySlIvTiuA5k8
	gdmUPwJg2ik8TQFCepCRL+hGbhM1oEZp4cvFji4gk8lKqJhLL+/R7G1Q2AFpzSaqmFn/z2vxI2V
	+h62DXUu0ReTEymbhqnv4/PXMmGihIsnj6fB29dkQUzM5HE5OexFU4DxryC2jqvZZRWTnl9pPTu
	sfJ+GS/gNId3GZRD5NEdx9n6MiMAKCfORbELkLLjUsx2VyuQpwTU5m62f7/Odnjb4s3fjNO+JeL
	l+h8Fcs+co+ZLt66XRKRXoakDvDmSY898GoOfwy6gDv7ZQJVmogQYo++xcgdQO8UxUgoB3RV/3M
	2qcgsHRkW5i0/U4+l6TZ6RZNNKZ0ZzUgMp9KRQkTguzlJfjZNgFw==
X-Received: by 2002:a05:6a21:6b04:b0:3b4:65ac:e2e6 with SMTP id adf61e73a8af0-3b9e80ff5c6mr3448556637.36.1781772999524;
        Thu, 18 Jun 2026 01:56:39 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:39 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: libarena: Add bitmap selftets
Date: Thu, 18 Jun 2026 04:56:26 -0400
Message-ID: <20260618085626.19633-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618085626.19633-1-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testing for the new arena bitmap data structure.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 314 ++++++++++++++++++
 1 file changed, 314 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
new file mode 100644
index 000000000000..991a2f420ac5
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
@@ -0,0 +1,314 @@
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/bitmap.h>
+
+#define TEST_BITS	(2 * BITS_PER_LONG)
+#define TEST_WORDS	BITS_TO_LONGS(TEST_BITS)
+#define MID_BIT		(BITS_PER_LONG + 1)
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
+	bmp_set_bit(LAST_BIT, bmp);
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	bmp_clear_bit(LAST_BIT, bmp);
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
+	bmp_set_bit(0, bmp);
+	if (!bmp_test_bit(0, bmp))
+		goto err;
+
+	bmp_set_bit(MID_BIT, bmp);
+	if (!bmp_test_bit(MID_BIT, bmp))
+		goto err;
+
+	bmp_set_bit(LAST_BIT, bmp);
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	if (bmp_test_bit(MID_BIT - 1, bmp))
+		goto err;
+
+	bmp_clear_bit(MID_BIT, bmp);
+	if (bmp_test_bit(MID_BIT, bmp))
+		goto err;
+
+	if (!bmp_test_bit(0, bmp))
+		goto err;
+
+	if (!bmp_test_bit(LAST_BIT, bmp))
+		goto err;
+
+	bmp_clear_bit(0, bmp);
+	bmp_clear_bit(LAST_BIT, bmp);
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
+	bmp_set_bit(ind, bmp);
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
+	bmp_set_bit(0, src1);
+	bmp_set_bit(MID_BIT, src1);
+	bmp_set_bit(LAST_BIT, src1);
+
+	bmp_set_bit(MID_BIT, src2);
+	bmp_set_bit(LAST_BIT, src2);
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
+	bmp_set_bit(0, src1);
+	bmp_set_bit(LAST_BIT, src1);
+
+	bmp_set_bit(MID_BIT, src2);
+	bmp_set_bit(LAST_BIT, src2);
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
+	bmp_set_bit(0, small);
+	if (bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	bmp_set_bit(0, big);
+	if (!bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	bmp_set_bit(LAST_BIT, small);
+	if (bmp_subset(TEST_BITS, big, small))
+		goto err;
+
+	bmp_set_bit(LAST_BIT, big);
+	bmp_set_bit(MID_BIT, big);
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
+	bmp_set_bit(0, arg1);
+	bmp_set_bit(MID_BIT, arg2);
+	if (bmp_intersects(TEST_BITS, arg1, arg2))
+		goto err;
+
+	bmp_set_bit(LAST_BIT, arg1);
+	bmp_set_bit(LAST_BIT, arg2);
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
-- 
2.54.0

