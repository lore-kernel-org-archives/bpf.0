Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190455;
	b=JWou/smgOW6waVwCoOQnKL8gw+bPSAfjaeN9QvM/bdyr6c+xscKZ7mlUzySAXGTEjasM
	 czUTprzKEhl3jJYcHhyOOWzvJYHOfTscC1aDVKTb2KbHWfEzWsjkFoRUut0FNPMsDClKe
	 WLs8slW2QjglHWuOnee/Mt3w6Q3tJLHNprMRb9oSEJsT7iz1qxFjzc679AcUTwM3aGDRJ
	 4kopj3vytfd61u+mJ+/MetU5TNKQ2Hj0NFJErpZHti04ZFmLNhzpRhTACv/rjR43XC6wZ
	 0WLYjv2XSAirrWm/uup3sEsL7/AeaV38lvIu6GWjNQTVHoMv3ge7zn1nvKnKRjcXTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t7edQ3ltItCPYjYCnj5IiHPcFRQNK/7PckbU6OeRwMI=;
	b=uS3x8sU1hpiCacv9c8xLhOgRSaKpqcW/gR9KGKX6Mh6oYUJ2H8yhdg3kBqgWQz8C6XNo
	 3qrISpvheCDN/fUYPEKQL3DKBW1/Zy/MNRg9og0AFj7OnDCHz00GIleBsl8m6FC+TteIm
	 x1orswYY7OezwYtCHDtXSy43d0sEtSgPpGFkFG+0lzIHvxGNThN6RuRmwAsqZK4Qykb5a
	 l6HZQNjs2rI5E5LjYYOg17dXUMhLSNWA52Wx5BSQ5sPpYbIhPoNrk6eu1LQi7uoLo9QF+
	 Y5BM2xYFOeekbYjoQWMMA8Y0gMvRLiLGnTFBCGxc1s1nbFy57cEz4/wMW0xwenjc6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4xHTJ2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F6606A31A;
	Wed, 28 Oct 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4xHTJ2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEDC1F01825;
	Wed, 28 Oct 2026 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190455;
	bh=t7edQ3ltItCPYjYCnj5IiHPcFRQNK/7PckbU6OeRwMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E4xHTJ2gx+6IKj4UyCiEiHht/rD3Q08gG8KYWKkaQ+DwO9b5QWba6NgdZry9ETOhD
	 LJeinzZKPOzwQmSWWUW/yTQz6PBRn9e9ePKyz1pP+b9Ui1CUDl38EJWxMA0W99gtQP
	 +Jx7p0iINVAK2Ef0201TuM3WJmgt8NpoeZqk+zfIDfqmv7a/zWX481noF3iNP62nA7
	 xvXwCUY00EUi84F7lNGRzZH2znH1IF1rDWlQ0kSxD8jG8Asnrm9dVpgFYb5nmAKLoB
	 XIrE0L5TIGwBkihofnjgxcg09Iu7GsK+vafEBG3kU+LtunIsJPOZ7sAf+T9I/XVWeM
	 VOvpAD+WJPaQg==
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
Subject: [PATCH net v2 4/5] openvswitch: use eth_type_trans_careful() in internal_dev_recv()
Date: Wed, 28 Oct 2026 13:27:02 +0100
Message-ID: <20261028122703.2093730-5-edumazet@kernel.org>
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

OVS actions like pop_eth followed by pop_mpls(ETH_P_TEB) or pop_nsh
can expose an inner Ethernet header which is not in the linear part
of the skb. Output to an internal port then crashes in eth_type_trans():

  flow: in_port(0),eth(),eth_type(0x8847),mpls(lse=0x00010140)
  actions: pop_eth,pop_mpls(0x6558),0
  # AF_PACKET SOCK_RAW on dp0: eth / mpls / eth / 4096 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   internal_dev_recv (net/openvswitch/vport-internal_dev.c:202) openvswitch
   do_execute_actions (net/openvswitch/actions.c:1296) openvswitch
   ovs_execute_actions (net/openvswitch/actions.c:1606) openvswitch
   ovs_dp_process_packet (net/openvswitch/datapath.c:310) openvswitch
   ovs_vport_receive (net/openvswitch/vport.c:448) openvswitch
   internal_dev_xmit (net/openvswitch/vport-internal_dev.c:42) openvswitch
   dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
   __dev_queue_xmit (net/core/dev.c:5066)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled. This covers all OVS actions at the consumer,
instead of fixing each producer.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/vport-internal_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 77a16d5ebd54343c80a2def261aadcb8ff0d1274..8f035087f0eec80eddf6b493cf5ba7915a3e01c6 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -188,6 +188,7 @@ static void internal_dev_destroy(struct vport *vport)
 static int internal_dev_recv(struct sk_buff *skb)
 {
 	struct net_device *netdev = skb->dev;
+	enum skb_drop_reason reason;
 
 	if (unlikely(!(netdev->flags & IFF_UP))) {
 		kfree_skb(skb);
@@ -199,7 +200,12 @@ static int internal_dev_recv(struct sk_buff *skb)
 	nf_reset_ct(skb);
 
 	skb->pkt_type = PACKET_HOST;
-	skb->protocol = eth_type_trans(skb, netdev);
+	reason = eth_type_trans_careful(skb, netdev);
+	if (unlikely(reason)) {
+		dev_core_stats_rx_dropped_inc(netdev);
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
 	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	dev_sw_netstats_rx_add(netdev, skb->len);
 
-- 
2.53.0

