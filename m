Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB23B19BA
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946243; cv=none; b=KpxosvefoF6zon+926J4PzOT6Op7Ayi+i7Lsz64oFYPdARYmFCOYEkvEFsoO3kjKFMgqYDcmw5JLnXCJqtxBrrL7psz8Bg2vqYGy/sgJE86HghuSD7ORF+YlcDXiS6/yYUXFvwaBrFy8ZxNmyd54GY84JeWes0MCofz8QwokcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946243; c=relaxed/simple;
	bh=uNCTz82eekeFFxCz6eme5ihpslacfTaLf1UFSRMBHOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFfEB++I+GPlvCqCPjfFF7e6gxQWz6YhqiLH02OUaG97rRWKB0E9884w+4q2Tke5YoUUopprgZv9CWnlWUt+Qh3RDAzDTlTUioJfGJSwRjNjNAmdQ5Vf/93EHSo9UNA920Jq2+sfgurtMO0Cqu357t8QuNJmIdkdbFsRBrmBQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=IAryzH0G; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="IAryzH0G"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efb708b1a0so11021506d6.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946241; x=1783551041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar6YcJ7g+CeT38991pv1ByOmzQUK/2eFfkiqJT5uPd4=;
        b=IAryzH0Gj3uSHU30658wydw4Rubo6XkOP19XMOCiwet8rxLEc/aPc5aSFHcdvGkF5F
         3x015V1gxkDLfKq9jkc1jaIc0873QLSgS23SSXhc6n9LoX0RckJIDqfZOyWKCaX36+SE
         1eLfY38klNEGl5yFfmUdkVPDtRAbzv9PlWVktxdaYEmfQdFl5McMIKj10lXzGRo4FFss
         w1icO8HmW8/K48s3RyYMtTdwdvCy3XDGKEPsiR9B5YNK9PPzFiH35MBW0CuSREX7xFkx
         6GuOGZoNZ6vckyuliHgYYpUn0EoYUOUX8B1frAJAGoS0dpyK4PzLCtZXKXdvIKRlDNTn
         3tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946241; x=1783551041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ar6YcJ7g+CeT38991pv1ByOmzQUK/2eFfkiqJT5uPd4=;
        b=JlRdo1Bj483eV6wyIQbfIGYc8y2lV85OKIGab4i6E3XniRP67C0UBl9Mb+o4xhsKsj
         wtpuy0WQpPCq9ABkupqfoBbGdJKqp6MoO+WdbJc6Tp4alVvUxlPIGNweN03Q2M6xlWd8
         UCdIEiaptYZA8hylyNa2TRJzk5QSINGSuhyRSq1AYe0pwGTv/eGcrWpgxUkyUa76WUu2
         t6EfuXuNcYqnFGCkiizQlW6eHvn2qeSEE9RJhDBnjZ6G1BDXbCUftNG1+U8jubecK56j
         qGgTpxjx4Jto/r74jSl17VSy/8q9YkfSBSUI2q7Tnl97ePIKFiZXKhTKEMfq02Dbo0rs
         Rm6Q==
X-Gm-Message-State: AOJu0Yz0k32kFR4uY+IQnhbt1l64AmxjccryEOV0WXtEwh66+dQxfx4v
	s07995Z74q2A1fUKComdinh8mE3Bvn0lLUitT+lUd+xcuBH6F+yrCXz30XWRTKCZBJHfQmOM5kr
	IFGMMtuo=
X-Gm-Gg: AfdE7clhCFgQ5MQU7LdPaStbrimAZSDVPvpLk2igLKP0zUJzuwrxToLBm2h1yyKaDP3
	JSGxfWDjfzyrVgPYFX/a3Ob9VludEdTreZ4v9qiLZlkL1zQXVPv40KpnsYa455bLaMJXbV8onZF
	HY4bBC5u4nBfdyQJ1tz20V/ORgNRDRWm35gJk7bcJwY7XZIfiTPeOjraEwTvaKkPF+1OZpy8Sy5
	1Yak8aV3Itk7gu+hlacXTMxXF7wCUbhiN5CuT2oXwKEh+yxFYx2yx17yFUQB/yV/z4aTUECofDk
	HdWebn0AdNwFct5G35jgyOVnXdzjKuL1Qgz9L/GopIvbJTXTOgvtyTpj2I4XCTKNCWYh3om4oip
	Yfb1y8Az3CF3kErJDX1MWAXqxINiJha5/MhckKFy9QyCPfECfG9C+xmeSkOiCspnCrvrYKw7Byo
	sOB+6eIWMRQxw/92gDjnHsNVVLPKL3ZIPTZHPnGw==
X-Received: by 2002:a0c:ff0b:0:b0:8f0:b08d:1327 with SMTP id 6a1803df08f44-8f3c6ecc03emr38079396d6.20.1782946241490;
        Wed, 01 Jul 2026 15:50:41 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: libarena: Add parallel bitmap selftest
Date: Wed,  1 Jul 2026 18:50:34 -0400
Message-ID: <20260701225034.12628-6-emil@etsalapatis.com>
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

Add a selftest for testing the atomic bitmap set/clear/
test_and_set/test_and_clear operations. The selftest
checks atomicity by spawning two threads, each of which
either only works on even bits or with odd bits. The
test checks that threads do not affect each other's
bits.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/test_parallel_bitmap.bpf.c      | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
new file mode 100644
index 000000000000..eec2871e2b0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+
+#include <bpf_atomic.h>
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/bitmap.h>
+
+#define TEST_BITMAP_THREADS	2
+#define TEST_BITMAP_BITS	(2 * BITS_PER_LONG_LONG)
+#define TEST_BITMAP_SYNC_SPINS	BPF_MAX_LOOPS
+#define TEST_BITMAP_ITERS	10 * 1000 * 1000
+
+static struct bitmap __arena *bitmap;
+static volatile u64 started;
+static volatile bool test_abort;
+
+/*
+ * The test needs cmpxchg atomics on arena memory.
+ */
+#if defined(ENABLE_ATOMICS_TESTS) &&				  \
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	 defined(__TARGET_ARCH_s390) || \
+	 defined(__TARGET_ARCH_powerpc) ||				  \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+static bool bitmap_tests_enabled(void)
+{
+	return true;
+}
+#else
+static bool bitmap_tests_enabled(void)
+{
+	return false;
+}
+#endif
+
+__weak
+int bitmap_wait_for_start(void)
+{
+	u64 i;
+
+	__sync_fetch_and_add(&started, 1);
+
+	for (i = zero; i < TEST_BITMAP_SYNC_SPINS && can_loop; i++) {
+		if (test_abort)
+			return -EINTR;
+		if (smp_load_acquire(&started) >= TEST_BITMAP_THREADS)
+			return 0;
+	}
+
+	test_abort = true;
+	return -ETIMEDOUT;
+}
+
+/*
+ * The test makes sure writes don't clobber each other by overwriting
+ * the same word. One thread always writes on even bits, the other on
+ * odds. Both should be able to operate on the bitmap oblivious of the
+ * other's operations.
+ */
+__weak
+int bitmap_test_bit_sequence(u32 bit)
+{
+	if (bmp_test_and_clear_bit(bit, bitmap))
+		return -EINVAL;
+
+	if (bmp_test_and_set_bit(bit, bitmap))
+		return -EINVAL;
+	if (!bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	if (!bmp_test_and_set_bit(bit, bitmap))
+		return -EINVAL;
+	if (!bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	if (!bmp_test_and_clear_bit(bit, bitmap))
+		return -EINVAL;
+	if (bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	if (bmp_test_and_clear_bit(bit, bitmap))
+		return -EINVAL;
+
+	bmp_set_bit(bit, bitmap);
+	if (!bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	bmp_clear_bit(bit, bitmap);
+	if (bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	bmp_set_bit(bit, bitmap);
+	if (!bmp_test_bit(bit, bitmap))
+		return -EINVAL;
+
+	return 0;
+
+}
+
+static void bitmap_test_reset_single(int parity)
+{
+	u32 bit;
+
+	for (bit = parity; bit < TEST_BITMAP_BITS && can_loop; bit += 2)
+		bmp_clear_bit(bit, bitmap);
+
+}
+
+static int bitmap_test_common_single(int parity)
+{
+	u32 bit;
+	int ret;
+
+	for (bit = parity; bit < TEST_BITMAP_BITS && can_loop; bit += 2) {
+		if (test_abort)
+			return -EINTR;
+
+		ret = bitmap_test_bit_sequence(bit);
+		if (ret) {
+			test_abort = true;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int bitmap_test_common(int parity)
+{
+	int ret;
+	u32 i;
+
+	arena_subprog_init();
+
+	ret = bitmap_wait_for_start();
+	if (ret)
+		return ret;
+
+	for (i = zero; i < TEST_BITMAP_ITERS && can_loop; i++) {
+		ret = bitmap_test_common_single(parity);
+		if (ret)
+			return ret;
+
+		if (test_abort)
+			break;
+
+		bitmap_test_reset_single(parity);
+	}
+
+	return 0;
+}
+
+SEC("syscall") int parallel_test_bitmap__enabled(void)
+{
+	return bitmap_tests_enabled() ? 0 : -EOPNOTSUPP;
+}
+
+SEC("syscall") int parallel_test_bitmap__init(void)
+{
+	bitmap = bmp_alloc(TEST_BITMAP_BITS);
+	if (!bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+SEC("syscall") int parallel_test_bitmap__fini(void)
+{
+	int ret = 0;
+
+	if (!bitmap)
+		return -EINVAL;
+
+	bmp_free(bitmap);
+	bitmap = NULL;
+
+	return ret;
+}
+
+SEC("syscall") int parallel_test_bitmap__0(void)
+{
+	return bitmap_test_common(0);
+}
+
+SEC("syscall") int parallel_test_bitmap__1(void)
+{
+	return bitmap_test_common(1);
+}
-- 
2.54.0

