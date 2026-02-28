Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A93CC9E9
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304496; cv=none; b=FSoGR6CN3i0u7cCLrB+1i4S42pk+EWrF2BM/+1/a9PpS/iAhvWHfv9AytWs1meyuILIHbVgC6JO6V1C02WAiNOsS2cCHLGPaOcGM+9iUJv1gRE5aQW+OltPydRya8LGasAqzrJQzSxC761UdY62rDBfJrbusAI3Bc3rzdQ0eYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304496; c=relaxed/simple;
	bh=kcxQBhRnsv/2+rLF1+R6x6q3rrabddgksxGQ/uU7yCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYmSi7Nww8axMGntEUuGOJd5RYZ8l/T1oI7cIaWILpsjPdCQpgN+7cJrST1YFgC1OKF4CjGxFHPEHdWpP3Oman7PtHs1jy9J5IXWiNkYs+WaZdT5gw4wZvU1aGGnPI9co4MmhOpWvbMuPqXQVjy2wHU3wZZPb0WfIG31BJgYRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hLnu0i12; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hLnu0i12"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069df1de6fso27583091cf.3
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772304494; x=1772909294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqXDV+BY5Z+ou6mCyh2OlKY8skjH5SofQmVMGER0lYk=;
        b=hLnu0i12s0VO+ikPez+hcjDlVXti5fl6lhhrrwLma2JWQHR75qQC3gz5SK1wQBZauY
         DEDildU9FJ3l8tVJfUUczzTo7J4wvCA4XnzxkC3AHblOIlUKmI6iscisVszEMOCrFrGX
         K49+/Cs+MVi+fs2zH8L6wB9OG0FS6SYcG/1/h/egg6m/Yw6ZRy3BQlP8tYQksdBHCntA
         wTcAizMCC1/neh4z6PabKEFDI22HQzG7NPh+PCZL3QvtXcWR7/Tn+SgMRPQ6RhQWPt4Y
         9MvOCDqB7MVo9uIGdJvvW82G3+vEdoUpjObXHgS3bIqNXUAZukESSzGQLoepQr3ExNPO
         /uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304494; x=1772909294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqXDV+BY5Z+ou6mCyh2OlKY8skjH5SofQmVMGER0lYk=;
        b=Filwsi1Y54D2g7iQY7cPVZHMNJZJzLiw3fH2rPw9dgcNDmaBeNY0IRXxRhu/7Bqmqb
         AWnP0iDRuRQWIGcTKeCy1syQkeZG3awE4HHRw4a1n4ftaVNND+TRTXWqvUI0sBDnZl9/
         EzNkfp3kbOVMoWsgtVJeD7fCw5KHahhdGdpYfVzGCyRSGQEY7Avx2/ZimzUcl0CBGc0M
         jzXT0tl41ey5PoP9kCS9QMD7in8UfNiAwGBrMnioOQnbbEEIGwy6xLaR1jgmpUDfIDWa
         Zek3R2m0ZpHUo6avGQxVMym9N03MBwYMdGofBYDd46K5Y+kuW1aKU0MDBmTDdS95oVKH
         BqFw==
X-Gm-Message-State: AOJu0YxAIoC8Vt59Ztsc3/lZ4JTYyPCYfaSLvmXHXaIFlGtYQLAKU7hq
	q2zWdQHVpek5K2p1kEKaoIvg2TtFtVSSfBG5WoIgA4I9RzGSmEfcTf10S5w4mlN75PAtl62s5Ay
	L6pdD6DU=
X-Gm-Gg: ATEYQzxkX+18F8OIynbXB9960SEJ1YgFek0I/HLHfUe/tX1kGVBPO2yXQFXexWP+D4j
	IJEYnfqFV3CaUPDkpUasS4tdDiUomcvljqM1LOxDHzKP+YLM9mzkJ1/CZUR9M7B29TBwLIOwwzj
	r4W2UN5QrkpvlEMS1ieL1DRL3kGijnhDNN7PCJondhfmettvGaM5qb7uRQUmHYWCw3keQCtntlz
	lXYWI7uMskZkuR0zxbQlo+mB/GQ8MnI1EgQXbb4hVwpuVgBTmX1AGcApv9SE41PRc07BPRwvJVL
	ewpAKNb0kCWuqd4SpejwVZmUiqLbeeuW/kF9vbLKTdiwv5fI9vYGTaXLaSASXQprtUlzmzB3ftU
	k4VLaxtEae/SkAjjaIbw2l5zezuac93TTLUTIEum2XJnZhUzY2H5EJcBg7rBE0BJDGew6fyQGjV
	rqR6AvMBpeP+ee1vRoKOgudQ==
X-Received: by 2002:ac8:5a8f:0:b0:4f1:b947:aa04 with SMTP id d75a77b69052e-50752740accmr86653171cf.18.1772304493769;
        Sat, 28 Feb 2026 10:48:13 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d88sm76160561cf.21.2026.02.28.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:13 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 5/5] selftests: bpf: Add tests for void global subprogs
Date: Sat, 28 Feb 2026 13:47:59 -0500
Message-ID: <20260228184759.108145-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228184759.108145-1-emil@etsalapatis.com>
References: <20260228184759.108145-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional testing for void global functions. The tests
ensure that calls to void global functions properly keep
R0 invalid. Also make sure that exception callbacks still
require a return value.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 24 +++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 14 ++++++++
 .../selftests/bpf/progs/exceptions_fail.c     | 35 +++++++++++++++++--
 .../bpf/progs/freplace_int_with_void.c        | 11 ++++++
 .../selftests/bpf/progs/freplace_void.c       | 10 ++++++
 .../bpf/progs/verifier_global_subprogs.c      | 19 ++++++++++
 7 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 516f4a13013c..84ab73e08b0e 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -83,6 +83,7 @@ static void test_exceptions_success(void)
 	RUN_SUCCESS(exception_assert_range_with, 1);
 	RUN_SUCCESS(exception_bad_assert_range, 0);
 	RUN_SUCCESS(exception_bad_assert_range_with, 10);
+	RUN_SUCCESS(exception_throw_from_void_global, 11);
 
 #define RUN_EXT(load_ret, attach_err, expr, msg, after_link)			  \
 	{									  \
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index f29fc789c14b..23d933f1aec6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -347,6 +347,17 @@ static void test_func_sockmap_update(void)
 				  prog_name, false, NULL);
 }
 
+static void test_func_replace_void(void)
+{
+	const char *prog_name[] = {
+		"freplace/foo",
+	};
+	test_fexit_bpf2bpf_common("./freplace_void.bpf.o",
+				  "./test_global_func7.bpf.o",
+				  ARRAY_SIZE(prog_name),
+				  prog_name, false, NULL);
+}
+
 static void test_obj_load_failure_common(const char *obj_file,
 					 const char *target_obj_file,
 					 const char *exp_msg)
@@ -432,6 +443,15 @@ static void test_func_replace_global_func(void)
 				  prog_name, false, NULL);
 }
 
+static void test_func_replace_int_with_void(void)
+{
+	/* Make sure we can't freplace with the wrong type */
+	test_obj_load_failure_common("freplace_int_with_void.bpf.o",
+				     "./test_global_func2.bpf.o",
+				     "Return type UNKNOWN of test_freplace_int_with_void()"
+				     " doesn't match type INT of global_func2()");
+}
+
 static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 {
 	struct bpf_prog_info info = {};
@@ -597,4 +617,8 @@ void serial_test_fexit_bpf2bpf(void)
 		test_fentry_to_cgroup_bpf();
 	if (test__start_subtest("func_replace_progmap"))
 		test_func_replace_progmap();
+	if (test__start_subtest("freplace_int_with_void"))
+		test_func_replace_int_with_void();
+	if (test__start_subtest("freplace_void"))
+		test_func_replace_void();
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index f09cd14d8e04..4206f59d7b86 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -109,6 +109,20 @@ int exception_tail_call(struct __sk_buff *ctx) {
 	return ret + 8;
 }
 
+__weak
+void throw_11(void)
+{
+	bpf_throw(11);
+}
+
+SEC("tc")
+int exception_throw_from_void_global(struct __sk_buff *ctx)
+{
+	throw_11();
+
+	return 0;
+}
+
 __noinline int exception_ext_global(struct __sk_buff *ctx)
 {
 	volatile int ret = 0;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index d28ecc4ee2d0..275ad6fe4a04 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -29,11 +29,15 @@ struct {
 private(A) struct bpf_spin_lock lock;
 private(A) struct bpf_rb_root rbtree __contains(foo, node);
 
-__noinline void *exception_cb_bad_ret_type(u64 cookie)
+__noinline void *exception_cb_bad_ret_type1(u64 cookie)
 {
 	return NULL;
 }
 
+__noinline void exception_cb_bad_ret_type2(u64 cookie)
+{
+}
+
 __noinline int exception_cb_bad_arg_0(void)
 {
 	return 0;
@@ -50,8 +54,8 @@ __noinline int exception_cb_ok_arg_small(int a)
 }
 
 SEC("?tc")
-__exception_cb(exception_cb_bad_ret_type)
-__failure __msg("Global function exception_cb_bad_ret_type() return value not void or scalar.")
+__exception_cb(exception_cb_bad_ret_type1)
+__failure __msg("Global function exception_cb_bad_ret_type1() return value not void or scalar.")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
@@ -85,6 +89,15 @@ int reject_exception_cb_type_4(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__exception_cb(exception_cb_bad_ret_type2)
+__failure __msg("exception cb cannot return void")
+int reject_exception_cb_type_5(struct __sk_buff *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
 __noinline
 static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 {
@@ -346,4 +359,20 @@ int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
 	return 0;
 }
 
+__weak
+void foo(void)
+{
+	bpf_throw(1);
+}
+
+SEC("?fentry/bpf_check")
+__failure __msg("At program exit the register R1 has smin=1 smax=1 should")
+int reject_out_of_range_global_throw(struct __sk_buff *skb)
+{
+	foo();
+
+	return 0;
+}
+
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_int_with_void.c b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
new file mode 100644
index 000000000000..cbb8f8ff2581
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("freplace/global_func2")
+void test_freplace_int_with_void(struct __sk_buff *skb)
+{
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_void.c b/tools/testing/selftests/bpf/progs/freplace_void.c
new file mode 100644
index 000000000000..68b114f477fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_void.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("freplace/foo")
+void test_freplace_void(struct __sk_buff *skb)
+{
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 20904cd2baa2..f02012a2fbaa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -388,4 +388,23 @@ int arg_tag_dynptr(struct xdp_md *ctx)
 	return subprog_dynptr(&dptr);
 }
 
+__weak
+void foo(void)
+{
+}
+
+SEC("?tc")
+__failure __msg("R0 !read_ok")
+int return_from_void_global(struct __sk_buff *skb)
+{
+	foo();
+
+	asm volatile(
+		"r1 = r0;"
+		:::
+	);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0

