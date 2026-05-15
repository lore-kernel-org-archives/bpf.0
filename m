Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBC413D60
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874491; cv=none; b=VqbbRKowGKHoI5GMEWhnioKpOIBGdKqhnS/x8fsteHN3BCRKauDcpDsGmf9jdTjf7NGWEpMpwImINYFZPJIXFrLdAw2t4Mj7mDU/T7B8AFZrr4fTSajBiIvlMg9w9JetTBvjApysBsFDTo/hTxg4PVGgdMs61tdW6ZEDic0hEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874491; c=relaxed/simple;
	bh=aieHkWTb5KdhwCOuY7iUo+1CQAvKUUKZfFH/f/EXpqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jU5DnHl13ULg9XFg7Ju9RDkTteMSzYr17ZGTVTnBFHs0zqYkMMhGFYBpQoNGyolwXXscCthqT/jrR6RB8H187kyRosQyldj0VQ4FGMd43rPqAWwRbOMCfyTjzExeobA0eGUvJvFm44B9K+sjE7CNpd3GQg0SAz9cyhPOe9F9khk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlGj8FKq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlGj8FKq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso1340715e9.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874480; x=1779479280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE+kWiVwTBK//nqL89vvRu6lWOgjMqCngZLqzXZ82yw=;
        b=qlGj8FKqZcZ1clfW5UzX2J4pcE1qnHqroDXiPniYvEQwf/zlMf4deRL4wIlMHZEtfH
         BmGMLuMCi90PUV4Q+vinz7LbMSY/hnGgbAsLKwRpJLpHQBXL+aBOH6jSlQHYuWX4n7xh
         sTM/I3T0auEhlWxDQpDveVUxxL4QAaAlgBqHhvWqtjA9b+v05OUr+fJmA8eYSztrCb15
         VMELYqeAj/WnCNHpDiH9bIsr7p1K5fW+H/m0ZRHYAIdGaSDUWIHxT8PaAyHRAK/PJfV5
         sl+Ezf29ahwSza5IRs3+fkQZYc1kSHLzEbqvIXfgtN2uRkQQHqXKwFWN1yH3U+PCNq7J
         NBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874480; x=1779479280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IE+kWiVwTBK//nqL89vvRu6lWOgjMqCngZLqzXZ82yw=;
        b=FIsei74ttPDivT6/iUY0qSX3PKxXxtPd2eI6TS4/2UMvS8G5A87kQG6VNRLNxjwmPj
         So/nYepXI4JoL8yQ597L4LryEFrBLe1siFDeURLGPW0Q4JRRCcyN1RkHnPha1xI/Fy6M
         hNvXumS6IxWexPgO05dDc/JvpPetnFS4V7MfTM5PWOXhCg6gd8pP8Qo3+badz+RNawkG
         lCgxe5lYwrUyY0NIasBkIaFyona6pAAswViwPBxPvbNhgM007D0ev2LLdayaCDO6pHDv
         AWVB7be8ecyX1PEiGL1c32VXIhbf2AYpDm0gc2d52zK14buYFRv0ROq/d/ybgFybOe4Y
         iRSA==
X-Gm-Message-State: AOJu0YxlYrAtQoOHaRowZganV30RaJDoYfn+l7+Oy2stQiJdb3ORY6B4
	VKztAPIeNNhyasOQjNU4J7g+Ju/CQpBpJ2OZnDYf4sC2+59DrHD0sbTNUchItvFD
X-Gm-Gg: Acq92OEIkeBuQM6+QvGnu/jbwoxGkJLeEMi9xXS0GSgw0EQcdwB7X9g6wMTRbgoVCHy
	aJrvTh6HSuaqJpiFEiSD5SUplx+9dh/Scg0GI1iGD5wUlo8H/hgrVZOxc+9OPJ/L45ewhmjhBvu
	LIpPyLLFGaLaRdfjhZn6+Rhdi5VkBmaF+R6PL7iZ69RttfuNB/YJZwYqQzfvlKHE6mqncQFwp+9
	cT3kf2B+nNlTFP6k6LPidqQvuE67F6WHpffWdY00AnKOnuo45vkhh2kih9RtqK75azShIgjdrVY
	iKu9O/amsgsetRAhDQgIE0TdQWanS8AbRvZ9LzSS4quviU/B7rw6Y1tiG65c9KOFCERESNC2iPs
	88PWCN/G4np1SlscHRSBD2CfyAC5y7oXZ04VsVAmbCjdRBSRqOCcZZIrNp/6iZOEwVpFl50Ddn3
	gfwQA3LUreim1h8MXbrt9mE2kj7Nb578kcLVSf8w==
X-Received: by 2002:a05:600c:c494:b0:48e:706b:53e8 with SMTP id 5b1f17b1804b1-48fe60ecd88mr75398505e9.11.1778874479900;
        Fri, 15 May 2026 12:47:59 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm77509945e9.2.2026.05.15.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:47:59 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
Date: Fri, 15 May 2026 19:47:45 +0000
Message-Id: <20260515194746.50920-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515194746.50920-1-mahe.tardy@gmail.com>
References: <20260515194746.50920-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test extends the existing tests with IPv6 support.

Note that we need to set IPV6_RECVERR on the socket for IPv6 in
connect_to_fd_nonblock otherwise the error will be ignored even if we
are in the middle of the TCP handshake. See in
net/ipv6/datagram.c:ipv6_icmp_error for more details.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 76 +++++++++++++------
 tools/testing/selftests/bpf/progs/icmp_send.c | 48 +++++++++---
 2 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index b98c0312adad..d9badfc6e620 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -8,15 +8,17 @@
 #define TIMEOUT_MS 1000

 #define ICMP_DEST_UNREACH 3
+#define ICMPV6_DEST_UNREACH 1

 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
+#define ICMPV6_REJECT_ROUTE 6

 static int connect_to_fd_nonblock(int server_fd)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
-	int fd, err;
+	int fd, err, on = 1;

 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
 		return -1;
@@ -25,6 +27,12 @@ static int connect_to_fd_nonblock(int server_fd)
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
@@ -34,7 +42,7 @@ static int connect_to_fd_nonblock(int server_fd)
 	return fd;
 }

-static void read_icmp_errqueue(int sockfd, int expected_code)
+static void read_icmp_errqueue(int sockfd, int expected_code, int af)
 {
 	ssize_t n;
 	struct sock_extended_err *sock_err;
@@ -44,6 +52,12 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 		.msg_control = ctrl_buf,
 		.msg_controllen = sizeof(ctrl_buf),
 	};
+	int expected_level = (af == AF_INET) ? IPPROTO_IP : IPPROTO_IPV6;
+	int expected_type = (af == AF_INET) ? IP_RECVERR : IPV6_RECVERR;
+	int expected_origin = (af == AF_INET) ? SO_EE_ORIGIN_ICMP :
+						SO_EE_ORIGIN_ICMP6;
+	int expected_ee_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						 ICMPV6_DEST_UNREACH;
 	struct pollfd pfd = {
 		.fd = sockfd,
 		.events = POLLERR,
@@ -61,16 +75,16 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 		return;

 	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
-		if (cm->cmsg_level != IPPROTO_IP ||
-		    cm->cmsg_type != IP_RECVERR)
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
@@ -78,14 +92,13 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 }

 static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
-					    int code)
+					    int code, int af, const char *ip)
 {
 	int srv_fd = -1, client_fd = -1;
 	struct sockaddr_in addr;
 	socklen_t len = sizeof(addr);

-	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
-			      TIMEOUT_MS);
+	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		return;

@@ -94,6 +107,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
 		return;
 	}
 	skel->bss->server_port = ntohs(addr.sin_port);
+	skel->bss->unreach_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						    ICMPV6_DEST_UNREACH;
 	skel->bss->unreach_code = code;

 	client_fd = connect_to_fd_nonblock(srv_fd);
@@ -103,13 +118,33 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
 	}

 	/* Skip reading ICMP error queue if code is invalid */
-	if (code >= 0 && code <= NR_ICMP_UNREACH)
-		read_icmp_errqueue(client_fd, code);
+	if (code >= 0 && ((af == AF_INET && code <= NR_ICMP_UNREACH) ||
+			   (af == AF_INET6 && code <= ICMPV6_REJECT_ROUTE)))
+		read_icmp_errqueue(client_fd, code, af);

 	close(client_fd);
 	close(srv_fd);
 }

+static void run_icmp_test(struct icmp_send *skel, int af,
+			  const char *ip, int max_code)
+{
+	for (int code = 0; code <= max_code; code++) {
+		/* The TCP stack reacts differently when asking for
+		 * fragmentation, let's ignore it for now.
+		 */
+		if (af == AF_INET && code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code, af, ip);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test an invalid code */
+	trigger_prog_read_icmp_errqueue(skel, -1, af, ip);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+}
+
 void test_icmp_send_unreach(void)
 {
 	struct icmp_send *skel;
@@ -128,20 +163,11 @@ void test_icmp_send_unreach(void)
 	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
 		goto cleanup;

-	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
-		/* The TCP stack reacts differently when asking for
-		 * fragmentation, let's ignore it for now.
-		 */
-		if (code == ICMP_FRAG_NEEDED)
-			continue;
-
-		trigger_prog_read_icmp_errqueue(skel, code);
-		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
-	}
+	if (test__start_subtest("ipv4"))
+		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);

-	/* Test an invalid code */
-	trigger_prog_read_icmp_errqueue(skel, -1);
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

