Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996B3E7BDD
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178214; cv=none; b=KluToX0240wFrW7TtpCvKyGESZUGJlehCSdmbJAZTsSRGzIpUO+V8KzU/8uA2NuhVpxkO43udH9q6e28nyZe9/DG+ecIY0V3bK/4u62MY5/tqhdXBAHWlF+inYWOoL8pBtUYblfA1Dn0pXU4WCV+ALIFpCWYoZfeHcn/V1U1NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178214; c=relaxed/simple;
	bh=duEqYffJ0i5yOFdO+pVyL/oa/2FN3TmsScC4ZTcUVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJLCSUp7bLD2oydJOwerGf3OUK9Taz0Azc1CR9vzQh6Qz4SG6datagOtARZwkGjACE3IGDHkyfxOGtS6aqcTC4E25dGEcjPU+V1+u+zT9nYrdBGgzYl/WLrWKnqg12Zfao0kXOmD+MkcnTISMg22RFtt+jjxkuKI4yDzTycjE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV0sFxB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV0sFxB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2445D1F00893;
	Thu, 11 Jun 2026 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178213;
	bh=LH1kHMr69K0GMo8Zaj2MBRVMwRK8dsmHYZ2Ib7GS1JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WV0sFxB2uMiM7KpSt2E7zV3yJ1n80THh19LCe2lboMiZeZchv49JP10/WsxFxrOTV
	 0qvits3Onv5x+tOMh5esawiyRY87sqm+UOjS/WQVuGpvBcS5+A/SyU/MKjYHP1aOXH
	 OZaemSV8fDNDEmogGjnUaLZS3zkaKqBW4pVldJOA3YR3BcAo6vKAyiqv9gxdT+LFoK
	 +BlTQ9EdfR2DORLCHx99LUghT365tmx3EtHC6BkvhCmVQmvzdL6fK/aNPRl40C2Tjw
	 6IMUWoxy/FAkeXvanf6ETUzXROokfuD0ynAxMhslm4eNMnAfreq06CmDvARQwmMrXd
	 5ms6Ej3h6IoEg==
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
Subject: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uprobe_multi path_fd fail tests
Date: Thu, 11 Jun 2026 13:42:29 +0200
Message-ID: <20260611114230.950379-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
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

