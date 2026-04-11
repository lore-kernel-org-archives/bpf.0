Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358931DE4E0
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871173; cv=none; b=hG3Wo/L34OSnqblDkBXc6SKRCyn55v51h6htVNiknK8kq/SvYAlVKwW9ED8TZkzoQmcHGs9nbO8sEWt3PLMd256Gk8i0HzOzA1IqHN22JhVR9ZULtR/+vJXa/HB8p+cW2Fp9PmnUQEmzvJ+4c05M0sap8Q4j4n0Pf8iMVJOD+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871173; c=relaxed/simple;
	bh=VO6BMkxq96+MVVztCDUAdoUouKK0RTwbTwrWVTmDayQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTLN9FyNl7sbKWnU9sbCdd8IqiC+2atVI0v8jm82Vm0kw55pLRdbXV0BeOXPLBv/P/W84EqAAWKhESF37MYQLJkofBnXtvbtTJeHIyGf89I2lQ8+zAQt9hyCFr3IYtt0VQUjUknjg4eAH2by0JgQs29U1BDG6ngttuRy83WYmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPvrQ48E; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPvrQ48E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775871169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoJCAFaTxUEnMvDnlo8IAOnt4jK6ofxDJqaroElqR/U=;
	b=sPvrQ48EhC0ZhnKra1/msHQQJN8Wu7PXFcsjVNhruGof3v1V+ShwNzVOvODxToSg8zGQc8
	BEH8rdmGWV3uA0/wlCZMd2YuyWhWdJsToiZlrTEbtB10R53lqkWwtV8IabHGessLuYDvAg
	jNqu+zyBT7rOoNafQBt3YamfD7lI9RY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie statistics in tcp_custom_syncookie
Date: Sat, 11 Apr 2026 09:32:05 +0800
Message-ID: <20260411013211.225834-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-1-jiayuan.chen@linux.dev>
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
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
---
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b82f572641b7..3388dd5112b6 100644
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
+		 "nstat -az TcpExt%s | awk '/TcpExt/ {print $2}'", name);
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
index 79a010c88e11..c53cd781df6e 100644
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
index eaf441dc7e79..6adfb4b892f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -91,12 +91,21 @@ static void transfer_message(int sender, int receiver)
 
 static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
 {
+	unsigned long recv_before, recv_after;
+	unsigned long failed_before, failed_after;
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

