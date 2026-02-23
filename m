Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40C36B071
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873725; cv=none; b=ZsYaxyklGUGLLkfiJR5p3qDihly8MawP8S10RWnb9dNRkuqIPPmZb/XXVXphukkCBfT8B0V/T1lIHVDLGtVjW7F9qQ60k5MKJbgT1S/LhRl7sGV6IOxOG7vnw8JdNDaHeFVClhnKSNhEQFgTkxt2uq3w/DULJn4pFaxC47mzhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873725; c=relaxed/simple;
	bh=OXctf3NUqnAZuAxu1aLlPz/j7koALTJtVbkyAmLEJIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b36vFvTT6ZLh5OR7+CdkEav2M9zp9/cWNUV0dkmw3DbNAiz7t5W7TbWvYq8J7NuV0/3axjB8qPIydr+/FCftL14q91510NNqZdk23q0eHgDRHWr3+OHUbTv83Ry+Ba3i8ah1PLxhVRYe9gQsNkzZ3DICfI/D/NoIxW7RQ9CVvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cjTmNjKZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cjTmNjKZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv9Qc5Ceahl9eBJ7mgculwLxJBZp6JCNQGrz4aDmn0w=;
	b=cjTmNjKZRJV0WyNiFiVX84V60yAUClhUh4HR6yJJT74sqbIqTn8KnUpW4QJJneUlrz+2tX
	bP4/utbfu7tJWCcVokooPkdcDHZtP3LZyh9FRBFpkNVuL3abQ3tjfVnsAd+VDFSVcAiF9+
	KE8V5WXFHoeKvylZtmYtjF/RtZD6q6E=
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
Subject: [PATCH bpf v4 15/20] selftests/bpf: Fix resource leaks caused by missing cleanups
Date: Mon, 23 Feb 2026 11:07:31 -0800
Message-ID: <20260223190736.649171-16-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN reported a number of resource leaks:
  - Add missing  *__destroy(skel) calls
  - Replace bpf_link__detach() with bpf_link__destroy() where appropriate
  - cgrp_local_storage: Add bpf_link__destroy() when bpf_iter_create fails
  - dynptr: Add missing bpf_object__close()

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/cgrp_local_storage.c       |  4 ++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  5 +++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 28 +++++++++----------
 .../selftests/bpf/prog_tests/sockmap_listen.c |  2 +-
 .../bpf/prog_tests/struct_ops_private_stack.c |  4 +--
 .../selftests/bpf/prog_tests/tc_opts.c        |  6 ++--
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |  5 +++-
 7 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 9015e2c2ab12..478a77cb67e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -202,7 +202,7 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
-		goto out;
+		goto out_link;
 
 	/* trigger the program run */
 	(void)read(iter_fd, buf, sizeof(buf));
@@ -210,6 +210,8 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 	ASSERT_EQ(skel->bss->cgroup_id, cgroup_id, "cgroup_id");
 
 	close(iter_fd);
+out_link:
+	bpf_link__destroy(link);
 out:
 	cgrp_ls_sleepable__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b9f86cb91e81..5fda11590708 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -137,11 +137,14 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 		);
 
 		link = bpf_program__attach(prog);
-		if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		if (!ASSERT_OK_PTR(link, "bpf_program__attach")) {
+			bpf_object__close(obj);
 			goto cleanup;
+		}
 
 		err = bpf_prog_test_run_opts(aux_prog_fd, &topts);
 		bpf_link__destroy(link);
+		bpf_object__close(obj);
 
 		if (!ASSERT_OK(err, "test_run"))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 256707e7d20d..dd3c757859f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -204,7 +204,7 @@ static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
 	/* Fail since bpf_link for the same prog type has been created. */
 	link2 = bpf_program__attach_sockmap(prog_clone, map);
 	if (!ASSERT_ERR_PTR(link2, "bpf_program__attach_sockmap")) {
-		bpf_link__detach(link2);
+		bpf_link__destroy(link2);
 		goto out;
 	}
 
@@ -230,7 +230,7 @@ static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
 	if (!ASSERT_OK(err, "bpf_link_update"))
 		goto out;
 out:
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 	test_skmsg_load_helpers__destroy(skel);
 }
 
@@ -417,7 +417,7 @@ static void test_sockmap_skb_verdict_attach_with_link(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
 		goto out;
 
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 
 	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
@@ -426,7 +426,7 @@ static void test_sockmap_skb_verdict_attach_with_link(void)
 	/* Fail since attaching with the same prog/map has been done. */
 	link = bpf_program__attach_sockmap(prog, map);
 	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_sockmap"))
-		bpf_link__detach(link);
+		bpf_link__destroy(link);
 
 	err = bpf_prog_detach2(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT);
 	if (!ASSERT_OK(err, "bpf_prog_detach2"))
@@ -747,13 +747,13 @@ static void test_sockmap_skb_verdict_peek_with_link(void)
 	test_sockmap_skb_verdict_peek_helper(map);
 	ASSERT_EQ(pass->bss->clone_called, 1, "clone_called");
 out:
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 	test_sockmap_pass_prog__destroy(pass);
 }
 
 static void test_sockmap_unconnected_unix(void)
 {
-	int err, map, stream = 0, dgram = 0, zero = 0;
+	int err, map, stream = -1, dgram = -1, zero = 0;
 	struct test_sockmap_pass_prog *skel;
 
 	skel = test_sockmap_pass_prog__open_and_load();
@@ -764,22 +764,22 @@ static void test_sockmap_unconnected_unix(void)
 
 	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
 	if (stream < 0)
-		return;
+		goto out;
 
 	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
-	if (dgram < 0) {
-		close(stream);
-		return;
-	}
+	if (dgram < 0)
+		goto out;
 
 	err = bpf_map_update_elem(map, &zero, &stream, BPF_ANY);
-	ASSERT_ERR(err, "bpf_map_update_elem(stream)");
+	if (!ASSERT_ERR(err, "bpf_map_update_elem(stream)"))
+		goto out;
 
 	err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
 	ASSERT_OK(err, "bpf_map_update_elem(dgram)");
-
+out:
 	close(stream);
 	close(dgram);
+	test_sockmap_pass_prog__destroy(skel);
 }
 
 static void test_sockmap_many_socket(void)
@@ -1027,7 +1027,7 @@ static void test_sockmap_skb_verdict_vsock_poll(void)
 	if (xrecv_nonblock(conn, &buf, 1, 0) != 1)
 		FAIL("xrecv_nonblock");
 detach:
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 close:
 	xclose(conn);
 	xclose(peer);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index f1bdccc7e4e7..cc0c68bab907 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -899,7 +899,7 @@ static void test_msg_redir_to_listening_with_link(struct test_sockmap_listen *sk
 
 	redir_to_listening(family, sotype, sock_map, verdict_map, REDIR_EGRESS);
 
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 }
 
 static void redir_partial(int family, int sotype, int sock_map, int parser_map)
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 4006879ca3fe..d42123a0fb16 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -54,9 +54,7 @@ static void test_private_stack_fail(void)
 	}
 
 	err = struct_ops_private_stack_fail__load(skel);
-	if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
-		goto cleanup;
-	return;
+	ASSERT_ERR(err, "struct_ops_private_stack_fail__load");
 
 cleanup:
 	struct_ops_private_stack_fail__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index dd7a138d8c3d..2955750ddada 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -1360,10 +1360,8 @@ static void test_tc_opts_dev_cleanup_target(int target)
 
 	assert_mprog_count_ifindex(ifindex, target, 4);
 
-	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
-	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
-	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
-	return;
+	goto cleanup;
+
 cleanup3:
 	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
 	ASSERT_OK(err, "prog_detach");
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 0fe0a8f62486..7fc4d7dd70ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -699,7 +699,7 @@ void test_tc_tunnel(void)
 		return;
 
 	if (!ASSERT_OK(setup(), "global setup"))
-		return;
+		goto out;
 
 	for (i = 0; i < ARRAY_SIZE(subtests_cfg); i++) {
 		cfg = &subtests_cfg[i];
@@ -711,4 +711,7 @@ void test_tc_tunnel(void)
 		subtest_cleanup(cfg);
 	}
 	cleanup();
+
+out:
+	test_tc_tunnel__destroy(skel);
 }
-- 
2.53.0

