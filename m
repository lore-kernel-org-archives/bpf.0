Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215895;
	b=GEZB9WRymhDlSHEoIeoGeA5xI2TIwUyTz+A7yt3QHCmun2lWP4zEgMmnhXANik1ajJWT
	 2eH+HOPU1rw8BlCBU2UggV80/7ddopJHP3A1gnI0UdwlJVf0yXrAbYUHb+LeB1nC0vvQt
	 QmzP6YdwE1q5SxgqqN3+GheGpYG3M3XpJ4Za/Rf3u6tkaM2JrAcJtbW3/aA5EdvH0ite7
	 8k0aJ8Ry9U8EB4O/mUiLwbVoeHeDE8TVmU7nNq6b5LwhvOtLQoESGLpCEQY6iWdahy+rw
	 EWQa/XqiksNNzhb3ADGdbnTMgKUzcvGWstKMgUjrtrtjpgKy/mVue8dpVKxFZRhzinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=/wBsxz8SxXMwHBU3491QiAIfiIdjYFkiipB0X+a5k7Q=;
	b=I6XOUSjUD1tsYAlsDI/+K38uvrIanhKDIXJmdrvr/pleUFuNfq6Qi2yVFoJhDxYFbDvX
	 VD8GcbJZ3M5JKeDI3VgsT0zScia1c6ypLQLKhJhyjZ5RqavqhKmlT0R0mYuYNofY1d7M1
	 bvraOrpB+7z0wwDlHnHTwAy7Q5HJAVNCLT4tHL8cuvTDkx7CAyGdImpQqKRnXccno6yN0
	 Tu+B2OtgAWKB2lPwGvNrcw/XAb/G2jpkHvx8Icyh1s+ma33RMTSuUTVrSj//UIwuicIPz
	 hM5hXvRoEJlo0XWDwb1OUw7Qf9iQH0nFizFiomKIYyVjlRTZ/djyDkXTPZl5OauNGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GqbjajKM;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BE606A31E;
	Wed, 28 Oct 2026 19:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 700BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GqbjajKM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/wBsxz8SxXMwHBU3491QiAIfiIdjYFkiipB0X+a5k7Q=; b=GqbjajKMv+4LLOpcusssK1VyTq
	4GFh0T7xERdRA2FngOc22DhR/5MlQapDWlGQrJIFTsHss0cGj4xTeyYEOjNgJ+nep2m+RlrNAc8dv
	Nhn4A1F9ndRGPYy+mAGg2/KDrzPEoycho5P9zLxluBNXe66AqiqPDdYGNXPK2mv2yVjSMOQ7LKpy1
	oO/ZW78HHUdKokCnZ2mqwfQdFypEqRbvZSvSYhg7NpG4TLzqiLWo3XGw+G1cjCNf/1sQXIiQeJBSg
	gxUgPOlT96zxh+lP1T8PvdRO903/I1Dh3GbDhxmsNR8+lbXfaas9M4bwvxuuLSsoaakC4C/buMl8I
	hx1TZngA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM9MY-000MPs-0O;
	Wed, 28 Oct 2026 20:31:06 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM9MW-0007F2-0R;
	Wed, 28 Oct 2026 20:31:04 +0100
Message-ID: <8a17da81-59cc-4e59-a306-9cd233e7cf3d@iogearbox.net>
Date: Wed, 28 Oct 2026 20:31:03 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net: fix eth_type_trans() crashes on skbs
 coming from the stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 dev@openvswitch.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ren Wei <weir@nebusec.ai>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <DMGNHWT5M153.3C6CZBKTPNBAY@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <DMGNHWT5M153.3C6CZBKTPNBAY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

On 10/28/26 6:34 PM, Alexei Starovoitov wrote:
> On Wed, Oct 28, 2026 at 05:26 AM Eric Dumazet <edumazet@kernel.org> wrote:
>> Other eth_type_trans() users already pull the header or never see
>> such skbs:
> 
> netkit_xmit() has the same problem, I think.
> It calls eth_skb_pull_mac() directly, not eth_type_trans().
> It pulls ETH_HLEN before netkit_run(). The prog can shrink the linear
> part after that:
> 
>    AF_PACKET SOCK_RAW on nk0          eth (ETH_P_IP) / eth / 8192 bytes
>    tc egress on nk0
>      vlan pop_eth                     skb_headlen() == 0
>                                       skb_mac_header_len() == 0
>    netkit_xmit()
>      pskb_may_pull(skb, ETH_HLEN)     skb_headlen() == 14
>      netkit_run()
>        bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0)
>          bpf_skb_generic_pop()        off == 0, skb_headlen() == 13
>      eth_skb_pull_mac()               BUG() in __skb_pull()
> 
> It's an old bug and it doesn't block this series.
> It can be a follow up.
> 
> Something like this (compile tested only):
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 82e608e..f093103 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -116,6 +116,9 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
>   	switch (ret) {
>   	case NETKIT_NEXT:
>   	case NETKIT_PASS:
> +		/* The prog may have shrunk the linear part */
> +		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> +			goto drop;
>   		eth_skb_pull_mac(skb);
>   		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
>   		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
Reproduced locally with a BPF selftest, and that fixes it. Feel free to
add my Acked-by.

Thanks,
Daniel
