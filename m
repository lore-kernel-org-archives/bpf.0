Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE3402422
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737871; cv=none; b=ppUaNfDCFPIMY8QwHK4e73Czg1/nQHrOlj2qN9wI7oEqDD7RCqZT/mjx1MwfIGXtmGjgJS0M8Kpjh9f+3iPuhTbi0VEAKzIn3o/coPn8SVmjQHpFNWIHeHYK6sUpVmSgkwvxp52nyspM1IZZJLqQpTcESywIanW9iIn+tMJ9FRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737871; c=relaxed/simple;
	bh=zfksjw+XRBPxiZB4Kl4ufA4nXVLgzGFz2c+17Fn6Yn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+I6KMAE1mq0uPQPKJE7e9hlcE4/7+V243B2VMQj90pDOGn43404aGblb5/rlT/z07Y3CUuXz4+zunHJniRltqWrOJrabkZj/q+m3UES3KR26kc3z0zGbnLVRaDMD411b/gN7ajMZ+EJzBkM3TO/W72D8IIvwn75ANM+H1gOM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTV6djWo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTV6djWo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso42309845e9.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782737868; x=1783342668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zS6INqnnyC03KYKAIS5NHsKTWgAmbX4KvTkfnH8Dlis=;
        b=LTV6djWorcvP7cu6Zcqhf48TrEgrSu0/pH/34I66LZYBvNn2QtaGhC7BuJd3+EZD72
         sYmJE8qKrNPzU8Fmq8VsDlLSiZl/Jho5ZFmqfeYg6uLlBa7Lwt8B73NLhq9Blu6XjaRs
         k4h0viYx2bQ6hctjh83/6reD0J2lTVF2GudD194HQYP2KhoU28hsKFybd/sL5STTFylx
         HKgy6eKtEp2q0QKTKVCLtNdWd8pzsywzSr+62myrcotcdZ75dyeNKah2+RSyn/ytZB43
         NfVNjp8wfh7gMc4dGLQHroVkA4dXSlkHh9NOgF2s70WI/H1STAVfsRzmu3d3G96f2Kkd
         Cu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737868; x=1783342668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS6INqnnyC03KYKAIS5NHsKTWgAmbX4KvTkfnH8Dlis=;
        b=X0TVH5/vApAZhJMdtjmeOhqI/xbuim+I916RfMpZPhu2kEV8o6HVUaBI9Mr6XNm3bi
         S1EEsjiZ86THZtJWqtZ+gLyk9eaYadYmyv72vvzSmmw38qOiHuwSZ5San1F9lhEdzOKc
         HBzK+8Qkmxm7ncAtvyLajEEpDcEjQYpymQY6xt2Q5ob7WrfdK9Odhres/7yn1udwhc0q
         8HyTO8h48s61cnwlCnF8qxqHfKnvse7KkT9V/oSLzugs340VouS+8pZmfr8bxO5pRLp0
         YBFWhkbMmbGl3FK/o/iJtezHS9pNWpHB92YUpKgq3WtYm6D9l+Sp6BhHYcobarFcQo4l
         x0fw==
X-Forwarded-Encrypted: i=1; AFNElJ8r8f+OI06/j/TorfOIZNs8RbKLu2rUuyELFZ4QrszaVyIqvpR58CfI5ucW/owAz+LWGW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3goCYakrp1jzGtWcb/c3ZG5lOME/bsBt1OQoprN7iSmRdrkt
	2rQ80l89TAl9BUB1aPtWdO/i4Tz/CKlTmWVrMrEC2wSK3pPE/UfzMcB1
X-Gm-Gg: AfdE7cnbrsHwC16hzboGeiL7un+BblawszXaA66liVeeRqVVb2RNS83Qn1hsvPTcsZK
	zK8DGD3yEM8OcHAMXlr61mbXjXlXMQeqP+0MxR7AwktGlLYk9oVyFFrTyxbrCLMjob+GWLv5F0S
	wSioAFfnEupQeXumJ7tV41ob2VNcduWJH4NNtrY1bVSk6Le6b3VQ/2K20lcqxl0RtzIrrsFAyUJ
	uEllTt6/syTo+U5zV/0d3r6smu4RSDQ3S0+Wy7+VRKXCaZkrNqtJfO5XoAARCfLwcsQVNnhOrgo
	4yp17IOpmuYRn5RR/CMb4VmnsgoTtNGs3eoEPQyucucAH3uSL6AoiAYeMlYrJXBEbT+4CHV4rOb
	pMueNWGE9P7tSVzFqkh6n2AT8/rqzlEiGpxCIzWGLWXkYReu1/9gYXI8V4f8b9+NpAuOypuoVUe
	aNTKe6KbhPJTunDvB3uEzkDw==
X-Received: by 2002:a05:600c:3acd:b0:492:6da2:5f0e with SMTP id 5b1f17b1804b1-4926da25f4dmr177134215e9.32.1782737868462;
        Mon, 29 Jun 2026 05:57:48 -0700 (PDT)
Received: from uberwald.home ([2a02:a03f:635d:6701:d6a2:6d4:bf93:c1b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm546336835e9.15.2026.06.29.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:57:47 -0700 (PDT)
From: "Guillaume @layus Maudoux" <layus.on@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Guillaume @layus Maudoux" <layus.on@gmail.com>
Subject: [PATCH] selftests/bpf: Mask socket type flags in mptcpify prog
Date: Mon, 29 Jun 2026 14:56:37 +0200
Message-ID: <20260629125637.384923-1-layus.on@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mptcpify BPF prog hooks update_socket_protocol() to rewrite
eligible TCP socket() calls to IPPROTO_MPTCP. It only does so when the
socket type is exactly SOCK_STREAM:

	type == SOCK_STREAM

The problem is that update_socket_protocol() in __sys_socket() is
called on the raw type argument as passed from userspace, before
__sys_socket_create() strips the flag bits with
"type &= SOCK_TYPE_MASK". The type argument may therefore carry
SOCK_CLOEXEC and/or SOCK_NONBLOCK in its upper bits, and the equality
check above then fails.

As a result, any socket created with e.g.
socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- which is what common
libraries do by default -- is silently left as plain TCP instead of
being upgraded to MPTCP. This was observed in practice with curl,
whose connections were not upgraded to MPTCP despite the prog being
attached.

The impact reaches beyond the test, because mptcpify.c is referenced
as example code for users who want to transparently enable MPTCP. The
same mistake is therefore likely to be copied into real deployments,
where it fails the same way and is hard to diagnose.

The fix is to mask off the flag bits before comparing, mirroring what
the socket core does:

	(type & SOCK_TYPE_MASK) == SOCK_STREAM

Since SOCK_TYPE_MASK is not exposed through vmlinux.h, define it in
bpf_tracing_net.h.

To exercise the regression directly, extend the mptcpify test to also
create the server socket with SOCK_CLOEXEC and SOCK_NONBLOCK set.
Routing a flagged type through start_server() then revealed a second
instance of the same pattern: start_server_addr() compared the type
against SOCK_STREAM for equality to decide whether to set SO_REUSEADDR
and call listen(), and so would skip listening for a flagged type.
Mask the type there as well. As SOCK_TYPE_MASK is not exposed by
glibc's <sys/socket.h> either, define it in network_helpers.h,
mirroring prog_tests/socket_helpers.h.

Fixes: ddba122428a7 ("selftests/bpf: Add mptcpify test")
Signed-off-by: Guillaume @layus Maudoux <layus.on@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c |  4 ++--
 tools/testing/selftests/bpf/network_helpers.h |  5 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++++++++++----
 .../selftests/bpf/progs/bpf_tracing_net.h     |  3 +++
 tools/testing/selftests/bpf/progs/mptcpify.c  |  2 +-
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b82f572641b7..db935a9d9fc1 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -111,7 +111,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (type == SOCK_STREAM &&
+	if ((type & SOCK_TYPE_MASK) == SOCK_STREAM &&
 	    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
 		log_err("Failed to enable SO_REUSEADDR");
 		goto error_close;
@@ -128,7 +128,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 		goto error_close;
 	}
 
-	if (type == SOCK_STREAM) {
+	if ((type & SOCK_TYPE_MASK) == SOCK_STREAM) {
 		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 79a010c88e11..75133119c04a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,11 @@ typedef __u16 __sum16;
 #define VIP_NUM 5
 #define MAGIC_BYTES 123
 
+/* include/linux/net.h */
+#ifndef SOCK_TYPE_MASK
+#define SOCK_TYPE_MASK 0xf
+#endif
+
 struct network_helper_opts {
 	int timeout_ms;
 	int proto;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8fade8bdc451..faa001ea84ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -264,7 +264,7 @@ static int verify_mptcpify(int server_fd, int client_fd)
 	return err;
 }
 
-static int run_mptcpify(int cgroup_fd)
+static int run_mptcpify(int cgroup_fd, int type)
 {
 	int server_fd, client_fd, err = 0;
 	struct mptcpify *mptcpify_skel;
@@ -280,7 +280,7 @@ static int run_mptcpify(int cgroup_fd)
 		goto out;
 
 	/* without MPTCP */
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	server_fd = start_server(AF_INET, type, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_server")) {
 		err = -EIO;
 		goto out;
@@ -307,7 +307,18 @@ static int run_mptcpify(int cgroup_fd)
 static void test_mptcpify(void)
 {
 	struct netns_obj *netns = NULL;
-	int cgroup_fd;
+	int cgroup_fd, i;
+	int types[] = {
+		SOCK_STREAM,
+		/* userspace sets these flags together with the type, and the
+		 * BPF prog must still upgrade the socket to MPTCP. See
+		 * update_socket_protocol() in net/socket.c, which runs before
+		 * the type is masked with SOCK_TYPE_MASK.
+		 */
+		SOCK_STREAM | SOCK_CLOEXEC,
+		SOCK_STREAM | SOCK_NONBLOCK,
+		SOCK_STREAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
+	};
 
 	cgroup_fd = test__join_cgroup("/mptcpify");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
@@ -317,7 +328,8 @@ static void test_mptcpify(void)
 	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
-	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+	for (i = 0; i < ARRAY_SIZE(types); i++)
+		ASSERT_OK(run_mptcpify(cgroup_fd, types[i]), "run_mptcpify");
 
 fail:
 	netns_free(netns);
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..c4b438854565 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -8,6 +8,9 @@
 #define AF_INET			2
 #define AF_INET6		10
 
+/* include/linux/net.h */
+#define SOCK_TYPE_MASK		0xf
+
 #define SOL_SOCKET		1
 #define SO_REUSEADDR		2
 #define SO_SNDBUF		7
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
index cbdc730c3a47..e3f8cb54dbe9 100644
--- a/tools/testing/selftests/bpf/progs/mptcpify.c
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -15,7 +15,7 @@ int BPF_PROG(mptcpify, int family, int type, int protocol)
 		return protocol;
 
 	if ((family == AF_INET || family == AF_INET6) &&
-	    type == SOCK_STREAM &&
+	    (type & SOCK_TYPE_MASK) == SOCK_STREAM &&
 	    (!protocol || protocol == IPPROTO_TCP)) {
 		return IPPROTO_MPTCP;
 	}
-- 
2.54.0

