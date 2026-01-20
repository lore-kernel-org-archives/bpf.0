Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869E35A957
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906836; cv=none; b=d07eyanxhC67O+mby6ENSW8Cbl4UI+OgiH5wfED5KTp0Z2h4AmTWyrfHbdUl8GTvIGrTN1VWEu87sM+1RHTR8D4CN1bME0PLdduucPm5NE8Lzn+ax5K4IgLbbJ+deDQfZwA6XZdlbIgMCa+avUR+Kyp9Ud6dMN3gJ7xm57UP2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906836; c=relaxed/simple;
	bh=mpjMk8kJwwho+1wgkQrW0bya3jgOGq6pcLsHG2tyzV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxJKRHRgC0Z2R8n+H+rxmbsgrvh172Kur6YNt1PZoeHdepyO0cYdigNFEakfqY8195eY7PDQUvno3mFkQL1pAqinpzv/x4ZQnxPiH8g1AEt3eh69zF1TAO/TZPKapIeqOylM55ukvW/eNZzWTiXJT8+5MGjo89NQgv7zmp9XMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: reg9Jy68TYCKx0RvieVgzA==
X-CSE-MsgGUID: 4d2Vfj/SQFC0l8HDE0j1nA==
X-IPAS-Result: =?us-ascii?q?A2GNAgD5Xm9p/zcImYJaglmCV4JbtGmBfwYJAQEBAQEBA?=
 =?us-ascii?q?QEBWgQBAYUHAox6JzUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQICgR2GCVOGYwYyAUYQUVYZgwKCdLBngQHdei1UgSYBCxQBgTiNU?=
 =?us-ascii?q?nGEeEKCDYEVg2iBD4l4BIMwlA5IgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuC?=
 =?us-ascii?q?BEZHYEZCj4XgQobBwWBIgaCFYZpD4kzgV8DCxgNSBEsNxQbQm4HjxNHgi6BD?=
 =?us-ascii?q?5E7B4d3jw+hEYQmhFEfnGhNqmsumFijaXCGUQGCFE04gyJSGQ+OLRbLfGk8A?=
 =?us-ascii?q?gcLAQEDCZNpAQE?=
IronPort-Data: A9a23:iP+RF6KaHQeXyn1cFE+Rd5QlxSXFcZb7ZxGr2PjKsXjdYENS0zJSy
 mtLWj+EParbMGH8ett3O4rioBxV65PRzdcxSQJorCE8RH9jl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX8s9JIGjhMsfzb8Uk35K2aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTKp6HKnueFL1yDwyjaMKVBktubD12i+
 tQCJT9cTAHd196H65GrEtNyh8kdI9vCadZ3VnFIlVk1DN4jUdXPTqHL+9JCzXEti8sIFP2YZ
 dJxhThHNU+YJUQSYRFHTs9j9AurriCXnzlwqUmVpLs+5mH7zBR6lrn2dsfYcZqDToNXhi50o
 0qfpzqoWElKZIX3JTytrn72uOHN2hjCdqlKEO2Y2tMyggSV7zlGYPERfQHi+6bm0x/Wt8hkA
 00P+is/pK073EyzRZ/8RFulrXXCtxVaWcI4LgEhwASdj6bZ5weHC3IVFHhcZddgvcRwRyRCO
 kK1c83BHzFg4Z+EFyKhx5y3vWuIJykYE2AQTHpRJeca2OUPtr3fmTrtdr5e/EOdi82wFTz0w
 i6HtjlkwagehogC3OO55TgrYg5ARLCUEWbZBS2OAQpJCz+Vg6b/P+SVBaDzt6ooEWpgZgDpU
 bhts5H2ABoy4W6xeNylGrxXQ+7wtp5pwRXAgVMnAp8g6Tm34H+/bMhX7nlzIEpiLtwDPDTuZ
 UrOvwJa7YNSO32xBZJKjkPYI5pC8JUM4vy/BqCENIcVOcMsHOJFlQk3DXOtM6nWuBBEuckC1
 V2zK65A0V5y5Xxb8QeL
IronPort-HdrOrdr: A9a23:LPoA7qvuAKS0ZFQADwfHERO87skDjdV00zEX/kB9WHVpmwKj9v
 xG+85rsSMc6QxhPU3I/OrqUpVoLkmwyXcL2/hqAV7PZmXbUQiTXeNfBOnZowEIcheWntK1s5
 0OT0EUMqySMbEVt6jHyTj9P/EehP6u1IzAv5an815dCS1MVOVc3z5UYzzra3FedU1+PrwVKL
 Cgj/A3wQaISDAsNuS9CX9tZZm5mzTDruOaXTc2QyQGxWC1/FSV1II=
X-Talos-CUID: 9a23:HJ1LCWC4eQs+KSL6EzNq+x82C551Tkz272eIGVG5BFhmWpTAHA==
X-Talos-MUID: 9a23:DFGlCAUjIcsAYk3q/GPg3g9sNoBT2oqFUERdsbkr48vdMwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106920882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 20:00:28 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 34B601839FBD;
	Tue, 20 Jan 2026 20:00:28 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
Date: Tue, 20 Jan 2026 20:00:11 +0900
Message-ID: <20260120110011.1805037-3-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
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
index a8513964516b..3ccfae4d27d3 100644
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
+__test(0) int test_strncasecmp_eq6(void *ctx) { return bpf_strncasecmp(str, "hello world!", 11); }
+__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasecmp(str, "hello!", 6); }
+__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecmp(str, "abc", 3); }
 __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
 __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
 __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
-- 
2.52.0

