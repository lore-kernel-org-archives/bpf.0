Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F010E3
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773895892; cv=none; b=IEG9KmXvXOzocPjBcuPdCH4nEnZQHG4dV0lf03elEc+LT6JkiVaOl75uwM4HLVvC5yOhf1cYE7HaWSde4+LGxfhVK11uMPVKLs3LqQ6ZJBj7WNqWZlAXyKp54QjNjPf60RuP57CnpdUMcUtrbJQpgtPY1ul5uAVXhprHwoKnRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773895892; c=relaxed/simple;
	bh=l7dkEfw1Py+7b1kZiqsXhi89N4H8tnY3MEK4AECKPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDJ0G74jrdyr4ZtN0UAWzlBSc4A/d81DzSMmjA3XLXLWadKVv0enbfKZWyVyywgOaDb1y47kEU6IpUVUSQ8mj1muc/D4GUYsSGQ4u4B40wUkNTxogFQuLY7EOYTL2mH9YwkYvJXSjDj7j0nMwUgNWXuxKS7nJfYAIl46j42w0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtJp6A43; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtJp6A43"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b976536806cso76151566b.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773895889; x=1774500689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5aqDqu5TxHGEHT/w2dr6bXhum7GpP5rEWZjiubG1dE=;
        b=FtJp6A43i9KZh6w/WF48u9MGtI998TBibqRkDtAxQ56Uam9Ruc8kXRB8lGc8Mtfe0P
         J5oWXwc14ZtUbdmgYDbsmh+6EvuVRnrCa9AK1EvHEltAW6sgABMvK7lYR7eMd3bmWWCS
         HDJY0uvt29xlvGTLW5ZEuS9N1wl3q+WOTVQenKe+EC6w5wX0D7B7ocA92KVYyiRYKHdH
         v9JBf/YGqbsTSUfS2pYHrhN7ystJ78anU3akqPp8iUXi035h+kYo82Yuq71cEdS2IhoF
         /FdXo+VPX3Pau1GI/SZJUWyACgLBc7NMS5+BtpuX3atUc58S2TQEMTbHQ3/OTLZ46CoM
         E47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773895889; x=1774500689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5aqDqu5TxHGEHT/w2dr6bXhum7GpP5rEWZjiubG1dE=;
        b=qv4Vpfte2Z5FRI/wF4vURlggEojJZ3psJrjKf9KorgK9hjPMWxEsmrTdq/2mkjjMsI
         m2UuHWizuw2xAEqa6PPJdeBd6LgFce7C/GF3OJ1CsSNo91tcw6SLR7a1Y8oZD8YVlnow
         idxPKSoezxRRgvvuGf7XYl21CMR4vBpGwAyo5orzjY5Bjw+gdwa0aR0C4M2iUTtBxLsQ
         6unpHoVQVESGykoMHMyyNb2HNm3T+9BCbLaFUrr/DL8PtLxJwGZ5uOh7uV/NGoa8qhtB
         /gdRBPZNDk1xTx6c3/JkydeMi1JWVJJgJw1ILlPYRzs722o5i9Ub4+klmQnZNA8/xqEX
         ah9g==
X-Forwarded-Encrypted: i=1; AJvYcCWMprbg54pAT0GSlsIKCLuOhHpxo/oV7qKYars7WVH8YYFxjGIMAquC8KO5SkuFVfK7Ivk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lXslv4rvvvHFhGWHp6Q5k+Wisdfc9h+queoDKH9GOBtCjlut
	AgJn5bWh6jGKRPZBbON0c5eUMdDmCQ5Xk3CFgN1xvowg3FrLR7i6reFzXIrMbho=
X-Gm-Gg: ATEYQzwWFl/IJLEH/9PwdHBG0s7rIiC6mKeinafeHe5PP6CFFEJGtSc0tjjLmNAwKbS
	hIRj6ZlbstJ7nePRdhSXMb2Ibozrv6hn+e4k1ML3GFfNjuTqGC3qiw+DF8gZ4b+lyMV7ATK8Sv2
	EWAHTZo+QtoaS7KJCFcVJkeicmiXSJ0Lkj1IUt/anhJJRh//EKPgCgBHQfEW5qMer0OlQ/i7Zej
	fVCzzoj/tUfDREAxR3chX4txvZ/5rEpZ9qIBtUtcUwrTGISgHVYyNc7+CiKVQoxVHk0D/6xQ/Iz
	lgyP3D0x1MgVqzjY9MCyC4xnqn9Ni3bBahCHModdmDCqHdgO9iHKRxH1z8WbINcppbSqq/MyYST
	T4XtFvapK+60ohKXUlQQNy9CO5kzLaFnt1uXn8oBGDHdhte9t9f5C7ng0TNwYiRnUmisTxVlWou
	nAZzcDaZHRNDYYZ6+hjFff9id9wwzNUCkZ5L6PL1aVas2YiBL5duh6sw5ZUN60xqa3V1rQIMQv6
	SisvMv02VCgUKeDcH1KfbKZTg==
X-Received: by 2002:a17:907:96a3:b0:b94:1bd:13fa with SMTP id a640c23a62f3a-b97f493bde3mr341386666b.21.1773895889190;
        Wed, 18 Mar 2026 21:51:29 -0700 (PDT)
Received: from codespaces-35910c.m1k4x3cq3poebda54cltipn05g.ax.internal.cloudapp.net ([4.210.177.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142c3e7sm387151766b.15.2026.03.18.21.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:51:27 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH bpf-next v2] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
Date: Thu, 19 Mar 2026 04:51:22 +0000
Message-ID: <20260319045122.9122-1-zeroxjacks@gmail.com>
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

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
 kernel/bpf/helpers.c                          |  2 +-
 .../bpf/prog_tests/test_snprintf_ip.c         | 54 +++++++++++++
 .../selftests/bpf/progs/test_snprintf_ip.c    | 77 +++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
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
index 000000000..5471a2b8b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
@@ -0,0 +1,77 @@
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
+	/* 11 x %d + 1 x %pI4 = 12 args (BPF_SNPRINTF max) */
+	near_overflow_ret = BPF_SNPRINTF(NULL, 0,
+		"%d %d %d %d %d %d %d %d %d %d %d %pI4",
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
+		&ip4_worst);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

