Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332413CF1E1;
	Mon, 20 Jul 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536502; cv=none; b=aFOAOK+xVAeRtE/UzQ0Io3I8DacUIhUg0YVnx/DxH0RQr4LNrpumpg7wkG6WVPJtqHo3R7QceH+rGY6iDHcVqL3GKoTGO5F/f9PdUrvgGnPodBRX1j+XkJ0E8ASvI80FFkQN3NXkvraI1KPSimKFjY528ZrFaha4UqNUPBCprjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536502; c=relaxed/simple;
	bh=1ihwXgC1+TwrpRm8xRBHUYMo7NQ3ihSZHT60cDf9YC8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=W5LeQdHq3jHbh5CaYn1t6wkNoAMPtJQ3t/OV5P7VL3D6w3Cu0AX3KhJ8b5vpq18SoFiLDF1AhjpqXRjuCvrlnPMkIMkL0lR9YuHWQix+g61ESo7BXZYha36f8AG7ze98+aS8jlBW8rTZ280eKrnZIIei4cEXp6ufOpssBcXaECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HC5V4IOQ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HC5V4IOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784536494;
	bh=nAuqGeYR4eAYyIScHY5xN4HyE1zBEZDUsDnSayc7Y+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HC5V4IOQKZSywkBZsyQqxePBjdBPxUZW20f1Stsb8RRP2QRwZ6BiSQnqE6WJxqEMM
	 MywrDtjmGHIhQZb49uL9ar2i8pBQg2yF4HaiqkDf6uv8nztJmxDeY2DB2wcxeVKaWD
	 n9dYhsomimHEKMaJ+4iP1o6WA8INxhTEGZOFbULE=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8A42167D; Mon, 20 Jul 2026 16:34:36 +0800
X-QQ-mid: xmsmtpt1784536486tmjsgx8mf
Message-ID: <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
X-QQ-XMAILINFO: MXU7emneNmB7y9QSqVfwEBtpJweH6BuI0vt2flwbv8Tn9ttPKhx7NEkU4jUVvV
	 6ri0FwxhSlOujAlEkiYK77lv7++nCXfaO9NdiTHrsdnZYs6jAAqfpKlHi+A4JMiECzRHdXjCXkCp
	 fnTNdosXqmocqFjYdvaLTc6o7LQy7u3K5C3+8dP0GBuHU4idcfTiNFg40siGiNy7VaGLkofKB7MK
	 OPkNyGsm3E9Nw82jVtz8tO8CmlTw/akg1oDtqhTbj3uoumf0FdO/TDhFVK8C8uwZA8kyMqfcRgrc
	 Xal3aB4a+xjNsjmyYP5Jj9BrvV7hm1MM/Jlm+j6KzqpN8yBpKdbzkl1TdrWMTb3CVz5nuqENmG0U
	 1IuNAwARBjoEbi6VpWYYvgeAgz18GcwgnygM3e8iPw6wtkO75lHw1+fYuT8R4adulsnJ3MY75J9+
	 bB+h3DYPNcWQ2rfXGM9VFg3+LBEawg8PhK56FFNa2P2s6RxAo7btTf5twl7Eupx59c82GPzO/UUv
	 kTtDdMwIKgIcakB4lsCCjVakUldEke/J4ZHhHyYmD2ACq/1XCwFVEvUeNYBmKmbtQSzokbqOqys3
	 FgiexX0Am9/2vFhGhK4o+IHUIC/nhFBBogAnanFM9MuJQK8nhCbX3ZoVY9PBWUy63p8wKU9zGmcs
	 fAWcEu8IIn5qjp9wOMTC/LzUCAr0UGJQkgPS+As9h+j1QleN8TI2GEKwPbEnnOoaY0PGPD+HuWOj
	 cN3IPySjQaogHihB7zJlqGzQXAEynVh1FkritpvIX3A9Ur+navQqK02L09qgGTlJAE0+m/8Q07te
	 Rqvk4eNjHH3dBPppeG+PZp1ATOGdtBmhYeIX6tpQhWi4t0QgAHSmNEZdpy1mpUkvnqs+n2LquXpK
	 XsqwfQbpJrwX/LZqIEVvQhGSbGMp7SnMHvs/eWoNi8gKE3oYZhpNkcDWqvNObbAdg+4Ai1yG8pfd
	 sU66JdOiQHhoFX0KzQRwWoupcYZPMXddpb7e66gzmz4NR0zvFre/lVvqItPQwtnqpkKdk6WdLjUC
	 BfF58InzWC20YgIWEO8VF4dnULSF+Lq/zJ+p69abeBQMpVT5DFvYvtcZ3eUASQdHD3LVFBNVBdGE
	 al2Xxlq6iRjst4vyuVNM2TaOp2UUXRwegz21IiwJ+vrB6PlHQ=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
Date: Mon, 20 Jul 2026 16:34:10 +0800
X-OQ-MSGID: <2bff2c3cacdddd3652b81b92a532b87fe1b4500c.1784536164.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784536164.git.rtoax@foxmail.com>
References: <cover.1784536164.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add tests for new kfuncs bpf_strcat() and bpf_strncat().

And remove extra whitespaces in selftests string_kfuncs_failure1.c.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 53 +++++++++++--------
 .../bpf/progs/string_kfuncs_failure2.c        |  3 ++
 .../bpf/progs/string_kfuncs_success.c         | 10 ++++
 4 files changed, 47 insertions(+), 21 deletions(-)

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
index bddc4e8579d2..d432d4990f80 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -8,6 +8,7 @@
 
 char *user_ptr = (char *)1;
 char *invalid_kern_ptr = (char *)-1;
+char kern_buf[32] = { "hello" };
 
 /*
  * When passing userspace pointers, the error code differs based on arch:
@@ -30,29 +31,31 @@ char *invalid_kern_ptr = (char *)-1;
 
 /* Passing NULL to string kfuncs (treated as a userspace ptr) */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
 SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strrchr_null(void *ctx) { return bpf_strrchr(NULL, 'a'); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strlen_null(void *ctx) { return bpf_strlen(NULL); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strnlen_null(void *ctx) { return bpf_strnlen(NULL, 1); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null1(void *ctx) { return bpf_strspn(NULL, "hello"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null2(void *ctx) { return bpf_strspn("hello", NULL); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null1(void *ctx) { return bpf_strcspn(NULL, "hello"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null2(void *ctx) { return bpf_strcspn("hello", NULL); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null1(void *ctx) { return bpf_strstr(NULL, "hello"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null2(void *ctx) { return bpf_strstr("hello", NULL); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasestr_null1(void *ctx) { return bpf_strcasestr(NULL, "hello"); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasestr_null2(void *ctx) { return bpf_strcasestr("hello", NULL); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return bpf_strnstr(NULL, "hello", 1); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
-SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strrchr_null(void *ctx) { return bpf_strrchr(NULL, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strlen_null(void *ctx) { return bpf_strlen(NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strnlen_null(void *ctx) { return bpf_strnlen(NULL, 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strspn_null1(void *ctx) { return bpf_strspn(NULL, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strspn_null2(void *ctx) { return bpf_strspn("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcspn_null1(void *ctx) { return bpf_strcspn(NULL, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcspn_null2(void *ctx) { return bpf_strcspn("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strstr_null1(void *ctx) { return bpf_strstr(NULL, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strstr_null2(void *ctx) { return bpf_strstr("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcasestr_null1(void *ctx) { return bpf_strcasestr(NULL, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcasestr_null2(void *ctx) { return bpf_strcasestr("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return bpf_strnstr(NULL, "hello", 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -79,6 +82,10 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, kern_buf); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr1(void *ctx) { return bpf_strncat(user_ptr, 1, kern_buf, 2); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), user_ptr, 1); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -107,5 +114,9 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
 SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault1(void *ctx) { return bpf_strcat(invalid_kern_ptr, 1, kern_buf); }
+SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault1(void *ctx) { return bpf_strncat(invalid_kern_ptr, 1, kern_buf, 2); }
+SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), invalid_kern_ptr, 2); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 412c53b87b18..2dbd1349689e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -5,6 +5,7 @@
 #include <linux/limits.h>
 
 char long_str[XATTR_SIZE_MAX + 1];
+char str[] = "hello";
 
 SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
 SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
@@ -23,5 +24,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
 SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
 SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
 SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
+SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), str); }
+SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat(long_str, sizeof(long_str), str, 3); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index f65b1226a81a..71fbbe97b4c5 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -59,5 +59,15 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
+__test(0) int test_strcat_success(void *ctx) {
+	char buf[32] = "hello";
+	bpf_strcat(buf, sizeof(buf), str);
+	return bpf_strcmp(buf, "hellohello world");
+}
+__test(8) int test_strncat_success(void *ctx) {
+	char buf[32] = "hello";
+	bpf_strncat(buf, sizeof(buf), str, 3);
+	return bpf_strcmp(buf, "hellohe");
+}
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

