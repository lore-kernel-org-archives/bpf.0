Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214183;
	b=VizbJ2t4ZLQkoHwKG5cufR6wRJzXvsBvIywbKLSzv4gioLVYSNdq3PdeoX1Jjhgi55JC
	 bqQIQcH9jA4p0A/ivjC4g3upG0QMmPYxMggnm8WRUAPeLTIo9+Qxwp9RjrmIoKfWMwcft
	 4e4RBQLioZ1e3fxdep++6WT8rkS6PVgHwcG/roc/SRAN4kK1+jx5i7bMgXlv6HynVWxB+
	 qaTkW1Xy4p22Raj8/ZpLXCBrAXk+O4KPv+5ajVkx0HX94caPxNrXXJVJmyfv/fPyMFlpK
	 An5b3qtYCnUKo3v7WiXFOyH8kq1sVT1jInh1jpUopJ96NznmDhPedziA+2j6INXfIpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
	b=wl6y96h9jeERm+67DeMtLCOOKtJOu+R/FtqYZTKd/0dcGCqODe3sDuedr1XJ+zXbi/0m
	 bmdK6iXSTh4zomR3v/dFEvjHHSDcUqrZFP7czQfruPxb42pNHH2jmKiMIBA88F6JuUUf5
	 tclbWyLC7LLT9QIt6qv3BGLjFJ/DATYLkfCzCaBDWw8qk1eFnOnLP9WEDTN6bEY9/YaJu
	 tHb/b5of3+7QNHEryO2LO1ObKi2feHEbYvhs4R8dRf364E5tISr5EpJxryNsc/WrDLmAb
	 rQPJwqfEbKuq+PdotKYjjd7Lx6+CrQIsWVsR+DK633i0aa4HnPJ/6vEmnKC4de/wfXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P6JZT88/";
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC86606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 19:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC86606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6JZT88/
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ab395abf79so12666937b3.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214182; x=1793818982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
        b=P6JZT88/SvnGvQPtUYU6UYlfLX0q019sjrIEFKXRwFbsQw+KAiuKQdU5r1bbUN97rD
         tl395zpBurBx4wfQ33p/4MfqlxqcFJ4Ue2pozGmZzM6cGt/UCCedAk5ij99spcO2lEsv
         D4eahRFDjtT0mrgCoLhG+wxi6SYqSVkGqxNG909A+rcnIXGDKnr2IOwnu9NKq0nYVR9V
         UWnWJWVxekfhehQel2JYoUPYtJKHmd6YpQLjKu9H6wwr+5tu5e5DNLaGHCcKy40W4+Wh
         lKDPsayxaWM5R03wB+At9/SXueH9yPRNS66DJDeAFKTRQr0Bv1+zzH3kSQLc0IjygZHA
         g4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214182; x=1793818982;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
        b=rHDKmINnCE2jEETrLp838KFui2mnAb4iwMlYOCsKSp9YsNjianmfSqApXmpOhooSZE
         8e3pl34GB2tY9xS21x2C/HHVvUCkYZtF9UqgDJDkvDHngY0e+GHQUYYcIHNBjr2P36Pv
         wSXxL/FAAWxuV9vwmGdx6je8Zltv8K7/i46VMClfm7g/0dWWz/gBHvogwV/GNtAesp81
         U6GBI5sCCk11Ie90umUxJhKevKKazLiH/V+sQSjh0TEvj1VTONPGJj17sX6rxRpQPWa1
         RoR1Q3zi1mY5MuIiVrxTvL0Wq0E2p2xAqIUSKq3mFMCAxAYBokBHujb4HBbI819DxRCf
         TpeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwP3HLAtfyV+746JiOS0CrmBE0njvcKShUL0hUBUtLIeVot3cn5SN+LZ1kiKippU2JPMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkRxuBGJMejY/7cBT1fIbcn74DnmM5wwUwxb4TN98I1xcqka0Z
	IrDWs7P2PQeeUMWM0b7KRwuko7rLGOdtELBYjqlzQqBuT5WduNB7Rlcb
X-Gm-Gg: AYBFou1lFIVxqjAA4FqIGFwo0i3yQBKeAM3W/F5ZUnW6J8Q8XXmn2OoBGzVA2j19gn4
	+ZUJ/66ngXwXzssmzd3PjhjSkBhKOFTmcekdux6s4Bmm7BGO2tXyO0jvN7cmPJQ1ebl3QcW/nCg
	A8Z4447v6W0dHiT8P6h8TbsiEpfhPdDqSxgmUb2vvSiRlhSjTV0WJ6InMvr4ozPjTj85AckQM36
	+jwaLdWuceM9hjIVJEAK2mwY4ETicV70LeLn5VwrfqZk28NP9uLTIQRnNRHcpyBgcqByBt6FeV4
	x16vgUDUlKNo6rQq0bfJFjK9EJTxBwe3AbVYM0D2qKieebitaxdN0K2cUUU0eoQPNS58W6kazRu
	9g2kO9fHNDBeWLBJcREWYs0zD5kxyMdOeJNHsq7wXkVGx6pGgiAJPdt/8cV6NJj9rbUzEjbhFQ9
	gpc4k612qze4lnNgsBeqGHNwzCCKlWW5YUHVQaABDfrB7sQ+AOHh6TaFp1chqNTo0hF2G+pseFY
	lPaMXZfOUgz4PM7QBQUJRbeLEKUcZ8tpEYZ8P5Hz5J4n9pTUcdYQmMuHTayKsp0c3BwxAeICmkw
	1wEXNnX8n7as5zYUCqllL4Qa3cmpKmuEBH7XBSm8Zr+jls6tu8kAzkuomjvUPBCYieU50XDbWsn
	09BinPowDqn+ODvmXt1GWOUNM3k5ioiY4dqVO6H+eIPWYZeHLsKnvFQ7TMwLbDixgjLQe
X-Received: by 2002:a05:690c:34c9:b0:8b0:76e5:ecf0 with SMTP id 00721157ae682-8b1b59e36e3mr25394687b3.4.1793214182076;
        Wed, 28 Oct 2026 12:03:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e539e34sm33510157b3.9.2026.10.28.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:03:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:03:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
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
Message-ID: <willemdebruijn.kernel.2a72e3d2bb313@gmail.com>
In-Reply-To: <20261028122703.2093730-4-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-4-edumazet@kernel.org>
Subject: Re: [PATCH net v2 3/5] net: use eth_type_trans_careful() in
 __dev_forward_skb2()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> A tc egress BPF program can push a tiny link-layer header with
> bpf_skb_change_head() on an skb whose head is almost empty, then
> redirect it to an Ethernet device ingress. __bpf_redirect_common()
> only checks mac_header < network_header, and __dev_forward_skb2()
> crashes in eth_type_trans():
> 
>   tc filter add dev lo egress pref 1 matchall action vlan pop_eth continue
>   tc filter add dev lo egress pref 2 bpf da obj prog.o
>   # prog: bpf_skb_change_head(skb, 1, 0);
>   #       return bpf_redirect(veth1_ifindex, BPF_F_INGRESS);
>   # AF_PACKET SOCK_RAW on lo: eth / eth / 8192 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    __dev_forward_skb2 (net/core/dev.c:2507)
>    dev_forward_skb_nomtu (net/core/dev.c:2546)
>    __dev_queue_xmit (net/core/dev.c:4738 net/core/dev.c:4998)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled. This also covers other dev_forward_skb()
> users (veth, macvlan, ipvlan, netdevsim, l2tp_eth).
> 
> Update the empty_skb BPF selftest: at lwt_xmit, BPF_PROG_TEST_RUN
> strips the Ethernet header, so the "veth ETH_HLEN+1" packet is a 1-byte
> skb. Redirecting it to veth ingress used to read the Ethernet header
> past skb->tail and deliver a 1-byte frame; it is now dropped with
> NET_RX_DROP, as veth_xmit() already does at egress.
> 
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
