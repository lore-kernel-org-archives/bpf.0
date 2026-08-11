Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973B35203C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470779; cv=none; b=O45RR+T9pX9/iVbolNwUP8d+tRdA0eeBDDMhftNY1WBghkhvark1A4IYq2XSIiHTbrhKG2KR0ZMShraeZKt+9Uun6fVLpPuHw7wY/SFteRW0XojV5EdwzT0Ni9uaBBiwfsmd9pcP7jjWOk2EJECht3q7XiPyXzVZhhd8EUImdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470779; c=relaxed/simple;
	bh=9tRbUqmsaxXdtdubnSWTHE6DrNeJYzyUncpsqh9EDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOtWc52UA/mzndrwpVOZA4ZOrrI1WjN3fb5He7CpZAFzRdMo5nACBan4nOgSQWgbtCglVHprtONe1NVBwYI87SXCO9/T2AL4rzZXAOL3qECJaFWdCtrwtCKXaF3bcTyF92kF213FUNahRKRWBx4RRdg/D/cxnBP7yejNh06YJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VutglnZ0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VutglnZ0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedb88aa34so29734a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470777; x=1787075577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91u0Za1hz/a5fH7FY4ulKiBG9M7w8xkSoB6NVMLvLQE=;
        b=VutglnZ0xyO1Owc58U4veHlraC7VAkLRLay2dx2EXki3CUwQR9hrE0yfhxz98p+wmk
         KXB2TfAO7JyNPuUEDJltzj3LdLeByXDNfwD4jC2r/blmFiZwIy+6OFQHZ+26QMstgshy
         AKqju2kHTSvdK+w53ztQaZbozVPNVC3Z0ppicSpkUqNXErS+uPRMiln0X80rnR2nBJjU
         zVTTtUMScDdQ2frj84zq7x85lcN8guwkrHiNK6p7gd4/aaOa55sG75SvfTIKnV0Awcup
         BoOSG2nlVQ6gwqk4Iu1vTZl+7Xt2UvWt+i1gwO8xD7kXwd0yTsCANzqiSCEHatsRn9bu
         b6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470777; x=1787075577;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91u0Za1hz/a5fH7FY4ulKiBG9M7w8xkSoB6NVMLvLQE=;
        b=riRTbF+LDiiWR/d4BYddtTohyVclkqNdA34+5TO1uw3UmFvO+KkFHgWyOm2ymA2oqS
         bD6dLob5RuVL6sHd+zkEhxvAFvUFOPRpzQpFhOyaVJ9SBOWFdgSLDoV7OqvsefnhRXHF
         nr5Kku4OaD8zC8hvF5mBVghMmbZRvH+s90L3YEYQAOef2vkSS5s1RZCDB78DLYQMcx4F
         zP4A8WiUyx1H9RHQWsfoblgOd2s1OS+86u4IJXmSOjjsZBNxGrjmYPUjtIrm7IYjp4w6
         Mcjl/1s/L5XKtccbEL/mhujo/+ZkKkpgAxyqWFhap/XxvK+fAZNbexazAX6HX7GdO+c4
         ZFIQ==
X-Gm-Message-State: AOJu0YyBr/khc4WE1CXyJlviH7+C2qEJaTtW0kwRSJTSABWK7QxyG5Ge
	D/WuxDHuY5UNfqmN4jJcswOrl0C2NESZUAwSX03OBjpq+pea88SSlCwWSzbvEx/v
X-Gm-Gg: AR+sD11nCaITzSyxeGYnes6oyFLMM9CtN6sESTnBW+OobLOCkVJvw1zcxCpGW8YOMKp
	PoZ6a/ooc7hs0Xg6FmTEwJpNYN2THZKwWHITYN8HKcdASNl+8vTaAT2xuPSeow8xcOvn/qKNcYq
	PbajM7J9kpWGVw4au9Vm4awQL7l6UaWaKPS8fD/tHwgo/2MHP5gPc7pljm2Hos34I4YwIc7Kdgk
	lsHbjkkMWiOqxXGO32gAuGrVJ3E9f3j4ZieM84dt3HkALfgTJg2t/prxYm76l4IvUYN3gzsKAyY
	jXUohZtNzesC61kMkc16LBYuX0+ql84R+Id2p3qCMouFUtT4pKsSfuaiTyfFIc/lyQQh7T9yYCD
	OK4bo+pbroN18tA1HEo/Qj0ZklVZokhQf6Ge4BLPq88Jd64uJWH5iedwWPgneYazouiJ0F6isup
	1/lSUsWjSmHV1XFi1KuF1CjxMsiUGXnMGVhaQt1p0JWyEjzHrIK7F/A0suOMu+RIvI99ju1SPl0
	ma3fziAjr0Y4di4Iu+6ahMaLWWhMPfl9x7VMynY0wcY4zJieA==
X-Received: by 2002:a05:6a20:244b:b0:3c3:b628:6d17 with SMTP id adf61e73a8af0-3cc2ba95c31mr5810436637.25.1786470776554;
        Tue, 11 Aug 2026 10:52:56 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d726f1sm2405112eec.26.2026.08.11.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:52:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: exercise veristat filtering logic in a selftest
Date: Tue, 11 Aug 2026 10:52:42 -0700
Message-ID: <20260811-veristat-filter-fix-v1-2-b5b43c431550@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com>
References: <20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Test cases for veristat file/prog name filtering logic.
Check various formulations for any (*foo*), file (*foo*/),
prog (/*bar*) and file/prog (*foo*/bar) filters, alongside
errorneous filters and mixed allow/deny filter expressions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/test_veristat.c       | 98 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/veristat_bar.c   |  3 +
 tools/testing/selftests/bpf/progs/veristat_foo.c   | 31 +++++++
 3 files changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 9aff08ac55c0..e1eda4ae755e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -37,6 +37,13 @@ static struct fixture *init_fixture(void)
 	return fix;
 }
 
+static void read_output(struct fixture *fix)
+{
+	ssize_t len = pread(fix->fd, fix->output, fix->sz - 1, 0);
+
+	fix->output[len < 0 ? 0 : len] = 0;
+}
+
 static void teardown_fixture(struct fixture *fix)
 {
 	free(fix->output);
@@ -230,6 +237,95 @@ static void test_no_array_index_for_array(void)
 	teardown_fixture(fix);
 }
 
+/*
+ * Name filter tests below run veristat on veristat_foo.bpf.o and
+ * veristat_bar.bpf.o, both defining programs 'foo', 'bar' and 'buz'.
+ * Every entry describes a single (filters, file, prog) combination and
+ * tells whether that program is expected in the veristat output:
+ * 'true' if it is, 'false' if it is not and -1 if veristat is expected
+ * to reject the filter.
+ */
+#define FILTER_OBJS "veristat_foo.bpf.o veristat_bar.bpf.o"
+
+static const struct name_filter_case {
+	const char *filters;
+	const char *file;
+	const char *prog;
+	int included;
+} name_filter_cases[] = {
+	/* no filters, every program is processed */
+	{ "",			"foo", "foo", true  },
+	{ "",			"foo", "bar", true  },
+	{ "",			"foo", "buz", true  },
+	{ "",			"bar", "foo", true  },
+	{ "",			"bar", "bar", true  },
+	{ "",			"bar", "buz", true  },
+	/* deny filters */
+	{ "-f '!*foo*'",	"foo", "bar", false },
+	{ "-f '!*foo*'",	"bar", "foo", false },
+	{ "-f '!*foo*/bar'",	"foo", "bar", false },
+	{ "-f '!*foo*/bar'",	"foo", "buz", true  },
+	{ "-f '!*foo*/bar'",	"bar", "bar", true  },
+	{ "-f '!*foo*/'",	"foo", "bar", false },
+	{ "-f '!*foo*/'",	"bar", "bar", true  },
+	{ "-f '!/bar'",		"foo", "bar", false },
+	{ "-f '!/bar'",		"foo", "foo", true  },
+	{ "-f '!/'",		"foo", "bar", -1    },
+	{ "-f '!'",		"foo", "bar", -1    },
+	/* allow filters */
+	{ "-f '*foo*'",		"foo", "bar", true  },
+	{ "-f '*foo*'",		"bar", "foo", true  },
+	{ "-f '*foo*/bar'",	"foo", "bar", true  },
+	{ "-f '*foo*/bar'",	"foo", "buz", false },
+	{ "-f '*foo*/bar'",	"bar", "bar", false },
+	{ "-f '*foo*/'",	"foo", "bar", true  },
+	{ "-f '*foo*/'",	"bar", "bar", false },
+	{ "-f '/bar'",		"foo", "bar", true  },
+	{ "-f '/bar'",		"foo", "foo", false },
+	{ "-f '/'",		"foo", "bar", -1    },
+	{ "-f ''",		"foo", "bar", -1    },
+	/* allow and deny filters combined */
+	{ "-f '*foo*/' -f '!/bar'", "foo", "foo", true  },
+	{ "-f '*foo*/' -f '!/bar'", "foo", "bar", false },
+	{ "-f '*foo*/' -f '!/bar'", "bar", "foo", false },
+};
+
+static void test_name_filters(void)
+{
+	struct fixture *fix = init_fixture();
+	const struct name_filter_case *t;
+	char cmd[512], row[64], name[128];
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(name_filter_cases); i++) {
+		t = &name_filter_cases[i];
+		/* stderr is merged with stdout in order to catch error messages */
+		snprintf(cmd, sizeof(cmd), "%s " FILTER_OBJS " -q -o csv -e file,prog %s > %s 2>&1",
+			 fix->veristat, t->filters, fix->tmpfile);
+		err = system(cmd);
+		read_output(fix);
+
+		snprintf(row, sizeof(row), "veristat_%s.bpf.o,%s", t->file, t->prog);
+		snprintf(name, sizeof(name), "veristat %s: %s", t->filters, row);
+		switch (t->included) {
+		case true:
+			ASSERT_OK(err, name);
+			ASSERT_HAS_SUBSTR(fix->output, row, name);
+			break;
+		case false:
+			ASSERT_OK(err, name);
+			ASSERT_FALSE(!!strstr(fix->output, row), name);
+			break;
+		case -1:
+			ASSERT_NEQ(err, 0, name);
+			ASSERT_HAS_SUBSTR(fix->output, "Invalid filter", name);
+			break;
+		}
+	}
+
+	teardown_fixture(fix);
+}
+
 void test_veristat(void)
 {
 	if (test__start_subtest("set_global_vars_succeeds"))
@@ -256,6 +352,8 @@ void test_veristat(void)
 	if (test__start_subtest("test_no_array_index_for_array"))
 		test_no_array_index_for_array();
 
+	if (test__start_subtest("name_filters"))
+		test_name_filters();
 }
 
 #undef __CHECK_STR
diff --git a/tools/testing/selftests/bpf/progs/veristat_bar.c b/tools/testing/selftests/bpf/progs/veristat_bar.c
new file mode 100644
index 000000000000..83d2a2a1dfc9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/veristat_bar.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include "veristat_foo.c"
diff --git a/tools/testing/selftests/bpf/progs/veristat_foo.c b/tools/testing/selftests/bpf/progs/veristat_foo.c
new file mode 100644
index 000000000000..bd24b97664b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/veristat_foo.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/*
+ * Programs below exist only to exercise veristat's -f name filters,
+ * their bodies are irrelevant, only the names matter.
+ * This file is also included by veristat_bar.c, so that the same set of
+ * program names is available in two differently named object files.
+ */
+
+SEC("socket")
+int foo(void *ctx)
+{
+	return 0;
+}
+
+SEC("socket")
+int bar(void *ctx)
+{
+	return 0;
+}
+
+SEC("socket")
+int buz(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0
