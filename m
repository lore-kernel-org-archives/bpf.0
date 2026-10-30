Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396853;
	b=lv3Cfg50tgDjiU0fk5aCjaXUzMLZHUKfIZoOss4zYl8sLYLmhoyKuVTgoq8iq0VzqHMG
	 5U258+EAzLdso8lZZ3xm+FoMwxCIS1gSgG38XMsvJVStVxveF5k5dPoMNiJDVmQ4LbOa7
	 D2DRHE7K2jY0gINq+HQcwCKyu8ZiKE9j+33BYFVl5lbsQo7weSkPTvZPJq+xQWd4aowo5
	 kSyzom7s05TjQFLp41uc4NhR2DwWlkBctYZ3D9IGJHF6uahZZm37lv83mqzicVkQUMNYT
	 SKirXGiz070ZAE+JcO6yxvXbpDsilToB+EqVL/tYDW9pDrci+5xGa+kZELLzeppxDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
	b=asDgn5tl1u3qbZwlUHPfFDVuAU7aeXbiJtz/HMfecZbHAqYGY76atI7HJ+dPCmCk+VDQ
	 xLRMuKMiSD0XQ2hd6oyvUbg1c9H8OVkyp7J8atuOT8BRm1R0R8fJ7xaDtUtCxjCJZ2a7a
	 77Gu6xNVb4MvGTwM6OarFYa+1BLzkkuK5S1F2DxRq4kZHJoYjY13LdPalvxcIycgTZ8nd
	 ODOxP5Jsd9NBwtpulyLAv8kiY78yE65p20Rb5LnjFvKmfnlAb6SAJPYnzKbV21TxcSNf4
	 r4j5X823l6GB3Q02fyAEUTNGCrqZR434Iz1cnCWOPYRpWVWfCbPqpHg71Cxo4DWZ3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA91606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA91606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e60f9af6e6so11367755ad.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396852; x=1794001652; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=QwLgp5NIIMg4AA8/Z8CtU3veu8cREA/NoPqO23FoHKGC2AvsPNQmzks5z8NjAGnG/7
         BD+ScScN5uJUv8ITeksQDGK+fqx3rm7eK5nu5JL35HXr5EeDTZqo8H6lUhoriOU0kp3T
         n4Cr6obn1rdNu4BtmuGD/0gHHQOz/9joE+tLRnTxTz3OpMJ8aym3QAdjy+0zl7O+2L0w
         OcJWym7XY8P4pwpSMytqPjqzLzyaJmqOxy6zVKYr8aq3T+f039sSxExWB+CFDlN8z0yd
         uiAKWbQYezGYKcGlBy2DHE+7yOcvR6xCHyhfPmirxfPFcswd06xFfor8tls/BoU2Rz6I
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396852; x=1794001652;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=Rwb56EpqyzftNGjClUaWXsrSRNhf3iye9zDuL0d11NY0nyZ3+XNQn/U2qLDHNmy7A9
         dLOmQeKGzFEJ2qmhIE6CK24GF0ll/eJnWCVXwYlJwNXkfuXF3lNYIOpjGIehaX+8sD3G
         1QvnUW4WRapKuepeqVX6KHk8GDDlKT/s/yJiVcrf0zeiMdKafJitOUjh/B1DdU/1xxzx
         JHX3cqqnoCElX7jE3KAFrNW664MqxPgEHJq44mPde0nuKZK83iKCnfdGXqaukV7g5RCF
         UNAZSU6nR8IUL/v3pjoDG0v/hS6Ol7JbRLs4s3dIP0tF/bU9YFfkHXbrCOea87oVyF3n
         CA4Q==
X-Forwarded-Encrypted: i=1; AKwUvByX641qfEsWpbGuWRIfTsBYqZxN59fi8SDn6Dxxf5ggfEqYoXOs6/U2Jok5bFm0V+Z6tmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsTAuLYbDTh77QwfuBTFiK+NjO0DVZAnAO5a/L765VCx3+y1vR
	W0gCcVyKB9p4NaUhMyfVNFTefFpTdh3i+OoI8ZWSBqJTxVo7ajyKy+xg
X-Gm-Gg: AYBFou2OXiUr8bNiNmRbu2nDoxtisWnwNw6l5amvp3iVx/Qqr+nD5Nxpn5hsdEBrnOs
	f931Ynkjqi3p3P63wU5Ue2PAqFxGBetCzSWzXw/71+1CHcCbgHAxSRDd33zYPq4iTHkpVP5B91N
	m/PQViwcaM9TXMXoXKQSo6hoJ7n156nSYfhH6EGuNsMiv1sC2yDvHcalSfu2w7rMxTrFiKpfFZj
	1qcE3ZBTQGOSGmS+MOxfWjDR1g0dd85zZ1wVAAEd+ihbbFEkBmgt+bapqHqzHn/FsVPcRqJCYLS
	s83FMspiAA3hTdqhbm+qrdOKTPJ3PqRd1qEt83iT7iu396GhBPZFzG02DLVTOq+NfWblMoi7Jez
	UHV4Vd1pj72E+HlUZJspiUBXlsFgQqDNXuVMDYZkvZ2yaXwM6pVO6mlh0KDsJir3fnZ+yYLK43j
	d4vYWQVbZXSIY9b3LahI+jz7yj9mgT7NTiWPwVIg7itd5P7JmYGqTJvJZk2lIJgWvbFVFbOBXuq
	xXnMacIo5s4XMSHhguUm9D9/tD3KDswPpCXYqbjiO2L1Ac6BG1X/z6PnpWPIUbHtiI/3+dbX0yB
	meq4M5uUzfc8zL/DKz7/JMWRy3MMg77gCJYeXPZp742cmg20rdbo7+s7+l8qFxBSMF2yEN4JigJ
	edLKCc5PPojzEdvPl2+aG+wvO3rmU3/Hw3w==
X-Received: by 2002:a17:903:144b:b0:2e9:42d8:48d3 with SMTP id d9443c01a7336-2eb364d2529mr35787295ad.36.1793396851935;
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39230bbfsm11775285ad.19.2026.10.30.14.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 21:47:30 +0000
Message-Id: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "Eric Dumazet" <edumazet@kernel.org>, <bpf@vger.kernel.org>,
 <bot+bpf-ci@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "David
 Ahern" <dsahern@gmail.com>, "Martin KaFai Lau" <kafai@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor
 Nogueira" <victor@mojatatu.com>, <linux-kselftest@vger.kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in
 __bpf_redirect_neigh()
In-Reply-To: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
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

On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Add egress coverage to tc_redirect_neigh: the existing test only attaches
> redirect_neigh at ingress, where mac_len is populated.

This test cannot hit the BUG.
Just drop it and respin as [PATCH bpf v3].

>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
>  				struct bpf_nh_params *nh)
>  {
> -	struct ethhdr *ethh = eth_hdr(skb);
> +	struct ethhdr *ethh;
>
>  	if (unlikely(skb->mac_header >= skb->network_header))
>  		goto out;
> +	if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> +		     !pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;
> +	ethh = eth_hdr(skb);

ETH_HLEN is not enough.
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
and ipv6_hdr() right after the pull. Nothing makes these headers linear.
Take the AF_PACKET frame from the commit log without pop_eth and
bpf_skb_change_head():

  packet_snd()                     headlen == 14, IP header in frags
  skb_pull(skb, ETH_HLEN)          headlen == 0
  skb_reset_network_header(skb)    network header == skb->tail
  ip4h->daddr, ip4h->saddr         read past skb->tail

The route lookup runs on garbage.

Eric's skb_network_offset() check also covers
mac_header >= network_header. No need for two checks.

Something like this:

diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct ipv6hdr *ip6h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
+		goto out_drop;
+	ip6h = ipv6_hdr(skb);
 
 	if (!nh) {
 		struct dst_entry *dst;
 		struct flowi6 fl6 = {
@@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
+		goto out_drop;
+	ip4h = ip_hdr(skb);
 
 	if (!nh) {
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
@@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
-
-	if (unlikely(skb->mac_header >= skb->network_header))
+	if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
 		goto out;
 	bpf_push_mac_rcsum(skb);
-	if (is_multicast_ether_addr(ethh->h_dest))
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
 		goto out;
 
-	skb_pull(skb, sizeof(*ethh));
+	skb_pull(skb, ETH_HLEN);
 	skb_unset_mac_header(skb);
 	skb_reset_network_header(skb);
 

pw-bot: cr
