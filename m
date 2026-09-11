Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4733612ED
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137404; cv=none; b=SkYRBvcOvEDyrse5IVIgdX7cKk2YbHL2AJcll58GOWDJaH4v9jH53Hj5oN+4OBV3vU8QCYEOQe16LIiedI/L0Ero/VpfyQ9sDAx/o7PPhXHSkrPdH9uHVyJvwAducNwEdTGRiQlW+RVp+hAjGjhfvBtFgfrNv7sQGmBiIgjJCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137404; c=relaxed/simple;
	bh=DtRphfl1re5UW3jAxoshsoG41iL/y7QC0AQvoXfhQmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k7GVCtfZ8f7FUjvRfFPYclkem0q1NL9mx9JpBf+ZqH8C1bOHSzkYhYPjbfKXfwp+TdEjl2k5o44TJz+wrbxV2d6tGETgGCY12qpFNn/qEI3dToFhv4FRrvghrHh9WBoQ19PM/jw8NkwY9hvmcF9je0Fe4zHH4f/n9+HZENSGyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBSR54Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBSR54Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B51F000FF;
	Fri, 11 Sep 2026 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137403;
	bh=kZSUSudwrHkCPEdvtktpRlkzzW1orUy+gc2oD0JZKzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBSR54Bnb8+iPU/BP+cTVP1eTzPZUSopniCflyS8SuomtRHn1dD8b43gp9Hf5Hfkm
	 MsIAYkJEHk5mGD4Q+vvazS4eChHo2J2KTL9pQ7S2c+Ef4KOYpGX/i32YRiXbQQ0xwo
	 QrakWxj0C1dhBa02fkJX2Yp0AqHCKTN1a0imWk7iy4jUjVXIR8PtUxii8lgrIPFLpj
	 /gAkqaICf1pS9KjdLYaW4lT/WTNx/5D3gs4r4bp9OJxAaFJxi9bKAfodrZOAGSBXMi
	 iX885fB+WVbQCLjKWeGsPLG9KYyQV7qyOT+Atpy2iycdiwgGWvvsmwb/CCgaWomOUy
	 wlruHowlcOs1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911135711.109338-2-jiayuan.chen@linux.dev>
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:36:42 +0000
Message-Id: <20260911143643.402B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] veth_xdp_rcv_one() overwrites shared per-queue rq->xdp_rxq.mem.typ=
e state, corrupting subsequent SKB processing in the same NAPI poll and cau=
sing kernel panics.
--

commit 6d121019cfea2f329267400ac7c2525a49f34f53
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

    bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
   =20
    bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
    xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb =
is
    cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHAR=
ED.
    This fixes the resulting page pool panics by recording the memory type =
in
    the xdp_buff flags instead.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153fb..a3fdf1959b76c 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -775,6 +775,12 @@ static int veth_convert_skb_to_xdp_buff(struct veth_=
rq *rq,
>  	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/*
> +		 * A nonlinear skb was cow'd into rq->page_pool above, so the
> +		 * frags must be freed to that pool, not via the rxq's
> +		 * MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but can the shared per-queue mem=
ory
type state be clobbered during a mixed batch?

In veth_xdp_rcv_one(), the shared rq->xdp_rxq.mem.type state is overwritten
with the incoming frame's type without being restored:

veth_xdp_rcv_one() {
    ...
    case XDP_REDIRECT:
        orig_frame =3D *frame;
        xdp->rxq->mem.type =3D frame->mem_type;
    ...
}

If a single NAPI poll (veth_xdp_rcv) processes a batch containing a native
xdp_frame (e.g. MEM_TYPE_XSK_BUFF_POOL) followed by a standard sk_buff, the
next packet will be processed with the clobbered rxq->mem.type.

When veth_xdp_rcv_skb() processes the subsequent sk_buff, the BPF program
is executed with this clobbered state:

veth_xdp_rcv_skb() {
    ...
    act =3D bpf_prog_run_xdp(xdp_prog, xdp);
    ...
}

If this clobbered memory type is read by helpers like bpf_xdp_shrink_data(),
could it lead to a kernel panic? For instance, if clobbered to XSK_BUFF_POO=
L,
it would erroneously call xsk_buff_free() on a standard xdp_buff, resulting
in a garbage dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135711.1093=
38-1-jiayuan.chen@linux.dev?part=3D1
