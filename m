Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B135F615;
	Tue, 14 Jul 2026 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021826; cv=none; b=XtZ5iiyufPAw9dvoYNCFrNEUj7bk1uWG3UxSzkkTuGBHw3M116TkAu6KFr3SYnSHN5yPfRTpKa7Eqdk+YN89Llnik3Np3CkFUql3cBpQXwpgSMibynsCFlN91eS/8mwHNOTMimrheBx/jz9eVhHH5D5bidh0Ps5jTJpBK8lOeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021826; c=relaxed/simple;
	bh=Cru6fDZogsABYZJ+P7BSvoByrQ+uu09YAV2JQuIR7U8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GwMn+RhXCybRza8FfbPmCQPD1r78d0K7AvMtAXfslF2tM8wLyoppP+Xpum2Pnu0Xj92kHtKRp30czrz/XjXFyhYRJyLuTxNJoMkbHRSGyvFaPC3ielJCVcW9O212nQkLeAvw70ab1w8P8SV+yAheUzkfNKH3vf2huH+OEw5XUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=zF+W1TZo; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zF+W1TZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784021816;
	bh=4mWVHUITD2rsW66ieYeCmmssDwQzf0+u/pXs2tYU2E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zF+W1TZoMqu6NNKOhI1Xq9LOOTI0Hie5oLEF5JxyCODiL2R2A1ZP2qepgtW7DvwHm
	 IqtkJMaRp02uGf682iTAf/UH1u1ZjcRu6mnMuMgdTgyr3E24KIB3UxtboOh50/EQe+
	 x5OcFseLIJciiO0796hGY5gl1al2d9v1o9EQNNi8=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 924940A8; Tue, 14 Jul 2026 17:36:36 +0800
X-QQ-mid: xmsmtpt1784021807tnwse8ma3
Message-ID: <tencent_FB0E71C06045E8278BE9B254A5E7756D7405@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uULkKPqNIOFj1owK3Fjd59PLUfDjOYkrwXHmKgpGhPWuZabLXAB
	 BQbGFVcwNyDCaTa+cIaHOybvJi6YTO+yuG8XOpgNKAAY23Lbtn4vQt/zwEaCOe8touJgt9lTJAgn
	 8/L13KM815mVDQkNX9K7DnGGqnqH/x5F0Ku+sUrZ1pAv50PLcplWkKVqbMS7gHZ+qqqCOEUKNRas
	 Y3PUcni4Z6Yifz6AvekJyot2YxBsbu+Xlqx9WrbW9n7EvzIrU8akcLfGhilrxTY9901+lnsBSRua
	 HXPWhLuNwH4XmSziBB9MOu1oRAgnqbgd61EPSIkLB1N1bLBKVNdtRCsZBvv9KQ2FdkI3nInGZQED
	 q6URmiZIESPFVDlZ4GNlKiSjlVro47jW2dcM4gkgQ3mdBIck74E3V5jm8fxdzjyEBO6t2Yz13cCg
	 v7+ZjYGvctOKu0dMsfo2FsgU4oh637yMgKKKfqsWpbs/+pfMm2eAeG5EchF7BNwi6hx4deWZoJqL
	 pl6Y38ojanZBFAoG3AXDhlUMHYsmabO/ALNCzqiZkjYg2dKZXC2qmMLrIetQd82RwQ3udE9rjFqK
	 5YZrNNqYLzXQR2ujRTY5Bdh2HtmCWHcElTHRLMiyTNAQjlAlIDHpU+cSTxvGehhwJg7ZqxZP4idc
	 cBrZB7fSuHSBPa/9p4pyi68fkmEiH54tv9Jfa9a4IdiAPeZrfS3dYYMyEKjddWoKbuskgvx2ekD3
	 Tz7H7KNR6OR9hyYHBbdLV+xUdXsODyPEQUhYB5hkXDMBkgIJXw9OMsgAhS/0XtJXJjNtS95OxjKJ
	 YJBhS4Wm4J2IBcpV5cIyc17/Z+SFqOD2YKnjeosGtq6wMzgWB1ZU77UckaqTqn5SMn/al9vAGPxi
	 HA1agm7ngp/QRz7iwbR0iiQU7zphqRgwlZvkeVE/TFchkscmhBBGwTE4qPFKZkSaiNc/GsHrXPdV
	 1Sl8oGWxsw9aOA9xQ8m0p26lo32ppY4gEnGLEf/yU2/6MC0S7Lg/vyeLo0huUzax52kXrHW8byAi
	 Xz1fTxgyM441K9G5if0L46SHohjbz9egLAo1kAh6HV6Tjl/9mb
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners & Infrastructure)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
Date: Tue, 14 Jul 2026 17:36:00 +0800
X-OQ-MSGID: <2f5bc28625860c8215acde8ce06fd423aec2b189.1784021302.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784021302.git.rongtao@cestc.cn>
References: <cover.1784021302.git.rongtao@cestc.cn>
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
index f65b1226a81a..b45e559a3178 100644
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
+__test(5) int test_strcat_success(void *ctx) { return bpf_strcat(buf, sizeof(buf), "world"); }
+__test(3) int test_strncat_success(void *ctx) { return bpf_strncat(buf, sizeof(buf), "world", 3); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

