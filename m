Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2737303C97
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748385; cv=none; b=qD7a+2YRWow2EaWLG3fXJaHzII/fyJjJmiyPNDGD9vIfTWI0/IejwJsFPtAW3i5yWB/SP9I8eoAaYfg0CYX6+zXhP++jW7l8m9oWkepFQrb/UrovO0FsdJTTE3Ru95WnHtl7357HVaSwRNp/F4mNPpVKW3naq9qwV8I685H8R1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748385; c=relaxed/simple;
	bh=F/+j+4BMnkmhmAeYeXhQT23UVkzT9LDeN0u+HSrNbHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5/dU51ZzluStXYMcuA/7w/lIRvG8Kl901cQtBsnvF0yh37K036YnBAjp6hM1Qe3MUdYLcL3Z2EigqRFWh/jjVCvMjG7pEHJDwk0kGW78SwUY9+RP/h8P6mnbtp6Jkdq95jd5yxk0cDho7ZuMtHDA/SVk/XlmRyDVe1rOUZdE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ivoLkLgK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ivoLkLgK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-896f5af3d8aso14724746d6.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770748383; x=1771353183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnnF7v9P6RTzrP5qU00aD/Wl+rtYCM6Z1Ka0QsECUJE=;
        b=ivoLkLgKPVtYeDR+y+NMauiBw/mBgXP+9pwKWPR0RNNPkmu2EuUl3ApC+oRT4ukOie
         h7CK/lghOW7N77EA2LMqOt8qeJ/1e52XhO0z82OwxEBg8S9G4DgcN+ZaQVqwvKd4iz6t
         RLk+rCL/5sg8I4ucvX0Jgkre+R9h0sfxOcfQ0SfdXL5nmKpkt7eM05lYLZYCyhKCGwkl
         SEP2FQOpfpD24Nwq+ZOrwq1u3Zlix+KStQvcp7r/27RPF4kjVFPL6w9sauR2yqIGv4SL
         d6sx6XRhUfAuSktXKoMb6BSYM4icxPZRr2BwodTOQuSz7sxV5chyLnD5PZ/SkNrZfdep
         JRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770748383; x=1771353183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnnF7v9P6RTzrP5qU00aD/Wl+rtYCM6Z1Ka0QsECUJE=;
        b=qI+QgSwDHv3eFhMcRndOLnvpkL6jr1ujKAXf5VKA7dr/ha9MC6b5422MtpzrqYxqL4
         zMNy3Csi9IC6rKsWPdZW4JqloSa40/ZViv7umJ8UMLRuXMOE9Hpq4e3xLO1u08N0Zf5g
         V7KuK7xVmXcPZ3rLoIW7/OND2NY1+Rc0RS5JtxL/RJYQmMn6nPYbUiYu4YoKCNEjSXah
         BSVqVgx6hel0SDxHsSfIN5BwnSX5IRXMJGazKLVsF2QySPoJ7oeA0g5yo/fxpQmosQR/
         imEoKsOXaimzLFh1uPnLl2AJBj0m6j+trn4TvDJT0l4oqUs9RCaTViCDMimHx6/EtYiO
         286w==
X-Gm-Message-State: AOJu0Yx1zvM/mByCVGTbWfl/cboJqnhBThp+I73fVo1UM0cbSyz6Uy8D
	sXtcaWbV4lOqwqqurKyBYwaPW/dTsybOR0PeKTusVO2sCvuqkcYUZDn51hNsByCsRlndnWoPBco
	mS5zjqgI=
X-Gm-Gg: AZuq6aLlP8pBodX+jctXeBrxpeLHmzH+eSrWyVh6mVoCOr0uRN7r+K9beLTZNPZqsHS
	fgFPwsfzJGqCkjkT7Yy/ELQI14GOLSiiJURrrDCH8inHRNzCs1Q69Hjzk8sOOhgxfqa5kg3bdIK
	4FMQz2m+NekAqCUUSUBzKHrxE5kII3Ruz3GfTSQA3eHKFg9vX8w77IyD+1Huek2jvN5Gxpomrid
	po+F/BHDstenlQbQjuu1z95GIwcIcAAW4YuwhEku0JOgddRyOxVVT0VASnrdDWxinmCJTQleSLR
	AyJVJfPZlq08uGTJR/q7c4WHuoEPcS9MBdA4SqhP9/M74pfyM+roLQ8jMPz8sNI0GkDwQ8xqcVO
	HU913otkMoCvGEpa52wcwOL5IW+O3t+7Fzbvj8PM9EfFA2Qcri6Uw8FXCMg0b7ibKlA4tjsd+fQ
	wrE6yyFIYT1VIes2vcgkyzlg==
X-Received: by 2002:a05:622a:18aa:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-506398e56e9mr192155401cf.35.1770748382831;
        Tue, 10 Feb 2026 10:33:02 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063913b829sm105348641cf.7.2026.02.10.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:33:02 -0800 (PST)
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
Subject: [PATCH v2 2/2] selftests: Add selftests for void globals
Date: Tue, 10 Feb 2026 13:32:57 -0500
Message-ID: <20260210183257.217285-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260210183257.217285-1-emil@etsalapatis.com>
References: <20260210183257.217285-1-emil@etsalapatis.com>
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
 .../bpf/prog_tests/test_global_funcs.c        |  2 ++
 .../selftests/bpf/progs/exceptions_fail.c     | 19 ++++++++++++---
 .../selftests/bpf/progs/test_global_func18.c  | 23 +++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func18.c

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

