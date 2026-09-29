Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F124F55AB
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725595; cv=none; b=aaJDf438UFEbahYtm0D8dMpe5mqvGdO9B0+3kUhg8iN4l9FQkydnk3PG90tUsVxKSy1satWSLuuaFThVZzJRK7mDkw6y7y2QopXvRsMA94waWr5TjEr/FbNSnUhFPlLI0wcETOojPOkbG5PJngFLu6SrWnTxFce+upufAuW2rT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725595; c=relaxed/simple;
	bh=QVwkF7ASyD32wEA19tSSqNA0YWdRMWqliDWqQCPybw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXVFDN0G1vDigaOgmRKnmmVwQQVYl7yg1DZoP0r9D9Q9fmGiQCK82tSwkk1Tn7sFw3/VBkU9vz7inWRqTG+GTyyrtKb2QQCLbsFew04nm0+AXZ8jagwzMfb+ateqaVXVoRVoZI4308Wf+KjBCES1dR0A5WlmbfniAqMQBwJVtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fPENr7NW; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fPENr7NW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QVwkF7ASyD32wEA19tSSqNA0YWdRMWqliDWqQCPybw0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725591; v=1; x=1791330391;
 b=fPENr7NWZUd1EYyl4rXNYVvbCagRtvDCLSAD5j5DppvO8cPLsMYGJGMFpAvxhYkUrMTd2zfR
 nGG/osAGqhAl6gnozn6WVpYMFBYY21X7rEpEUc2Y8wKwDunW4tzeW4SveUz1aQZLvwYyRRU5Fgm
 1B65TrZYvxggSy0c2Gc3HcYs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id feca7e19f65b7140;
	Tue, 29 Sep 2026 23:46:31 +0000
X-Mizu-Trace-ID: feca7e19f65b7140
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add ASSERT_TEXT_EQ()
Date: Tue, 29 Sep 2026 16:46:06 -0700
Message-ID: <20260929234608.48503-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929234608.48503-1-ihor.solodrai@linux.dev>
References: <20260929234608.48503-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Text comparisons in test_progs repeat the same two statements:
compare_text_to_expected() to print the diff, then an assert to record
the failure. ASSERT_OK() on the raw return also appends a stale errno
to the failure output.

Add ASSERT_TEXT_EQ() after ASSERT_HAS_SUBSTR(). The assert cannot move
into compare_text_to_expected() itself: the helper is linked into
standalone binaries without test__fail(), and the framework unit test
checks the raw mismatch return. Convert the 3 test_progs call sites
plus test_ctx__dump_and_compare(), so multi-line dumps fail with a
diff; prog_tests_framework.c keeps calling the helper directly.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/bpftool_btf_dump.c  | 6 ++----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c        | 9 ++-------
 tools/testing/selftests/bpf/test_progs.h                 | 3 +++
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index abc62958b6ed..534aa79a4278 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -207,7 +207,6 @@ static void test_dump(const char *btf_path, bool sorted)
 {
 	const char *exp_path;
 	char *dump, *exp;
-	int err;
 
 	exp_path = sorted ? EXPECTED_SORTED : EXPECTED_UNSORTED;
 
@@ -219,8 +218,7 @@ static void test_dump(const char *btf_path, bool sorted)
 	if (!exp)
 		goto out_dump;
 
-	err = compare_text_to_expected(dump, exp);
-	ASSERT_OK(err, sorted ? "cmp_sorted" : "cmp_unsorted");
+	ASSERT_TEXT_EQ(dump, exp, sorted ? "cmp_sorted" : "cmp_unsorted");
 
 	free(exp);
 out_dump:
@@ -260,7 +258,7 @@ static void test_loc_dump(const char *btf_path)
 	if (!dump)
 		return;
 
-	ASSERT_OK(compare_text_to_expected(dump, expected), "cmp_loc_dump");
+	ASSERT_TEXT_EQ(dump, expected, "cmp_loc_dump");
 	free(dump);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index fe04a955d46c..838f7232f591 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -161,12 +161,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 
-	/*
-	 * The mismatch has already been reported, so this only has to
-	 * register the failure. ASSERT_OK() would append a stale errno to it.
-	 */
-	err = compare_text_to_expected(dump, expected);
-	ASSERT_EQ(err, 0, "compare_text_to_expected");
+	ASSERT_TEXT_EQ(dump, expected, "compare_text_to_expected");
 
 done:
 	free(expected);
@@ -224,7 +219,7 @@ static void test_ctx__dump_and_compare(struct test_ctx *t,
 	fflush(t->dump_buf_file);
 	t->dump_buf[t->dump_buf_sz] = 0; /* some libc implementations don't do this */
 
-	ASSERT_STREQ(t->dump_buf, expected_output, message);
+	ASSERT_TEXT_EQ(t->dump_buf, expected_output, message);
 }
 
 static void test_btf_dump_incremental(void)
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index ea493c477fbd..adc18f5eceb6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -349,6 +349,9 @@ void hexdump(const char *prefix, const void *buf, size_t len);
 	___ok;								\
 })
 
+#define ASSERT_TEXT_EQ(actual, expected, name) \
+	ASSERT_TRUE(compare_text_to_expected(actual, expected) == 0, name)
+
 #define ASSERT_MEMEQ(actual, expected, len, name) ({			\
 	static int duration = 0;					\
 	const void *__act = actual;					\
-- 
2.50.1

