Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671979D0
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897783; cv=none; b=HFV8xvsO4E0Sy+pO2hLicGC4ebf1cXWekxny1YOceGqCY26rcg+WPVGu/6y++oq3xyBNkHlsRHBs0oZtvceesRwZrJaSMMaDvAzY0RHGsf52Q3l3RqYX7Nu4ZaUdnZqy7CQO6hzBYZshqBEZcsSsSxXUk3yAR2o/K1vD/5TagCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897783; c=relaxed/simple;
	bh=9jjTmzQMsJPVBIv9YSojScLb2Z/IsQC4JCC9p4egCNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJKxVlYieHjUnmHhdlJ6ePSoUb7EcqnKTId4O1JtpEakvWJgYw3HKHcfq/ZbC2OVWMBDnjSwiITzAjCQsP5eB7xc9cFv5NgwgQSHijWJlsiwE0O6syd0WvKQMLLaCpLRmcZOzVw6O3lqb9M2IpFmZ0YHESdux8DnN0AECe0jMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJz1dXE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJz1dXE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B57AC433F1;
	Wed, 20 Mar 2024 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710897783;
	bh=9jjTmzQMsJPVBIv9YSojScLb2Z/IsQC4JCC9p4egCNM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJz1dXE7Lyp7VVCAYQ+cy3lUyU9iFfMPzvt7p5LnXt+DwCu7pMmGQlodj2STQWjBO
	 Ag+v/1W+JQ0mvPbqMH0NkW3jkZIOAyoJ/lZ8BHgThX2ptug9lAT4FhcI3hWNPb0h7c
	 S/bPuzR+qiVx9bmyP8PZXjAtgCRGpGE7gxaJ1RpQ78ayBiEFL08fbo54VQF3d+XTQF
	 EANaxNm9DafJzVsndAvbSXz1uDOFbZdbxs1w89HhSpEOAk3IRdcLPUBiFUjGiYEalN
	 gzi9RnPMolm4CYjNhZWj2i91YozrwwO9/S6rTwF7OAkIo8qt9zF4WinwAE4julFkff
	 ZMashKfnz4OYQ==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Enable libbpf logs when loading pid_iter in debug mode
Date: Wed, 20 Mar 2024 01:22:41 +0000
Message-Id: <20240320012241.42991-1-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to load the pid_iter BPF program used to iterate over the
PIDs of the processes holding file descriptors to BPF links, we would
unconditionally silence libbpf in order to keep the output clean if the
kernel does not support iterators and loading fails.

Although this is the desirable behaviour in most cases, this may hide
bugs in the pid_iter program that prevent it from loading, and it makes
it hard to debug such load failures, even in "debug" mode. Instead, it
makes more sense to print libbpf's logs when we pass the -d|--debug flag
to bpftool, so that users get the logs to investigate failures without
having to edit bpftool's source code.

Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 00c77edb6331..9b898571b49e 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -101,7 +101,6 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
 	char buf[4096 / sizeof(*e) * sizeof(*e)];
 	struct pid_iter_bpf *skel;
 	int err, ret, fd = -1, i;
-	libbpf_print_fn_t default_print;
 
 	*map = hashmap__new(hash_fn_for_key_as_id, equal_fn_for_key_as_id, NULL);
 	if (IS_ERR(*map)) {
@@ -118,12 +117,18 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
 
 	skel->rodata->obj_type = type;
 
-	/* we don't want output polluted with libbpf errors if bpf_iter is not
-	 * supported
-	 */
-	default_print = libbpf_set_print(libbpf_print_none);
-	err = pid_iter_bpf__load(skel);
-	libbpf_set_print(default_print);
+	if (!verifier_logs) {
+		libbpf_print_fn_t default_print;
+
+		/* Unless debug information is on, we don't want the output to
+		 * be polluted with libbpf errors if bpf_iter is not supported.
+		 */
+		default_print = libbpf_set_print(libbpf_print_none);
+		err = pid_iter_bpf__load(skel);
+		libbpf_set_print(default_print);
+	} else {
+		err = pid_iter_bpf__load(skel);
+	}
 	if (err) {
 		/* too bad, kernel doesn't support BPF iterators yet */
 		err = 0;
-- 
2.34.1

