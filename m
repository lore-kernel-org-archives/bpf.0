Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B62848BE
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990447; cv=none; b=BeATxKu1WDbkPbuKY8bBRW+iyFbO0hUc33QivyKAuUZFitTmR5bXdHM+BKFsPyWtX2jOK6Jc10AlFH/shuoi+Lar3uOmiu8+1cBq/pzP+ygmFAhyVxA9DFDataE7UqvFAucb0q3WjnluI3rhwsLLhmJIKEUC5WO54sGw4OPJerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990447; c=relaxed/simple;
	bh=yDNo/s93lBFyToErP/wki4LpSW8EwVlUr2WqPB34oWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXkIrhAAvCHNOgENhJZliB50lCb9JwshfcwtnvYyw2PBC+oSiV9N3t5al8XsSP0H65w910SE/ST3mGDb50jE9w9+2IaBgWP+DHDsjFDnAWKkBK+ZKxmNCNZuP6hsaZm8583ToWfE6Va2IwlDhj39Wn90fKBaYSCiHRAH1z7/3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=h4abqeU9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="h4abqeU9"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3e22435fso40575585a.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771990445; x=1772595245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycFQg5QJINHuOrmydHV79ValJBhtiQNUVTIfioie238=;
        b=h4abqeU9hPrE5v0rE6zZG7iBg90mC1oBukpKBMdgxvXM1TuAau7xYpGnwQlFhvj3ti
         lkW774362p9GcIcY3DBVqbkjo0F6bsQfsE4DncoL3khyn7sEgqMfCorv2ydA9AOrB2lt
         zqG8jW+Uy0MB5VBQGqq6Fdpqbb9sUwRCirvb5H4kTNq/CKAYWnAzy4r6I9IdspzpXS4J
         RsVp8AvJ0c+LVs49FCIx1yQeXB97dkR+ZDdhoRIxU6YZapa9oKnWk4ZILybjYuuJQmSQ
         A//H2tDxwS4AUqcxXqIWt0NA341h6nBo+WLAYjyf0ocHGYCdgFw03z7dowT9Ot81KQyx
         q14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990445; x=1772595245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycFQg5QJINHuOrmydHV79ValJBhtiQNUVTIfioie238=;
        b=ItBxHUJxjwPye1QNZwhaA6442eULS7wtMb74qieISkuuCr1CXUi89XIysGc3LkDR3/
         Xiw+D76MLHz+nHBj29pa12i2wiIeXpnBa9obm5j+9ng4i1GX3Z4aD7srNLeYJnCNz7wi
         HBr3flX02ADoGjyftikC5K8zQUlOMZSr6OoRg4JjD1v77rA1PzWMx7w65+9RYtOkWXkG
         Ly7unHM6dcpjBvpX/tZsStywREX2VB1oZqfQqBmyACNg+GEOYn3f6WyQtAum99Ux4HZg
         /eEAgtrUpT9n/uE48kMK99pUevFC+b1QE2BFRDy0ycYt6A45X3eN5rX1KulRHfMmiXYc
         cq0Q==
X-Gm-Message-State: AOJu0YxWYrPXjjBYv6L/Ae4QRp/KfsGyPCSQifc/PQqWpLrv9DSRioMf
	CXKiE7CoKqOKbd4zZ/vXAmKpvPRmS6J039GXd5gne0l+CxoGN8iprEm7AaENzYLg9kZdqG0KweR
	GqJeVWxk=
X-Gm-Gg: ATEYQzwCGfpBTzmUMbzqMyuderDUowVkWKwt9dl44WoLNwvx5l1iJUIJdN3/t8YFpRc
	M2G8qqCzVnI7PmNIvTMASnm7W01r29LsRqTAYiTBEjwbG7lSnojwpCc24pNTNZ3uru8gYiA2PJD
	kIiUXmo1QF2B8SRbI31OL/On4pceIKIK5l+C+VOliSMW7vfnMuA83604JmrAwnHuQsyXGbg6aAz
	7xRmEvoTHcjedCXfunspQ+BzJc/LlL1o0qe1wtno2n8cZQ55RXPOj9shKt47WDjbHXewyEKL3rB
	cvND2wQPX+fE1025N/neMxgaNq/z8TaWGMUIcdVQ6AacTS5jdRgv37QQplCiCVGlCm38XM02XRB
	M3buoT/iYBV8H0DgGfS+s3TFmALEkggLBRJDgjBCfpYSR11mXHODUJln0cvYLatsdnJ1zijJkaS
	iah1PpNoCNUGHpdXzF8a3MMw==
X-Received: by 2002:a05:620a:690f:b0:8cb:5566:c947 with SMTP id af79cd13be357-8cbb1fe0756mr325256885a.17.1771990444658;
        Tue, 24 Feb 2026 19:34:04 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm112207986d6.44.2026.02.24.19.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:34:04 -0800 (PST)
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
Subject: [PATCH bpf-next v4 4/4] selftests: bpf: Add tests for void global subprogs
Date: Tue, 24 Feb 2026 22:33:56 -0500
Message-ID: <20260225033356.518313-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260225033356.518313-1-emil@etsalapatis.com>
References: <20260225033356.518313-1-emil@etsalapatis.com>
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

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 24 +++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 14 ++++++++
 .../selftests/bpf/progs/exceptions_fail.c     | 35 +++++++++++++++++--
 .../bpf/progs/freplace_int_with_void.c        | 14 ++++++++
 .../selftests/bpf/progs/freplace_void.c       | 12 +++++++
 .../bpf/progs/verifier_global_subprogs.c      | 19 ++++++++++
 7 files changed, 116 insertions(+), 3 deletions(-)
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
index 000000000000..8b6f5776cf0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_int_with_void.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+
+volatile int data;
+
+SEC("freplace/global_func2")
+void test_freplace_int_with_void(struct __sk_buff *skb)
+{
+	data = 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_void.c b/tools/testing/selftests/bpf/progs/freplace_void.c
new file mode 100644
index 000000000000..cfa4af00991d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_void.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+volatile int data;
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

