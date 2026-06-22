Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC532B106
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140887; cv=none; b=XNHGDqLaqGBcESRBwOxtxvxFTzxF6ErhVSPL2z+ai5lpW2UgloxUVzFVt7cjWcOVKoAbowKWYEbDPs9RroxC+OLpU51a9S9LGYqxcVRY/kzqfTg5lj/b94tBkt7wxukCeRmZnY8pORyaK7IHxKfSBRDY8jbd0PcZ6zaERLujufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140887; c=relaxed/simple;
	bh=ctkXUqINeog3YaaxNzkhEPEYeUycKQ6ka1jBb3wlaTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JE14/vemefv46ReH/opJEWaFFLHG3IZ2a09AIbpENbPZ2nbYWcxH5jSayDJYOlmk7JIcFRwYan4GVcDXtlH5pLt/OP5Pu50zAqAOKtNCpb45lC185GCem6BTkTQtMVzjB/VgQt7k/q+9JMGjiVL+tplgnjuj9o30M9qkyQ/lNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XulF3xbC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XulF3xbC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so6262190a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782140884; x=1782745684; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1beVt+7IOcgdQFGOGbC4Ll2RMfXWA8DiQT54PR4ATY=;
        b=XulF3xbCfInNtwFSHLK5pE4N/bFE3PWs7FiJelLbiDzs+jS/J1jtVj5donO9AOgX1I
         T/SbPBYpXFBSARQHmAMLZBTualJizMlGW7IIeOjTJRvhzjm2cbMSkhVR8HKWewsxjLZK
         sR7x6DNu+hmRv60gTTq3tibkHh5zIUr8YyMeVy21xr1Q/CB7LaxOLqiObl6PCvAE9CeW
         MFfD1f/FtK7N2V9ie/xJDig35N3pEdSf6Md6gzXzwFE3u0opKIb6OfQ+BXkG53sea2xh
         u+4o3DehbZV9pkZX2ksu5tbgr9+dYE5FCh3GqICzS8DNRqJxP+bFvfXKr51FHCptK68E
         vaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140884; x=1782745684;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1beVt+7IOcgdQFGOGbC4Ll2RMfXWA8DiQT54PR4ATY=;
        b=Q0ILTAxRGhp9HKAmjKMk9dfuTNUuCPPcBed72qh2tm1U/0AQ9PEta7HdiSOiU98uoT
         jZh/9+YBcv7yVhNo1rw4eqr80UzYhh605+/dgropVBk3B/h6oMyyNvd87gpJmqnJMmiW
         nV291ZMs6iEeIdiafiQqPZ+x+WkriSFWzmzamFNNZqZVQHf6CudyrvEEMjvcmTYFKWaH
         0IFLK96rFNmpcQnwgVtsuYsdon3iD2+Iogy6cfayX0foUU9n3pnv/a/O5PcXdmfBNKzG
         tXkRm99A8i7SNLKCEvHbYNeEgMh6DcqaLfFy+9Gga24cNrcn26vppN4iUf3fJnUxlkqC
         hszg==
X-Forwarded-Encrypted: i=1; AFNElJ8LPsp6Z6EZcxEVPhX6awzzURWFJm+Hf3EriOqFtywhsT/fxxPWo6sAN7U3o6buVcwwPrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdKPo6Wz+520944tIfr5dkH1dtV7zfcePJBeISUjGkUmLLhxK
	Ul+cVfAYHZTMNK9SQL673QoRgtEYXQELX5IwL6ioBDu3N6EC/dSWJMDbWqUgfbwvmq8mtA0kwJw
	vHbQtErw=
X-Gm-Gg: AfdE7cl5kWgwUCKEDH0MH1jhL1fpg6iUKtx3wO2jdoXO63CUgt0xMA+EHtPG7qyHxNy
	JENoWBZWS2N6wIkjJYx+fSy9P7NvIghjuBVo0BPzaG55ozGS6grySiaxxiDHaeo3Y17ZqXuJtAA
	6A3gar6sqiAo8duwElggGuS4cubSjfjLkbWPKkDlClmU1+OCTf9E5kh2FTZN2zNtHWWM+JWfoFu
	p04520LG7M6Nfi97iFGtWdrXb8pwZIutVKmLwQ6mT/Opdt6uCL5OzqzdabmpXefLhqI5//oZY0m
	3bEM8E41v2fd7HvuOue1UQgRFyUU3so++CvoveeqqobgDJQqpVl1NArzUGTdISkl+CezPKdAj6U
	W18HD2GEXPIRbuGUQyy2H6gwqRGUMIccecrpueaMQ/yoceXSIuHNxnZd18MmLPk5qf7Omxjr4cv
	oBdueWMXenlvdGeFA=
X-Received: by 2002:a05:6402:2346:b0:697:d3e4:4d48 with SMTP id 4fb4d7f45d1cf-697d3e44dcdmr20124a12.22.1782140884354;
        Mon, 22 Jun 2026 08:08:04 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b82fa67sm3702615a12.4.2026.06.22.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:08:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: lwtunnel: Drop skb metadata before LWT
 encapsulation
In-Reply-To: <20260620170951.580641F00A3A@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Sat, 20 Jun 2026 17:09:50
	+0000")
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
	<20260619-bpf-lwt-drop-skb-metadata-v3-1-71d6a33ab76b@cloudflare.com>
	<20260620170951.580641F00A3A@smtp.kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 22 Jun 2026 17:08:02 +0200
Message-ID: <87cxxi4nql.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 20, 2026 at 05:09 PM GMT, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calling `skb_metadata_clear(skb)` on a potentially cloned SKB modifies
> the shared `skb_shinfo` structure without exclusive access, leading to a data
> race and silent data corruption for other clones.
> --
>
> commit a6915ae09d5ba82236d77c5574df958bccb552d5
> Author: Jakub Sitnicki <jakub@cloudflare.com>
>
> net: lwtunnel: Drop skb metadata before LWT encapsulation
>
> This commit clears skb metadata before lwt encapsulation across all dispatch
> helpers. It prevents non-bpf lwt encapsulations from overwriting metadata in
> the headroom and stops bpf lwt xmit from triggering warnings due to metadata
> position during skb_data_move().
>
>> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
>> index f9d76d85d04fd..b01a395d9a966 100644
>> --- a/net/core/lwtunnel.c
>> +++ b/net/core/lwtunnel.c
>> @@ -350,6 +350,8 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
>>  	if (likely(ops && ops->output)) {
>> +		/* Encap pushes outer headers over the metadata; drop it. */
>> +		skb_metadata_clear(skb);
>
> [Severity: High]
> Does calling skb_metadata_clear() here modify the shared skb_shinfo
> structure without ensuring exclusive access?
>
> Since skb_metadata_clear() modifies skb_shinfo(skb)->meta_len, if the
> buffer is cloned (for instance, via tc mirred or multicast forwarding),
> this might cause a data race and corrupt the metadata for other clones still
> processing the packet.
>
> Should we unshare the skb first to safely modify the shared info?

For skb to have metadata we had to go throuhg ip6?_forward to get to LWT
output, so as I mentioned earlier - we don't need to unclone here
because ip6?_forward will skb_cow, which already unclones.

>
>>  		dev_xmit_recursion_inc();
>>  		ret = ops->output(net, sk, skb);
>>  		dev_xmit_recursion_dec();
>
> [ ... ]
>
>> @@ -404,6 +406,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
>>  	if (likely(ops && ops->xmit)) {
>> +		/* Encap pushes outer headers over the metadata; drop it. */
>> +		skb_metadata_clear(skb);
>
> [Severity: High]
> Could this similarly corrupt shared metadata if the buffer is cloned?

Same as above.

>
>>  		dev_xmit_recursion_inc();
>>  		ret = ops->xmit(skb);
>>  		dev_xmit_recursion_dec();
>
> [ ... ]
>
>> @@ -455,6 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
>>  	rcu_read_lock();
>>  	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
>>  	if (likely(ops && ops->input)) {
>> +		/* Encap pushes outer headers over the metadata; drop it. */
>> +		skb_metadata_clear(skb);
>
> [Severity: High]
> Could this also lead to a data race by modifying skb_shinfo on a potentially
> shared buffer before handing it to ops->input()?

This is valid. For encaps which use LWT input, we need to unclone, as
this happens before ip6?_forward.

>
>>  		dev_xmit_recursion_inc();
>>  		ret = ops->input(skb);
>>  		dev_xmit_recursion_dec();
