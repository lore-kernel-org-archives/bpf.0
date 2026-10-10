Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F73451D6
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628038; cv=none; b=qFiVUySn/QQ7C/PHx76kqNAR0ML3VgTAN2klUx3DsRnAWJ8q4mWWZ+7g4QNv82HsDxtW5pLVEtuMqKsVEMtppfCba9FZOvDOg4wEzs3OR6becn1yvDulIdUhcERtxLVln4UQzUim6hyDqG4FmUi4SLKc+SDREfMyOyR9fkaxRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628038; c=relaxed/simple;
	bh=q1DC11ZxEwj64Tna4QdDd4OGI/RgwyXUkPEkntt1bWA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=joA0N7Vcdy9ei99PkFA0+3A7fzlzHNOmAzT+xH1B6qHBelE/xbY0PYmTfu+LOAzKKua0SSo+W1IvPQrzjDhHd9CkrQbR7DVHAB/B/WnNt6VhJ86cHCxXvIemUOb34mbOktEsAhV/C5QMWVgslI9NIpba4v3cFM3idH9Or6Y6Niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmeqhHcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmeqhHcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AD11F00898;
	Sat, 10 Oct 2026 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628036;
	bh=O1Rfw/VtPlLc3V7dtuy8NRSY/9LnVAjumFFHOiYFGo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HmeqhHczImNe63XMHCwa5qESC5VcsmOH+VT3thcQuq3omfiIPFp33P0VglDcq2Ggu
	 rng1rZt0K32lcLs5p5kGJOu4y1t1OfSSDaoB432enK6mHk5/ldP+7r2HqGgI3qZDqi
	 6neGFozmWfK3VdBAgbfLUny7nf+M6lm68GzxEvNZcKWPc1stua7a1a7C+byeJ/Ogxk
	 e5ug1JxaR/2TWBTGu/6cIOXWHKURT3jYmzXgQ5VQlQ9UFuCtoNNMItOQp0MggkqymW
	 7idq45WepASNNT4F7vAwHZUVkk6wfcKZ6CGjhcQwZ6wrLjutjGtDvq9BhudqynHuP0
	 Tggw1yinyGBvQ==
Message-ID: <sashiko-outbox-166432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: take ownership of saved RX
 state at poll entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-stmmac-rx-mb-v5-1-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <20261009-stmmac-rx-mb-v5-1-c38fa4eaa138@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:27:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: packet injection via dropped jumbo frames in stmmac_rx_zc
--

commit 3706267b24a396bb486058241888899e504fbd4c
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: take ownership of saved RX state at poll entry

This commit addresses a use-after-free issue when a saved partial packet
completes with a poll budget of one. It ensures the saved RX state is taken
at poll entry and the stored ownership is cleared immediately.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -5705,6 +5712,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, i=
nt limit, u32 queue)
> =20
>  		if (unlikely(error && (status & rx_not_ls)))
>  			goto read_again;
> +
>  		if (unlikely(error)) {
>  			count++;
>  			continue;
>  		}
> =20
>  		/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
>  		if (likely(status & rx_not_ls)) {
>  			xsk_buff_free(buf->xdp);
>  			buf->xdp =3D NULL;
>  			dirty++;
>  			count++;
>  			goto read_again;
>  		}

[Severity: High]
Does this code leave subsequent fragments of a dropped scattered frame
vulnerable to being processed as new, valid packets?

When a jumbo frame is split across multiple descriptors, the first descript=
or
has status & rx_not_ls set. In the zero-copy path, this fragment is dropped,
and the code jumps back to read_again. However, it does not set error =3D 1
before doing so.

Because the error state remains 0, the error skip checks at the beginning
of the loop are bypassed when processing the next fragment of the same pack=
et.
If that next fragment is the tail fragment (where rx_not_ls is 0), it appea=
rs
it will be erroneously processed as an independent, valid packet and passed=
 to
the XDP program.

Could this allow an attacker to craft a jumbo frame that injects arbitrary
headers and payload into the stack?

It looks like subsequent patches in this series update the non-zero-copy
stmmac_rx path to properly accumulate fragments, but it appears stmmac_rx_zc
might have been missed and does not yet handle scattered frames or set
error =3D 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-stmmac-rx-=
mb-v5-0-c38fa4eaa138@oss.qualcomm.com?part=3D1
