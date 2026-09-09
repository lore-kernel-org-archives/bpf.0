Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EB39A4BA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977902; cv=pass; b=FTiavg+KQy7vLpocy9EatLgWjmtvB+N+zZ4EsRmmyP6lxnQhJb1NtVoWbvGGjE4wKy1C1d2IzdO0AbP6mUlzpvHSkE0w3kDStA2XnaA3GMKelylJ/Xr364aS3cZYF/cQiQgY1LmQR6/esPPnbo8AugR43TNQmh9LPZV//DXK6IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977902; c=relaxed/simple;
	bh=+CDkEoDX2/LXNI3w0TZ8BPrSDg27dcd2Jkj3AIOFwBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGcrPWNyvHcG/4sRMVYrxkeyodjdTjTkShxMkbc9uXPSLIMB/mB+BJc9tTDvqi2VQydc3I1FhErJRxtBGBnaBFFM5U2Tg3oM17zEiyXUEj+U1BMWejfzSukPE9i2OzetBC3rwT/Tkcn4my8UeVwBQQfG6gU88TkUyTaRRvuKqXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K786/Ugs; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K786/Ugs"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66cf1f9965dso5164096d50.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977900; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHtBn0obwdvgclfjQueDpR38++eFYsztqw+IBSWYPFBCe6qXwJchCg8IFZQ+QixJpW
         2LurM7cIAIGU1NBkg7ptzTcY5nn9WsD75bQhuQAVPvPymcenRQx0uCWVb4zcKgTEOSXR
         mQK83ItSlbYydWdU6fo7bxX92ulcBz6QM+2dUlnC9c7ccVX2ZHCzgDE6Q49Fu02d4qAj
         WyQcfLhUzVNVy2BkTy8AVysGAcD4okPK9WdI65DOJddl01tkY3s4dBfIG6FD+E+sOvm9
         lNQM3kcx2vd0rCTsPWRTT6MqalCQuiA+NP/TnTxOHrlwNFgHLS3pX+SWjGtwInncOC9r
         yDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        fh=idfqMFVMJmg0TOmpmeB+78A5MxaH3v9/NuE4MOJP0ZE=;
        b=NwBEx0mvKuEF2A31MkFwZJQUqy3V29y/MwMtjEmbYCRS7N1TLikAgzGWbHeCUqSajV
         EiVcANF8xbyGxrqa8ruAgAjZRGRIwL2HOZjYtXhH4o3Ki5FCTdvhe8icnUpwpsXBBZfg
         kj6EAtVYi99MV0waRpQ9CGVwItQku2zdGZZCphNSLPX98vfwa4c2mLug3s4bUDNkiPEx
         Ye5JjlGNWRifjv6A4c19Le2ySlN6Hirj47/TvdZ/3BD12rrUltTPj9mTcH2mv1WEejKz
         UWWxRIR+aKO6o79T4mqMzOkPDljsX8T2RACUUNiJngFYwNe9sOk1p71V4tLplBEHryiu
         ogxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788977900; x=1789582700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=K786/UgsWJ13mRcFVosouCsAqsW6E3/kB3B568N2Cf80edSGyVZuDTDeiQwOOzPWUJ
         +ItaDTNfEihzO5M6PHu+v5IxS8xZR3B7+9YhBuQKcn+MdjtQr17l5FYNUgUdLSdZdbnA
         ScmCKjTF9yaAjUsdzD02XeKJenV/vSSQN8H7gRKpCCxyG3C6/Jvy86/EH+SfYAlKJIdI
         9LqxoMOEcMZQKfB+2dvrgoahLX7vtynmozey13NE5eRykP77De179uAmsNlJkUWGMfrO
         dg2benyomZnIWpR0K4fdcCEgkCU40WoG4zIPE9+t9tcqfuyaANvdXCt/JLK5pHjQe9Ra
         tM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977900; x=1789582700;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=CGXtPG3n+PMQbbR3s8/BajSNziSpgCTgR6AIsCTJFCLpS1y3UTCtgZB3Sq0TLCMyuC
         EePbQMtp/neZjfJQ/892RxF+aTdxauzsvk6rp9KBWQoj+VsHZVasOsEEkK9UY4l8Z+f8
         Un4BfkUgYC/wvedfQALRxnAmPej3xwsZr/zu6dVG7s/KcSkvm5cXUwd6bloTHlng5661
         +Sgq7DMPKsP420xaG6cSZ42hoKiqS5s4Gheok7ens9rjuTOMl7kdVbO2uXjLKuBwnEj3
         KOui07x92FvXfd7HwxAb9wu7d+ijwO0C2cVO94hNdHJkjs7o0emF/icTtnAbnNZTCcEk
         pJvw==
X-Forwarded-Encrypted: i=1; AKwUvBzg6pB8uHAQ5eOQT8XeeDHcIFkgM4BpO34ywQZohq0cKWNp1gBu7PLIwSdKfNQ2yHJR0WU=@vger.kernel.org
X-Gm-Message-State: AFuF++mQThR14eLaHKwX7mlzf37rarxwUbhOwEGyYOV9O98FqVYhtKYS
	YgZ/cMzp9Sn1DtqVAI9MzdDRobyxXIMjcyZYFCJ5tiPKL3vIRlpoK0yC1fx4sPsox6GYYK9trIE
	QFuKmFr0JK4XQ0tO5KXptJR+qjuYBRJEJ8LH4/Q5EyQ==
X-Gm-Gg: AYBFou2K5Ba73rRsH3szkBU1YIpCnX0/4+17WlWDH602ZVF6/mQ//HVtSwCRS91sb8S
	QvgccqKBcmaDhbP1tlT7+Pi5NrG4MTEMmnWuo4kEGMgjec2hmmWa6PCJ6nJMQm31Yr3AXl0SRAa
	vH+pSmqYbMRy86saCY1BQPZtr0W1amIzXp+YaAXUlm222OKXuHsB8C3vLxJjP/TyfpS9K+gin87
	SGjAZNdiH025LShA4+0i6fBHrPUH3eumxxl2NfiMR5xOwi+Rbv64gaUWJ0zmovzoj3hxNVTGvyC
	MPHdHygh90glJ/fRptThO6stawYxeMGHLXot0dH1NcZ62A2Zt9UH6Bs=
X-Received: by 2002:a53:dd04:0:b0:66f:c1bc:4033 with SMTP id
 956f58d0204a3-66fc1bc4591mr8088674d50.96.1788977899985; Wed, 09 Sep 2026
 11:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192129.557377-2-bestswngs@gmail.com> <20260909040807.3885815-2-bestswngs@gmail.com>
In-Reply-To: <20260909040807.3885815-2-bestswngs@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 14:18:08 -0400
X-Gm-Features: AcwNN1Vllz-TAro1yIo4gS9pQ0u90xlbBvVitrlvw4Rqq5UUb-P30JRI5SxUS38
Message-ID: <CABFh=a73wXKY--GSfTTp6X0xcKVUNr-iUnqnJO3rZXp7RLvKjQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
To: Weiming Shi <bestswngs@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lebrun <dlebrun@google.com>, 
	Mathieu Xhonneux <m.xhonneux@gmail.com>, co+adfca3e91be95776@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:08=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> An LWT_SEG6LOCAL program can invalidate its cached SRH with
> bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> Post-program SRH validation then writes through that pointer.
>
> Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
> rejects this unsafe helper combination. Other LWT program types continue
> to expose the helper through lwt_out_func_proto().
>
> Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> Reported-by: co+adfca3e91be95776@bugs.sh
> Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@=
bugs.sh/
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Changes in v2:
> - Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL instead of adding a
>   wrapper to refresh the cached SRH pointer, as suggested by Alexei.
>
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..2a84f9d011314 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
>  lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
>  {
>         switch (func_id) {
> +       case BPF_FUNC_skb_pull_data:
> +               return NULL;
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>         case BPF_FUNC_lwt_seg6_store_bytes:
>                 return &bpf_lwt_seg6_store_bytes_proto;
> --
> 2.55.0
