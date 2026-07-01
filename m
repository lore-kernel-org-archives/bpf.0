Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28039AD5E
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931965; cv=none; b=BYmBTjZPKmUoPv7HZouqb03stzS7jJN9MFfSp9ktnibWGpngFACGQClKicTJ1d33OHOxrlE3JE5xRof+IU96PtXWTXBiRQjHSGeEwBkTEFMgNIMiZeZ1wA5WtMazqDS4j25KeDdZ3JLKvQC9GB3NiunjWIo4LQ+JIIUOci89cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931965; c=relaxed/simple;
	bh=DD9jQp/eYP/YK9wMHCFHl4PfzP4qJ/L0qjTgQI38nOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1CMPsJf4zl6l8IAp2BU4eCvE+FbqeYAUaaTu90wYwjvNHZsIpDHA0SbRgkeRYHg3eIuEXy7W1YZWDthM+xRJg4x63JPwbLZZmaRr/yQy6VVfXTu4/rLxnXBnBpBw+BrtVYnu54ZEgJjjgt4aXmJQNAipsl3indDVjc9IIMhVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nLf+ZRdD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nLf+ZRdD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e663c828dso70542285a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931963; x=1783536763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWbQFHAWueya+IjMFXn/3DIjN+/zISQoGQd6Tjl85EY=;
        b=nLf+ZRdDNLQddoNcnHGPFA2yhrwgmALGFTwreqDXGxUU/PoRtBFBDecnqFXuk7RQ0i
         pSRIJloWFDPFmV8CSY7kp6XvLYi8Ojg1DcMU5kHXnn0ZBXUbMusI75AQz9HAPtMeuTnQ
         GCkePXh6N1y8PggWWCus3S5+A1on4TcufPNr10Q58LqFVmXkNokhWljq+wm/bDmy1Ysk
         ldMz4+tLmhMqM8YvDzIY4b6i1d4KH2gNJpXifBoUhek160XPV3oBF9lgMEvh2wlXG9Vy
         brWZEgI3orXSNAeliSGDK4SmQ7/G0j0Q0j3PRyoSP3xwZGA8mFKrx6v5MAT9Y+WECD4a
         0+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931963; x=1783536763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWbQFHAWueya+IjMFXn/3DIjN+/zISQoGQd6Tjl85EY=;
        b=b1ZIUP+NSQ/hdSl07T8ejlg0l30o85SDfOd/OjujOCZ3jCNY4Gj6oK9/vQUL8FAuUt
         GhirTYL7ACpt3rjA/RPTqNouYmgJeASP3BwauAWOwx2N3qc2dw3ByE4fTQ40U6Xp6mKE
         OAvHgDR3V3TssNq64NXqf9DMxtldIeZKhwFXhed8kJQnis+CzgFCPnL/oYEyDA9JQJWj
         UAozL/fQI+oqq5+a2/bjPdoNscYHwWI1zmQiBt//v+t4DFB6ZP/xW3wdCIzgxBhtwL+H
         GnLIZpoJWjCx6kaD7P7rsix8d+b0EhpMrjEquxcShZ1IMjL4rrDWLregkszu7ZK6bOiv
         wQ8Q==
X-Gm-Message-State: AOJu0YyYE9Y8tTmbe96wdx+DT1dzGXJdmaXgjYMt/l95ze2m8X9x3E6L
	GqhYtlUanRthX63Vu1T+iS8WlFnr8DnX2ILGrzLpQ6CKp3Ifw47j2rmqnK3kBW/7WhNaxz0ucfB
	WqFbVGp8=
X-Gm-Gg: AfdE7cl1ijlvs5lC1iZD/m7UZiJ0LWTUIL8zFRsLGrpO//miS7MZTMyhURyVBIn1F3S
	i767KiZPNY8X+fkJSgJqGSSak+obCZuOK6I/sr3ES3yVnzHYWmLQd4YLRE9RYxEHSVNDoVeeEzO
	txZRwWzTn/FaVfRBknUGmg3fdQ21HCTgBd2+l/CnRwiTxlO/oPqhoCvY7rDyPCnokEgpYWQYI1/
	ggbWUXA7MepZljbp0DRXhRF6Phbs3pJk2O/J/cpyuyys11FjaXedp+cgnY8hIWxD1aSZJEVm+ID
	/5uNHklyE+YtCXg3lBuZbZ625uUzV2fzF3Ks9REM59JFTdgRXDydA9f5vMzDYi8tMhdOgcXuzZa
	DdOY+lUeTEL6SJnDhUYHFk87ooR2mlWTPXk7L67YdzyUWT2pWi3Ps48O5Zvp/2u38tOFEQnUSr1
	5wujA9X+NXH2j/MiHGACyUDVbE92iCKimDQA+AMg==
X-Received: by 2002:a05:620a:6846:b0:92b:5791:e2ff with SMTP id af79cd13be357-92e782067a9mr366717985a.9.1782931962785;
        Wed, 01 Jul 2026 11:52:42 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: libarena: Add parallel bitmap selftest
Date: Wed,  1 Jul 2026 14:52:35 -0400
Message-ID: <20260701185235.4516-6-emil@etsalapatis.com>
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

Add a selftest for testing the atomic bitmap set/clear/
test_and_set/test_and_clear operations. The selftest
checks atomicity by spawning two threads, each of which
either only works on even bits or with odd bits. The
test checks that threads do not affect each other's
bits.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/test_parallel_bitmap.bpf.c      | 191 ++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
new file mode 100644
index 000000000000..5381deeb8d37
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
@@ -0,0 +1,191 @@
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
+#define TEST_BITMAP_WORDS	BITS_TO_LONG_LONGS(TEST_BITMAP_BITS)
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

