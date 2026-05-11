Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C13CAE70
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489646; cv=none; b=SJQ0LgNWsYcf2MrSBu2OuMzRf4rqeZAEvTSRM5tOE6kT7L/pYgtMzqHy8HsEHHlDi4awKrDG9zVm1gDzcohculPYEvmR6W5GYmHThUuiy4W/PSxWvIISICOXbgpOHu5BLWiuaGAh60CqKDHnIytyfMfL8m1XZGlAHbEkoCo5o8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489646; c=relaxed/simple;
	bh=jftBf0nvnvP4b+8q+PC92GDYy6FURx6s4RdIMglxWZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMI5EGmuDSpCBJu/ldNWIQY0ibUZWgFqmGlRr62U/L9JgQ/BfdM8z6p7GVRj7WTOytwegJjNoaS5w/6bmahjdpf413CxuE1QVTzVua36dl+BmT6+qMHmv1YRdoSZ0qArIl9kn60XpI4ko4PRob5yAuQJiSAQAZKZ4EPb3GIQ/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZhzPm1G; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZhzPm1G"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-441209fb77eso2376826f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489643; x=1779094443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75eyMXpWhkoCDZVNgGch0+NK/tzxCTW62FD0g4hC9LE=;
        b=KZhzPm1GnXUMc6XPWx5RbLzsiHkZzJGf45BeHlMK/ARVPl69H1teS/wKQQ4HhCAgy4
         /McHx6GsCLSraTzkplybY0sBtsFKzTWW+3rUZBCHbpgbzHCu5HmyZimuY+SwRCZO7DvE
         LT1MO43G5g3XYv3bNjIQs4RNt6RM55xCVLW7W6EigV5Xw/msMjQRwCHRWZtHEAJVyPfc
         GVVut378WVaDCqmFlJb/x1rrvRSx+Zp/XXiTfPhtMaQzR08/VtviMCvJqOXw8NrSj0HE
         sBmne47UyBDHqZymF4lihCsqTDfFuwX8iPch7E9p+ZE+csaaynwAmnWz2zrImMn9VvPv
         Fgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489643; x=1779094443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75eyMXpWhkoCDZVNgGch0+NK/tzxCTW62FD0g4hC9LE=;
        b=NA6e3ao5NQb5rAsXumd1DaZIrkDwXd2Fem8EXazLQJjfXO+kTFTu3gGUiggeD4kUuh
         uxQP2hej6PjzNfhKOEsWLofVKewqj8b7Igji6EMQBCv8PaWbEZT66PmxhRacZ3/UzCc9
         +gOjqub1eJYKReqPAn7lp481pwvUJ4Xo4x2qJGBJBBhHPdQI7bKVdc6P8E0UDDNCDXJg
         JO3pnjg12flkol2O/r9fT0VyI90QM+4rrs+hmSJvc5/eYJJZR5xJRDE0knSEq2l3nkuV
         8i/IPgsTP8ICh7BI96SCFVeli3C6IkOxpuea+mgdkIt/02lktajHqycnyrgSmqQonPr4
         Doyw==
X-Gm-Message-State: AOJu0Ywid79umxsX5Olv/xWtyBKm5EjO2JaucCwsaWBQvYRODoAVOEPY
	UrbQcy1zXSY/gQ0t4tGuWCqu6Gs4jRQBLM0XcKR8c1eM1OsydZ/qqdHgXi2XNQB1Qyw=
X-Gm-Gg: Acq92OG5Udx7FgS7ETmDM+Ipcc7Qgtoch8XP71seR8J15A1txPO1FToiAc/Xw+5uAqj
	aQy6bedxtKsAPsKMWcH8ZIWtp/kkEGMwQTd6faLUeRGGc5yK3pYQxDnbyB/OqHZgzQzME+L6alN
	ckr+oBirR6pgCj2kKnfMazV+rAGYanwmDlUdx8ueOtzQjFLyAmKdIeu82EulUHy98IdETtwsiit
	XzBVrsJIfKjUviCRq+JoaVeIGjjDhItJVLRoXsjt0aYOLXaTr/XdFge6fSwbDiPx+riOAQ59+/c
	CfEw1pO1w+C4is4WUJDYWQh4QlR/YVZrLw1j+x3mA4KE1bHoqPc6pyKQHxSGUA6RQELPevNtCv4
	CKkJ3pHMDTZGFr0k1LAsiRfggV7Od9MrreWVIBlLnC8oIsETse29IRyM810p+mAOyp0no4lYMKG
	RjDl/KkPz7/Fa/YU3q5KMEKeuzIN0=
X-Received: by 2002:a5d:5a44:0:b0:451:4e0e:b8a3 with SMTP id ffacd0b85a97d-452e9e89c70mr18299211f8f.22.1778489642438;
        Mon, 11 May 2026 01:54:02 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23817156f8f.27.2026.05.11.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:01 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	liamwisehart@meta.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH v1 3/4] selftests/bpf: Add netpoll kfunc IPv6 variant test
Date: Mon, 11 May 2026 08:53:43 +0000
Message-Id: <20260511085344.3302-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511085344.3302-1-mahe.tardy@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that exercises the bpf_netpoll kfuncs end-to-end with
IPv6, reusing the code that was added for IPv4.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/netpoll.c        | 42 +++++++++++++++----
 .../selftests/bpf/progs/netpoll_sanity.c      | 33 +++++++++++----
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netpoll.c b/tools/testing/selftests/bpf/prog_tests/netpoll.c
index 1cfac4b13e7d..eac0378c426a 100644
--- a/tools/testing/selftests/bpf/prog_tests/netpoll.c
+++ b/tools/testing/selftests/bpf/prog_tests/netpoll.c
@@ -9,15 +9,20 @@
 #include "netpoll_sanity.skel.h"

 #define NS_TEST "netpoll_sanity_ns"
+#define NS_TEST_V6 "netpoll_sanity_ns_v6"
 #define DUMMY_DEV "dummy0"
 #define DUMMY_IP "10.0.0.1"
 #define REMOTE_IP "10.0.0.2"
+#define DUMMY_IP6 "fd00::1"
+#define REMOTE_IP6 "fd00::2"

-void test_netpoll_sanity(void)
+static void run_netpoll_test(const char *ns_name, const char *local_ip,
+			      const char *remote_ip, bool ipv6)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct nstoken *nstoken = NULL;
 	struct netpoll_sanity *skel;
+	struct in6_addr addr6;
 	int err, pfd, fd;

 	skel = netpoll_sanity__open_and_load();
@@ -25,18 +30,28 @@ void test_netpoll_sanity(void)
 		return;

 	/* Create a network namespace with a dummy device */
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link add %s type dummy", NS_TEST, DUMMY_DEV);
-	SYS(fail, "ip -net %s addr add %s/24 dev %s", NS_TEST, DUMMY_IP, DUMMY_DEV);
-	SYS(fail, "ip -net %s link set %s up", NS_TEST, DUMMY_DEV);
-
-	nstoken = open_netns(NS_TEST);
+	SYS(fail, "ip netns add %s", ns_name);
+	SYS(fail, "ip -net %s link add %s type dummy", ns_name, DUMMY_DEV);
+	if (ipv6)
+		SYS(fail, "ip -net %s addr add %s/64 dev %s", ns_name, local_ip, DUMMY_DEV);
+	else
+		SYS(fail, "ip -net %s addr add %s/24 dev %s", ns_name, local_ip, DUMMY_DEV);
+	SYS(fail, "ip -net %s link set %s up", ns_name, DUMMY_DEV);
+
+	nstoken = open_netns(ns_name);
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto fail;

 	/* Configure the BPF program globals */
 	snprintf(skel->bss->dev_name, sizeof(skel->bss->dev_name), "%s", DUMMY_DEV);
-	skel->bss->remote_ip = inet_addr(REMOTE_IP);
+	if (ipv6) {
+		if (inet_pton(AF_INET6, remote_ip, &addr6) != 1)
+			goto fail;
+		__builtin_memcpy(&skel->bss->remote_ip6, &addr6, sizeof(addr6));
+		skel->bss->ipv6 = 1;
+	} else {
+		skel->bss->remote_ip = inet_addr(remote_ip);
+	}
 	skel->bss->local_port = 5555;
 	skel->bss->remote_port = 6666;
 	skel->bss->remote_mac[0] = 0xaa;
@@ -87,6 +102,15 @@ void test_netpoll_sanity(void)
 fail:
 	if (nstoken)
 		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	SYS_NOFAIL("ip netns del %s &> /dev/null", ns_name);
 	netpoll_sanity__destroy(skel);
 }
+
+void test_netpoll_sanity(void)
+{
+	if (test__start_subtest("ipv4"))
+		run_netpoll_test(NS_TEST, DUMMY_IP, REMOTE_IP, false);
+
+	if (test__start_subtest("ipv6"))
+		run_netpoll_test(NS_TEST_V6, DUMMY_IP6, REMOTE_IP6, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/netpoll_sanity.c b/tools/testing/selftests/bpf/progs/netpoll_sanity.c
index 9e1e595eff2c..26303632ebde 100644
--- a/tools/testing/selftests/bpf/progs/netpoll_sanity.c
+++ b/tools/testing/selftests/bpf/progs/netpoll_sanity.c
@@ -12,9 +12,11 @@
 /* Globals for passing config from userspace */
 char dev_name[16] = {};
 __be32 remote_ip;
+struct in6_addr remote_ip6;
 __u16 local_port;
 __u16 remote_port;
 __u8 remote_mac[6] = {};
+int ipv6;

 /* Results */
 int status;
@@ -35,10 +37,14 @@ int netpoll_setup_test(void *ctx)
 	status = 0;

 	__builtin_memcpy(opts.dev_name, dev_name, 16);
-	opts.remote_ip = remote_ip;
+	if (ipv6)
+		__builtin_memcpy(&opts.remote_ip6, &remote_ip6, sizeof(remote_ip6));
+	else
+		opts.remote_ip = remote_ip;
 	opts.local_port = local_port;
 	opts.remote_port = remote_port;
 	__builtin_memcpy(opts.remote_mac, remote_mac, 6);
+	opts.ipv6 = ipv6;

 	bnp = bpf_netpoll_create(&opts, sizeof(opts), &err);
 	if (!bnp) {
@@ -88,7 +94,9 @@ int BPF_PROG(netpoll_dummy_xmit, struct sk_buff *skb, struct net_device *dev)
 	unsigned char *data;
 	struct ethhdr eth;
 	struct iphdr ip;
+	struct ipv6hdr ip6;
 	struct udphdr udp;
+	unsigned int offset;

 	if (bpf_probe_read_kernel(&data, sizeof(data), &skb->data) < 0)
 		return 0;
@@ -97,19 +105,28 @@ int BPF_PROG(netpoll_dummy_xmit, struct sk_buff *skb, struct net_device *dev)

 	if (bpf_probe_read_kernel(&eth, sizeof(eth), data) < 0)
 		return 0;
-	if (eth.h_proto != bpf_htons(ETH_P_IP))
-		return 0;

-	if (bpf_probe_read_kernel(&ip, sizeof(ip), data + sizeof(struct ethhdr)) < 0)
-		return 0;
-	if (ip.protocol != IPPROTO_UDP)
+	if (eth.h_proto == bpf_htons(ETH_P_IP)) {
+		if (bpf_probe_read_kernel(&ip, sizeof(ip), data + sizeof(struct ethhdr)) < 0)
+			return 0;
+		if (ip.protocol != IPPROTO_UDP)
+			return 0;
+		offset = sizeof(struct ethhdr) + (ip.ihl * 4);
+	} else if (eth.h_proto == bpf_htons(ETH_P_IPV6)) {
+		if (bpf_probe_read_kernel(&ip6, sizeof(ip6), data + sizeof(struct ethhdr)) < 0)
+			return 0;
+		if (ip6.nexthdr != IPPROTO_UDP)
+			return 0;
+		offset = sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
+	} else {
 		return 0;
+	}

-	if (bpf_probe_read_kernel(&udp, sizeof(udp), data + sizeof(struct ethhdr) + (ip.ihl * 4)) < 0)
+	if (bpf_probe_read_kernel(&udp, sizeof(udp), data + offset) < 0)
 		return 0;
 	if (udp.dest != bpf_htons(remote_port))
 		return 0;
-	if (bpf_probe_read_kernel(&driver_xmit, sizeof(driver_xmit), data + sizeof(struct ethhdr) + (ip.ihl * 4) + sizeof(struct udphdr)) < 0)
+	if (bpf_probe_read_kernel(&driver_xmit, sizeof(driver_xmit), data + offset + sizeof(struct udphdr)) < 0)
 		return 0;

 	return 0;
--
2.34.1

