Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554215;
	b=o4eCgpHh/YhhEcOJ5progjkbjvFkJnJbjR4i3j1WDOQhLbV2+aamR+o2KiI/0ErfP5dY
	 CfkBdiaYH0ieKlO/3IiHkBJQz6SvpTDjmYnMGHCxqJBu9rXEseNEAa0gxFPh4xgmBSBFx
	 nMvHc6X57CflH5Y8oyBSzKgvsT3Q7BOc1GCAU/xu9YaL6fk2MclO8T24nlhPwCIpfHb4j
	 ZJMyto6GYwKwoCRvTjJiJi+RNRjClM4ldcCgjHSEiOvgUCtMQePFDKz+cRaGIWQPqLwSE
	 dYUyEk8CkUlAqR4ol7Z5KI7wMlaAup2Sy4EgZa1djd4ilGVRjcS0ZQiX4PAftHkScHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
	b=uDpf2FJRyEplZKyG/9pgG0t3V+3tSbM88r2W8c3JVlhrJrDgP5Gg1CRwc71bAaMN7XV4
	 2Fx90giSKqUmOSrUXh4a37g7uljLf0qmJyEiVllxGfDNhtz9ogT5wiZzH43+YyW51XrSZ
	 QbJuKpT1QCtHpJ6Q6Jw2RBRoKfbnNxOiEFU8KAq4wcKEXMDCjqgbzf9VQZqqmZuzylPRr
	 Fn93tgiA0hcAfhOelob+aqSwtTgcp/rER/OZXaSdYfRWGzQwPmFftYcv96MUkv6HWVfMz
	 vcD0aLH9l+b2JdDzWwzTwR0i7ojsUsuuJXe/bXNGC0CvIKOGU6KOXuVMR3otG1ojOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJBzmjvf;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783ED606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJBzmjvf
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1303158a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554214; x=1794159014; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
        b=DJBzmjvfSco3FICFg2idv+0ljye0HNTj1MdvnD7nftPDGb8VlDqyReKmVc+brgqqZx
         qQfKLXru/2BHn89Xw6q/OxGwhNTqQeji7wfTKshpPGaBA0JMCmUzCFOB4qwTbg0BS30k
         xqxmYhI/Xfamjdr2+ELsO7+0l93qDVPLJIEb09CduJeBE+KGPN++YQmdmUbezKKCmwSI
         1d7YP6zUC0P5QLCrrWLOMgnQ9OpWwMhDO9lr9MdSQ1HmmH9wAmwGvCv8IwdYWVFz/nIG
         enW4g87Kq0h96XpT3XaU67d73zYqp/AtL8/z2y5JGDh4GsspcXF4CWU7+ZQADRPjE1kA
         5oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554214; x=1794159014;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
        b=y+LoNYEGjjeIO+M9RRXGA1f0kFZv2YLcoqB3wqkI6qmoQVYeTZfFJVKirYjH5TUfoe
         sFdeJye1B9TOQCytj/70onOTjUSk4Tsl6Jf3WJ1Xv1a9KdBMZz4L08ALw1ubE+NCuMKr
         DJopKwwHi+VvT55FGLLgDLfIgMIaw7f78jiVY9EU214meavuC2JAdaLXQGI4ICDqwWwA
         5ZNgl7wXxi0/1b3h8hlv0wMu5DxtVSQhJ5ZpSdVzi22OQ+ap6ixGLu76AKNISSEdw0Re
         rAVe6yBNIVhdSwOUuReeSxnMHbT4nNroUbeY6C+iyWHMaL5sfkS7eMatY+AJs0myn6st
         zurw==
X-Forwarded-Encrypted: i=1; AKwUvBxSIV+KTggiEE/UM3Mx4dB2S0RKwiUCc2cZ/Pmorh3+xo1OFM4nsrhtHXy7al2foJpsRnM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+arTQIRYF5hrDWAyiq+Caup9HbAGvFjhBqSYcuNbVn3iU8eCXY
	xhHpgrZABZgqyHEimbyEEZQxsLDWAPHxLOoii6SS1nqGMoBJNYgE7803
X-Gm-Gg: AYBFou1UyyhsZGH43Q+yQ0+B99p790IWv7FhOzkhfB0XfCyFzOPF2IN8noNDUUcZETk
	lT1sbXq3wnH8Y0yBaybVGSiN0hEvEOrIvcchGXj6lAvxKlLh5/n0Y/2ZpzM/xskJ8uoWyTLdCfh
	0Uq5JiC7Vq97PAU9Wm7v9iIPXgE5xofxWWVdReMBpHYlENXQ/gVrkbUUsKw0Vp3mJYL+RAdgmou
	44IBb2wRtSl6qG5cA4/0psBDt8pNovnAPDo3ltyi/Hn0NsUIbZjyD+0vbLlqObdPRgsgU30b3yu
	MPgC9P2tVcDinz3kMAJHvkJp7S40NfBX10rHXjM/8yCBSJdML5ei/0TUOSWVSLfbo2Lw+uEGlUh
	En3LAAUSpZX6aUd4Gszt+boEDgF35NwS31LBgA9IpqFEkZvNru3rv3dYWSBCnQa/YL18iTB1QCe
	GBBcmYoslaPvhGxXeYgbO+W0bw9hXmTTF7CyAf+OpE0VPvMoFsubvmO11qWZpwfa761PqSjvNjN
	qeBZBebQe+h4A2iO8/zybMz03v+MkrrFPWsW8wgRgjjTJhvo8sAQk9z1/OyLt7ZvoqjE/GCg1BV
	wgvVPmeiiE2rMWx63TffhTrHQMvD4EX2DTLHzYkTyUtPBGEnt/hDSNd++lNjoaBlyLPZSf41+5X
	1UtesM1De8Tt8zEMpCbaTXS9KutDVtVYBfQ==
X-Received: by 2002:a17:90b:4a11:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3ae896f7fc4mr6014943a91.14.1793554213552;
        Sun, 01 Nov 2026 09:30:13 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm14819745a91.15.2026.11.01.09.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 09:30:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 17:30:12 +0000
Message-Id: <DMK1WMB2XY42.29D4PNQZ4JVBV@gmail.com>
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>,
 <idosch@nvidia.com>, <richardbgobert@gmail.com>, <willemb@google.com>,
 <ecree.xilinx@gmail.com>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <martin.lau@linux.dev>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: keep the TCP fixed-ID flags on the header
 they describe
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Julius Bairaktaris" <julius@bairaktaris.de>, <netdev@vger.kernel.org>
In-Reply-To: <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
References: <cover.1792857378.git.julius@bairaktaris.de> <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 08:46 AM Julius Bairaktaris <julius@bairaktaris.de> wrote:
> GRO sets SKB_GSO_TCP_FIXEDID for the outer IPv4 header of a TCP packet
> and SKB_GSO_TCP_FIXEDID_INNER for the inner header of an encapsulated
> one, and segmentation reads them the same way. Three paths do not keep
> the flags on the header they describe:

When the same mistake is made in N places the interface is the problem.

Before commit 3271f19bf7b9 SKB_GSO_TCP_FIXEDID described the innermost
header. Encapsulation didn't have to know about it.
That commit made it describe the outermost header.
Now every site that adds or removes a header has to move the flag.

This patch changes 9 sites and it's not enough.
xfrm_output() sets skb->encapsulation and SKB_GSO_ESP.
xfrm4_tunnel_encap_add() adds the outer IPv4 header.
SKB_GSO_TCP_FIXEDID stays, so ESP tunnel mode has the same bug as IPIP.

> tunnel GSO types of the removed header. Keep encap_level below GRE and
> UDP tunnels, as ipip_gso_segment() and the IPv6 tunnel handlers do; the
> inner pass then also masks the features with hw_enc_features, which the
> tunnel handlers have done already, and resets the inner headers of each
> segment.

This undoes
commit 5197f3499c47 ("net: Reset encap_level to avoid resetting features on inner IP headers").
With remcsum __skb_udp_tunnel_segment() sets NETIF_F_HW_CSUM after its
mask. The mask in inet_gso_segment() clears it again on bnxt and mlx4.
Their hw_enc_features has NETIF_F_IP_CSUM and no NETIF_F_HW_CSUM.
Then skb_segment() checksums every segment in software.

> The three changes go together: with any one of them alone, fixed IDs
> are lost in a case that works today, such as a packet encapsulated and
> decapsulated again without segmentation, or one forwarded into an IPv6
> GRE tunnel.

Lets keep SKB_GSO_TCP_FIXEDID on the innermost header.
The second flag describes the outer header of an encapsulated packet.
Willem's intuition in the review of 3271f19bf7b9 was right:
https://lore.kernel.org/netdev/willemdebruijn.kernel.a8507becb441@gmail.com/

                               this patch          flag on the innermost
                                                   header
  encapsulation                move the flag       nothing to do
  ESP tunnel mode              missed              nothing to do
  decapsulation                move the flag       clear the outer flag
  SRH decapsulation            move the flag       nothing, outer is IPv6
  FOU pulls offloads twice     needs a check of    clears it twice
                               skb->encapsulation
  GRE, UDP tunnel GSO          keep encap_level    as-is
  sfc, mlx5                    as-is               less code

Then no need for skb_gso_fixedid_encap(), skb_gso_fixedid_decap(),
the bool in iptunnel_handle_offloads(), etc.

Something like this (compile tested only, the mlx5 hunk was not built):

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 25a8b7e..0f20bb6 100644
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
index 22fea47..b804a75 100644
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
index 0300575..162cfa5 100644
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
index 6f7fec2..ac3f664 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5535,7 +5535,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
 	netdev_features_t feature;

-	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_OUTER))
 		gso_type |= __SKB_GSO_TCP_FIXEDID;

 	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf..6eb913e 100644
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
index 5cccf4c..a8e1cd7 100644
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
index 09c60a5..0b8d363 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3803,6 +3803,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Clear encapsulation flag only when no tunnel GSO flags remain */
 		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
 			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
 						  SKB_GSO_UDP_TUNNEL_CSUM |
 						  SKB_GSO_GRE |
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7677b03..d5769a5 100644
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
index b84fcd0..7919004 100644
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

