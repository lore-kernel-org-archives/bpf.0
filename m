Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444030D419
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184117; cv=none; b=ERd/8qOZb9FVAFzzqAi2W1B8FdGzQUibnuj3ztUqOFr/Yc0ehTwFeaNH3EW4IKwX5HRW/sZWCmjoPYJZ2rbS3ulxFkSFcQIqtEHA6JPEN7C2DT3g4f0767vyCyQKTMjkb2tovO8qOe+KUSSqd19IBFhiA0hWCWU6nEUK01r/MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184117; c=relaxed/simple;
	bh=o18X25zWg3pp3FhVZoTa3lbm2/dv1sV/7C8NZ2n36n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7Ci8571LkpRzGhg8B7CT94N/zD8eK9AjCvnkHSJcEplLk7NYaE7zbyLO27SfgXDD8lsEIiLxWzFE1K7+V9TpbO/xc3sWDIhRIFqR0ysfNtMQXMi6K9ytzq8YGua5/J6o1zFvclEFsEj4nMlw2CPez/+4l5OBYXCq03MR2PgNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vh1ZFg4x; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vh1ZFg4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xs
	+Xd1ImGn0c+LBdQYr0EUqAyMSFGrnAn8hCEzgKceA=; b=Vh1ZFg4xxt6mpnuaWS
	jyhvKYA/2wo5urXyWv4TDZEBkTGn5eB05nukrzPzk3aYxrcrYAQl8rndXsRA0Hz2
	mBce7VwmhPidiAPOo13NpJXYY5KyLGEP2gCawisBzktvaj6YvY8j1CwMv+yM2okj
	3yLJltLhMMVdP7aYULWBANYww=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S5;
	Tue, 23 Jun 2026 11:08:09 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 3/5] selftests/bpf: add tests for bpf_memcmp
Date: Tue, 23 Jun 2026 11:08:00 +0800
Message-Id: <20260623030803.44798-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623030803.44798-1-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFy8XFyxZrWxGryDJr4UXFb_yoW7Cw15pa
	4xuw1avr1rGr1rJ3yxuw1xKa1rXr97tr45Gr1jq3ZFvF1Fvan2qrn29ay3GwnxKrsF9wsI
	vFWrJrW3ZF4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRJxhdUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RlNe2o5+JlHwQAA36

From: Longjun Tang <tanglongjun@kylinos.cn>

Add functional tests for equality, ordering, zero-size, and null-byte
handling. Add negative tests for NULL, user-space, and invalid kernel
pointer arguments.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 .../bpf/progs/string_kfuncs_failure1.c          |  9 +++++++++
 .../selftests/bpf/progs/string_kfuncs_success.c | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index bddc4e8579d2..a85d64605d0e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -9,6 +9,9 @@
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
 
+extern int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
+		      size_t size) __ksym;
+
 /*
  * When passing userspace pointers, the error code differs based on arch:
  *   -ERANGE on arches with non-overlapping address spaces
@@ -53,6 +56,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_memcmp_null1(void *ctx) { return bpf_memcmp(NULL, "x", 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_memcmp_null2(void *ctx) { return bpf_memcmp("x", NULL, 1); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -79,6 +84,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_memcmp_user_ptr1(void *ctx) { return bpf_memcmp(user_ptr, "x", 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_memcmp_user_ptr2(void *ctx) { return bpf_memcmp("x", user_ptr, 1); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -107,5 +114,7 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_memcmp_pagefault1(void *ctx) { return bpf_memcmp(invalid_kern_ptr, "x", 1); }
+SEC("syscall") __retval(-EFAULT) int test_memcmp_pagefault2(void *ctx) { return bpf_memcmp("x", invalid_kern_ptr, 1); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index f65b1226a81a..c2be9edcd282 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -7,6 +7,9 @@
 
 char str[] = "hello world";
 
+extern int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
+		      size_t size) __ksym;
+
 #define __test(retval) SEC("syscall") __success __retval(retval)
 
 /* Functional tests */
@@ -60,4 +63,18 @@ __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
 
+/* bpf_memcmp - functional tests */
+char data1[] = "hello world";
+char data2[] = "hello world";
+char data3[] = "hello worle";
+__test(0) int test_memcmp_eq(void *ctx) { return bpf_memcmp(data1, data2, sizeof(data1)); }
+__test(-1) int test_memcmp_neq_less(void *ctx) { return bpf_memcmp(data1, data3, sizeof(data1)); }
+__test(1) int test_memcmp_neq_greater(void *ctx) { return bpf_memcmp(data3, data1, sizeof(data1)); }
+__test(0) int test_memcmp_size_zero(void *ctx) { return bpf_memcmp(data1, data3, 0); }
+/* memcmp should NOT stop at null byte - compare past '\0' */
+char bin1[] = { 'a', '\0', 'c' };
+char bin2[] = { 'a', '\0', 'd' };
+__test(0) int test_memcmp_null_byte_eq(void *ctx) { return bpf_memcmp(bin1, bin1, sizeof(bin1)); }
+__test(-1) int test_memcmp_null_byte_neq(void *ctx) { return bpf_memcmp(bin1, bin2, sizeof(bin1)); }
+
 char _license[] SEC("license") = "GPL";
-- 
2.25.1

