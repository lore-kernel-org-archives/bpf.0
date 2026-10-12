Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439C44F551
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813782; cv=none; b=ggoTZqgP/YXirrshdL4Lexp/9b3Xp2WmdRUWXAtP7fJYVtxrQdQR06Ivuc2i6YRtVTuw6BwfcBkJrVsOmknDyNhzb2hoGVYkBMwWNM7Eh8pqZHJBsCoOaNLxG/0WP3ozpnEaYaz797ntvCJIF7wiRTgygYHoyfPLsSLv/BXBYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813782; c=relaxed/simple;
	bh=aK3SwRgOhQJkPLJg1DEYhZSGqnvS8cB7A4MSQuObRso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIucg4r/daQuKfGQ2Uee3/pg8du1zL6x34q/qcrSTvta+RboWpJA8QhftleIEvvo2RJjiVvc56i7IEwNgBD1SdyBD0bAr3HsSraP9TT8sqIi64UDLxK8KNKb+JEiMEuFzPqVgC8mSoBD4EtobNzuwAOWx2JzctWmgxdxu4xkSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EaF1ire7; arc=none smtp.client-ip=95.215.58.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EaF1ire7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aK3SwRgOhQJkPLJg1DEYhZSGqnvS8cB7A4MSQuObRso=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791813778; v=1; x=1792418578;
 b=EaF1ire7R5Gq/oQPqUhJUj/DfeE1IGbyYLo8CQvCBfp+I5aBPLTZ5Z9rAIitHnGfGbdeZpAT
 RR0ekDbhFrCkG0rQCEE3VZXTNO5HUooxjfgTz6uCkFbF+cIA47sF4gE7xsjiS480Tf25dIi99Fk
 KZq6pLoQEEwpZwoXq9C3fYO8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 2f3aa6d497d7e38b;
	Mon, 12 Oct 2026 14:02:58 +0000
X-Mizu-Trace-ID: 2f3aa6d497d7e38b
X-Migadu-Flow: FLOW_OUT
From: KaFai Wan <kafai.wan@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	KaFai Wan <kafai.wan@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Skip compare_text subtest when stdout is not saved
Date: Mon, 12 Oct 2026 22:02:01 +0800
Message-ID: <20261012140202.2754552-4-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012140202.2754552-1-kafai.wan@linux.dev>
References: <20261012140202.2754552-1-kafai.wan@linux.dev>
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
index b4cd7c7ff439..ddb6cdc1579f 100644
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

