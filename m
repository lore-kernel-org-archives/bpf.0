Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80B4C33E1
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977553; cv=none; b=TR/Lq/uHYGFa0Jxf7N8E+ySOn33apM6+LdTlhsQ83HFskIU9pCM+8372bhM3W/UKsFYWDhPf07WPKQGLGYwzrGOqiOeXO40CoqMuzr2Sbh6O3/Vn2qTH6qVC3l8w7nbP6P4Z6XEEwmrMjMsOv7yxGqUghuCikr6gkuOlHqrb1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977553; c=relaxed/simple;
	bh=TyPPOwItSaDlf4TkZfOdgVWrpgx12V89501xfmwsMX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7tMKbV8Ze9ORNFvQGlnTICnFfXv3xiXLnNFDY7SSyyFe1PcaLrxFKSMOLEzGwmbMMe1D/hYDdgQOCg7VvJLBBeoO2atk1EfwVU4I3FbSAa4xG6R0jsThJGGwfPHctQeZ/buFQc7OrcMIAf8H7MN4XIoN6gOC+ZZGyO0euO5vz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqCX0ojm; arc=none smtp.client-ip=95.215.58.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XqCX0ojm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TyPPOwItSaDlf4TkZfOdgVWrpgx12V89501xfmwsMX4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977550; v=1; x=1792582350;
 b=XqCX0ojmnZclNX7wDHWMOYx2lQnDmz4SXzLOT+4kfTU35kTdekPAY0HwoVm224Gbfp4MwS2t
 33bV84krAe2LHEt+mUgIAzhaE6tKMlr/F4H9jGpCL4mHvUD7qXpmmlEJ7qXwSkxIYOBWfi6L1ak
 XAxQVTsuo7ZFQ04vvnBGNPb8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 6e9e8d5fdee6a166;
	Wed, 14 Oct 2026 11:32:29 +0000
X-Mizu-Trace-ID: 6e9e8d5fdee6a166
X-Migadu-Flow: FLOW_OUT
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KaFai Wan <kafai.wan@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Feng Jiang <jiangfeng@kylinos.cn>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: Fix prog_tests framework subtest count checks
Date: Wed, 14 Oct 2026 19:30:41 +0800
Message-ID: <20261014113043.640435-6-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014113043.640435-1-kafai.wan@linux.dev>
References: <20261014113043.640435-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardcoded expected skip_cnt/error_cnt in test_prog_tests_framework()
mismatch the real count when the binary is run with -t or -n filters,
since some subtests are not selected. Count the executed subtests and
compare against that value instead.

Fixes: 2324257dbd68 ("selftests/bpf: Refactor prog_tests logging and test execution")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/prog_tests/prog_tests_framework.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index d111fe1054476..53347f3799245 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -13,6 +13,7 @@ static void clear_test_state(struct test_state *state)
 void test_prog_tests_framework(void)
 {
 	struct test_state *state = env.test_state;
+	int subtest_cnt;
 
 	/* in all the ASSERT calls below we need to return on the first
 	 * error due to the fact that we are cleaning the test state after
@@ -30,25 +31,30 @@ void test_prog_tests_framework(void)
 		return;
 	clear_test_state(state);
 
+	subtest_cnt = 0;
 	if (test__start_subtest("test_skip_subtest")) {
 		test__skip();
 		test__end_subtest();
+		subtest_cnt++;
 	}
 	if (test__start_subtest("test_skip_subtest")) {
 		test__skip();
 		test__end_subtest();
+		subtest_cnt++;
 	}
-	if (!ASSERT_EQ(state->skip_cnt, 2, "skip_cnt_check"))
+	if (!ASSERT_EQ(state->skip_cnt, subtest_cnt, "skip_cnt_check"))
 		return;
 	if (!ASSERT_EQ(state->subtest_num, 3, "subtest_num_check"))
 		return;
 	clear_test_state(state);
 
+	subtest_cnt = 0;
 	if (test__start_subtest("test_fail_subtest")) {
 		test__fail();
 		test__end_subtest();
+		subtest_cnt++;
 	}
-	if (!ASSERT_EQ(state->error_cnt, 1, "error_cnt_check"))
+	if (!ASSERT_EQ(state->error_cnt, subtest_cnt, "error_cnt_check"))
 		return;
 	if (!ASSERT_EQ(state->subtest_num, 4, "subtest_num_check"))
 		return;
-- 
2.43.0

