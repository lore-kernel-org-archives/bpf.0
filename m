Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530231;
	b=jM9FZskZt4AQ2SPgrgvCX02Y5cpD/PNqp41fuX10lcRWW2l6WEFMuFEL/xtinW6Cba8G
	 dYwuHaX4/ftiWjqCUOntHTC+vr3G5RPN/pgK5CPrAKywWvkygTJovMde097NkAUrBI1bZ
	 28/ICMEgkBKI5KSXHHr57iCedM3ATOwgLVaHmeqCibgN4g5Rj551FaawQEVy0wobk1Hld
	 xNijh8vSTX8Yz7Fq0ET5sFnGTetsILsuw5Hc9Bk5pk8CnWO35X6WNIoEl8x0TSKYpbLK0
	 S997YQjv/8MhNaJ+ZrcRYvjz4xB8zo58ZKRnRQBixNhjZj5WP8TZMZ5rCGAfbz+0wkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530231;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=u8ytjzLGT9u73CVzPoGJdSTSstXpX06F4wtfTDoHE9c=;
	b=N8lx/Tpr+tRWn+XVSTGoi7ZPTk1iYSkq1VhK7aMpOM1Htdo9z8B8I8J0HOLs6ZcGfg1q
	 m9JHS0XtlJrsmUefs4JaOYniT92YfzIL+g2Rg1iKCOkThnNY2+f9CfdLGcQbiy28eDvcw
	 RU9ObQZlV6wmDf7osDABNBCAOU8Bpgm6ujQ8YkmZp2VLo70hoYkmwNJ5QQLrg8+PYhrU6
	 3zwOe3uafM3r8d4gsFXRrMrYSKXWvUd0J2V45Nri+uehQsZovpZyCspgwQzGRNXkdVhit
	 TlHGgUeir0paIk4UyGm9k8gnuFvVp+1OlTilgaSnOXqFyYlSzcvaCcWVMpKh8Hf6eGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LdiLfpNB;
	arc=none smtp.remote-ip=91.218.175.31
Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC26606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC26606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LdiLfpNB
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=K5kxjwdrKRCx7YT4plbcssoC62fiIRBME4cA+uWQRsg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795530228; v=1; x=1796135028;
 b=LdiLfpNBVejnfHRV6F9uBV+vuvBX2VNSM74vHBL1IbzHD1AyEAKm1EG4w281zoo56JX+W4C7
 swoJ1W1knEor//PzJKjpLRBOh0UhwPW6/NwtE6UgaFWb7bavJAhkos4rBxjfg+pgQ6l3zvNTvPB
 +vOkq5iRkiW2Rmz1YZJK0Y9E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 30824d65790ac0b1;
	Tue, 24 Nov 2026 14:23:48 +0000
X-Mizu-Trace-ID: 30824d65790ac0b1
X-Migadu-Flow: FLOW_OUT
Message-ID: <511dade2-01a9-492b-85c2-014880b2379e@linux.dev>
Date: Tue, 24 Nov 2026 22:23:37 +0800
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
Subject: Re: [PATCH net v2] net: xdp: fix generic XDP on skbs without an
 Ethernet header
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, kennethbwlee@snu.ac.kr, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com,
 wang.zhan@smartx.com, mkarsten@uwaterloo.ca, bpf@vger.kernel.org
References: <20261123121540.275576-1-jiayuan.chen@linux.dev>
 <179552306350.3135.16282643834784138893@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <179552306350.3135.16282643834784138893@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/24/26 8:24 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new runtime guard in netif_receive_generic_xdp()
>   (net/core/dev.c:5827, `if (skb->data - skb_mac_header(skb) < ETH_HLEN)…
> 
> --
> 
> net: xdp: fix generic XDP on skbs without an Ethernet header
> 
> This patch stops generic XDP programs from being attached to devices that
> are not ARPHRD_ETHER or ARPHRD_LOOPBACK. dev->type can change after attach,
> so it also skips generic XDP for skbs whose mac header is shorter than
> ETH_HLEN.
> 
> Closes: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 6140fd9d11cd0..df335f361706d 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -5823,6 +5823,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>>  	if (skb_is_redirected(skb))
>>  		return XDP_PASS;
>>  
>> +	/* XDP is Ethernet only, skip skbs without an Ethernet header. */
>> +	if (skb->data - skb_mac_header(skb) < ETH_HLEN)
>> +		return XDP_PASS;
> 
> [Severity: High]
> 
> According to the commit message, this check covers the case where dev->type
> changes after attach:
> 
>   "An empty bond or team takes the type of its first port ... So also
>   skip the program for skbs whose mac header is shorter than ETH_HLEN."
> 
> What happens with non-Ethernet ports whose L2 or pseudo header is ETH_HLEN
> bytes or longer? In these two cases data - mac_header is at least 24.
> 
> IPoIB, in skb_add_pseudo_hdr():
> 
> 	skb_reset_mac_header(skb);
> 	skb_pull(skb, IPOIB_HARD_LEN);
> 
> ipgre with ipgre_header_ops, in __ipgre_rcv():
> 
> 	if (tunnel->dev->header_ops == &ipgre_header_ops)
> 		skb_pop_mac_header(skb);
> 
> That second case leaves mac_header on the outer IP header, so mac_len is
> the outer IP header plus the GRE header.
> 
> The sequence looks like this:
> 
> 1. Attach an XDP_FLAGS_SKB_MODE program to an empty bond or team while it
>    is still ARPHRD_ETHER. This passes the new dev_xdp_attach() check.
> 
> 2. Enslave an IPoIB device to the bond
>    (bond_enslave()->bond_setup_by_slave()), or add an ipgre device to the
>    team (team_dev_type_check_change()->team_setup_by_port()). Nothing
>    vetoes NETDEV_PRE_TYPE_CHANGE because of a generic XDP program.
>    bond_enslave() only checks the native-mode bond->xdp_prog.
> 
> 3. On RX, __netif_receive_skb_core() calls skb_reset_mac_len() on the
>    lower device's skb. The rx_handler returns RX_HANDLER_ANOTHER, and at
>    another_round do_xdp_generic() runs the upper device's generic program.
> 
> 4. The new check is false, so the program treats the IPoIB pseudo header,
>    or the outer IP/GRE bytes, as an Ethernet header.
> 
> If the program then changes bytes 0-5 or 12-13, bpf_prog_run_generic_xdp()
> does:
> 
> 	__skb_push(skb, ETH_HLEN);
> 	skb->pkt_type = PACKET_HOST;
> 	skb->protocol = eth_type_trans(skb, skb->dev);
> 
> This leaves mac_header at data - 14 while skb->mac_len stays at 24 or
> more. skb->protocol is also taken from non-Ethernet bytes.
> 
> Would tc ingress then hit the same "skb_vlan_push got skb with skb->data
> not at mac header" warning in skb_vlan_push() that this patch is meant to
> fix?
> 
> There is also a second gap. bpf_xdp_link_update() calls dev_xdp_install()
> directly and does not go through dev_xdp_attach(). After a type change like
> the one above, could a new generic program be swapped in through an
> existing link without hitting the new ARPHRD check?
> 
> Would any of these close the remaining cases?
> 
> - require mac_len == ETH_HLEN at run time
> - check skb->dev->type for ARPHRD_ETHER or ARPHRD_LOOPBACK at run time
> - veto NETDEV_PRE_TYPE_CHANGE while a generic XDP program is attached
> 


Ok, same as sashiko.
I used < ETH_HLEN to keep VLAN devices with reorder_hdr off working, but the fixup after the program is wrong
for them too, so I'll just skip everything that is not ETH_HLEN.

pw-bot: cr
