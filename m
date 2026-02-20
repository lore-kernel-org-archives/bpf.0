Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224D337BBA;
	Fri, 20 Feb 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582234; cv=none; b=Lwl15lNBmXeKplhbxRrNQSadf9nGnLX9VNNB7xnC5b5XAZzonLmdFhsOosFf23wRcCJ1CIRjiVyIM+yZnSmubxXbMaJUxFnOSyv+GGGuSnv0VxKqAUJ+KDqTvy6VVPOHKoEzXZVobe274wzCikKaADAGhdyxB1B6sQJjIG43Osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582234; c=relaxed/simple;
	bh=8qKCablq4IYVUKrHbdawWDLTb60qDpG15NtSArpa2d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1D6rqG/+CzzT1e6IpZEq01KSYuiJm3Ld4DCMKoKOfL9WZnCOMTWnkzUz7zeVSmcPQXDw9nGyXqb5lZJiBT/pwIBWlkpx+p+2Sl+etYjQStlTnTcKySS49+YRXXf1gfkzxSV/G2NENnYBYLfHQXgK7N4sh7NJvmo7jxXYd0/+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5XE07jS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5XE07jS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA55C116C6;
	Fri, 20 Feb 2026 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582233;
	bh=8qKCablq4IYVUKrHbdawWDLTb60qDpG15NtSArpa2d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5XE07jS6HO82oXivnEGm1VnQe2ClScPrmCIGyyUNcUqnZnhYVakOhYSa2jt9Q8po
	 a4KzWffxjEGGUeffoNeM7fKkwmp966+fKOEyX3cLbHfby0TCI6w9bh3UINtBiPDY26
	 jr/33V3fKjhWbSVTwgW35mNqeG486s8Z3k2+TXZzFfBN3kgHy3FQXEz8wZ1w0p1yGu
	 zusEf1HqPYUzVG6I2n5jYL3WlOQrb77D8R00drJZFXqyxQRMCELFm8x39QBbHsTl8i
	 HxIYRL8VUJXw/m45xNNveSbDbEJE2gBTHaooz58PCCVB2x/Y+KKyUv8atoImctoMEv
	 TTr3gcXdySVgA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCH bpf-next 16/17] selftests/bpf: Add tracing multi attach fails test
Date: Fri, 20 Feb 2026 11:06:48 +0100
Message-ID: <20260220100649.628307-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for attach fails on tracing multi link.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 3d9327b80e88..ba86a88844e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -340,6 +340,60 @@ static void test_session(void)
 	tracing_multi_session__destroy(skel);
 }
 
+static void test_attach_api_fails(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi *skel = NULL;
+	__u64 cookies[2];
+	__u32 ids[2];
+
+	skel = tracing_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
+		return;
+
+	/* fail#1 pattern and opts NULL */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, NULL);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#2 pattern and ids */
+	opts.ids = ids;
+	opts.cnt = 2;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#3 pattern and cookies */
+	opts.ids = NULL;
+	opts.cnt = 2;
+	opts.cookies = cookies;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#4 bogus pattern */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_not_really_a_function*", NULL);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#5 abnormal cnt */
+	opts.ids = ids;
+	opts.cnt = INT_MAX;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi");
+
+cleanup:
+	tracing_multi__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -359,4 +413,6 @@ void test_tracing_multi_test(void)
 		test_link_api_ids(true);
 	if (test__start_subtest("session"))
 		test_session();
+	if (test__start_subtest("attach_api_fails"))
+		test_attach_api_fails();
 }
-- 
2.52.0

