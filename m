Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190441;
	b=BktV0yuBUlZFhJ47Miugp9E9066KzGRnyOI0VavCQdeFyKrp8iD53s7Uc5kepvcl0wu+
	 KHh+4WKVUDns8QD3cP/oNQcKUI6U1aeuyh388B6G6lvUcsEDDRjx5JRgTJvQa+xVww5Md
	 DpX4Lqc+/YEyXVUHl+t1B84e7APnncRi/eojHhxKC34l7zIpV9UeBpIk6d1NyvrDTcjRx
	 R3MLQcZaDz5+8Xs2/0j5B5LTOwq7EhgtVmrA6A/D5efPYaOAM1/UR+jbdJtYJgo0t+5bh
	 B/9ErEL/3T2ea/JRYDW7CpXwMq1vJLF8p1l23lkwfj4rdCnOgNu0TZ5llcBllvyHtBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Yf78rh5q+20vX0febYbjJJD8StxdQXb0hlS+4Zu1s4o=;
	b=i4rzx96eyvSE+C1jIY5+csoQjheJD7dSya4dJx1w8GHz0/u1f8ddvoKIB2k79miTSZPq
	 gUPYs/LFF4O6SMOz5SVqsEqG/IU7mNrRNawBY/kggnpyBO9cbsGrflrNC2girzDvUh+Az
	 0tgv2ZEdRR81FT6R02i7sJ46bbogkRwVnU9lnwOHSnHfUqpKr2wmHqVqcLSAamZCejRn3
	 J/XSY+0S5v2devpKioOLpqRd3SANie6PHxGe+2OGoQWQpkMJH/A2Ez/+LsDVQcmMCYrN4
	 PcRwursrR09lowX3x/fXkoLKv5iN0iumS7aah6Yuw0Jdts58J5U/gizUUq7++XsPodw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F6/cjXa4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E0606A31E;
	Wed, 28 Oct 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6/cjXa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7E1F01828;
	Wed, 28 Oct 2026 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793190441;
	bh=Yf78rh5q+20vX0febYbjJJD8StxdQXb0hlS+4Zu1s4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6/cjXa48b01wruAS/mHlC9o6NbTPeBcdm5TS6NJOx9iTib1qlQkkqJkxVPwLQVh4
	 sORVFOiJMxcgPdvQUbXzQkKGVj+w2zEKq67ftZgoXb098HDdxvliGlwRkvDDvLiJVT
	 QnByzBmxh5Foj79UppncWUFnnN1IEx2r42H7rn3f0h0fxh8vCo0NkKyd9axjjRVy7K
	 qx4KitwHMIfQEcPHseMqXTZkmeXkK4LaeRs44W1PtBV1EZYUgeJkA/ZWDeUmpPYArR
	 egBTsFX2vJcotnxBaG/PiV3PrkjBwYSJs8oiqPxUoLzrOiTGBRJgD8w77Bz/btDz2c
	 c/e2Xv3HA4kJw==
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
Subject: [PATCH net v2 1/5] net: add eth_type_trans_careful()
Date: Wed, 28 Oct 2026 13:26:59 +0100
Message-ID: <20261028122703.2093730-2-edumazet@kernel.org>
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

eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
NIC drivers always provide this, and they should keep using the fast
version.

Devices looping skbs from their transmit path back to their receive
path get skbs built by the stack instead. Their link-layer header
might have been popped by tc actions (act_vlan pop_eth, act_ife decode)
or OVS actions (pop_eth + pop_mpls / pop_nsh), leaving fewer than
ETH_HLEN bytes in the linear part. eth_type_trans() then hits
the BUG() in __skb_pull().

Add eth_type_trans_careful(), which first pulls the Ethernet header,
and returns a drop reason on failure, so that the few devices exposed
to this can drop such packets.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/etherdevice.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index df8f88f63a7063fbd1df5248d2fc02c859a7bc74..1f833ebd71ed917d138ec1e64c29689ae7dd0dd5 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -38,6 +38,34 @@ int fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr);
 
 u32 eth_get_headlen(const struct net_device *dev, const void *data, u32 len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
+
+/**
+ * eth_type_trans_careful - eth_type_trans() for skbs coming from the stack
+ * @skb: buffer, possibly with less than ETH_HLEN bytes in its linear area
+ * @dev: receiving network device
+ *
+ * eth_type_trans() expects ETH_HLEN bytes in skb->head, which NIC drivers
+ * provide. Devices looping skbs from their transmit path back to the
+ * receive path (loopback, OVS internal ports) get skbs built by the stack,
+ * whose link-layer header might have been popped by tc or OVS actions.
+ *
+ * Sets skb->protocol on success.
+ *
+ * Return: SKB_NOT_DROPPED_YET on success, or a drop reason. In the latter
+ * case, the caller must free @skb.
+ */
+static inline enum skb_drop_reason
+eth_type_trans_careful(struct sk_buff *skb, struct net_device *dev)
+{
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
+
+	if (unlikely(reason))
+		return reason;
+
+	skb->protocol = eth_type_trans(skb, dev);
+	return SKB_NOT_DROPPED_YET;
+}
+
 extern const struct header_ops eth_header_ops;
 
 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
-- 
2.53.0

