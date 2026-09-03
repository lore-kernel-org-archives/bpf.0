Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5754ACC81
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440020; cv=none; b=VlLdx+SWaefWhTPh6npeh0bgTTsZAQe6vMUvJG4/A7uwEkyo1yhxWXkN0Qyn9cF7vFEFInD5UWmuDMuNsXuhBTu/Fg/7KgZSU5CrpXFUoR3+JHXEwmWNs/ITHuvmOdDj4ZmtTNaqboj1pw/KM4yJ2bB7bnBmGa/eAMkYzqv6AWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440020; c=relaxed/simple;
	bh=JptFFqM7LLI6UiMYd4/0OPbkJU1jH/1iiyo2vP8GRPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pel7XkdJGi3TYIpB6FAnmKjKzoQc16XdNZvVJZNK+SN2BusXllh0uiQjxqyDhzOCgyxr90TLRF4TGi8QB9ezdWqPt/lf7GTHwzwzRouS/3Ye3zIOvsMiB51rV429JPvSwf1ZP2QzimtFQbPEoMSXe3c1p34qScBUeEn9ISbM72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkez+Yba; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkez+Yba"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JptFFqM7LLI6UiMYd4/0OPbkJU1jH/1iiyo2vP8GRPg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788440016; v=1; x=1789044816;
 b=rkez+YbahhD5xSvXlTzgDUvR3R8aScF9yRAKzsaktW3EzyagbkZyu1VG1V+bvUfUNK3MZZQ4
 t2+/3i0XTKXhH7rvZ1GGTYeuB+h9pfMWZGDsGguRjpE4JJVf94PZU0DId7zGqweyqL3f97/I+HR
 v6dsApvy33KOrOxMh9hXz85k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 21463ba885a2f1b1;
	Thu, 03 Sep 2026 12:53:36 +0000
X-Mizu-Trace-ID: 21463ba885a2f1b1
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Test bpf_sock_destroy() on a TIME_WAIT sock
Date: Thu,  3 Sep 2026 20:52:49 +0800
Message-ID: <20260903125306.299943-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903125306.299943-1-jiayuan.chen@linux.dev>
References: <20260903125306.299943-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tcp_timewait subtest. The client shuts down first and the server
closes after it, so the client sock ends up in TIME_WAIT. A tcp iterator
then finds the timewait sock by the cookie it inherited from the client
sock and destroys it. Iterate once more to make sure it is gone.

Without the previous fix bpf_sock_destroy() reads past the timewait sock
and KASAN complains.

  ./test_progs -a sock_destroy

  #444/1   sock_destroy/tcp_client:OK
  #444/2   sock_destroy/tcp_server:OK
  #444/3   sock_destroy/tcp_timewait:OK
  #444/4   sock_destroy/udp_client:OK
  #444/5   sock_destroy/udp_server:OK
  #444/6   sock_destroy/trace_tcp_destroy_sock:OK
  #444     sock_destroy:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 62 ++++++++++++++++++-
 .../selftests/bpf/progs/sock_destroy_prog.c   | 30 +++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 9c11938fe597..6ccc7cda410b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -110,6 +110,65 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
+static void test_tcp_timewait(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, accept_serv = -1, n;
+	struct timeval tv = {};
+	char buf[1];
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup;
+
+	accept_serv = accept(serv, NULL, NULL);
+	if (!ASSERT_GE(accept_serv, 0, "serv accept"))
+		goto cleanup;
+
+	/* Active close from the client, then close the server side. Once
+	 * recv() sees EOF the server FIN has been processed and the client
+	 * sock is in TIME_WAIT. Block without timeout so a loaded CI box
+	 * can't race us.
+	 */
+	if (!ASSERT_OK(setsockopt(clien, SOL_SOCKET, SO_RCVTIMEO, &tv,
+				  sizeof(tv)), "clear rcvtimeo"))
+		goto cleanup;
+	if (!ASSERT_OK(shutdown(clien, SHUT_WR), "client shutdown"))
+		goto cleanup;
+
+	close(accept_serv);
+	accept_serv = -1;
+
+	/* block until return EOF */
+	n = recv(clien, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(n, 0, "client recv EOF"))
+		goto cleanup;
+
+	/* Run iterator program that destroys the timewait client sock. */
+	skel->bss->tw_found = 0;
+	start_iter_sockets(skel->progs.iter_tcp6_timewait);
+	if (!ASSERT_EQ(skel->bss->tw_found, 1, "timewait sock found"))
+		goto cleanup;
+
+	ASSERT_OK(skel->bss->tw_destroy_err, "destroy timewait sock");
+
+	/* The destroyed timewait sock must be gone. */
+	skel->bss->tw_found = 0;
+	start_iter_sockets(skel->progs.iter_tcp6_timewait);
+	ASSERT_EQ(skel->bss->tw_found, 0, "timewait sock destroyed");
+
+cleanup:
+	if (clien != -1)
+		close(clien);
+	if (accept_serv != -1)
+		close(accept_serv);
+	if (serv != -1)
+		close(serv);
+}
+
 static void test_udp_client(struct sock_destroy_prog *skel)
 {
 	int serv = -1, clien = -1, n = 0;
@@ -204,11 +263,12 @@ void test_sock_destroy(void)
 		test_tcp_client(skel);
 	if (test__start_subtest("tcp_server"))
 		test_tcp_server(skel);
+	if (test__start_subtest("tcp_timewait"))
+		test_tcp_timewait(skel);
 	if (test__start_subtest("udp_client"))
 		test_udp_client(skel);
 	if (test__start_subtest("udp_server"))
 		test_udp_server(skel);
-
 	RUN_TESTS(sock_destroy_prog_fail);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
index 9e0bf7a54cec..0a8887543218 100644
--- a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -7,6 +7,8 @@
 #include "bpf_tracing_net.h"
 
 __be16 serv_port = 0;
+int tw_found = 0;
+int tw_destroy_err = 0;
 
 int bpf_sock_destroy(struct sock_common *sk) __ksym;
 
@@ -100,6 +102,34 @@ int iter_tcp6_server(struct bpf_iter__tcp *ctx)
 	return 0;
 }
 
+SEC("iter/tcp")
+int iter_tcp6_timewait(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	__u64 *val;
+	int key = 0;
+
+	if (!sk_common)
+		return 0;
+
+	if (sk_common->skc_family != AF_INET6)
+		return 0;
+
+	if (!bpf_skc_to_tcp_timewait_sock(sk_common))
+		return 0;
+
+	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
+	if (!val)
+		return 0;
+	/* The timewait sock inherits the cookie of the closed client sock. */
+	if (bpf_get_socket_cookie(sk_common) != *val)
+		return 0;
+
+	tw_found++;
+	tw_destroy_err = bpf_sock_destroy(sk_common);
+
+	return 0;
+}
 
 SEC("iter/udp")
 int iter_udp6_client(struct bpf_iter__udp *ctx)
-- 
2.43.0

