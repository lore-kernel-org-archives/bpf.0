Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFF2D0C98
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001819; cv=none; b=tXqIrBGJe4Sk0he6kwu3GjfjQ4dPVkZyF51sDMc6vY+jII6gZcmnZWZIEGwiHRC5pcCzQ2FIuYHL46N7UI36zKosGAsOW6OnsPD6UT/+vmybSwMp05imlvG3dgFmGGrl0HfTKTohTHRuQgp2KtLxSFgCXBqBrpEjH6pw+sjF/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001819; c=relaxed/simple;
	bh=g+9fvTSlgCJP8SYEqyMVc+8/p26clVdQdR2i1kNLlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZadPfbIB9x1y3EjePCSQHUfehmTItJTEDUxaIuVQmWRs0su6h3qR1bhcKloWpkgv85rhPxQmfcsNDP/SUgZ6VCpeDzIPAav3EUkPijDFA2W6QBvCYmrsJ6VnvWjcTzc696B7uO1da0IuhOG8n3OF/iVu4Ygw6lR3+D297p6fU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3OeMptd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3OeMptd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1661F00893;
	Tue,  9 Jun 2026 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001818;
	bh=hDORVoTSDIt4W4NdMm5OW7kQS7eScIEjrKIhENvu5fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q3OeMptdZVE695CIyDb/PScD+b96fP8W/8l9wZ4fQmfmJICbSB1th/UZb3ufrAwrA
	 XN9Esj73cF7tzCXcSFH9LTn56WOt0Tzcui2emY4jnWdNl1UKLqBu473CCXDP3A64Pd
	 OGdpJOhKF/dDJ4lWVy346IqX6YIipo4MZn6pqMAKAJtzVOSE5TjMI01It79NngbQzi
	 g8mTBWfKAWqGKcHRo2idJ02K2JGgSDmOq/c8j0EbjmtnNqr/Xn3dUcqJuBLMewV8uy
	 Kp2R+pVT3s7vSkpG5DFMHwNhpPSjV26eq+274gH519BazMB+AOgdeDf1vpADK18ljj
	 0oYysSbIioWNA==
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
Subject: [PATCH bpf-next 5/6] selftests/bpf: Add uprobe_multi path_fd fail tests
Date: Tue,  9 Jun 2026 12:42:43 +0200
Message-ID: <20260609104244.588321-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609104244.588321-1-jolsa@kernel.org>
References: <20260609104244.588321-1-jolsa@kernel.org>
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
index 8c9eba1d4084..71eea809dce3 100644
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
+		.uprobe_multi.offsets = (unsigned long *) &offset,
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
+		.uprobe_multi.offsets = (unsigned long *) &offset,
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

