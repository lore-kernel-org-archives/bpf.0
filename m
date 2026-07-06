Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD6435AB0
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361863; cv=none; b=TYzuK44GqAC1elqMV0M7MGaSnieJUemWpXGHOj4RtjZb2MhcgzkWwukEsILxqZmy7+eiwvFXnCMBero5quQEa0LVmAuzrZA3i1YiSACuUqvkhfIFhMbYAUdfZwDrlF/OS9zBgz0k5m3QQrMzgr3SdJzdUBBdEjeYQrFREOsRbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361863; c=relaxed/simple;
	bh=uNCTz82eekeFFxCz6eme5ihpslacfTaLf1UFSRMBHOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHT9h8pX23Vvof5wqikGBU08A7316E7JsP3hI9iAptydkwh1fcnu96ZFNmDX7Gdzu7OnWMX/yy740JWFxvR0va56pg3xKYEsUUgezGiMhCqMll/JQDey4MzJRod3GoUWWDYEngjI2TBysPoWrQDfBGjC1JXLHbHzG9GpzUKUJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WJlqI4px; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WJlqI4px"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso3799762b3a.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361861; x=1783966661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar6YcJ7g+CeT38991pv1ByOmzQUK/2eFfkiqJT5uPd4=;
        b=WJlqI4pxnHcq6wnqlsE6fFc305pSaOA++4Xjn8FwBwiLcI3Jb/byZKB9sHvokNAtRM
         F0HRBhG3f84u6aOKO+TTDcwjwHwNv3EiSRU3yRca75+3RE/z5K0drP1rz0Ik6NF/UlOc
         FSI399da634a9RNuUeAUBbhkwhSNlexdN9Pd/okNRov/+lASQ0WXPz/yWqyhKcsuQew2
         J2HMQHjxqBxPpS2hJcIlZ0sATawP55U005++OXxJ1G5WLWZR7COiAeuui0z01b1eCreM
         FmIDIF8SR4P+f4FK/eiDZOuuUgUWL+ag0piVIN95k0BX/F6yqZjxNumKW65pz7AmuuGw
         /1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361861; x=1783966661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ar6YcJ7g+CeT38991pv1ByOmzQUK/2eFfkiqJT5uPd4=;
        b=jE0mrDel1gwvZoSnuFguu72kPYt2uJ+URN38TkYhZ4XOxhtPWqaMTVFLICJIyeY2do
         O9SjkmwVoUUiKzm8MBey7mSJksViHE4tJLWA+uxwIrqlFIC2FK2iz81Ry9lsDtnHqhdi
         jfHhO+Wef1kwzcxmLYrhRcMrnz23xCigwuz1oCT6s/42KGkRiB1GQtPbLod+oZNHTiov
         H1SIsCCH1FOWFus6NdjyHVsB549yrGRuvF05Ks5v9s2P3Hz2pwvGVi4OLneLEb10tlFS
         nppmYrVmTa3xYQLXP5Iy3qlMIW8K4Q3GLwWPmqtckb+mirHejLHTqkrxKoOajtTKGSF0
         xdwg==
X-Gm-Message-State: AOJu0YzfFqMLJACRYGjkV7XRAp7e0BNdc2CExLg4DKsT+yIVICv3pqc+
	//XES95eIbQTpv7k2OuseGL3XfLd4D6/vLUeqvD1EbShWXey0Ljk42nxIrlTVjQGwPpmSqEuPP9
	MEmsGoPY=
X-Gm-Gg: AfdE7cniuw2DQczzIDxfwwEltY/rFXZTKBjcMbWgrNpMV5d5xNYSmer6FSsxOPQ+Z38
	UO2iEpLDiAXl67gPGBFuvIH6DLJOXFPOlo4Zme6AvivrxZQL85+JCdasltHR22dLw7vE8HRacnh
	M25ta2z1YkCzUD04rhlXSUuHf4auarEG/ZCPx9ZN406bdYR0R2acCaGWINpMZBQD7EHumW/dv3m
	86UzR/a5DBYWrzC8uYyQPDSkzzt51514kZFd5CfQc5KJvs2jbwOEg507kAVoqf3VCbhcKvXotk9
	azU4VBGrzPbvdWqDvMoD6gE8bUvhkdeXvKsoC5z60aEr1IeRoo33GZ9OO0oAMgYdVsUGYjO8DCS
	wYuQ7kmdx9E3ELlGZDJ7sre/3J+1RMjR09SVlz3r2Y512EzARXecwfZKFBoPY5LM6eFyL5wpINT
	1ZMQYpet9HfbzDMbQjDt/WipLys3nANCCt5DYi1Jp3erKuL6U=
X-Received: by 2002:a05:6a00:3a13:b0:845:e1a3:1080 with SMTP id d2e1a72fcca58-84826d81a1amr1834298b3a.55.1783361860923;
        Mon, 06 Jul 2026 11:17:40 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:40 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 6/6] selftests/bpf: libarena: Add parallel bitmap selftest
Date: Mon,  6 Jul 2026 14:17:30 -0400
Message-ID: <20260706181730.21731-7-emil@etsalapatis.com>
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

