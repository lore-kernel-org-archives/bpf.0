Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6D3B5304
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293831; cv=none; b=iWprR/o5wBNBST7HXuSEX7dDKL0a52dsrqg7v/FSZBkDA8ep/XMdDhfby95gFXCxK4+4HGjmj9cIVwYPElACVwRuqrt6A2+usBLylj+0zMfqKVTassLhX5HlBOcdtkW6SJ0qP7HMxJmTdEs4e2SMwbfejvYVWl1KFbH/x7xIwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293831; c=relaxed/simple;
	bh=JMATW+7F5MDYpbVk6FZoRREjI7kQJYW6jFToaCEVLHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlxATz65be9gQXap7kQ5TgFgzwPNk7inBhBFGbJ2FukTA+DzLAHIr6dHElk++iTgBJeZWVGkdDhOZbX6QIKAdVytbZNcOpMRiofoNSYNui7UCrnyakw52qpYwninhhvDNN5HUFdrqJy7iryndEHLs0kN8D9z1zrwiCgK2EWUv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TnQc0jyq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TnQc0jyq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZH
	MILXDP6WuDSguTj9ddFWGsT0nD3HoLmhZreiNCc3w=; b=TnQc0jyqX7OkBVWe5H
	FddS7TRueRfNICkRa+DCF7BwRXab51P5m+mDeP+yUi0A9Hcr1yrzwzMSjMecukIr
	+Ujv6N7Rtjdo3AMsP0dQ28/lUCQ+DKtltZWzKtKMN6nfXr8EIjbTJK+UY8IRebbY
	3aEI4DUDH1YGH2nBdoFVFSp0U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3lwonpTtqwoMPFQ--.6915S7;
	Wed, 24 Jun 2026 17:36:43 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for bpf_strpbrk
Date: Wed, 24 Jun 2026 17:36:38 +0800
Message-Id: <20260624093638.117062-6-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624093638.117062-1-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lwonpTtqwoMPFQ--.6915S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw15Cw4ktry3try8Gw1kGrg_yoWxtFW3pF
	y8Cw1j9r4rGr4rJayxZw17Ka1rWw1vvr45Cw1jvas0v3WrXa9Fqrn7uay3Jw13KrsI9FsI
	vrW0qrW3ur4UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_0eH-UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gvcC2o7pSu8GwAA3G

From: Longjun Tang <tanglongjun@kylinos.cn>

Add functional tests for first-match, multiple-match, not-found, and
empty-accept cases. Add negative tests for NULL, user-space, and
invalid kernel pointer arguments.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c    | 2 ++
 .../testing/selftests/bpf/progs/string_kfuncs_failure1.c  | 7 +++++++
 .../testing/selftests/bpf/progs/string_kfuncs_failure2.c  | 2 ++
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 8 ++++++++
 4 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 300032a19445..959ff37110a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -20,6 +20,8 @@ static const char * const test_cases[] = {
 	"strspn_accept",
 	"strcspn_str",
 	"strcspn_reject",
+		"strpbrk_str",
+		"strpbrk_accept",
 	"strstr",
 	"strcasestr",
 	"strnstr",
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
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 412c53b87b18..d3b978e453bd 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -19,6 +19,8 @@ SEC("syscall") int test_strspn_str_too_long(void *ctx) { return bpf_strspn(long_
 SEC("syscall") int test_strspn_accept_too_long(void *ctx) { return bpf_strspn("b", long_str); }
 SEC("syscall") int test_strcspn_str_too_long(void *ctx) { return bpf_strcspn(long_str, "b"); }
 SEC("syscall") int test_strcspn_reject_too_long(void *ctx) { return bpf_strcspn("b", long_str); }
+SEC("syscall") int test_strpbrk_str_too_long(void *ctx) { return bpf_strpbrk(long_str, "z"); }
+SEC("syscall") int test_strpbrk_accept_too_long(void *ctx) { return bpf_strpbrk("b", long_str); }
 SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str, "hello"); }
 SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
 SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index c2be9edcd282..25b8c897da54 100644
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
+__test(2) int test_strpbrk_found_multiple(void *ctx) { return bpf_strpbrk(str, "l"); }
+__test(-ENOENT) int test_strpbrk_notfound(void *ctx) { return bpf_strpbrk(str, "xyz"); }
+__test(-ENOENT) int test_strpbrk_empty_accept(void *ctx) { return bpf_strpbrk(str, ""); }
+
 /* bpf_memcmp - functional tests */
 char data1[] = "hello world";
 char data2[] = "hello world";
-- 
2.25.1

