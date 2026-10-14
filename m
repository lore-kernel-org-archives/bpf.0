Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13B4BE457
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977571; cv=none; b=f/ilB4ZUVv2FbHyhRJyoOl9Qi1Ke+OtulZA2+f1oB2tuBAGAl1ZXUrPoTYU601r4dcY9XQpwHOerceuJmtv5ABeXVXqY3dZ4Kzupf+NZlA5dYGNBYB3EiyICkzVvTNE7vQBbLgrDbRAuJ91kBcsLOtuKAsxUICReZ8StGcLo8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977571; c=relaxed/simple;
	bh=rUpy9MyFtwRHnMTDPYO12dfwaXHBB/auGnEe6vnVHzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmFNDMTxSqfjmDeqe0KICbpcJHtdierBsB1SR/lkHsHDiCqay7GmutzAk0t47tjLcZr0lkvf08ziGzLi8Hp6KsHiSrbJd+ggu8PbC1FtP8HUlTiRGkvX6H/xhgMeMe0mWZFh3jiBYCCrCKLhj+/FHbxM6yMpjfWdIM1lsB5XbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9FYMKVL; arc=none smtp.client-ip=95.215.58.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9FYMKVL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rUpy9MyFtwRHnMTDPYO12dfwaXHBB/auGnEe6vnVHzg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977567; v=1; x=1792582367;
 b=P9FYMKVLLALjWOrxUT4bKbUD6OoiP/feWGc2526J9KlnuKlMvFmWE4d//x6TEbrNgLt5xHga
 p2OJe62g0O/Q5+IIi1+TmjbfVbmbYpg/gvzthgx0AIzDjSHnePb78s8QbRBnNCmyTcaXpTI0fOC
 2Cvasuj+a+iRnZjMZeekYn1U=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a4a3fb094b9cd429;
	Wed, 14 Oct 2026 11:32:46 +0000
X-Mizu-Trace-ID: a4a3fb094b9cd429
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
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Skip compare_text subtest when stdout is not saved
Date: Wed, 14 Oct 2026 19:30:43 +0800
Message-ID: <20261014113043.640435-8-kafai.wan@linux.dev>
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
compare_text_mismatch subtest crashes when inspecting it. Skip it when
stdout was not saved.

Fixes: bd71904697c6 ("selftests/bpf: Add compare_text_to_expected() helper")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/prog_tests_framework.c      | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index b4cd7c7ff4391..ddb6cdc1579f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -203,14 +203,18 @@ void test_prog_tests_framework_compare_text(void)
 	}
 
 	if (test__start_subtest("compare_text_mismatch")) {
-		err = compare_text_to_expected("line two\n", "line one\n");
-		fflush(stdout);
+		if (!env.subtest_state->stdout_saved) {
+			test__skip();
+		} else {
+			err = compare_text_to_expected("line two\n", "line one\n");
+			fflush(stdout);
 
-		ASSERT_EQ(err, -1, "mismatch_rc");
-		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "-line one",
-				  "diff_has_expected");
-		ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "+line two",
-				  "diff_has_actual");
+			ASSERT_EQ(err, -1, "mismatch_rc");
+			ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "-line one",
+					  "diff_has_expected");
+			ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, "+line two",
+					  "diff_has_actual");
+		}
 		test__end_subtest();
 	}
 }
-- 
2.43.0

