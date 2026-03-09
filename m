Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2603C1976
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062232; cv=none; b=ENTJysZqaT/Fpqdgrx1PDJVSK8WG037jZEDJJ+DRsyl7+vVXA39LZCQ6yQn8k47vS08DnIEcJ1hs1zkY60MTC2VA5GIExRf3pjm3SwlbFMiXcwJjBhK9dTYpfq/wCc4EdSvDRMTbrKlwHRVVjReu/itkUpMnjuP8GaZ9lK+SfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062232; c=relaxed/simple;
	bh=9uolMe4mt+fewYIS/Y2CGZRTOc9L2T+RusBV/vPo8Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmG49a/+DXs7TCBW/CyiEY/9FnEcJ4DClovHU2L/uidVI7YYEpiBll7rWe17MPaajm6YfWr3p+R9lAzMTEvcjhEng2NIFSZP2X3bTijyZgc74442dM+85Ji8wOmJMKJW9Efl+0ooaFN03KD6QfBTYHAndZ5aOJwRBI/btbEasrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abSV78as; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abSV78as"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48534237460so16310055e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062229; x=1773667029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1qlQj0LMyTyKLVnpTN0fdnwkMuQ3XNP9Fqmf84gU9k=;
        b=abSV78asjnWWVfJA6Q6NL7voqrLe8x+uVkXYt0Vqm61mKJZ0fCtEDb3l0rdsUsbm0K
         oxYwT6K7Zx32SxiAnGDD2BEG8PiaSm4T5jVFkrRjfreITK38JhebbaAnRnLcQuyVzdpW
         +4+U4LXKJ6rdel6NrhkIjw8yywWpfC7vIPSwPbHkQmUs6vE7X/BOR10c49hx4mCa4ujq
         8BUAb0v8Cs1TkDd2kpV4juV2AeqhFolFHjwpY+KUAOR4SKmRRhP+9tRNHhuToYCWZRCs
         a8pZQoEgd2krVv6BvzR/nLbcqEXcgDP35+ShK3X4tVBfjtY0L4p4aPyQWU3nAyjRl53f
         iVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062229; x=1773667029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1qlQj0LMyTyKLVnpTN0fdnwkMuQ3XNP9Fqmf84gU9k=;
        b=vbG0veWZDG77Tk8kIHjfb/75Uv7R3Y57Bpq4fN+KpHbr//dSABWdPqwGK4gHOtOi59
         Ts1ZPO2r6EqiKjw1kXhTM8n2EivG2vliI553zpTvjzNVEdsreUKuBMNz7BxJ1JV1BXS/
         I0gS1u6GUZq9IcmxRhwt70BhNr9KbHb5IXCIwz97Qra/6RuF8VpprOYJnayop7nlPM1E
         XoQhHCw9Ap5+f/T783p9+PnCXAtlxP5GfeYzaLCwGZhHS/88MDz/svWkYLBh7jHG7Iy/
         zpQSsZVyGvRzHOm6xG1fLcoVU0/p8pq1LSwB4dnqBW+t14g6slIV7HfzB+YkqH/dwQw3
         9SAg==
X-Gm-Message-State: AOJu0Ywft4W3EhLXdw+V+iQYa0jhttuK9DvlGNfR97/mJRnsGvOoB2xj
	JGyD0V7Nqy8a3gYTX+xnPoELISmfbO0IE/aEABnZIOkMi97BZKCOvIvARzcds7oc95M=
X-Gm-Gg: ATEYQzzcg86Va0YCb/IJPuMMeqM+RSloqjrDeNxjmwXx6HRIcphMP2VjT5W7LlBdcbr
	xJLgxeav1n1/V8K2poT2U3StXROwEVvXc7MdeTfVzKt6G8trMeVnnuLdSoyhWvpnoWqiiKeSN4f
	813URAfFjufzHmCuwyo6jPrFZyu+hw7LDUvVSBcFyF75l8uWZjfGMFJWMZf3YHDsPvxciDMhJU8
	q7mQlSCTSxDYkFS84dOHsdeLeyu6NSrOpRgeehLYRSFf/Yxm4J+HPW+y0UL5GJQXFWw9qvtVhsJ
	6nHWIOjDAWCaXvFaMGpmlf2PycRsz+T6/1ZWi3McTEFx7HX1AINfMsrHKRXnM0kuLUVp7Xqeoq7
	W03Rwc/mqrMxFmtZ3hpovuiGmOLrRuiXWQdNZzFek2RjaIlKaYuR9uScFGv3HY5lKexw5NZkFjB
	REbViRmPY1h995xEKna1A9joqI8ewwbBfwzz7VXQ==
X-Received: by 2002:a05:600c:4e8b:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485363bfcc7mr71921515e9.1.1773062228806;
        Mon, 09 Mar 2026 06:17:08 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-485246ece8bsm128506395e9.4.2026.03.09.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:17:08 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [RFC PATCH bpf-next 3/4] selftests/bpf: Add netpoll kfunc IPv6 variant test
Date: Mon,  9 Mar 2026 13:16:34 +0000
Message-Id: <20260309131635.302424-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309131635.302424-1-mahe.tardy@gmail.com>
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
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
 .../selftests/bpf/prog_tests/netpoll.c        | 43 +++++++++++++++----
 .../selftests/bpf/progs/netpoll_sanity.c      | 33 ++++++++++----
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netpoll.c b/tools/testing/selftests/bpf/prog_tests/netpoll.c
index 1cfac4b13e7d..f2548f1f9349 100644
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
@@ -87,6 +102,16 @@ void test_netpoll_sanity(void)
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
+	run_netpoll_test(NS_TEST, DUMMY_IP, REMOTE_IP, false);
+}
+
+void test_netpoll_sanity_ipv6(void)
+{
+	run_netpoll_test(NS_TEST_V6, DUMMY_IP6, REMOTE_IP6, true);
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

