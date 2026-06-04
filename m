Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D73BB66B
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596813; cv=pass; b=m3vSc0toHO97fdhYrRzMuPdVH6UZTQlBMrkL+K93ZNbYPeuPxHuq+KfXc5ImptT9YICSXkuM8bzT52NhFfOsbjREmCCX4A6qqgv+Kp6bM6wXvoLd46DlAGx4Kt0vW01NBZ0ZF5SSIbsq7jEvHuwXIEnAktyeO4sFvm4tMa9niGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596813; c=relaxed/simple;
	bh=r7aiLnJmSQE/TEAofXn2LNNOIhJcr0OcXIdWzKOEMtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVRNPjemtD0P1wfMalSmMjO/fs3IRqW8S/+fIY1m1QdjZQRJ9DR8f/POFnyzmixsyAeQEcZ2nB86UqBgIPGDSldPA7bp8KuzWWAKZ1IGD1yZ2l1WX1DkCF6nFU01cPRDRE312q25AbGCb8EquBQJIpuVppdYyBFJuJ6wOq/OlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECpNZDCQ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECpNZDCQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e8833c99fcso12778227b3.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 11:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780596811; cv=none;
        d=google.com; s=arc-20240605;
        b=CdQJw6gqaAqr4GXEKuq47r4SYlFlr11e0aXgmrmmhhNJhxK9m5WFygiwetN+aArqql
         hfHyegRHpJQw6lwzXeI3Vvc/atONottlEcj1M5N52k0z/JoLuBAtUUwlugfdeyeGii3J
         FxPYoijz89sPQAJVkGQq2o7Mr/I+b6yg0q/BE3FVLXZ25aWMvMWTkC8g7EevY4i085gS
         mTXGCVjaiHdsjMhWRhww3uOiqMvPZ2uB7z1ajYckheZCHn0S7azPoshF2I39QXZFCyDF
         cXL2ov1nIc03a6X+L1IwLBl1td8NSlXKqcqrZhgAhrK3rGoG2vblCHT5s4fmKpYZZgKp
         /GTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        fh=5R3Ncrmvtt+rHqmkDY2qnlnSS1CZPtmi5OYRWes0Y+Q=;
        b=a5OINAy+BMQpk3E5ymFP/V7qxzxWeVJLXC03VAtsY+yYzBU8QHOrACGXXh7gdQhXtz
         IdSRIkaK9sCTUisFxwQZ+inBV6rMvFyUqz40mR9fjnhXeQyAXwjoBzVyt5a6pl1EUTTF
         i39ThGab3yUmFUhgyjXFV94otjC86j54/fWXlB8/PAgmUOxVc6zV/iPyIXI8W46oYxHu
         Q4ayoxUNAi8o6D/4w8Zw6Rrgqu2XiIyVEOGdukRv44jD9tlN+rwuH/9goFpaKhd9Pmls
         SjsOFdwIGdXKFvlpo+27QY2MunPG9ZNb9FHiYj5JWP/UWyR5d19BfyWc7OxuqGW4vpE3
         8qDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596811; x=1781201611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        b=ECpNZDCQISmYYP84Hh3BhXYaUqwxFAgec1YEKU/o0PmvajJMQ17hP5fy60GEirVvJ7
         cWBBSKWHn4XocHCiv90fMb3ZWkZwtZ38+CvehSNhlRo/01n0+f/I4m1kllE1CMgbHZRo
         wSbvZGc8ZpXXbXNJ7adVxrkAj2BLI/ZaZWxvTk8iBgqBSrYudj2Lid/z/Tr729Zty/s3
         agM7niCsVBrfcYUAcu8JR6n61HDr5b+sKUTWgIXWFilhJG9iPj94Qsrc7KE9UGMrPwx7
         8qthZxwXcMhaxeExqRPjplPo51u9cNSUJgaiR7fl+a7kyJRqOnBXf7RI0tnoP/MK+wBz
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596811; x=1781201611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        b=W9Jg00QpT3MRgAxKBPVl8kSt8Ngaum1i2lmBXVMtOluoR9MpJ3iZME1+vvgDkS1o7e
         R45OTgkqx/haIlPmaxMbvCMgkTNKd1jmjFXkB9fE42LsNV/spcstK/SWe4xplyRuYmy2
         5g5GMYLJL/aSAZM+HwD3unoYxwABR5SjvBmpALcuFseIwNMbvivr6o+xn0DvioKGxCZt
         0mEuR2KSkusMmVBGDWnd/0CCwt5T97jUwwEwYbn0W7NRekf0qYjxi6Inaaqr3DE5YsP8
         uEzRvmoIdq23HQuAvhJzd8zIi6/QtiRR88GHrDPt+TqrlxqbjsH/ujV0MHiphEabbnWW
         2Dbw==
X-Forwarded-Encrypted: i=1; AFNElJ/CAsGTfIcZBxrDRp6HJ+f4XbY8iFuO7ImIGUfHV1azxY283Ywpp9iEpDkUKuA73eQaMXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAQpk9XyOpCk4RSAKIipcBTTkMjYZSvdNS6sorYce2bKyiW9F
	my3cxfFAEht19ouevWw3mOxFCCV5p7C3eHzO0I0dRJl46vm0DVo2t+3j8UBgVoyFA/fnKhOeSJ6
	7YUmFvZVx4zkHJ6YxohKgJJzm8LelBt0=
X-Gm-Gg: Acq92OEPiiT81jZzDnexcVxtTnTv/s6hOVlJ5VAM85LDoxmKjEC7rd54gEQBM5x/cJj
	p6WfcN09iuBhLtmK3DM68g8dbaN+6XIMLbYZxXmoKq70TjuZADfnDi/QD4fJhBSKh8Tgqj2l6of
	+HzHdA7tZnWmtYmkaxi7ztGCc79YyVyKxiQuqzikf/Td6RMQ6a03vpiTtMPHdas0Mx4hOBdX9dR
	7JDVYaZHTRZwKZAqzsdeM32tR+J3ulOyBLe17NuHr4kfkAiv0nCMvqkwL3YTZXNnrDVRyGVUngk
	oBZ/Fgcsv6cCIzamih0=
X-Received: by 2002:a05:690c:6a12:b0:7bd:7c16:170e with SMTP id
 00721157ae682-7ed0dc9a14fmr305207b3.22.1780596811259; Thu, 04 Jun 2026
 11:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn> <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
In-Reply-To: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
From: Magneto <magneto712003@gmail.com>
Date: Thu, 4 Jun 2026 23:43:19 +0530
X-Gm-Features: AVHnY4JkyXdU41yKdGlaIvP3bPb_0C-R0eBTkcgq9jckSbHdmHQXWlodnAPuYpI
Message-ID: <CALdn3FES+6N28KiHdzCyeddQd+LTfQ3gTsw2TM6Y42amwUbeyg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, dxu@dxuuu.xyz, 
	stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:00=E2=80=AFPM Nuiqi Gui <gnq25@mails.tsinghua.edu.=
cn> wrote:
>
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. A concrete inner array with a different max_entries
> value can then replace the template.
>
> After a successful outer map lookup, the verifier represents the
> resulting map pointer using the inner map template. Const-key lookup
> nullness elision consequently uses the template max_entries even though
> the runtime helper uses the concrete inner map max_entries.
>
> Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
> because the template max_entries does not prove that the key is in bounds
> for the concrete runtime map.
>
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..bffe12d0bb289 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier=
_env *env,
>         return 0;
>  }
>
> -static bool can_elide_value_nullness(enum bpf_map_type type);
> +static bool can_elide_value_nullness(const struct bpf_map *map);
>
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
> @@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>                 err =3D check_helper_mem_access(env, regno, key_size, BPF=
_READ, false, NULL);
>                 if (err)
>                         return err;
> -               if (can_elide_value_nullness(meta->map.ptr->map_type)) {
> +               if (can_elide_value_nullness(meta->map.ptr)) {
>                         err =3D get_constant_map_key(env, reg, key_size, =
&meta->const_map_key);
>                         if (err < 0) {
>                                 meta->const_map_key =3D -1;
> @@ -10225,9 +10225,12 @@ static void update_loop_inline_state(struct bpf_=
verifier_env *env, u32 subprogno
>   * lookup return value nullness check. This is possible if the key
>   * is statically known.
>   */
> -static bool can_elide_value_nullness(enum bpf_map_type type)
> +static bool can_elide_value_nullness(const struct bpf_map *map)
>  {
> -       switch (type) {
> +       if (map->map_flags & BPF_F_INNER_MAP)
> +               return false;

One small nit: the can_elide_value_nullness() function comment appears
to be out of sync with the updated parameter.
