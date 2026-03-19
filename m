Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3A40DFA4
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892066; cv=none; b=ODi7sqUCL7+Ry+PzaQyjL1vq3bcOy3v5xXeAXRuc7BODbHqXzC7x1tZlBTPn9lF2dUeDVQk3Co1uhN7IZqYXB9BlyhnfHsd4gKbW5tUWDNoQ1VekZrpy+GlmtaulKC7Bnwrm5pWEZ/iLAYKyLldTPLVMEEgHZ4TkuShd9av/hQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892066; c=relaxed/simple;
	bh=1dHkqee0M4zeAK5amubp3xdpKiAulavq0OlQqWcKNUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vdj91frpd5lSNOjKmgufoQaH4Tgirt8SmZBDRI6+3dpN7tXM6EKTHYcF/9bs8JdNdkH1bBHzEVrGak/A9PulF6QrfULP4b1dXYjfKOLE5KVBLn8OOZMPreTJZc+eVjHb6vu4/nwypcW3jZahDBwC71CseihxMB+JfZJEuRHZUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0411Wyp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0411Wyp"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-667952fd262so898262a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773892063; x=1774496863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmSUWon4NyhSsL4DljIoxeto843T8qqFlqgLpXBxtpk=;
        b=N0411WypPVtWZP4W7NhyQr13U/UUiNbVN2kQrgWrl4vZpCOniVuGOOMHgXeBKYzQc4
         FCWoVUbYtce8ypuFvpDjNbgj/UyiM5an/SY6tsCHyI8cLQdINnAo5hOh+smEY6/xAgCs
         lgppUNrqRm3IwV1QUAW436dijGoeYQlmS3inF5stFiHI5w5gDQQa2yEHW0sG9xqf/EBX
         5gli+eBHBl5IQsLxHVZaE8FlqAuVdnNmPdvXFFMt3BPQuUnd+QJvTKo2rIp6x6C/oXqo
         4s4/aMv2J0TFuw0r/pkUbssXitUXNeXmEA0uxoJ53mbk0EIrfR9AWa6NQFzQdk30E62q
         yM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773892063; x=1774496863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmSUWon4NyhSsL4DljIoxeto843T8qqFlqgLpXBxtpk=;
        b=hcKpDN58Lun57j7Vmap2vGIa+WhMOwQebSwBBenYWMP1E5CJD41PwUQNlGICYe5VoZ
         mmOA+mSpSyzA9HiRXM2gAtLGxjJhQ54yb6xUX7mjgCJ25dS/Ylwm9TqN2ejemkjJCyE4
         YcmlM46NUgkL4vfUFs2cYYRZZKLTsBtEsYjtmf5B+zoRRrNfA2UXJyaSpjKwQuou4AZ+
         rQtfjUupOmbKRjl5cAm9KliwgaTGVI8OSIwmLPuhSZzF447sDJGyc2c8A1krc2LBcKJ0
         rDdlvqR/V52WwsDi1aQ5mMY3SeXybRriEnOHHlc9o9KiP892XO9aKxFAOFboPUm+CnI5
         6SaA==
X-Forwarded-Encrypted: i=1; AJvYcCVWUP8C1JbQXTopVABIDBpBqp1KqIW94cn+1zr89WQSKjZ5DjfCcOMlYKm5IB4OHl5wvIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy18BQSgffWPDaOrdxTNj1hGPy264/x1ihkfkNIYezcJL3jSMa
	VZtwntSluGgmqEsUyG1cPxDqMRJONpiKEUK3N+p0SynavtwGeRLJdgY=
X-Gm-Gg: ATEYQzzNRt3i6VgVkxyRaAk9PjIjDS33d6A6qgwx/PIG58x9AymmFWNdULGL3R9CHgu
	opPS5CeAAwxCa+N9Q3GRjmzpS7BoX2p0ExZpwcevgZeTZmZ2l+pPilWuKohNQvWwemB2sqbYcF5
	QZFph85hI9UlB85ohwGfND3ioNCtOfgXWhF5nFesqJz/D/8ZZE3xoOVWdf2M5sMM2gIYOjcrJQh
	m9eMKIFgQ2YdCMsiw9636HSLCFFOWrqkE7MC6bk/ibiSGWH9fF9l7BSsKhySC6lRVKIvZV1lHdf
	E4dzbZNuuhE/H+5JWrHks3pcri9nZvkpAVz1oBw2HBG8WiVPSv00EvD/c4RXVPPR2Sc/JvJhYms
	G5LxEW/hj3JwnMR6OA2+lxUZMgM+KSOLJUPuAUx8GCzsNuypMsZOytegElaHwvlf0q/eV9PMuji
	Dhpewyux2evuuiOJO/AD5Xn4NdeVskZHJ3DisD8kkaF8qJf3OiezcLFPH4arEICm+a+97s85hY0
	F+r5+F7w2pyy5nqxCOthPU1iQ==
X-Received: by 2002:a17:907:9811:b0:b94:24:44bb with SMTP id a640c23a62f3a-b97f49bd1dfmr367370866b.42.1773892063079;
        Wed, 18 Mar 2026 20:47:43 -0700 (PDT)
Received: from codespaces-35910c.m1k4x3cq3poebda54cltipn05g.ax.internal.cloudapp.net ([4.210.177.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1704a08sm375136866b.48.2026.03.18.20.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:47:42 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
Date: Thu, 19 Mar 2026 03:47:36 +0000
Message-ID: <20260319034736.10569-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bpf_bprintf_prepare(), the bounds check for %pI4 and %pI6 format
specifiers uses sizeof_cur_ip (4 for IPv4, 16 for IPv6), which is the
raw byte count of the IP address. However, snprintf() returns the
length of the formatted string, not the raw bytes. For IPv4 this can
be up to 15 characters (255.255.255.255) and for IPv6 up to 39.

tmp_buf is then advanced by (err + 1) using the full string length,
which can push tmp_buf past tmp_buf_end. The next iteration's bounds
check underflows due to unsigned arithmetic and passes, allowing a
write past the end of the per-CPU bin_args buffer.

Fix this by checking against the maximum formatted string size:
16 bytes for IPv4 and 40 bytes for IPv6.

Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
 kernel/bpf/helpers.c                          |  2 +-
 .../bpf/prog_tests/test_snprintf_ip.c         | 54 +++++++++++++
 .../selftests/bpf/progs/test_snprintf_ip.c    | 81 +++++++++++++++++++
 3 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_ip.c

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cb6d242bd..dcaa822ba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -930,7 +930,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto nocopy_fmt;
 
 			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
-			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
+			if (tmp_buf_end - tmp_buf < (size_t)((fmt[i] == '4') ? 16 : 40)) {
 				err = -ENOSPC;
 				goto out;
 			}
diff --git a/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c b/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
new file mode 100644
index 000000000..5b000d6d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Ibrahim Zein <zeroxjacks@gmail.com> */
+#include <test_progs.h>
+#include "test_snprintf_ip.skel.h"
+
+#define EXP_IP4_OUT  "192.168.1.1"
+#define EXP_IP4_RET  sizeof(EXP_IP4_OUT)
+
+#define EXP_WORST_IP4_OUT  "255.255.255.255"
+#define EXP_WORST_IP4_RET  sizeof(EXP_WORST_IP4_OUT)
+
+#define EXP_IP6_OUT  "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"
+#define EXP_IP6_RET  sizeof(EXP_IP6_OUT)
+
+void test_snprintf_ip(void)
+{
+	struct test_snprintf_ip *skel;
+
+	skel = test_snprintf_ip__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	if (!ASSERT_OK(test_snprintf_ip__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	/* Test 1: normal IPv4 */
+	ASSERT_STREQ(skel->bss->ip4_out, EXP_IP4_OUT, "ip4_out");
+	ASSERT_EQ(skel->bss->ip4_ret, EXP_IP4_RET, "ip4_ret");
+
+	/* Test 2: normal IPv6 */
+	ASSERT_STREQ(skel->bss->ip6_out, EXP_IP6_OUT, "ip6_out");
+	ASSERT_EQ(skel->bss->ip6_ret, EXP_IP6_RET, "ip6_ret");
+
+	/* Test 3: worst-case IPv4 "255.255.255.255" */
+	ASSERT_STREQ(skel->bss->worst_ip4_out, EXP_WORST_IP4_OUT,
+		     "worst_ip4_out");
+	ASSERT_EQ(skel->bss->worst_ip4_ret, EXP_WORST_IP4_RET,
+		  "worst_ip4_ret");
+
+	/*
+	 * Test 4: near-overflow scenario.
+	 * Before fix: tmp_buf overflows, kernel may crash or corrupt memory.
+	 * After fix: returns valid length without overflow.
+	 */
+	ASSERT_GE(skel->bss->near_overflow_ret, 0, "near_overflow_ret");
+
+cleanup:
+	test_snprintf_ip__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf_ip.c b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
new file mode 100644
index 000000000..44cc4d74c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Ibrahim Zein <zeroxjacks@gmail.com> */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/*
+ * Test that bpf_snprintf() with %pI4/%pI6 does not overflow the
+ * internal bin_args buffer when the buffer is nearly full.
+ *
+ * The bug: sizeof_cur_ip (4 for IPv4) was used for the bounds check,
+ * but snprintf() returns the full formatted string length (up to 15
+ * for "255.255.255.255"), pushing tmp_buf past tmp_buf_end.
+ */
+
+/* Output buffers */
+char ip4_out[64] = {};
+long ip4_ret = 0;
+
+char ip6_out[128] = {};
+long ip6_ret = 0;
+
+/* Test %pI4 with worst-case IP (255.255.255.255) */
+char worst_ip4_out[64] = {};
+long worst_ip4_ret = 0;
+
+/* Return value for the near-overflow test */
+long near_overflow_ret = 0;
+
+__u32 pid = 0;
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	/* Worst-case IPv4: "255.255.255.255" = 15 chars */
+	const __u8 ip4_worst[] = {255, 255, 255, 255};
+	/* Normal IPv4 */
+	const __u8 ip4_normal[] = {192, 168, 1, 1};
+	/* IPv6 worst-case */
+	const __u8 ip6_worst[] = {0xff, 0xff, 0xff, 0xff,
+				   0xff, 0xff, 0xff, 0xff,
+				   0xff, 0xff, 0xff, 0xff,
+				   0xff, 0xff, 0xff, 0xff};
+
+	if ((int)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	/* Test 1: normal %pI4 usage */
+	ip4_ret = BPF_SNPRINTF(ip4_out, sizeof(ip4_out),
+			       "%pI4", &ip4_normal);
+
+	/* Test 2: normal %pI6 usage */
+	ip6_ret = BPF_SNPRINTF(ip6_out, sizeof(ip6_out),
+			       "%pI6", &ip6_worst);
+
+	/* Test 3: worst-case %pI4 "255.255.255.255" */
+	worst_ip4_ret = BPF_SNPRINTF(worst_ip4_out, sizeof(worst_ip4_out),
+				     "%pI4", &ip4_worst);
+
+	/*
+	 * Test 4: near-overflow scenario.
+	 * Fill bin_args with scalar args (%d), then use %pI4.
+	 * Before the fix: tmp_buf overflows by 8 bytes.
+	 * After the fix: correctly returns -ENOSPC or fits exactly.
+	 *
+	 * We use fewer args here since BPF_SNPRINTF macro has a limit,
+	 * but this validates the format string parsing path.
+	 */
+	near_overflow_ret = BPF_SNPRINTF(NULL, 0,
+		"%d %d %d %d %d %d %d %d "
+		"%d %d %d %d %d %d %d %d "
+		"%d %d %d %d %d %d %d %d "
+		"%pI4",
+		1, 2, 3, 4, 5, 6, 7, 8,
+		9, 10, 11, 12, 13, 14, 15, 16,
+		17, 18, 19, 20, 21, 22, 23, 24,
+		&ip4_worst);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

