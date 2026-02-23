Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB631690A
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883481; cv=none; b=QAsIV6G689CLcWHJ5oGThPV9204ZRQMJJLEHoNT95QSK8SLqmQLIPNkhD+98ZvBXufwspn9nsGYtbwdgrkU5eMM7aZjx6+rFAocrFJ1CUm09hdE24/dVZVV1VEQexNCpZTy28A/bEY0fsLpBWg2VZphcTIDkBQYcTi2et1ms7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883481; c=relaxed/simple;
	bh=71jnkfNoiXsOW8YmYtw/ChG4gc9wyIvhpqFX+TIAtq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRjtJW5DJ+6Rzqtw9ZYNtw8jwXJhuorvZSeKzVp3YPwedqqiUBqiXGmPyNxVep6dam/JiHTfEsc+etddUqGMmJby+lVLvH3sDs0Sfp9dkZctRzWI0FQzspWWgbme4ZHxenwoFhwTGiRuHiJIt7QJOUfTYsh6JnKajEn3Qc+H6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=q++HP0hc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="q++HP0hc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb5138df1aso487637885a.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771883479; x=1772488279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mq9UkJCnV9fZWuBjmx3N9N6N0MZiDWPNJL6ugBAQqo=;
        b=q++HP0hcogeA7AYtEvfwxjGEghKRnJ5O/pVDC7vT+DctpPlCiBvELAbz2gc4sfyCv5
         d8HxzYPY1X2jsOgbMEktc0Q+pQK4pkTIwzp9zCrtnNKUBGehpQjNwE1wcsSsJuTc6198
         8JTiwKOp/Wli+ygFdHmInF7lmUt1Pgx+5T/LRD8OskylrBNv3tEgv1l5+L4pqAms/Ug/
         ZO9YUf3lRAN/iGLfyzxZEqqmN6DmMELVrW+M2DKDPJIKoNgGdbYLVYbhnMgPI3MO9vcl
         XtHWj5l8WJzqU87O4igFxyCh79IiE/yFgXxbIuwqOro1XbmKeyTy17YQvIq1RbXM4ZMk
         Kuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883479; x=1772488279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mq9UkJCnV9fZWuBjmx3N9N6N0MZiDWPNJL6ugBAQqo=;
        b=hhXTvh/Xc1FWoRnnN+BXdCmBRpzDjYQJCeFUKQWenGDyn8DqfIkgLst9DIWf5EUhqL
         Yn2RwPj2qdnbHpEH3PlL+/KGAYdOO5hAMOx0MAFRzf5qzhq/VpXeqLkXUMLanbc7zpwC
         4QvZLmQ+cOLks84/AkZ/x+FSkbyugTwo/xJCF3PEiIHvM1NSKk5ewd2K/WK36sFwW2Ic
         hUf+X+gLfbjnX4wLdVOacArZU4pqqMY64BU3u0o8rsiRmhRrvB9lWPIbqs9OMts1tjay
         FTTSujVI6Ozqi7br7hEzTqP7WU21udzXjwuUu/H4jebVJigqf94wAvWsiyJvR47Lf9Ln
         AAUg==
X-Gm-Message-State: AOJu0YxIkp8KK7KnfkqRmFtiAEzky/wysxZldD0Vi51UQzYjbc5c0Eos
	HJRAJPjpsa1ihdfVd73QAA4A1yZv3QUYgKA+MK814Cwko0Hk/86/IQ53Waqvcz6t+6fbS6oT8x5
	2J8hOWKc=
X-Gm-Gg: AZuq6aLi7PVQ/tB4MrxYRTWvs+MYHrJN3cwvdoLUKadWeFJEb4CbxTZnyMw60+4jlCv
	GnfUkzE5a+bsEQNOf8cFBR2sxhC+WcIGvDYpL1fB24twyBsy0TrxEI3RO1YexlxeEPpSCS7qa3Z
	PXW7H1Pm7r05+q7DA5S3j7vPR38Mvq99AJwdvODRZtyYe4Z0vxdrFaKPpxpWee6q8oA6hZFSUpB
	Nl4x6bCUwssADOza8B2WYRsbijYKjp8XiYtOWpEn2fwXuytYZZhy6lElwhRzdlUa23JiuIvurnc
	rptiOdA1uJCTx5bn5BlHvfDFpZ3iOMsbJXcXoztFgv6qEriZwe3cJIQ/6TQSUwKIvjAPji6NWr8
	GD4jzilUA36vfkSg9rD429ULxgoxl5SeJUcBI5KPpG2EPW0zT8l+MSZJjuNUYDZmYKkPiUXdtWK
	cx5stdUc6zwNE5mgAv2aNT6w==
X-Received: by 2002:a05:620a:318f:b0:8cb:4cb0:8d51 with SMTP id af79cd13be357-8cb8ca83710mr1278856885a.61.1771883478688;
        Mon, 23 Feb 2026 13:51:18 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d100c18sm815115485a.38.2026.02.23.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:51:18 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/2] selftests: bpf: Add tests for void global subprogs
Date: Mon, 23 Feb 2026 16:50:46 -0500
Message-ID: <20260223215046.1706110-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260223215046.1706110-1-emil@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
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
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 24 +++++++++++++++++++
 .../bpf/prog_tests/test_global_funcs.c        |  2 ++
 .../selftests/bpf/progs/exceptions_fail.c     | 19 ++++++++++++---
 .../bpf/progs/freplace_int_with_void.c        | 14 +++++++++++
 .../selftests/bpf/progs/freplace_void.c       | 14 +++++++++++
 .../selftests/bpf/progs/test_global_func18.c  | 23 ++++++++++++++++++
 6 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.c

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
diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index e905cbaf6b3d..45854cbcbfcf 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -18,6 +18,7 @@
 #include "test_global_func15.skel.h"
 #include "test_global_func16.skel.h"
 #include "test_global_func17.skel.h"
+#include "test_global_func18.skel.h"
 #include "test_global_func_ctx_args.skel.h"
 
 #include "bpf/libbpf_internal.h"
@@ -155,6 +156,7 @@ void test_test_global_funcs(void)
 	RUN_TESTS(test_global_func15);
 	RUN_TESTS(test_global_func16);
 	RUN_TESTS(test_global_func17);
+	RUN_TESTS(test_global_func18);
 	RUN_TESTS(test_global_func_ctx_args);
 
 	if (test__start_subtest("ctx_arg_rewrite"))
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index d28ecc4ee2d0..691c16001952 100644
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
index 000000000000..76707b29dc6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_void.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+volatile int data;
+
+SEC("freplace/foo")
+__weak
+void test_freplace_void(struct __sk_buff *skb)
+{
+	data = 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_global_func18.c b/tools/testing/selftests/bpf/progs/test_global_func18.c
new file mode 100644
index 000000000000..3dafb0dc2342
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func18.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__weak
+void foo(void)
+{
+}
+
+SEC("tc")
+__failure __msg("!read_ok")
+int global_func18(struct __sk_buff *skb)
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
-- 
2.49.0

