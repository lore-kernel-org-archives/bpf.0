Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD919B5A7
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858884; cv=none; b=N8bbgzi4JWd0DdcTqsKKY9wNcSRkd3mNy0mQnwDjwE0PtFl8DgISitBiUQ6at7PEvFIOLtnVLikCoFuu+w4Kv0qQOk2a5Coee9JSH9SH2hBJIDsS76x3jH1rvlQhewxygL1X9ig7cUOwyOrPSQKXcLhRnsC46Ci8qcvhJcWFuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858884; c=relaxed/simple;
	bh=DPgQu+n8kdL6qL9eyNq5ujqn6WBRhV3hx2GcxKHXvPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr4bPUTtbqr1L4Hmokiv5QB2xLEFooh1Ez2AdxE29SzXKQgWBbg9Iul/t+pQ8lsDYH8hH5pChwf6CP18YvSme72X8/7ztvhdxeW3JG913Pb8LdJs9MGRdHplbkbIags3Naub8zLWdjXHeD9R7wZUgDbLfUC2H96qz0LRwK19Xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exG0UYx7; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exG0UYx7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZqVIhBYgNX+eTjruXcUXhjk4BPzUoWwpJnndcds9tA=;
	b=exG0UYx7159WiePpmId+XFATuOWG06u8ydiJIN/YsxtvRZKHRNthpBno2tCiogVfQzU2Es
	HPdJLqGXbg3OrqWRLeYj9tltjav0l4IFnznpRW+ztSCCgRsEVvIVJOFdRtvOWT/Ees5q0h
	f2n208fY9Z2eYt/xd9r83axcMJ5AFgo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/14] selftests/bpf: Fix resource leaks caused by missing cleanups
Date: Wed, 11 Feb 2026 17:13:52 -0800
Message-ID: <20260212011356.3266753-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
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

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/cgrp_local_storage.c        |  4 +++-
 .../testing/selftests/bpf/prog_tests/dynptr.c  |  5 ++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c   | 18 +++++++++++-------
 .../selftests/bpf/prog_tests/sockmap_listen.c  |  2 +-
 .../bpf/prog_tests/struct_ops_private_stack.c  |  1 +
 .../testing/selftests/bpf/prog_tests/tc_opts.c |  1 +
 .../selftests/bpf/prog_tests/test_tc_tunnel.c  |  5 ++++-
 7 files changed, 25 insertions(+), 11 deletions(-)

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
index 256707e7d20d..ce010602a443 100644
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
@@ -747,7 +747,7 @@ static void test_sockmap_skb_verdict_peek_with_link(void)
 	test_sockmap_skb_verdict_peek_helper(map);
 	ASSERT_EQ(pass->bss->clone_called, 1, "clone_called");
 out:
-	bpf_link__detach(link);
+	bpf_link__destroy(link);
 	test_sockmap_pass_prog__destroy(pass);
 }
 
@@ -763,12 +763,15 @@ static void test_sockmap_unconnected_unix(void)
 	map = bpf_map__fd(skel->maps.sock_map_rx);
 
 	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
-	if (stream < 0)
+	if (stream < 0) {
+		test_sockmap_pass_prog__destroy(skel);
 		return;
+	}
 
 	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
 	if (dgram < 0) {
 		close(stream);
+		test_sockmap_pass_prog__destroy(skel);
 		return;
 	}
 
@@ -780,6 +783,7 @@ static void test_sockmap_unconnected_unix(void)
 
 	close(stream);
 	close(dgram);
+	test_sockmap_pass_prog__destroy(skel);
 }
 
 static void test_sockmap_many_socket(void)
@@ -1027,7 +1031,7 @@ static void test_sockmap_skb_verdict_vsock_poll(void)
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
index 4006879ca3fe..c36aa2354d2f 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -56,6 +56,7 @@ static void test_private_stack_fail(void)
 	err = struct_ops_private_stack_fail__load(skel);
 	if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
 		goto cleanup;
+	struct_ops_private_stack_fail__destroy(skel);
 	return;
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index dd7a138d8c3d..2a4fd367da0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -1363,6 +1363,7 @@ static void test_tc_opts_dev_cleanup_target(int target)
 	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
 	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+	test_tc_link__destroy(skel);
 	return;
 cleanup3:
 	err = bpf_prog_detach_opts(fd3, loopback, target, &optd);
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

