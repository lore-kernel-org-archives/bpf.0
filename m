Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795350885;
	b=c5RH6/2jGXh2tmAeSgpxdEyFTW8Igm2Sb9VTOVpFK41kHcX/ZuUKUqG34wl4TUgBM1PK
	 /NqNPC58daqx1B+iBS5JPVk9vcVEusO6Xh84b1QhmhOfGPCTH7CeZbWLRpjUiTHBzFWzc
	 wN6GSQq79afsDYXgcGUF42L99bRZ41pKPzv7UtDaT+m7t2A/g8y3gdOuu+l1aGBFYtbLR
	 cgRr9jIawjbnc+17su3ENsghHPtdvNXzgL8Yj4wwbrg2YoE9d6iteHfGS37AEfr5Pmoq5
	 nzp/lzg1roy5hjZ9usPz5resCqNrcDrunRJ252lTXyaa8WC9Di2CfOnVnWx5aw3s60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
	b=iIjaDmvus02XkawSNwOcGKOPSv6uGGfK/1pUWLwy5jq716nTBE2NKKmikwH539MZ1d6b
	 b3AXCVsNsMMDQd+wlGNPcl3BCgfO4Uu/i+5lowms/GWZF1X2xyADjNj/ubLjlC8GTycAL
	 DckBET9P7mqzQ5wjN58LwdOx255B1nKdCSzLaMAZrm9xTpUBOWBSfxjbvKEzf+KyrYWUh
	 iXGJcGfjlwlTq7fbVxhSraYvE2tc7B2tIhPI2bOoM8wVX0jwXejb3t6WEb87wzSWGQUBg
	 PIN5MXrBDnXB0FqwOxn8q0NmgyTJh3WrHeit4KVWOX1XIoo3pZSeLdN4ZTb/nv9uN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKwikFDd;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF36606A681
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF36606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKwikFDd
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38644aedba1so3216413eec.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795350884; x=1795955684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
        b=xKwikFDdX4OBdEgRODyFtJGV+zd3rDqJUoJO0jhEeGn51IQrIrJVSwAWne+IkxvJb8
         LGGKUptn3PPNw/Yvs7ngoxneVPDOBhUSvG5ZL6sg+2rzl7u7OlyUYLWeWfyNsirg1WLO
         oWGtMr4oFSa73ih2y5qcpUUmV85XXq/Bgv/MAOE8tlh85gT3OVALKKFRFbW2/Ifa7vHT
         DEms7ePeMIHS+XOZ30gQs7MzPX/uVoFMTnxdtsxcmA4SEzP6zaJd9rZKma+QzKewffX5
         Jsruy2izLQeViQaFMdHHv3qecUgXnsMGhKYKEiE7hrtHdTcgUyq0f8B2GAxUwoK3+8hW
         OfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795350884; x=1795955684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jZ+9Hq7+WF35Ttn4sUCu8cTqno+NpMWFIKoNlp9zeYA=;
        b=WkR/mg1zZIqibGkcAeG+XTyJI0jmwxNggjVz8vlv7rT5/dEP9jBoiEEM+0v5SvvKHz
         9lzyXVC1GnMov2y85bdNxAQyennXGq7/11W+PtXa2jQqO1ZrfJ9jSsTIATUbfPVTpAcU
         Ys8jwH/6NMF3MPTrF6d7VSzWNr/1FSqW6g0OTNeT5iqaSwvTyQBi9sO8qUCoRS60lCeM
         OiffQCJe3OcuLbGg9uQDp/KHBWbYoIAaqNRcYvXGrPVwU5xZSFNQKeQIO3p5Ka74dge6
         v3BdIAXX+5qYsq+KvvMqLkXwwd7mZaFLCWi1OIaGuwbUj4c6C4CDWJC3lI5b15Q4xZI4
         7UGQ==
X-Gm-Message-State: APuU4Z8LAJqVuVHziXs31Yr6orWFuRalh8BtkKiF4E7HxgYeEgI+pQq3
	JGsFcNhI00XgUOc7kxRvkZ1VZcBFT2TBTOkU2ParzSk5mtq9VJGv6t4k6C6yKDHN7p4=
X-Gm-Gg: AZFdTZc84ZlnYet6iTgUevHgZo7g5YXBNycraylNW8dYqzoGJfaromxNQ7+et5Uyzve
	lKJXOVzWnFoFkpUgkXF9N43elcf9K7CG2dEPYNlvO0QTpMZ2RXkAzodttjxxeuxGOAzMZjnz+n2
	2aNDruytcEljoQE770abVKyi+cpp+Nkv+ED/kuF46wXaD/O9gKhZufthdU484dUZ4j9gWiSzLhb
	wajONabPD+TU8bC5lvhXggW2U3Rk7TsEVzNMfVSvNbdr54CgjMzn8B0jIiMIG2UEf+77t1Re9Vf
	ml/VcJ39wj8d2llQRPkwdMo/iyrBus8amqbawxaHjOANRMRlKG3kYXj8ADL8lDsbjwC7r2HeuNI
	UUzlun9PHw5s6QPwgJJnpdLHw1/z3OyzAD04CcfqTEaZGbO8rdMZTJ3yulq7kpE54q7UXJxjEWq
	By+EM5hMMHkbrxi+t3yigw/JDldhhxTtg4HdSAPKYTF+1vwubCxxHInJB9KzQHaTVg9EfwUoe+5
	F6+aZLGCcKR+UzQYcqWLSSa64r//VCHJoUpDNqgvnDphwfbhLnO8EG537tIbLi4H/draoxBmUYu
	b2MTjSkXrrxIuTUOq0O3WDBJefaxwWnmuQKC6A9jYDOMhcC/OZBjWvLrWs1OlrHAKw==
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr9754733eec.40.1795350884211;
        Sun, 22 Nov 2026 04:34:44 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm33372330eec.5.2026.11.22.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:34:43 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next v2 2/2] selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 18:04:27 +0530
Message-ID: <20261122123427.287521-3-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122123427.287521-1-abhishekkhade69@gmail.com>
References: <20261122123427.287521-1-abhishekkhade69@gmail.com>
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

