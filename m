Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43248A2BE;
	Mon,  7 Sep 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783037; cv=none; b=YpV6Gy6KajLO65Xa88ZOjBYGbJS8r9AuQYn5Cl7fPDuQHyp75S1+UPNaVddtPXgVJ+z8bR1Hrqz9e/Nm+BVdwJFjvEPJOLDRqSbVnY1k3QZHvBuOk3ADeEoPRJpGNagGYzVyz2DQ0dN7Wv35Cc4lvXEwLhHPpjopUroBMj+WF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783037; c=relaxed/simple;
	bh=nAxmZCL3tUuhYr0zrIPyunIDDwj7KwLoFZThiSwUEXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qskbrzq7Ye6LyeMGnjsIqdTP17aT/ldinwt/bNfNw3OB0WJpl3ppPS71p4CW0tkheJHD5oUK8O6ezHNahed3JKt0MhZnLzFNPr2sc48lAPaUpiwxpUa22oBYYay8jCdbSLVclZPfuTnXs6YVKAdX2uLawq5MGP4Pwkw1WM3Jims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cw6sLAvD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cw6sLAvD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DgvJkmevIQCHNVgAHC15KSH8YO6ZgVj1PClNZKxN8PM=; b=cw6sLAvD1JQMpyzwzFemebt+HD
	GpurTvWb+v/VzVEYgh8EbffrlnZ5k4NBKkkDv2E9GBTdxhWV8dGFCEgntnc47OE/JwRte5Hzlv8u1
	wUnK/JSul4WcLc++/AZuA+xz8wdf/fFYweQx0a57aVB+3Egtrjym80OkilUZxzbCoAqSKmbNvOUJn
	ElBFYnnWhQOE26ep/MUxFzpmSSDmZ+RS2soAxVy1yq8N5yUgyxyOB2w1Zp6ADxze/rIEf3EhMl2OP
	GJP9DSJuZHVkleTwx+9uzzWlOfCdeLu2gRqqA0fx/LWYQRj3duUDREcXdWaZCAG8s6vn3Zt6dbyzy
	SJ864QeA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x3YB8-000Mp4-2U;
	Mon, 07 Sep 2026 14:10:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	yusuke.suzuki@isovalent.com,
	tom.hadlaw@isovalent.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_tail on csum partial skbs
Date: Mon,  7 Sep 2026 14:10:25 +0200
Message-ID: <20260907121025.1923656-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907121025.1923656-1-daniel@iogearbox.net>
References: <20260907121025.1923656-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)

Add a test which builds an ICMP error out of a TCP segment. A tcx prog
on the client's egress side trims the first data segment down to the
target size and pushes the ICMP error headers in front of it to then
reflect the packet back to the sender.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t tc_change_tail
  [...]
  #509     tc_change_tail:OK
  #510     tc_change_tail_pmtu:OK
  Summary: 2/0 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/prog_tests/tc_change_tail_pmtu.c      | 125 +++++++++++++++++
 .../bpf/progs/test_tc_change_tail_pmtu.c      | 129 ++++++++++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail_pmtu.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail_pmtu.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_change_tail_pmtu.c b/tools/testing/selftests/bpf/prog_tests/tc_change_tail_pmtu.c
new file mode 100644
index 000000000000..7acdbd5757a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_change_tail_pmtu.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <netinet/tcp.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "test_tc_change_tail_pmtu.skel.h"
+
+#define CLIENT_NS	"tc-change-tail-cli-ns"
+#define SERVER_NS	"tc-change-tail-srv-ns"
+#define CLIENT_IP	"192.168.1.1"
+#define SERVER_IP	"192.168.1.2"
+
+#define TEST_PMTU	1000
+#define TEST_MSS_MAX	(TEST_PMTU - 20 - 20)
+#define TIMEOUT_MS	3000
+#define XFER_BYTES	8192
+
+void test_tc_change_tail_pmtu(void)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, tcx_opts);
+	int mss_before = 0, mss_after = 0, ifindex, port;
+	int srv_fd = -1, srv_conn_fd = -1, cli_fd = -1;
+	struct test_tc_change_tail_pmtu *skel = NULL;
+	struct nstoken *nstoken = NULL;
+	static char buf[XFER_BYTES];
+	socklen_t optlen;
+	ssize_t bytes;
+	size_t total;
+
+	if (!ASSERT_OK(make_netns(CLIENT_NS), "make client ns"))
+		return;
+	if (!ASSERT_OK(make_netns(SERVER_NS), "make server ns"))
+		goto out_client_ns;
+
+	nstoken = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open client ns"))
+		goto out;
+	SYS(out, "ip link add veth1 type veth peer name veth2 netns " SERVER_NS);
+	SYS(out, "ip -4 addr add " CLIENT_IP "/24 dev veth1");
+	SYS(out, "ip link set veth1 up");
+	ifindex = if_nametoindex("veth1");
+	if (!ASSERT_NEQ(ifindex, 0, "if_nametoindex"))
+		goto out;
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	nstoken = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		goto out;
+	SYS(out, "ip -4 addr add " SERVER_IP "/24 dev veth2");
+	SYS(out, "ip link set veth2 up");
+	srv_fd = start_server(AF_INET, SOCK_STREAM, SERVER_IP, 0, TIMEOUT_MS);
+	if (!ASSERT_OK_FD(srv_fd, "start server"))
+		goto out;
+	close_netns(nstoken);
+	nstoken = NULL;
+
+	skel = test_tc_change_tail_pmtu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto out;
+
+	port = get_socket_local_port(srv_fd);
+	if (!ASSERT_GE(port, 0, "get server port"))
+		goto out;
+
+	skel->bss->server_port = port;
+	skel->bss->pmtu = TEST_PMTU;
+
+	nstoken = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open client ns"))
+		goto out;
+
+	skel->links.change_tail_icmp =
+		bpf_program__attach_tcx(skel->progs.change_tail_icmp, ifindex,
+					&tcx_opts);
+	if (!ASSERT_OK_PTR(skel->links.change_tail_icmp, "attach tcx"))
+		goto out;
+
+	cli_fd = connect_to_fd(srv_fd, TIMEOUT_MS);
+	if (!ASSERT_OK_FD(cli_fd, "connect to server"))
+		goto out;
+	srv_conn_fd = accept(srv_fd, NULL, NULL);
+	if (!ASSERT_OK_FD(srv_conn_fd, "accept connection"))
+		goto out;
+	if (!ASSERT_OK(settimeo(srv_conn_fd, TIMEOUT_MS), "set server timeout"))
+		goto out;
+
+	optlen = sizeof(mss_before);
+	if (!ASSERT_OK(getsockopt(cli_fd, IPPROTO_TCP, TCP_MAXSEG, &mss_before,
+				  &optlen), "get mss before"))
+		goto out;
+
+	bytes = send(cli_fd, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(bytes, (ssize_t)sizeof(buf), "send data"))
+		goto out;
+
+	for (total = 0; total < sizeof(buf); total += bytes) {
+		bytes = recv(srv_conn_fd, buf, sizeof(buf), 0);
+		if (bytes <= 0)
+			break;
+	}
+
+	ASSERT_EQ(total, sizeof(buf), "receive data");
+	ASSERT_OK(skel->data->change_tail_ret, "change tail");
+	ASSERT_OK(skel->bss->adjust_room_ret, "adjust room");
+	ASSERT_TRUE(skel->bss->icmp_sent, "icmp sent");
+
+	optlen = sizeof(mss_after);
+	if (!ASSERT_OK(getsockopt(cli_fd, IPPROTO_TCP, TCP_MAXSEG, &mss_after,
+				  &optlen), "get mss after"))
+		goto out;
+
+	ASSERT_LT(mss_after, mss_before, "mss reduced");
+	ASSERT_LE(mss_after, TEST_MSS_MAX, "mss below pmtu");
+out:
+	close(srv_conn_fd);
+	close(cli_fd);
+	close(srv_fd);
+	test_tc_change_tail_pmtu__destroy(skel);
+	close_netns(nstoken);
+	remove_netns(SERVER_NS);
+out_client_ns:
+	remove_netns(CLIENT_NS);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail_pmtu.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail_pmtu.c
new file mode 100644
index 000000000000..5c4c07545bc9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail_pmtu.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdbool.h>
+#include <stddef.h>
+
+#include <linux/bpf.h>
+#include <linux/icmp.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ICMP_SAMPLE_LEN	(sizeof(struct iphdr) + 8)
+#define ICMP_HDRS_LEN	(sizeof(struct iphdr) + sizeof(struct icmphdr))
+
+__be16 server_port = 0;
+__u16 pmtu = 0;
+
+long change_tail_ret = 1;
+long adjust_room_ret = 0;
+bool icmp_sent = false;
+bool icmp_err = false;
+
+static __always_inline __sum16 csum_fold(__wsum csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__sum16)~csum;
+}
+
+SEC("tc/egress")
+int change_tail_icmp(struct __sk_buff *skb)
+{
+	__u8 smac[ETH_ALEN], dmac[ETH_ALEN];
+	void *data, *data_end;
+	struct icmphdr *icmp;
+	struct ethhdr *eth;
+	struct tcphdr *tcp;
+	__be32 saddr, daddr;
+	struct iphdr *ip;
+	__wsum csum;
+
+	if (icmp_sent || icmp_err)
+		return TCX_PASS;
+
+	data = (void *)(long)skb->data;
+	data_end = (void *)(long)skb->data_end;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TCX_PASS;
+	if (eth->h_proto != bpf_htons(ETH_P_IP))
+		return TCX_PASS;
+
+	ip = (void *)(eth + 1);
+	if ((void *)(ip + 1) > data_end)
+		return TCX_PASS;
+	if (ip->ihl != 5 || ip->protocol != IPPROTO_TCP)
+		return TCX_PASS;
+
+	tcp = (void *)(ip + 1);
+	if ((void *)(tcp + 1) > data_end)
+		return TCX_PASS;
+	if (tcp->dest != server_port)
+		return TCX_PASS;
+	if (bpf_ntohs(ip->tot_len) <= sizeof(*ip) + tcp->doff * 4)
+		return TCX_PASS;
+
+	__builtin_memcpy(smac, eth->h_source, ETH_ALEN);
+	__builtin_memcpy(dmac, eth->h_dest, ETH_ALEN);
+	saddr = ip->saddr;
+	daddr = ip->daddr;
+
+	change_tail_ret = bpf_skb_change_tail(skb, ETH_HLEN + ICMP_SAMPLE_LEN, 0);
+	if (change_tail_ret) {
+		icmp_err = true;
+		return TCX_PASS;
+	}
+
+	adjust_room_ret = bpf_skb_adjust_room(skb, ICMP_HDRS_LEN,
+					      BPF_ADJ_ROOM_MAC,
+					      BPF_F_ADJ_ROOM_NO_CSUM_RESET);
+	if (adjust_room_ret) {
+		icmp_err = true;
+		return TCX_DROP;
+	}
+
+	data = (void *)(long)skb->data;
+	data_end = (void *)(long)skb->data_end;
+
+	eth = data;
+	ip = (void *)(eth + 1);
+	icmp = (void *)(ip + 1);
+	if ((void *)icmp + sizeof(*icmp) + ICMP_SAMPLE_LEN > data_end) {
+		icmp_err = true;
+		return TCX_DROP;
+	}
+
+	__builtin_memcpy(eth->h_dest, smac, ETH_ALEN);
+	__builtin_memcpy(eth->h_source, dmac, ETH_ALEN);
+
+	__builtin_memset(icmp, 0, sizeof(*icmp));
+	icmp->type = ICMP_DEST_UNREACH;
+	icmp->code = ICMP_FRAG_NEEDED;
+	icmp->un.frag.mtu = bpf_htons(pmtu);
+
+	__builtin_memset(ip, 0, sizeof(*ip));
+	ip->version = 4;
+	ip->ihl = 5;
+	ip->ttl = 64;
+	ip->protocol = IPPROTO_ICMP;
+	ip->tot_len = bpf_htons(ICMP_HDRS_LEN + ICMP_SAMPLE_LEN);
+	ip->saddr = daddr;
+	ip->daddr = saddr;
+
+	csum = bpf_csum_diff(NULL, 0, (__be32 *)icmp,
+			     sizeof(*icmp) + ICMP_SAMPLE_LEN, 0);
+	icmp->checksum = csum_fold(csum);
+	csum = bpf_csum_diff(NULL, 0, (__be32 *)ip, sizeof(*ip), 0);
+	ip->check = csum_fold(csum);
+	icmp_sent = true;
+	return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

