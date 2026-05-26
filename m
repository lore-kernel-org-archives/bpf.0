Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA835B653
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829313; cv=none; b=D1h/W5Q2Vz3AQrPszQjAoEuCHVMhkm1gL3VAP8W77D1bHpvV/oPmfrQykHcnzN1MRgfzzc5LgzGJP0rPZL4BZvaHvq5fDw90y9d0KQwpGY+xpQjxme21B3bqdLp/WQ8xZ3sOPDjbVC0MdyNm8wfI3R8GtDmdZN4OXSopcLB/Fo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829313; c=relaxed/simple;
	bh=/7gxm0ztRnL4VuNYQ5xyhxMZvgVwQzORjO023WXMEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuLwDl+mkX9DETqzpoqPBrsPNOWCY5+g2NgbPiiLKfSYDriWVuPVEEZm15AocBaL7XYvVAeBVARtSiQcDt9XEnDp3OU4UFCCM9F+o6rXMDkmR50s1wo+HZfQCvpKbiRaYXIrNFJ/wA8/Sw4P7WLoOIQvBS8tu9pjaUWesXEDaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZkRa4uX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZkRa4uX"
Date: Tue, 26 May 2026 14:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779829308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tU6iIA1AHS++grQa49/VChzcNhRWRhTecBu3tlxsvGw=;
	b=hZkRa4uXrVppnjhxzAayd/BJtN3jysuXFZ6KiVG0e8it1mhjEWqdhjyy/tMwv+TCacvGHa
	8RWpUT2KaR3twHCDny6bJ5wC/jHAwc/mocLd+ZkNAVPDtxGTycK+01VUWhprZCce4CQV5a
	D9tEGF5WQHyctCJOHw5MV+8FdwYTJEM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVQ_CB.
Message-ID: <202652620533.bfqf.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-12-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523083001.2911931-12-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, May 23, 2026 at 08:29:40AM +0000, Kuniyuki Iwashima wrote:
> +static void tcp_do_autolowat(struct bpf_sock_ops *skops,
> +			     struct tcp_autolowat_cb *cb,
> +			     struct tcp_sock *tp)
> +{
> +	struct bpf_sock_ops_kern *skops_kern;
> +	struct tcp_skb_cb *tcb;
> +	struct sk_buff *skb;
> +	u32 seq, end_seq;
> +	int ret = 0, i;
> +
> +	skops_kern = bpf_cast_to_kern_ctx(skops);
> +	skb = skops_kern->skb;
> +
> +	if (!skb)
> +		goto update;
> +
> +	tcb = bpf_core_cast(skb->cb, struct tcp_skb_cb);
> +	seq = tcb->seq;
> +	end_seq = tcb->end_seq - !!(tcb->tcp_flags & TCPHDR_FIN);
> +
> +	LOG("Start parsing skb: seq: %u, end_seq: %u, len: %u, "
> +	    "rpc_desc_seq: %u, rpc_end_seq: %u, rpc_buff_len: %u",
> +	    SEQ(seq), SEQ(end_seq), end_seq - seq,
> +	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
> +
> +	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
> +		ret = tcp_parse_descriptor(skops, cb, seq, end_seq);
> +		if (ret)
> +			goto update;
> +	}
> +
> +	i = 0;
> +
> +	while (1) {

A nit. It may be useful to take a look at progs/arena_htab.c or
rbtree_search.c on the 'for (i = zero; i < xyz && can_loop; i++)' usage.

#> ./veristat tcp_autolowat.bpf.o
Processing 'tcp_autolowat.bpf.o'...
File                 Program                   Verdict  Duration (us)  Insns  States  Program size  Jited size
-------------------  ------------------------  -------  -------------  -----  ------  ------------  ----------
tcp_autolowat.bpf.o  tcp_autolowat             success         245961  12624     338           141         939

The "Insns" could likely be reduced to ~1000s level.
