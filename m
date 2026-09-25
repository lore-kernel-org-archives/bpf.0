Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C94D37BD;
	Fri, 25 Sep 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367610; cv=none; b=uW9Vz404ReEt/tmx47I3JPqspvkINisnv3oJEFTpvktipVZwt5ndn3u5iO53F1DqpSwLBIIFVl0/IxY+kV2kQRw/FSS+sxaG/kjVpvmR+2b/lFalUh11OFq9NU8EOlT02/4e79qFWmnF3cIt2AlLNYKwSRB8M5eRIcFKvzojzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367610; c=relaxed/simple;
	bh=m+7Mgtti+1oT1QvcuKxKgB2E7C2Ve9mSqhH35y2bsqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1SfvA+k2l9ADhsVPUw7vqXrTpWie5RmZ19EY7PSTx6wrSGWEUVlpXKqaX7UJSS+f2tLR/hq/O+TMVp2OaLtr2Mo4JMm8QW3WpDfkhbMTYTbKlklwtLQW06AZ7+pjWYCG92ISj6j5ALFuFf1EAfzZnZIeczwkW4mc1tWAfCx8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHLvY7EE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHLvY7EE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE31F000FF;
	Fri, 25 Sep 2026 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367606;
	bh=pz6qXX2KXJ5Uccw7ZdzEtnK41nDtZlA8dbdJlqwpi2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gHLvY7EEY06/8zhEyvDsXAOJWRPTDkh7ZQEAsv6a7DjHOG97UEStJ+i3Pb5+7aWVM
	 pzFB4Vm7/dIzwaUuijGncdFeNyy1oUcMd12RQEmPTK5yIplsT/MZcLD95aW3VqrbZb
	 ssey849clIFV6iSW1CPH23soJ6OpBO8C4w5NVnJLvzcUbSI2/TQMxupywcniby2ln7
	 XPVSwX5wnLjAjFXSRA/oJgKfPuLRr687VjfCpLhRJsj7Y9DSpcNBUySm/0eoOD09BN
	 iktZtXn+fJkIISIjrpsXaIQylZ1ll5cRLKUsmPrX8eTPmuYuJYSX2/TZ5pHZbDOG5T
	 amg23+940jmsw==
Date: Fri, 25 Sep 2026 13:20:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
Message-ID: <20260925132004.171b751e@kernel.org>
In-Reply-To: <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com>
	<87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 19:51:37 +0000 Alexei Starovoitov wrote:
> On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > Instead of improving the existing infra we're adding more BPF-specific
> > glue and another bit to the skb. Matter of perspective I suppose :/  
> 
> skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
> the last bit of u8 active_extensions.
> skbuff_ext_cache object is sized for all ids, so it also grows by
> BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.
> 
> As I said earlier skb_ext is fine from bpf pov. If it can be made as
> cheap as bit + tracepoint I don't mind it at all.
> Which part of skb_ext would you improve?

Mostly allocation speed. Either a small per-CPU cache like we have
for skbs or let the scalar matadata fields live inside the skb.

That said, the selective tracing approach is also tempting.
It'd be great if we could have that for sockets.
Could we possibly think of a way to build that into tracepoints
instead of having the open coded

obj_maybe_trace_bla()
{
	if (obj->trace)
		trace_bla();
}

Having both:

	skb_maybe_trace_free(skb, SKB_CONSUMED);
	skb_release_data(skb, SKB_CONSUMED);

looks a little ugly
