Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2732B132
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680592; cv=none; b=CCzqv3pZlKrVSKw3WE7WHA9fxeak5F+MlcqBFYbIj/FYk5dnigWX1jm9HDyi2qd3qjwof+EjEpTPd73HRfsFtZBF1U8LCO0IGxPa+jy+rOSo3znjbXcebGtd9mithc23xxqrcVPTuS7dC0khQ9J78WdfA26wD0lsYPghWmlKMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680592; c=relaxed/simple;
	bh=1pV/OjK3uqRh6NbspLA/v1dMgiXXeN4cc8uhsKwlu1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnkFKx6Rf1DuXA83GNMkoUmluS6XWc0YTSf0Hq3mSFiKCvnU+VMlAJgezIvEBRo1dTXx2fMRHIkhmP1iFRm3vDXI2RfHSC3m8cYV1yY4xbVWRlX2kQQZJbssfavjEQQbbcA9chYob0ayvu4DC++2MEN3pTtWqPADIlTQagwdleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJZjYMXE; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJZjYMXE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1pV/OjK3uqRh6NbspLA/v1dMgiXXeN4cc8uhsKwlu1g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788680589; v=1; x=1789285389;
 b=UJZjYMXEv+6LluF8kkVidQaetJFBXcIPVzzJMInkbJYFofGw8cddFuxmGPWYci+MeiE4TyPM
 xU6bDke9r/3+tybBuUK8OX6xQTUEXBlI+15FLrnbknGuvBXNVBdctHchN+TEaMBhiOGIVVtA2vq
 pMOwYCFItoDEff2nOSh/BX3E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1c0355f00ed10633;
	Sun, 06 Sep 2026 07:43:09 +0000
X-Mizu-Trace-ID: 1c0355f00ed10633
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 3/3] selftests/bpf: Test bpf_sock_destroy() on TIME_WAIT and listener socks
Date: Sun,  6 Sep 2026 15:41:04 +0800
Message-ID: <20260906074135.185212-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906074135.185212-1-jiayuan.chen@linux.dev>
References: <20260906074135.185212-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two subtests.

tcp_timewait: the client shuts down first and the server closes after
it, so the client sock ends up in TIME_WAIT. A tcp iterator then finds
the timewait sock by the cookie it inherited from the client sock and
destroys it. Iterate once more to make sure it is gone. Without the
first fix bpf_sock_destroy() reads past the timewait sock and KASAN
complains.

tcp_listen_pending: connect to a listener but never accept, so the child
sits in the accept queue, then destroy the listener. Without the second
fix the cond_resched() in inet_csk_listen_stop() trips the might_sleep
check under rcu_read_lock().

  ./test_progs -a sock_destroy

  #444/1   sock_destroy/tcp_client:OK
  #444/2   sock_destroy/tcp_server:OK
  #444/3   sock_destroy/tcp_listen_pending:OK
  #444/4   sock_destroy/tcp_timewait:OK
  #444/5   sock_destroy/udp_client:OK
  #444/6   sock_destroy/udp_server:OK
  #444/7   sock_destroy/trace_tcp_destroy_sock:OK
  #444     sock_destroy:OK
  Summary: 1/7 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 119 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   |  30 +++++
 2 files changed, 149 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 9c11938fe597..c9f0885709c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <poll.h>
 #include <test_progs.h>
 #include <bpf/bpf_endian.h>
 
@@ -110,6 +111,120 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
+static void test_tcp_listen_pending(struct sock_destroy_prog *skel)
+{
+	int serv = -1, clien = -1, n, serv_port;
+	struct pollfd pfd = { .events = POLLIN };
+	char buf[1];
+
+	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(serv, 0, "start_server"))
+		goto cleanup;
+	serv_port = get_socket_local_port(serv);
+	if (!ASSERT_GE(serv_port, 0, "get_sock_local_port"))
+		goto cleanup;
+	skel->bss->serv_port = (__be16)serv_port;
+
+	/*
+	 * Connect but never accept, so the child sits in the accept queue
+	 * of the listener. Wait until it's actually there.
+	 */
+	clien = connect_to_fd(serv, 0);
+	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
+		goto cleanup;
+	pfd.fd = serv;
+	if (!ASSERT_EQ(poll(&pfd, 1, -1), 1, "poll listener"))
+		goto cleanup;
+
+	/* Run iterator program that destroys server sockets. */
+	start_iter_sockets(skel->progs.iter_tcp6_server);
+
+	n = accept(serv, NULL, NULL);
+	if (!ASSERT_LT(n, 0, "accept on destroyed listener"))
+		goto cleanup;
+	ASSERT_EQ(errno, EINVAL, "error code on destroyed listener");
+
+	/* The unaccepted child was reset along with the listener. */
+	n = recv(clien, buf, sizeof(buf), 0);
+	if (!ASSERT_LT(n, 0, "client recv on reset child"))
+		goto cleanup;
+	ASSERT_EQ(errno, ECONNRESET, "error code on reset child");
+
+cleanup:
+	if (clien != -1)
+		close(clien);
+	if (serv != -1)
+		close(serv);
+}
+
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
+	/*
+	 * Active close from the client, then close the server side. Once
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
+	/*
+	 * Make sure the server has seen the client FIN before it closes,
+	 * so the two FINs never cross.
+	 */
+	n = recv(accept_serv, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(n, 0, "server recv EOF"))
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
@@ -204,6 +319,10 @@ void test_sock_destroy(void)
 		test_tcp_client(skel);
 	if (test__start_subtest("tcp_server"))
 		test_tcp_server(skel);
+	if (test__start_subtest("tcp_listen_pending"))
+		test_tcp_listen_pending(skel);
+	if (test__start_subtest("tcp_timewait"))
+		test_tcp_timewait(skel);
 	if (test__start_subtest("udp_client"))
 		test_udp_client(skel);
 	if (test__start_subtest("udp_server"))
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

