Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874857;
	b=B/6NeHsmzHwDJFKozn6Elh6Dox52YFYoLv1oyJHDpRUjwWufVZFxETfF7ZKlRlOzULVh
	 CbB1Eh2QauZaXrvGfZb01XlVIdmssT0DLCYfu9/e3xPZ4Uel1edpV8wza1hyGWznYyTKh
	 o420VgRUr0WvhGN3sMMHYOxBwng9wXqW1xvbRfNh4rvQaDafjfdH3tMIjU79vOar2op5Q
	 T3H/27zM8C/0Hjy4FKZjdjq+ls0xwI/C++/OBJX5JvmDAJj8dseMpSB/jimFrQ8S9LvF/
	 9Zynu+e7/IYoqMvV4OopMnoMIWeSgm4/LXTbHRkRDi0LJNrZgHicL7FujucHyn1/gHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f/d1btkvZcevrnOhkA8/ZTJd8q2ZFvpCiI2Vo3YPdjY=;
	b=OBiKmYTum9dbk/jRiL76tcFMF/ODryMQbn7BXd8rJtM2lnaMhqOPSHKYl9YZ7Cs0ptdX
	 7053TEMhKn/mPybx3FgNWIyKz77wiBnSk66TOZIquMTHzDlYi5NRkng0g7x3u5T2POKAG
	 uepTC+/DDWFffwKTq8w529xBhiP3Z1zn6/ZUe4CeHkAMIm6FBJodTWKsbiHQ8Wlz4CKmI
	 wiv0r61/BpbzArOLZh1fRYgj/TDUQkuikHvH6Gv6JnhZ8jIWLPTLcR66kooDDZxo0wcH8
	 PfFsxedkx/Fk4D3PeaK/sq1fE+wqRoElpaxgB6XKQn1dX4moSR7g1wOa41HBLrwF6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gmjyyqag;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E6606A689
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 14:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00E6606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=gmjyyqag
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c51d158acc6so282622366b.0
        for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 06:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795874855; x=1796479655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/d1btkvZcevrnOhkA8/ZTJd8q2ZFvpCiI2Vo3YPdjY=;
        b=gmjyyqagDNUDUma+oTBWJ12m+2GcALMG2fZNV/rZt8Az3XgYaZoad6Xn2L5EVLLRfw
         0huvtE81L3NWNuRv57z9wgY2PkAXmuTNaqVjbOeaeq7XgkPqJbAmgAE8UJlRI6stZXeZ
         8Wg1kusbDcv3bvf4z4Dz0Z6PfKSWa1mHYTW/7AXJaovFrfqI84SYAzmpawueDe9B2Can
         GPI1gyrMetfHtaO6KXY/vZMFxasq1U5ld1KQyacQNvL0RYQx/hvgZyZmCejek/tKCCXI
         hSxwpfMXGLsNCPevMwr9Nlb6/Wyc7Gz+48WoraQm110Pv6yyGP5p2T7NomECnn9bB7em
         ahdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874855; x=1796479655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/d1btkvZcevrnOhkA8/ZTJd8q2ZFvpCiI2Vo3YPdjY=;
        b=G5ZNHK5MxVdCdl5tFtd5gS8DofiHdhk0tplIsQko1BKJwInP/f36KXmQf6dlumxFBZ
         DO6+yZsYpyt+sTD5Z5tfcXN5pTywdJrLpkJd7KFetXQTLHVCI+jcnLL2k2pXHw9aB6f8
         3CJKzf1RggS7Owe1E2p3HSjg3wnmex3TiZWPHSPzjdy1yZujru6BhmuAf1hVSQ9MqZ0o
         Ks5/mGWwahRixdyCuEc2JRJDwcc6n35qsiCkESE3oITZ/IMg0G4G9/e+5YLnavL2InXx
         2ZfmPsD+vs9HdVTeZFfiq1poXQon14MPVDALkEp6U/aNtmI2Mzue4ewQ793jt5IcLRNM
         jnPw==
X-Forwarded-Encrypted: i=1; AL+hErFOEJEeGjZ+dKeBbFEPAeoBtX58iSEvsK1GGhE483XS+LHlS8MjWAX0UTUltJyB5xgYePI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TeP+7uNq4dD6MOM5TOPtLz2mpnAmJFJvG5YSIzlsTCA4Rv7ot
	z0ZVMvcl32LzkStr6Xra8yT99gH4D2FeKPChLib7SgTfnecO10tFbzqgPgjwVIeghg==
X-Gm-Gg: AZFdTZdQ3h3KhKW+K+IYFLt/a1Bc48X6HSlq6nDEHq0Z93ImuRly5ixMiBQVNgK+7dC
	rTA+j8OmGxirwWWaEyc60743TZRdu2pN2TlI6agrTMmdAVpWai47dXFAJI0JW+G7iVczNwEkhX3
	W3spot5sEIgPWJByV7tlbFveCChntXcLAAmf4FDLqbSTI69TI/H3jmZxPcgfqYAa4pL+/4ktk0o
	iXOaG8Fz8Y7EqcjwpyF6J9W4smhK3yCf3iVsfshXylKvGjzhC6xWQsyq9CPpzTnkINVWVoSXlYy
	r0Q/P7UJiVHizV99GT4L0xfSdQzZQ7O82AlZ4rcep15i6AFo3xaxneVrpZHre1qMsO8MFZsdGpw
	Z7m8dUdIkzze8c0hIP2FYsXIW4UbVh2rd/NwKNdsDmFNN2LV82hneZjRBk+9ZAOxe0yKVcq+1DT
	KgW/whwSF08C7+dkZfmSJqHLpN5HQgWEgSJbwd1ryWa1bysIjjwx7Fd3f5q7JOUBVBX2IHpMTjB
	5ePuVOLrRVYK8KdnfRXRzhdip2pgyWMaeKZxOlGF+HtsGXlcq62EzxEBJKUj4bUUOEg8qmYlEvu
	cyWKA7Eo5kvMvsfk9xXU1qAqU2u9kaupM8v0xvRRNPTaRpMLKdJg4tE9HHlXg2s8PsqpCO6roOa
	X1LpFUzqMeHz86V5TebVjHkBiMQNVnFKAeBn48K795LSpPPww56+zTVVQMMXRtaCn1lWs2EbgA3
	XZpzGufIE6Gl6Pu3nCm+c3i0XDgUNAaX2CMFGupJO8x/64E+L1C/ayIgokYDdzMGtthGSjAk1oU
	HbQWpq9UprQ6MQOZt4zjU1qVpT7UyVbsllsaqqUCektJFLgiEjnrGVDT5G80AEx0aqQzmQVDhGx
	AmgEjzf4cCrkJdZCh36a7VsQULhdVlfQakXEAzfAxd2+6+RoNMGKSzOCovc0bSuOuWbbR7W4dQ=
	=
X-Received: by 2002:a17:906:2419:b0:c50:750a:6a1b with SMTP id a640c23a62f3a-c513a878473mr1785421166b.29.1795874854588;
        Sat, 28 Nov 2026 06:07:34 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247083200a8c3fd0ab7d20fde.dip0.t-ipconnect.de. [2003:f2:4708:3200:a8c3:fd0a:b7d2:fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad010a6sm990714266b.7.2026.11.28.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:07:34 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	kuniyu@google.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	andy.moreton@amd.com,
	alex.austin@amd.com,
	linux-net-drivers@amd.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	izaiahsun@gmail.com,
	zirajs7@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sat, 28 Nov 2026 15:07:33 +0100
Message-ID: <c9ec995833aac63f552441e4a60bf420a0a52275.1795869698.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795869698.git.julius@bairaktaris.de>
References: <cover.1795869698.git.julius@bairaktaris.de>
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
and with incrementing inner IDs. A tunnel that decapsulates such a packet
in iptunnel_pull_offloads() leaves the state of the removed outer header
on the new outer one, and the inner header of a GRE or UDP tunnel, which
segmentation reads at encap_level 0, gets the state of the outer header.

Let SKB_GSO_TCP_FIXEDID describe the innermost IPv4 header again, as it
did before that commit, and replace SKB_GSO_TCP_FIXEDID_INNER with
SKB_GSO_TCP_FIXEDID_OUTER for the outermost header of an encapsulated
packet. Where a header is added in front of a GSO packet, in
iptunnel_handle_offloads() and in the BPF LWT encapsulation, clear the
outer flag, so that the new header gets incrementing IDs as it does on a
packet that was not encapsulated before. Clear it as well where
iptunnel_pull_offloads() and bpf_skb_net_shrink() remove the outer
header. ESP transport and BEET mode with crypto offload set
skb->encapsulation but keep the IPv4 header and its ID, so xfrm_output()
copies the inner flag to the outer one for them. Convert mlx5 and sfc,
the two drivers that use the inner flag.

GRO of an IPv6 TCP stream in an IPv4 tunnel (SIT, or VXLAN over IPv4)
records fixed outer IDs as it does for an IPv4 stream, but
tcp6_gro_complete() never turned that into a flag: set
SKB_GSO_TCP_FIXEDID_OUTER there as tcp4_gro_complete() does. As for an
IPv4 stream, a device without NETIF_F_TSO_MANGLEID then leaves such a
packet to software segmentation.

xfrm_output() segments a GSO packet for a tunnel mode SA with crypto
offload before ESP when skb->inner_protocol is set, as an encapsulated
packet, but a tunnel that decapsulated the packet leaves inner_protocol
set, and segmentation then reads the outer flag for its only IPv4
header. Take that path only for a packet that is still encapsulated.

Two flags cannot describe a header between the outermost and the
innermost one of a packet with three IPv4 headers: software segmentation
uses SKB_GSO_TCP_FIXEDID for it, as it used SKB_GSO_TCP_FIXEDID_INNER
before.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v4:
- Set the outer flag in tcp6_gro_complete() for an IPv4 outer header
  with fixed IDs in front of an IPv6 TCP stream (Sashiko).
- Take xfrm_output_gso() for a tunnel mode SA only for a packet that is
  still encapsulated; a decapsulated one kept inner_protocol (Sashiko).
- Target net-next (Paolo), Fixes: tag dropped.
v3:
- Clear SKB_GSO_TCP_FIXEDID_OUTER in iptunnel_handle_offloads() and in
  the BPF LWT encapsulation, where a header goes in front of an
  encapsulated packet (Sashiko).
- Copy the inner flag to the outer one in xfrm_output() for ESP transport
  and BEET mode with crypto offload (Sashiko).
- Name the paths that change the outer flag and the middle-header limit
  in skbuff.h, segmentation-offloads.rst and the message; list the outer
  flag in the bpf_skb_adjust_room() decap flags of the uAPI header
  (Sashiko).
- Wrap lines at 80 columns (NIPA).
v2: https://lore.kernel.org/netdev/f7d096c63c6a0b7a23a4dcea9a3de0915a48ac56.1794139176.git.julius@bairaktaris.de/
v3: https://lore.kernel.org/netdev/7c74b2076dc7dee1d481d39a135e0946d5e04145.1795284858.git.julius@bairaktaris.de/

 .../networking/segmentation-offloads.rst       |  8 +++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c    |  8 ++------
 drivers/net/ethernet/sfc/ef100_tx.c            | 12 +++---------
 include/linux/netdevice.h                      |  2 +-
 include/linux/skbuff.h                         | 12 +++++++++++-
 include/net/ip_tunnels.h                       |  1 +
 include/uapi/linux/bpf.h                       | 16 +++++++++-------
 net/core/filter.c                              |  1 +
 net/core/lwt_bpf.c                             |  2 ++
 net/ipv4/af_inet.c                             |  9 ++++++---
 net/ipv4/ip_tunnel_core.c                      |  2 ++
 net/ipv4/tcp_offload.c                         |  7 +++++--
 net/ipv6/tcpv6_offload.c                       |  5 ++++-
 net/xfrm/xfrm_output.c                         | 18 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                 | 16 +++++++++-------
 15 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 25a8b7eca847..45c1703d68b8 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -49,9 +49,11 @@ The default behavior is to increment the IP ID with every segment.  If the
 GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
 ID and all segments will use the same IP ID.
 
-For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
-SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
-Any combination of these two GSO types is allowed.
+For encapsulated packets, SKB_GSO_TCP_FIXEDID describes the innermost header
+and SKB_GSO_TCP_FIXEDID_OUTER the outermost header. Any combination of these
+two GSO types is allowed. A header added in front of a packet gets incrementing
+IDs. A header between the outermost and the innermost one has no flag of its
+own; software segmentation uses SKB_GSO_TCP_FIXEDID for it.
 
 If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
 performing TSO and we will either increment the IP ID for all frames, or leave
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1586cb2404c0..e47b1232130c 100644
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
index 03005757c060..162cfa54f2d0 100644
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
index 694b6d29f680..9e0992afbbed 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5545,7 +5545,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
 	netdev_features_t feature;
 
-	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_OUTER))
 		gso_type |= __SKB_GSO_TCP_FIXEDID;
 
 	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c609cafc7a14..caf374b452ca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -724,9 +724,19 @@ enum {
 
 	/* These indirectly map onto the same netdev feature.
 	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
+	 * SKB_GSO_TCP_FIXEDID describes the innermost IPv4 header and
+	 * SKB_GSO_TCP_FIXEDID_OUTER the outermost one. Adding a header in
+	 * iptunnel_handle_offloads() or with BPF LWT clears the outer flag, and
+	 * so does removing one in iptunnel_pull_offloads() or in
+	 * bpf_skb_adjust_room() with a BPF_F_ADJ_ROOM_DECAP_L4_* or
+	 * BPF_F_ADJ_ROOM_DECAP_IPXIP* flag. xfrm_output() sets it from the
+	 * inner flag for ESP transport and BEET mode offload, which keep the
+	 * header.
+	 * Software segmentation uses SKB_GSO_TCP_FIXEDID for any header in
+	 * between.
 	 */
 	SKB_GSO_TCP_FIXEDID = 1 << 30,
-	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
+	SKB_GSO_TCP_FIXEDID_OUTER = 1 << 31,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cccf4c0e691..a8e1cd7021fc 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -667,6 +667,7 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 			return err;
 		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
 					       NETIF_F_GSO_SHIFT);
+		skb_shinfo(skb)->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 	}
 
 	skb->encapsulation = 0;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d7228834305..e5aae5320af9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3097,20 +3097,22 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
  *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
- *		  when decapsulating a GRE tunnel.
+ *		  and SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a GRE tunnel.
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
  *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
- *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) and SKB_GSO_TCP_FIXEDID_OUTER when
+ *		  decapsulating a UDP tunnel.
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
- *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
- *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) and
+ *		  SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a tunnel with an
+ *		  outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
- *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
- *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
- *		  or IPv4-in-IPv6).
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) and
+ *		  SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a tunnel with an
+ *		  outer IPv6 header (IPv6-in-IPv6 or IPv4-in-IPv6).
  *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
diff --git a/net/core/filter.c b/net/core/filter.c
index d6a6dd9c9547..5a7957c21d17 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3856,6 +3856,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Clear encapsulation flag only when no tunnel GSO flags remain */
 		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
 			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
 						  SKB_GSO_UDP_TUNNEL_CSUM |
 						  SKB_GSO_GRE |
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 484cd3b53dea..a7d6fda69f60 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -585,6 +585,8 @@ static int handle_gso_type(struct sk_buff *skb, unsigned int gso_type,
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	gso_type |= SKB_GSO_DODGY;
+	/* The outer flag described the header below the new one. */
+	shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 	shinfo->gso_type |= gso_type;
 	skb_decrease_gso_size(shinfo, encap_len);
 	shinfo->gso_segs = 0;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5d03a9149b40..c4541c924aaf 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1404,10 +1404,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-
-	if (!skb->encapsulation || encap)
+	if (!skb->encapsulation || encap) {
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
+		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	} else {
+		fixedid = !!(skb_shinfo(skb)->gso_type &
+			     SKB_GSO_TCP_FIXEDID_OUTER);
+	}
 
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 6c2855adff28..dbf6bbf25114 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -193,6 +193,8 @@ int iptunnel_handle_offloads(struct sk_buff *skb,
 		err = skb_header_unclone(skb, GFP_ATOMIC);
 		if (unlikely(err))
 			return err;
+		/* The outer flag described the header below the new one. */
+		skb_shinfo(skb)->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 		skb_shinfo(skb)->gso_type |= gso_type_mask;
 		return 0;
 	}
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 7691be01da4d..93ea20b90550 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -463,6 +463,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
+	const u8 fixedid = NAPI_GRO_CB(skb)->ip_fixedid;
+	const u8 encap = skb->encapsulation;
 	struct tcphdr *th = tcp_hdr(skb);
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
@@ -477,9 +479,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
-	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID << 1 != SKB_GSO_TCP_FIXEDID_INNER);
+	/* Bit 0 of ip_fixedid is the outermost header, bit 1 the inner one. */
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+		(((fixedid >> encap) & 1) * SKB_GSO_TCP_FIXEDID) |
+		((fixedid & encap) * SKB_GSO_TCP_FIXEDID_OUTER);
 
 	tcp_gro_complete(skb);
 	return 0;
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 71feb92aeac2..f232d5b38bbf 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -96,7 +96,10 @@ static __always_inline int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
 				  &iph->daddr, 0);
-	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
+	/* Only an IPv4 outer header sets bit 0 of ip_fixedid. */
+	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6 |
+		((NAPI_GRO_CB(skb)->ip_fixedid & skb->encapsulation) *
+		 SKB_GSO_TCP_FIXEDID_OUTER);
 
 	tcp_gro_complete(skb);
 	return 0;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f1f612cd7b43..e5bcb845e9ac 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -791,6 +791,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	secpath_reset(skb);
 
 	if (xfrm_dev_offload_ok(skb, x)) {
+		bool encap = skb->encapsulation;
 		struct sec_path *sp;
 
 		sp = secpath_set(skb);
@@ -805,10 +806,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		xfrm_state_hold(x);
 
 		xfrm_get_inner_ipproto(skb, x);
+		/*
+		 * Transport and BEET mode keep the IPv4 header and its ID, so
+		 * the header that SKB_GSO_TCP_FIXEDID describes is the outer
+		 * one as well.
+		 */
+		if (!encap &&
+		    (x->props.mode == XFRM_MODE_TRANSPORT ||
+		     x->props.mode == XFRM_MODE_BEET) &&
+		    (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID))
+			skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID_OUTER;
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
+			/*
+			 * inner_protocol is only valid on an encapsulated skb:
+			 * a tunnel that decapsulated the packet leaves it set.
+			 */
+			if (encap && skb->inner_protocol &&
+			    x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d7228834305..e5aae5320af9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3097,20 +3097,22 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
  *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
- *		  when decapsulating a GRE tunnel.
+ *		  and SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a GRE tunnel.
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
  *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
- *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) and SKB_GSO_TCP_FIXEDID_OUTER when
+ *		  decapsulating a UDP tunnel.
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
- *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
- *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) and
+ *		  SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a tunnel with an
+ *		  outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
- *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
- *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
- *		  or IPv4-in-IPv6).
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) and
+ *		  SKB_GSO_TCP_FIXEDID_OUTER when decapsulating a tunnel with an
+ *		  outer IPv6 header (IPv6-in-IPv6 or IPv4-in-IPv6).
  *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
-- 
2.53.0

