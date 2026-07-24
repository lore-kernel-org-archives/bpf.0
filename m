Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FE4908B9
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873163; cv=none; b=XJY9s2yEyi7wlmCWDtJvURXnL2kwZX/fgg7Jh7sGeh4XMUyTAieC94VgCaikTEvYDQyXKBpGBDInvIMgBtynNlKtSnbMpKnITYLjtz4gmIJbgWUbEFd8VNvcXtjHmzdbwv1j9nv/+I91HDaDyEyBlxSutamOzPQo7aw2MBGblhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873163; c=relaxed/simple;
	bh=s7pbSfZBkXLhOVdmAbafHRuBcOkd0zfGJdf156zepe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r9pxrZ0Hj5YCwET0WROMSidUM+Sebu9IwG1DFXglb3FkS1OXpRzNUiMfpkRAaFuc9NJCdLk+OhCfsZAtRzBHJqhG7LOBa88QxLpO5OOcFTig7pFZjC6AoKFv+dvzyTnSWQg9ILXoWNkmWGbHNUZdl/uw7wiHt/GSmr0lOaoAZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIwzQiaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIwzQiaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E509C1F000E9;
	Fri, 24 Jul 2026 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784873162;
	bh=1w///eXdmssDPnSWmFbNC1+LzZB79A+9zAxZE+1pwH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIwzQiaVnHDmjCx9rYqDQOzPtifcWuHZqfOZKRZodhw5jDN15KfLAzy714UMKlebn
	 9w4BcB0jLT/vIItfHSe1JQrBWcgwy9anMPaAEuKMCDxl2fZIjz0RB+Q+jA2WvyTivz
	 PFFatpWIo4trGEl7cAHcqdv6zHyW8nzD+LFVBIqotRyAdgYRo+IizWjEH8Jnk0enGd
	 +LO7LOwe1DVtFXfihOIpFQ5xFIAJ8ZcvFYHn2yh+g9XMzKUO6eZBHFBv36GEwoyUmH
	 utKKnnsyuVnoW3/WH0c/6vOgRHUAIl5ygKFc1te3RF3TnBpBJUO/2RaA07JlWiGK23
	 AJOExlLl+9nFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v1] bpf: lwt: Fix dst reference leak on reroute
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: xuanqiang.luo@linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723060445.21926-1-xuanqiang.luo@linux.dev>
References: <20260723060445.21926-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 06:06:01 +0000
Message-Id: <20260724060601.E509C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pskb_may_pull() or length checks before accessing IP/IPv6 =
headers.
--

--- Patch [1]: [PATCH net v1] bpf: lwt: Fix dst reference leak on reroute f=
ailure ---
commit e474c43b475b276dbbb67aeaae49296dafe9f3ef
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

bpf: lwt: Fix dst reference leak on reroute failure

This patch fixes a reference leak on the newly looked up dst in
bpf_lwt_xmit_reroute(). When skb_cow_head() fails, the error path
now correctly releases the new dst reference before freeing the skb.

Cc: stable@vger.kernel.org

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index bf588f508b79e..652952d416f23 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
[ ... ]
> @@ -255,8 +255,10 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
>  	 * if there is enough header space in skb.
>  	 */
>  	err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> +		dst_release(dst);
>  		goto err;
> +	}
> =20
>  	skb_dst_drop(skb);
>  	skb_dst_set(skb, dst);

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in bpf_lwt_xmit_reroute() and bpf_lwt_input_reroute() regarding missing hea=
der
length checks.

If a BPF program attached to lwtunnel (e.g., BPF_PROG_TYPE_LWT_XMIT or LWT_=
IN)
shrinks the packet via bpf_skb_change_tail() such that the linear data leng=
th
is less than the IPv4/IPv6 header size, and returns BPF_LWT_REROUTE, the
kernel unconditionally accesses the packet headers.

In bpf_lwt_xmit_reroute():

    if (ipv4) {
        struct iphdr *iph =3D ip_hdr(skb);
        ...
        fl4.daddr =3D iph->daddr;
        fl4.saddr =3D iph->saddr;

In bpf_lwt_input_reroute():

    if (skb->protocol =3D=3D htons(ETH_P_IP)) {
        struct iphdr *iph =3D ip_hdr(skb);
        ...
        reason =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
                                      ip4h_dscp(iph), dev);

Does this sequence cause an out-of-bounds memory read (info leak or Oops) w=
hen
dereferencing iph->daddr or iph->saddr, since there is no verification that
skb->len >=3D sizeof(struct iphdr) or a call to pskb_may_pull()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723060445.2192=
6-1-xuanqiang.luo@linux.dev?part=3D1
