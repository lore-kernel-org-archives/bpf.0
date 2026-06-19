Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DB322A2E
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851913; cv=none; b=bPL83hXYImblpCkO5F7VTs8xADu4PXG07oZIDtYYeInrb+upSVOKrKqb37HCzfbR267a7yiO0NxlkEw9Yghi2wOuq8r7RMQo/EgN47McWh7Zs88cXQrCNigUN/LeN1KxOFoZOKpYt9EZ/vyKFUkWlkzDslsQeuXQLDQZpNEShhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851913; c=relaxed/simple;
	bh=ON9RJBIeqM3G3vmzgfB1fU91uLoBv1dKuwo/tr4ZvT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhA+pZxzJnOOEkT05O8mTar6w9Kb9GYprYmbVBBWpydTFhoE/n3FSvgFFnu7Fy9Agk6lPZrjXCMx2L7D2UJWKEC0EWtXUWRDs2vVBARrDdLZ+yMkkhVrLpBSe7b+QLWPOaUt+Jd6LNY3Y/c7l+H/Agdn5BjObtKvW0ZnAwk47Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF+74JQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF+74JQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA31F000E9;
	Fri, 19 Jun 2026 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781851912;
	bh=9GZC83BLpL/PGsRP3PASf+sc5JP0x2bnQEl7OYUkcoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LF+74JQJqZHdPZ2ng54FL9t2nXoejaya9J/W0ixP+29er+0vo94Ihzj5w0Msp2QND
	 Nr9UPLvEUvMidlQnjwH4csnD2+iGCVnDFWOEcx81+mJwO1cUcQvpD6IPFaBWElidoJ
	 0SGYlIiqo+LFxqJ3Hr5Afaj8/qyKWEtElRKhcf5SyUu050rJJsZNlGZO0t/PrC5u/T
	 V2FCQC2AjSlxof+NemeV0egZxZxnu7jQYekNQtXu/fX3l2oh1paeKnS3UCbMf5TGF9
	 NwrOkW356dKLomDh14UukUiLxqFkeyD72YyBXk8TDLQGAVVidp6emDT0whLqoao6J4
	 JxKemaDYX0Tvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/3] bpf, sockmap: reject a packet-modifying
 SK_SKB stream parser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619062959.3277612-3-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
 <20260619062959.3277612-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 06:51:51 +0000
Message-Id: <20260619065152.4CDA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete mitigation for a Use-After-Free in the stream parser. T=
he newly added attach-time check can be bypassed using `bpf_dynptr_write()`.
--

commit 045eed2578465803e8813874d62e6ec53c4a01de
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: reject a packet-modifying SK_SKB stream parser

sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
to find the length of the next message. strparser assembles a message out
of several received skbs by chaining them onto the head's frag_list and
recording where to append the next one in strp->skb_nextp. A stream parser
is only meant to measure the next message, so this patch rejects a parser
whose program can change packet data at attach time.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 99e3789492a09..c60ba6d292f9a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c

[ ... ]

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
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
This isn't a bug introduced by this patch, but could this attach-time check=
 be
bypassed by using bpf_dynptr_write()?

Because BPF_FUNC_dynptr_write is missing from the
bpf_helper_changes_pkt_data() switch statement in net/core/filter.c, and
bpf_dynptr_from_skb() is not flagged by bpf_is_kfunc_pkt_changing(), the
verifier never sets changes_pkt_data for programs using dynptrs to modify
the packet.

If a BPF program obtains a writable dynptr to the SKB using the
bpf_dynptr_from_skb() kfunc, it can modify the packet using the
bpf_dynptr_write() helper.

For SKB dynptrs, bpf_dynptr_write() calls __bpf_dynptr_write() in
kernel/bpf/helpers.c:

	case BPF_DYNPTR_TYPE_SKB:
		return __bpf_skb_store_bytes(dst->data, dst->offset + offset, src, len,
					     flags);

This modifies the SKB and triggers skb_ensure_writable(). If the write
exceeds skb_headlen(skb), this invokes __pskb_pull_tail() and unconditional=
ly
frees the frag_list skbs, causing the exact use-after-free in the stream
parser that this patch intends to fix.

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619062959.3277=
612-1-rhkrqnwk98@gmail.com?part=3D2
