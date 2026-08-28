Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123C322B9F
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953948; cv=none; b=YYc4Axu04U+1MYkD5DAmxEHuFxmwIUpVT5aRxMqy6GLg6YS7oKvkwlTahJn4KiSxS23o/uUN60bDspxvq7FmrSJvvdIhfZDiyoEYFk96jy6LFH0eAQwPoaOBdSsGX/S88eagRiciE/Rb5LwDTPiO+M/sDRJPkyjzCqsftcK2PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953948; c=relaxed/simple;
	bh=RLvhD2IQRPjrjot38S6Da7Em+gHjxODDcLmCwL9GRCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn5KNf++W9jHa/uRDgTDjsy973TQvCbFYV3fcBcmVwN2oEnH35qt9RPO/2CLY0ZFgAdrQy+mYtvOsXrfiXpagPKlIJtrPH5MJL2Pcf2wv1/lMwgxDQi4SbCk805+Oo8bDVmEcHGRGkUwRMnjb4f5t1VkEnVHHgTFZmiHEIj+gMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fv9eBTyY; arc=none smtp.client-ip=95.215.58.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fv9eBTyY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RLvhD2IQRPjrjot38S6Da7Em+gHjxODDcLmCwL9GRCA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953943; v=1; x=1788558743;
 b=Fv9eBTyYAyISpvsOuS3v0pYxair+G7JB3B1kpcZbw1LvlRzf+wDSwLoax6g1rNXoppRN9dwz
 xdk8cG+2Fc76ryZYNBDcFrDW5x/OhYy3DUHx/9M2o8b1ajCJfrSCbWGyKKfjHNLOpVx85NyEXdp
 gKtZ7yB1gRbiTHsgHbw7sXIw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0b8b57ec76cd66e5;
	Fri, 28 Aug 2026 21:52:23 +0000
X-Mizu-Trace-ID: 0b8b57ec76cd66e5
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] selftests/bpf: Add compare_text_to_expected() helper
Date: Fri, 28 Aug 2026 14:52:02 -0700
Message-ID: <20260828215207.3105313-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
References: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some selftests generate text (such as BTF dump) and check it against
an expectation committed nearby.

There is no shared way to do that. prog_tests/btf_dump.c assembles an
"awk ... | diff -u" pipeline and hands it to system(). Any other test
wanting the same behaviour needs to reproduce both the comparison and
the reporting of a mismatch.

test_progs captures per-subtest output by pointing the stdout and
stderr FILE * globals at a memstream. But a child process inherits
descriptors, not the globals. So the "| diff -u" goes to the console
instead of the subtest log and is absent from the failure report.

Add a helper that compares two strings and runs diff(1) on mismatch,
properly relaying the output to stdout. Add tests for the helper.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/prog_tests_framework.c     | 23 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 43 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  3 ++
 3 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index 7607cfc2408c..d111fe105447 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -179,3 +179,26 @@ void test_prog_tests_framework_expected_msgs(void)
 		}
 	}
 }
+
+void test_prog_tests_framework_compare_text(void)
+{
+	int err;
+
+	if (test__start_subtest("compare_text_match")) {
+		err = compare_text_to_expected("same\n", "same\n");
+		ASSERT_EQ(err, 0, "match_rc");
+		test__end_subtest();
+	}
+
+	if (test__start_subtest("compare_text_mismatch")) {
+		err = compare_text_to_expected("line two\n", "line one\n");
+		fflush(stdout);
+
+		ASSERT_EQ(err, -1, "mismatch_rc");
+		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "-line one",
+				  "diff_has_expected");
+		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "+line two",
+				  "diff_has_actual");
+		test__end_subtest();
+	}
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index c970e7793dfc..3f037949e978 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -534,3 +534,46 @@ int stack_mprotect(void)
 		       PROT_READ | PROT_WRITE | PROT_EXEC);
 	return ret;
 }
+
+int compare_text_to_expected(const char *actual, const char *expected)
+{
+	char exp_path[] = "/tmp/selftest_expected.XXXXXX";
+	char act_path[] = "/tmp/selftest_actual.XXXXXX";
+	char buf[512], cmd[128];
+	int exp_fd, act_fd;
+	FILE *p;
+
+	if (!strcmp(actual, expected))
+		return 0;
+
+	exp_fd = mkstemp(exp_path);
+	act_fd = mkstemp(act_path);
+	if (exp_fd < 0 || act_fd < 0) {
+		fprintf(stdout, "output differs, no temp file for a diff\n");
+		goto out;
+	}
+
+	dprintf(exp_fd, "%s", expected);
+	dprintf(act_fd, "%s", actual);
+
+	snprintf(cmd, sizeof(cmd), "diff -u '%s' '%s'", exp_path, act_path);
+	p = popen(cmd, "r");
+	if (!p) {
+		fprintf(stdout, "output differs, '%s' did not run\n", cmd);
+		goto out;
+	}
+	while (fgets(buf, sizeof(buf), p))
+		fputs(buf, stdout);
+	pclose(p);
+
+out:
+	if (exp_fd >= 0) {
+		close(exp_fd);
+		unlink(exp_path);
+	}
+	if (act_fd >= 0) {
+		close(act_fd);
+		unlink(act_path);
+	}
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 2edc6fb7fc52..1c58a2f08b64 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -61,4 +61,7 @@ int testing_prog_flags(void);
 bool is_jit_enabled(void);
 int stack_mprotect(void);
 
+/* Runs diff(1) on mismatch */
+int compare_text_to_expected(const char *actual, const char *expected);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.55.0

