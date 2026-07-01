Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AD1CAA65
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946706; cv=none; b=jdZ/Qbd8szUDmjqXpkEfm5Ljah98elhudkT/dsCki2Dhp2B9lsISylGk7xNiYgtI8mXnD+6T88pQZ5qWRIvRb0JM+Le0/IdtTkdP6jncxc6WjM5qZZhcNSOkHG6IEHTgZsYct1NyrmmAhBeP5/n+F/JY4CdMM24P1nJdrsEkjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946706; c=relaxed/simple;
	bh=bUDYuKYHtQmgldv9vVNnWK4B+5v8BcuM1LLff3DuZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3s8166iMFc2JEbhSSMUAboSbuPNt79sKOPG2YcxLDtxslYSj5L/pU9v0QBDHpZpnBrVZCHSHXpWXywfr8zeCykAT9pIYVI5ZAqFVa+hhglFQNNxs2D36aXx6jxgY05AkwpfndgdlKbc2iVQx6JEsdwU0fJHNGe7PUFHKiFZ0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQqIlGJt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQqIlGJt"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b9d265355so751706a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946704; x=1783551504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=De8XTkFmbzVQpV87okqkWkxOfLzf9SREnezKw2Sjhrg=;
        b=SQqIlGJthVps4kpcXuJohYjaxqycopvRMH7wj9DiKy3M6ecJlTFGL4UVHli+m5dRnc
         rHgxN6t2haIZ0s8KCoCekno5luVipsv+3btqnvLB27D10Y/cSJq8oRHPJ8Ibtz2has9S
         nobFW6SNmtdpvlsj8/W2yMc1jDZA6e5ON8YRZ+eJZ0k/mo/grZPvAOfwsolRbCLk+fM6
         19qLcebM0x+VPKDHXNDTfCxQphCCwix94c8LaymJ7ZharYYjJh/NcccAxugq67yxHP7v
         GZcC4yBoz1fFgyFS2VrGwS3yO5mSUvL7wPqAn6s/MzHmteKxuKZfhtqSH+WyWIxmuI5b
         zP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946704; x=1783551504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=De8XTkFmbzVQpV87okqkWkxOfLzf9SREnezKw2Sjhrg=;
        b=Z+s/lSTqlB5Cvt+wKV7Z2E3Ok0CJjdL3lvbJSxmXw/NAi0jP6OIjc6I/yomInWBgzd
         HkKhncihdO6s2c5Ol45Qh4vl0VTEVLaLGdAkcEdpudM9Wc7YZsP+IhbwHakwV61/y83Z
         lFWlsBK/IGI9JRaoiiFKV4OmMWUQDFYLhf1DWsfixlDvE+PoN+auYdPv6PO8+kXvC0S3
         w7fFAqiNJfaM6lP0KKVRH8rqPDcclW7yEiWLg6H2SIJIeSCCCahkMp3HgA8yWbh0Pt+k
         jChmmAOgcxn1CHREIyrfL7lPisHTR+RAejjvdxsAaZVxO5Iv1r/nbFXuIsGbTDE22/vu
         WpBw==
X-Forwarded-Encrypted: i=1; AHgh+RowGWHJ9XyL3aXStq8Ponw2ElOVOe91JjEywnn1oEyL3KmUbPXMofMquWWV3I5YEHiqHrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz692B1FgNygSZwQ8xQj31Z+bpJbRi8nxW1F39MXcW61qOVrrl+
	4vNW+wzu8orx1fqEs9p65iJarOT4QFsd+CKLZNt4xteGqCIgEImCIFV2
X-Gm-Gg: AfdE7cnLZCE3emLl+uDiJPXvyOgMvounPX/sldDByR+y1zYujqoIDlxjlRdtx3Ixw6H
	UzPLXgCBcwRRQftd/F9jaJ5uiurslLlJtIib8llV8dzvns6b5iY95sm4oTNyLKJSKSXiXKdB1eQ
	uQecMz7OBHZ2v7XJkkR3wofHicLz/wJ9jPTaXr6u1XehXy8oibGTVmMKI7LB7kbH0W1m3LWHgmo
	g4vk1gdfwx1EESPOxDKCWxk5VPbAlJHGK3jcXtZUKvkgprXZpOcy1TEMz88M6U6A0I7ij7WahSo
	nR8PDlhRACGR2YOVjoYWvzD2Jx/D+seJGjFRz4pvXDCJAFuO1C01JizjecUCLTvSKLe23m9xIQG
	yftWVPzqWFh6lmYnXjiGXTleiEDVsUKAiB2DISywTkUVM2yCGDk1g3GHPbf++KLdwmZAC+BE/xe
	Fuyy7RyqCtvg==
X-Received: by 2002:a17:90b:180e:b0:37f:ff9d:ad69 with SMTP id 98e67ed59e1d1-380ba80c706mr2735930a91.7.1782946703866;
        Wed, 01 Jul 2026 15:58:23 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380def494c5sm99877a91.15.2026.07.01.15.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:58:23 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:58:21 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Michal Luczaj <mhal@rbox.co>, sashiko-reviews@lists.linux.dev, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Message-ID: <akWbSP5aMxLYSmM8@john-p8>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
 <20260626205814.BAC3C1F000E9@smtp.kernel.org>
 <e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
 <87v7b137cx.fsf@cloudflare.com>
 <26ecbce0-48ad-4b53-a0b7-34b59870e010@rbox.co>
 <87echn2fhd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87echn2fhd.fsf@cloudflare.com>

On Wed, Jul 01, 2026 at 12:04:14PM +0200, Jakub Sitnicki wrote:
>On Mon, Jun 29, 2026 at 11:40 PM +02, Michal Luczaj wrote:
>> On 6/29/26 13:37, Jakub Sitnicki wrote:
>>> On Sun, Jun 28, 2026 at 11:59 PM +02, Michal Luczaj wrote:
>>>> On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
>>>>> [Severity: High]
>>>>> Could a memory ordering regression here allow unbound UDP sockets to still
>>>>> bypass this check?
>>>>>
>>>>> In udp_v4_get_port(), the flag and hash are set:
>>>>>
>>>>> net/ipv4/udp.c:udp_v4_get_port() {
>>>>>     ...
>>>>>     sock_set_flag(sk, SOCK_RCU_FREE);
>>>>>     sk_add_node_rcu(sk, &hslot->head);
>>>>>     ...
>>>>> }
>>>>>
>>>>> Because these stores lack a memory barrier between them, could sk_hashed(sk)
>>>>> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
>>>>> the leak to still trigger?
>>>>
>>>> I'd like to verify it on a weakly-ordered CPU; please give me a day or two.
>>>
>>> False positive, IMO.
>>> Both ->get_port and sock_map_sk_state_allowed run with sk_lock held.
>>
>> What about an update coming from iter/task_file? You get an unlocked socket
>> via bpf_sock_from_file(ctx->file). And sock_map_update_elem()'s
>> bh_lock_sock(sk) doesn't care if socket is owned.
>
>You're right. No exclusive access to socket there.
>
>I think we should block map updates from all iterators but iter/sockmap,
>where we know the socket is already in the correct state.
>
>This is in the spirit of the API lockdown that is in progress [1]

+1 lock this down to just iter/sockmap allowing these updates from
arbitrary context is too hard to reason about.
