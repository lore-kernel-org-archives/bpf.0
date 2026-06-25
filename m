Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC383AE6F8
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385416; cv=none; b=CCbdtxvH29XtK53g+zH1PorYok2HrFVtIcvCee1QeapWXMaEHpcInBmvnT/NS9l14W6iLgzOfnQBIHGCAG5JtHe8AlCBaQ+BFFnLJmoBC09O1iVJCTac3BjsRDCRu4xaRYZMbweNNm3QPIzNBl8IdEbJTShmDr1kzINjTXsl1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385416; c=relaxed/simple;
	bh=/zOQc9ZSIDjz8Z2ZLlfPthihY0iqYqU0xYSz4Bs+PRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdGc7HHAxZAJgQwgmQCk12Sw5vsOlk8izTdBMGoKeye/GbpQJ1zXGFVkCQx191xBlhpfNgfSIDduSJ9VY7VzPUqY5siCPsyG3ikWnHwHynN+vAYQkr5fHu/dRvaYa8XR3cZ/uYzeDd3DFVc8egtYyFJkFex6XbXdQoSO/oO+BDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcPPerzl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcPPerzl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso2318196f8f.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385410; x=1782990210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEpVvmKSBmn+AWACSLzxjW8KlXjZyDGmgFaj+T7jvZI=;
        b=LcPPerzlNKOFNg3eEQn4ze+qqKYzk4LTrUPyllOHbkFd3rM2lW42/0vsmrbf6zS2sd
         EeJHDhyrLd5AF78KP0JqmE48XqCxbpUsBuxeUO3OnI+FQT0z9QsVURy93dDjr+3dITKk
         34r5WDuCZoPhXQc+Q6ssUBchS2dpZ5yqPRbvHskPzbQzIQBmwLc0+Ot1NscZjxluUtg3
         4H2ZnyQGjj/+YfqnDt4kPxktALI2bMuaLgLBytn7f7NFsLzQRtlrqoPae0jLVHzq94H7
         lUDjmfei2WmsLgpSW4FbDO7QTLkU+1q2vtRsRuAAsX4a3uxhr3tUOkU+XLYJU0lxmedq
         f0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385410; x=1782990210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEpVvmKSBmn+AWACSLzxjW8KlXjZyDGmgFaj+T7jvZI=;
        b=B+jA71uApOmYBSn2vvyVjwUE7fvUbecy5864jN9jzZtIy77ikId77czm8F232RHANL
         +vEHsQ7rCK1+v1jm9YvuU7HWQOrVcwwRQ7vqKcwaXbCFjLea6GFbO5gqTnwviYk5fRBI
         JZDSTZSPEWGWDPdzu3M/FwEVTYwZ9U6i0p69NtdzeotnMsWAiOIkyRbxywq5L4LqK681
         S23lJd0EdqR+ISNiGpE9PvRNHL+e+xKAw8/CpRq+Ia/kzq2oeqV48X3lf8GT53pbUMN3
         XsRDR2/cUQ252YQ+lf95nmVYQtKPbGMeRYcmitVSs9NjLV+vNVv/NxfNBPPL8kqrbiGg
         +yFg==
X-Gm-Message-State: AOJu0YzTtmsf1utvA4TCLU3gSe+xENuLzldUOIN4iMz7hIsR4Fa1MLfQ
	EJbfCArWWsCe1623vG9hFte5hegAde8pEZIOYlPfe38vxO3zCyALyCYhwiymnRA3XW8=
X-Gm-Gg: AfdE7cnsAHGZFGsvz4j/m2FN4nODUbBF3/PlFB7N33OuVOV13uqc8T0rCW91l+nV+m1
	4ZqcmkLTrSibeG9NjzjSgwMaZGyG8bCqekL2tTIfNo93CUCCFLOGlSaENZJ99FqbjLmxo1627A7
	z6wrJ2l0sjFZBURSquIN8DwTZvAkKdl/ZDA4ASzUkBNfMDTc0aDNzaFJAigQc5acrI8Kda+1dNx
	BEzvJtVzesjL6aiBGlxHwthRSDkj8pzJq21sZ/63dpozrknwLyOfM8l1w3ObqA4XavegS+Tt+pg
	5g7lP8kbhMZH+kkOxnRCXx7+iM9mebj31oM9kQbDB5/7M6xF76Ja5NtGcdHlowOIwl7Ib1uBGCa
	tgmDZmNJdCvJxcT4QlnKqfbKF9tLvmelRjlbl8hKjOGC6IqU4P9wFH5ryJZ5IaQkmP9zIoMu6zO
	JC56WXhJdBgGkx0xI3
X-Received: by 2002:adf:e005:0:20b0:45e:f5bf:6c25 with SMTP id ffacd0b85a97d-46dc12e067emr2030677f8f.32.1782385409917;
        Thu, 25 Jun 2026 04:03:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 3/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
Date: Thu, 25 Jun 2026 11:03:19 +0000
Message-Id: <20260625110321.28236-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test extends the existing cgroup_skb tests with IPv6 support.

Note that we need to set IPV6_RECVERR on the socket for IPv6 in
connect_to_fd_nonblock otherwise the error will be ignored even if we
are in the middle of the TCP handshake. See in
net/ipv6/datagram.c:ipv6_icmp_error for more details.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 91 +++++++++++++------
 tools/testing/selftests/bpf/progs/icmp_send.c | 48 ++++++++--
 2 files changed, 101 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index b8a98c90053e..bbb3c3d4509c 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -8,9 +8,11 @@
 #define TIMEOUT_MS 1000

 #define ICMP_DEST_UNREACH 3
+#define ICMPV6_DEST_UNREACH 1

 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
+#define ICMPV6_REJECT_ROUTE 6

 #define KFUNC_RET_UNSET -1

@@ -18,7 +20,7 @@ static int connect_to_fd_nonblock(int server_fd)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
-	int fd, err;
+	int fd, err, on = 1;

 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
 		return -1;
@@ -27,6 +29,12 @@ static int connect_to_fd_nonblock(int server_fd)
 	if (fd < 0)
 		return -1;

+	if (addr.ss_family == AF_INET6 &&
+	    setsockopt(fd, IPPROTO_IPV6, IPV6_RECVERR, &on, sizeof(on)) < 0) {
+		close(fd);
+		return -1;
+	}
+
 	err = connect(fd, (struct sockaddr *)&addr, len);
 	if (err < 0 && errno != EINPROGRESS) {
 		close(fd);
@@ -36,8 +44,14 @@ static int connect_to_fd_nonblock(int server_fd)
 	return fd;
 }

-static void read_icmp_errqueue(int sockfd, int expected_code)
+static void read_icmp_errqueue(int sockfd, int expected_code, int af)
 {
+	int expected_ee_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						 ICMPV6_DEST_UNREACH;
+	int expected_origin = (af == AF_INET) ? SO_EE_ORIGIN_ICMP :
+						SO_EE_ORIGIN_ICMP6;
+	int expected_level = (af == AF_INET) ? IPPROTO_IP : IPPROTO_IPV6;
+	int expected_type = (af == AF_INET) ? IP_RECVERR : IPV6_RECVERR;
 	struct sock_extended_err *sock_err;
 	char ctrl_buf[512];
 	struct msghdr msg = {
@@ -63,38 +77,43 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 		return;

 	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
-		if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
+		if (cm->cmsg_level != expected_level ||
+		    cm->cmsg_type != expected_type)
 			continue;

 		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);

-		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
-			       "sock_err_origin_icmp"))
+		if (!ASSERT_EQ(sock_err->ee_origin, expected_origin,
+			       "sock_err_origin"))
 			return;
-		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
+		if (!ASSERT_EQ(sock_err->ee_type, expected_ee_type,
 			       "sock_err_type_dest_unreach"))
 			return;
 		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
 		return;
 	}

-	ASSERT_FAIL("no IP_RECVERR control message found");
+	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
 }

-static bool valid_unreach_code(int code)
+static bool valid_unreach_code(int code, int af)
 {
 	if (code < 0)
 		return false;

-	return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
+	if (af == AF_INET)
+		return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
+
+	return code <= ICMPV6_REJECT_ROUTE;
 }

-static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
+static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code,
+					    int af, const char *ip)
 {
 	int srv_fd = -1, client_fd = -1;
 	int port;

-	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
+	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
 	if (!ASSERT_OK_FD(srv_fd, "start_server"))
 		return;

@@ -105,6 +124,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
 	}

 	skel->bss->server_port = ntohs(port);
+	skel->bss->unreach_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						    ICMPV6_DEST_UNREACH;
 	skel->bss->unreach_code = code;
 	skel->data->kfunc_ret = KFUNC_RET_UNSET;

@@ -114,13 +135,37 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
 		return;
 	}

-	if (valid_unreach_code(code))
-		read_icmp_errqueue(client_fd, code);
+	if (valid_unreach_code(code, af))
+		read_icmp_errqueue(client_fd, code, af);

 	close(client_fd);
 	close(srv_fd);
 }

+static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
+			  int max_code)
+{
+	for (int code = 0; code <= max_code; code++) {
+		if (af == AF_INET && code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code, af, ip);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test invalid codes */
+	trigger_prog_read_icmp_errqueue(skel, -1, af, ip);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	trigger_prog_read_icmp_errqueue(skel, max_code + 1, af, ip);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	if (af == AF_INET) {
+		trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED, af, ip);
+		ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+	}
+}
+
 void test_icmp_send_unreach_cgroup(void)
 {
 	struct icmp_send *skel;
@@ -139,23 +184,11 @@ void test_icmp_send_unreach_cgroup(void)
 	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
 		goto cleanup;

-	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
-		if (code == ICMP_FRAG_NEEDED)
-			continue;
-
-		trigger_prog_read_icmp_errqueue(skel, code);
-		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
-	}
-
-	/* Test invalid codes */
-	trigger_prog_read_icmp_errqueue(skel, -1);
-	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+	if (test__start_subtest("ipv4"))
+		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);

-	trigger_prog_read_icmp_errqueue(skel, NR_ICMP_UNREACH + 1);
-	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
-
-	trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED);
-	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+	if (test__start_subtest("ipv6"))
+		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

 cleanup:
 	icmp_send__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6d0be0a9afe1..6e1ba539eeb0 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -5,10 +5,11 @@

 /* 127.0.0.1 in host byte order */
 #define SERVER_IP 0x7F000001
-
-#define ICMP_DEST_UNREACH 3
+/* ::1 in host byte order (last 32-bit word) */
+#define SERVER_IP6_LO 0x00000001

 __u16 server_port = 0;
+int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

@@ -18,19 +19,48 @@ int egress(struct __sk_buff *skb)
 	void *data = (void *)(long)skb->data;
 	void *data_end = (void *)(long)skb->data_end;
 	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
 	struct tcphdr *tcph;
+	__u8 version;

-	iph = data;
-	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
-	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
+	if (data + 1 > data_end)
 		return SK_PASS;

-	tcph = (void *)iph + iph->ihl * 4;
-	if ((void *)(tcph + 1) > data_end ||
-	    tcph->dest != bpf_htons(server_port))
+	version = (*((__u8 *)data)) >> 4;
+
+	if (version == 4) {
+		iph = data;
+		if ((void *)(iph + 1) > data_end ||
+		    iph->protocol != IPPROTO_TCP ||
+		    iph->daddr != bpf_htonl(SERVER_IP))
+			return SK_PASS;
+
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+
+	} else if (version == 6) {
+		ip6h = data;
+		if ((void *)(ip6h + 1) > data_end ||
+		    ip6h->nexthdr != IPPROTO_TCP)
+			return SK_PASS;
+
+		if (ip6h->daddr.in6_u.u6_addr32[0] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[1] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[2] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[3] != bpf_htonl(SERVER_IP6_LO))
+			return SK_PASS;
+
+		tcph = (void *)(ip6h + 1);
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+	} else {
 		return SK_PASS;
+	}

-	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
+	kfunc_ret = bpf_icmp_send(skb, unreach_type, unreach_code);

 	return SK_DROP;
 }
--
2.34.1

