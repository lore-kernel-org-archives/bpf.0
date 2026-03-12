Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA872874E0
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296470; cv=none; b=GjJrynnH4LPvqOX+1NrcB+JVCzYsNk7PBtfTe5duSnNMO+ijMQGrXw6VhPijYKyS6joWhBKX1fkj0HibAjqDaNs8ogSdW3QqwXQkUuVUSHi61X0U/pWNKrDpgdS87PkY86xYedBe5bJc1nMRCWT8nW/e3tp02ml3aikV1kNlpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296470; c=relaxed/simple;
	bh=yX+P25SFQt+hKWowT6l//ymslHAMD4h2kwPp7q1L1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWWZIGXDxfm1FEMFLuMK08dRbInoa9SjXpVBey+cNkf4PCM3Z6O4P7Z0yB3v4iLkPWwHGZfnNQ+RULL6RdB5yBxegB++mSwfix1TxsMCy43UPsFEC7vOvfteUvGwp8Q7ih6AZzjn/oPBgIr5d1ro71xbokI1QKWyw8gvxAbxNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQTBZUwi; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQTBZUwi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773296456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2vVMS1rputcYuq9qQkm4lsbyxPvoAkHcTLgoqyv28Ts=;
	b=tQTBZUwiaA4PEGqFl4UTHNZ76YCImuwYACCCIlnvvnJQ06GCFnD2A420JFEnRFxP+RHDUO
	vB/6zbWH8U4qUfHCDbzf6or/u98zgI8q9OzLGkCW3CzcHapmfHng2oiAA+VUuK7OdFb+6/
	rESHRMdJb/Y9KmWru3ArDr5MoIYRoi4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Improve connect_force_port test reliability
Date: Thu, 12 Mar 2026 14:20:26 +0800
Message-ID: <20260312062042.387367-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

No functional changes.

The connect_force_port test can fail intermittently because the
hardcoded server ports (60123/60124) may already be in use by other
tests or processes in CI environments [1].

Fix this by using dynamically assigned ports (port 0) for start_server
and propagating the actual port to the BPF programs at runtime via
skel->bss->port. Convert the test from the legacy bpf_object__open_file
loading model to the skeleton (skel) pattern, which provides direct
access to BPF global variables without introducing maps or other
mechanisms.

Test:

  ./test_progs -a connect_force_port -v

  test_v4:PASS:skel4_open_and_load 0 nsec
  attach_progs:PASS:attach connect 0 nsec
  attach_progs:PASS:attach getpeername 0 nsec
  attach_progs:PASS:attach getsockname 0 nsec
  run_tests:PASS:start_server tcp 0 nsec
  run_tests:PASS:get_socket_local_port 0 nsec
  run_tests:PASS:connect_to_fd 0 nsec
  run_tests:PASS:verify_ports 0 nsec
  run_tests:PASS:start_server udp 0 nsec
  run_tests:PASS:get_socket_local_port 0 nsec
  run_tests:PASS:connect_to_fd 0 nsec
  run_tests:PASS:verify_ports 0 nsec
  test_v6:PASS:skel6_open_and_load 0 nsec
  attach_progs:PASS:attach connect 0 nsec
  attach_progs:PASS:attach getpeername 0 nsec
  attach_progs:PASS:attach getsockname 0 nsec
  run_tests:PASS:start_server tcp 0 nsec
  run_tests:PASS:get_socket_local_port 0 nsec
  run_tests:PASS:connect_to_fd 0 nsec
  run_tests:PASS:verify_ports 0 nsec
  run_tests:PASS:start_server udp 0 nsec
  run_tests:PASS:get_socket_local_port 0 nsec
  run_tests:PASS:connect_to_fd 0 nsec
  run_tests:PASS:verify_ports 0 nsec
  #80      connect_force_port:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

[1] https://github.com/kernel-patches/bpf/actions/runs/22697676317/job/65808536038

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../bpf/prog_tests/connect_force_port.c       | 190 +++++++++---------
 .../selftests/bpf/progs/connect_force_port4.c |  10 +-
 .../selftests/bpf/progs/connect_force_port6.c |  10 +-
 3 files changed, 108 insertions(+), 102 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index 24d553109f8dd..3e62f9b9f1d94 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -3,6 +3,8 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "connect_force_port4.skel.h"
+#include "connect_force_port6.skel.h"
 
 static int verify_ports(int family, int fd,
 			__u16 expected_local, __u16 expected_peer)
@@ -46,122 +48,122 @@ static int verify_ports(int family, int fd,
 	return 0;
 }
 
-static int run_test(int cgroup_fd, int server_fd, int family, int type)
+static int attach_progs(int cgroup_fd, int family,
+			int connect_fd, int getpeername_fd,
+			int getsockname_fd)
 {
 	bool v4 = family == AF_INET;
-	__u16 expected_local_port = v4 ? 22222 : 22223;
-	__u16 expected_peer_port = 60000;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	const char *obj_file = v4 ? "connect_force_port4.bpf.o" : "connect_force_port6.bpf.o";
-	int fd, err;
-	__u32 duration = 0;
-
-	obj = bpf_object__open_file(obj_file, NULL);
-	if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))
+	int err;
+
+	err = bpf_prog_attach(connect_fd, cgroup_fd,
+			      v4 ? BPF_CGROUP_INET4_CONNECT :
+				   BPF_CGROUP_INET6_CONNECT, 0);
+	if (!ASSERT_OK(err, "attach connect"))
 		return -1;
 
-	err = bpf_object__load(obj);
-	if (!ASSERT_OK(err, "bpf_obj_load")) {
-		err = -EIO;
-		goto close_bpf_object;
-	}
+	err = bpf_prog_attach(getpeername_fd, cgroup_fd,
+			      v4 ? BPF_CGROUP_INET4_GETPEERNAME :
+				   BPF_CGROUP_INET6_GETPEERNAME, 0);
+	if (!ASSERT_OK(err, "attach getpeername"))
+		return -1;
 
-	prog = bpf_object__find_program_by_name(obj, v4 ?
-						"connect4" :
-						"connect6");
-	if (CHECK(!prog, "find_prog", "connect prog not found\n")) {
-		err = -EIO;
-		goto close_bpf_object;
-	}
+	err = bpf_prog_attach(getsockname_fd, cgroup_fd,
+			      v4 ? BPF_CGROUP_INET4_GETSOCKNAME :
+				   BPF_CGROUP_INET6_GETSOCKNAME, 0);
+	if (!ASSERT_OK(err, "attach getsockname"))
+		return -1;
 
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd, v4 ?
-			      BPF_CGROUP_INET4_CONNECT :
-			      BPF_CGROUP_INET6_CONNECT, 0);
-	if (err) {
-		log_err("Failed to attach BPF program");
-		goto close_bpf_object;
-	}
+	return 0;
+}
 
-	prog = bpf_object__find_program_by_name(obj, v4 ?
-						"getpeername4" :
-						"getpeername6");
-	if (CHECK(!prog, "find_prog", "getpeername prog not found\n")) {
-		err = -EIO;
-		goto close_bpf_object;
+static int run_tests(int cgroup_fd, int family, unsigned short *bss_port)
+{
+	int types[] = {SOCK_STREAM, SOCK_DGRAM};
+	bool v4 = family == AF_INET;
+	__u16 expected_local_port = v4 ? 22222 : 22223;
+	__u16 expected_peer_port = 60000;
+	int server_fd, port, fd, i;
+
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		/* Log the socket type to identify which test is running. */
+		server_fd = start_server(family, types[i], NULL, 0, 0);
+		if (!ASSERT_GE(server_fd, 0,
+			       types[i] == SOCK_STREAM ? "start_server tcp" :
+							 "start_server udp"))
+			return -1;
+
+		port = get_socket_local_port(server_fd);
+		if (!ASSERT_GE(port, 0, "get_socket_local_port")) {
+			close(server_fd);
+			return -1;
+		}
+		*bss_port = ntohs(port);
+
+		fd = connect_to_fd(server_fd, 0);
+		if (!ASSERT_GE(fd, 0, "connect_to_fd")) {
+			close(server_fd);
+			return -1;
+		}
+
+		ASSERT_OK(verify_ports(family, fd, expected_local_port,
+				       expected_peer_port), "verify_ports");
+		close(fd);
+		close(server_fd);
 	}
 
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd, v4 ?
-			      BPF_CGROUP_INET4_GETPEERNAME :
-			      BPF_CGROUP_INET6_GETPEERNAME, 0);
-	if (err) {
-		log_err("Failed to attach BPF program");
-		goto close_bpf_object;
-	}
+	return 0;
+}
 
-	prog = bpf_object__find_program_by_name(obj, v4 ?
-						"getsockname4" :
-						"getsockname6");
-	if (CHECK(!prog, "find_prog", "getsockname prog not found\n")) {
-		err = -EIO;
-		goto close_bpf_object;
-	}
+static void test_v4(int cgroup_fd)
+{
+	struct connect_force_port4 *skel;
 
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd, v4 ?
-			      BPF_CGROUP_INET4_GETSOCKNAME :
-			      BPF_CGROUP_INET6_GETSOCKNAME, 0);
-	if (err) {
-		log_err("Failed to attach BPF program");
-		goto close_bpf_object;
-	}
+	skel = connect_force_port4__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel4_open_and_load"))
+		return;
 
-	fd = connect_to_fd(server_fd, 0);
-	if (fd < 0) {
-		err = -1;
-		goto close_bpf_object;
-	}
+	if (attach_progs(cgroup_fd, AF_INET,
+			 bpf_program__fd(skel->progs.connect4),
+			 bpf_program__fd(skel->progs.getpeername4),
+			 bpf_program__fd(skel->progs.getsockname4)))
+		goto out;
 
-	err = verify_ports(family, fd, expected_local_port,
-			   expected_peer_port);
-	close(fd);
+	run_tests(cgroup_fd, AF_INET, &skel->bss->port);
 
-close_bpf_object:
-	bpf_object__close(obj);
-	return err;
+out:
+	connect_force_port4__destroy(skel);
+}
+
+static void test_v6(int cgroup_fd)
+{
+	struct connect_force_port6 *skel;
+
+	skel = connect_force_port6__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel6_open_and_load"))
+		return;
+
+	if (attach_progs(cgroup_fd, AF_INET6,
+			 bpf_program__fd(skel->progs.connect6),
+			 bpf_program__fd(skel->progs.getpeername6),
+			 bpf_program__fd(skel->progs.getsockname6)))
+		goto out;
+
+	run_tests(cgroup_fd, AF_INET6, &skel->bss->port);
+
+out:
+	connect_force_port6__destroy(skel);
 }
 
 void test_connect_force_port(void)
 {
-	int server_fd, cgroup_fd;
+	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/connect_force_port");
 	if (CHECK_FAIL(cgroup_fd < 0))
 		return;
 
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 60123, 0);
-	if (CHECK_FAIL(server_fd < 0))
-		goto close_cgroup_fd;
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_STREAM));
-	close(server_fd);
-
-	server_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 60124, 0);
-	if (CHECK_FAIL(server_fd < 0))
-		goto close_cgroup_fd;
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_STREAM));
-	close(server_fd);
-
-	server_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 60123, 0);
-	if (CHECK_FAIL(server_fd < 0))
-		goto close_cgroup_fd;
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_DGRAM));
-	close(server_fd);
-
-	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 60124, 0);
-	if (CHECK_FAIL(server_fd < 0))
-		goto close_cgroup_fd;
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_DGRAM));
-	close(server_fd);
-
-close_cgroup_fd:
+	test_v4(cgroup_fd);
+	test_v6(cgroup_fd);
+
 	close(cgroup_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/tools/testing/selftests/bpf/progs/connect_force_port4.c
index 27a632dd382e0..d2beff466902e 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -14,6 +14,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+unsigned short port = 0;
+
 struct svc_addr {
 	__be32 addr;
 	__be16 port;
@@ -40,7 +42,7 @@ int connect4(struct bpf_sock_addr *ctx)
 	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
 		return 0;
 
-	/* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:60123. */
+	/* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:port. */
 	if (ctx->user_port == bpf_htons(60000)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
 					  BPF_SK_STORAGE_GET_F_CREATE);
@@ -51,7 +53,7 @@ int connect4(struct bpf_sock_addr *ctx)
 		orig->port = ctx->user_port;
 
 		ctx->user_ip4 = bpf_htonl(0x7f000001);
-		ctx->user_port = bpf_htons(60123);
+		ctx->user_port = bpf_htons(port);
 	}
 	return 1;
 }
@@ -63,7 +65,7 @@ int getsockname4(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose local server as 1.2.3.4:60000 to client. */
-	if (ctx->user_port == bpf_htons(60123)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		ctx->user_ip4 = bpf_htonl(0x01020304);
 		ctx->user_port = bpf_htons(60000);
 	}
@@ -79,7 +81,7 @@ int getpeername4(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose service 1.2.3.4:60000 as peer instead of backend. */
-	if (ctx->user_port == bpf_htons(60123)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0, 0);
 		if (orig) {
 			ctx->user_ip4 = orig->addr;
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/tools/testing/selftests/bpf/progs/connect_force_port6.c
index 19cad93e612fc..7b5f3c6040cc4 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -13,6 +13,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+unsigned short port = 0;
+
 struct svc_addr {
 	__be32 addr[4];
 	__be16 port;
@@ -39,7 +41,7 @@ int connect6(struct bpf_sock_addr *ctx)
 	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
 		return 0;
 
-	/* Rewire service [fc00::1]:60000 to backend [::1]:60124. */
+	/* Rewire service [fc00::1]:60000 to backend [::1]:port. */
 	if (ctx->user_port == bpf_htons(60000)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
 					  BPF_SK_STORAGE_GET_F_CREATE);
@@ -56,7 +58,7 @@ int connect6(struct bpf_sock_addr *ctx)
 		ctx->user_ip6[1] = 0;
 		ctx->user_ip6[2] = 0;
 		ctx->user_ip6[3] = bpf_htonl(1);
-		ctx->user_port = bpf_htons(60124);
+		ctx->user_port = bpf_htons(port);
 	}
 	return 1;
 }
@@ -68,7 +70,7 @@ int getsockname6(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose local server as [fc00::1]:60000 to client. */
-	if (ctx->user_port == bpf_htons(60124)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		ctx->user_ip6[0] = bpf_htonl(0xfc000000);
 		ctx->user_ip6[1] = 0;
 		ctx->user_ip6[2] = 0;
@@ -87,7 +89,7 @@ int getpeername6(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose service [fc00::1]:60000 as peer instead of backend. */
-	if (ctx->user_port == bpf_htons(60124)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0, 0);
 		if (orig) {
 			ctx->user_ip6[0] = orig->addr[0];
-- 
2.43.0

