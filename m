Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343934;
	b=CUIn8rRtkfPYK2nBXLtOtgwMfnJzBySdauYzOlgq0Ty24JvB8UZyJy8j0X+EUNYKf8Ik
	 LhNujI1vIJLB+L/9yVDCztigOPmXdamTG6+UlldadUmJlYjP/AhkTsfG0pAXvfYFuBKDn
	 VRR7RKixpUZs+GXTAtjNBa9ZMkA2nT0SYdMxDigaItK8pEQT8Jpv8dIsWwe5w89UavF8W
	 tb7zFGdmeKXLA9Q1/thZ4tmKkl9yEpiWsawirwF8NsN3RzONg/pVRvBz5BnmbFv0oyFCw
	 atwtqy2tn26TSkPEd1aG18+KJYxK6UKZX7fY5gZSRsI6e/MLWX6pf5izSg57RqEuVJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
	b=vYyT9SOtHHE39GMnPbqCQzC2OXOpzABZ/JSxuePZ39cw9CuUu5RQq1ttShC/3zfgPSQG
	 agTmjsBW9nwiyU0eyZSGA/E36rOW5r9PsVdEhbuTcn5WlVrLpj5aYEukqdtqf0SfjdUhr
	 7QCPhxZg1ZCbRjodp30Z9mbvNlG+HRRXq+TAI5riifJjXseS4vAdyaUNojEIw2Nm/PArB
	 Ph0a+iWmvEaC0xZ5LeEvxd7ZTpVKFbmZ0GkYpsxvIpnFTSpMPeWoYTISnZFaaxzhtB/ni
	 LJUVnTlGHVg7VogBG7yGQAtc5TAXBeis07P+p4CeLOvHWhW/3r5PbLnBrM9IP5fZ+eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6nT2KzU;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565A606A332
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 10:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3565A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6nT2KzU
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a315ed211so2952196eec.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343933; x=1795948733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
        b=d6nT2KzUNaWfSImeOZ6TNlBqxf6TIqr/kOuK6VitnS+aE7+8AzPCHLpHgwpzdrb2k/
         OFM/IiOq8UTy2V1N3aFG1a34oKA8EfwcJL+C80QPuPzAw/J9z6NhKjVlgccTynF6w9US
         tNvWd4HUtWAaP6KLvNAYbUUtfKceFH86gwUWdsUGRR9rbWKB1+JaxHoYf6vsOeeCuF2R
         BhwZtfutPLGTZGJGW3PhH9R/zYQ1fCvw3OYJF685pxyMvmIS8FTYojloMuLLzp5wwSTS
         b9qGz469I/SVyTgb4NoYFdrzbzKsQFBGTBxg15E8x0Tp+03v3DCUS+XOrqrwtRbp4ptg
         EOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343933; x=1795948733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
        b=buAbZxaIZDDdqe5DNTevsH7MDsIVWymtCgDP/j7jEBd/Om36d8EU4rODLqR7rC9Opg
         Me4Du5q7SG0lTRHh74/Tbc1yFRTpBpr6fyLhlgPBpOB5efWcjne8AEoWbofOtFxdUt5a
         qF+oqBJzFIW+UXMcDTiCqwRBMxGHXq/3zmkeVJZLgEqcs0Y/Ghy+IaieAXB7aSQIjO7y
         ZuV4zQHOBI6l1Uhurq6t926rjE2TgsL7bLZc2teO/eMrwthEo0TdwVNVE+dCzH5t0w3Q
         oG0QA3dAzdcSO9n/QqMfXp6CTvoFaQHzIHchgnJVUHSF+tLGMJ/u6Er3Np4XumFvXDl6
         ythQ==
X-Gm-Message-State: APuU4Z+zdPM0mq4hIVEYRBD57N8MLIeX0LyKr3NRPCykaX4fzRaEtyeM
	A2Q2t/Ub+oLbFPTlgCRnAlRcTyJc3BHLz+49nbFufdJfuiNG4zyzSFjzYOQfTjFT3uw=
X-Gm-Gg: AZFdTZc5azDUjT0AyHcTwM1jjbW6mStxtF8teX6Wt4nC8AXKsvPiBGCtUhBgvDXrpyM
	R9mRZ7Dl9KGoSpVMnMBVTTHsrBM4Sjdue23kA4PqPoP3Py/kKNc/ApvzaOgBJXR6eJmKJUkOYTj
	aJuAqqjydJytzt4rYSeyCe/l8VXNYrF9livGWj3BhYIyjo7VG6RlOJnIJLNPQuH72Ud9gZkj/d6
	eCPyUl0vsZBU+93+orPrviOeD/Fv8JNUyIwnlB1KLDNNGatac48qd/c4bBx9wn/4VMRpeniHW8W
	Ogvkh9Wq5qbJHq87TW0UZ1LTDKetOn3Ttv01cCZINswGuIxL8e2NwduCpNcsBhzvxluTOKUpiLm
	XyH/dAEK/Z0tgWaMZbhF7ePmt6p3BOGVtZUKXO1hzSXJhdN7ssxbAKQIc/DD19gsnkhgJUDyPdd
	okJKxOw3p+oPk15UJu3FnFn0hwaGQ5t20f191cJCUwRslbNAYqT9n3CJphWRiz76QLJ2mKhSXOG
	/151qrLQCRpcHNTJc1rRxipma3GHGiqLHifu+TrJ9zJ57zDsK82rizhsOgS6NAzzy7BDDswMwgD
	2O6F9Vmd9BSOfrLrqd5ekIDAtSOGncutn9C4OFUgjo2n1isxMhSDkIO1MG/8CxophQ==
X-Received: by 2002:a05:693c:408b:b0:377:82e:2d79 with SMTP id 5a478bee46e88-384b39896edmr10713871eec.9.1795343933223;
        Sun, 22 Nov 2026 02:38:53 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm27124771eec.24.2026.11.22.02.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:38:52 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 16:08:38 +0530
Message-ID: <20261122103838.244974-3-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122103838.244974-1-abhishekkhade69@gmail.com>
References: <20261122103838.244974-1-abhishekkhade69@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automated BPF selftests validating in-kernel binary byte sequence
matching for bpf_memmem() and bpf_dynptr_memmem().

Covered test cases:
1. Binary pattern match across embedded null bytes (0x00).
2. Match at buffer start (offset 0).
3. Match at buffer end (haystack_sz - needle_sz).
4. Single-byte needle fastpath.
5. Non-matching pattern returning -ENOENT.
6. Multiple candidate occurrences returning the first match.
7. Overlapping candidate prefixes returning the correct match.
8. Exact match where needle equals haystack.
9. Needles larger than haystack returning -EINVAL.
10. Empty needle returning -EINVAL.
11. Invalid flags returning -EINVAL.
12. Oversized haystack (> 2 MB) returning -E2BIG.
13. Exact 2 MB boundary full scan.
14. Zero-length haystack returning -EINVAL.
15. Dynamic pointer (bpf_dynptr) searching across embedded nulls,
    start, end, not found, size boundary, and error cases.

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 .../selftests/bpf/prog_tests/memmem_kfunc.c   |   9 +
 .../selftests/bpf/progs/memmem_kfunc.c        | 259 ++++++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/memmem_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c b/tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
new file mode 100644
index 000000000..d27c9a2a2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Abhishek Khade */
+#include <test_progs.h>
+#include "memmem_kfunc.skel.h"
+
+void test_memmem_kfunc(void)
+{
+	RUN_TESTS(memmem_kfunc);
+}
diff --git a/tools/testing/selftests/bpf/progs/memmem_kfunc.c b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
new file mode 100644
index 000000000..8abd06e97
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Abhishek Khade */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* kfunc prototypes */
+long bpf_memmem(const void *haystack, u32 haystack__sz,
+		const void *needle, u32 needle__sz,
+		u64 flags) __ksym;
+
+long bpf_dynptr_memmem(const struct bpf_dynptr *haystack,
+		       const void *needle, u32 needle__sz,
+		       u64 flags) __ksym;
+
+static char bin_data[] = {
+	0x16, 0x03, 0x01, 0x00, 0x02, 0xaa, 0xbb, 0x00, 0xff, 0x00, 0x55
+};
+
+static char needle_null[] = { 0x00, 0xff, 0x00 };
+static char needle_start[] = { 0x16, 0x03, 0x01 };
+static char needle_end[] = { 0x00, 0x55 };
+static char needle_single[] = { 0xaa };
+static char needle_notfound[] = { 0xde, 0xad };
+static char needle_repeat[] = { 0xaa, 0xbb, 0x00, 0xaa, 0xbb };
+static char needle_sub_repeat[] = { 0xaa, 0xbb };
+static char overlap_haystack[] = { 0xaa, 0xaa, 0xaa, 0xbb };
+static char overlap_needle[] = { 0xaa, 0xaa, 0xbb };
+static char oversized_buf[2 * 1024 * 1024 + 1];
+
+/* 1. Flat memory buffer tests */
+
+SEC("syscall")
+__success __retval(7)
+int test_memmem_embedded_null(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_null, sizeof(needle_null), 0);
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_memmem_start(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_start, sizeof(needle_start), 0);
+}
+
+SEC("syscall")
+__success __retval(9)
+int test_memmem_end(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_end, sizeof(needle_end), 0);
+}
+
+SEC("syscall")
+__success __retval(5)
+int test_memmem_single_byte(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_single, sizeof(needle_single), 0);
+}
+
+SEC("syscall")
+__success __retval(-ENOENT)
+int test_memmem_not_found(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_notfound, sizeof(needle_notfound), 0);
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_memmem_first_occurrence(void *ctx)
+{
+	return bpf_memmem(needle_repeat, sizeof(needle_repeat),
+			  needle_sub_repeat, sizeof(needle_sub_repeat), 0);
+}
+
+SEC("syscall")
+__success __retval(1)
+int test_memmem_overlapping_prefix(void *ctx)
+{
+	return bpf_memmem(overlap_haystack, sizeof(overlap_haystack),
+			  overlap_needle, sizeof(overlap_needle), 0);
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_memmem_exact_match(void *ctx)
+{
+	return bpf_memmem(needle_start, sizeof(needle_start),
+			  needle_start, sizeof(needle_start), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_memmem_needle_too_large(void *ctx)
+{
+	return bpf_memmem(needle_start, sizeof(needle_start),
+			  bin_data, sizeof(bin_data), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_memmem_empty_needle(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_start, 0, 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_memmem_invalid_flags(void *ctx)
+{
+	return bpf_memmem(bin_data, sizeof(bin_data),
+			  needle_start, sizeof(needle_start), 1);
+}
+
+SEC("syscall")
+__success __retval(-E2BIG)
+int test_memmem_oversized_haystack(void *ctx)
+{
+	return bpf_memmem(oversized_buf, sizeof(oversized_buf),
+			  needle_single, sizeof(needle_single), 0);
+}
+
+SEC("syscall")
+__success __retval(-ENOENT)
+int test_memmem_exact_2mb(void *ctx)
+{
+	return bpf_memmem(oversized_buf, 2 * 1024 * 1024,
+			  needle_single, sizeof(needle_single), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_memmem_zero_len_haystack(void *ctx)
+{
+	return bpf_memmem(bin_data, 0,
+			  needle_single, sizeof(needle_single), 0);
+}
+
+/* 2. Dynamic pointer (bpf_dynptr) tests */
+
+SEC("syscall")
+__success __retval(7)
+int test_dynptr_memmem_embedded_null(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_null, sizeof(needle_null), 0);
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_dynptr_memmem_start(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_start, sizeof(needle_start), 0);
+}
+
+SEC("syscall")
+__success __retval(9)
+int test_dynptr_memmem_end(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_end, sizeof(needle_end), 0);
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_dynptr_memmem_exact_match(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)needle_start, sizeof(needle_start), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_start, sizeof(needle_start), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_dynptr_memmem_needle_too_large(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)needle_start, sizeof(needle_start), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, bin_data, sizeof(bin_data), 0);
+}
+
+SEC("syscall")
+__success __retval(-ENOENT)
+int test_dynptr_memmem_not_found(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_notfound, sizeof(needle_notfound), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_dynptr_memmem_empty_needle(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_start, 0, 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_dynptr_memmem_invalid_flags(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_start, sizeof(needle_start), 1);
+}
+
+SEC("syscall")
+__success __retval(-E2BIG)
+int test_dynptr_memmem_oversized_haystack(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)oversized_buf, sizeof(oversized_buf), 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_single, sizeof(needle_single), 0);
+}
+
+SEC("syscall")
+__success __retval(-ENOENT)
+int test_dynptr_memmem_exact_2mb(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)oversized_buf, 2 * 1024 * 1024, 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_single, sizeof(needle_single), 0);
+}
+
+SEC("syscall")
+__success __retval(-EINVAL)
+int test_dynptr_memmem_zero_len_haystack(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)bin_data, 0, 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, needle_single, sizeof(needle_single), 0);
+}
-- 
2.53.0

