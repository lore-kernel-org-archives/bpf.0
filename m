Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FB46C4A3
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390297; cv=pass; b=IZMz6YtnXZ7EBtf32J3idOnfFDJeHt+nUMpewWs0P1UQRl+Dg902Vss8i4A6S6Y6gqdlpQxinlsQFYyCnq8/yLa2ZHr9Cd4rYLUrY2aaWSuGBL+1Ck/4ZapGkESML26ZV8Xn6FYsTeyVALf11tII3o+lZvugmTeaXEDrcUSe4Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390297; c=relaxed/simple;
	bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0hFAElibZ+fmfZfw78ldz2cj2LYNPw8aPT0p6tqYSvwMqbe48Ka3I87C3oF0kBiReZFzvGys+bxTHnP19QuQbQFud26kchQAr/FncbPfSMyLEeBKPYQCmr1fF3k11ZjODpwjyka45Oofx7WSu835aqfvzolD4HVq6h+SSQ+iWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+VK7vZR; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+VK7vZR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so2007146a91.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 16:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390289; cv=none;
        d=google.com; s=arc-20260327;
        b=K5gT+gy1Rtv1u371uz+D2ot35H+oInbZwg25eDTEsEgujm8vSFtH7xIdWzO/1DoYst
         t10hreXDZgWtMCUZaUwpi3LXn7Mtm0qcPOkvMyBTuxhzWPdCNB3vwxwJLVwGkAAC3scI
         4cUlOBV4GjMAwRWGTaIJOc5Ti9nPgem65TCKISu8we12mi9xXsEA0Bvr34xUfxiXm1M5
         O4YZyVE5fUdA1pxMyBsXhdIv1aeYSfSqXSjvHWXqpO0ROsM6YWWFZgUvaU4DqJIdmEtd
         yk3KZRt9jlVH69VBYttlrhF2iYK38h02NEoiZEdJmCoE/5N+Qc7qwTbgJOCq2mbaTGM2
         b/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        fh=ra2/VZw1ckvWrHwh5Y6w7SUNOCfa9oDplvIaaaT2cfA=;
        b=R61YwKAhPru7rK9WmvPri5r41qn+KKArbn1xnpFvzana9BNqIymiW++M8ZrtKylnXg
         2bYqhLp3gj/q5fztdJL7H1XZ+sdThSKGt4eV0hFrEw03TntreafiqFJtsPjnAW8E3ua/
         /PGXDmIvGGgZh2W9du7Le+Y5kFiLTyNO3ncCvSNC5oELx3gbE/oItNPpUX79W0eU3ExD
         P8E449k7g0e6kiB4KL7n65yIiHJU1nZhUuE5SkRcryt0rBuYDmBJ3ZSx92wgn7AN+IbY
         h6+PvRPKka/uQgt3sDtQ0cesehlPNJBss+c0lvoJozX+AEV0QKG0LwouoLwxcaqH1M5x
         ykzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390289; x=1788995089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        b=E+VK7vZRF+UAaweMQupmYJcDtfYBCXTmfbly6iB1bEIecnOxjhl3ZGTJP85kBzzba3
         BWfclCerpJFce0/ObOT0+5u57AMR/Ld9bNfttf5t/9uwIDH79+wsNfQx99uMrcmOf2Jy
         eNVS1dcHV0YsbgjWFwjiYQ+vhiQacebt0Y1RkeIwA7K9xYmQpAnK0T1k+hBuK4ROQzUu
         /0UR5SEGv192wGNrPfOX2R/ZLK9UPTjV0thLrPUbgArW2Uq97ld+4RwBGpp7rjRLxbsJ
         RoRuAKKT8D6TGBjkWFf4IHUUSb+ceyqI8uTKL/ns5wg/GZJORktsGcT13kZ+6ae7n/9C
         WaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390289; x=1788995089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/v97SxnXWUl3AzCD8i4KYWPlhfuArXwfYgURlq/8OC4=;
        b=I1mKVt6IRZY463xlw2kPDlmgvyvSw1KbI1tv/kFki9oDEvoDyM7g8UxN6EB8ceXcRf
         IyN6p//y1aqCTigMNTakvy10aucTdgJ66ZHFdsr0Mz5mmIqaQm3f228W00xHRuSjAqyX
         2WMR5ZUDSgvOoXqnpJss6AHEfThw8tFwvTRUOs2n1YOXNgPIYSl6rZyo6o0DJfuL2pD4
         KHGmB4AbDxlJP2c4KYpkGWrE0QCUrBqINIdQleC/KuESv0YO6AhulBqwKqnJUvBCJceL
         jBtzLfW8mz19V1R7LU9kep2+dRAOwgLbLPrgdW7VkuvJE0/I+uTKcI7tAe0BV48o1IT0
         Ovpg==
X-Forwarded-Encrypted: i=1; AKwUvBzBYbYCXNtfF7MY51s9rtCmICW9n52rijJky8NPUYOQGeBzcx+OZfv7X12zeP7nMpPBTAE=@vger.kernel.org
X-Gm-Message-State: AFuF++mHBBcx8kQO+jObeNRPIn7/uNnotgoGC7l+260CmFyb/Gh4cRys
	SGEFdTdzXO05D1QbsYLxPeKYoDZLFkT3hJqjXth4DjA+sNF+FqHIk3u4Rgq1Uc/IFEKv1r5DYxn
	NQ54Ljfh1O5Jke5qm47iToRO7d8/YWDRVRbHJ2Lcu
X-Gm-Gg: AYBFou273urkmMlX5T3Nj3FQe6ohNGrfQv5HDi7/lUsUR9boS5SgAr+W/q1SL+zeUTR
	RW0/Thp57sw+FALdz5SUrFsCqGEy/3AgkL2OV6ct2kYKSAmmH4KkjrD0WsqlSjDqGkSTj4hYBJz
	VMoYLgnaKtfVzvYe46TNsC+vTc7l06MNf1WrKOnZKVPxuy9Sj9o0SUVKGKEAiWs1to9tDhyEB2K
	iGn3f/f1R+r6mpdEa/xR19fqXW9OaDVx9YT1ymuM86It4zdqLAKCfiKRHKV5gHyI8/r66a0le3U
	31uIKiSU0za5bXw7DblZJO3i3mn86ffO+5daFpmmobz9WSZk7+69Wxt8WImKYELgsNFUsV32dhB
	N5Zkma7JAh5X0c5zBuScpNvBr8nkLV8Q0jjqTz7bh8jGrC69SnfftZP1lN5LH7SRRmezILCGFkK
	X5D1rwkWzhwJyL
X-Received: by 2002:a17:90b:2649:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39aee249be6mr12032469a91.25.1788390288724; Wed, 02 Sep 2026
 16:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com> <20260902155216.4fa23444@kernel.org>
In-Reply-To: <20260902155216.4fa23444@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 16:04:36 -0700
X-Gm-Features: AcwNN1UkbVzkWQ8FDXuwY9XPS95VYwqDS1NMCf7kWqvgYjJkEoK_LkIEshdICok
Message-ID: <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > Several BPF socket helpers acquire a socket reference only when
> > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > re-evaluating sk_is_refcounted() again at the time the release runs. =
TCP
> > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established sock=
et.
> >
> > Due to several bug reports, we are now inclined to forbid the
> > buggy transformation.
> > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguRo1Z_=
4FxO=3D02KLmwmQ@mail.gmail.com/
>
> Kuniyuki, would you be willing to send a patch to do that?
> Not sure if anyone else is planning to, I wasn't..

Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com/
