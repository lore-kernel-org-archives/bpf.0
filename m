Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226C315D35
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626429; cv=none; b=TXIuFxlx2o2gyrdN5g/lMDGhbFOidtC8SPOscQ5OsjIRxRi5ZwKmgYWtEMl0zn7YvgWtPPWllED6vaKDQ7xP4exeDonmJKvbAiDdvo3kzc4izUjZUvS878dygYgLPbi/+11mIp/NVvo/Os0vyFAm6xd21rt7IXUAY1vkK9VadsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626429; c=relaxed/simple;
	bh=OhwXEJpa4nTUiXqwkxQqB+DAIjkR6dlqqn333NLbtts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyREka1Udj/jNlfTblrEBON9aevnYeh6neTzuxfsGvOVl5FWhhSu2VphrwU0dQMtlch/k23wmwKPaQ6ZHOV/md1TbtHrOWj3i2kGogQLo1RABrvaUD7A0J8L2/fjrllWWSDUsuG9xNCZr4Cx1fi8K39oJnHsVpcDVaELEX9Vt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fiK2MRSP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fiK2MRSP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB4ypzf99oYRqj7vX8THS7uO7MYjSRJ+wJRwvR9VB+Y=;
	b=fiK2MRSPi+zwV0GbEV9J4DzJTk4eSYaeJlZjimSby7F5L4Spp3zOdAi/X6eszkjctYaMLa
	aTZ586Tey6Nj49XxqxKPnXWlS4/maFHglYMQ0g2C7TVoqrgizWhFIM8XMu6Dz3OyajUbsV
	LEq+X3NG/w3dQW2O+4gzZjWB0xfyt3Y=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v3 13/15] selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
Date: Fri, 20 Feb 2026 14:26:02 -0800
Message-ID: <20260220222604.1155148-14-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

- kmem_cache_iter: remove unnecessary debug output
- lwt_seg6local: change the type of foobar to char[]
  - the sizeof(foobar) returned the pointer size and not a string
    length as intended
- verifier_log: increase prog_name buffer size in verif_log_subtest()
  - compiler has a conservative estimate of fixed_log_sz value, making
    ASAN complain on snprint() call

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c | 7 ++-----
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/verifier_log.c    | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
index 6e35e13c2022..399fe9103f83 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -104,11 +104,8 @@ void test_kmem_cache_iter(void)
 	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
 		goto destroy;
 
-	memset(buf, 0, sizeof(buf));
-	while (read(iter_fd, buf, sizeof(buf)) > 0) {
-		/* Read out all contents */
-		printf("%s", buf);
-	}
+	while (read(iter_fd, buf, sizeof(buf)) > 0)
+		; /* Read out all contents */
 
 	/* Next reads should return 0 */
 	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
index 3bc730b7c7fa..1b25d5c5f8fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -117,7 +117,7 @@ void test_lwt_seg6local(void)
 	const char *ns1 = NETNS_BASE "1";
 	const char *ns6 = NETNS_BASE "6";
 	struct nstoken *nstoken = NULL;
-	const char *foobar = "foobar";
+	const char foobar[] = "foobar";
 	ssize_t bytes;
 	int sfd, cfd;
 	char buf[7];
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 8337c6bc5b95..aaa2854974c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -47,7 +47,7 @@ static int load_prog(struct bpf_prog_load_opts *opts, bool expect_load_error)
 static void verif_log_subtest(const char *name, bool expect_load_error, int log_level)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	char *exp_log, prog_name[16], op_name[32];
+	char *exp_log, prog_name[24], op_name[32];
 	struct test_log_buf *skel;
 	struct bpf_program *prog;
 	size_t fixed_log_sz;
-- 
2.53.0

