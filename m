Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB8282F00
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792592; cv=none; b=BZ2jFZFHZbL7fqaLBqei8S7FsWxFTlGzgT6es35dftY48YuQTWwYvYd3gAZFTT2pisJTP2m7iuCe8jeZ1VSMaA8I5uttDOjqPi1IgBJAHqeXp7ty5Qiau1vpCZZ8UYgRrNyV2sMe2scMT7z4sO4RhBFJQJmCgptXDeJ7lOk3Ets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792592; c=relaxed/simple;
	bh=C7V+YBLZdu+uxmDIP/BI0On1ky21GlzNDVMB48wsW8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vu1yalzNvPwhL87DotGL3UeVdITWUvI54ExuvTN/gw18EY95PdfL/R0qVlA+mgRisKdwgwD33JQ/3LpiNtk8lmoOKRPSYhjZzeCjlazltYVnhKNA6mtQd1Xnz9x3iuWi+aADL1XPcCjNfnn8eTvLx0OCFrvXHlrYleLO4WAsKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6DpIs1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6DpIs1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7052C2BCB5;
	Tue, 21 Apr 2026 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792591;
	bh=C7V+YBLZdu+uxmDIP/BI0On1ky21GlzNDVMB48wsW8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=A6DpIs1UAdSxw07XVsVqjAEnUmw3Mnk/zmQJrDOA8xc2jCVJNj3ZDShdB9Ubzgenh
	 i2a2SlZi+syb/34Dx6pD2FhRwCOsvsqrU1UJqr2jhjHOrTd3021/8GlN69zYPurqRD
	 ziK9si5WJ1a/FouY4k76NBF/tf77zCVKDkVe/HK5BZ8pPmCwRIUBYZ+cIWURPEY1EF
	 uRrW9jllfOXyv/LsFf44A19EzgnFKK2u1nBWZpT+nwmCa2Br3oVmPUvatFITsli3Uk
	 4crMIPZVd9CuAQm+on9m2pTbVMA2i2+OF1V6pwrarJE9WgFKww/0xcla2Nv9p3ASmd
	 h/BtxuZsp7uMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
Reply-To: sashiko@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420132314.1023554-143-sashal@kernel.org>
References: <20260420132314.1023554-143-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 17:29:50 +0000
Message-Id: <20260421172951.A7052C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The commit introduces a UAPI backward compatibility breakage and m=
akes UMEM headroom limits unpredictable for userspace.
- [High] Permanent `locked_vm` accounting leak during short pins in `xdp_um=
em_pin_pages()`.
--

commit 39b8ee9e55bd1dabb902c8f19155e836abf3b229
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: tighten UMEM headroom validation to account for tailroom and min frame

This commit modifies the headroom validation in xdp_umem_reg() to reserve
128 bytes for the minimum ethernet frame size and enough tailroom for
skb_shared_info. This prevents potential corruption at the end of
multi-buffer XSK frames.

Link: https://patch.msgid.link/20260402154958.562179-2-maciej.fijalkowski@i=
ntel.com

> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 9f76ca591d54f..9ec7bd948acc7 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c

[ ... ]

> @@ -202,7 +202,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct=
 xdp_umem_reg *mr)
>  	if (!unaligned_chunks && chunks_rem)
>  		return -EINVAL;
> =20
> -	if (headroom >=3D chunk_size - XDP_PACKET_HEADROOM)
> +	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
> +		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
>  		return -EINVAL;
> =20
>  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {

Does this change make the maximum allowed headroom unpredictable for usersp=
ace?

Since sizeof(struct skb_shared_info) and SKB_DATA_ALIGN depend on kernel
internal structures and architecture-specific cache line sizes, userspace
applications do not have access to these values to deterministically
calculate the limit.

Could this also break existing userspace applications that legitimately
configured larger headrooms but do not enable multi-buffer later on?

While looking at the surrounding code in xdp_umem_reg(), is there an existi=
ng
locked_vm accounting leak in the error paths?

When xdp_umem_reg() attempts to pin pages, it first accounts them:

	err =3D xdp_umem_account_pages(umem);
	if (err)
		return err;

	err =3D xdp_umem_pin_pages(umem, (unsigned long)addr);
	if (err)
		goto out_account;

If pin_user_pages() successfully pins some, but not all pages,
xdp_umem_pin_pages() updates umem->npgs to the smaller count before returni=
ng
an error:

	npgs =3D pin_user_pages(address, umem->npgs,
			      gup_flags | FOLL_LONGTERM, &umem->pgs[0]);
	...
	if (npgs !=3D umem->npgs) {
		if (npgs >=3D 0) {
			umem->npgs =3D npgs;
			err =3D -ENOMEM;
			goto out_pin;
		}

Then xdp_umem_reg() jumps to out_account and calls
xdp_umem_unaccount_pages(umem). This subtracts the newly modified, smaller
umem->npgs from umem->user->locked_vm, which appears to permanently leak the
difference in the user's locked_vm counter.

Can this be repeatedly triggered by passing ranges with unmapped holes to
exhaust the memory lock limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420132314.1023=
554-143-sashal@kernel.org?part=3D1
