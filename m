Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5945D5F5
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250750; cv=none; b=r2LuOI0XAbXYRKgKZh42aLXlf+1bhcT1ID2t9d8rV7UrfockWA7PWhr27/AmteVj/GOrTw97jT/y0YftxUrnkqk+ffb3eDh3Anyb4+9fELQLdapodd4KAQV2OdMrw1ZG1deZsehcoKhsZ6wk4OvskODybj5PvkRgUmMFHqLp1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250750; c=relaxed/simple;
	bh=v0ME300TEid32aWD8J+NpePPTdTOW/cH2DY4na06gpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkbztK7x4eLAaET5gzOWpYba9jQFNwQ3Mm/282bbgJ+rf0LwzV8kthxIcnOC6Lu9zfvziCZQ0zbwuD3yEpgYr8TBs47q9g669QH4+G/SLqPBxnnqlnT70/mtXMYuXgB1vt2eLmY3CthqErBxZx6wwB7TqJp69vB080c+mQHOAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJBLEfII; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJBLEfII"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNp4HhpCuLw6R1QKipgGVZPnAvveUqgoF5YJI3gg4oQ=;
	b=DJBLEfIIBne30WGNW9FbXhgT0Nfn5FYOdRYEvXyxRkN4epLKgT5oqjGblFqitWFp2WRZfA
	OOE/QmLRgxZcs+XY8v1AuY04cHMvTFDppYeQ5J7TUNdDdVfng877r5GV5T6hXNHq6w4pYG
	o/YbgITnV+to2G3ng2jbeid/aCiuO2w=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 5/6] selftests/bpf: Exercise word-at-a-time string kfuncs
Date: Tue, 28 Jul 2026 22:57:26 +0800
Message-ID: <20260728145727.45153-6-leon.hwang@linux.dev>
In-Reply-To: <20260728145727.45153-1-leon.hwang@linux.dev>
References: <20260728145727.45153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add functional coverage for aligned and unaligned strings across
the scan, comparison, span, and substring families. Cover matches and
mismatches beyond the first word as well as the length-limited substring
suffix rule.

Use aligned invalid kernel addresses to exercise a failed
word-sized nofault load and its byte-sized retry.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/progs/string_kfuncs_failure1.c        | 58 +++++++++++++
 .../bpf/progs/string_kfuncs_success.c         | 86 +++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index bddc4e8579d2..05f93c7cd07c 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -8,6 +8,7 @@
 
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
+char *invalid_aligned_kern_ptr = (char *)-8;
 
 /*
  * When passing userspace pointers, the error code differs based on arch:
@@ -108,4 +109,61 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
 
+/* Exercise word-load faults and the byte retry at the same address. */
+SEC("syscall")
+__retval(-EFAULT)
+int test_strncasecmp_word_pagefault(void *ctx)
+{
+	return bpf_strncasecmp(invalid_aligned_kern_ptr, "12345678", 8);
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strnchr_word_pagefault(void *ctx)
+{
+	return bpf_strnchr(invalid_aligned_kern_ptr, 8, 'a');
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strrchr_word_pagefault(void *ctx)
+{
+	return bpf_strrchr(invalid_aligned_kern_ptr, 'a');
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strnlen_word_pagefault(void *ctx)
+{
+	return bpf_strnlen(invalid_aligned_kern_ptr, 8);
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strspn_word_pagefault(void *ctx)
+{
+	return bpf_strspn(invalid_aligned_kern_ptr, "a");
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strspn_set_word_pagefault(void *ctx)
+{
+	return bpf_strspn("a", invalid_aligned_kern_ptr);
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strnstr_word_pagefault1(void *ctx)
+{
+	return bpf_strnstr(invalid_aligned_kern_ptr, "12345678", 8);
+}
+
+SEC("syscall")
+__retval(-EFAULT)
+int test_strnstr_word_pagefault2(void *ctx)
+{
+	return bpf_strnstr("12345678", invalid_aligned_kern_ptr, 8);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index f65b1226a81a..ec72410e17a1 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -6,6 +6,11 @@
 #include "errno.h"
 
 char str[] = "hello world";
+char aligned_str[] __aligned(8) = "0123456789abcdef0123456789ABCDEF";
+char unaligned_str[] __aligned(8) = "_0123456789abcdef0123456789ABCDEF";
+char scan_order[] __aligned(8) = { 'a', 'H', '\0', 'H', 'x', 'x', 'x', 'x' };
+char compare_order1[] __aligned(8) = { 'a', 'b', '\0', 'x', 'x', 'x', 'x', 'x' };
+char compare_order2[] __aligned(8) = { 'a', 'b', '\0', 'y', 'y', 'y', 'y', 'y' };
 
 #define __test(retval) SEC("syscall") __success __retval(retval)
 
@@ -60,4 +65,85 @@ __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
 
+/* Exercise aligned word loads, mask ordering, and unaligned prefixes. */
+__test(30) int test_strnchr_word(void *ctx) { return bpf_strnchr(aligned_str, 32, 'E'); }
+
+__test(1) int test_strnchr_word_before_null(void *ctx)
+{
+	return bpf_strnchr(scan_order, sizeof(scan_order), 'H');
+}
+
+__test(-ENOENT) int test_strnchr_word_after_null(void *ctx)
+{
+	return bpf_strnchr(scan_order, sizeof(scan_order), 'x');
+}
+
+__test(2) int test_strchrnul_word_after_null(void *ctx)
+{
+	return bpf_strchrnul(scan_order, 'x');
+}
+
+__test(1) int test_strrchr_word_after_null(void *ctx)
+{
+	return bpf_strrchr(scan_order, 'H');
+}
+
+__test(2) int test_strnlen_word_null(void *ctx)
+{
+	return bpf_strnlen(scan_order, sizeof(scan_order));
+}
+
+__test(32) int test_strlen_word(void *ctx) { return bpf_strlen(aligned_str); }
+
+__test(0) int test_strcmp_word(void *ctx) { return bpf_strcmp(aligned_str, unaligned_str + 1); }
+
+__test(0) int test_strcmp_word_after_null(void *ctx)
+{
+	return bpf_strcmp(compare_order1, compare_order2);
+}
+
+__test(-1) int test_strcmp_word_mismatch(void *ctx)
+{
+	return bpf_strcmp(aligned_str, "0123456789abcdef1123456789abcdef");
+}
+
+__test(32) int test_strspn_word(void *ctx)
+{
+	return bpf_strspn(aligned_str, "0123456789abcdefABCDEF");
+}
+
+__test(0) int test_strspn_word_set_after_null(void *ctx)
+{
+	return bpf_strspn("xx", scan_order);
+}
+
+__test(30) int test_strcspn_word(void *ctx) { return bpf_strcspn(unaligned_str + 1, "E"); }
+
+__test(16) int test_strstr_word(void *ctx) { return bpf_strstr(aligned_str, "0123456789ABCDEF"); }
+
+__test(16) int test_strstr_unaligned(void *ctx)
+{
+	return bpf_strstr(unaligned_str + 1, "0123456789ABCDEF");
+}
+
+__test(15) int test_strcasestr_word(void *ctx)
+{
+	return bpf_strcasestr(aligned_str, "F0123456789ABCDEF");
+}
+
+__test(0) int test_strnstr_word_suffix(void *ctx)
+{
+	return bpf_strnstr(aligned_str, "0123456789abcdef", 16);
+}
+
+__test(-ENOENT) int test_strnstr_word_truncated(void *ctx)
+{
+	return bpf_strnstr(aligned_str, "0123456789abcdef0", 16);
+}
+
+__test(0) int test_strnstr_word_after_null(void *ctx)
+{
+	return bpf_strnstr(compare_order1, compare_order2, sizeof(compare_order1));
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

