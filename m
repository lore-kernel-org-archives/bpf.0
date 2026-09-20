Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C446D548
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922009; cv=none; b=O2RbQjMxkKLV29/Zni0uUJemNiWsXN0INYdaKzoTkZR5orFdxKwqTXno9+qSdoIaw/yeHLb54qdIov7Ck1y0z48DWe3UKroyP+D60cH4oKzbCbZdQMbt8C3K58wJjW5b1+x/pEdECwcG6ip+ZcaodtpT8I3K0nUxbspfKiY6JAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922009; c=relaxed/simple;
	bh=M6eq7518NcqGSls1Q2O5LYBYseZpRAZf6EGOdd7HnfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCpaUJv5078Ccl2r+FVbV1DYF4u827tBbLc/HnrLZQPzv+b0whotlDIODLJytNbLPrdqiYPOYU5l9U4ysm3KD+F06siSSdEiUQINB3o3Aqj56UFg9+hkej3Jca+Q4+muBU2BJXXEerpVYpgzbv6BW5ZpBWuGYk6NYax2bGJae40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4VK5fpl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4VK5fpl"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0135fso21503475ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789922003; x=1790526803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MGj7x4NYijNiXI1Yu7fch5YTGUoaVlAca3kPtJVJv4=;
        b=A4VK5fpljIkREq65ZNv6coL7o7F3QgolNvH7tGDFQ7Ty4ghfuOAJl97+Q3emj1LI5+
         iC39b/AbKF0bJOvIwOPvu6kOgtLtR8aluIbYBRRJFddhGPzCa1fw2fUDIyQst9pntn4k
         F+Nyq626xgJMSa2jFarI7SNBBawAQBS6GAq1jPBS6RHsxucA90e5qgGVncw+a6xFXqKJ
         L5MVKSKzJxzDkzAQM0tVLtX22vV3HZjRI8POq/t5K+NL3eHhx4bDBefKhR0Tde0CYRPC
         Fb5mrI4fHyBlVqSqj9KgRgTGA19e9+Qf1bCJjOW4fUC4FofBzF+tVMe5dq9nL6z4pvHh
         m/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789922003; x=1790526803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MGj7x4NYijNiXI1Yu7fch5YTGUoaVlAca3kPtJVJv4=;
        b=B9vLxTRt/WnFPbuNAQ3Umz6tyzt+lRTQP+tvt9JzfusxAD5DjyMFiC9dvkH2mBz4+J
         KBF+UEZCf19/L/QOWOGlw44SBTiQdAtP63eqIIqQT1d+pf80Mq0HFS+dA0Yv0g+UjG+y
         SaLIFfKqzs3TPpThGDBQE6inkZ+zztb6v3Z8CyuV/9kVWJfIDErlF8MdhETAiwiQ8s7+
         ToxYWkRauthQvFhg+1GPujn6MSCkTM7oEPwJptPfVJgG5zSIagt1BWWNURvbYjHfr7Er
         +QzwNCQj+RfFDKmKjckI4o9xAVYdxA1UnPB6gwlGFaFVZlu5cuJroUBU3uiq4oop/1pn
         O0/w==
X-Forwarded-Encrypted: i=1; AKwUvBwkubTty2EKjVoW5x+3MJALQ5pEJZTHJhKoJjtIhkzJR3R47YU/qVoYK5vaDPU94qLMwUA=@vger.kernel.org
X-Gm-Message-State: AFuF++nc266mYgJ59CVWSYz6aA32JbLDTUWjhKAq2yd6Ow+bgI1Rr0dx
	NlDkqvCXaGSs723518goEYNfaEUlGevhQMB4+P2ARVR5FCEQbNzIqec5
X-Gm-Gg: AYBFou0C+vTN412WkfM2k6naz3cDCLQHR48w5LVbgDq+c7OfHPP2ZQHHvFkyyd7TJMk
	ImAwWHX9WPTKi1ejq6uXZL52abhe0l+x4A7cW1gJIOgCNwHMPWoPbagFVbGSr+EpZH9k+4sgGoV
	c6JZFc1rPnoBXCrhMtB44wSpDmwd0d/AnMRtZRUNk8d9gBsPjzbm/bj92/s4nlbtlRulO2Uj1Ky
	4ZUiH5nK9umfidXjhB10YhrNec7p1lAtS64PgXdpce04kEO0yJptul6zJC1bsdeNIhMbs6U/WF/
	0NaHkldg4HFftLLaQLnOyLX1qVrRF19qsLIF6tPmf/i43kwROt6LZvw+MpF4D7KEiF7dPPV0uuf
	Jjg7W3MI4ijh5B63s/5wlTeXRyS7BV1Gml67Koq24ZnalNTmxOWNafk4R5C8LOuh2TmGQAJJGHx
	6ujSLUl1kErZPm65CVYXiwkpQ7kV7N/sjzcvWdCtUjgOoEOoiLZAUS5OWGJKRRO+To+dTx/N1vk
	bUNKU+mMSe1iWDSKhhG2/zwUL8lCPzFC1RewHSU9w4=
X-Received: by 2002:a17:903:2312:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ddb1b899famr139374895ad.14.1789922002512;
        Sun, 20 Sep 2026 09:33:22 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm21784355ad.70.2026.09.20.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:33:21 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3 3/3] selftests/bpf: cover stale CB after LWT IP encapsulation
Date: Mon, 21 Sep 2026 00:32:11 +0800
Message-ID: <20260920163211.795547-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920163211.795547-1-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression coverage for stale protocol control-block contents after
bpf_lwt_push_ip_encap(). Inject an IPv4 packet carrying a Record Route
option through an ingress LWT program and verify that the resulting ICMP
Time Exceeded packet has no options copied from the inner header.

Exercise both direct ctx->cb[] access and access introduced by a freplace
program. The latter also verifies that cb_access is propagated to the
target so the replacement observes cleared BPF scratch space.

Run both variants on VRF ingress as well, checking that ICMP source
selection still uses the original ingress slave rather than the VRF
master after the protocol control block is reset.

Add an ingress TC pre-encapsulation case which enters LWT with
skb->encapsulation already set and a compiled outer Record Route option.
This covers the true-to-true transition that an encapsulation-bit edge
check misses.

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 288 ++++++++++++++++++
 .../bpf/progs/lwt_ip_encap_stale_cb.c         | 100 ++++++
 .../progs/lwt_ip_encap_stale_cb_freplace.c    |  32 ++
 3 files changed, 420 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb_freplace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index 39e8a3b8b6afb..0cc36b4d75b83 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -1,8 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <linux/icmp.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
 #include <netinet/in.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
 
 #include "network_helpers.h"
 #include "test_progs.h"
+#include "lwt_ip_encap_stale_cb.skel.h"
+#include "lwt_ip_encap_stale_cb_freplace.skel.h"
 #include "test_lwt_ip_encap.skel.h"
 
 #define BPF_FILE "test_lwt_ip_encap.bpf.o"
@@ -686,3 +695,282 @@ void test_lwt_ip_encap_vxlan_ipv6(void)
 {
 	lwt_ip_encap_vxlan(IPV6_ENCAP);
 }
+
+#define STALE_CB_NETNS "lwt-ip-encap-stale-cb"
+#define STALE_CB_DST "10.9.9.0/24"
+#define STALE_CB_PIN_FMT "/sys/fs/bpf/lwt_ip_encap_stale_cb_%d"
+#define STALE_CB_PKT_LEN 64
+
+static __u16 stale_cb_csum(const void *data, size_t len)
+{
+	const __u16 *word = data;
+	__u32 sum = 0;
+
+	while (len > 1) {
+		sum += *word++;
+		len -= sizeof(*word);
+	}
+	if (len)
+		sum += *(const __u8 *)word;
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	return ~sum;
+}
+
+static int stale_cb_get_mac(const char *ifname, __u8 mac[ETH_ALEN])
+{
+	struct ifreq ifr = {};
+	int fd;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name) - 1);
+	if (ioctl(fd, SIOCGIFHWADDR, &ifr)) {
+		int err = -errno;
+
+		close(fd);
+		return err;
+	}
+	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
+	close(fd);
+	return 0;
+}
+
+static int stale_cb_open_packet_socket(int ifindex)
+{
+	struct sockaddr_ll addr = {
+		.sll_family = AF_PACKET,
+		.sll_protocol = htons(ETH_P_ALL),
+		.sll_ifindex = ifindex,
+	};
+	struct timeval timeout = { .tv_sec = 2 };
+	int fd;
+
+	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (fd < 0)
+		return -errno;
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) ||
+	    setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout))) {
+		int err = -errno;
+
+		close(fd);
+		return err;
+	}
+
+	return fd;
+}
+
+static int stale_cb_send_packet(int fd, const __u8 src_mac[ETH_ALEN],
+				const __u8 dst_mac[ETH_ALEN])
+{
+	__u8 frame[ETH_HLEN + STALE_CB_PKT_LEN] = {};
+	struct ethhdr *eth = (struct ethhdr *)frame;
+	struct iphdr *iph = (struct iphdr *)(frame + ETH_HLEN);
+	__u8 *opt = (__u8 *)(iph + 1);
+
+	memcpy(eth->h_source, src_mac, ETH_ALEN);
+	memcpy(eth->h_dest, dst_mac, ETH_ALEN);
+	eth->h_proto = htons(ETH_P_IP);
+
+	iph->version = 4;
+	iph->ihl = 7;
+	iph->tos = 8;
+	iph->tot_len = htons(STALE_CB_PKT_LEN);
+	iph->id = htons(0x1234);
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = inet_addr("10.0.0.2");
+	iph->daddr = inet_addr("10.9.9.9");
+	opt[0] = IPOPT_RR;
+	opt[1] = 8;
+	opt[2] = 4;
+	iph->check = stale_cb_csum(iph, iph->ihl * 4);
+
+	memset(frame + ETH_HLEN + iph->ihl * 4, 0x41,
+	       STALE_CB_PKT_LEN - iph->ihl * 4);
+	if (send(fd, frame, sizeof(frame), 0) != sizeof(frame))
+		return -errno;
+
+	return 0;
+}
+
+static int stale_cb_icmp_ihl(int fd, __u32 *saddr)
+{
+	__u8 packet[512];
+	ssize_t len;
+
+	while ((len = recv(fd, packet, sizeof(packet), 0)) >= 0) {
+		const struct ethhdr *eth = (const struct ethhdr *)packet;
+		const struct iphdr *iph;
+		const struct icmphdr *icmph;
+		size_t ip_len;
+
+		if (len < ETH_HLEN + sizeof(*iph) ||
+		    eth->h_proto != htons(ETH_P_IP))
+			continue;
+		iph = (const struct iphdr *)(packet + ETH_HLEN);
+		ip_len = iph->ihl * 4;
+		if (iph->ihl < 5 || len < ETH_HLEN + ip_len + sizeof(*icmph) ||
+		    iph->protocol != IPPROTO_ICMP)
+			continue;
+		icmph = (const struct icmphdr *)((const __u8 *)iph + ip_len);
+		if (icmph->type == ICMP_TIME_EXCEEDED) {
+			*saddr = iph->saddr;
+			return iph->ihl;
+		}
+	}
+
+	return -errno;
+}
+
+static void lwt_ip_encap_stale_cb(bool use_freplace, bool use_vrf,
+				  bool pre_encap)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .attach_point = BPF_TC_INGRESS,
+		   );
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts,
+		    .handle = 1,
+		    .priority = 1,
+		   );
+	struct lwt_ip_encap_stale_cb_freplace *freplace_skel = NULL;
+	struct lwt_ip_encap_stale_cb *skel = NULL;
+	struct bpf_program *target, *replacement;
+	struct bpf_link *freplace_link = NULL;
+	struct netns_obj *netns = NULL;
+	char pin_path[128];
+	__u8 mac0[ETH_ALEN], mac1[ETH_ALEN];
+	__u32 saddr = 0;
+	bool tc_hook_created = false;
+	int ifindex, packet_fd = -1, prog_fd, err, ihl;
+
+	skel = lwt_ip_encap_stale_cb__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load target"))
+		goto out;
+	target = use_freplace ? skel->progs.lwt_in_freplace_target :
+				  skel->progs.lwt_in_direct;
+	prog_fd = bpf_program__fd(target);
+
+	if (use_freplace) {
+		freplace_skel = lwt_ip_encap_stale_cb_freplace__open();
+		if (!ASSERT_OK_PTR(freplace_skel, "open freplace"))
+			goto out;
+		replacement = freplace_skel->progs.replace_add_ip_encap;
+		err = bpf_program__set_attach_target(replacement, prog_fd,
+						     "add_ip_encap");
+		if (!ASSERT_OK(err, "set freplace target"))
+			goto out;
+		err = lwt_ip_encap_stale_cb_freplace__load(freplace_skel);
+		if (!ASSERT_OK(err, "load freplace"))
+			goto out;
+		freplace_link = bpf_program__attach_freplace(replacement, prog_fd,
+							     "add_ip_encap");
+		if (!ASSERT_OK_PTR(freplace_link, "attach freplace"))
+			goto out;
+	}
+
+	snprintf(pin_path, sizeof(pin_path), STALE_CB_PIN_FMT, getpid());
+	unlink(pin_path);
+	err = bpf_program__pin(target, pin_path);
+	if (!ASSERT_OK(err, "pin target"))
+		goto out;
+
+	netns = netns_new(STALE_CB_NETNS, true);
+	if (!ASSERT_OK_PTR(netns, "create netns"))
+		goto out_unpin;
+
+	SYS(out_netns, "ip link add vh0 type veth peer name vh1");
+	if (use_vrf) {
+		SYS(out_netns, "ip link add vrf0 type vrf table 1001");
+		SYS(out_netns, "ip link set vrf0 up");
+		SYS(out_netns, "ip link set vh1 master vrf0");
+		SYS(out_netns, "ip addr add 10.1.0.1/32 dev vrf0");
+		SYS(out_netns, "sysctl -wq net.ipv4.conf.vrf0.rp_filter=0");
+		SYS(out_netns, "sysctl -wq net.ipv4.icmp_errors_use_inbound_ifaddr=1");
+	}
+	SYS(out_netns, "ip link set vh0 up");
+	SYS(out_netns, "ip link set vh1 up");
+	SYS(out_netns, "ip addr add 10.0.0.1/24 dev vh1");
+	SYS(out_netns, "sysctl -wq net.ipv4.ip_forward=1");
+	SYS(out_netns, "sysctl -wq net.ipv4.conf.all.rp_filter=0");
+	SYS(out_netns, "sysctl -wq net.ipv4.conf.vh1.rp_filter=0");
+	SYS(out_netns, "sysctl -wq net.ipv4.conf.all.accept_local=1");
+
+	if (pre_encap) {
+		tc_hook.ifindex = if_nametoindex("vh1");
+		if (!ASSERT_GT(tc_hook.ifindex, 0, "vh1 ifindex"))
+			goto out_netns;
+		err = bpf_tc_hook_create(&tc_hook);
+		if (!ASSERT_OK(err, "create vh1 ingress hook"))
+			goto out_netns;
+		tc_hook_created = true;
+		tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_pre_encap);
+		err = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(err, "attach pre-encapsulation program"))
+			goto out_netns;
+	}
+
+	if (!ASSERT_OK(stale_cb_get_mac("vh0", mac0), "get vh0 mac") ||
+	    !ASSERT_OK(stale_cb_get_mac("vh1", mac1), "get vh1 mac"))
+		goto out_netns;
+	SYS(out_netns,
+	    "ip neigh replace 10.0.0.2 lladdr %02x:%02x:%02x:%02x:%02x:%02x nud permanent dev vh1",
+	    mac0[0], mac0[1], mac0[2], mac0[3], mac0[4], mac0[5]);
+	SYS(out_netns,
+	    "ip route add %s encap bpf in pinned %s via 10.0.0.2 dev vh1 %s",
+	    STALE_CB_DST, pin_path, use_vrf ? "vrf vrf0" : "");
+
+	ifindex = if_nametoindex("vh0");
+	if (!ASSERT_GT(ifindex, 0, "vh0 ifindex"))
+		goto out_netns;
+	packet_fd = stale_cb_open_packet_socket(ifindex);
+	if (!ASSERT_OK_FD(packet_fd, "open packet socket"))
+		goto out_netns;
+	if (!ASSERT_OK(stale_cb_send_packet(packet_fd, mac0, mac1),
+		       "send crafted packet"))
+		goto out_netns;
+
+	ihl = stale_cb_icmp_ihl(packet_fd, &saddr);
+	if (!ASSERT_EQ(ihl, 5, "ICMP IPv4 header length"))
+		goto out_netns;
+	if (use_vrf && !ASSERT_EQ(saddr, inet_addr("10.0.0.1"),
+				  "ICMP source is ingress slave address"))
+		goto out_netns;
+	if (use_freplace) {
+		ASSERT_TRUE(freplace_skel->bss->freplace_ran, "freplace ran");
+		ASSERT_TRUE(freplace_skel->bss->freplace_cb_zero,
+			    "freplace cb was cleared");
+	} else {
+		ASSERT_TRUE(skel->bss->direct_ran, "direct program ran");
+		ASSERT_TRUE(skel->bss->direct_cb_zero, "direct cb was cleared");
+	}
+
+out_netns:
+	if (packet_fd >= 0)
+		close(packet_fd);
+	if (tc_hook_created)
+		bpf_tc_hook_destroy(&tc_hook);
+	netns_free(netns);
+out_unpin:
+	unlink(pin_path);
+out:
+	bpf_link__destroy(freplace_link);
+	lwt_ip_encap_stale_cb_freplace__destroy(freplace_skel);
+	lwt_ip_encap_stale_cb__destroy(skel);
+}
+
+void test_lwt_ip_encap_stale_cb(void)
+{
+	if (test__start_subtest("direct-cb-access"))
+		lwt_ip_encap_stale_cb(false, false, false);
+	if (test__start_subtest("freplace-cb-access"))
+		lwt_ip_encap_stale_cb(true, false, false);
+	if (test__start_subtest("vrf-direct-cb-access"))
+		lwt_ip_encap_stale_cb(false, true, false);
+	if (test__start_subtest("vrf-freplace-cb-access"))
+		lwt_ip_encap_stale_cb(true, true, false);
+	if (test__start_subtest("already-encapsulated"))
+		lwt_ip_encap_stale_cb(false, false, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb.c b/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb.c
new file mode 100644
index 0000000000000..7638db379118e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
+
+#define IPOPT_RR 7
+#define IPOPT_MINOFF 4
+
+bool direct_cb_zero;
+bool direct_ran;
+
+struct tc_outer_ipv4 {
+	struct iphdr iph;
+	__u8 options[8];
+};
+
+static __always_inline __u16 fold_csum(__u64 csum)
+{
+	csum = (csum & 0xffffffff) + (csum >> 32);
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return ~csum;
+}
+
+SEC("tc")
+int tc_pre_encap(struct __sk_buff *skb)
+{
+	struct tc_outer_ipv4 outer = {};
+	struct iphdr inner;
+	__s64 csum;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &inner, sizeof(inner)))
+		return TC_ACT_SHOT;
+
+	outer.iph.version = 4;
+	outer.iph.ihl = sizeof(outer) / 4;
+	outer.iph.tos = 8;
+	outer.iph.tot_len = bpf_htons(bpf_ntohs(inner.tot_len) + sizeof(outer));
+	outer.iph.id = bpf_htons(0x2345);
+	outer.iph.ttl = 64;
+	outer.iph.protocol = IPPROTO_IPIP;
+	outer.iph.saddr = bpf_htonl(0x0a000002); /* 10.0.0.2 */
+	outer.iph.daddr = bpf_htonl(0x0a090909); /* 10.9.9.9 */
+	outer.options[0] = IPOPT_RR;
+	outer.options[1] = sizeof(outer.options);
+	outer.options[2] = IPOPT_MINOFF;
+	csum = bpf_csum_diff(NULL, 0, (__be32 *)&outer, sizeof(outer), 0);
+	if (csum < 0)
+		return TC_ACT_SHOT;
+	outer.iph.check = fold_csum(csum);
+
+	if (bpf_skb_adjust_room(skb, sizeof(outer), BPF_ADJ_ROOM_MAC,
+				BPF_F_ADJ_ROOM_FIXED_GSO |
+				BPF_F_ADJ_ROOM_ENCAP_L3_IPV4))
+		return TC_ACT_SHOT;
+	if (bpf_skb_store_bytes(skb, ETH_HLEN, &outer, sizeof(outer),
+				BPF_F_INVALIDATE_HASH))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_OK;
+}
+
+__noinline int add_ip_encap(struct __sk_buff *skb)
+{
+	struct iphdr iph = {};
+
+	iph.version = 4;
+	iph.ihl = 5;
+	iph.ttl = 1;
+	iph.protocol = 4; /* IPPROTO_IPIP */
+	iph.tot_len = bpf_htons(skb->len + sizeof(iph));
+	iph.saddr = bpf_htonl(0x0a000002); /* 10.0.0.2 */
+	iph.daddr = bpf_htonl(0x0a090909); /* 10.9.9.9 */
+
+	if (bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(iph)))
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
+SEC("lwt_in")
+int lwt_in_direct(struct __sk_buff *skb)
+{
+	direct_cb_zero = !(skb->cb[0] | skb->cb[1] | skb->cb[2] |
+			   skb->cb[3] | skb->cb[4]);
+	direct_ran = true;
+	return add_ip_encap(skb);
+}
+
+SEC("lwt_in")
+int lwt_in_freplace_target(struct __sk_buff *skb)
+{
+	return add_ip_encap(skb);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb_freplace.c b/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb_freplace.c
new file mode 100644
index 0000000000000..6358f76e47c8b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lwt_ip_encap_stale_cb_freplace.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+bool freplace_cb_zero;
+bool freplace_ran;
+
+SEC("freplace/add_ip_encap")
+int replace_add_ip_encap(struct __sk_buff *skb)
+{
+	struct iphdr iph = {};
+
+	freplace_cb_zero = !(skb->cb[0] | skb->cb[1] | skb->cb[2] |
+			     skb->cb[3] | skb->cb[4]);
+	freplace_ran = true;
+
+	iph.version = 4;
+	iph.ihl = 5;
+	iph.ttl = 1;
+	iph.protocol = 4; /* IPPROTO_IPIP */
+	iph.tot_len = bpf_htons(skb->len + sizeof(iph));
+	iph.saddr = bpf_htonl(0x0a000002); /* 10.0.0.2 */
+	iph.daddr = bpf_htonl(0x0a090909); /* 10.9.9.9 */
+
+	if (bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(iph)))
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

