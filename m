Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73237A82E;
	Thu, 16 Jul 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194553; cv=none; b=Iw46JM+R5gDzQisPoZ018YCaOCz3b3vRz2+Y30rUqcJKm3J43cn5giqO6AM1Up4G7gylyMV7BHniYgnwLIfRP6wrtnP8g9aQj2yuQIyLr5AOnPDN8GUGDxWpZ4UYfa1g52Of2lsSPAAaRntPDh3n+Xrg1nwmH002zB2xqiNTrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194553; c=relaxed/simple;
	bh=T3Re0X4PUtj9OrPVH16xP1VR4x6mVOJBeH8N4Lt0q3w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EVPHXXHj+nQYqFIMKRZdJrXieygqOwWkiGqqs9vQRotdk3q4x+3apuzn2RNls+QvtG8NXt8s5Jbn7Yo2ZhSi/efiVfnXAkts+9Izy9vB7sFdvO7WXxaz4MRdHJ23Ay4OtcelPJfd3hSGPoqqlY9tEEUOQLCvjh5HodzQAJFLzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=h9R2Hekq; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="h9R2Hekq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784194546;
	bh=PGEgglPcK7GG7eadaVjVRffpBLOT8zLPQv/ALm1hlB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9R2HekqCep4KMBorbXdidnqBstSUYYopYhwrBZb4QrU46TUhJ4rqhkuJ6l3hghYe
	 U+ICXSo9EvHcBl4Ebjzzebd9vX3WAgTqIiEk0SX76OsvpHOBWaJaFXFIJVq6tgEhaZ
	 8WgZT3aIqj66KeNaig0srhp20kLnFOGOYOgAxFXU=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8CFB3470; Thu, 16 Jul 2026 17:35:15 +0800
X-QQ-mid: xmsmtpt1784194527tw9oyy7vf
Message-ID: <tencent_C7A5E27560540491DBE052682ACBE1F24405@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XH7TUhcGZChNh6AEE2jJIdaIrT2jK/mpig/oO1iRkjPTfFr2XTQ
	 SOG1uDmzjjdaRvWWwi7d1S6im2H/MfdqE2geuhJRFlVSE9/xs3o5s661p25EGnY57Ttarv13EJk+
	 XEGxnIPSpcvipua9tiLSlfM8WF0MpX/wimdf0XGZsZAH8HGqcZ2xNC0bXmaRjYEbQt0hBUePWCiV
	 DokdhsNIHu2TG1tDTSgYVasvOVyYeoZ05lS6D/85/Rb71BLK0DfiuSkIXebtnNR3n+TCAChpXU2t
	 HOuZb7j4vpgsjSyPxr8PcjyABYV/fqb5FLhPmzvFuaUACN0shE36fIQcENKmBmcQdqs1jB3ktQu2
	 rbXU3XxzZ1gzvWb05LphHyDb2fvtlHt6zi6tdQRh/6BaGTDO8L0dVo37wwz4rgbsdHImRPoNcwpQ
	 nFXcD4apdRPPjWHrcdMYMNLtzRqKzmSmfs9UmU4vfdlleMf3aUWL06HH8h0hyNsKwHywk8NEDrw1
	 sJSy2Si0V3K6cjn4S0Ldbt7RjEiisPmTFXOZ/JKIM4RXT5f4i04/OxLx7l4YqLx1vxKnAjzhOzM4
	 Fosgw1O6Ezc4/ZqK6ONTNErKO6dvNf0qThHs/fNqRm2sKlayLDlopXc0TiNJevPXsC06CkLJWAEi
	 h0pipm6NKGJ/qbutn0F50h4VsJmwUuGN5siCHRf99U/mkrvDQ1xECY18Y/4h7Rgbr0+T1KOjnT9H
	 NVXU7mIUtTff1znPZEGq+qh5MrE9RCFFd4yNtWwM2LfeZszD2ueUtwe8C2k04caVOfh4OP8JF/7E
	 SMeFyJIs4+uA4ZcLhc1JIVTK0dQL3FDol5zs9R/VPsm6rDOZXNWQyWUwA9t6eTrUuPVBcf5iY3DI
	 r4P35ZGVtHA1WzS8CQRZLkgvQJiNa0I7G+e2DPrO1Tf/Se1gRfU6vt99OTkIMMlvSyI4JAUN1ygD
	 M8Z4Hc0tNzHsmSEaSk6rpi1VhqjTx5Fq8xHre9CjbPijoB+fPQRza9wy/ze9yX5eDPpoH16caJkx
	 hANCIlYNwKb95Hdx4UTsAg3NyilfuNPc5Mhx6ouF8JsBWA5vfG972uzSZ3iMQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
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
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
Date: Thu, 16 Jul 2026 17:34:51 +0800
X-OQ-MSGID: <048a85428cda194270080829056db872a6113233.1784194024.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784194024.git.rtoax@foxmail.com>
References: <cover.1784194024.git.rtoax@foxmail.com>
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
 .../testing/selftests/bpf/prog_tests/string_kfuncs.c  |  2 ++
 .../selftests/bpf/progs/string_kfuncs_failure1.c      | 11 +++++++++++
 .../selftests/bpf/progs/string_kfuncs_failure2.c      |  2 ++
 .../selftests/bpf/progs/string_kfuncs_success.c       |  4 ++++
 4 files changed, 19 insertions(+)

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
index bddc4e8579d2..973a6ba643d4 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -8,6 +8,7 @@
 
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
+char kern_buf[32] = { "hello" };
 
 /*
  * When passing userspace pointers, the error code differs based on arch:
@@ -53,6 +54,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -79,6 +82,10 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr1(void *ctx) { return bpf_strncat(user_ptr, 1, "hello", 2); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), user_ptr, 1); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -107,5 +114,9 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
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
index f65b1226a81a..b24456ad3d43 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -6,6 +6,8 @@
 #include "errno.h"
 
 char str[] = "hello world";
+char buf1[32] = "hello";
+char buf2[32] = "hello";
 
 #define __test(retval) SEC("syscall") __success __retval(retval)
 
@@ -59,5 +61,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
+__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf1, sizeof(buf1), "world"); }
+__test(8) int test_strncat_success(void *ctx) { return bpf_strncat(buf2, sizeof(buf2), "world", 3); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

