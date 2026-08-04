Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399F332614
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845777; cv=none; b=TYsKbbtLlQjxU3ithFtN7d1xnkJCYsrtyaRQTh7oHp/EYTJBM9sU5wx5zmzfg+dtvrAl2LFfKQA56RN2FsMFpht1fDYQQEqYHfVv9z6fSo96s9gjomFU7S58VixQOCJikmnerDbaqvTimP9WsYohEE4KgIfOUlzCOXEpEslxu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845777; c=relaxed/simple;
	bh=jnyksvIqf28xKiDSMK9JmnG3/NGrgFEAYt1AJb8VkXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkuPVJUVpL9HlgSyW9EpPG/Rz1diU8QmP1/WPcupkfSkBrtpFqZTdld5ldIavOnbgTWBssom7jcrAobWeBpT7TFlS07m/zcbkeTsTBn9tGAHq8u1GBInyZwTXlqa7DCr1g60e6UXZQGEqpRkGiMoH8qspsf3cqg8+eJ9/xyhaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubv8wfRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubv8wfRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42661F000E9;
	Tue,  4 Aug 2026 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785845776;
	bh=7LQnHbDq5jSORbrQ6p0whnarNjzhPbSvPSJilbSnluQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ubv8wfRGnGc0TQux6yHJix90mZYtQZrELDYn1auqfG0ISvvvxmEd8Y1xTWDUYc81X
	 sBcDbF6m+qLgoN+9chIE6ABkmkrZOCCYnkA9ziM2lhPZatopVbjJNuo0Wr6jHAa25E
	 SGfffP2WY60cS0zzC2gp+jTb5hqLdSQicCDB1NPvCGGCwdXt6CTWonNsH5PhI9ECvo
	 Xed7wHhld7Lf1cNzYYBhyxOtK2+6k+KVZMDttDt7E/NuHulPTt7sTkwhHcy7l2LyYU
	 mo4GSrjbgKCsJqXvmbGkhee7+rqRVp7QxQlT4chIxRVO/NEjPqKmRpSdB4BKTncRPS
	 RUMxfB4p/iGmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] xdp: reject clones that overrun skb_shared_info
 tailroom
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <6b2afef5d1738763c6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai>
References: <cover.1785757386.git.zhilinz@nebusec.ai>
 <6b2afef5d1738763c6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:16:15 +0000
Message-Id: <20260804121615.E42661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing SKB_WITH_OVERHEAD check in `xdp_convert_zc_to_xdp_frame()`=
 leads to in-page overwrite of packet data with `skb_shared_info`.
- [High] Incorrect `headroom` initialization in `xdp_convert_zc_to_xdp_fram=
e()` causes an out-of-bounds write of `skb_shared_info` into the next physi=
cal page.
- [High] Silently dropping packet fragments in `xdp_convert_zc_to_xdp_frame=
()` causes truncation of multi-buffer packets.
--

--- Patch [1]: [PATCH net 1/1] xdp: reject clones that overrun skb_shared_i=
nfo tailroom ---
commit 06453b67e02a5370da9d6643a102dd0628f4807c
Author: Zhiling Zou <zhilinz@nebusec.ai>

xdp: reject clones that overrun skb_shared_info tailroom

This commit updates xdpf_clone() to reject frames that do not leave
enough room for skb_shared_info. It changes the bounds check to use
SKB_WITH_OVERHEAD(PAGE_SIZE) to prevent build_skb_around() from
corrupting live packet bytes during XDP-to-SKB conversion.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..0194e69da339a 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -871,7 +871,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
>  	headroom =3D xdpf->headroom + sizeof(*xdpf);
>  	totalsize =3D headroom + xdpf->len;
> =20
> -	if (unlikely(totalsize > PAGE_SIZE))
> +	if (unlikely(totalsize > SKB_WITH_OVERHEAD(PAGE_SIZE)))
>  		return NULL;
>  	page =3D dev_alloc_page();
>  	if (!page)

Looking at the fix applied here, there appear to be similar pre-existing
issues in the same file within xdp_convert_zc_to_xdp_frame():

net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
	metasize =3D xdp_data_meta_unsupported(xdp) ? 0 :
		   xdp->data - xdp->data_meta;
	totsize =3D xdp->data_end - xdp->data + metasize;

[Severity: High]
This isn't a bug introduced by this patch, but does this calculation
result in silently dropped packet fragments?

If an AF_XDP multi-buffer zero-copy packet with XDP_FLAGS_HAS_FRAGS set is
passed here, only the linear data size is calculated. The fragments appear
to be ignored, and the original xdp_buff is freed back to the pool,
returning a truncated xdp_frame without propagating the fragments.

	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
		return NULL;

[Severity: High]
This is a pre-existing issue, but should this bounds check also use
SKB_WITH_OVERHEAD(PAGE_SIZE) similar to the fix in xdpf_clone()?

If an AF_XDP zero-copy packet has a linear length between
SKB_WITH_OVERHEAD(PAGE_SIZE) and PAGE_SIZE, it will pass this check.
When __xdp_build_skb_from_frame() later converts this frame into an SKB,
build_skb_around() could overwrite the valid packet payload with
skb_shared_info.

	addr +=3D sizeof(*xdpf);
	data_to_copy =3D metasize ? xdp->data_meta : xdp->data;
	memcpy(addr, data_to_copy, totsize);

	xdpf->data =3D addr + metasize;
	xdpf->len =3D totsize - metasize;
	xdpf->headroom =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but could setting headroom to 0
instead of metasize cause an out-of-bounds write?

If metasize is greater than 0, setting headroom to 0 shifts the computed
hard_start of the SKB buffer forward by metasize bytes. When
build_skb_around() is called on this buffer with a length of PAGE_SIZE,
the buffer logically extends past the allocated page boundary.

If fragments are later appended or the tailroom is used, could the stack
write directly into the next physical page?
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6b2afef5d1738763c69=
65e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai?part=3D1
