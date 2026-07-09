Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11B381E95
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608558; cv=none; b=ZavGy7lYaPEUGroeX97qgrNOy/Jy1DJGoaKs1TvJZbdwwLXAHM8dQfaiuOXak4BXJ+hjv/Rjw3bGBIkhrjWIzR/kX05wH/LWMBO6IjggAXNOACrFZOpWZ3sSH85ohWeXOkaPSnwNy978DF0BixvTE6ybaErEB/128IPAwfmqJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608558; c=relaxed/simple;
	bh=/zOQc9ZSIDjz8Z2ZLlfPthihY0iqYqU0xYSz4Bs+PRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/wbx6Bx6mMX82lvIfKtftL8grDOgzGObz5ZT9TuGE/gXVo3q3dMczhRA37CvqyfEDBR1F9gYMuWw/9weCdG+DdxjrzfTfv0oXlAPzlygC36GPjYchw9YLY4JtSjBTd0wTFSLqRugFrx7EKd4rNjiHags2p8HLi3Psczqt+MsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEYiqg0a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEYiqg0a"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso9099735e9.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608555; x=1784213355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEpVvmKSBmn+AWACSLzxjW8KlXjZyDGmgFaj+T7jvZI=;
        b=PEYiqg0aMKwS+a43sf12aVFdpm3D8rlfEmEaAa6LJbb0Q/ng1HryZy0XvEcQnNTZFu
         WLyb1/SJpPByiDXmMbDAXoDNS/zqLQkeD6ISQz3A7LFoPATQzFbmen0JTmmyArBfCB0H
         uxX1dWpS5G+TaaCm2DIFjZWalRytWGCM1c8tXWvyAzGVVkYy0Omt7Q2MbF9UdJxnSDBq
         XFPG0unCAALlQVvXuUSIiL7toQzaDmt6WJpyRX8AcmZwAciJgw2i3q0IX9SFLBXQniKr
         YDBxNtmP3gtf0hKoRsnPHpDSvibRCZwMSA20w/qlXWSyI+wkpzJarqonXRcofKxO+tx0
         f66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608555; x=1784213355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qEpVvmKSBmn+AWACSLzxjW8KlXjZyDGmgFaj+T7jvZI=;
        b=VOquM5vZqxN6G+eiv2d48obLS+uEs4x+9/+2km1VTRUfVBxfSRymqLDP7Cwy5ri4bd
         sHP4/4ZodDEHb1FFTVXLXOhRYbLOiM4CyWJdVbs7cny0HYMB/i6ZG3KV3ymtql9LQiyK
         a3Ss06geHqiR6XdTm8mEv0c1wXbAYI7xOvCbpJOXgwZA2MnD/QFQtS+/fCERrgNTk9QH
         XHqqvzd7ZWxMEgtsBz8u4Z3l57xmiYEu6o2Js5rswhUqcGQ7ue/umNW7eqC+VTqWojaL
         DsS0vjnELmQCcVS00SvxdKtOBXcPYIgQ6io3B7stHeU+B5lCQPaRKO8aFzHp8s3tg7a0
         AJ8Q==
X-Gm-Message-State: AOJu0YwcIXLYl3tJb8U0cQX3rug3zw8A1m2lOZvZKRbAYCLMJ5es0cjv
	BI1c2t3x0K7l7lXk0KMmd4LIrVqB021m5Pg8YFeLLqLjCrmekPpLeQXxGesPb0Vp+58=
X-Gm-Gg: AfdE7clFXJAkhqGbXUFr32Zy7H9fLykWOuyOfCveSmzJoFeQ+mQ+WnWUWnNenrGnTpu
	53AJakP5d8UW/QLp0nuy8dhXGrHlIPcSkkyUAGhPzqijzLO1IqDeljcDerdteM3AZUaITM53i+d
	wMWekYSJYGP2y7dAiO63bJ+UWD4Hg3vNsYuVma93BG/Zhuj4Jmjo1uNSKqhsYuEkCxTvjgcmd/w
	COmA0Uae5OPN0F0YYWbpAS8pPicvUO8EJ0A7pgjPwCeQGvtbLuHnq49Uzx21KzETGE/ldqtKcjU
	wtrrg7BPWOzTPTDJ2t1bXE0hD+FxADziFYTKuq9sqUZqEstuH5kVPeTTP0AoKEPlN+kEcwhygFF
	Le4S9FSA827AW4AVYKYtrlpB53iY2RViW9Kgx1+hwyJUpl9poBuUjDQPv5M01oHT1D8+GJ8dlGj
	BRjGE8RetHHv1U/QMu24Jjcl8F5o3GGSIMfV+ZHVIe01Vt2Cz5jcRhQoNOSTkzFQLNFixV
X-Received: by 2002:a05:600c:6206:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-493e68c8063mr76201165e9.19.1783608554585;
        Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
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
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 3/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
Date: Thu,  9 Jul 2026 14:48:58 +0000
Message-Id: <20260709144900.245904-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
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

