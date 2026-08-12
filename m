Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD31ED80
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514761; cv=none; b=eDEV+mByIheSe1HSZg5YbhwbqfOOo2+gj5BHIm1XpP0thr9kfC0TsQjm0UACozgVgoOekOR8/gKkqD4/ej/921Um+QP1/o90/knx2Whm+i1W9vvrAC3P1dOSteXm2H5vdiSzLSKwRpIXFqhz7BHtwgGVEm35g10VmtdhVu7kpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514761; c=relaxed/simple;
	bh=aNeuXNvXQjh2cAMesuKXs6cZfUoES8RuztBB2ygYqF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsZWgFzdBIlyyICLu6P/i3ZxPdSlYGKaE942NX1x18IDKHAWD5Euxz2hty1reaxHmk/zVzhJxbuorFr6NJ9oLs80qLBqGLFu7Ng2K/W/vjGB3Ua38DzkyKZ8PXl7WxpBwyf4Yz3zWbJ7Yj/rHdLJIVuTZUa8XrJU5XibiVR5QLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOUSzDSY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOUSzDSY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d049069377so6688335ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786514760; x=1787119560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s4f/kxvA4eKSxyhI6Q8ptv/aEyxRkGH33MqPUVeFTF8=;
        b=UOUSzDSY1vXqtEh/zqCUmEnLXdNtaqDbzCP9kHuSX/glK84lNjAUTso9W2AZnhQqFt
         oqfG8l5didp5Jm3AfGUMQOhxzw8zVTDV46NSoUb/evePTx4b0g4eI3AlIRCF9UTqGgqr
         0vfuIfkEC1vepAHqaSLhTEqKRH//LNuh/pL4/Dxi9oxKDc88UG+qIzsZFAU5+1W0xbsb
         XWQA1k48B+c3NSxUPmnCcHoQg+F+MoCNy2WSVRsNxOe8FOYWATnu0/w2D2BMRtXQULBG
         YuTBEz3mQdr+83eExinon554gtdIFJDGlBcLUebPPkMBesC/tTuxDfxxoXYV18OHOhlz
         +kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514760; x=1787119560;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4f/kxvA4eKSxyhI6Q8ptv/aEyxRkGH33MqPUVeFTF8=;
        b=gOejXQhlsInS1xTJ8bgiX040u5URNr7gvvD2lKiaPrXdz9Bl20qCSuKxft7HGKrDFA
         XjapGoOeOMqNnzQqdm0V0xVB4FnP43EJYrYOzav8SAaz/lzvjmvZqGS7l6yWMiqmoSTz
         igU/lsNeZolTbFr60kpJewOkIU6de9+5yQMcwaaKWXoQ0k7yg73tSwc1MbB8f8dTN8qn
         Vw58dXi7W68odLPOutwbxu544TBUqU6d4SBHCKijpi5owPYiufIQMbXNPGopSDX8cK1i
         uX+B6mtxcXYz3HMOAQDdnf+Q6+Z++bj02q3CxgTVQwFfS0NHQoAGvRSMd7VjlvJSXvhC
         +CPQ==
X-Gm-Message-State: AOJu0YxI3yUs4SSdSjNMj0qQsaGMNCwD7R5y7NwXXDQOpRozxgEDc5fl
	15QyCVrGPb9HxR7APQXO46hzyMoutz/BGfij39C1a/wAAaBNS09HiEVNkYUv7bE2
X-Gm-Gg: AR+sD13IZnsuqOYFfxT4/vjhBFSpNXweFxUjyv4KfcyXNRLvpRKDrvmLMzX3vDsBvo9
	xMOfcvofCx6+yIAhrakKVFtBhU6mYTwhvLLYQTeqCRCPN5fEu/XQGHtZ3i4JoPrJprZI4fWMKFy
	1I/q92q85B/1xjKJMSnxIQJYRAPxbkkxJ9K+nStBSPD5VdZmQa/ceQP5y7a6pyPm02k+qEjR1fN
	J6neC9Ew21VE8xcSj6MU84keL92l209B4TWoD8vpRBdZtbRNwszdhZ2L4XUZH/BpgRi7i0nzymD
	taVaNBXsKU+Iw0FTk1/d7miP6dxZ4CCf4pa+IK7nxwdoZOIouaNM77+H5wZMuLXsaL4Q17jpIlQ
	XGS5xvgdU+lmXKZtd1HHgLYrBaZ/GynVUkhHdq1ul06tzsVBB+wweqjn9s/n+XSVLYSqelSqkXV
	KDKXMwLOgdvD47ms1yia9A6h/6FxTrW5a44AAYIcMQxBxzrpJH/fPlPo3MMNeq+1TuKCg+3KD+J
	JEjUQ==
X-Received: by 2002:a17:90b:5443:b0:381:528a:808c with SMTP id 98e67ed59e1d1-393014fde42mr2870551a91.12.1786514759531;
        Tue, 11 Aug 2026 23:05:59 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d1e8csm2314520a91.5.2026.08.11.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:05:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: exercise veristat filtering logic in a selftest
Date: Tue, 11 Aug 2026 23:05:43 -0700
Message-ID: <20260811-veristat-filter-fix-v2-2-6c234c4cd6ef@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
References: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
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
prog (/bar) and file/prog (*foo*/bar) filters, alongside
erroneous filters and mixed allow/deny filter expressions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/test_veristat.c       | 101 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/veristat_bar.c   |   3 +
 tools/testing/selftests/bpf/progs/veristat_foo.c   |  31 +++++++
 3 files changed, 135 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 9aff08ac55c0..4cd41080eed3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -37,6 +37,14 @@ static struct fixture *init_fixture(void)
 	return fix;
 }
 
+static void read_output(struct fixture *fix)
+{
+	ssize_t len = pread(fix->fd, fix->output, fix->sz - 1, 0);
+
+	fix->output[len < 0 ? 0 : len] = 0;
+	ASSERT_GE(len, 0, "pread");
+}
+
 static void teardown_fixture(struct fixture *fix)
 {
 	free(fix->output);
@@ -230,6 +238,97 @@ static void test_no_array_index_for_array(void)
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
+	{ "-f '!*foo*'",	"bar", "bar", true  },
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
+	{ "-f '*foo*'",		"bar", "bar", false },
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
@@ -256,6 +355,8 @@ void test_veristat(void)
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
2.53.0
