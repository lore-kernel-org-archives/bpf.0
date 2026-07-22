Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0946369D54
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743237; cv=none; b=igxiaD1j/ihlYsCUV12diGz1/tePKzFbN10a5kBa7fsBLlwpxeXkxbAF9aMbGcPMrmd2P/4Nna+fM5a1NQ2P5PeUi2TntRpwx+vQMvSDh0wc45bS2/VFtaD7zFHaNOPX6WxWhBpdvJDMOY+v1kLNY+AFak3BVbZdwArUtBjp3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743237; c=relaxed/simple;
	bh=Vm9pdnoQiEjS5jrO+VcZAmAh4KLL2aDUZZ2ez/tDOZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfjqDM7mDrgmDZ91CgNC/PEHYaBKwnsxa9F0aGtTPcUP6ANLKoEqDe0f9gPX6+9UIMJtA315b6apmtnMQXLglt002PdRIHPfDCZ32aAH+23nVlLqSHaG8jbgVq+wx+yw5Qa7YWUqpFLnNkpaWNTRV6StNWfTzgk6hhfVwR6kUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOvIcX3K; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOvIcX3K"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so7882903a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743235; x=1785348035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HnNlfSj3fIGtu585qe6eLWjGneo6zvxtz8A2jHYq8n0=;
        b=KOvIcX3Ki/9DH/Q+5M2g+Sn5rSwVtABWmBNsDuFWR0iN8/nAaKDq1BIVv+5v2kctGs
         QnaOKR6zj/PJMwdhPNjmaUEJLPvyigqHaG48exG2TfywbyG7wuXNvSlJlQ5RMd4CPRqG
         Sd1lgzPEP5trV5+qGfahIqOenKW+OAXMxHEWGpJJiyfFi8a+hnR6sBNl/LJdXPWhBP3b
         /Nw5J1LIyBArYTTVINrTlXaeIJKIUi9ErdnjxwBKsxf4Y3ptGISvdSGF3QdIkeaLsH7h
         7pPLxyM6t4uXy8cTP0QvoNCjtHZUzdcP/bzvrxpIvIeWsCTgPEaPV5Dr1Haz5hTM9v4/
         pasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743235; x=1785348035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnNlfSj3fIGtu585qe6eLWjGneo6zvxtz8A2jHYq8n0=;
        b=Rzu1Wh0LlF59id2iGMHhKnfteKYG21qDWK1PlTx/491CHznUchJf68qv98+R0FFCPJ
         ytm+VF8q6RdcuoWl4tAY3l0m7ZBls8I14VUVC+nlK802aUEGa3xKZnpVN/FG9vFOpHAg
         A2IPDLNjPj4ov0VBqosnK+yhk0vKfrD+PgPo/AlFTOwNePTblBs5syMWdk/5MS8RMjx3
         NL0luqSw05xk8oSGNpHvYnRZgNSfn/btiqUvTFVlvnDiUCNfEahYLE5wrUUg5NBfwlMP
         iVPdAKXp1tRkE9EI0mvlqLJxpXC2anPZGZV/d726y1+Oq4KB+yRW1jxintIrUwgh5ftj
         wLMQ==
X-Forwarded-Encrypted: i=1; AHgh+RovIdNN6SqE7+JLc7bTUtgaphHOPzcEWVDrfwnKgUUcRkxwf2fwIHThs3JXjtNLCaYbIpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkVpuCNFeyVczq6LC5d10i8a62J22cWrYMWW7UpgVle7AUbKs
	elZJgV3t95VyyBpC6WwwK2jv57qXGRF0/gPh0vFq41oGBZgA8Z6HoQKe
X-Gm-Gg: AR+sD10to3tpe3LQTIaYQqy7KI/7ZR71LCD0CLFQZ5Bf7QEY+kRkYYnAXB8mUyR4GRn
	cvalHGLdh3FIZo19bPmkc7VQxfLHQaEvqClAfx5j8J9CqHcVivWgL5zljh6QkDgNTXnYWud8lNk
	GJ3FactQmK94LwLigVrZQk3xLXoB0Kj/o6om+kfQBnTDSG5Q72b/uHtmvbMu+1ckPJG1zgBLlhQ
	0+agq/AY9zI36KZM1R5Yih6Fw8yTFTeFX+SidB65O88NdzIv+/0BHx0QnkzL5MYDSudhf4qTFsq
	m+2S3XEe3jW55ixQpGWO1j6EMdqjj0W5rcveYk3BqgkJAD3oQ/b25lafjk9Tz2M9Xlb6CQ/RoF1
	Wf58tikNqqdNImX46DmAsyz15MF68iGf0E+Mjmf64B+3op88W3WbR11mTz+Ex+pqPmRtRQQ==
X-Received: by 2002:aa7:8744:0:b0:84e:89a:b8ed with SMTP id d2e1a72fcca58-84e089ab9d8mr6443533b3a.70.1784743234973;
        Wed, 22 Jul 2026 11:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17266107sm1750442b3a.17.2026.07.22.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:00:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:00:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Message-ID: <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
 <20260721183256.6f49d6e1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721183256.6f49d6e1@kernel.org>

On 07/21, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 16:03:37 -0700 Stanislav Fomichev wrote:
> > > > For unnecessary, I think the safe expectation is that the bpf program
> > > > will update the value of the checksum in the packet if it touches the data?  
> > > 
> > > Documenting as expected behavior which no driver currently follows 
> > > is a bit silly. I thought the ask was to sketch out the plan of
> > > explicitly updating/invalidating the checksum even if we don't
> > > implement it today?  
> > 
> > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > prog has to maintain in-packet checksum if it changes the payload. I think
> > it's a fair assumption?
> 
> What about decap? If we decap the header that device validated 
> as UNNECESSARY there's no possibility of maintaining the checksum
> (by which IIUC you mean correcting it in along the payload changes).
> 
> I think we'd need some API to "decrement the csum level" ?
> Or some heuristic in the drivers to decrement if the head moved
> by at least len(IP+UDP) into the packet ?

True :-/ I guess one more case to document?

> > In terms of documentation, here is what I have on my side, lmk if that makes
> > sense, roughly:
> > 
> > - TODAY
> >   - some drivers (correctly) disable reporting COMPLETE when XDP is attached
> >     - the xdp program has to modify the packet checksum value if it
> >       changes the payload
> >   - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
> >     needs to be fixed
> >     - updating the payload doesn't update skb->csum, so the safest
> >       option right now is to only do UNNECESSARY with xdp for all drivers
> 
> Yes, that sounds fair.
> 
> >   - the hw test needs to make sure that the csum is either
> >     NONE or UNNECESSARY, and will error out on COMPLETE
> 
> Driver can report COMPLETE to XDP, just not to the stack.
> I think we can use a tracepoint (bpftrace) or attach in TCP
> to check the skb state?

No strong opinion on this, it seems easier to report the same to both
xdp and bpf (at least initially)
