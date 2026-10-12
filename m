Received: from mta1.migadu.com (out-156.mta1.migadu.com [95.215.58.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6E409279
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813771; cv=none; b=Yt0X9EwgNvgrBswQ8QtPJ9aPOATA314QVKGRoPna9pIxED7qqVSNqDXv5YrhME4rD4YcV8fjcoaYexz7sfOfqbmRD77RKpzbXlwNsK3IOZcHv2/isPDom7JbjGwt4Ue/fJkWpW99scz95sOg9b1RbdJvknt5Mm8blYCbHlm8zyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813771; c=relaxed/simple;
	bh=lL5ZR2PgGHAxQPANSgaERaDouH6EiWuLA6v56Civr7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clvq/W9miKbL94KVplTUb22QI174pGVWdsaMCF1hDSHZvdkabL6tBplBmJQU7/Uve2TZ700hCgiiCQUMiKBFH6ZnvYiLsMLMcR6PMTZhe8fQdPxgM3TrnlajOYkXnIkenRVaS58FHB1OxUSACylurMhcXfxssCaUmnyoECOV1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SKL5UPxk; arc=none smtp.client-ip=95.215.58.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SKL5UPxk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lL5ZR2PgGHAxQPANSgaERaDouH6EiWuLA6v56Civr7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791813768; v=1; x=1792418568;
 b=SKL5UPxkx8oz0EoHPjsxreEQ4aJOBGpsYshhD0Sc1E22FlTVspaBersNtpHjIrgHVIeKisQQ
 ivlamR6M3fh4EAwgC2VKMnzhn9+BaqXO+HcrQY6IBNdMKXd4/XUHXX9yY3l6DyQz2G8ZiOtHMja
 QWwTE/KA9mTsyLZrUnXslBv4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 01321d116cb14331;
	Mon, 12 Oct 2026 14:02:47 +0000
X-Mizu-Trace-ID: 01321d116cb14331
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
Subject: [PATCH bpf-next 2/3] selftests/bpf: Skip expected_msgs subtests when stdout is not saved
Date: Mon, 12 Oct 2026 22:02:00 +0800
Message-ID: <20261012140202.2754552-3-kafai.wan@linux.dev>
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
expected-messages subtests crash when inspecting it. Skip them when
stdout was not saved.

Fixes: 34c513be3dad ("selftests/bpf: __not_msg() tag for test_loader framework")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/prog_tests_framework.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index 53347f379924..b4cd7c7ff439 100644
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

