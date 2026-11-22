Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358314;
	b=Y3M9+M5GAxt9NhJJwo/4ou/vUfb5YCdr+p+mdiAW8tHTTCCWwleaZjl+K+QqrrnDDF3D
	 sTmawDJ6vRGBHiIQMBMEvKaLaR1JyWO9kabhAqJ5iDKsS8c7/PRr7M+lum4MyMFYgHuxq
	 W5PkXhDvAPFL/sann+DCBODmKKD6o5vY/kT/qI0v7g6Edk6XnMQQ1DUt/TqIQR7vGYa1b
	 XYusDY7Ogn2y4S26eLZrnOv6F7pBEp84L8IAWsZJ0q0Fq1/x3qS/v+ySfaOn9051fb+Sp
	 MaoVdXGNal2DPRtn0+vFuP45ysuZayuH3ZKMMdkrfKEz3WHZLdct6KggpwBVla9Qr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R2SCsefLVosXtBOzyHVV+zlMeX4Ss3cZYdMKvKADzcY=;
	b=NuQnvh7RIiDgjmbPlSf8BhPGU88tj93bUUU48zyhZamF8ZQdbALtQ5BJhUnyDhphsYho
	 Wc407EAMRC6O/2JpRRSBaeRcjFpVE0agIMeszGGPt3wyd0uuodFQz+YHlVwTjlFKTR6WU
	 0F29IeSAF2hcZHCSvM39Rvkl3P9DPd84wgNJ7/0FBSBqKxVJVT6Le1uxjgFuxeSKabtAz
	 6YTIpQuGB89DkC2MMgQSkIMR8NB+buoVdJbnsd9gT+LdUBqwTMBxciZ4sGJH1j+o1fZr7
	 N9M+KLF0Gmlton+RZOMkA6tWSMXqCbUj41+wjN7gnWXXjdjwYaHIpXe+g+YceQ/RBVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgrjZJY5;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DB606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 14:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 602DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgrjZJY5
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-380c28f9e35so3486028eec.1
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795358313; x=1795963113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2SCsefLVosXtBOzyHVV+zlMeX4Ss3cZYdMKvKADzcY=;
        b=sgrjZJY5sKYGZa/aEDAAN2rm2dUN5QRNGW0dhym95+TFYPkgsMhBaCnfKVMOfFjp6R
         9lGkmO78Cjqko9KlQwjUEM/6QrlLlea/z3L+MuBZm0lZvwG2WFHi607L7Ly14kyDH+uH
         9t8eP/q7YhGulSYIquZAHKOuXoZtiLnHGC/GmVhU9cZNJS24OatC3HYTIS0rg7iODRE3
         9VxXC039AtOPopU3ye2g7gQeNEnSBIthLQHk6ODWfuQJq/Jbzl9Jvqf9NRscVrvYpZxz
         /b+8778FQ2p7KNCqeojMoi8rHiMVUacw+l+JCmsHvLcWZO3XM/Y5M015SwIi91p+0Dcz
         KypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358313; x=1795963113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2SCsefLVosXtBOzyHVV+zlMeX4Ss3cZYdMKvKADzcY=;
        b=OtWo3FqdDQUsAblhT3awUm55GwJ3tg4k7nedA04Wt6iWiLSsNwjYo09II12iS8VNsC
         T/OH9r3hDUWxArcvk1XqTiydSAsWvfjQpZ6jmPNcYKDIG+JV7CbuFYYM24sACv9Lu9ws
         mVzoxUzj6TUmt/BCvvLGxscWrAgZCyrP+AxAsggwqpfa3QChLd63KxtzVgNdfam+rTgw
         seS6qt1BRkPKNBqM/MRHGISlc755ytpITNjOG9rCYaFRYgvPznHUdNsnDqMthX/4a/y9
         qWLiD7S5xSPrhpbJ8mu+U1btLgN64UkfBi2M1obyT/KVZ9+Jm+HuYOV/xd0F79XweTjV
         lc8w==
X-Gm-Message-State: APuU4Z8HWEp1f0n1yulcgvJT1AumeMjXh1HnFXvwYkc06mkYqKH3hnxX
	l0ChW8yynw1WOBhu/FDLrPeuNx/KqHjdstIUZ2+9PaLvW5Fvtyp6dgZMcwpLq1CLFN4=
X-Gm-Gg: AZFdTZc6k9VKpQj1t4fArqbDWj3F1tIBdn2cYijMHX0sVuJz2ydNB0cC2rUM38I57a8
	5YOG5bNCdMGo8JhE4Yflx6t7yEGAcUM0ZdRZ6s1Z4AzJvNlm9dAEimC6tsp/+YAFAqsF79qIdNj
	ND8J7bCzlNBaAn5QIyg1+wgc1lD68iHDPEHDoXDPehUG3GKvPnQg+jTwM2ki4zgsV4mYQHhf5wo
	JJzQ1CjvouYLru6u+RydTxMeBqot3Tl9mquKGVz8qQ1DoyCELkrMaBRHLB8CsYBOAPbZgQL+KDu
	oe6gR+4PCHKeZV68npJT4NJkLAFoJVUMxoBEVMIfTS/H6ObADnpDLS5ipSC9ffxsEbC6OMbF1mA
	Gh6DBu5xEOzZik1AvrxblrX1yPimb/dA1VYvITlHyyDlKeipb7UCNtOJMpGGaD/8iyD4z5Y7WcZ
	gug8IwceBadvRGjLSU2HV2eSZTG0TU6h4fLdWyCOhYTJD6xNFLyZdePqcH9eJOza4HtNiuf1zpQ
	4/hJQAQbhBO71CXp/7O8+8asdLHM+LBuO2lNtQS+HnI5iU3JGo26Ls1ha6J5rkKVcv+wM8jHg77
	WWuSwY+siuz4uhvB8HJQvfMVgnDQ520Jt2j/R2PPfbEK6GeW91HKiFTYkHtu6sHazg==
X-Received: by 2002:a05:701a:ca09:b0:1b3:b322:a42c with SMTP id a92af1059eb24-1b5568f8e64mr8966138c88.13.1795358313144;
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm21265456c88.8.2026.11.22.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:32 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 20:08:15 +0530
Message-ID: <20261122143815.330528-3-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122143815.330528-1-abhishekkhade69@gmail.com>
References: <20261122143815.330528-1-abhishekkhade69@gmail.com>
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
16. Periodic needle patterns validating Two-Way critical factorization.
17. Pathological repetitive prefix patterns validating linear-time immunity
    without premature budget aborts.

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 .../selftests/bpf/prog_tests/memmem_kfunc.c   |   9 +
 .../selftests/bpf/progs/memmem_kfunc.c        | 299 ++++++++++++++++++
 2 files changed, 308 insertions(+)
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
index 000000000..eb8959068
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
@@ -0,0 +1,299 @@
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
+static char periodic_buf[] = "abababac";
+static char periodic_needle[] = "ababac";
+static char rep_buf[] = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaab";
+static char rep_needle[] = "aaaaaab";
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
+SEC("syscall")
+__success __retval(2)
+int test_memmem_periodic_pattern(void *ctx)
+{
+	return bpf_memmem(periodic_buf, sizeof(periodic_buf) - 1,
+			  periodic_needle, sizeof(periodic_needle) - 1, 0);
+}
+
+SEC("syscall")
+__success __retval(24)
+int test_memmem_repetitive_prefix(void *ctx)
+{
+	return bpf_memmem(rep_buf, sizeof(rep_buf) - 1,
+			  rep_needle, sizeof(rep_needle) - 1, 0);
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
+
+SEC("syscall")
+__success __retval(2)
+int test_dynptr_memmem_periodic_pattern(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)periodic_buf, sizeof(periodic_buf) - 1, 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, periodic_needle, sizeof(periodic_needle) - 1, 0);
+}
+
+SEC("syscall")
+__success __retval(24)
+int test_dynptr_memmem_repetitive_prefix(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem((void *)rep_buf, sizeof(rep_buf) - 1, 0, &ptr);
+	return bpf_dynptr_memmem(&ptr, rep_needle, sizeof(rep_needle) - 1, 0);
+}
-- 
2.53.0

