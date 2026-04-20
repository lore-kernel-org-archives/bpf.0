Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3339936E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710220; cv=none; b=BnCPlC8/DH63AGnzO9tJesNDPLrfaqwNHG3ZhEJefKSlNb/M3zrL3sJBXo840STX+LoI5F/L4TY1oerVjHbvCL2YJnP5ubjuzNSD0H3sD78Kf7/zMTUXc9CsKsrHM/GNZyZJrcR8n6xxWv/FUMaGprjSb1v2EbcXHcR78jGjxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710220; c=relaxed/simple;
	bh=CBBSoO9kTtLxzHRoa4Ab9jE/HH2VINcAEfP4EjjDQPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQUi28tSgG9xQ+SgovIsoa8lC2dXgATGMQiMSQUmkR7oWVmJMRRYlSz/42HVSfVLllq4q5iljfms5Jt3i9QzUTSGDZddjfgIL6RaHK6N9q3O2rB/6geDwr6vitYctkOVS/xbqGTWwOGuffp++2FIvYp0PJcIunY805739orjSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8w5mWsX; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8w5mWsX"
Date: Mon, 20 Apr 2026 11:36:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776710206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iemELGgB+ZL7KFZ21IfvD3tE3IwlqkufHa9FGi9Rq/M=;
	b=s8w5mWsXpYVJTyMrsqnwl8ny9bR1qXKZP1Xko919KsJfHehzySLyRqSagj1FqR1i1bJ4Fo
	W+0G1U8N3BLH87E7/lWwOuT+TnTS0Z6jiMCVy35G6RvR4/Up7BAEPFA56KxNC7n1KA6Jdm
	NgcFF4IfncuuMPWPreMgGoA9nss3cnI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Message-ID: <2026420182243.zAiN.martin.lau@linux.dev>
References: <20260420161432.3919396-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420161432.3919396-2-bestswngs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 09:14:33AM -0700, Weiming Shi wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index f8338acebf077..3b487280f50fa 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  		struct bpf_map *map;
>  
>  		smap = rcu_dereference(SDATA(selem)->smap);
> -		if (!(smap->map.map_flags & BPF_F_CLONE))
> +		if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
>  			continue;
>  
>  		/* Note that for lockless listeners adding new element
> @@ -547,6 +547,8 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>  		return -EMSGSIZE;
>  
>  	smap = rcu_dereference(sdata->smap);
> +	if (!smap)
> +		goto errout;

You need to study it more thoroughly and the code around it
instead of rushing to fix a problem discovered by AI/bot (?).

This is now treated as an -EMSGSIZE error by diag_get().

>  	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
>  		goto errout;
>  
> @@ -599,6 +601,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
>  	saved_len = skb->len;
>  	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>  		smap = rcu_dereference(SDATA(selem)->smap);
> +		if (!smap)
> +			continue;
>  		diag_size += nla_value_size(smap->map.value_size);
>  
>  		if (nla_stgs && diag_get(SDATA(selem), skb))

... and here it will eventually return an -EMSGSIZE to the user space
which is incorrect. Pass the smap to diag_get instead.

pw-bot: cr
