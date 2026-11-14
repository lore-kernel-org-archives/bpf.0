Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680871;
	b=R82m9XRRZZrgTRQwTVFv+KQM/fgLWvUvs62B3xkzIjWVaLpQAyTHf0cT2Gx185lRJQ8l
	 5UwpGLafpRIIJhLX2smHo8Rzf0k4wQehrcz2nbXUzR3k/ZROIJZv6JCRAzLHcZwlUHlT5
	 bsAOtwhqQffFzsAT7Eulk7PGdCOj+cpFblL3JMucIXUZbA+1YY6Rh8SpfEJadcSerFEy9
	 jafSrZw3cUjjcd49NCm9J+hp2kLQYSMYfFjr/eVuHJBMQoHP2MBiYZTwmg/8ypV4oYIxJ
	 JuvJZE1RSrkSVXFGMMxdZ3atXr4QqSeZMxtePndGShNgN5m0AhzBZJfqIQt3lcubH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=COpZlkF3gjNsbleKennDYj+Fmu6LFoVwH+euJBJfJOY=;
	b=Faai1vkj72XE1yagRjwm13aidDGGkz9K6zYytrda2eBKapfF0Cre1Gu4tMut5PC2bv/d
	 PqGDfxY0dpL9KG0RPr6sQiJTWNlUhr8HmuwaW9HHJ9cAg1GdRPzuq64XMSGXn5lW6TPLB
	 gUbz+IHdJkBmbQ6kYXCuElcufGr/VQ6DXG1wS4DMheSaz8ocfL/GK82i6U/KJQHaFKya8
	 4lDOptXtUJjqH8ck/VfSFK2XBq1wiugriApfIiMZeOsIAtIrF4A5sEilu5COo1MmDwTJG
	 KBlHvlhR/7LigG0sJRUd+ngLm1XBxXQSvB9kAW3KkwqDzJerRqI6xPiDjF51LaPTkEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=u1ahjrHa;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39343606A891
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39343606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=u1ahjrHa
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4395d31228so383134566b.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794680870; x=1795285670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COpZlkF3gjNsbleKennDYj+Fmu6LFoVwH+euJBJfJOY=;
        b=u1ahjrHa4S10vwFHPp1YcfCzotsvWJ6wsT46BsGRopHXst2ygrEwQhtTPt0JmMxOwi
         Jp6fzNbsLPDoaSvVc7BTnyuqGCTz30vGlb9gh5w90VrPa4tpIuLkFOCx+mNb7DkDxFaL
         KIaO2j7tH5pb1t3EBb+yHIwuBKfeOxjFPcVVlVR048Xvq0dov7DPDrcWspBWn7LKz3GT
         eCfieLZlG3IQ2tpk/VC9nMEqa/6ijt2+T3n5YZJttlmr6b2bF6YJ1epTfewEBsHVCcWc
         hWRzRdGyfnusjN6nmxxMoOCPM8G96Tj5MvKU7C07RpIksijy4LvH59BR6wHXj+DcLz0h
         NzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794680870; x=1795285670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=COpZlkF3gjNsbleKennDYj+Fmu6LFoVwH+euJBJfJOY=;
        b=peGSpEj4Y0iGRPtsTxHQSDrx7om8M9M8rBwy+VYGoRTp+za+uimVaE0IM0nmMmfdus
         EzMsINX2f1zm7w6PcxbduOpbVWJwajI1RL5TgC3TxN4Ifc1Lm+NvEEX/uV0BhzpPrudo
         4oMNP+z+++C2j57VLBC96btt/6Lj4kdiFZRy3b/4pyU9/+viINv65lJ1+6cdg5+Ki89E
         7kOi8cdmKCUWxEwjYVSpr40ZK9aBgZmioKPVURICwwsO0kbT2apIPwb5T4eeAZiVE41Z
         +EXCH4UEvQaRNSOIL3mTbVahPNi7GJOeJZL4plz9KGBJgILCmmtXDIDMuRskiBl11tan
         +EXA==
X-Forwarded-Encrypted: i=1; AL+hErEcp3nJHKcrnnF9JHiuDktBNxPf1haKy5pziV37EeQg4uFKEJxbza/BeBkzIwG3v3lw+5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w8/TVIO2v0jjudOnUtzBKCKUW+4gib9MgnLGWa0OLPvVTqCGo
	hA9+n+zyOKH0yjYPXdHnQ1L7PT56YLUg+H4GyIJJX1RnBjfFzYLLCDwRXvMTIfgWRQ==
X-Gm-Gg: AYBFou2H4bfZPzf7p6uZu27OqCGwQRjkEZsbNJtZ3xj59xcWhFtXDez/hHfO287xTuS
	o0HFd0hcIG98UntdQKHvejlUA27N6Ka+labp/Crut0JPHVH9+Yerk0662swcFVN0d9lHuW8r8Ck
	oD9D4kgir+XWs7IfwZYzR+KD3FZGq/LQuqujbLMpMeImTXYyyKOqkvglvWoaEvDlmpQ2WEO+SKr
	hqMIc9k65GC8YJcLbsMqljcJp6AhgPciyrhfQbEGPr0U1oJkoeAZmO+6vBY4HHGQwZaV0ADS62U
	j/nxU/XGNTsyTTEu8SBtt5aPPQJOhDfk1eIIRJNuGhkIeVUFQ+eB42fxX+laoEtTtHuIy+Qc3IS
	H48etmF6nXB+w/W9M1M4ZyJRxJ4fHsRBlIeaSCU/c/J5vrQ8kAC/aTraOxb9EsCzKvlSHE78un+
	cS3+BwPOqwjxBFbvg3resSvXVwixEwzjcB6bTRyZg4xxquS4NwMLo/4hXn5dzh4n+Ubs6EFC2/l
	S8vyBSeRLZOueSLh3RZreqXfGp9jfE9kk8sJ99UAd/pft5PXD6b6iYfgza4YN8Sm9Xck5mb2DCL
	yVzzNp9/E4UAwGhpg/cBo3KhWfy8J6ShIxglYLT0zw/jaU/6ZdNqmZmY3AVnjXsd+uXZ1fvRmWY
	zPbSomUEUHHwgPEQliQL4X3aQsDpE1sr420Mtb+Du7HEsUhTgfTTn3Q0Sq8IbJz6wyjKpKP6AcJ
	hjsh3Bk/OHcwyKTDthLt7AoBMaX0dyV4G7KfIaKkw6VEjAsfvxnFOKLxkNjklXQJPb/F+q7ObKO
	O3o75AFbUFSsHBrsBK41DkIwqRmMYvkcutgG3yOpBFclLZb+5FEob7KLUqnQ2ISP3IFvSyHf9Ah
	QLo=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr585583166b.44.1794680869556;
        Sat, 14 Nov 2026 10:27:49 -0800 (PST)
Received: from Desktop.fritz.box ([185.181.130.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm245554366b.47.2026.11.14.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:27:49 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	kuniyu@google.com,
	richardbgobert@gmail.com,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	linux-net-drivers@amd.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sat, 14 Nov 2026 19:27:44 +0100
Message-ID: <f7d096c63c6a0b7a23a4dcea9a3de0915a48ac56.1794139176.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794139176.git.julius@bairaktaris.de>
References: <cover.1794139176.git.julius@bairaktaris.de>
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

Commit 3271f19bf7b9 ("net: gso: restore ids of outer ip headers
correctly") made SKB_GSO_TCP_FIXEDID describe the outermost IPv4 header
and added SKB_GSO_TCP_FIXEDID_INNER for the inner header of an
encapsulated packet. Every path that adds or removes a header then has to
move the flags, and none does. A TCP stream that GRO merged with fixed
IDs and that is forwarded into an IPIP tunnel, or into an ESP tunnel mode
SA with crypto offload, is segmented with one outer ID for all segments
and with incrementing inner IDs. Decapsulation leaves the state of the
removed outer header on the new outer one, and the inner header of a GRE
or UDP tunnel, which segmentation reads at encap_level 0, gets the state
of the outer header.

Let SKB_GSO_TCP_FIXEDID describe the innermost IPv4 header again, as it
did before that commit, and replace SKB_GSO_TCP_FIXEDID_INNER with
SKB_GSO_TCP_FIXEDID_OUTER for the outer header of an encapsulated
packet. A new outer header then has no flag and gets incrementing IDs,
so encapsulation needs no change, and decapsulation clears the outer
flag in iptunnel_pull_offloads() and bpf_skb_net_shrink(). Convert mlx5
and sfc, the two drivers that use the inner flag.

Fixes: 3271f19bf7b9 ("net: gso: restore ids of outer ip headers correctly")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 Documentation/networking/segmentation-offloads.rst |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++------
 drivers/net/ethernet/sfc/ef100_tx.c                | 12 +++---------
 include/linux/netdevice.h                          |  2 +-
 include/linux/skbuff.h                             |  4 +++-
 include/net/ip_tunnels.h                           |  1 +
 net/core/filter.c                                  |  1 +
 net/ipv4/af_inet.c                                 |  8 +++++---
 net/ipv4/tcp_offload.c                             |  6 ++++--
 9 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 25a8b7eca847a..0f20bb643145d 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -49,8 +49,8 @@ The default behavior is to increment the IP ID with every segment.  If the
 GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
 ID and all segments will use the same IP ID.
 
-For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
-SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
+For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the inner header.
+SKB_GSO_TCP_FIXEDID_OUTER can be used to specify the same for the outer header.
 Any combination of these two GSO types is allowed.
 
 If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 22fea4739a2c9..b804a759710e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1175,12 +1175,8 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
 				   ipv4->daddr, 0);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
-	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
-		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
-
-		skb_shinfo(skb)->gso_type |= encap ? SKB_GSO_TCP_FIXEDID_INNER :
-						     SKB_GSO_TCP_FIXEDID;
-	}
+	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
 
 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 03005757c060d..162cfa54f2d04 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -201,16 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool outer_csum;
 	u32 paylen;
 
-	if (encap) {
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
-			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-	} else {
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (!encap || (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER))
 		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-	}
 
 	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
 		vlan_enable = skb_vlan_tag_present(skb);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e5..7ecf0f9c5f655 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5536,7 +5536,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
 	netdev_features_t feature;
 
-	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_OUTER))
 		gso_type |= __SKB_GSO_TCP_FIXEDID;
 
 	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e4..6eb913ebc7d53 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -716,9 +716,11 @@ enum {
 
 	/* These indirectly map onto the same netdev feature.
 	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
+	 * SKB_GSO_TCP_FIXEDID stays with the innermost IPv4 header, so there is
+	 * nothing to do on encapsulation. Decapsulation clears the outer flag.
 	 */
 	SKB_GSO_TCP_FIXEDID = 1 << 30,
-	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
+	SKB_GSO_TCP_FIXEDID_OUTER = 1 << 31,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cccf4c0e6913..a8e1cd7021fcf 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -667,6 +667,7 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 			return err;
 		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
 					       NETIF_F_GSO_SHIFT);
+		skb_shinfo(skb)->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 	}
 
 	skb->encapsulation = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 52e6ea6d50455..340b2e64d818e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3867,6 +3867,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Clear encapsulation flag only when no tunnel GSO flags remain */
 		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
 			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
 						  SKB_GSO_UDP_TUNNEL_CSUM |
 						  SKB_GSO_GRE |
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7677b0343abd4..d5769a5fdc314 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1402,10 +1402,12 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-
-	if (!skb->encapsulation || encap)
+	if (!skb->encapsulation || encap) {
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
+		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	} else {
+		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER);
+	}
 
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b84fcd07c7230..79190044f6fe9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -459,6 +459,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
+	const u8 fixedid = NAPI_GRO_CB(skb)->ip_fixedid;
 	struct tcphdr *th = tcp_hdr(skb);
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
@@ -473,9 +474,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID << 1 != SKB_GSO_TCP_FIXEDID_INNER);
+	/* Bit 0 of ip_fixedid is the outermost header, bit 1 is the inner one. */
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+		(((fixedid >> skb->encapsulation) & 1) * SKB_GSO_TCP_FIXEDID) |
+		((fixedid & skb->encapsulation) * SKB_GSO_TCP_FIXEDID_OUTER);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.53.0

