Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF732EA481
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532637; cv=none; b=l1uQ8plyZTg0+/H4d22vb89sJpVfheW4URs9J/boYGiGlYBzSGSM9ojD5bwBCHWsBtdz+V+9WbAGBpi5IigCmReGniQMsVgOmUSY8w/VTITB/IzB+L+Jt0OLI3zjodTS0rrcnjujCMmSODRRFwGTHGj5v1WjkEw0QCc6hynEcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532637; c=relaxed/simple;
	bh=snCx+raJApWXPduGnvVazw2x8+DpPWr/6MBLh4ntUhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlVhAY/oV4pMOJ0gWfX957cWR2fcWsUGlRNRCRmiiUVqbRNvCNm8eSBgF9FKl7WQSXm3ggtt82Typ1DHFbtEtoa88c04mWGeTHEo+nbA53hkw+7XLIOO9AS6zQWOn8rNgddSa9HQC5fgok/1nooqX6K/ZPdO0qsVn8+qLM4PafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDLZHAyU; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDLZHAyU"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-4795222965cso1137134b6e.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532634; x=1777137434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a26k7Ig8qe7dDs4E/yHWGmsETigxmVkieBzGlHslZIs=;
        b=mDLZHAyUq6APZ+KxcWTZhXtqh7Mh9Z2+OWz8mz2yZSfBFpBfg7qzmgVeVr3xGBu1g3
         OY1eFFxIwCgRHYxYlpurAPwQNsIuql+6VVj6WZnXzUj/vDHdco0+8A6ZdrYOKU5cxpFE
         l5mAmzWtm+O47SyykCJpe0443jY8iPYBnvBcIg0OPb859w0eHw7Sbo0mEA1mIbMyKihJ
         dkdSsqV1ffCjpTl7WWRLV4bSgqsEOhQg+uyP2ovGJO288E18bQSTJJcm8U+zokHSi/fa
         0ZmtQzzk/kBZX/Cbfks8ssVBd5WPoOtOeazjRIMyVnuVP6/+zNFoFFaY7uIjzyQY69SX
         4yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532634; x=1777137434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a26k7Ig8qe7dDs4E/yHWGmsETigxmVkieBzGlHslZIs=;
        b=dzvcVD1LLRyB/pywCHoegPLLrWMOkH91q8r06IaqxxyvCTeZ43Uo/XUdawlq0emXWo
         FFprYgQF6Tw4S9Vh6OMw4LoGCrjQ2qhultHsCq0V7WxLeJYinunOXCbZP35S3MwqCGV6
         uyXY28lj3T8B9FXEvXWa0w1Ssz9utA6sa7+ngEIFuhms1ZEklREnoc//xGooBgzVU4vQ
         K5VbdImBlPIThrBFtJ5WvBNsDQogJM0kzGiu7aoI5ACGzcwlNL6icAY191RxykYPNztu
         hbMmNc67smgneLH4cFRouQGSf4Rp2O/jnZZEhR96MfABAsYc1+fJqJ3czxPWu20WsKe4
         vvEg==
X-Gm-Message-State: AOJu0YwRhx9cArYORy6JLoNhEiuscQ/4+h6KSSUPqkO32+fW/Dvzf65D
	ONUYlcP8uM8Yqjidz9HxSxUNbZZXiQgAlGNFoMCJ3VomW7mryOoBq7c0231kL52lJcdN+w==
X-Gm-Gg: AeBDieuFXjPWPfZwe/6F9MCv4Odxb3UXP+AHJPouvjq/4JunxBu666mTDNbd4L4qGE7
	/bV0BaUYTahyKG3XmtHwxt3d0CRAfQvG/ph3zSaoNx2UVVrDZa503wPI+aRSQhXVMtgs/iuD0e2
	R3B+uaxLkhfDs1LCEUDhW/V/VceLQRDacXdR0ulVN2Sv0z4NSp50FLnWEk4tJZEipIs7n+c14jR
	XQAChTf8cr3gucWe0ksKCHe1JiHQZhP2FNyoNX93L1kxp+ySyoupc7ujKRvPfaAFMcitHpaW57m
	B+RUPXxJlcOwVFRjRqbloZyed872TU3TWKKg8uF5SaTTPQEIGKbovKfaElbabDCUzHcwj/KT40E
	VUTE6u98NFk283rRvanmaN3o8u7/y8Vs/Hj/t/vAPaeITXgOSjhXzQvDRMR62JZLw0LJpcWVHrA
	Ln/gApGVeFZ1gVS5cLBPHHohYpMtO8eCjd3LJNeLUGXUlZQQhjRidhkYWQb7GPqASMK4CPMPlP1
	q8dblUW4+E2T+L/GXbfsU8WB1254+Kjl/Ur+XxTIPIi
X-Received: by 2002:a05:6808:80b0:b0:44d:badf:f449 with SMTP id 5614622812f47-4799c802e7amr4246304b6e.1.1776532634374;
        Sat, 18 Apr 2026 10:17:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm3367123b6e.14.2026.04.18.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:17:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Test verifier warning logging
Date: Sat, 18 Apr 2026 19:16:59 +0200
Message-ID: <20260418171701.610025-5-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418171701.610025-1-memxor@gmail.com>
References: <20260418171701.610025-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3569; h=from:subject; bh=snCx+raJApWXPduGnvVazw2x8+DpPWr/6MBLh4ntUhA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPxnuydvUyOynonnBtm3PsY8theMvl8eOgt1smbou1P/f8m O7G9o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMxnsTIcId5Voby0sA1b6yLNRnPRW Znc9pXZWWqH49OZ3zQLXkjnuF/dHj21/f7eyU6Luy67KOnXKdasPlfcv2brIkPuLWP7knmBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add coverage for explicit verifier warning logging and for libbpf's
default warning flush path while keeping the warning bit private to the
test.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/kfunc_implicit_args.c      | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
index 5e4793c9c29a..f92a27d76455 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
@@ -4,7 +4,99 @@
 #include <test_progs.h>
 #include "kfunc_implicit_args.skel.h"
 
+#define TEST_BPF_LOG_LEVEL_WARN	(1U << 4)
+
+static size_t libbpf_log_pos;
+static char libbpf_log_buf[4096];
+static bool libbpf_log_error;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt, va_list args)
+{
+	int emitted_cnt;
+	size_t left_cnt;
+
+	(void)level;
+
+	left_cnt = sizeof(libbpf_log_buf) - libbpf_log_pos;
+	emitted_cnt = vsnprintf(libbpf_log_buf + libbpf_log_pos, left_cnt, fmt, args);
+	if (emitted_cnt < 0 || emitted_cnt + 1 > left_cnt) {
+		libbpf_log_error = true;
+		return 0;
+	}
+
+	libbpf_log_pos += emitted_cnt;
+	return 0;
+}
+
+static void select_legacy_impl_prog(struct kfunc_implicit_args *skel)
+{
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog,
+					  prog == skel->progs.test_kfunc_implicit_arg_legacy_impl);
+}
+
+static void test_warn_bit(void)
+{
+	struct kfunc_implicit_args *skel;
+	char log_buf[4096] = {};
+	int err;
+
+	skel = kfunc_implicit_args__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	select_legacy_impl_prog(skel);
+	bpf_program__set_log_buf(skel->progs.test_kfunc_implicit_arg_legacy_impl,
+				 log_buf, sizeof(log_buf));
+	bpf_program__set_log_level(skel->progs.test_kfunc_implicit_arg_legacy_impl,
+				   TEST_BPF_LOG_LEVEL_WARN);
+
+	err = kfunc_implicit_args__load(skel);
+	ASSERT_OK(err, "skel_load");
+	ASSERT_OK_PTR(strstr(log_buf, "uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl()"),
+		      "warning_msg");
+	ASSERT_NULL(strstr(log_buf, "processed "), "no_verbose_log");
+
+	kfunc_implicit_args__destroy(skel);
+}
+
+static void test_default_warning_flush(void)
+{
+	libbpf_print_fn_t old_print_cb = libbpf_set_print(libbpf_print_cb);
+	struct kfunc_implicit_args *skel = NULL;
+	int err;
+
+	libbpf_log_pos = 0;
+	libbpf_log_buf[0] = '\0';
+	libbpf_log_error = false;
+
+	skel = kfunc_implicit_args__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	select_legacy_impl_prog(skel);
+
+	err = kfunc_implicit_args__load(skel);
+	ASSERT_OK(err, "skel_load");
+	ASSERT_FALSE(libbpf_log_error, "libbpf_log_error");
+	ASSERT_OK_PTR(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD WARNINGS --"), "warn_banner");
+	ASSERT_OK_PTR(strstr(libbpf_log_buf,
+			     "uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl()"),
+		      "warn_msg");
+	ASSERT_NULL(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD LOG --"), "no_verbose_log");
+
+cleanup:
+	kfunc_implicit_args__destroy(skel);
+	libbpf_set_print(old_print_cb);
+}
+
 void test_kfunc_implicit_args(void)
 {
 	RUN_TESTS(kfunc_implicit_args);
+	if (test__start_subtest("warn_bit"))
+		test_warn_bit();
+	if (test__start_subtest("default_warning_flush"))
+		test_default_warning_flush();
 }
-- 
2.52.0

