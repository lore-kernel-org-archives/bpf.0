Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D93A83B1
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390914; cv=none; b=GKyxrdVR3qOksRcEVg6luj/pSnfa3BgTbp+yckOME9IQ7f4fbesaqtLaP+H203wjndntOt5hSBrMMIu4O2GIHVtZfpAAe6CBLjFkK+WgOq2feoM2b8fb7aKIXpFmlncrxWMBCThGzYu1c6yfXBsLERywNmUjR1Zteel4dLLdUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390914; c=relaxed/simple;
	bh=c9CY//KjYCoWquJgViQlRQ9u8ssg5aUR81qepc/THhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OgItUmUGhCoCQJaV5PnxbCfeRYYuku2INxXW6JwcZhv7D1Zm3RuPjWcWK4udikKtu1ppcwechWSKg0OX+d/1XrQWjoJtNM1neVS8c2KuH5FC0/0/WODXu9UZG2Pxg5ZfT0i/Pp2hxsiuvKGzd7uH67l3nE3OFjmiQODgE0gKdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDTSuqG/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDTSuqG/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84245e2bb00so1982444b3a.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781390911; x=1781995711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5sRi83XH9MXIyr3VV4a1cHDENoBfAAeIf89BWKJdi0=;
        b=YDTSuqG/BopfDcguy5uJATFOVY9AYffqnhzz+EFhKMs8pdTA0nVAP0n/tED6NosYy9
         nnWMKHPUl0xKDs2fG9d9MD10qSZcySsDTnZ69OJF1HuKPDR5dqCUDVei+OYcW81jepYH
         o05/2OwqzyujzMQZ8K8MMgBeR4tPl1m8cbb57nFLVhfJyDHnEZpSTDflrfK5eDKA6JAX
         aRb6AQifsg10u+ryubZLq4qhccsDHe9l42Ou3KkLXvN0Oyh+NtfSSWSi16cgWcOcLqM2
         iEer6gTo9LmBPjJrVqyz6Aeo/idRttpTeO8uNW4fGeq7nrecxQuNAPiNoXC+9cXH/yeH
         8LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390911; x=1781995711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5sRi83XH9MXIyr3VV4a1cHDENoBfAAeIf89BWKJdi0=;
        b=e9sNSm2onyJYJVchqrGbIgstj8HtGhOJ5NyLPkzJBM6CjnWwp9MBJhp4A1r3kb87ms
         LdSH7DbWSCcu2aAWF92WgCcE3AOib7sCAqbs/nWdbOi/+vSVEvwMTpPFZweXc4AG32dT
         TErHkp9DzMlZN7YVeezcG88NaQMmdtJgGG1fN4ZItfrNHVZ7tuek4s8USUFt8lYgfmQN
         o5/Cmre6gCOrrNcKY4bXFCktRYBNs521EgjmZaWn72R7bnXn8XRd4c7jASpFlC9qfmnB
         Gq6JgISi4UGfLGrkKn73ukWF7waldRGLCgK0/nzn67QHlnQLkUZr86BU3xog4d8PMYMV
         0Nuw==
X-Forwarded-Encrypted: i=1; AFNElJ90MDwU2C6P9cHpU8ZeuzJly8shppseHVKsuWxCKgtS3MNXOx4/tzyuYosR9wrMMyRsa5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjjjKI6l7dO5SpKWi2G/yNXHmaxy+QOTEW92PKU2+72jDnvnU
	HJHZKXexq58m/5UPd4PWtx01+8/Ltna1NkF0rhNWTG92Rn2jG8hJSqDM09THnVSeXwLb/zHZs4w
	3HwZ4Cw==
X-Received: from pfez11.prod.google.com ([2002:aa7:888b:0:b0:844:e56c:ba8c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a883:b0:843:4937:6d0e
 with SMTP id d2e1a72fcca58-8434ce269a8mr9189886b3a.16.1781390911080; Sat, 13
 Jun 2026 15:48:31 -0700 (PDT)
Date: Sat, 13 Jun 2026 22:48:08 +0000
In-Reply-To: <20260613224823.2399535-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613224823.2399535-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613224823.2399535-5-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 4/4] selftest: bpf: Add test for hwtstamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This selftest simulates the hardware timestamp proxy scenario mentioned
in the previous commits using two UDP sockets.

Here, app_fd represents a standard socket application, and proxy_fd
simulates a userspace proxy that receives and injects encapsulated
packets from/to app_fd via a GENEVE device (geneve0).

TX:
   1. app_fd sends data w/ SCM_TS_OPT_ID
   2. BPF prog hooks at tc/egress of geneve0
   3. BPF inserts the GENEVE option with Type 0x1 to save SCM_TS_OPT_ID
   4. proxy_fd receives the encapsulated packet
   5. proxy changes the option Type to 0x2 and sets TX hwtstamp
   6. proxy sends it back to geneve0
   7. BPF prog hooks at tc/ingress of geneve0
   8. BPF extracts TX hwtstamp into skb
   9. BPF looks up the app_fd socket
  10. BPF enqueues skb to app_fd's sk->sk_error_queue
  11. app_fd receives TX hwtstamp and verifies the value

RX:
  12. proxy_fd generates RX packet from TX packet
       by swapping src/dst in each header
  13. proxy changes the option Type to 0x3 and sets RX hwtstamp
  14. proxy sends the encapsulated packet to geneve0
  15. BPF prog hooks at tc/ingress of geneve0
  16. BPF extracts RX hwtstamp into skb
  17. app_fd receives RX hwtstamp and verifies the value

The GENEVE TLV option is structured as follows:

    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Option Class         |      Type     |0|0|0| Length  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                     HW Timestamp  (8 bytes)                   +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                     Timestamp key (4 bytes)                   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Type:
   - 0x1: TX packet
   - 0x2: TX completion packet w/ TX hwtstamp
   - 0x3: RX packet w/ RX hwtstamp

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3
  * Drop bpf_kfunc.h change

v2:
  * Use scm_timestamping64 (Sashiko)
  * Correct saw_tskey check (Sashiko)
  * Fix retval check for bpf_skb_get_tunnel_opt() with
     (int) cast (Sashiko)
  * bpf-style comment
---
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 236 +++++++
 3 files changed, 825 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
new file mode 100644
index 000000000000..175d8be74804
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include <sys/epoll.h>
+#include <net/if.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
+#include "test_progs.h"
+#include <network_helpers.h>
+#include "proxy_hwtstamp.skel.h"
+
+#define swap(a, b)				\
+	do {					\
+		typeof(a) __tmp = (a);		\
+		(a) = (b);			\
+		(b) = __tmp;			\
+	} while (0)
+
+#define swap_array(a, b)			\
+	do {					\
+		char __tmp[sizeof(a)];		\
+		memcpy(__tmp, a, sizeof(a));	\
+		memcpy(a, b, sizeof(a));	\
+		memcpy(b, __tmp, sizeof(a));	\
+	} while (0)
+
+struct genevehdr {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	u8 opt_len:6;
+	u8 ver:2;
+	u8 rsvd1:6;
+	u8 critical:1;
+	u8 oam:1;
+#else
+	u8 ver:2;
+	u8 opt_len:6;
+	u8 oam:1;
+	u8 critical:1;
+	u8 rsvd1:6;
+#endif
+	__be16 proto_type;
+	u8 vni[3];
+	u8 rsvd2;
+};
+
+struct geneve_opt {
+	__be16	opt_class;
+	u8	type;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	u8	length:5;
+	u8	r3:1;
+	u8	r2:1;
+	u8	r1:1;
+#else
+	u8	r1:1;
+	u8	r2:1;
+	u8	r3:1;
+	u8	length:5;
+#endif
+};
+
+struct proxy_header {
+	struct genevehdr geneve;
+	struct geneve_opt geneve_opt;
+	s64 hwtstamp;
+	u32 tskey;
+	struct ethhdr eth;
+	union {
+		struct {
+			struct iphdr ip;
+			struct udphdr udp;
+		} v4;
+		struct {
+			struct ipv6hdr ip;
+			struct udphdr udp;
+		} v6;
+	};
+} __attribute__((packed));
+
+#define GENEVE_VNI		0x900913
+#define GENEVE_OPT_CLASS	0x9009
+#define GENEVE_OPT_LEN		((sizeof(struct proxy_hwtstamp_opt)	\
+				  - sizeof(struct geneve_opt)) / 4)
+enum {
+	GENEVE_OPT_TYPE_TX	= 1,
+	GENEVE_OPT_TYPE_TX_CMPL	= 2,
+	GENEVE_OPT_TYPE_RX	= 3,
+};
+
+#define APP_DST_IPV4		"192.168.0.1"
+#define APP_DST_IPV6		"2001:db7::92"
+
+#define GENEVE_PORT		6081
+#define APP_SRC_IPV4		"10.0.3.1"
+#define APP_SRC_IPV6		"2001:db8::1"
+
+#define HWTSTAMP		0x12345678
+#define TSKEY			0xaabbccdd
+
+static struct proxy_hwtstamp_test_case {
+	char name[8];
+	int family;
+	char geneve_remote_ip[16];
+	char geneve_local_ip[16];
+	char app_dst_ip[16];
+	int app_dst_port;
+	int encap_payload_len;
+
+	/* fields below are populated during test. */
+	struct proxy_hwtstamp *skel;
+	struct netns_obj *netns;
+	struct sockaddr_storage geneve_remote_addr;
+	struct sockaddr_storage geneve_local_addr;
+	socklen_t addrlen;
+	int proxy_fd;
+	int app_fd;
+#define APP_PAYLOAD_LEN		512
+	char app_payload[APP_PAYLOAD_LEN];
+	char encap_payload[APP_PAYLOAD_LEN + sizeof(struct proxy_header)];
+} test_cases[] = {
+	{
+		.name = "IPv4",
+		.family = AF_INET,
+		.geneve_remote_ip = "127.0.0.1",
+		.geneve_local_ip = APP_SRC_IPV4,
+		.app_dst_ip = APP_DST_IPV4,
+		.app_dst_port = 443,
+		.encap_payload_len = APP_PAYLOAD_LEN + offsetofend(struct proxy_header, v4),
+	},
+	{
+		.name = "IPv6",
+		.family = AF_INET6,
+		.geneve_remote_ip = "::1",
+		.geneve_local_ip = APP_SRC_IPV6,
+		.app_dst_ip = APP_DST_IPV6,
+		.app_dst_port = 443,
+		.encap_payload_len = APP_PAYLOAD_LEN + offsetofend(struct proxy_header, v6),
+	},
+};
+
+char *ipv4_commands[] = {
+	"ip link set dev lo up",
+	"ip link add geneve0 type geneve local " APP_SRC_IPV4 " external",
+	"ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
+	"ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
+	"ip link set dev geneve0 up",
+	"ip route add " APP_DST_IPV4 "/32 dev geneve0",
+	/*
+	 * We do not forward ARP to the wire in this test,
+	 * so a static neighbour entry is needed for APP_DST_IPV4.
+	 */
+	"ip neigh add " APP_DST_IPV4 " lladdr ab:bc:cd:de:ef:fa dev geneve0",
+};
+
+char *ipv6_commands[] = {
+	"ip link set dev lo up",
+	"ip link add geneve0 type geneve local " APP_SRC_IPV6 " external",
+	"ip -6 addr add " APP_SRC_IPV6 "/32 dev geneve0 nodad",
+	"ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
+	"ip link set dev geneve0 up",
+	"ip -6 route add " APP_DST_IPV6 "/128 dev geneve0",
+	/* Similarly, APP_DST_IPV6 needs a static neighbour entry */
+	"ip -6 neigh add " APP_DST_IPV6 " lladdr ab:bc:cd:de:ef:fa dev geneve0",
+};
+
+static int setup_netns(struct proxy_hwtstamp_test_case *test_case)
+{
+	int i, array_size, ret;
+	char **commands;
+
+	if (test_case->family == AF_INET) {
+		commands = ipv4_commands;
+		array_size = ARRAY_SIZE(ipv4_commands);
+	} else {
+		commands = ipv6_commands;
+		array_size = ARRAY_SIZE(ipv6_commands);
+	}
+
+	for (i = 0; i < array_size; i++) {
+		ret = system(commands[i]);
+		if (!ASSERT_OK(ret, commands[i]))
+			break;
+	}
+
+	return ret;
+}
+
+static int setup_tcx(struct proxy_hwtstamp_test_case *test_case)
+{
+	struct proxy_hwtstamp *skel = test_case->skel;
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts_ingress);
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts_egress);
+	struct bpf_link *link;
+	int ifindex;
+
+	ifindex = if_nametoindex("geneve0");
+
+	if (make_sockaddr(test_case->family, test_case->geneve_remote_ip, GENEVE_PORT,
+			  &test_case->geneve_remote_addr, &test_case->addrlen))
+		goto err;
+
+	if (make_sockaddr(test_case->family, test_case->geneve_local_ip, GENEVE_PORT,
+			  &test_case->geneve_local_addr, &test_case->addrlen))
+		goto err;
+
+	/*
+	 * Set up struct bpf_tunnel_key for GENEVE.
+	 * Note that bpf_skb_set_tunnel_key() expects
+	 *   IPv4 address in host byte order
+	 *   IPv6 address in network byte order.
+	 */
+	skel->bss->key_dst.tunnel_id = GENEVE_VNI;
+	if (test_case->family == AF_INET) {
+		struct sockaddr_in *addr4;
+
+		addr4 = (struct sockaddr_in *)&test_case->geneve_remote_addr;
+		skel->bss->key_dst.remote_ipv4 = ntohl(addr4->sin_addr.s_addr);
+
+		addr4 = (struct sockaddr_in *)&test_case->geneve_local_addr;
+		skel->bss->key_dst.local_ipv4 = ntohl(addr4->sin_addr.s_addr);
+
+		skel->bss->tunnel_tx_flags = BPF_F_ZERO_CSUM_TX;
+		skel->bss->tunnel_rx_flags = 0;
+	} else {
+		struct sockaddr_in6 *addr6;
+
+		addr6 = (struct sockaddr_in6 *)&test_case->geneve_remote_addr;
+		memcpy(&skel->bss->key_dst.remote_ipv6,
+		       &addr6->sin6_addr, sizeof(addr6->sin6_addr));
+
+		addr6 = (struct sockaddr_in6 *)&test_case->geneve_local_addr;
+		memcpy(&skel->bss->key_dst.local_ipv6,
+		       &addr6->sin6_addr, sizeof(addr6->sin6_addr));
+
+		/*
+		 * IPv6 requires BPF_F_TUNINFO_IPV6.
+		 * Since udpv6_rcv() drops 0 csum packets unlike udp_rcv()
+		 * by default, UDP_NO_CHECK6_RX must be set on the proxy socket.
+		 */
+		skel->bss->tunnel_tx_flags = BPF_F_ZERO_CSUM_TX | BPF_F_TUNINFO_IPV6;
+		skel->bss->tunnel_rx_flags = BPF_F_TUNINFO_IPV6;
+	}
+
+	/* Attach BPF progs to egress and ingress. */
+	link = bpf_program__attach_tcx(skel->progs.proxy_hwtstamp_ingress,
+				       ifindex, &tcx_opts_ingress);
+	if (!ASSERT_OK_PTR(link, "attach_tcx(ingress)"))
+		goto err;
+
+	skel->links.proxy_hwtstamp_ingress = link;
+
+	link = bpf_program__attach_tcx(skel->progs.proxy_hwtstamp_egress,
+				       ifindex, &tcx_opts_egress);
+	if (!ASSERT_OK_PTR(link, "attach_tcx(egress)"))
+		goto err;
+
+	skel->links.proxy_hwtstamp_egress = link;
+
+	return 0;
+err:
+	return -1;
+}
+
+static int setup_fd(struct proxy_hwtstamp_test_case *test_case)
+{
+	int proxy_fd, app_fd;
+	int val, ret;
+
+	proxy_fd = start_server_addr(SOCK_DGRAM, &test_case->geneve_remote_addr,
+				     test_case->addrlen, NULL);
+	if (!ASSERT_OK_FD(proxy_fd, "start_server"))
+		goto err;
+
+	if (test_case->family == AF_INET6) {
+		/*
+		 * udpv6_rcv() drops 0 csum (BPF_F_ZERO_CSUM_TX) packets
+		 * unless UDP_NO_CHECK6_RX is set.
+		 */
+		val = 1;
+		ret = setsockopt(proxy_fd, SOL_UDP, UDP_NO_CHECK6_RX, &val, sizeof(val));
+		if (!ASSERT_OK(ret, "setsockopt(UDP_NO_CHECK6_RX)"))
+			goto close_proxy;
+	}
+
+	app_fd = connect_to_addr_str(test_case->family, SOCK_DGRAM,
+				     test_case->app_dst_ip,
+				     test_case->app_dst_port, NULL);
+	if (!ASSERT_OK_FD(app_fd, "connect_to_addr_str"))
+		goto close_proxy;
+
+	val = SOF_TIMESTAMPING_RX_HARDWARE |
+	      SOF_TIMESTAMPING_TX_HARDWARE |
+	      SOF_TIMESTAMPING_RAW_HARDWARE |
+	      SOF_TIMESTAMPING_OPT_ID;
+	ret = setsockopt(app_fd, SOL_SOCKET, SO_TIMESTAMPING_NEW, &val, sizeof(val));
+	if (!ASSERT_OK(ret, "setsockopt(SO_TIMESTAMPING_NEW)"))
+		goto close_app;
+
+	test_case->proxy_fd = proxy_fd;
+	test_case->app_fd = app_fd;
+
+	return 0;
+
+close_app:
+	close(app_fd);
+close_proxy:
+	close(proxy_fd);
+err:
+	return -1;
+}
+
+static void destroy_env(struct proxy_hwtstamp_test_case *test_case)
+{
+	close(test_case->app_fd);
+	close(test_case->proxy_fd);
+	proxy_hwtstamp__destroy(test_case->skel);
+	netns_free(test_case->netns);
+}
+
+static int setup_env(struct proxy_hwtstamp_test_case *test_case)
+{
+	test_case->netns = netns_new("proxy_hwtstamp", true);
+	if (!ASSERT_OK_PTR(test_case->netns, "netns_new"))
+		goto err;
+
+	if (setup_netns(test_case))
+		goto free_netns;
+
+	test_case->skel = proxy_hwtstamp__open_and_load();
+	if (!ASSERT_OK_PTR(test_case->skel, "open_and_load"))
+		goto free_netns;
+
+	if (setup_tcx(test_case))
+		goto destroy_skel;
+
+	if (setup_fd(test_case))
+		goto destroy_skel;
+
+	return 0;
+
+destroy_skel:
+	proxy_hwtstamp__destroy(test_case->skel);
+free_netns:
+	netns_free(test_case->netns);
+err:
+	return -1;
+}
+
+static int wait_data(struct proxy_hwtstamp_test_case *test_case, bool tx)
+{
+	struct epoll_event event = {
+		.events = tx ? EPOLLERR : EPOLLIN,
+		.data.fd = test_case->app_fd,
+	};
+	int epoll_fd;
+	int ret = -1;
+
+	epoll_fd = epoll_create1(0);
+	if (!ASSERT_GE(epoll_fd, 0, "epoll_create1"))
+		goto out;
+
+	ret = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, test_case->app_fd, &event);
+	if (!ASSERT_OK(ret, "epoll_ctl"))
+		goto close_epoll;
+
+	ret = epoll_wait(epoll_fd, &event, 1, 3000);
+	if (ASSERT_EQ(ret, 1, "epoll_wait"))
+		ret = 0;
+	else
+		ret = -1;
+
+close_epoll:
+	close(epoll_fd);
+out:
+	return ret;
+}
+
+static int check_tstamp(struct proxy_hwtstamp_test_case *test_case, bool tx)
+{
+	char buf_msg[APP_PAYLOAD_LEN * 2], buf_cmsg[1024];
+	bool saw_tstamp = false, saw_tskey = false;
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int ret;
+
+	if (wait_data(test_case, tx))
+		return -1;
+
+	iov.iov_base = buf_msg;
+	iov.iov_len = sizeof(buf_msg);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buf_cmsg;
+	msg.msg_controllen = sizeof(buf_cmsg);
+
+	ret = recvmsg(test_case->app_fd, &msg, tx ? MSG_ERRQUEUE : 0);
+
+	if (ret > 0)
+		hexdump(tx ? "tx tstamp  " : "rx tstamp  ", buf_msg, ret);
+
+	if (!ASSERT_EQ(ret, APP_PAYLOAD_LEN, "recvmsg"))
+		return -1;
+
+	ret = memcmp(buf_msg, test_case->app_payload, sizeof(test_case->app_payload));
+	ASSERT_OK(ret, "memcmp");
+
+	ret = -1;
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SO_TIMESTAMPING_NEW) {
+			struct scm_timestamping64 *ts;
+
+			ts = (struct scm_timestamping64 *)CMSG_DATA(cmsg);
+			ASSERT_EQ(ts->ts[2].tv_sec, 0, "tv_sec");
+			ASSERT_EQ(ts->ts[2].tv_nsec, HWTSTAMP, "tv_nsec");
+
+			saw_tstamp = true;
+		} else if ((cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_RECVERR) ||
+			   (cmsg->cmsg_level == SOL_IPV6 && cmsg->cmsg_type == IPV6_RECVERR)) {
+			struct sock_extended_err *ee;
+
+			ee = (struct sock_extended_err *)CMSG_DATA(cmsg);
+
+			if (ee->ee_origin == SO_EE_ORIGIN_TIMESTAMPING) {
+				ASSERT_EQ(ee->ee_data, TSKEY, "tskey");
+				saw_tskey = true;
+			}
+		}
+	}
+
+	ASSERT_TRUE(saw_tstamp && (!tx || saw_tskey), "no timestamp");
+
+	return ret;
+}
+
+static int test_proxy_hwtstamp_tx(struct proxy_hwtstamp_test_case *test_case)
+{
+	char h_source_dummy[ETH_HLEN] = {0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA};
+	char buf_cmsg[CMSG_SPACE(sizeof(u32))];
+	struct proxy_header *phdr;
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int ret;
+
+	memset(test_case->app_payload, 0xAB, sizeof(test_case->app_payload));
+	iov.iov_base = test_case->app_payload;
+	iov.iov_len = sizeof(test_case->app_payload);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buf_cmsg;
+	msg.msg_controllen = sizeof(buf_cmsg);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_TS_OPT_ID;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(u32));
+	*(u32 *)CMSG_DATA(cmsg) = TSKEY;
+
+	ret = sendmsg(test_case->app_fd, &msg, 0);
+	if (!ASSERT_EQ(ret, sizeof(test_case->app_payload), "send"))
+		return -1;
+
+	while (1) {
+		memset(test_case->encap_payload, 0, sizeof(test_case->encap_payload));
+
+		ret = recv(test_case->proxy_fd, test_case->encap_payload,
+			   sizeof(test_case->encap_payload), 0);
+		if (ret <= (int)sizeof(phdr->geneve)) {
+			ASSERT_GT(ret, (int)sizeof(phdr->geneve), "recv(tx ingress)");
+			return -1;
+		}
+
+		phdr = (struct proxy_header *)test_case->encap_payload;
+
+		/*
+		 * In the real world, we forward all packets,
+		 * including ARP, NDP, etc, but now we ignore them.
+		 * In this test case, we only care about skb with
+		 * the GENEVE option, meaning it was sent by app_fd.
+		 */
+		if (phdr->geneve.opt_len)
+			break;
+	}
+
+	hexdump("tx payload ", test_case->encap_payload,
+		test_case->encap_payload_len);
+
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "encap payload len"))
+		return -1;
+
+	if (!ASSERT_EQ(phdr->tskey, TSKEY, "tskey"))
+		return -1;
+
+	/*
+	 * Assume we have got TX hwtstamp now.
+	 * Reuse the original payload to "regenerate" the
+	 * same skb to put into app_fd's sk_error_queue.
+	 */
+	phdr->geneve_opt.type = GENEVE_OPT_TYPE_TX_CMPL;
+	phdr->hwtstamp = HWTSTAMP;
+
+	/*
+	 * GENEVE drops a packet if the outer/inner eth headers
+	 * have the same source address. (See geneve_rx())
+	 * Work around it by filling a fake address.
+	 */
+	swap_array(phdr->eth.h_source, h_source_dummy);
+
+	/* Send the TX completion packet to geneve0. */
+	ret = sendto(test_case->proxy_fd,
+		     test_case->encap_payload, test_case->encap_payload_len, 0,
+		     (struct sockaddr *)&test_case->geneve_local_addr, test_case->addrlen);
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "sendto(tx cmpl)"))
+		return -1;
+
+	swap_array(phdr->eth.h_source, h_source_dummy);
+
+	return check_tstamp(test_case, true);
+}
+
+static int test_proxy_hwtstamp_rx(struct proxy_hwtstamp_test_case *test_case)
+{
+	struct proxy_header *phdr;
+	int ret;
+
+	/*
+	 * Assume we have received a packet w/ RX hwtstamp.
+	 * Generate RX packet by swapping source/dest of the
+	 * original TX packet.
+	 */
+	phdr = (struct proxy_header *)test_case->encap_payload;
+
+	swap_array(phdr->eth.h_dest, phdr->eth.h_source);
+
+	if (test_case->family == AF_INET) {
+		swap(phdr->v4.ip.daddr, phdr->v4.ip.saddr);
+		swap(phdr->v4.udp.dest, phdr->v4.udp.source);
+	} else {
+		swap(phdr->v6.ip.daddr, phdr->v6.ip.saddr);
+		swap(phdr->v6.udp.dest, phdr->v6.udp.source);
+	}
+
+	/* Embed RX hwtstamp into the GENEVE option. */
+	phdr->geneve_opt.type = GENEVE_OPT_TYPE_RX;
+	phdr->hwtstamp = HWTSTAMP;
+	phdr->tskey = 0;
+
+	/* Send the packet to geneve0. */
+	ret = sendto(test_case->proxy_fd,
+		     test_case->encap_payload, test_case->encap_payload_len, 0,
+		     (struct sockaddr *)&test_case->geneve_local_addr, test_case->addrlen);
+	if (!ASSERT_EQ(ret, test_case->encap_payload_len, "sendto(rx)"))
+		return -1;
+
+	return check_tstamp(test_case, false);
+}
+
+static void run_test(struct proxy_hwtstamp_test_case *test_case)
+{
+	int ret;
+
+	ret = setup_env(test_case);
+	if (ret)
+		return;
+
+	ret = test_proxy_hwtstamp_tx(test_case);
+	if (!ret)
+		test_proxy_hwtstamp_rx(test_case);
+
+	destroy_env(test_case);
+}
+
+void test_proxy_hwtstamp(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		if (!test__start_subtest(test_cases[i].name))
+			continue;
+
+		run_test(&test_cases[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..77a88dc20a64 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -73,6 +73,7 @@
 #define ETH_P_IPV6		0x86DD
 
 #define NEXTHDR_TCP		6
+#define NEXTHDR_UDP		17
 
 #define TCPOPT_NOP		1
 #define TCPOPT_EOL		0
diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
new file mode 100644
index 000000000000..e13963f2393e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include "vmlinux.h"
+#include <errno.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+
+struct proxy_hwtstamp_opt {
+	struct geneve_opt header;
+	ktime_t hwtstamp;
+	u32 tskey;
+} __attribute__((packed));
+
+#define GENEVE_VNI		0x900913
+#define GENEVE_OPT_CLASS	0x9009
+#define GENEVE_OPT_LEN		((sizeof(struct proxy_hwtstamp_opt)	\
+				  - sizeof(struct geneve_opt)) / 4)
+enum {
+	GENEVE_OPT_TYPE_TX	= 1,
+	GENEVE_OPT_TYPE_TX_CMPL	= 2,
+	GENEVE_OPT_TYPE_RX	= 3,
+};
+
+struct bpf_tunnel_key key_dst;	/* Populated from userspace for TX encap. */
+int tunnel_tx_flags;
+int tunnel_rx_flags;
+
+SEC("tcx/egress")
+int proxy_hwtstamp_egress(struct __sk_buff *skb)
+{
+	struct skb_shared_info *shared_info;
+	struct proxy_hwtstamp_opt opt = {};
+	struct sk_buff *kskb;
+	int ret;
+
+	/* Outgoing packet will be |ETH|IP|UDP|GENEVE|ETH|IP|UDP|Payload| */
+	ret = bpf_skb_set_tunnel_key(skb, &key_dst, sizeof(key_dst), tunnel_tx_flags);
+	if (ret < 0)
+		goto drop;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	shared_info = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+	if (!shared_info->tx_flags) {
+		/*
+		 * If TX tstamp is not needed, don't insert the GENEVE option.
+		 * The proxy socket will see genevehdr.opt_len == 0.
+		 */
+		goto pass;
+	}
+
+	opt.header.opt_class = bpf_htons(GENEVE_OPT_CLASS);
+	opt.header.type = GENEVE_OPT_TYPE_TX;
+	opt.header.length = GENEVE_OPT_LEN;
+	opt.tskey = shared_info->tskey;
+
+	/* Outgoing packet will be |ETH|IP|UDP|GENEVE|GENEVE_OPT|ETH|IP|UDP|Payload| */
+	ret = bpf_skb_set_tunnel_opt(skb, &opt, sizeof(opt));
+	if (ret < 0)
+		goto drop;
+
+	bpf_skb_scrub_tx_tstamp(skb);
+pass:
+	return TCX_PASS;
+drop:
+	return TCX_DROP;
+}
+
+static int proxy_hwtstamp_sk_assign(struct __sk_buff *skb,
+				    struct bpf_tx_tstamp_cmpl *attrs)
+{
+	struct bpf_sock_tuple tuple;
+	void *data_end, *data_l4;
+	__be16 *dport, *sport;
+	struct bpf_sock *skc;
+	struct ethhdr *eth;
+	int protocol_l4;
+	int tuple_size;
+	int ret;
+
+	data_end = (void *)(long)skb->data_end;
+	eth = (struct ethhdr *)(long)skb->data;
+
+	if (eth + 1 > data_end)
+		goto drop;
+
+	attrs->protocol = eth->h_proto;
+
+	switch (bpf_ntohs(eth->h_proto)) {
+	case ETH_P_IP: {
+		struct iphdr *ipv4 = (struct iphdr *)(eth + 1);
+
+		if (ipv4 + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct iphdr);
+
+		protocol_l4 = ipv4->protocol;
+		data_l4 = ipv4 + 1;
+
+		/* Swap daddr/saddr since this skb has the original TX headers. */
+		tuple.ipv4.daddr = ipv4->saddr;
+		tuple.ipv4.saddr = ipv4->daddr;
+
+		tuple_size = sizeof(tuple.ipv4);
+		dport = &tuple.ipv4.dport;
+		sport = &tuple.ipv4.sport;
+		break;
+	}
+	case ETH_P_IPV6: {
+		struct ipv6hdr *ipv6 = (struct ipv6hdr *)(eth + 1);
+
+		if (ipv6 + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct ipv6hdr);
+
+		protocol_l4 = ipv6->nexthdr;
+		data_l4 = ipv6 + 1;
+
+		/* Swap daddr/saddr since this skb has the original TX headers. */
+		__builtin_memcpy(tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
+		__builtin_memcpy(tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
+
+		tuple_size = sizeof(tuple.ipv6);
+		dport = &tuple.ipv6.dport;
+		sport = &tuple.ipv6.sport;
+		break;
+	}
+	default:
+		goto drop;
+	}
+
+	switch (protocol_l4) {
+	case IPPROTO_UDP: {
+		struct udphdr *udp = data_l4;
+
+		if (udp + 1 > data_end)
+			goto drop;
+
+		attrs->payload_offset += sizeof(struct udphdr);
+
+		/* Swap sport/dport since this skb has the original TX headers. */
+		*dport = udp->source;
+		*sport = udp->dest;
+
+		skc = bpf_sk_lookup_udp(skb, &tuple, tuple_size, -1, 0);
+		break;
+	}
+	default:
+		goto drop;
+	}
+	if (!skc)
+		goto drop;
+
+	ret = bpf_sk_assign(skb, skc, 0);
+	bpf_sk_release(skc);
+
+	if (ret)
+		goto drop;
+
+	return 0;
+drop:
+	return TCX_DROP;
+}
+
+static int proxy_hwtstamp_tx_completion(struct __sk_buff *skb, u32 tskey)
+{
+	struct bpf_tx_tstamp_cmpl attrs = {
+		.network_offset = sizeof(struct ethhdr),
+		.payload_offset = sizeof(struct ethhdr),
+		.tskey = tskey,
+	};
+	int ret;
+
+	/* Set skb->sk to the socket of the original sender. */
+	ret = proxy_hwtstamp_sk_assign(skb, &attrs);
+	if (ret)
+		return ret;
+
+	ret = bpf_skb_complete_tx_tstamp(skb, &attrs, sizeof(attrs));
+	if (ret)
+		return TCX_DROP;
+
+	return TCX_ERRQUEUE;
+}
+
+SEC("tcx/ingress")
+int proxy_hwtstamp_ingress(struct __sk_buff *skb)
+{
+	struct proxy_hwtstamp_opt opt;
+	struct bpf_tunnel_key key;
+	int ret;
+
+	/* Get the GENEVE header. */
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), tunnel_rx_flags);
+	if (ret < 0)
+		goto drop;
+
+	if (key.tunnel_id != GENEVE_VNI)
+		goto drop;
+
+	/* Get the GENEVE option. */
+	ret = bpf_skb_get_tunnel_opt(skb, &opt, sizeof(opt));
+	if (ret < (int)sizeof(opt)) {
+		 /*
+		  * If TX/RX tstamp is not needed, the proxy socket
+		  * does not insert the GENEVE option.
+		  */
+		goto pass;
+	}
+
+	if (opt.header.opt_class != bpf_htons(GENEVE_OPT_CLASS) ||
+	    opt.header.length != GENEVE_OPT_LEN)
+		goto drop;
+
+	if (opt.header.type == GENEVE_OPT_TYPE_TX_CMPL ||
+	    opt.header.type == GENEVE_OPT_TYPE_RX) {
+		struct bpf_hwtstamp attrs = {
+			.hwtstamp = opt.hwtstamp,
+		};
+
+		bpf_skb_set_hwtstamp(skb, &attrs, sizeof(attrs));
+
+		if (opt.header.type == GENEVE_OPT_TYPE_TX_CMPL)
+			return proxy_hwtstamp_tx_completion(skb, opt.tskey);
+	}
+pass:
+	return TCX_PASS;
+drop:
+	return TCX_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0.1136.gdb2ca164c4-goog

