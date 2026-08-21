Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691645FFBB;
	Fri, 21 Aug 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304483; cv=none; b=eDstfbjt1lcm+dWBWVEPUCBo8O5TmUChBlZc664vh3wJ2yIenrYwDYySAY6Ypi5RglBDoTZAYM5jj7FQKB0lJfrHsHaZGXCEfgKfCqUhxg9jZ09Bp6XwDnHhjwPfr5uLLk1Uynarlf+Q3+BnaqXMT6LA9Xqzc0bCJgXEIyPehnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304483; c=relaxed/simple;
	bh=1wTh39NdS2AJGUiEuIl6241+4n9++m3+6F1OUYIdnHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXRveIaPll7Oay1Tey0dVLd7jKshBbpDdG+tzOZyEjjIXMUUd/VPE+jqgO+Yewenmq2easHcOTORMoG0euHKXg4/zDPvx8z5bXsKKNjpEu6gcav/3PJy2JQzRPeSg/kSN/nMF5wrAfOVoU+h1Eu+gQ7PZjRqY+zd96OG4a4+EuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djf7NOZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djf7NOZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257FA1F000E9;
	Fri, 21 Aug 2026 09:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787304469;
	bh=mEdAGVzPUoyqrfbaWfJzZ3/gyva0sQPDevVMAwj477g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=djf7NOZ8scVNbwjo7n61Um9iJmA1QFmribD8NS5XFcKw+udiRqevv9qvv+ewRLvmN
	 blKlkq4jjn1avHCLKCNiUe1SPULqcR2F0u16AH2ljLun/E0alBU9RIMSVYqe6LiKFd
	 H9SkyfXaGcVsEyE6FS94+lqzYE9mOzbQ52abqUZUsnPs+9XTjbMwwyPMCCYIO1n8OT
	 y0+/uRleEwC2qmWs6STY9HKJEeZooqSW5j/0aWIOpCYUqKr9Tmen1e0CYQ/0l6lkTd
	 GCGurP8pJ3oibxRbrOurDpL4P8Kk+jhSIVbKOlX+TUqQvoJfgQ+G6P15q7mccjDCcK
	 dLOxlNeGBIlyg==
Message-ID: <64365932-c765-472e-bf6c-b07c9ee25eaf@kernel.org>
Date: Fri, 21 Aug 2026 11:27:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/14] skb extension for BPF metadata
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2026 10.14, Jakub Sitnicki wrote:
> [I realize net-next closes soon. Posting only to collect more feedback.]
> 
> Please see the RFC cover letter for the overview [1].
> I will focus here just on the latest developments.
> 
> 1) Based on feedback from the RFC - the BPF skb extension is *no longer
> scrubbed* on tunnel encap/decap or veth traversal. There is also *no
> mechanism* to enable scrubbing as we don't seem to have a use case for it.
> 
> 2) Since the RFC I've enabled access to BPF skb extension for the remaining
> BPF program types which operate on skbs, namely netfilter, lwt family, and
> - everyone's favorite - sk_skb.
> 
> Outside the patch set, two things happened:
> 
> 3) At NetConf 2026 Kuniyuki presented effectively the same idea with a use
> case in mind to attach metadata to packets on egress (IIRC). Hoping for
> feedback if this meets your needs as well.
> 
> 4) At BPF Summit 2026, Alexei asked - I'm paraphrasing: What percentage of
> skbs will carry metadata in our workload? This determines if the cost of
> attaching a tracing prog to consume_skb gets amortized. We've run
> experiments and have some answers.
> 
> If bpf skb ext existed today, we would adopt it to attach metadata to
> incoming TCP connections and ingress UDP packets to CDN to identify flows
> that have been forwarded from one PoP to another.
> 
> Based on stats from a production node where we've been testing this patch
> set, the fraction of skbs that would carry the metadata is <1% (~0.7%):
> 
> ```
> 923m16$ sudo perf stat -a -r 10 \
>              -e skb:consume_skb -e skb:kfree_skb \
>              -e probe:skb_ext_add -- sleep 1
> 
>   Performance counter stats for 'system wide' (10 runs):
> 
>             334,256      skb:consume_skb                            ( +-  1.63% )
>               1,525      skb:kfree_skb                              ( +-  4.09% )
>               2,218      probe:skb_ext_add                          ( +- 18.58% )
> 
>             1.02305 +- 0.00243 seconds time elapsed  ( +-  0.24% )
> ```
> 
> I expect that even if we adopted bpf skb ext for other use cases we have in
> mind, like labeling egress CDN packets with a customer identifier, we would
> attach metadata only to around 5% of all skbs in flight.
> 
> We've run an experiment to evaluate this patch set - bpf skb extension -
> against the alternative - using a BPF map keyed by &skb (LRU_HASH) to stash
> metadata plus consume/kfree_skb tracepoint programs to clean up the
> entries.
> 
> To do that we've modified the CDN component that labels the incoming
> connections forwarded from another PoP:
> 
> - with bpf skb ext, BPF progs involved in processing consumed 7.5..10 CPU%,
> - with BPF map + consume/kfree_skb tp, the overhead was between 15..20 CPU%
> 
> Not surprising considering the low fraction of skbs we attach metadata to.
> (For graphs see slides 30 & 40 from our presentation at Netdev 0x1A [2].)
> 

It seems quite clear to me that the kfree_skb tracepoint approach have
too high overhead.  Simply due to frequency as it getting invoked for
ALL packets in the system.

--Jesper




> [1] https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com
> [2] https://github.com/jsitnicki/talks/blob/5d64c151f4dc0c38b2832fdcbce7284ec93fdca2/Netdev%200x1A%20-%20Thrice%20the%20charm%20-%20an%20skb%20extension%20for%20BPF%20metadata.pdf
> 
