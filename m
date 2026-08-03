Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DA41D122
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776600; cv=none; b=GE2tou+IJds+Vl2eYMWX+urk281fzRlu3b5svLHCIHqJBuUkoWLxQyPGOFnrGsAIYqy02DtsNXWHHp/MmAr8+VN6bBu9JVHnYQu8pxaJf4C9kzQImzQGvLcBCex5kUsvrJKQXWypxdfzuK0jn8u2RNjSLSq8ONmAg/DFh7kv71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776600; c=relaxed/simple;
	bh=YueUsyAPM50kr+tvjkqG3/IXAA21hvRsOkbvnXAcEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nygLAfGkG/3QGFHoYQl9dC1p2GoVc0DWQoK+EFZWfXywG6kJtnYByRlVgniqfUsZVQi+ywTcgy0NenhQGVaklMhB3XsuZeAhvhvgLGwZFdl32ie5NDRf7qy1nsBfFQy1xQvjK/+97pQCSeyVwF35mNgMLvAvFs5+2Zt+dAEFkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WON1VA4b; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WON1VA4b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785776588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJo3x4oawUqd8sXksvOFjNdRI29zIVI6gG2AIfHhMaU=;
	b=WON1VA4bRSTlhb48VjXwsIj1EIkInNjYb72OPM9nwq1ClA3B7LyWbZQwQc5DRx1tjvrA4E
	tVpLYWMzoJ1cW2c972UOpzFMYcyCa4G9rZWCLjxjhmcz9XeBkc29BgIikVxJytcMa2qiAZ
	HNZT3GBvWGLfeeouvAlM8AR8vJiXHNc=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [bpf-next 3/4] selftests/bpf: report failed subtest count in test_progs summary
Date: Mon,  3 Aug 2026 10:02:50 -0700
Message-ID: <20260803170251.1898102-4-vineet.gupta@linux.dev>
In-Reply-To: <20260803170251.1898102-1-vineet.gupta@linux.dev>
References: <20260803170251.1898102-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The final summary line is asymmetric: the PASSED field reports both the
number of top-level tests and the number of subtests within them, while
the FAILED field reports only top-level tests:

  Summary: 640/5750 PASSED, 7760 SKIPPED, 100 FAILED

There is no way to tell whether those 100 failing tests amount to 100
broken subtests or 1000. So count subtests with a non-zero error_cnt
into a new sub_fail_cnt and print it alongside fail_cnt:

  Summary: 640/5750 PASSED, 7760 SKIPPED, 100/342 FAILED
                                             ^^^^^

This is correct for -j runs, as subtest_states[] is populated both in
sequential and parallel modes.

A test that fails without declaring any subtests contributes 0 to
sub_fail_cnt. That mirrors the existing behaviour of sub_succ_cnt for
tests that pass without subtests, keeping the two numerators
comparable.

Also emit the new count as a "failed_subtest" field in the JSON output,
for parity with the existing "success_subtest".

Note that this changes the trailing field of the summary line from a bare
integer to "A/B", so anything scraping "N FAILED" out of it needs updating.
While here, fix the fail_cnt comment in struct test_env, which claims it
counts "total failed tests + sub-tests".

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/test_progs.c | 21 +++++++++++++--------
 tools/testing/selftests/bpf/test_progs.h |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 8ee46745e2e8..5e2f6ec2e212 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1656,8 +1656,8 @@ static void *dispatch_thread(void *ctx)
 
 static void calculate_summary_and_print_errors(struct test_env *env)
 {
-	int i;
-	int succ_cnt = 0, fail_cnt = 0, sub_succ_cnt = 0, skip_cnt = 0;
+	int i, j;
+	int succ_cnt = 0, fail_cnt = 0, sub_succ_cnt = 0, sub_fail_cnt = 0, skip_cnt = 0;
 	json_writer_t *w = NULL;
 
 	for (i = 0; i < prog_test_cnt; i++) {
@@ -1670,10 +1670,14 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 		sub_succ_cnt += state->sub_succ_cnt;
 		skip_cnt += state->skip_cnt;
 
-		if (state->error_cnt)
+		if (state->error_cnt) {
 			fail_cnt++;
-		else if (!test->not_built)
+			for (j = 0; j < state->subtest_num; j++)
+				if (state->subtest_states[j].error_cnt)
+					sub_fail_cnt++;
+		} else if (!test->not_built) {
 			succ_cnt++;
+		}
 	}
 
 	if (env->json) {
@@ -1688,6 +1692,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 		jsonw_uint_field(w, "success_subtest", sub_succ_cnt);
 		jsonw_uint_field(w, "skipped", skip_cnt);
 		jsonw_uint_field(w, "failed", fail_cnt);
+		jsonw_uint_field(w, "failed_subtest", sub_fail_cnt);
 		jsonw_name(w, "results");
 		jsonw_start_array(w);
 	}
@@ -1726,12 +1731,12 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 		fclose(env->json);
 
 	if (env->not_built_cnt)
-		printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d FAILED\n",
+		printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d/%d FAILED\n",
 		       succ_cnt, sub_succ_cnt, skip_cnt, env->not_built_cnt,
-		       fail_cnt);
+		       fail_cnt, sub_fail_cnt);
 	else
-		printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-		       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
+		printf("Summary: %d/%d PASSED, %d SKIPPED, %d/%d FAILED\n",
+		       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt, sub_fail_cnt);
 
 	env->succ_cnt = succ_cnt;
 	env->sub_succ_cnt = sub_succ_cnt;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index e66d5c457901..ea493c477fbd 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -124,7 +124,7 @@ struct test_env {
 
 	int succ_cnt; /* successful tests */
 	int sub_succ_cnt; /* successful sub-tests */
-	int fail_cnt; /* total failed tests + sub-tests */
+	int fail_cnt; /* failed tests */
 	int skip_cnt; /* skipped tests */
 	int not_built_cnt; /* tests not built */
 
-- 
2.55.0

