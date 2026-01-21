Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B930B521
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966428; cv=none; b=NVldTM3Hd+q446j0TVyMQbzclN/SlaKuB9/lauDGTn8x48sLWk90RbVx/4y4jNUcqKG5WLXEhSXOmMlmif7uV9Fuz+czjImUYUt3WgejrlkrPAWaj03Xooj52iv+I4wmuqUZ2GJmBdrdYoYkoUP5ODKHyjkf3tgPBhBssLaCclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966428; c=relaxed/simple;
	bh=Gy4xUXnBoqdSTAXTpU3rS++3ajR7mPlPVaNu+6cjiSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxnZdGjiyMeaYCISAmoDyi9pQQrGzrqK+ea5mes6Rzf8QH67EcL0ehMlYAiJIDMXVPI278SqDCM052rbFvv8gAh5uQ6Muh+sd+mkBlNV76lEKwdAXYWRw9v5AmLNl0ndywlFayqaz0rQGfRauHrvu2rVglHUzTiLgUYlDC6oInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: AB1PchreQBiMNebfp/4NmA==
X-CSE-MsgGUID: cFNTSXo2T9qc9Trfz9LNGg==
X-IPAS-Result: =?us-ascii?q?A2GNAgB5SHBp/zYImYJaglmCV4JbtGmBfwYJAQEBAQEBA?=
 =?us-ascii?q?QEBWgQBAYUHAo0DJzUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQICgR2GCVOGYwYyAUYQUVYZgwKCdLEDgQHdei1UgSYBCxQBgTiNU?=
 =?us-ascii?q?nGEeEKCDYEVg2iBD4l4BIMwlBRIgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuC?=
 =?us-ascii?q?BEZHYEZCj4XgQobBwWBIgaCFYZpD4kzgXYDCxgNSBEsNxQbQm4HjxdHgi6BD?=
 =?us-ascii?q?5E7B4d3jw+hEYQmhFEfnGhNqmsumFijaXCGUQGCFE04gyJSGQ+OLRbLYWk8A?=
 =?us-ascii?q?gcLAQEDCZNpAQE?=
IronPort-Data: A9a23:VvI/Uas2x4BhMK9j++dIaRBLLufnVPtfMUV32f8akzHdYApBsoF/q
 tZmKWrXOaqONmKjedx0b4XnoRhQv5bXn95mQVBvqyoxRX4U9ZOVVN+UB3mrAy7DdceroGCLT
 ik9hnssCOhuExcwcz/0auCJQUFUjP/OHvynTraYZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCROsspvlDs15K6s4GpC5gRlDRx2lAa2e0c9Xcp3yZ6ZciOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkEfzsCa+v9T2Ms0MS+7uR3Q9zxC4
 IwlWaiLdOscFvakdNLx8/VvO3oW0aVuoNcrKJUk2CCZ5xWun3DEmp2CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rrsjv+Lm7UORVrMUGCsThMptY5ldl5GSMZRomacirr6Ti4M8d0Do0h95DB+eYe
 scSLzNkKhbYC/FNEg5MUNRnwbzu1j+iL1W0q3rMzUYzy2nIzA1g2b3kGNrNcZqLXoNIk03er
 2mA/XyR7hQybYTBmGTbqiPx7gPJtSjVfr4pJLriyq9ziwyv3GIBWTkwelTu9JFVjWbkAogAd
 BVFksY0loAz70yqX9D4VjW4uHXCvwVaRtdbVeQxrgOVopc4+C6cFi0IQzpAdtE8pZZwWDEhk
 FaC2dHxbdByjFGLYVu3r4+frSm/AAIUCEkPbyEcClcj5vC29enfkSnzosBf/LmdrOWdJN0d6
 zWa6SQzg7QNgNQajuOm8FuBijnqpIChou8JCuf/Az/NAuBRPdHNi2mUBb7ztq8owGGxFAXpg
 ZT8s5LChN3i9LnU/MFNKc1UdF1T2xp6DNEsqQQ2RcZ+rmXFF4+LYYBdqCx4JVlkKN0FZS6hZ
 0GbtAdc74NJOz6haqpyfoSwAM02zK/mDrzYax0VB/IQCqVMmPivrHs0NRXOgjmy+KXu+IlmU
 aqmnQ+XJS5yIcxaIPCeG4/xDZdDKvgC+F7u
IronPort-HdrOrdr: A9a23:v33pdK6lfVzUUsIs/QPXwAHXdLJyesId70hD6qm+c20tTiX+rb
 HUoB17726NtN9/YgBCpTntAsm9qDbnlKKdgrN/AV7BZniDhILAFugLhuHfKn/bdREWndQtsp
 uIHZIObuHYPBxViYLU7AGkD80t2rC8gcWVbCTloktFfEVFb6lh6kNeEQaUEkp/QU1jCYAiHJ
 SRouprzgDQG0j/p/7WOkU4
X-Talos-CUID: 9a23:nbmP/GHXk0GaOFPiqmJO3hcsEcA/f0T3zVL2LkW2ESE1bri8HAo=
X-Talos-MUID: 9a23:ZiUmwQWOEf94OE3q/DTCog1ZBMAy3/W3AxExi5sU6u2iGiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763391600"; 
   d="scan'208";a="106966096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 21 Jan 2026 12:33:39 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 5F1C0183E3B2;
	Wed, 21 Jan 2026 12:33:39 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
Date: Wed, 21 Jan 2026 12:33:28 +0900
Message-ID: <20260121033328.1850010-3-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testsuites for kfunc bpf_strncasecmp.

Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Acked-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 0f3bf594e7a5..300032a19445 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -9,6 +9,7 @@
 static const char * const test_cases[] = {
 	"strcmp",
 	"strcasecmp",
+	"strncasecmp",
 	"strchr",
 	"strchrnul",
 	"strnchr",
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index 826e6b6aff7e..bddc4e8579d2 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -33,6 +33,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
@@ -57,6 +59,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { ret
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr1(void *ctx) { return bpf_strncasecmp(user_ptr, "HELLO", 5); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr2(void *ctx) { return bpf_strncasecmp("HELLO", user_ptr, 5);	 }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
@@ -83,6 +87,8 @@ SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
 SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault1(void *ctx) { return bpf_strncasecmp(invalid_kern_ptr, "HELLO", 5); }
+SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault2(void *ctx) { return bpf_strncasecmp("HELLO", invalid_kern_ptr, 5);	 }
 SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 05e1da1f250f..412c53b87b18 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -8,6 +8,7 @@ char long_str[XATTR_SIZE_MAX + 1];
 
 SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
 SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
+SEC("syscall") int test_strncasecmp_too_long(void *ctx) { return bpf_strncasecmp(long_str, long_str, sizeof(long_str)); }
 SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
 SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
 SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index a8513964516b..f65b1226a81a 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -17,6 +17,13 @@ __test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO
 __test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
 __test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
 __test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
+__test(0) int test_strncasecmp_eq1(void *ctx) { return bpf_strncasecmp(str, "hello world", 11); }
+__test(0) int test_strncasecmp_eq2(void *ctx) { return bpf_strncasecmp(str, "HELLO WORLD", 11); }
+__test(0) int test_strncasecmp_eq3(void *ctx) { return bpf_strncasecmp(str, "HELLO world", 11); }
+__test(0) int test_strncasecmp_eq4(void *ctx) { return bpf_strncasecmp(str, "hello", 5); }
+__test(0) int test_strncasecmp_eq5(void *ctx) { return bpf_strncasecmp(str, "hello world!", 11); }
+__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasecmp(str, "hello!", 6); }
+__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecmp(str, "abc", 3); }
 __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
 __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
 __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
-- 
2.52.0

