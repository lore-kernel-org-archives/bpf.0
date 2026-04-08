Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45071E5724
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672018; cv=none; b=mO66/aKIbx21X53lm4nltwZj8/jfYgc9MaSXfdDDbiTHPs+gaJZ852TI3YLJDtEEEiktEifkB0GGPxNdYmEuK1PKbpyPO4bTZMIe0sVWeOdsXKYdybEMZ45CPZUcc+ZxoxJfYDpzXtykUQF0eBHf/msvvPrXysroJBvUArODmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672018; c=relaxed/simple;
	bh=eERDK8MrgRVFpt8EPs6mScv+NPAcz47BRTMWRwRaxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TETtTALvFAWUTwRa+o9P7XUrEIpFh0G0HHTP7xlktm7OjbFZm3hEcj/e5vD6Q890sYM8AS4j4xXufVN9Px0MZ96xmR5tVbGnNDMZEVrynO4SIGN39jpQ+5227oVjRdFIPRRF6LbPw/lWueRnAFj+tCBrsUqWUviL/dg1fPZoUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fpqPtzxi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fpqPtzxi"
Date: Wed, 8 Apr 2026 11:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775672003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvj5h4HHK3avmY1kaN9kSeAcx7M966IB/bsppq/wjeY=;
	b=fpqPtzxiBAcO1LzeEqfVrmmPD1WZRWqf1D0cXahjB9nqdlirSLXRI2Ys4YaAnqzXLbr1Th
	0h+Lzl0ZfAXzRyZDCXh4brASljnAAp1N0LGKGI61+84B+R3Q1hg+onnZ2O91Tz+baLn1UD
	XqGfeuybvA2UDxCObG5jwffCDo3sm8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, martin.lau@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb
 when wait_for_space occurs
Message-ID: <20264818422.Ya8u.martin.lau@linux.dev>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com>
 <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
 <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.257654f9a3f23@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 08, 2026 at 11:15:09AM -0400, Willem de Bruijn wrote:
> > Avoiding adding a new one makes the whole work extremely hard. I'm
> > wondering since we have hwtstamp in shared info, why not add a
> > software one for timestamping use? Then, we would support more
> > different protocols in more different stages in a finer grain, which
> > is a big coarse picture in my mind.
> 
> I don't understand the need to store more data in the skb for BPF.

Adding a field specific to bpf timestamping is not scalable.
There will always be other bpf use cases that need to store
something in a skb.

There have been discussions about storing metadata for a skb which should
solve the general bpf use cases.

https://msgid.link/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com/
https://msgid.link/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com/

> 
> With BPF hooks, the bpf program can record the relevant data directly
> in a BPF map.
