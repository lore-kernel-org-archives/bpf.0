Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F95331EBC
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327381; cv=none; b=fNgRep16KAXJRtR/CO81wy1RLGhV/g81BqR2qU8nISMblWJBsr6vBOySLQHWh3METjaKS/z8HMxtdPgptHk7mvaPHWYvJ/X7Juxg80HMc2JNe9sutbYIN9vLZX9+pYUFeAogkxN4q1vX8+7Bb8KNcJyHQUv5SFp9qcg6+JSon7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327381; c=relaxed/simple;
	bh=fTpYpokZWMo0c35C3HejD/w0TPGCR2Vav3iAnH0jS6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIousitcpld9e+u0aepFvoN3OjycF5gtTBe5VJvNRQHJEFHUzp6FpN3CX/uHUgDk3RGZuigy7TedVpuNrNTcpVMtk24j4TxlRk8Oia/ckJDnmeM+08bsx2hnEnyQteh2t65IFRSH3kWV6uRcrCzncZl9UZHoJbquLR4LINXhMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0b8Az11; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0b8Az11"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso15183925e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327378; x=1782932178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OaD6zhmaXPnGTOCMX+cxdnY/rpFYjBbxFPWBzx9jV0=;
        b=g0b8Az11MJ7mOA6mz5exIoJDcx4UVk6UQ8UCNWmamUavbORLXXOYoluSknQC9aABvb
         jE4/OkvLYRlRvcftX2h/mrn8+vmmTgUR5z4KYA6Uv4Arn+GMVU6Q9X6T7C9qFe2RiJSm
         pbXdoYZuq0CcdikzBOgapq/1gdNKiI8KDPoYA6+ZNSbBqkHNcfpCrzOjBB9JMevQwj4q
         V/7OnrVkIkv/jrFtL9HbSPgQZeg/0af92DUYQowjJcc/0Mwzx0EsMVzDCUbkEFqtkUpF
         ZB6T5mU5fZvw37GvN9+VkYviNj+65HuW9jpLNVqqLPxjud0FXwYO2HYbeOc5StMzff4p
         Lasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327378; x=1782932178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OaD6zhmaXPnGTOCMX+cxdnY/rpFYjBbxFPWBzx9jV0=;
        b=EgIRb0MKaM7WqA9ZPeC0g2RSvezwyJgYSz2Z+RbJLQQ8e741WzWT9AOqnZxu3ZFfjv
         xMU1ggAbdngPVUnJ8qwSaWy0rHGerRt9bL4rtdSCn+2j/aVm5mrSoUNVUAsC2AZqTtee
         l+43MKvCvpHwcwAItoWZKtxYZAX1EHHV1nbKbnnGt8jUuw7bp4AonN+rDJMRf8S4WjUP
         vR+vbb8WAFQdvHx9i/bZ9pCQMiYP167yuxm02i8UQn2b1crsmpnrb1v0cfyEhn/KPfaX
         HnWg16gnbNgGIuNhk8n+Fsj+P6rn5vVLcAWpPPOaIPwrameLJkJqWA0jm4XvxJZemQSn
         zgrA==
X-Gm-Message-State: AOJu0YwT/eT51CcuPKI8XS3XlykY1SNEy8V5bQDOZ9bB45djayuo6cH/
	9IgZpmNCMWuFlUE6lc+VcD8DF2b49OVFS9McICpFuB92M6ZweUMxV6CUXSFqLz9DQEE=
X-Gm-Gg: AfdE7cmdpHEdfZ8z9453FXsO5np3KhC9sUNMn545pSN4Az3N+QBiRYamnpYjwoHBE2n
	PxO5fhzqf+G6lTbBFTFsFx/nQfKMIJpvNzK8u7q/b7U1/Y0DcJ032/m3kPx9AZdCmzBw/8gMKnn
	ed29OBxqQvBTL0Al5aB+BT4qkynQIORDvgt42iCGTdGjHt8sYaScxNZbIYYUqyM1/xwZH19ybxk
	QxLbcUh9fXSFThq50QrtQ0isYNzgLthM8lIlacQudT/OZjT1N2hH1rOYDFeHbJpk0S+7vAeROD8
	ho31vuQPyj6gh1TLLT5JYf2VNJvmh7n6TrV++fDCC2nu9HMyN5kQr3fvYyu1HXBS2FK/Twma7/5
	mvV1iskMf8NllHcOHYr5lj6xDn+1ypPaiaPzCAr9h+TjJD9K9zGvioTICMkJxWFjnwj3vTnzSB0
	x4A0h4EnuyZxPhr4DO
X-Received: by 2002:a05:600c:4e4f:b0:492:5e36:155a with SMTP id 5b1f17b1804b1-492608805b0mr66346215e9.34.1782327378499;
        Wed, 24 Jun 2026 11:56:18 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:17 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v9 3/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
Date: Wed, 24 Jun 2026 18:55:52 +0000
Message-Id: <20260624185554.362555-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624185554.362555-1-mahe.tardy@gmail.com>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
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

