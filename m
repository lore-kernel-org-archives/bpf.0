Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533187;
	b=q4ZuZbQMf0bWTrlQk9oIDwu7Vv2K05S4yVvz57kymEKiNrO/m+ONfRx3GKx+vaTxKEzV
	 zSp9J0gR0POzRC+ONSkXWe1fl2u+lp5eQPH3jhU8GTEvIY8AvYSIq4rZg8DJakhZgVWo4
	 Z8fJ92EDJE3Kt0vDW8hDaTZQF8U6btsUOnGnW20v7REzQ77dusIVUt6j5FBAlHpI13zMk
	 2uZbBsbkWfmk4q7bCk3xRgVAexCdm2rKOd3Rl4nmw0XlEVxMb9/XZj59FRgqMYK1DOEi2
	 oWEv8W83q95LZP3xBu1AgvG69/a5tSYEjeTXNIET7X1GkNJVFzPilzLFUmwdvc9x2Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oSIagrRM61aKNDSM8lSa+5lNFq6nePeRvO38ASVlUbo=;
	b=ZENYyixcnp6eMK6GlSS1hWYTu+E8TGLRZoaixRbs9+iFDVxwtxesmRu1im5UMnnkytU7
	 OkskZStKlof2HVKwECuMTFnfQJVMUWKePZv3xoccbHRVjCSZJPw/5D+cBdWmMXD/88BrI
	 Us5ZeX51990UZd31+TlXo25XH+xUVeTw30Dekp4BENNkpaePrZGqEzZHLs9JIvmGN20LJ
	 dUdiareG/Dbfah0xK2DtG2jCWoYyUOfuW6HHulMrCGvxIrCiCfeSGk3iI4Cc0AUgyQZIO
	 oSv8GTGnxGe+pNsk9+QJgiBcKkJ6UpBOO2zwyW41BhydfkcJa7RcRPJyLa0VgHQm4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=luFFhWBn;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD6606A691
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88DD6606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=luFFhWBn
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491846221ffso3960243f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795533185; x=1796137985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSIagrRM61aKNDSM8lSa+5lNFq6nePeRvO38ASVlUbo=;
        b=luFFhWBnvJasuPduGXDLmcyKDdLH9NnCPVQ9aQyfP2EnOlw3gn545repZ/+MzWDiY2
         T4iHI7kqLCdfRhSISFfIFeaiquVZlZQuXA38S3kHeIYxdNwM+SJ07xcXyyNVHiZpaajF
         wMK8D6UcNgSGLCNA1s5vADQif883i1buZt/PM6pdSsBY9g8Zh+rh6FAzcyD53e4vpx48
         Yi8PEo7LCqqHcnPveb5TjQsOjVxykDJa5PHpyWR041h809n9mobzfyt1+KVbJE6EnsG0
         Hlw5tagWS3zDIXCLfn693UCABVzx/yI62mN7imPk1twMeGIosXKfPsxY2xInYY2i+L3R
         Rzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533185; x=1796137985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSIagrRM61aKNDSM8lSa+5lNFq6nePeRvO38ASVlUbo=;
        b=zdnNmRxb0E49Vfc/kGQpG0udGDkyRFggpS/e70LQ1Yx3eY45Nc6vdUgaHkcxTP0hV8
         ziw0/RQXD7tK/SQhIMLUfxQHpUb4vsfAgBd8MkFBvn13fpgOHUn8c/rkjypbuRzDKY4a
         OBw7lMbIhM0o21TzuxnlLCOM3z4Y3QbvqQwuPT02By0IfiuT7irpMjKvF2I495G7EY3f
         LxvqqssuYSEN0futpEB18E15B7kIo3eJypYxNHVE0EVitMfSQ2DnLXaRS1pC66lL81++
         s6MqNUR7KdcAUWxph4P21llLaC/RePwhs0D2f5u3YPL3VhbocQjjIW90ALJnxk4Anm6Z
         4gAA==
X-Gm-Message-State: APuU4Z/dzI7XMopC3V2aU7jBtahXr/2On19ns2NWOKCU5VxWduQIvFnd
	bW8/gwXTvMqmHXo5/haLGPnQkAgpjkIWEAJSBvufEvsjDJEUSQBKY7URGa4jwP49tYdwOYOYQro
	PdPjULCApSg==
X-Gm-Gg: AZFdTZfBZD5GDktkUXdueCbrE7Ag/YADW47/PogtRwgmvWco4VARdKkb/uFamsqILZ4
	3jfeZmkqb0JNAg3Q/yhD6josceWD0CCoQXyJL5q/RwKsNvwM8hFxGAK7TXHDOfDvajtOM/Ivw7I
	W6Wgtp5ql/CUHLKNSx9WibWNLN2D1auA2q9/XC2cOLfDbhrSGO+I2i/6oAZ8bAYAmH8uIeHedb6
	RERZNVkbnA1Npf89EpOS8/+YKvBpFNc7uRq5OIvYe0m4NUy6pdiCRhPyZ5yrYV4Ve9nrUr27YI3
	/06OMXckv9BeGbl72hMCU98Hw6OlaOKD1/Oz0dM/O3n2UKYUOiOBN706xupnEVmNadQS4kC6Uid
	BCgW2OvzpIqKTgivm1jmw1Oa0k+d0pNOMT5FZVJ6Gqq7O/Blc/jdhWc0WI5Gp/DCIPWFBIuz9AQ
	iRcSnnjMQiRKgZIeJ6rx8Sd6jtUZ+aROU3wW9tRTd+zSfZsMQ4/Wbo9/joiDMc9E0jSgl805RF3
	l6urLIdLXPjPqZPujIUmmd5e8WRDSCb+MN/+JXdUhu53QxgnEpgQEaa/VJ3Ob46bZpA/dASmqMK
	0XyadbDd3DEvCZM3TbyLBatkdva3CTQq8+ivg9aU9PQFBwGLJfI=
X-Received: by 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4bb88820436mr309578445e9.35.1795533184836;
        Tue, 24 Nov 2026 07:13:04 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906640a2sm229067635e9.0.2026.11.24.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:13:03 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: test netkit socket assignment to a transparent proxy
Date: Tue, 24 Nov 2026 17:12:44 +0200
Message-ID: <20261124151244.1423343-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124151244.1423343-1-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach a netkit peer program that assigns TCP SYNs and UDP datagrams for
a non-local service address to a transparent host socket on another
port. Check for IPv4 and IPv6 that the datagram reaches the proxy socket
and that the connection is accepted with the original destination. Only
the SYN is assigned, the rest of a TCP connection uses the normal
lookup, so no TCP data is exchanged.

Clone each assigned packet to the host netkit device while the netkit
program is still running. A tcx egress program on that device tries to
assign the proxy socket to the clone and checks for -EOPNOTSUPP. The
clone has no socket, so if the netkit gate accepted any skb while the
netkit program runs, the helper would return 0. Skip the subtests when
the kernel does not provide netkit.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../bpf/prog_tests/sk_assign_netkit.c         | 189 ++++++++++++++++++
 .../selftests/bpf/progs/sk_assign_netkit.c    |  95 +++++++++
 2 files changed, 284 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_assign_netkit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
new file mode 100644
index 000000000000..59dc204318ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign_netkit.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <uapi/linux/if_link.h>
+#include <net/if.h>
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "netlink_helpers.h"
+#include "sk_assign_netkit.skel.h"
+
+#define NS_HOST "sk_assign_host"
+#define NS_POD "sk_assign_pod"
+#define HOST_DEV "nk_host"
+#define POD_DEV "nk0"
+#define SERVICE_ADDR4 "198.18.0.99"
+#define SERVICE_ADDR6 "2001:db8:99::99"
+#define SERVICE_PORT 18080
+#define PROXY_PORT 15001
+#define TEST_DATA "test"
+#define IO_TIMEOUT_MS 1000
+
+struct iplink_req {
+	struct nlmsghdr n;
+	struct ifinfomsg i;
+	char buf[512];
+};
+
+static int transparent_socket(int fd, void *opts)
+{
+	int one = 1;
+
+	return setsockopt(fd, SOL_IP, IP_TRANSPARENT, &one, sizeof(one));
+}
+
+static int create_netkit(void)
+{
+	struct rtnl_handle rth = { .fd = -1 };
+	struct rtattr *linkinfo, *data;
+	struct iplink_req req = {};
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (err)
+		return err;
+
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+	addattrstrz(&req.n, sizeof(req), IFLA_IFNAME, HOST_DEV);
+	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
+	addattrstrz(&req.n, sizeof(req), IFLA_INFO_KIND, "netkit");
+	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, NETKIT_L2);
+	addattr_nest_end(&req.n, data);
+	addattr_nest_end(&req.n, linkinfo);
+
+	errno = 0;
+	err = rtnl_talk(&rth, &req.n, NULL);
+	if (err && errno)
+		err = -errno;
+	rtnl_close(&rth);
+	return err;
+}
+
+static bool setup_netkit(int family, const char *dest)
+{
+	const char *host = family == AF_INET ? "10.88.0.1" : "fd88::1";
+	const char *pod = family == AF_INET ? "10.88.0.2" : "fd88::2";
+	const char *dad = family == AF_INET6 ? "nodad" : "";
+	int prefix = family == AF_INET ? 24 : 64;
+
+	SYS(fail, "ip link set %s netns %s", POD_DEV, NS_POD);
+	SYS(fail, "ip link set %s up", HOST_DEV);
+	SYS(fail, "ip -n %s link set %s up", NS_POD, POD_DEV);
+	SYS(fail, "ip addr add %s/%d dev %s %s", host, prefix, HOST_DEV, dad);
+	SYS(fail, "ip -n %s addr add %s/%d dev %s %s", NS_POD, pod, prefix,
+	    POD_DEV, dad);
+	SYS(fail, "ip -n %s route add default via %s", NS_POD, host);
+	SYS(fail, "ip route add local %s dev lo", dest);
+	return true;
+fail:
+	return false;
+}
+
+static void run_netkit(int family, int type)
+{
+	static const struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_MS,
+		.post_socket_cb = transparent_socket,
+	};
+	const char *dest = family == AF_INET ? SERVICE_ADDR4 : SERVICE_ADDR6;
+	int server = -1, client = -1, accepted = -1;
+	struct netns_obj *host = NULL, *pod = NULL;
+	struct sk_assign_netkit *skel = NULL;
+	struct sockaddr_storage expected;
+	unsigned int ifindex;
+	struct nstoken *tok;
+	socklen_t len;
+	int err;
+
+	host = netns_new(NS_HOST, true);
+	if (!ASSERT_OK_PTR(host, "host_netns"))
+		return;
+	pod = netns_new(NS_POD, false);
+	if (!ASSERT_OK_PTR(pod, "pod_netns"))
+		goto cleanup;
+	err = create_netkit();
+	if (err == -EOPNOTSUPP || err == -ENODEV) {
+		printf("%s:SKIP: CONFIG_NETKIT is unavailable\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "create_netkit") || !setup_netkit(family, dest))
+		goto cleanup;
+
+	server = start_server_str(family, type, NULL, PROXY_PORT, &opts);
+	if (!ASSERT_OK_FD(server, "start_server"))
+		goto cleanup;
+	skel = sk_assign_netkit__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	skel->rodata->service_port = SERVICE_PORT;
+	skel->rodata->proxy_port = PROXY_PORT;
+	if (!ASSERT_OK(sk_assign_netkit__load(skel), "skel_load"))
+		goto cleanup;
+	ifindex = if_nametoindex(HOST_DEV);
+	skel->links.assign_proxy = bpf_program__attach_netkit(
+		skel->progs.assign_proxy, ifindex, NULL);
+	if (!ASSERT_OK_PTR(skel->links.assign_proxy, "attach_netkit"))
+		goto cleanup;
+	skel->links.egress_assign = bpf_program__attach_tcx(
+		skel->progs.egress_assign, ifindex, NULL);
+	if (!ASSERT_OK_PTR(skel->links.egress_assign, "attach_tcx_egress"))
+		goto cleanup;
+	if (!ASSERT_OK(make_sockaddr(family, dest, SERVICE_PORT, &expected,
+				     &len), "make_sockaddr"))
+		goto cleanup;
+
+	tok = open_netns(NS_POD);
+	if (!ASSERT_OK_PTR(tok, "open_pod"))
+		goto cleanup;
+	client = connect_to_addr(type, &expected, len, NULL);
+	close_netns(tok);
+	if (!ASSERT_OK_FD(client, "connect_client"))
+		goto cleanup;
+	if (type == SOCK_DGRAM) {
+		char buf[sizeof(TEST_DATA) - 1];
+
+		if (!ASSERT_EQ(send(client, TEST_DATA, sizeof(buf), 0),
+			       sizeof(buf), "send_client") ||
+		    !ASSERT_EQ(recv(server, buf, sizeof(buf), 0),
+			       sizeof(buf), "recv_server") ||
+		    !ASSERT_MEMEQ(buf, TEST_DATA, sizeof(buf), "proxy_payload"))
+			goto cleanup;
+	} else {
+		socklen_t actual_len = sizeof(struct sockaddr_storage);
+		struct sockaddr_storage actual = {};
+
+		accepted = accept(server, NULL, NULL);
+		if (!ASSERT_OK_FD(accepted, "accept") ||
+		    !ASSERT_OK(getsockname(accepted, (void *)&actual,
+					   &actual_len), "getsockname") ||
+		    !ASSERT_EQ(actual_len, len, "original_address_len") ||
+		    !ASSERT_MEMEQ(&actual, &expected, len, "original_dst"))
+			goto cleanup;
+	}
+	ASSERT_OK(skel->bss->proxy_err, "assign_and_clone");
+	ASSERT_EQ(skel->data->egress_ret, -EOPNOTSUPP, "egress_rejected");
+cleanup:
+	sk_assign_netkit__destroy(skel);
+	if (accepted >= 0)
+		close(accepted);
+	if (client >= 0)
+		close(client);
+	if (server >= 0)
+		close(server);
+	netns_free(pod);
+	netns_free(host);
+}
+
+void test_sk_assign_netkit(void)
+{
+	if (test__start_subtest("tcpv4"))
+		run_netkit(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("tcpv6"))
+		run_netkit(AF_INET6, SOCK_STREAM);
+	if (test__start_subtest("udpv4"))
+		run_netkit(AF_INET, SOCK_DGRAM);
+	if (test__start_subtest("udpv6"))
+		run_netkit(AF_INET6, SOCK_DGRAM);
+}
diff --git a/tools/testing/selftests/bpf/progs/sk_assign_netkit.c b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
new file mode 100644
index 000000000000..1837486de4b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sk_assign_netkit.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <asm-generic/errno-base.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
+
+#define SKIP_PACKET 1
+
+const volatile __u16 service_port;
+const volatile __u16 proxy_port;
+int proxy_err;
+int egress_ret = SKIP_PACKET;
+
+static __always_inline int assign_proxy_sock(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *sk;
+	__u8 proto;
+	__u32 len;
+	void *l4;
+	int ret;
+
+	if (skb->protocol == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = data + ETH_HLEN;
+
+		if (iph + 1 > data_end || iph->ihl != 5)
+			return SKIP_PACKET;
+		proto = iph->protocol;
+		l4 = iph + 1;
+		tuple.ipv4.dport = bpf_htons(proxy_port);
+		len = sizeof(tuple.ipv4);
+	} else if (skb->protocol == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6h = data + ETH_HLEN;
+
+		if (ip6h + 1 > data_end)
+			return SKIP_PACKET;
+		proto = ip6h->nexthdr;
+		l4 = ip6h + 1;
+		tuple.ipv6.dport = bpf_htons(proxy_port);
+		len = sizeof(tuple.ipv6);
+	} else {
+		return SKIP_PACKET;
+	}
+	if (proto == IPPROTO_TCP) {
+		struct tcphdr *th = l4;
+
+		if (th + 1 > data_end || th->dest != bpf_htons(service_port) ||
+		    !th->syn || th->ack)
+			return SKIP_PACKET;
+		sk = bpf_sk_lookup_tcp(skb, &tuple, len, BPF_F_CURRENT_NETNS, 0);
+	} else if (proto == IPPROTO_UDP) {
+		struct udphdr *uh = l4;
+
+		if (uh + 1 > data_end || uh->dest != bpf_htons(service_port))
+			return SKIP_PACKET;
+		sk = bpf_sk_lookup_udp(skb, &tuple, len, BPF_F_CURRENT_NETNS, 0);
+	} else {
+		return SKIP_PACKET;
+	}
+	if (!sk)
+		return -ENOENT;
+	ret = bpf_sk_assign(skb, sk, 0);
+	bpf_sk_release(sk);
+	return ret;
+}
+
+SEC("netkit/peer")
+int assign_proxy(struct __sk_buff *skb)
+{
+	int ret;
+
+	ret = assign_proxy_sock(skb);
+	if (ret == SKIP_PACKET)
+		return NETKIT_PASS;
+	if (!ret)
+		ret = bpf_clone_redirect(skb, skb->ifindex, 0);
+	if (ret) {
+		proxy_err = ret;
+		return NETKIT_DROP;
+	}
+	return NETKIT_PASS;
+}
+
+SEC("tcx/egress")
+int egress_assign(struct __sk_buff *skb)
+{
+	if (egress_ret == SKIP_PACKET)
+		egress_ret = assign_proxy_sock(skb);
+	return TCX_PASS;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.47.3

