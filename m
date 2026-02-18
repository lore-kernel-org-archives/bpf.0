Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8928C5B1
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374713; cv=none; b=tEreiL2TP6WAbF0bHwvMVDYenX8f/t4WfJ6DlRvJqQlziGsoFiVXO/1RtaTXZS9pXKH+3yB4T9F6hj1wxjE050n0kUoGyQMNBYePxJ6qrFywFNe/TG8U3jhmutMt1Vh+T1ucgAel0PdZZNV1oiiHahXbWF3ZejUFX6uZQpTfl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374713; c=relaxed/simple;
	bh=OhwXEJpa4nTUiXqwkxQqB+DAIjkR6dlqqn333NLbtts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUZ6xcV4GNw9su17S8TcfEuuUW1CA2ejBQC2BdW1SWa4w208FDK5En3cw/fDp4sawrXhnYUiIF8sM7e4syLoc0g3KqgV4mKBPtveZLruDEkfntb+xbMfaRYWBhT7xKvy62OjRVnqYCHYn+i6kdh6xzvjnFXH8vO81jtw/ZP5a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xv8rzh2v; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xv8rzh2v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB4ypzf99oYRqj7vX8THS7uO7MYjSRJ+wJRwvR9VB+Y=;
	b=xv8rzh2vCb4e9wAf7IET1EYp+n91OjuNF3ibJekShFIrjEWkohaq/K30ydm1HDs8jb0shp
	yIBaBcSdcv15cw+wOvYkd7JnwlSz82LvGSyJeDU7DUfibbOUe+lTYKffVD6V1720YquFur
	WZ/7WoU0RO/Br+E5+LEDWx3D6rh6kG4=
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
Subject: [PATCH bpf v2 13/15] selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
Date: Tue, 17 Feb 2026 16:30:39 -0800
Message-ID: <20260218003041.1156774-14-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
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

