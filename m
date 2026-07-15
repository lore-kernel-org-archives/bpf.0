Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09036E46F;
	Wed, 15 Jul 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078904; cv=none; b=TR52ABCdOz85qKRzB2Jrqwoq9/UEDFu0lWFBk8OfF7yhU95KvH66jTk4fgH0Yub7/MpvaExe2DiIK25zVw6FHVw+JmtnnbXiQ4xhIVhvaXPhjmsZjNOiZS6saMZHwtJ326p+terNAyz5gN93JMoOf46I8tBxdEjiwUpnqUA0c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078904; c=relaxed/simple;
	bh=20atOgI0T765b6W6HwUmO+KNzDuKFwW+2nLs95EBFRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CbMs1SpQ9XlKNYg6gXTTjNFF9pht8wV+AZZQMDrfPx5FWLNHBnowwVmDyLeNdNIKUV/JqerKEXMXMrdDT9Z9WC6vrFpPIQjMqaTMrkGA3WG7lqdwtI2p0wxoVXg0QQ0QMbWwSqxxodwbbZq/nH+W2Bnq1BTciRM42qcB4JSpbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rtR0nZ4M; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rtR0nZ4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784078898;
	bh=kG44LITixTvxuVq0CrIOkkCG4aWgKxeoPMP+cfbAv9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rtR0nZ4MxLXhxRvVlHnzV5yFJEvVfjF1u0WgwGEnsFE3XDsdU70iXjcECjfO26Qdj
	 qm6yD/L2jlCsHIJP77oodLDhADivcvcYoZ3NzllocMz9Rl+HG8BfIUTazZCHiOZFqZ
	 u1UiAf5aKm+NPh049MeDqT6FH4mGQ9Zlxu9yFq5c=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6FB10817; Wed, 15 Jul 2026 09:27:59 +0800
X-QQ-mid: xmsmtpt1784078889t83qiqxay
Message-ID: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ+X/Z9ZVknGd+tpIkFAv3GJd8mvgtvtyAUbwcBvWuQRBmgsVINL
	 H+qJdCxex+IOhzs/3dq/6QhDY94gtKdm27o2w6cC1Jiy0YelwHnwdCUSrKl+RGy7y9FIDKvoOFu0
	 nHJSdHviSZUaVgjrI+Duaj1O3aOFkQ5CRZlrt+ETU1DmWtb9B7GLF/nUY1G7+0s/NowGxZ6PYcA5
	 4jqAaV4u+hUnDh/EoRFmvXWQK4UcyjupxMbyINW0naftEHsE8lejvjD9J26ICpQe/UTTGd6z5KiN
	 ZHpuIZTmLCF1Cm6qYVnXs45SUz2KcLArQ7nYKJg+Mk2vdFmu4dGlzJHVD/ngevU5ptVcpYF8370W
	 CXGIjH1hdvFNmabNcYVdebDyasuWCwR4OVp8bQQWEblrLYqHauLR2zz+hiBN9dXjqJrm3EvJuOyj
	 V3KPDgxtjmQv6v7tE5BA4B/TlAp+zCWxfeOQ6Ps6y2YmgB4Fw9EsldIw3LjBZyVso1y3KvQ+8280
	 y+4JDiCaJ9F/3iFAxpCStem+2C4CUa04Do6TzZU9m+EXc0Mc4tvblzMuP1VqOedZItI9iRN8n98+
	 q+tlba7nDT6yNUA93xAOOve38CH5rafvzhmHGEkVU1NAbfUJiz92ipZh4icSCjpYpzhh3VB/btrk
	 GDE5jFZbQOcCJqNHOgZMr3t2omgbZa30v2HaWUMTrZAit2iWTsJB2cK+kQ0R55T/667NYsLwCQpB
	 V1xEcMWhPygRmq9Q7sRr2dSeDOTQcOlYypXq/AI3LLgYWrCNC+g6wRg0Jy/l5tINjXZ645f2XDEr
	 ZmTNGgF86ftgZvOtXi4pCb5ObX8ch9rSxh9J158YH1tT8VcLIs/uLtaJ93szilrpcnKs19ToC0lx
	 yHm8R3u6LGf+AZkSXEkuGoound2f5/QC3cpDapl3nlVO4OJopllwc73Z0VsP9pBM6c2IFqTEUtpB
	 vlYG2v6aWzg3G/sZlkMRUf2IibHxIDKxSTkE1nVEcOE7ySefo3sqPgZkTPkFg6GUpdQ3ejqcoE0R
	 KHpAVCvtGA0pJJBZ/oqYVBR2sNvJELPManiy1N5TutkEF1FTwPbrdfGLxONG/B61/5NYXTQTdQlI
	 Je54vfWdF+hYXNC7M=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
Date: Wed, 15 Jul 2026 09:27:27 +0800
X-OQ-MSGID: <7e219bf4db2380e33b13c5134b484e58dca80e8f.1784078494.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784078494.git.rtoax@foxmail.com>
References: <cover.1784078494.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add tests for new kfuncs bpf_strcat() and bpf_strncat().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c        |  2 ++
 .../selftests/bpf/progs/string_kfuncs_failure1.c    | 13 +++++++++++++
 .../selftests/bpf/progs/string_kfuncs_failure2.c    |  2 ++
 .../selftests/bpf/progs/string_kfuncs_success.c     |  3 +++
 4 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 300032a19445..460567ef622a 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -24,6 +24,8 @@ static const char * const test_cases[] = {
 	"strcasestr",
 	"strnstr",
 	"strncasestr",
+	"strcat",
+	"strncat",
 };
 
 void run_too_long_tests(void)
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index bddc4e8579d2..29bc7eabbb6a 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -8,6 +8,7 @@
 
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
+char kern_buf[32] = { "hello" };
 
 /*
  * When passing userspace pointers, the error code differs based on arch:
@@ -53,6 +54,10 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(NULL, 6, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(NULL, 6, "hello", 2); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -79,6 +84,10 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr1(void *ctx) { return bpf_strncat(user_ptr, 1, "hello", 2); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), user_ptr, 1); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -107,5 +116,9 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault1(void *ctx) { return bpf_strcat(invalid_kern_ptr, 1, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault1(void *ctx) { return bpf_strncat(invalid_kern_ptr, 1, "hello", 2); }
+SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), invalid_kern_ptr, 2); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 412c53b87b18..38f0a5f326b5 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -23,5 +23,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
 SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
 SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
 SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
+SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), "hello"); }
+SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat(long_str, sizeof(long_str), "hello", 3); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index f65b1226a81a..93996b0e9595 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -6,6 +6,7 @@
 #include "errno.h"
 
 char str[] = "hello world";
+char buf[32] = "hello";
 
 #define __test(retval) SEC("syscall") __success __retval(retval)
 
@@ -59,5 +60,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
+__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf, sizeof(buf), "world"); }
+__test(13) int test_strncat_success(void *ctx) { return bpf_strncat(buf, sizeof(buf), "world", 3); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

