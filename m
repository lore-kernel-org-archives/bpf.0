Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6439734A
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977233; cv=pass; b=hrxJXjMriJLcAcitZn3NSZyxAQ0KRzmu+2PcWzXGDvGIEDPhEKuQ/hTGp0QFHbUFidd6sCyk0XwnU6f7g35pY097AhXw7ny/z7Ax0ZpOFYIVCjQjxuKrn6D7PVdGVyk/PQM9+gdC1CVR3YNZV2+FuuEXszHNBJqcLeg1zvaaoJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977233; c=relaxed/simple;
	bh=ffpLcmhdNr6NOIw4fF/1zoFPIQiK4mOy2UlkzAuwzw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPg+EEzOFOyVMj7DgKD/ftdXc8jtc+yOl7OeeastDuLSq8mpyDDuMBXUtvqwKX8nWjrvSjL8rK21xKDCv8Kgk+rsWGHJ35DjkyCfFGdaBudBc52ROSST2sWyJRnO3t21ZH7KJhvVjJwuNIKaN3Wh6zu+uF4mya8ysa4Kh1Tke98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=u0XRGv88; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="u0XRGv88"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66f7f62e915so7130478d50.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977230; cv=none;
        d=google.com; s=arc-20260327;
        b=Vfam2ClwNPfLB7E74jndpMcFtkZqmP1BrbWgDthKhvs585EoA6aUB+Wsb8c/EKhrhm
         uQLlx1dDNs5CX8oyVEsP4rXnNAHNSYBiCM2vRnFlvR51t/Vw540E3PlcCBYDwuz99Qx0
         +o+3uruFekkhdcfaXdVJMwOVyzH28xXE4Cve3g6X8CGWeb5Z9VnICRu/OpF981U/WZts
         MIxEZmVjJFzRx/tPMVD3VCeVZthP+evAQo6jK+QpHA7XrABDKU8gzUog2Bg4gUqPBts3
         +DFzrNHdX25IcmbTtOC3J/pGAlsk/K+r+Vz5HhMZilzVCFOk4k1hdaapJV88o0rCJeMh
         dz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        fh=g8MPxiTU8B1fcBnSqXHNw1q0ewShtbui2o48BalZDmI=;
        b=kqy0BuBxShkFomVoEvBo94ReLXenMk5vIe2Fmq+M6uVUOqzcVXxIqcusLJl3Dkoq9x
         gJYzDOWo7itlVufVM3nGzyhwfb43xuXn+hejZOYe8YFMqC2Fmcdb3iODsyEM6vva9y0r
         O7if3wtq0bPv4LJLQ0oKT6/suCr85g8pM/D1lrgq/vzWOlXgTHKk9yve1eGoAeuKD+ZU
         ax4j4PF1L7dlWFqlR+F9s40SMXQgVZtxkAEOZgOICtO5to6FRQQafIukL2ItfTvYSoDv
         SXGawKr7ier3cQZOOVNH+1POopfpvDFzXod3iS45XTTj9oifYEV9sGepqVXkD6Mn/gap
         21Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788977230; x=1789582030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        b=u0XRGv88nCQIxehtLTPevTtlB7TUi3IqgpoQOtUO5BVi3QSvwDPVFZQIfiZwfCa3Jj
         S4viXBzwtMEnA6JKFy73M9DCvcbpd7MSh/Uu3LXmOYUeMRJF006TRC+B4Y/XhPHffL9X
         IgFickCE/xsQHHhWihcFWGgHh/hAfTa4cuiU7qac+APhrj81gcm6Bf5JU+XT6Qo9UamS
         yeRSw4M032rdpGBKMvOy9lMuJTfc4LMPAo/GRZU0FK2pb9LTvbYHouaBa8nsIorSTjD7
         kPOpWtA9sazTFT+eD5KqrfCFZr/HhV8fgC5vuqTQifEAuSoSqfvrF2MyjUjSYq5p/Wew
         xHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977230; x=1789582030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        b=ZS+yW0RQlzuvlypLCkxemwI0my30qF+m+jjGwuZyYA+t2qOEUKAwgMzvOh2mrk5zCr
         /8KZP23u/Q0Z9cZpuPFGjnuJYX+y3gmvJbnCYig3Bdn7HJTs4Oan5TuD51QL11E3u3r6
         +hAKpkwASfRDAIG57q3uvuMxD5DwdmGM4t+pxvOCGNKRrhWsLc7x9QDkXOTIKKy5gA8D
         61Ei5Rju6e56xsmufo+NxKcYD3jlr4A12tEpWTGD457pcnM2cLgK28xWqLwCrCjp9y6K
         qZvlteSy0lEoPkzRSeXNPEitgvwrrNaLIr7c2U9z7h0NhhKvAp2sFMnwSZC3TJPLN3vX
         85ag==
X-Gm-Message-State: AFuF++mFJLJOtmRsxaS2AziuT+0MpfdAI2fansnr7Bnpi4dbXCAm9xQQ
	p1PdrSokqbMF4cYO2AyQzG/KdM1/K03QOvK5Pubv/GgxRJ/P2N/Gigw0dQKUi0N++xMasOXrcTO
	Lv7BE9E+LF8oSo6RBuPKZ/xtWLhSdOOkTg/aL3KR/CEKGZpdg3zOj/Uc=
X-Gm-Gg: AYBFou2Ck0pwebBHrrnboWpJ0EVstHoSlHxaCHhJ07+M3RVzFNimJoxwPRgfnmP/3Mg
	CHcwVhvHB/HcvXUGT90KVN82R/bjQBa1BGDuggzggwrmGSXj9D+PRTwQpCDEecqsfICuI2bdfre
	vgEDA30zC3erh+GfHlu1W29iFR2zvMUmFKzNgb2dqF2ALYsNoTf5C8nFamjaQMFUkwQbhOES9Iv
	ULz3/RqSRBpyBDoCpeAndxRZ4ifrqrM3BSJHAvWfcY7EpNnoXpXp1Kye9jenpuZ3EdgF7dVyBaE
	cLHUDgryljx6J41Ms7O+/lRifPWI5jsYyNypCrRM1up5dQyg1Dh6+t0=
X-Received: by 2002:a53:5a0c:0:b0:66f:c1be:317a with SMTP id
 956f58d0204a3-66fc1be35ebmr7665511d50.81.1788977229661; Wed, 09 Sep 2026
 11:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903100921.113374-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260903100921.113374-1-jiayuan.chen@linux.dev>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 14:06:58 -0400
X-Gm-Features: AcwNN1WgDaem2ZiaTSnvUEhjWeQKvrRPTKih7rvRNQjxGVVOPW6EXSNd9iM6xvY
Message-ID: <CABFh=a7as_meC0sM5-KmSsGfvBuHd3XCceBEJ9q29Uf8V5E_gw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix out-of-bounds read of rtt_min in sock_ops
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, VEGA <vega@nebusec.ai>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:10=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> A sockops prog reading skops->rtt_min never checks the sk type: on the
> tcp_conn_request() path sock_ops->sk is a request_sock (non-full), and th=
e
> ctx rewrite casts it to a tcp_sock (full) and reads rtt_min past the end =
of
> the request_sock, returning dirty adjacent memory.
>
>         SEC("sockops")
>         int prog(struct bpf_sock_ops *skops)
>         {
>                 switch (skops->op) {
>                 case BPF_SOCK_OPS_RWND_INIT:
>                         leak =3D skops->rtt_min;   /* reads the request_s=
ock OOB */
>                 ...
>                 }
>         }
>
> For instance one such read returned rtt_min=3D0xffff8881, the high half o=
f a
> leaked kernel pointer.
>
> Guarding that cast is exactly what SOCK_OPS_GET_FIELD() does -- it checks
> is_locked_tcp_sock and returns 0 when sock_ops->sk is not a locked full
> socket. Every other tcp_sock field in sock_ops goes through it; rtt_min i=
s
> the only one open-coded, so it skips the check.
>
> Read rtt_min through SOCK_OPS_GET_FIELD() too. rtt_min is a bit special:
> it is a struct minmax and we only want the current min, so pass
> rtt_min.s[0].v. That is equivalent to the old hand-computed offset
>
>         offsetof(struct tcp_sock, rtt_min) + sizeof_field(struct minmax_s=
ample, t)
>
> (s[0] sits at rtt_min + 0 and .v at + sizeof(.t), i.e. what minmax_get()
> returns), so the loaded field is unchanged and only the full-sock guard i=
s
> added. The two BUILD_BUG_ON()s that protected the hand-computed offset
> are no longer needed.
>
> Before patch:
>
>         0: r1 =3D *(u64 *)(r1 +0)      ; r1 =3D skops->sk
>         1: r1 =3D *(u32 *)(r1 +2324)   ; ((tcp_sock *)sk)->rtt_min.s[0].v
>
> After patch:
>
>         0: *(u64 *)(r1 +56) =3D r9
>         1: r9 =3D *(u8 *)(r1 +50)      ; is_locked_tcp_sock
>         2: if r9 =3D=3D 0 goto pc+4      ; not a locked full sock -> 0
>         3: r9 =3D *(u64 *)(r1 +56)
>         4: r1 =3D *(u64 *)(r1 +0)      ; r1 =3D skops->sk
>         5: r1 =3D *(u32 *)(r1 +2324)   ; rtt_min.s[0].v
>         6: goto pc+2
>         7: r9 =3D *(u64 *)(r1 +56)
>         8: r1 =3D 0
>
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Reported-by: VEGA <vega@nebusec.ai>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  net/core/filter.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..a043d179ff1a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11105,18 +11105,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_=
access_type type,
>                 break;
>
>         case offsetof(struct bpf_sock_ops, rtt_min):
> -               BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
> -                            sizeof(struct minmax));
> -               BUILD_BUG_ON(sizeof(struct minmax) <
> -                            sizeof(struct minmax_sample));
> -
> -               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> -                                               struct bpf_sock_ops_kern,=
 sk),
> -                                     si->dst_reg, si->src_reg,
> -                                     offsetof(struct bpf_sock_ops_kern, =
sk));
> -               *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -                                     offsetof(struct tcp_sock, rtt_min) =
+
> -                                     sizeof_field(struct minmax_sample, =
t));
> +               SOCK_OPS_GET_FIELD(rtt_min, rtt_min.s[0].v, struct tcp_so=
ck);
>                 break;
>
>         case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):
> --
> 2.43.0
>
