Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190446;
	b=IS5e1ZiR4W8iZlVMIk/DLiUZOs0IlVL9Z01hi25nQaZ5ydOfl1nn0JyLTuzyetxt6Uq1
	 axwIVlqPx2SY7zlk/0cnjSBVvalt9XHwTKnDrPlsSIwyAeVEjN1ti9GIcNXFDmoXYkoD9
	 1a6flAjmC3Y0vzEjjqsDHrvLgmXieZk7y2e1w0v2T+3JtFd8G1mI1u3ZBqwBP0AFiVgZ1
	 jn3PH5JBw9ZQjPfjlzOotnrklefoiCqxF3qmNCqiR0+NkOVQlvqrpUc1CMjvN2fDe+vHK
	 6Yl10eL0XS+tGQtcR6HPibB9U0QuXBQFPEr7A9Q94UppqJ1SHQ6nKzu+t2QkrCgWYbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190446;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TD0R0GcnMxsqRw3Dfotwa8QE/YUfAhr68qs15gjH64o=;
	b=eDNqNspWox62UHYHS8PZKUU/Xg+yY46nMboGS/UbYBDZ3L9YXjjc3+IV4u5hQ0zxIGVF
	 L9cNqAUItBOewxzpWB/XUT4PAwpQqPg+2rkuQoQJ1W7O5gNBbrBiZNIxggG5CfmLa0pOX
	 M+8CeDwMF9I+39Ee4uNUujR7YfdCxyRqp1BEHyJ/zR1S7TZRK29TDwfZTiFFrJ9Cck8xb
	 +FyE28GrC8c9p6+zPMYnzm/NHQpCCpVk2yUQGXw5JTg5N6qLBs1OvOfRj/vc10Q8RxO6s
	 l3b2vX5tlGhw75KniabZQBwD8wZ5DEESVrrE6DzfjDTC3DJUTpcm4gINBr3GkOrOXng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAodqzMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5E606A31C;
	Wed, 28 Oct 2026 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAodqzMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2D21F01825;
	Wed, 28 Oct 2026 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190446;
	bh=TD0R0GcnMxsqRw3Dfotwa8QE/YUfAhr68qs15gjH64o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iAodqzMX5hgwXfh6OLXbobY269RnTV8VpCA0MfWvHX4Iceb/TAc8+boWz4OB6ad7b
	 dUSjshTEyCL2vK5ltUS8rf763Vxk7dVdkWFXbLOpd9xpQBZLM92ID7CHu6tQCsDGbZ
	 H2nvfuJFxiC/cKShAlbR49Ibf0YcfAvgdPNZT2KEi6Q7R8L2PEy0+gnx8w4bPiOhhj
	 N0kImQj2d3SoTUBUGKvcWugnpqjutMgg0O0GjgQr44juEbrRoAADbAKnGeHrtfCNJd
	 juujZlw/wM1UePDIKV2Q2za5H937olYR2QfjJGTH+zK9f963tpEJI3HLS/RZGB1oKB
	 MP947OXN9hH7Q==
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
	Ren Wei <weir@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 2/5] loopback: use eth_type_trans_careful()
Date: Wed, 28 Oct 2026 13:27:00 +0100
Message-ID: <20261028122703.2093730-3-edumazet@kernel.org>
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

tc egress actions can leave an skb with fewer than ETH_HLEN bytes in
its linear part. loopback_xmit() then crashes in eth_type_trans():

  tc qdisc add dev lo clsact
  tc filter add dev lo egress matchall action vlan pop_eth
  # AF_PACKET SOCK_RAW: eth / eth / 8192 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   loopback_xmit (drivers/net/loopback.c:87)
   dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
   __dev_queue_xmit (net/core/dev.c:5066)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

The same happens with "action ife decode" on lo egress.

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/loopback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 55ecd5ebac0f21b61b64373c429a6f9ba5d15c8e..8a6cb34e6b5f02c88dfb0c6bf112068c4f51fec1 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -70,6 +70,7 @@ EXPORT_SYMBOL(blackhole_netdev);
 static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 				 struct net_device *dev)
 {
+	enum skb_drop_reason reason;
 	int len;
 
 	skb_tx_timestamp(skb);
@@ -84,7 +85,12 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 	 */
 	skb_dst_force(skb);
 
-	skb->protocol = eth_type_trans(skb, dev);
+	reason = eth_type_trans_careful(skb, dev);
+	if (unlikely(reason)) {
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
 
 	len = skb->len;
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
-- 
2.53.0

