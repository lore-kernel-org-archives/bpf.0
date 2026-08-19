Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAE261B70
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154567; cv=none; b=DtQDYpEddsLj/5wGS3TNKO/lkewx1/kVrYggE61890DzwmsZn4vDzaGEhzRKeHAW72voEQpk/3qMhnMkWJg7OC4xDSytapJie2ByuvVSlz4mPOG+cMWnaTBq1a8sjqFDTa9fAq0UHZ3vDcBLCYHiEmYYcEH1U0xLoTVVgEg1owQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154567; c=relaxed/simple;
	bh=KTSw12lLSVInjHSA9TXgWdz/vlAklt/fBX482HJZrU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PrYU5RoFZg9hbZmUc/Y7xR6CsO/Wup61fCz8nNY6O36Jti9jLL6FdBjf5kROMr2qlVf+Hm5gqfLV+eex/m65OObVzPhWnrFFMWZu3mCnYfPMYAsUz9XRf6+ric97O8sBaThbwgx0KkH+yof0+m0VNkNKjJZ+ZwjH9I6MSx9F0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ3x6uB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ3x6uB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191821F000E9;
	Wed, 19 Aug 2026 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787154566;
	bh=pj55dsIdYQ+hDDuHBJ0jWoZKmh0tHh28GuaBq3Xw0eQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJ3x6uB876ZbQvYLMUYDn7G3cXulz+5MGsw0p7FslVoGkEIYWISqGo5AjeQToyozb
	 G+PUWoe1kA65jKwbNTf4jGuLMcStJuSqSnfIinSFn0WbgHVRgN+yiicyjJ/SLCUoEH
	 lpLJl180wrL5yJ/ixRVPBf6ML8XFFFAlbz6yH0Dyl0spdfX9XbTX57kNbTaQOmUmuf
	 r6CATPPKcC3UiT4GezAbV9ZGOvZc53qOJaPT820p0stMXtRnUfdkR9Ww+gW9O2Njth
	 r7RMnYyStT0hEUku4sm7k818j7Vi/2cbSgX5srzfGpDaUaOWOdnNon/dNgxf6nrbEf
	 gWhrQHWROeQDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xdp: fix zero-copy frame layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818154516.793517-1-bestswngs@gmail.com>
References: <20260818154516.793517-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 15:49:25 +0000
Message-Id: <20260819154926.191821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free of XSK buffer and memory leak of `xdp_frame` page =
on redirect enqueue error.
- [High] Silent truncation of fragmented AF_XDP (MEM_TYPE_XSK_BUFF_POOL) mu=
lti-buffer packets during redirect.
--

--- Patch [1]: [PATCH net] xdp: fix zero-copy frame layout ---
commit 300f3eb2043fb6dcf3006d467327612f861ccc98
Author: Weiming Shi <bestswngs@gmail.com>

xdp: fix zero-copy frame layout

xdp_convert_zc_to_xdp_frame() clones an XSK packet into an order-0 page
and advertises PAGE_SIZE as its frame size. It allows the copied frame
to occupy the page tail needed by skb_shared_info and records zero
headroom even when metadata separates the frame header from packet data.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 0194e69da339a..1d679e8fd6493 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -585,7 +585,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct =
xdp_buff *xdp)
>  		   xdp->data - xdp->data_meta;
>  	totsize =3D xdp->data_end - xdp->data + metasize;
> =20
> -	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
> +	if (sizeof(*xdpf) + totsize > SKB_WITH_OVERHEAD(PAGE_SIZE))
>  		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does this function silently
drop fragments when an AF_XDP zero-copy buffer contains them?

Looking at xdp_convert_zc_to_xdp_frame() in net/core/xdp.c, totsize is
calculated using only xdp->data_end - xdp->data. It ignores
xdp_buff_has_frags(xdp), meaning it allocates an order-0 page and copies on=
ly
the linear data.

Any attached fragments in the tailroom's skb_shared_info seem to be ignored,
and while they are freed via xsk_buff_free(xdp), the resulting xdp_frame is
silently truncated.

> =20
>  	page =3D dev_alloc_page();
[ ... ]
> @@ -602,7 +602,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct =
xdp_buff *xdp)
> =20
>  	xdpf->data =3D addr + metasize;
>  	xdpf->len =3D totsize - metasize;
> -	xdpf->headroom =3D 0;
> +	xdpf->headroom =3D metasize;
>  	xdpf->metasize =3D metasize;
>  	xdpf->frame_sz =3D PAGE_SIZE;
>  	xdpf->mem_type =3D MEM_TYPE_PAGE_ORDER0;

[Severity: Critical]
This is a pre-existing issue, but does freeing the zero-copy buffer at the =
end
of this function cause a double-free and memory leak if the subsequent enqu=
eue
operation fails?

In net/core/xdp.c:xdp_convert_zc_to_xdp_frame(), the original buffer is
explicitly freed via xsk_buff_free(xdp) upon successful conversion. It then
returns the new xdp_frame to xdp_do_redirect():

net/core/filter.c:xdp_do_redirect() {
    ...
    return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
                                   xdp_prog);
}

If __xdp_do_redirect_frame() fails, it returns the error code without freei=
ng
the xdp_frame parameter:

net/core/filter.c:__xdp_do_redirect_frame() {
    ...
err:
    _trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->t=
gt_index, err);
    return err;
}

Since the pointer is not saved in xdp_do_redirect(), the newly allocated
page appears to be leaked.

Additionally, because the error propagates back to the calling driver, the
driver might assume the subsystem did not consume the packet and proceed to
free the original ZC buffer again, potentially causing a double-free in the
XSK pool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818154516.7935=
17-1-bestswngs@gmail.com?part=3D1
