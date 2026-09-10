Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F764825CC
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051583; cv=none; b=KYFonqhf/9FPU3LnHUT9jsNX4H+vzMnnA9O1vP3/sY2P3fV2rIrFItSdgG+xbRun8336i/aruGZ8D9seZ84J7lVrlZ9C5Ns4nrmiHjmE5KAtcMd+WahAy9u0/0/cpvXknBs9celhYY7FzhJcZ8afpJJ3NZboeXeWnwoRyhCY/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051583; c=relaxed/simple;
	bh=/J1wuwnRGh/6mDO96IsZp7HVISUd14IirkUlM6AjAqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFbOPg9B/owWtqXbBQlcAtkTfK1KSwyYUJHPKLq731ffMfTclgZbDXEtnOVsOT4Fv41uW7ezocHQ1S9Ck58OJgEo469YMk08GUpbBrKAYvLQO/uYcX7yk8T1Z627pUN0xdqxUqNMtACzLRteQYKrBiDlGV56oj80dao4t//N2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqG8+NXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqG8+NXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D7B1F000FF;
	Thu, 10 Sep 2026 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051581;
	bh=1/K0nzc1i/FSgU4//yLck/pOpZEPUsIxhASatcypkg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqG8+NXFIV1ysuaTjFX9vv+JJFte1SWfAa58yMpzrm2nCE4gZGyS5afnU5SR2zaHe
	 OinQXPIIh2RyYiL8RRGKE2E1hFkfR3COkM3nhtxDtorAcFs5vhs1Yuj93kyFL9eGOQ
	 YDYRH+XAOcRvy2d8aHRz4OqiTXf5iC0JNygWo3CE+edSMPfk7ULE9xkk+dGG/zrX1C
	 ZKG+94+ORG5KyPr6ev/aXE/sz5ODQz6f/BUvuwlg4NMzEsF/34DJ5MSynnXUJOCsQQ
	 dQdgDifY39nXKH3qT69CoYiMP1FRbOwY+US97egkKCPpg2DoseTfVY0z5b6c9xZWKb
	 ub5FgOFpePE4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf: Fix non-linear SRH access in
 bpf_update_srh_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQgU2VjdXJpdHkgRk9SR0UgTGFicyk=?= <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
References: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:46:21 +0000
Message-Id: <20260910144621.99D7B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in bpf_lwt_seg6_action() during END_B6 and END_B6_E=
NCAP actions due to SKB reallocation.
- [High] Incomplete SRH linearization and potential dangling pointer in bpf=
_lwt_seg6_store_bytes().
- [High] Use-After-Free in bpf_lwt_seg6_store_bytes() via invalidated 'from=
' pointer.
- [High] Use-After-Free in bpf_skb_store_bytes() via invalidated 'from' poi=
nter.
--

commit a33b7a64a031c2a48a228616879e253a6490be94
Author: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft=
.com>

bpf: Fix non-linear SRH access in bpf_update_srh_state()

bpf_update_srh_state() assumes the SRH offset is within the skb linear
head, which can be incorrect if ipv6_find_hdr() locates it in non-linear
data. This patch replaces ipv6_find_hdr() with seg6_get_srh() to correctly
pull and validate the SRH. It also adjusts End.DT6, End.B6, and End.B6.Encap
actions to properly handle skb reallocation.

Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.mic=
rosoft.com/
Link: https://lore.kernel.org/bpf/CABFh=3Da5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9=
MVZZG6gSJAEw@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CABFh=3Da4VyzxsQqsayWpTKjxY3HL2C072u=3Dpb=
ecEpNDbL9eBNKA@mail.gmail.com/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2a84f9d011314..06a748c077479 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -7050,40 +7052,49 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *,=
 skb,
>  		if (param_len !=3D sizeof(int))
>  			return -EINVAL;
>  		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
> -	case SEG6_LOCAL_ACTION_END_DT6:
> +	case SEG6_LOCAL_ACTION_END_DT6: {
> +		int tbl_id;
> +
>  		if (!seg6_bpf_has_valid_srh(skb))
>  			return -EBADMSG;
>  		if (param_len !=3D sizeof(int))
>  			return -EINVAL;
> +		tbl_id =3D *(int *)param;
> =20
>  		if (ipv6_find_hdr(skb, &hdroff, IPPROTO_IPV6, NULL, NULL) < 0)
>  			return -EBADMSG;
> -		if (!pskb_pull(skb, hdroff))
> +		if (!pskb_may_pull(skb, hdroff + sizeof(struct ipv6hdr))) {
> +			srh_state->srh =3D NULL;
> +			bpf_compute_data_pointers(skb);
>  			return -EBADMSG;
> +		}
> +		__skb_pull(skb, hdroff);
> =20
>  		skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
>  		skb_reset_network_header(skb);
>  		skb_reset_transport_header(skb);
>  		skb->encapsulation =3D 0;
> =20
> -		bpf_compute_data_pointers(skb);
>  		bpf_update_srh_state(skb);
> -		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
> +		return seg6_lookup_nexthop(skb, NULL, tbl_id);
> +	}
>  	case SEG6_LOCAL_ACTION_END_B6:
>  		if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
>  			return -EBADMSG;
> +		old_len =3D skb->len;
>  		err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
>  					  param, param_len);

[Severity: High]
This is a pre-existing issue, but since param can point to packet data,
could passing it directly to bpf_push_seg6_encap() lead to a use-after-free?

In the END_DT6 case above, the code correctly copies param to tbl_id before
reallocating the skb head. For END_B6, bpf_push_seg6_encap() calls down to
__seg6_do_srh_inline(), which can trigger skb_cow_head() to reallocate the
skb, freeing the original packet data.

If param points to this freed packet data, would the subsequent memcpy() in
__seg6_do_srh_inline() read from freed memory?

net/ipv6/seg6_iptunnel.c:__seg6_do_srh_inline() {
    ...
    err =3D skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
    ...
    memcpy(isrh, osrh, hdrlen);  // osrh aliases the dangling param
    ...
}

> -		if (!err)
> +		if (skb->len !=3D old_len)
>  			bpf_update_srh_state(skb);
> =20
>  		return err;
>  	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
>  		if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
>  			return -EBADMSG;
> +		old_len =3D skb->len;
>  		err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
>  					  param, param_len);

[Severity: High]
This is a pre-existing issue, but this appears to have the same vulnerabili=
ty
as END_B6. Does this need to copy the param data before calling
bpf_push_seg6_encap() to prevent a use-after-free if skb_cow_head()
reallocates the skb?


I also noticed a few other pre-existing issues in this file related to
pointers being invalidated by skb head reallocation:

[Severity: High]
This isn't a bug introduced by this patch, but does bpf_lwt_seg6_store_byte=
s()
have a similar use-after-free if the from argument points to packet data?

net/core/filter.c:bpf_lwt_seg6_store_bytes() {
    ...
    if (unlikely(bpf_try_make_writable(skb, offset + len)))
        return -EFAULT;
    ...
    memcpy(skb->data + offset, from, len);
}

If bpf_try_make_writable() reallocates the skb head, the packet memory
from points to could be freed before the memcpy() dereferences it.


[Severity: High]
This is a pre-existing issue, but bpf_lwt_seg6_store_bytes() also appears to
leave the cached SRH pointer dangling if ipv6_find_hdr() fails after an skb
reallocation:

net/core/filter.c:bpf_lwt_seg6_store_bytes() {
    ...
    if (unlikely(bpf_try_make_writable(skb, offset + len)))
        return -EFAULT;

    if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
        return -EINVAL;

    srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
    ...
}

If bpf_try_make_writable() frees the old skb head, but ipv6_find_hdr()
fails (e.g., because the SRH is only partially linearized), the function
returns -EINVAL without updating srh_state->srh. Could a subsequent helper
then access the dangling srh_state->srh pointer?


[Severity: High]
This is a pre-existing issue, but does bpf_skb_store_bytes() also suffer fr=
om
the same use-after-free with the from pointer?

net/core/filter.c:bpf_skb_store_bytes() {
    ...
    if (unlikely(bpf_try_make_writable(skb, offset + len)))
        return -EFAULT;
    ...
    memcpy(ptr, from, len);
}

If from points to packet memory, bpf_try_make_writable() could reallocate
the skb, freeing the data that from points to before the memcpy().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142522.4501=
4-1-cenzhang@linux.microsoft.com?part=3D1
