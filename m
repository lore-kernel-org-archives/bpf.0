Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D63B9DA8
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735450; cv=none; b=jHdiYsvV6oOpqMXCa17U91fJ8hsO2HjYeNl5GHfaT9yYYdaL2tsGMUq7NPDhrat7MUqVinXpNqDLlD/e7YUzqWwaWXhbxZM2JhUnYqT3ddL/tCqYQc6gHQFuQSNiziHf4Uo1I2e2oizZ+909TyWDpVG+fo54ubs6AlWIgPxg4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735450; c=relaxed/simple;
	bh=q+zJyCGqjovaiIwt437MGOpY+gdYRqEuHxG+92IxJ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAtcOax6wEfRqI5NK7oWdvpZvkHIkIWFhmZCqDkcNds6kSNb9JRRFWV06Dj0Ob70a4X2r68+UpGJ4xjjJk/FKkry+0ydOhFagkqWi3RY5YvcYXZCNjpDfyqMDV7oio4BwHaUKA/9SyfPw5W3IS+l4lUNoGM+9GUoedk8j9hqgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxydN7sb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxydN7sb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778735447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfBmWLVLAOipY3O8m0a/fBCDqmiOi2Nx5QlLflxw4E0=;
	b=dxydN7sbiNIy8HQc7UmyMtvgBv3e5JAwv6K8Lr/cWgPPHvbprVEWJsSG9p9LXpN4dJ+k8N
	Qp+x9l2528f0ieQgpFC8oHebmqttNJ/VivNIQX7YlzH8uahIJy47nARSy2md3ONrIrwh8+
	A8P+EyqmrNowraN/fgxzq+Y8hZckvNc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: verify syncookie statistics in tcp_custom_syncookie
Date: Thu, 14 May 2026 13:09:58 +0800
Message-ID: <20260514051015.177926-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260514051015.177926-1-jiayuan.chen@linux.dev>
References: <20260514051015.177926-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add read_tcpext_snmp() helper to network_helpers which reads a
TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
BPF custom syncookie validation.

The delta is captured between start_server() and accept(), which
covers the full SYN/ACK/cookie-check path for one connection.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b82f572641b7d..4e3848f60261e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -621,6 +621,28 @@ int get_socket_local_port(int sock_fd)
 	return -1;
 }
 
+int read_tcpext_snmp(const char *name, unsigned long *val)
+{
+	char cmd[128], buf[128];
+	int ret = 0;
+	FILE *f;
+
+	snprintf(cmd, sizeof(cmd),
+		 "nstat -azs TcpExt%s | awk '/TcpExt/ {print $2}'", name);
+	f = popen(cmd, "r");
+	if (!f)
+		return -errno;
+
+	if (!fgets(buf, sizeof(buf), f)) {
+		ret = ferror(f) ? -errno : -ENODATA;
+		goto out;
+	}
+	*val = strtoul(buf, NULL, 10);
+out:
+	pclose(f);
+	return ret;
+}
+
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 {
 	struct ifreq ifr = {0};
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 79a010c88e11c..c53cd781df6e6 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -84,6 +84,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int read_tcpext_snmp(const char *name, unsigned long *val);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79b..00d5c32674fc9 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -91,12 +91,21 @@ static void transfer_message(int sender, int receiver)
 
 static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
 {
+	unsigned long failed_before, failed_after;
+	unsigned long recv_before, recv_after;
 	int server, client, child;
 
 	server = start_server(test_case->family, test_case->type, test_case->addr, 0, 0);
 	if (!ASSERT_NEQ(server, -1, "start_server"))
 		return;
 
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_before),
+		       "read SyncookiesRecv before"))
+		goto close_server;
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_before),
+		       "read SyncookiesFailed before"))
+		goto close_server;
+
 	client = connect_to_fd(server, 0);
 	if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
 		goto close_server;
@@ -105,9 +114,20 @@ static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
 	if (!ASSERT_NEQ(child, -1, "accept"))
 		goto close_client;
 
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_after),
+		       "read SyncookiesRecv after"))
+		goto close_child;
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_after),
+		       "read SyncookiesFailed after"))
+		goto close_child;
+
+	ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
+	ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delta");
+
 	transfer_message(client, child);
 	transfer_message(child, client);
 
+close_child:
 	close(child);
 close_client:
 	close(client);
-- 
2.43.0

