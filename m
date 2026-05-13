Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A2883F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631012; cv=none; b=hUCoSeXipZ43MejsbljEDH2tPlax0uUna3rTC32v1LqH5r7HRdjxxcrmfOcdcV1xOxShZ/YaHBnL2fM16waVsJFYmkIP33aGmoeV033qeX8/yl9kCQhAqO7N+Lro8Hs0wNxOMKXAoz9KUDEEvcCfkuvy1gqPvg5jbn/8BeDZkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631012; c=relaxed/simple;
	bh=RsIfxyGs/7TeYSIfEYyCDwjN+86Dm+0eZZP6lpibvQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=As3roCsScroFDNQ3NOghG98g9CJFr1AMzm0iCkL6AweAMAfm9FAtaWOKvXu7IoVH2geLIRqb3v+1q3k+PJX0J4co+R5qnAl7GJuQ+XKusszn20iq8rDeqT5tJ3VinwWB/ZunOJbXCJWIkQkE2BQm3RYYKb3SeBagEFZ+6e/XBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn3jrc+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn3jrc+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E0C2BCB0;
	Wed, 13 May 2026 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631011;
	bh=RsIfxyGs/7TeYSIfEYyCDwjN+86Dm+0eZZP6lpibvQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zn3jrc+jRKRhwbnAJH15RIadOUQzpuPbJSea+qRrl9TaRS9tGwAsYQD8nwS7sIgwR
	 Zf9ZppfyUoecaPK9qgoXAGemvc0H4xvpe2ZamuZLgaEOkf1CsdZkNbDLWqzabYp26A
	 tZpHc7b8/nvObT9Incs4nIUaUACNLSjmPTDGOuQ3wtWWxFvVF0ssZJ60soquHGEbJR
	 pDsKWw11m1xxUY5N6n9K4q1BVZFvOmlX0Ft5lbFIdmeZ1LPcntSoyaazwcj1K4UOim
	 TXoDCiv7tXhS1wSyLRubAPD+duVWnT+XC5DTpmYuiTttFCoGZLhAaGoYDiXKgJnfgS
	 kafdh4BYdBf1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511174920.433155-3-kuba@kernel.org>
References: <20260511174920.433155-3-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:10:11 +0000
Message-Id: <20260513001011.AE1E0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch fails to handle empty TLS records (size =3D=3D 0, st=
art =3D=3D end) when a BPF program pops all data, leading to a chain-after-=
chain kernel panic or premature scatterlist termination.
--

commit a19dc6e44cc96cee4ac7cb297275155ee108e228
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: prevent chain-after-chain in plain text SG

This commit adjusts the scatterlist chaining logic in tls_push_record() to
prevent an illegal chain-after-chain configuration when end =3D 0.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2608b0c01849f..3bfdaf5e64f50 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int fla=
gs,
>  	i =3D msg_pl->sg.end;
>  	sk_msg_iter_var_prev(i);

Does this code handle the case where a BPF program pops all data and leaves
an empty record where msg_pl->sg.size =3D=3D 0 and start =3D=3D end?

[ ... ]

> +	if (i < msg_pl->sg.start)
> +		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> +			 msg_pl->sg.data);

If start =3D=3D end =3D=3D 0, i wraps to NR_MSG_FRAG_IDS - 1. The condition
i < msg_pl->sg.start evaluates to false, skipping the wrap link.

>  	rec->content_type =3D record_type;
>  	if (prot->version =3D=3D TLS_1_3_VERSION) {
>  		/* Add content type to end of message.  No padding added */
>  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
>  		sg_mark_end(&rec->sg_content_type);
> -		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
> -			 &rec->sg_content_type);
> +		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);

In the start =3D=3D end =3D=3D 0 scenario, the content type link is placed =
at
data[NR_MSG_FRAG_IDS].

If start =3D=3D end > 0 (for example, start =3D 5 and end =3D 5), i becomes=
 4.
The condition i < msg_pl->sg.start is true, so the wrap link is created.
Here, msg_pl->sg.data is chained at i + 2 (which is 6, meaning data[5])
to rec->sg_content_type.

>  	} else {
>  		sg_mark_end(sk_msg_elem(msg_pl, i));
>  	}
> =20
> -	if (msg_pl->sg.end < msg_pl->sg.start)
> -		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> -			 msg_pl->sg.data);
> -
>  	i =3D msg_pl->sg.start;
>  	sg_chain(rec->sg_aead_in, 2, &msg_pl->sg.data[i]);

When start =3D=3D end =3D=3D 0, sg_aead_in chains to data[0]. Since the lis=
t starting
at data[0] never links to data[NR_MSG_FRAG_IDS], the scatterlist iterator
might hit a premature SG_END at data[0] instead of finding the content type
link. Can this cause the crypto API to fail because the expected cryptlen
is not satisfied?

When start =3D=3D end > 0 (e.g., 5), sg_aead_in is chained to msg_pl->sg.da=
ta[5].
Since data[5] is already a chain link to rec->sg_content_type, doesn't this
result in an illegal chain-after-chain configuration that the scatterlist A=
PI
cannot resolve?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511174920.4331=
55-1-kuba@kernel.org?part=3D2
