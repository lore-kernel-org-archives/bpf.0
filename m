Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111303033F7
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387995; cv=pass; b=qBtyvBXtdSLNy0XRpBZzw9rOy+cKm2bIbRK+5qxZBr6Hl/U8oAzCyBJ+nW/obC9Hx/X6XieACuIDqW9e7hDZUvYgtoTP472Bv9Z+HtPdW26J6NeL7efy11Whqal/utSA8czdzF/ItKl1DsRDa4VjaWQ6XucL6U+ChXxiWAhnH2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387995; c=relaxed/simple;
	bh=RxRUAVn/78i5jHo+4owJWwp8B8Kzb9uHLhrQsTr+MWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnMuyuMvXST7jPIXVuj4qCGxvqHgMlGF0ewSdgo0LnbZDJTfSBw1GDRRUW6TCqKypufI5BdG9uGxga8bRpUb1ayWWNeDL/TzqwABAgnDafC96KzIMrT5UkGbVK73ejSQXPUKuOx0vncAwMZTNieuaFJ13GGptZkBsPSeas+pkRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruCVmyek; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruCVmyek"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-60328744754so552271137.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774387993; cv=none;
        d=google.com; s=arc-20240605;
        b=O5smx0E/5xeDrmQr3RFHvYPL9IesdUGEi1D+WcwTtDWLsGC0KrF53vGJ0KA3nHMziE
         viqv0EkGIZi6pWPQD1f1eacCgBQEIySAQC750J0naOOl9I/HD9UwQH+oeHdCSy0E83AT
         WYQEI+o5A+C8HEaNGxbYYK3I3diBridrvKGkM1zruhVWHhuGNYL+xt4pPX7SO+Q8mS2Y
         kFJ0EjWL/NNacsGQBB6Y/hjCCetXvw2BSDGHHIw2PBNmcIxhMrg1bbXNDJiiNzYqmS9A
         rJOt3iebpTIvSjmjlJOT3PUKa9WlPR/b9vLMdpGaJMznF4z/8CLx51IVkaesnTK67WID
         Eq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kyWx+aqkq2Ug7006TN6UCPzsYVwBflASamp+e68NhZQ=;
        fh=BTjbp9AOowxdZNZmEFYrXXah4kyPKjxoEx7ZyyU6KLg=;
        b=jeixcd0S7vLt5hu/BF9NS+ytWND5XdeIu4Cj0n2R8t6MYaYm3uK1NSdLpEHhsb4+VQ
         8r6F5yRYre3WWpHchsQ2XdybBB/sEdPd9JwxXs4IpPMOXtKciGDc/FOJojux40qJWwYE
         DEFsWYS2RXbUz/pTuflsIYXR2u8oW9RXwaeLxkm6IIaLS/qhLT1EcAV1xf6Y1f0iy+3h
         1sTtUoKm4n8jCeQ6/FR/EAoyK3XzJ+Wfafu7bJfbq0ywLyGB/HRFbMkEvSWKicMhDu/r
         MffydyAVWs0BPfhewvayDoOawaoQVoCXEKXH1Czo0uAArtUlHBWpTqjQAbag2zkZMzpb
         6JYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774387993; x=1774992793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyWx+aqkq2Ug7006TN6UCPzsYVwBflASamp+e68NhZQ=;
        b=ruCVmyekjUPVz2nb7t0tmvFF+C5tBBIlxaYlx2CBrhdae82MNyIGsUw3nqM6H3/U+D
         L1sHd21h83cx/bTYPpzs5v/qLNPNpNCUE9XefKshnf6HPraivdKwRUR39ni2Vc4l7YPj
         6X2pK19Hacf9nJ2P9FqjGre/y9n8AQ9/Z86g6HzUigEkFJ3bqzMO+0v5WZf9m96/2F2Q
         mZa6MwrNxEsJ6zFOVqwE8nRCWbUMUa3nkfeXINQ/8TSaYqBQXdTiAJzHrSaMOFgA/bQc
         cgmyehNaIax15IgfmvLvyGawICBcFI0P3hTwPGvTroN05Q+d55Egr0WwUNfj0ri7QHna
         tpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387993; x=1774992793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyWx+aqkq2Ug7006TN6UCPzsYVwBflASamp+e68NhZQ=;
        b=kloo+CFiSXwxO4rSEyewG1JXtQjQbHrsqDDZs3kCmfqS+X7MCeTc4DxpozDXFMjR/9
         AgzJL65TNwZ5/AfqcgYW5JcjU2gKNlribK64siNdrLx1e21PC/YRFrL8Yz9r5MYcWe6Z
         cr8Srd0rEQE5aEjRxNlff7loAGYXVAl0GiWo8TpvPf2Ojgzb17gUjM90kyjmrVbIKcr1
         ZG0h05/e3aJcc765/cq+FWMZFNSwm2llann5n7Eis0MkLTNjqvzrUf0fy1cD1S3nNi6B
         P54JvzaVZNya1hSaPZSstWlMoFxYjx5RhCEc6T68DvjwsAy2A6lJi7CNOsymO2MWlklO
         LZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpOO283loiXnx5xV89XJDlzv1tUpUor0sdXwLxjJGXj2nshlqpS/vsOkSpZT+UJflkhKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm28QkFQfSSrxX1i2ssd4l09ojk4U1sjMIkv4enS7dFbdG+Cyf
	n/BoE65ojBBE8KRfyN9v+1bYngMPZu+I4XRmuHfk7dg3jJWWyVBZTnwVYTd9q+yJyKB2DK3LhfK
	715BxWWAaKpnJ3zlVdixK/oRSOIDDoZzBPQbM
X-Gm-Gg: ATEYQzxaYdTO+uYq7ZKZPvniwgpPHY4Rs+Lg608J8huhPnU1IMvBtFG0dIOEE05vnQW
	KNUj0XRxbT0kveTiCsz0bMY8U7NwWfqoGYrFj2Rt52tfXB3A/9J+RKoA5JZg1WarF0pd79YCbh2
	NlCswL9MVQwYc1SCaInY8+drfwNVRwThAgkGt6Ize4oJfxs/d5CEW17HmiePIF3DZODnPkIAslg
	S/zgpkkkkpC5j8pkmqz+ne3PFUa57Ony2zlk8coMU3giv1NGP3PnE+mNa4pYooS5r19Jyi1RZ1Y
	mlgxVE7P+TG71vqLL6Sm1+U6yL36Wc/j5wow6ZArFA==
X-Received: by 2002:a05:6102:2927:b0:5ff:cd6e:85e9 with SMTP id
 ada2fe7eead31-603870e6b40mr755485137.13.1774387993013; Tue, 24 Mar 2026
 14:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch> <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
In-Reply-To: <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 17:32:56 -0400
X-Gm-Features: AQROBzCLCW2exSiL_cOM4XtuHIK1OXRXzyK8C31jzDIKMq3iewZHzitdrCQvjB8
Message-ID: <CAM=Ch04dJEf0_1+NeO1AJOBwKhQ5hcQsionMyyxuu1h7Nmj_pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
To: patchwork-bot+netdevbpf@kernel.org
Cc: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	paul.chaignon@gmail.com, shung-hsi.yu@suse.com, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:

Hello, I see this was applied. Just a heads up that I still had a few
concerns regarding the
commit message and code style in my last reply. I think it was my
mistake to include
the Reviewed-by while still requesting changes.

Hao, would you like to send a follow-up for those, or should I put one toge=
ther?

Or Alexei, do you think it is okay as is? If yes, we can just leave it be.


> On Fri, 20 Mar 2026 17:23:36 +0100 you wrote:
> > Simplify tnum_step() from a 10-variable algorithm into a straight
> > line sequence of bitwise operations.
> >
> > Problem Reduction:
> >
> > tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask =3D=3D 0`=
,
> > and a value `z` with `tval =E2=89=A4 z < (tval | tmask)`, find the smal=
lest
> > `r > z`, a tnum-satisfying value, i.e., `r & ~tmask =3D=3D tval`.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v2] bpf: Simplify tnum_step()
>     https://git.kernel.org/bpf/bpf-next/c/833ef4a954e1
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
