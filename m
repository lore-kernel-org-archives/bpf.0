Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B043A5430
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977562; cv=none; b=tPSxGsoHI9tJJf7iF/ezwf1UIHQfQprOBl3zSQMvYqZ0hP6B0sAsir4UzPqecu+oMk+reqprM8bnXzwfnjjyGIlK6ekVV5mt2eU2b1Kw0jqzs6bo7Mx3ouiCKzUUCF5kw2fIfo9ACj7cz5cLLbs5KoKeP6LmaRSoQH2/Kw3wvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977562; c=relaxed/simple;
	bh=q1t5fcZzAYFKqt3LhN+ssOmb56MabTPb4Toqhe2bfxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVfnxlXLjMnfj4C8FQZSJxrMDdwdD929LQ+Nso4o9CqPd7tJPTpewB9Xpjr54V+ee6W2XSZa9KYfbvbQvYXVfCgzDS4oEmoArHHeLKekwRGQULcjg1u1N4xGH1oP3fPjJz4oINWXWjM1ZRLlYA0/CGYosvKWy3cXn+zEjbeBJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xxgRWFjU; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xxgRWFjU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q1t5fcZzAYFKqt3LhN+ssOmb56MabTPb4Toqhe2bfxM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977559; v=1; x=1792582359;
 b=xxgRWFjU6LhCM7x+Sdw+vxdMQQYcIsWMd5+97+bRWVc55okNh4weOCRtD7sZbkijPcW2EEEI
 1T90Mpv0aN6Ij+nspf92NcTeFiLN5jmiRG4zm5+dU9Em0FX6JKcBmocWFFvM2O6c5s9WqOtc4SW
 IMbM4gy+G8edH3GhjSapR16k=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 76c3b445136a24b3;
	Wed, 14 Oct 2026 11:32:38 +0000
X-Mizu-Trace-ID: 76c3b445136a24b3
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
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Skip expected_msgs subtests when stdout is not saved
Date: Wed, 14 Oct 2026 19:30:42 +0800
Message-ID: <20261014113043.640435-7-kafai.wan@linux.dev>
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

stdio_hijack_init() does not set subtest_state->stdout_saved when
running with -v in non-parallel mode, since output goes straight to
stdout. In that case subtest_state->log_buf is left NULL, so the
expected-messages subtests crash when inspecting it. Skip them when
stdout was not saved.

Fixes: 34c513be3dad ("selftests/bpf: __not_msg() tag for test_loader framework")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/prog_tests_framework.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index 53347f3799245..b4cd7c7ff4391 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -169,6 +169,12 @@ void test_prog_tests_framework_expected_msgs(void)
 
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		if (test__start_subtest(cases[i].name)) {
+			if (!env.subtest_state->stdout_saved) {
+				test__skip();
+				test__end_subtest();
+				continue;
+			}
+
 			error_cnt = env.subtest_state->error_cnt;
 			msgs.patterns = cases[i].pats;
 			msgs.cnt = 0;
-- 
2.43.0

