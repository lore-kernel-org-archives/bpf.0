Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265730CD92
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184118; cv=none; b=WOF/Jj9CsohYs9IZTmmQX6Wd6v4AfPc4h9m/2icpmHzLN7NxQiqqClKStgawydM+SM6ZdejhQzBeaUoSYcb3sWsrLqXntcIWWlv+kl/A7VUorl4Srytlt+XqniieZPHIJPPU+FEE5V1RIMEUnoNWZIDXLrTH6cDkx4Z9Y/KA6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184118; c=relaxed/simple;
	bh=3qnFVkzYY9wk9GyOTEjoqNns2plOekMPpECXH0WXzaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INAw+07jY4qqm+8G8jke4HSnCqJPvN3ushQdZmMNrMcYx00ecHJFyLpbfXT+lzAyBAjHv6MvVixYidzxLp3sZglA/3rNCxTkthyz/j6o0HFxlmJV8rj3QkVj5low8jCS/KpVSwMbVaILiCRahvOigdAvujugXgq4aHCKO01T8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hXzt0+ly; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hXzt0+ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H5
	l4Pzdrt/aKAhB+t6skc54WinHKFreAdr7uN0CUtA0=; b=hXzt0+lyFQjG7lzIEU
	5WKc96xUqh1SMKM+/D+QGai4ZxL1Nd6aJtfpaZ+SWebJuy55FGFdpR/SABO6scN4
	AzuJ8RNMRNXW9LpeFI7RTBzzPCGUPnhJmLC0putKd6sScaaNOJPAFNq55n4eqOba
	73IYcFKu0FN+k2JUUFXAlOmqU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S7;
	Tue, 23 Jun 2026 11:08:10 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: add tests for bpf_strpbrk
Date: Tue, 23 Jun 2026 11:08:02 +0800
Message-Id: <20260623030803.44798-6-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1DKFyUZF1fKFy5Kr1xZrb_yoW7Xryrp3
	48Cw1j9r1rGr4rJ3yxuw1xKa1rWrn2qr45Gr1jv3Z0v3Z5ZanFqrn7uay5Jw13GrsI9FsI
	vFZYgrW3Zr4UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMXdjXUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hpNe2o5+Jo7ewAA3-

From: Longjun Tang <tanglongjun@kylinos.cn>

Add functional tests for first-match, multiple-match, not-found, and
empty-accept cases. Add negative tests for NULL, user-space, and
invalid kernel pointer arguments.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 .../testing/selftests/bpf/progs/string_kfuncs_failure1.c  | 7 +++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index a85d64605d0e..e67fe9700e59 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -9,6 +9,7 @@
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
 
+extern int bpf_strpbrk(const char *s__ign, const char *accept__ign) __ksym;
 extern int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
 		      size_t size) __ksym;
 
@@ -58,6 +59,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { re
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_memcmp_null1(void *ctx) { return bpf_memcmp(NULL, "x", 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_memcmp_null2(void *ctx) { return bpf_memcmp("x", NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strpbrk_null1(void *ctx) { return bpf_strpbrk(NULL, "x"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strpbrk_null2(void *ctx) { return bpf_strpbrk("x", NULL); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -86,6 +89,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx)
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_memcmp_user_ptr1(void *ctx) { return bpf_memcmp(user_ptr, "x", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_memcmp_user_ptr2(void *ctx) { return bpf_memcmp("x", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strpbrk_user_ptr1(void *ctx) { return bpf_strpbrk(user_ptr, "x"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strpbrk_user_ptr2(void *ctx) { return bpf_strpbrk("x", user_ptr); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -116,5 +121,7 @@ SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { re
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
 SEC("syscall") __retval(-EFAULT) int test_memcmp_pagefault1(void *ctx) { return bpf_memcmp(invalid_kern_ptr, "x", 1); }
 SEC("syscall") __retval(-EFAULT) int test_memcmp_pagefault2(void *ctx) { return bpf_memcmp("x", invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_strpbrk_pagefault1(void *ctx) { return bpf_strpbrk(invalid_kern_ptr, "x"); }
+SEC("syscall") __retval(-EFAULT) int test_strpbrk_pagefault2(void *ctx) { return bpf_strpbrk("x", invalid_kern_ptr); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index c2be9edcd282..e67b80ab3cd2 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -7,6 +7,7 @@
 
 char str[] = "hello world";
 
+extern int bpf_strpbrk(const char *s__ign, const char *accept__ign) __ksym;
 extern int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
 		      size_t size) __ksym;
 
@@ -63,6 +64,13 @@ __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
 
+/* bpf_strpbrk - functional tests */
+__test(0) int test_strpbrk_found_first(void *ctx) { return bpf_strpbrk(str, "h"); }
+__test(4) int test_strpbrk_found_middle(void *ctx) { return bpf_strpbrk(str, "ow"); }
+__test(6) int test_strpbrk_found_multiple(void *ctx) { return bpf_strpbrk(str, "w"); }
+__test(-ENOENT) int test_strpbrk_notfound(void *ctx) { return bpf_strpbrk(str, "xyz"); }
+__test(-ENOENT) int test_strpbrk_empty_accept(void *ctx) { return bpf_strpbrk(str, ""); }
+
 /* bpf_memcmp - functional tests */
 char data1[] = "hello world";
 char data2[] = "hello world";
-- 
2.25.1

