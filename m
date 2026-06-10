Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB761358363
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102241; cv=none; b=JJZLfdWBbZmqwM9A5NMueIOYO94ff8i2ID0+P0osKhVi1uM9H8XyNEgFC2SXC9TjYoSm48WBWns5/izYXPRFLoNRvdZh/zx+E16XsdX3INUoGU2IUW+gbYu+PCUSZk/vtS71yAPnkzfPIIF61CYzFe2oomLdXaYjj2ecVU6t3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102241; c=relaxed/simple;
	bh=duEqYffJ0i5yOFdO+pVyL/oa/2FN3TmsScC4ZTcUVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swyc2UNXdP+0aPoE/EJapFdM2tNXOZJy+FG89LRmHZb+v0pMH/TtRjbI/NDBxwnGtc9Ta8nxcOjfUskiN76Pe8nojqYRuL2knx5N+44upKyQcnB3jq6jmjNmGQwJGp6Rz8wbrFz4FTANZ01/PDupwJ4mRtQgFQGQfFzzBTucdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fypCvj9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fypCvj9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217F1F00893;
	Wed, 10 Jun 2026 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102240;
	bh=LH1kHMr69K0GMo8Zaj2MBRVMwRK8dsmHYZ2Ib7GS1JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fypCvj9FbSSh9vs4IsAlv0+gvuLPPb86fYL9WxXnCqeVtrSgb1x92eA4Vzk+pvhzG
	 nSF9tdbA8tqlzPApcsI9/TaVS2TMfmH4d9KTwzfP5CvM2WDCBlP3N84JOHTlWdcrw5
	 60NlxzdBCPhTu5f122MdLTH8QmGqwtARBD/zK1oqivjP4g2sTTJMJx6eGmCLPvJTmY
	 EDvSYsQLAvbDm4sA14Wnm/sC6ep7aBBOFa1vBs9v2bzwTDuj/X4EatQhDhmtsOYdTN
	 h0+peP4NTftEyqxyhPxE+LgxJ106+s+Y+D49X6f2jrhC3Z7mIOfWJO2cOpXhHo7jXF
	 ZJNWsBTEtHy5w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 5/6] selftests/bpf: Add uprobe_multi path_fd fail tests
Date: Wed, 10 Jun 2026 16:36:26 +0200
Message-ID: <20260610143627.804790-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests to attach_api_fails suite to make sure we fail
wrong setup for path_fd usage.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index ffcf3c92f047..f0baf5738b75 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -537,7 +537,37 @@ static void test_attach_api_fails(void)
 	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
 	if (!ASSERT_ERR(link_fd, "link_fd"))
 		goto cleanup;
-	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
+	if (!ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong"))
+		goto cleanup;
+
+	/* wrong path_fd */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = NULL,
+		.uprobe_multi.path_fd = -1,
+		.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD,
+		.uprobe_multi.offsets = (unsigned long *)&offset,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EBADF, "path_fd_is_wrong"))
+		goto cleanup;
+
+	/* path and path_fd both set with BPF_F_UPROBE_MULTI_PATH_FD flag */
+	LIBBPF_OPTS_RESET(opts,
+		.uprobe_multi.path = path,
+		.uprobe_multi.path_fd = 1,
+		.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD,
+		.uprobe_multi.offsets = (unsigned long *)&offset,
+		.uprobe_multi.cnt = 1,
+	);
+
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	ASSERT_EQ(link_fd, -EINVAL, "path_and_path_fd_together");
 
 cleanup:
 	if (link_fd >= 0)
-- 
2.54.0

