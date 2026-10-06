Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E238D01B
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324427; cv=none; b=oc2+pfBV/1zc3dt23zWDiKV7kNAX2vwZsr5otxJ2sQLijlh0/+4QKwWeVN2lGCv1xopF16aNqXXWRuAfq+KGx/WbzSxI64xYHHEX0lRN//TJ94X9dQMZPr0lIPnIzKNctO2OldsfqmQsW4p1BNgHN6R85hzZX5xQi9KpgVaKv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324427; c=relaxed/simple;
	bh=HGjsZAU0u3T+R+pmEpAdBboZTClKw4LRBl+JSrIfAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm/eTkMErFjK1lvk9DCq+Ty9ZiCBb4PJkuPWmiZ93FrQaliqXczlqF6T3cY/75v3c3khfiWtObtVuj8YHrJQIsgeApgIUoeydWtRJL9JJOW2oc1QRSj6epoD1n7wsjMnhmEClS9iuHX4sll9yj5H+FTQVMonK/JidHg37ePq28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWw7S8xb; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWw7S8xb"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so808221a91.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324425; x=1791929225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/9sCqmiCuwJy19MJh5mPirhI4g3R7MXdiP97jppmAM=;
        b=VWw7S8xbk0ElNWroTAz7qYdqBVaRztRrqEiVcQHz3Ngv8wdfrjSdvq5Zi0OXWHxcyg
         iTz7aQK2k/f9DAw5++bTE3ZsiPUJYAZx7vkklaiPWaXe4XmpmVuQGKQs95JmRmnLsDOI
         V7P/D0aievFYm4Hmw3VDISWxvvYECPGxfBRzTTnIpTcO8Vk759ZhithyJ4oROnFHRQyd
         KP70l2bVSVnUEe51p+Nbqz11mGZrvEOWFOp+ShGSjivuTM6SBmv5FN+pKW6vmL0sWRvQ
         8a1+e1PUEwHAkEauHbu8G+oE+nEteHZTA8K2tHB1Omf2jmqPvR6JCS7PaGlNAON52lUj
         lnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324425; x=1791929225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/9sCqmiCuwJy19MJh5mPirhI4g3R7MXdiP97jppmAM=;
        b=LXohKDcpLmDIziGcPh8JLip/8TQ5NXgG8wmNBoxOAL6iCi9/OMMAaOhPPnD0is7q4f
         AMuIOag24orTCTSydXmD2zsXyzG9woMyAbKvOG/fn6O76hm22qCGOUHJ1AVReU/epWKB
         N2oz4xraebLwsvy0mYrAzElQZ6WPgqRLYZ+O23a4m0ORDlY3jd1pw8PNiFrLVxmBtJNb
         b94tukfkRRUtEs+WekgTdw+Gfg0F1LW0m5KfNcxoqS+Bq36btjdLIOD5w23iEZIB14mn
         LLHYn+kBv68zMmpIcm8a6RdVgVkyLRAui+okljuKB9tQxmhZSPRePD54G8S95led1jOE
         /n/A==
X-Forwarded-Encrypted: i=1; AKwUvBwknv35XzBvIb/TTeBZ7eSkr7gIPcel027uIg9XWY0mHCd4LjVkC0hiqwG9DnHRsKk+9aU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA/vwLiLkY6ifSUUFENLcxN+8RVOOHt/fOcis5crXAeuXgyH2m
	pLuUCNwOsCWBdonhGU049KDizjJpVzZ2LEuasMsVAXME4CTX6yF97rzG
X-Gm-Gg: AYBFou1+NohgJW77LeoghxAhew5ReUMbbG9/Ir6heZtaScZfZwpix0LuQowXFbawiCO
	H6PY0EzbiBZpLK7wOo02DTTJxdt/cJ931X/wmSROUq9vvJxz38mgkAcvl0jzHi886pDQDzazIDA
	U849QJfwToo6r3PvzIPEYZDEjTso6LF5JDfQ5QvRIsd8XSHZAJfqaUfurd+b/gDyc5fguqtF+zZ
	mjbEyTPfHXmQU6xP2KkXNQIjJUIB92azek8SpF8afnQ2Mwr7sCgqOF83pDVPsGxwqGaXbTwuWNM
	DAt0Qi2hephOpoKN8IcqjxnQ1PIkwPdD5STmyry1fWHkAnDK/l4bPcP6A6FzifTHzxqYk/yyAqV
	7i6OMm1UVoVLx4wPVn55Lft7g5h31du5GQNn9F+1VYQXDxYEkjCN2RXdzK0IV5DPNch94FbvVWP
	IZNJqvRRivNFT06kBy8WFMinZOr2lKV5PF1B1iNw1zmr5XU0upQLdcVVKgEDNiAZ4=
X-Received: by 2002:a17:90b:48c7:b0:3a7:971:7470 with SMTP id 98e67ed59e1d1-3a8a11b47a9mr327829a91.47.1791324425530;
        Tue, 06 Oct 2026 15:07:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm191415a91.2.2026.10.06.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:05 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:04:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 02/10] bpf: tcp: Add a new per-socket flag
 and kfunc for bpf_tcp_ops.
Message-ID: <asVwahjG9bguiIf2@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-3-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
> 
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
> 
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
> 
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
> 
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
> 
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
> 
> Both helpers only overwrite the field, which leads to reading and
> modifying the flags in the BPF prog and then writing them back
> via the helper.  This prevents use from the fast path (tc or
> cgroup_skb) hooks where bh_lock_sock() alone cannot prevent races
> with process context.
> 
> Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
> tcp_sock_read_txrx cacheline group, along with a new kfunc,
> bpf_tcp_ops_set_flags().
> 
> bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
> disable and updates tp->bpf_tcp_ops_flags atomically via
> try_cmpxchg() without relying on lock_sock().
> 
> The kfunc is exposed to bpf_tcp_ops, BPF_PROG_TYPE_CGROUP_SOCKOPT,
> and BPF_PROG_TYPE_CGROUP_SKB.
> 
> The first argument is struct tcp_sock * so that bpf_tcp_sock() etc
> is required for cgroup hooks, but not for bpf_tcp_ops where struct
> sock * is promoted to struct tcp_sock * automatically.
> 
> The fast-path callbacks will be guarded by the new flags in a later
> patch after updating the existing selftest to avoid breaking bisection.
> 
> Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
