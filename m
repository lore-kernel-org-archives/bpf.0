Received: from mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44D346766
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953949; cv=none; b=Vm7jINeJjQaR/R3Bs+Tv+RIamgna6UDfzrhX3dJcQzgjGb3elIpJDhWY37FDIvwzw4xD/LjOyE0f910NDNmBhX5vsamt6BvzxSwD+9FZvdJuR8WggdClsYBvZAcDN29VKYtfLjwhjutzjDht5ZFWMz7RvJF8+tUfehR9UMtPHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953949; c=relaxed/simple;
	bh=xxySGoKLfAI6RpBk5D+eMWwbrDo9d6NVjU1xBQH4SWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9Ume0znzuk59Qi6sbA0zQEd1GWpn/YHmmxnN91It7LfXV8gw7IydGFUwaWhbykYC8y+LZoYmLMkkRwqKmthfISniWn5tfsdciEkGXyGHRHKQ1tyrxCy3MO4rCVs40PUh3BJqoVDCgNRhFbYcz6vwg4Moed1CXz2HKlJG6/1AxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sz6rAQ5b; arc=none smtp.client-ip=91.218.175.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sz6rAQ5b"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xxySGoKLfAI6RpBk5D+eMWwbrDo9d6NVjU1xBQH4SWQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953945; v=1; x=1788558745;
 b=Sz6rAQ5bBUo1i5kUGK2hHuVslAajtGOXG8Rq5slHSXNzynMGMWHNGtIc76mFN6NgnKduuLxe
 Z9f6sQBD2ATzT9lARUfK7LwswJROZWwLz/wwWlIL5B++u1ZWSrsXJBv/aJZ+J5sQNHexkfuBLjL
 3ybi1mK8Z4sg+7FgwpCf88hY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 38af564fdd1b06de;
	Fri, 28 Aug 2026 21:52:25 +0000
X-Mizu-Trace-ID: 38af564fdd1b06de
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/6] selftests/bpf: Modernize btf_dump test scaffolding
Date: Fri, 28 Aug 2026 14:52:03 -0700
Message-ID: <20260828215207.3105313-3-ihor.solodrai@linux.dev>
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

Refactor test_btf_dump_case() in order to:
  * use newer ASSERT_* macros instead of CHECK
  * drop the file-scope "duration" variable CHECK required

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 9f1b50e07a29..e9d2d4c26509 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -2,8 +2,6 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
 
-static int duration = 0;
-
 void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 {
 	vfprintf(ctx, fmt, args);
@@ -69,8 +67,9 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 	if (!t->known_ptr_sz) {
 		btf__set_pointer_size(btf, 8);
 	} else {
-		CHECK(btf__pointer_size(btf) != 8, "ptr_sz", "exp %d, got %zu\n",
-		      8, btf__pointer_size(btf));
+		size_t ptr_sz = btf__pointer_size(btf);
+
+		ASSERT_EQ(ptr_sz, (size_t)8, "ptr_sz");
 	}
 
 	snprintf(out_file, sizeof(out_file), "/tmp/%s.output.XXXXXX", t->file);
@@ -80,8 +79,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 	f = fdopen(fd, "w");
-	if (CHECK(f == NULL, "open_tmp",  "failed to open file: %s(%d)\n",
-		  strerror(errno), errno)) {
+	if (!ASSERT_OK_PTR(f, "open_tmp")) {
 		close(fd);
 		goto done;
 	}
@@ -89,9 +87,8 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 	err = btf_dump_all_types(btf, f);
 	fclose(f);
 	close(fd);
-	if (CHECK(err, "btf_dump", "failure during C dumping: %d\n", err)) {
+	if (!ASSERT_OK(err, "btf_dump"))
 		goto done;
-	}
 
 	snprintf(test_file, sizeof(test_file), "progs/%s.c", t->file);
 	if (access(test_file, R_OK) == -1)
@@ -114,10 +111,10 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		 "out {sub(/^[ \\t]*\\*/, \"\"); print}' '%s' | diff -u - '%s'",
 		 test_file, out_file);
 	err = system(diff_cmd);
-	if (CHECK(err, "diff",
-		  "differing test output, output=%s, err=%d, diff cmd:\n%s\n",
-		  out_file, err, diff_cmd))
+	if (!ASSERT_OK(err, "diff")) {
+		fprintf(stdout, "output=%s, diff cmd:\n%s\n", out_file, diff_cmd);
 		goto done;
+	}
 
 	remove(out_file);
 
-- 
2.55.0

