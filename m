Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A403EF652;
	Tue,  2 Jun 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415470; cv=none; b=IyCIzblAZYXownDaUQO3MiorTxEhQWLdVr/ZaSNWXrZM/zpEsf6RYx8Hn+8fALREa0nf25H8Y/clPs/ibXiurMtBGj9cREroSJaW9Xsu6kiF6QUkOQGFbmgndwvztc527XzDCANmnMh5ryfBhEyUByddD8lLb/rMas8100mRCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415470; c=relaxed/simple;
	bh=VojV8BqIXeEHV183ebwyZ9lRNhjr8IZO8PFG7iIf+ws=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=emh6h7q4XFloD+EPz8zXfveV9tb6Unw57TAYd2/q1X9VBnSTYSNhHG0X120Z4HsAgpRmLJCn7QHt0z6CP4/vrj1pfGrxt4Uf3CAVVf9Ymp/4OafbYbZffYNoCG0EYF5Uyntk9MrOd8WGcs9K99nIJPb/ArGDd+OaSLLviftiz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBVJ0LCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBVJ0LCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18481F00893;
	Tue,  2 Jun 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415469;
	bh=5+YWpz7aIitfyi5cjjiK2WFktoBAyNWpDGeehJabe7s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SBVJ0LCKBfqI2ly5rfdIgDVuf++UgM0tK13CcwsBVT2jLGITiQSdY5UYRFHU6YnDK
	 sF/SmAPyrMQ8Z2mIHpXbVlYkv7/Ve/H3VrwS4TXZONo9Z/JID0XWCLxzzaw6+9Q1vH
	 RuA+GaT8evlLGjdZzwU4vtjrMM762qikk2A6Vo/9GB2pTZ5z8x3ijFCwvin0jeW+9D
	 ByJCeYGAvoGlwdnwDRjLJX8Z8IdGuF/kxSFs2FIMnavhIdeYpZefRK2ASUDzFGssqU
	 AaoO37TpjRu5yNfqf/d2Tr2B+9Ay1ZrIONOH+UCOAXlWrTesTOqT9V1jK6J9NPZWyV
	 lqLckWWmDjPXQ==
Content-Type: multipart/mixed; boundary="===============3174449838128457674=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b65e4b8c71a479f69f516a37f86cf6a527c7f747f33e735bb3036ac024ea518e@mail.kernel.org>
In-Reply-To: <20260602150931.49629-2-leon.hwang@linux.dev>
References: <20260602150931.49629-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf v4 1/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,gnault@redhat.com,leon.hwang@linux.dev,idosch@nvidia.com,fmancera@suse.de,posk@google.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,leon.huangfu@shopee.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 15:51:08 +0000 (UTC)

--===============3174449838128457674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..bf588f508b79 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>  		ipv4 = true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;

Can iph->ihl == 0 slip past this check?  Since len is a u32, iph->ihl * 4
is 0 when iph->ihl is 0, and len < 0 is never true, so the buffer is
accepted without returning -EINVAL.

ip_fast_csum() is later called with this iph->ihl, and on some
architectures (PowerPC, MIPS) that implementation assumes ihl >= 5 and
decrements the loop counter, which can underflow when ihl is 0.

Would an explicit iph->ihl >= 5 guard be needed here, for example:

	if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))
		return -EINVAL;

This was raised in review of v1 and an earlier revision added the
iph->ihl < 5 guard, but the current revision appears to have dropped it
again.

>  		is_udp_tunnel = iph->protocol == IPPROTO_UDP;
>  		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphdr)))
>  			return -EINVAL;
>  	} else if (iph->version == 6) {
>  		ipv4 = false;
>  		if (unlikely(len < sizeof(struct ipv6hdr)))
>  			return -EINVAL;
>  		is_udp_tunnel = ((struct ipv6hdr *)iph)->nexthdr == NEXTHDR_UDP;
>  		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(struct udphdr)))
>  			return -EINVAL;
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -637,6 +644,11 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (is_udp_tunnel) {
> +		size_t iph_sz = ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
> +
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph_sz);
> +	}

Can iph->ihl change between the initial length validation and this read?

The hdr pointer, and therefore iph, refers to a buffer provided by the BPF
program, which can be concurrently modified by userspace through a shared
BPF map.  iph->ihl is re-read here to compute iph_sz, and this read happens
before the memcpy() of the header into the skb:

	if (is_udp_tunnel) {
		size_t iph_sz = ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);

		skb_set_transport_header(skb, skb_network_offset(skb) + iph_sz);
	}
	memcpy(skb_network_header(skb), hdr, len);

If iph->ihl is concurrently changed to a larger value such as 15 after the
initial validation, can the transport header offset be set past skb->tail,
leading to out-of-bounds access when drivers later dereference the
transport header for checksum updates?

The suggestion in the v1 discussion was to move skb_set_transport_header()
after the memcpy() so it reads from the copied-in header, but the current
revision still reads iph->ihl before the memcpy().

>  	memcpy(skb_network_header(skb), hdr, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26830439032
--===============3174449838128457674==--
