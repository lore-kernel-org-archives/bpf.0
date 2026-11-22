Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357310;
	b=p9dPyyP4VZ1tCQXgZgxpdugejYiWQonrIhAEe2Tf1JwhYUhmJ1eVCbJHlszOmnbajCG6
	 gJBt6zvQrzt19BsRk2+V8Tb8mVdCZMmo8sd7lZO7U1a4tkCOPLAp92lnbtUMHhoFHS8O6
	 muuvF4P8sdEbBNpjXTNc2sZHREU0bUfMEW2OZkOi11+xAZ2FOrjNhIGZ+P+oNh/OzMG5p
	 X7/kZ5sh3MFXk7G8CX8pTQSQGWOLcrCEpjjlzEL5g1oQrW89dOvuLle1iEFkhrxZE3mj2
	 TKIHr3HWExUcWTsDBZ1orunMdF5l7/1nkeQOtEOJXLK27Ddi6s1qE3V34l4TCXv0WaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yPwxyZPCJRkoA2qMW2RTyJ99dfsqAAIzG4plyK1oUEo=;
	b=hmhez+8UxFnQuvCPvtpbihG3RsDLY1k0POlGIYNB71ols1r32NDhSsCrN3RoWGmcxUTa
	 5SdAnkhQDgU6RTPk//3SR/B1+wPZBOuUhQSLKEN0N7/SDJb7x5OM3yEkvb8uFaW6ZYw/+
	 Ulm7XHxGlvUK0QFMrjEEbO/ufhOd+lodrx8Okxvfgh2jEMmwRybunsQ4mHyq/NAuTjDE/
	 HVSIRKtWFMRccF7Gg75GHVE5hMbCVBaVpb5v7r8ncmAuElGW5f6dS244g2KLX5JpvuNOx
	 jjKwGFVdHDFYxU32P6Yk7K4MFuIxAm4X8AtGg5ko5TMSOqqYh2WxKvTRx6ICpoRT4LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Kg+AEzwj;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877C606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 14:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7877C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Kg+AEzwj
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so16292485e9.2
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795357308; x=1795962108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yPwxyZPCJRkoA2qMW2RTyJ99dfsqAAIzG4plyK1oUEo=;
        b=Kg+AEzwji6EMm0ZnkcmjqMVQO8GFnoZn6i7E2sQ89lOeGDHc1YWGlGV3F72W3WM4Gt
         ApWbvgBoIylVhyIGF22uEt0eTSveyHEmOEHBnQpw5yYfee5WAUmj8tDFvUhf01v/vlzh
         bOxiFpsaHIdxx7PTIWsrDvxbnI59ISQjE/8WdfBKcmQg6m/LNIVKS6scrwA0eKM5/NlS
         xootH3O54xz30xCDBRGh/3BImi/22PVXThG27C7QycZ2MhsbKNb2OML0MiJNVoc+IeV+
         iskAIN6YYAegACi6rsY7/8/4CyZHQE2Vst8QLtX4GQStVeUgpl3QkKow9gxUFKUob9x6
         iETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795357308; x=1795962108;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPwxyZPCJRkoA2qMW2RTyJ99dfsqAAIzG4plyK1oUEo=;
        b=TMDDs3RdWmX7hf04YUYyQd5JbV2Jh2PwDACTduMLV9SlKCkiWm0DEJDxXiw44Yd/1E
         /gZpUOlacXmREYBeaMjeidYUNfwLkuMuN/+5NK2aw/P+6vUP2b0xWr5JvExgpICNhUNs
         8YCJEmHo5JMy0Efk/GJxAwyGrzcx3beE0cRxO0cgrNebwiUcEDx9V9LH9O7RYwvR0mg3
         s4wmPCw8Sl2cWEx1mwQZFlvXxODmiJVOq4hH7D/51YSMEJEZsTs/MoYFvd3/o/kHyDiP
         O1U3YgHTZ1osdIG3VZD+EBIpfPasNfkh+Ta1f/wxaDdlaSXT0hRxt2YFxl1iHRnRnYH3
         KCYg==
X-Forwarded-Encrypted: i=1; AL+hErE8JiPnrRFwjcQAwi3wtrRfb1NmgckLSf8YrGHRViemEz3F3ZBrAgnpHl/hYSoz+5wRv1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z99nqAC8RxzdR40bGXC6N7+Ckmb0wf9JKFhwGM1PKGW2/WfdEEc
	K47sGLgr5PhOuuDIsew8Rl2Yzw8F6ENKNow+oDuxA93d3gwq1uwidsKhkC3hed//ni8=
X-Gm-Gg: AZFdTZdcppYMJl980WRo8O6GPIavKcUiChW51qPJ0kL7/n3vBjVuW/Qy3cQMqJuzq6t
	R5/wPXuJwvCaay9W8e/+STozaYSmxE/JyaGoqIJidvWjR4Cv6kP+eZENtrLMRfdhfvspyWpKrAi
	H7RG/q23X3upvjep0DJ2WEoCRoCCjSpqVgfQk2MYVhnROescgu53L9T9LjFFGo4AVUvdgMnpFL+
	9EUV3uSG0S36QN97E2tIvCTRuIwPK1CZn6kXBb6PnF/bEIxeQqLIuOhyw4eWFERrDS/2lzMYQ0C
	aF13KBg7fCipKlksCA97cTsFw9byWxm2O4FdtwVn+xZGE9dWnZPy2/OHXFIIV2Kx/eNnt3X5MrL
	QfCAJtnX901Jw9unDGE48rHer1WVyI2HX9+BGPXXySZYqLepLAFgxJmj4d7eOubr4vd26j5Y8p6
	dyWZsHymeWo6B3OssgzxDsbo/mhWS3BZQCoxdxz2mbQWLbGwegSylU+uFG5CkRU5WmQF6Mteewi
	OApxlYG+44HWwdMWT1oKIbeAAecPuFIAoLv2wdOIDZHjHX0NEqijwarZjr542I4GRpQogmnt1pC
	kW58kJeoQd+mTkGb4we3CC9rrtwkhiBhNnEQbmHwxEyX4MpiwKR/5csWlyk=
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr123249665e9.26.1795357307361;
        Sun, 22 Nov 2026 06:21:47 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm109767805e9.3.2026.11.22.06.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 06:21:46 -0800 (PST)
Message-ID: <c953972c-dc7e-4b97-b271-5137f0cb2cbc@blackwall.org>
Date: Sun, 22 Nov 2026 16:21:45 +0200
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
Subject: Re: [PATCH net] net: keep skbs with a prefetched socket out of
 gro_cells gro
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Joe Stringer <joe@wand.net.nz>, Daniel Borkmann <daniel@iogearbox.net>,
 bpf@vger.kernel.org
References: <20261121160204.4024204-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261121160204.4024204-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2026 18:02, Nikolay Aleksandrov wrote:
> bpf_sk_assign at tc ingress holds a reference on a socket that is not
> rcu freed, such as an established tcp socket, until the receive path
> steals it. ip_rcv_core keeps a prefetched socket so when the assigned
> packet is an ipip, gre or esp packet the socket stays attached after
> decap and their rx paths pass the skb to gro_cells_receive. GRO merges
> skbs with the same skb->sk into one flow and clears skb->sk and
> skb->destructor of each merged skb without calling the destructor so
> every merged skb leaks a socket ref.
> 
> Send skbs with a prefetched socket to netif_rx instead as
> gro_cells_receive already does for cloned skbs, where each skb is
> consumed on its own and no reference is lost.
> 
> skb_sk_is_prefetched tests skb->destructor which shares a cache line
> with skb->cloned that is read just before so the common case adds a single
> cheap test.
> 
> Reproduced with a tcx ingress program on a veth in a receiver netns with
> an ipip tunnel which assigns an established tcp socket to ipip packets.
> The sender sends 32 tcp segments of one flow inside ipip through a netem
> slot qdisc so they are decapsulated in one batch and merged by gro.
> Then the socket is closed and the receiver netns is deleted. The leaked
> socket holds a ref on the netns so it is never torn down and its devices
> are never unregistered:
> 
> Before:
>    bpf_sk_assign() calls 32, sk_refcnt 32 after the burst
>    receiver netns deleted, 30s later its veth peer still exists
> 
> After:
>    bpf_sk_assign() calls 32, sk_refcnt 1 after the burst
>    receiver netns deleted, its veth peer is gone
> 
> The problem was found during reviews of patches that add bpf_sk_assign
> egress support.
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@kernel.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Simon Horman <horms@kernel.org>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Martin KaFai Lau <kafai@fb.com>
> CC: Joe Stringer <joe@wand.net.nz>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: bpf@vger.kernel.org
> 
>   net/core/gro_cells.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

TBH it can be applied to next, this is an old problem ("never worked") that is
a corner case found by LLM reviews of a patch-set, which would make it easier to
reach. I've tested it with net-next as well.

Cheers,
  Nik

