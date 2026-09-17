Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C64A5C5F;
	Thu, 17 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680855; cv=none; b=Iy5vzVwBrMIHAXbgW88ruWBL54/4VBEY5ajAtn5dfEprslXpI4LLqhvmD0/NRzPAFDf2IHsitAZALyi+RynWYUoPj3oYUV2iRvFADb1ASA85lY6ZiphMibjMZVDA3Q9xz4yLTVrtTW2ZbYf2a/cso27NwFlwj+4vvceCBUsKPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680855; c=relaxed/simple;
	bh=OrHpf8GMyDAHQKhtaosXUGNZM8uuv0nmE5JyUUqCV9c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l+sUyN5+asCmCx9khytQgxs9Q+MSzFW7qRfgfXeQIXoRLBc6m7QHxvTRV52PUkKi3elQG+26k+WVnc3oLPQjoaXSfHorwHW1ADCE2RN7ebeJ6GElG/wW0OpD3biSnTVtH6l+/Uyb2Ic0eLCwgaCVqbR/wt7PK6zG+D8bSKgScSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc3He0UW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc3He0UW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D7D1F00893;
	Thu, 17 Sep 2026 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680854;
	bh=i0QdXOM59INKDn4FrgN0cBn8+uOxOJOXiT5vF8bmrdM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Lc3He0UWx5GJmugN+/f0wqwr3FpiCeaZzA3oXH5GHqSyG0gWNlNMWiScVk28P0EYs
	 TM2I/izzy/ryxLm3NfDXPZVSUARrjkS3iNqKS/qbccXQzncHy72h/mpmGNgdH18SaD
	 2aIl0+FsUIiPbP2q7+iJhqTUJIH6kMGGOjuRUyNUEME96B3U38bcPaZneZ8U2eWrsY
	 SJ8jhAnVZWvLgXNpCK3J5lvMAvoYKlBA/VPXeGYMkpDjFVe6Js++0BIFQXKDG6BVnN
	 VPQW8hIjomTTSURSrDGwww8jvYElMXkmoxf7HdJmLwrDSNGDATZ5EQL2OTBGApVb2s
	 7bxbJ47OaA0DA==
Content-Type: multipart/mixed; boundary="===============2911002517043429475=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01c965752665d0982d86213c2a4b86c428163d2b69a1b61c393ce312f86e4e4d@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-13-ameryhung@gmail.com>
References: <20260917200542.3689605-13-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 12/15] bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:13 +0000 (UTC)

--===============2911002517043429475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index af37470437784..d61ee00052e33 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3011,6 +3011,48 @@ struct bpf_tcp_ops {
>
>  	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
>  	void (*listen)(struct sock *sk);
> +
> +	/*
> +	 * Parse the TCP header options of an incoming skb received on an
> +	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes()
> +	 * to access the options.
> +	 */
> +	void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);

The parse_hdr() documentation recommends using bpf_skb_load_bytes() to
access the options, but is that helper actually available to bpf_tcp_ops
programs?

Looking at get_func_proto() in net/ipv4/bpf_tcp_ops.c, the struct_ops
verifier handler only exposes BPF_FUNC_load_hdr_opt, BPF_FUNC_store_hdr_opt,
and BPF_FUNC_reserve_hdr_opt, then falls through to bpf_base_func_proto()
for everything else. bpf_base_func_proto() in kernel/bpf/helpers.c has no
BPF_FUNC_skb_load_bytes case, and bpf_skb_load_bytes_proto is only
returned from the sk_filter/tc_cls_act/sock_ops/sk_skb func_proto tables
in net/core/filter.c, none of which apply to struct_ops programs.

A program written against this comment would fail to load with "unknown
func bpf_skb_load_bytes#26".

The other half of the recommendation works: bpf_dynptr_from_skb() is
reachable because bpf_kfunc_set_skb is registered for
BPF_PROG_TYPE_STRUCT_OPS in net/core/filter.c.

The UAPI documentation added by this same commit states that
bpf_load_hdr_opt() "can be called from the parse_hdr() and
write_hdr_opt() operators" in include/uapi/linux/bpf.h, and
get_func_proto() does expose BPF_FUNC_load_hdr_opt to parse_hdr. That is
the helper this comment should recommend.

Could the comment here be updated to recommend bpf_load_hdr_opt() or
bpf_dynptr_from_skb() instead?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============2911002517043429475==--
