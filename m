Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0918DF80
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924767; cv=none; b=urh2yIfQtC4Mzh7TjLI2PHTq/Nnq1bvoWw6YpUIzyrB+5YskVMFmCYEYQZzAEJXsKDM21XiA5ipa1St6rkFW5FK0ruJPZfBtRFYwcp16iN/tRCu1P0V/AoqdeuJ2dsqXn2ZAT3PODZWHusd8DN6HIPujR/FtkTf6DIoj9bUXZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924767; c=relaxed/simple;
	bh=dK3iRWPM/cmKRLqBxOyThAjtHyfQ2TyrZG+MswE3rBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fADCOWr9233NuH8ljH7HN8QJyafi3gfwgpG0pib87/Uu/ZU0BK+Yvz4tpGDJafiVpguZfg9TCKHVRMeXDKnxVlnxPOuGFyY3ISqPdpyVoAI0thyFw4bMFIAwU7uUL+xs5Si2gxMCtv0rRuXNTHK0j000M9OqjWxQ5WQFyxXS6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHBe4EmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHBe4EmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C001F000E9;
	Sat, 20 Jun 2026 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781924765;
	bh=2xoUABEtSyGgnLAxKW4Om8KofWAhAdKvsWiLtR9cEIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHBe4EmZ/z/lSq6aeS5P81sEAGKk1x3SdeQPscKiYrq9uorOMretAqgGbnx9Qg/Eo
	 0bwn6jsa/dg24wEB8hrxPpS05LZNRCoDNBk2wRMkbR6GNm8w0GnyJU8QgkEumeKXuA
	 9OREGmurfsPaex1t3ijkEBIWtkY+gsXsARiwbpLwlIvEOQxjEzsesewIsgy145yOeR
	 1mHddJ0eK3lDywgIIuj7XsTzLEhgwuVlNymxxpEF6XKE0tI9FZYpfXzMAEYhBvRlGz
	 4q14g9WhyoGvEp/UNmRPHE0vNOSdwyxIoDB06Nz7RvGq7Lkqf0anpmXg90BJjqSU8d
	 Fd/NpkUa/jNyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] bpf, sockmap: reject a packet-modifying
 SK_SKB stream parser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620024423.4141004-3-rhkrqnwk98@gmail.com>
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
 <20260620024423.4141004-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 03:06:04 +0000
Message-Id: <20260620030605.57C001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fix for the stream parser slab-use-after-free can be bypassed =
because `BPF_FUNC_dynptr_write` is missing from `bpf_helper_changes_pkt_dat=
a()`.
- [High] Lockless access to `link->prog` in `bpf_link_show_fdinfo` and `bpf=
_link_get_info_by_fd` can lead to a Use-After-Free if the program is update=
d concurrently.
--

commit bb301227c425ce89eb44f853ff40b55c28c66bcd
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: reject a packet-modifying SK_SKB stream parser

The patch prevents a slab-use-after-free by rejecting SK_SKB stream parser
programs that modify the packet. It does this by checking if
prog->aux->changes_pkt_data is set at attach time.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 99e3789492a09..c60ba6d292f9a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_ma=
p *map, struct bpf_prog ***ppr
>  	return 0;
>  }
> =20
> +static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
> +				      struct bpf_prog *prog)
> +{
> +	/* A stream parser must not modify the skb, only measure it. */
> +	if (prog && attach_type =3D=3D BPF_SK_SKB_STREAM_PARSER &&
> +	    prog->aux->changes_pkt_data)
> +		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does this check completely
prevent packet modifications?

Looking at bpf_helper_changes_pkt_data() in net/core/filter.c, it seems
BPF_FUNC_dynptr_write is missing from the list. If a program acquires a
writable dynptr via bpf_dynptr_from_skb() and calls bpf_dynptr_write(), it
internally calls __bpf_skb_store_bytes() which can trigger pskb_may_pull() =
and
cause the exact same slab-use-after-free this patch is trying to fix.

> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1776,6 +1791,11 @@ static int sock_map_link_update_prog(struct bpf_li=
nk *link,
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> +
> +	ret =3D sock_map_prog_attach_check(link->attach_type, prog);
> +	if (ret)
> +		goto out;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the later program excha=
nge
in this function race with lockless readers?

Later in sock_map_link_update_prog(), the program is updated using
xchg(&link->prog, prog) and the old program is freed via bpf_prog_put().
In kernel/bpf/syscall.c, bpf_link_show_fdinfo() and bpf_link_get_info_by_fd=
()
access link->prog locklessly without holding rcu_read_lock().

If a reader is preempted after fetching link->prog, could an RCU grace peri=
od
elapse and bpf_prog_put() free the old program? When the reader resumes,
dereferencing the freed memory (e.g., prog->tag or prog->aux->id) could lead
to a use-after-free.

>  	if (!sockmap_link->map) {
>  		ret =3D -ENOLINK;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620024423.4141=
004-1-rhkrqnwk98@gmail.com?part=3D2
