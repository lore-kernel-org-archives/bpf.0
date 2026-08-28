Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C0394EBD
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953952; cv=none; b=j7gxiVWv/UTRERv8qd4e5bjgAwZkbvgQ3iDohMFqntUp1qWk2Orzpzs4ahP8QVUsW0hxUOeQkdvsC0ekkiTZiuK+tzur10PSZmQ81yzFHmGFJ7IYSby8WMGhdrGrHWJlMxyrxWrn0pkBtmahMMk5pI5Qw2I9cVpJ/1rjMs3AWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953952; c=relaxed/simple;
	bh=sMJalm7GSf7bT/osn7fY/sWgIaW2hJdoez5kicoAnBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcaS5ROlfwQS13//KkeAvKdDbC/+KJAbd/jYpZxSMBGhsqOKj4+/L+siuk3BSONSJ4UmajqkpA0T7ZJAzxV/YTFwjO1IXYzTGylNrW//RtV9GQSmMH71/j7FV/ZmUxHoxzlMoI/uohbjvliW14O8B7dmNEt2ASDYoC2tUbMmseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NtS++WtA; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtS++WtA"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sMJalm7GSf7bT/osn7fY/sWgIaW2hJdoez5kicoAnBQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953948; v=1; x=1788558748;
 b=NtS++WtAZ+wK338N7vDJc/HtuJt5ccPNzZ7yY5NRGFVbOdgljIJVHv1ErzKE1LO+w0ZzNt3d
 1gw677arLpfMI3I8JCFteDDMq/yrXpnxJIW4J32+Ur7m8GfUrmDLBlYOoGBlsqxE0DzC7Vtwk+Q
 Zdq7NhuRHMxI5Ks/NwL/3i9A=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 87a5c2da3bdcad58;
	Fri, 28 Aug 2026 21:52:28 +0000
X-Mizu-Trace-ID: 87a5c2da3bdcad58
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/6] selftests/bpf: Compare btf_dump expected output in-process
Date: Fri, 28 Aug 2026 14:52:04 -0700
Message-ID: <20260828215207.3105313-4-ihor.solodrai@linux.dev>
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

test_btf_dump_case() writes the dumped types to a temporary file and
then runs a command against the expectation:

	system("awk '...' 'progs/x.c' | diff -u - '/tmp/x.output.XXXXXX'");

This creates three processes per test case: a shell, awk and diff. The
awk cannot be deferred to the failure path, because its output is the
expected text.

In a VM with a 9p root (used on BPF CI) process creation dominates the
cost. A bare fork+exec measures around 110ms, so the btf_dump test
cases spend most of their runtime forking.

Replace the awk pipeline with a simple marker parser. Buffer the dump
in memory, and use compare_text_to_expected(), which only runs diff(1)
on mismatch.

Measured with "time ./test_progs -t btf_dump" in the VM:

	real 2.751s -> 0.702s, sys 1.901s -> 0.193s

This also drops the temporary file setup.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 112 +++++++++++++-----
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index e9d2d4c26509..fe04a955d46c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include "testing_helpers.h"
 
 void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 {
@@ -43,12 +44,75 @@ static int btf_dump_all_types(const struct btf *btf, void *ctx)
 	return err;
 }
 
+/*
+ * Expected output is embedded in the test case source, between
+ * START-EXPECTED-OUTPUT and END-EXPECTED-OUTPUT markers. A region is either
+ * plain C, where a declaration doubles as its own expectation, or C wrapped in
+ * a block comment, where the rendered form differs from the source. All
+ * regions of a file concatenate into one expectation, compared against one
+ * whole-file dump.
+ *
+ * Returns a malloc'd buffer for the caller to free, or NULL on failure.
+ */
+static char *read_expected_output(const char *path)
+{
+	size_t out_sz = 0, line_cap = 0;
+	char *out = NULL, *line = NULL;
+	bool in_region = false;
+	FILE *f, *out_file;
+
+	f = fopen(path, "r");
+	if (!f)
+		return NULL;
+
+	out_file = open_memstream(&out, &out_sz);
+	if (!out_file) {
+		fclose(f);
+		return NULL;
+	}
+
+	while (getline(&line, &line_cap, f) > 0) {
+		const char *p;
+
+		if (strstr(line, "START-EXPECTED-OUTPUT")) {
+			in_region = true;
+			continue;
+		}
+		if (strstr(line, "END-EXPECTED-OUTPUT"))
+			in_region = false;
+		if (!in_region)
+			continue;
+
+		p = line + strspn(line, " \t");
+
+		/* opening or closing line of a commented out region */
+		if (!strncmp(p, "/*", 2) || !strncmp(p, "*/", 2))
+			continue;
+
+		/*
+		 * Only a '*' directly after the indentation is a comment
+		 * prefix. Without one the line is taken as it is, leading
+		 * whitespace included.
+		 */
+		p = *p == '*' ? p + 1 : line;
+
+		fputs(p, out_file);
+	}
+
+	free(line);
+	fclose(f);
+	fclose(out_file);
+	return out;
+}
+
 static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 {
-	char test_file[256], out_file[256], diff_cmd[1024];
+	char *dump = NULL, *expected = NULL;
 	struct btf *btf = NULL;
-	int err = 0, fd = -1;
-	FILE *f = NULL;
+	char test_file[256];
+	size_t dump_sz = 0;
+	int err = 0;
+	FILE *f;
 
 	snprintf(test_file, sizeof(test_file), "%s.bpf.o", t->file);
 
@@ -72,21 +136,14 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		ASSERT_EQ(ptr_sz, (size_t)8, "ptr_sz");
 	}
 
-	snprintf(out_file, sizeof(out_file), "/tmp/%s.output.XXXXXX", t->file);
-	fd = mkstemp(out_file);
-	if (!ASSERT_GE(fd, 0, "create_tmp")) {
-		err = fd;
-		goto done;
-	}
-	f = fdopen(fd, "w");
-	if (!ASSERT_OK_PTR(f, "open_tmp")) {
-		close(fd);
+	f = open_memstream(&dump, &dump_sz);
+	if (!ASSERT_OK_PTR(f, "open_memstream")) {
+		err = -errno;
 		goto done;
 	}
 
 	err = btf_dump_all_types(btf, f);
 	fclose(f);
-	close(fd);
 	if (!ASSERT_OK(err, "btf_dump"))
 		goto done;
 
@@ -97,28 +154,23 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		 * without preserving the directory structure.
 		 */
 		snprintf(test_file, sizeof(test_file), "%s.c", t->file);
-	/*
-	 * Diff test output and expected test output, contained between
-	 * START-EXPECTED-OUTPUT and END-EXPECTED-OUTPUT lines in test case.
-	 * For expected output lines, everything before '*' is stripped out.
-	 * Also lines containing comment start and comment end markers are
-	 * ignored. 
-	 */
-	snprintf(diff_cmd, sizeof(diff_cmd),
-		 "awk '/START-EXPECTED-OUTPUT/{out=1;next} "
-		 "/END-EXPECTED-OUTPUT/{out=0} "
-		 "/\\/\\*|\\*\\//{next} " /* ignore comment start/end lines */
-		 "out {sub(/^[ \\t]*\\*/, \"\"); print}' '%s' | diff -u - '%s'",
-		 test_file, out_file);
-	err = system(diff_cmd);
-	if (!ASSERT_OK(err, "diff")) {
-		fprintf(stdout, "output=%s, diff cmd:\n%s\n", out_file, diff_cmd);
+
+	expected = read_expected_output(test_file);
+	if (!ASSERT_OK_PTR(expected, "read_expected_output")) {
+		err = -errno;
 		goto done;
 	}
 
-	remove(out_file);
+	/*
+	 * The mismatch has already been reported, so this only has to
+	 * register the failure. ASSERT_OK() would append a stale errno to it.
+	 */
+	err = compare_text_to_expected(dump, expected);
+	ASSERT_EQ(err, 0, "compare_text_to_expected");
 
 done:
+	free(expected);
+	free(dump);
 	btf__free(btf);
 	return err;
 }
-- 
2.55.0

