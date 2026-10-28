Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190451;
	b=SLTbcm4/MGgaZYabi49kEkKjEwgfojpongp4s6puM9SmfkOrCd5+T3rofRNhIyxOHbI6
	 yv/MtH+woQmm389KHP4iwHsnVD7kMSnz3qaAo0oViNlfLkbz7uQmIu2WZQ6XZJM7/Ji9L
	 ysJnTyWMSiHueWJ43+eTcMBnjMj6ZPTKqQbMfw0UmtMFJXry6/HrwMHROIUCKydEjVTW+
	 xfrqIHBAMRT8Qn6vu29LgV3gSkC4O4FKhS9jtPL+S+u5uL1oSkIY14CW70Ns3V1lfXNU/
	 4AnzYPmar2pfY49ypX+zHRMthVLgyc8GYdrPWWD+UxZEDq2628ym6FF7ltqzsRVK2CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DiaTpfW5KCOdWJuZOfR4DFsJnE0d3F/i8T+eJoIZptU=;
	b=ZKgOMR7vvtbRRjinXFaP2752Z4UY9XbywSEUlqJt36717gc/PA069XaG6iAmr+I5AeFv
	 WI3yU7vpAV7L6ZWSTCAy0ND2B5m/OeKrxvXH7QQtxkmXjLdUeA/F0DyLldoc3FVytDePF
	 ZhqDvuHF9vrlGJ/wI8eQl4gqR1VRVhTHwtkGjUiU29Cw8E/TAMHlMSnQjU6kWVnO4ZXeB
	 +85kZdLT6fA3i1/gxE1DveYSrkPNc30qOty5s5MffQfFLIj2jRSSgjqLcqDpx9+3D/8Ln
	 pr1HODKCDq3OsQCOM6VYnDRlW7LdESBIiE7DuD4aA/izQscPoqpVHkk0LLxm3DOEQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xbqrau7k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C6606A31D;
	Wed, 28 Oct 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xbqrau7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C9A1F01825;
	Wed, 28 Oct 2026 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190450;
	bh=DiaTpfW5KCOdWJuZOfR4DFsJnE0d3F/i8T+eJoIZptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xbqrau7kWzi1mBfW0VYKLLd4wIiSVWCtR5aBs68jIjy+qabb1TyDwPTfO7mXVvH+2
	 idIO+doir7eFCosLkjzEaO5l9GlLaSMaXX01PZQSDuLimRunVqaFfWVbmBiRbiW4bv
	 9rvWLHTzm2Wm6TKK56WO6THnBSk7++GaLyzcifbP7bCqXBzS1aLoxFhgUTi3FKluNL
	 aB2d9JX8JLpIDWh1QBIm7WxqESlHzYkPv1aOaZrhMCYnC0F3rHtI2vXmQazxe3jwke
	 JtCQcmh5Jn4qei5l+vGTDhIktKTcoDfAObHXlwaDz0VKz2f/UXuaDdm3qvl2KqJuyb
	 vAFHOrEMle0kw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>
Subject: [PATCH net v2 3/5] net: use eth_type_trans_careful() in __dev_forward_skb2()
Date: Wed, 28 Oct 2026 13:27:01 +0100
Message-ID: <20261028122703.2093730-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028122703.2093730-1-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
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

A tc egress BPF program can push a tiny link-layer header with
bpf_skb_change_head() on an skb whose head is almost empty, then
redirect it to an Ethernet device ingress. __bpf_redirect_common()
only checks mac_header < network_header, and __dev_forward_skb2()
crashes in eth_type_trans():

  tc filter add dev lo egress pref 1 matchall action vlan pop_eth continue
  tc filter add dev lo egress pref 2 bpf da obj prog.o
  # prog: bpf_skb_change_head(skb, 1, 0);
  #       return bpf_redirect(veth1_ifindex, BPF_F_INGRESS);
  # AF_PACKET SOCK_RAW on lo: eth / eth / 8192 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   __dev_forward_skb2 (net/core/dev.c:2507)
   dev_forward_skb_nomtu (net/core/dev.c:2546)
   __dev_queue_xmit (net/core/dev.c:4738 net/core/dev.c:4998)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled. This also covers other dev_forward_skb()
users (veth, macvlan, ipvlan, netdevsim, l2tp_eth).

Update the empty_skb BPF selftest: at lwt_xmit, BPF_PROG_TEST_RUN
strips the Ethernet header, so the "veth ETH_HLEN+1" packet is a 1-byte
skb. Redirecting it to veth ingress used to read the Ethernet header
past skb->tail and deliver a 1-byte frame; it is now dropped with
NET_RX_DROP, as veth_xmit() already does at egress.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c                                | 18 +++++++++++++-----
 .../selftests/bpf/prog_tests/empty_skb.c      | 19 ++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b3622e532f269333ed62e31fbca0f6ac56dcde8f..a51d53491fa23158cb31fa4764f41f0ad9ecc978 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2501,14 +2501,22 @@ EXPORT_SYMBOL_GPL(is_skb_forwardable);
 static int __dev_forward_skb2(struct net_device *dev, struct sk_buff *skb,
 			      bool check_mtu)
 {
-	int ret = ____dev_forward_skb(dev, skb, check_mtu);
+	enum skb_drop_reason reason;
+	int ret;
+
+	ret = ____dev_forward_skb(dev, skb, check_mtu);
+	if (unlikely(ret))
+		return ret;
 
-	if (likely(!ret)) {
-		skb->protocol = eth_type_trans(skb, dev);
-		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
+	reason = eth_type_trans_careful(skb, dev);
+	if (unlikely(reason)) {
+		dev_core_stats_rx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return NET_RX_DROP;
 	}
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
-	return ret;
+	return 0;
 }
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index c9fcb70cbafbce571d7826e233920193625dead1..a3938c16557b140e3ee5c116139cf8b636f85e35 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -24,7 +24,7 @@ void test_empty_skb(void)
 		int *ifindex;
 		int err;
 		int ret;
-		int lwt_egress_ret; /* expected retval at lwt/egress */
+		int lwt_ret; /* expected retval at lwt */
 		__be16 h_proto;
 		bool success_on_tc;
 		bool adjust_room;
@@ -82,7 +82,7 @@ void test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &veth_ifindex,
 			.ret = -ERANGE,
-			.lwt_egress_ret = -ERANGE,
+			.lwt_ret = -ERANGE,
 			.success_on_tc = true,
 		},
 		{
@@ -96,17 +96,23 @@ void test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &ipip_ifindex,
 			.ret = -ERANGE,
-			.lwt_egress_ret = -ERANGE,
+			.lwt_ret = -ERANGE,
 		},
 
-		/* ETH_HLEN+1-sized packet should be redirected. */
+		/* ETH_HLEN+1-sized packet should be redirected at TC.
+		 * At LWT, the Ethernet header is not part of the skb, and
+		 * a 1-byte packet is too short for an Ethernet device.
+		 */
 
 		{
 			.msg = "veth ETH_HLEN+1 packet ingress",
 			.data_in = eth_hlen_pp,
 			.data_size_in = sizeof(eth_hlen_pp),
 			.ifindex = &veth_ifindex,
-			.lwt_egress_ret = 1, /* veth_xmit NET_XMIT_DROP */
+			/* lwt: skb->len=1, dropped by veth_xmit() at egress
+			 * and by __dev_forward_skb2() at ingress.
+			 */
+			.lwt_ret = 1, /* NET_XMIT_DROP / NET_RX_DROP */
 		},
 		{
 			.msg = "ipip ETH_HLEN+1 packet ingress",
@@ -144,7 +150,6 @@ void test_empty_skb(void)
 			eth_hlen.h_proto = tests[i].h_proto;
 
 		bpf_object__for_each_program(prog, bpf_obj->obj) {
-			bool at_egress = strstr(bpf_program__name(prog), "egress") != NULL;
 			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
 			bool is_adjust_room = !strcmp(bpf_program__name(prog), "tc_adjust_room");
 			int expected_ret;
@@ -153,7 +158,7 @@ void test_empty_skb(void)
 			if (tests[i].adjust_room != is_adjust_room)
 				continue;
 
-			expected_ret = at_egress && !at_tc ? tests[i].lwt_egress_ret : tests[i].ret;
+			expected_ret = at_tc ? tests[i].ret : tests[i].lwt_ret;
 
 			tattr.data_in = tests[i].data_in;
 			tattr.data_size_in = tests[i].data_size_in;
-- 
2.53.0

