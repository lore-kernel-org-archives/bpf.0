Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7A3F823C
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193344; cv=pass; b=l8ESlwJxCuFLDMyLKYIZGeJ1pKct677kh8oqWHWlehCoHl9woFnbyhRgcZtYVweB0h+OulVz9GqaTpxnyGwdIFdNeOiACMTB8I0cksBGRFcTCaMzHcOinsnlD6PYIO25gKtL54XVudP4ipCfPB7O+JiarW9s0wWONcd0TNPrrqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193344; c=relaxed/simple;
	bh=6DoAEKCsNOaUz2PTOJynJRn0qQq/BYfx/LsuRo3yo/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EduTQ72F/Jmo5RjkndK5vkEmjEH2dqiccZtTIK8gicf1nc2uzJ8qE9yJ1hxel72i4TopvuhgUmq3MVc3FxDA3FwwnXh0t9hyM3lPBRudZ9NY92H7oFYfaLvj5QbAzwueJI5wbqIPc4bYsPxhT4Uf6MOi2WGUjGOl2NRO/cpRqrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNzslSXm; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNzslSXm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b33f7b23so518356066b.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785193341; cv=none;
        d=google.com; s=arc-20260327;
        b=NhLlV2MvT8j5uziv1WCD7QoKTaxG6ct3tFU0YdlRnQzh+9q35HnDdG75pYjU2R0vl/
         G/9k5oBsH5B/7JyMY1PLoEfwrdsb8EHt6pae9yzAVPxQxI6NN8Baj662yusybqw9uod/
         7Q+z/ZUnFyPeRco4MwerhuPb2KiY1Sw0QIc0b0RkIxIP+YwbH7Vbi0MwDUyiEspD6xs6
         zMbrmwvVYPdfm8Nq5HHJU9O3b3lr/EhNk37O4iyvclewRUZ0Ykl5qki0O/Na5ZtkaiYB
         gKpfH5ZaxvytD/8EMBNrF8L77mJc4ORW2XLR6zIW4f8CT+7YtFJ9/74oDOpzlNhTWntJ
         lGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9vEbo66DqxPPuInuSLQZriasmmp1SqZtCdl/C/0z3uk=;
        fh=aYWh8h/GZC2EgYNIUxXJNJP//lbEYAtK75WTuEP/ygA=;
        b=a1Mnvri/ZxlqEozwqQnWxQRIIf21bAatF/9ENtFEM2jnTw7hSl8mdOTr2XzrlVHKrL
         QQIH5z8VzN78u+RMGP1mZYN1ttWdk9L9XoHmf+e5+yIpFfJ6e0gwjPQJK91hHYK+Qe+x
         +OPUFGD57ly+B1HT37+Es98iytCVuq9mBB8F04Esp5VVyWd9cIXgMOvCUFzlCHIV3/0D
         dUEO8mbIkQv0aKMAMS7uj67D0oU1+qzSWFv86si0VfRRmDhZgh/D6buBhAK5pnmw8rwr
         vmja6Cvr3u3iPVnUod7OB85JFyD9pLBxc88NQR5gDv/Mw9zLYUocqd4Tt+AkxeNgz7Eo
         KHbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193341; x=1785798141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9vEbo66DqxPPuInuSLQZriasmmp1SqZtCdl/C/0z3uk=;
        b=ZNzslSXmt7WWRg/p1LoZf82UOySdn6xpr8KS+0A8GXyprq/fxjYy68jC/Dl0TGsZJo
         9UXRHcbTqrPpCGnPytJy7pAMMWqt+s/+eAohdt5PZGrDu9m2uu05pWTQjgw14vWwuJCH
         PFXXHkImC4SoxejXyVJw5qmsYvlVCDdiCvfGvS72JUBTlwdik/1y4TWcNOABmYiuacb/
         u5GzZrCrQIOQhnPKBxqsNyM8Gd/UnluRZO/AN8XKCeZ6AMBlOXRWOeDXPGvn7zOZ76bi
         w2f/84aT3Lc10rkaQuUA0+pFVMIBGhUF1+7e+F0n6fhBDRN1U3hE0gUcymXcpM8EDpgN
         4BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193341; x=1785798141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vEbo66DqxPPuInuSLQZriasmmp1SqZtCdl/C/0z3uk=;
        b=m+aHKKPiE2fv3hxCjkeqxWaBmuQYHvBmVhWMcO0p8g1oEEWGQ3DCVyB30asFF1y11e
         ssgcTUIbNVXCaPBM8Uah2S2Jh6RVefYAecw8OWfKq1JsmkFhe/pSu3L7+vYV0a3yELwr
         HB+u/EMMVQ0jr64NX0gWN1ZSZ7CJRImBOgV7p0v2ohT5ik+j+J8u15s3XXv66Iw/1Fz6
         ZmuLlE/Pso4XP83MHQy+J2UzsL29qdCG8HCFdBZfBHjeus5UTBUycxkQUEBbKZT1QPTa
         AqKSA2NXewURV2wdUXHS/02rueCmYZ0wRLon6bJWS/mCHll5D7T97VINca8vzQgMABPj
         bD1g==
X-Gm-Message-State: AOJu0YwoM4uBkdlhHJn97fp7rxfd0S4i2i6+MVpRAC+ydK+Qy6jfD9gE
	sO4fuEmMgdi7qSwoeOE3plD877bygBGuIymbhICLjFezP20q0kaSNi/DZ4yWpHMSxgbqrNG3+ts
	9Q5L/bBzZo+uQZPQBDR4TxjVwfteLUek=
X-Gm-Gg: AR+sD11HYjVQ6FHN11QpCK47q3MUMjpdXFFikjGquq54ASkKmRb1Zr4E2J0iLpHr/so
	IExIG5DIgPeth9ctiyt7iRV7j6VpHy8oDMAFhb8Z/p8JtkpYToTb8FeADegZjzLU67xzxiepl7S
	1/mL6OkPXy2oY7uzxTxMfDPC1KPTXwCybUjEZD8MaR3LuBXkW2kDrXS0QgtKBOdYotzbbk8ahWH
	ZGfCx1dyNsaljuaGJwSLJD+e9fZqSaLYkpgJS5Yq/dnGlVQIOvux69Azd5oURk96FKq77IpFCCE
	21JVINb0Q66/fFKIHgCBczg9dh7gg7aWjBtgdWBKleGNYPPiVE4sNdrqvA==
X-Received: by 2002:a17:907:1c9a:b0:c12:2b09:6c83 with SMTP id
 a640c23a62f3a-c1f1f09ef40mr511466666b.33.1785193340623; Mon, 27 Jul 2026
 16:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722072326.1545677-1-pulehui@huaweicloud.com> <20260722072326.1545677-2-pulehui@huaweicloud.com>
In-Reply-To: <20260722072326.1545677-2-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:01:59 -0700
X-Gm-Features: AUfX_mwM_M7QQX0oCn8TYFPP0E5sesd8EN1P-Z14QX45-bcwL_VWS4BSjIB2Q-8
Message-ID: <CAEf4BzZQo9vidTkr9kORbft9Lhx56JJujWQit40xem40TjSS1A@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/4] bpf: Fix potential UAF in bpf_netns_link_update_prog
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:19=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> In bpf_netns_link_update_prog, the checks for old_prog and prog type
> are currently performed locklessly before acquiring netns_bpf_mutex.
> This creates a race condition that can lead to a UAF issue.
>
> If two threads concurrently execute BPF_LINK_UPDATE on the same netns
> link, the following execution path can trigger a UAF:
>
> CPU0                                          CPU1
> bpf_netns_link_update_prog
>   if (old_prog && old_prog !=3D link->prog)
>     return -EPERM;
>                                               bpf_netns_link_update_prog
>                                                 if (old_prog && old_prog =
!=3D link->prog)
>                                                 ...
>                                                 old_prog =3D xchg(&link->=
prog, new_prog);
>                                                 bpf_prog_put(old_prog);
>   if (new_prog->type !=3D link->prog->type) <-- trigger UAF
>
> Fix this by moving the old_prog and prog->type checks inside the
> netns_bpf_mutex critical section.
>
> Fixes: 7f045a49fee0 ("bpf: Add link-based BPF program attachment to netwo=
rk namespace")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  kernel/bpf/net_namespace.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>

the change is good, all other link types do take lock first and then
do all the checking, netns is the only oddball, but see implementation
nit below

> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 25f30f9edaef..9fc62db1441c 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_li=
nk *link,
>         struct net *net;
>         int idx, ret;
>
> -       if (old_prog && old_prog !=3D link->prog)
> -               return -EPERM;
> -       if (new_prog->type !=3D link->prog->type)
> -               return -EINVAL;
> -
>         mutex_lock(&netns_bpf_mutex);
>
> +       if (old_prog && old_prog !=3D link->prog) {
> +               ret =3D -EPERM;
> +               goto out_unlock;
> +       }
> +       if (new_prog->type !=3D link->prog->type) {
> +               ret =3D -EINVAL;
> +               goto out_unlock;

can we use guard() and avoid all the goto jumping?

pw-bot: cr


> +       }
> +
>         net =3D net_link->net;
>         if (!net || !check_net(net)) {
>                 /* Link auto-detached or netns dying */
> --
> 2.34.1
>
