Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA8392C29
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934343; cv=pass; b=HT+/wOtSq1y3Gw5B3KShIrc6H4UHltpL0yHZ9ETI1oqmiWd9je0XqbiYQERo6JPMtme7q3nNoLdf2y7uI9rFEaJTwPbIA91I/0mdv5GXa2A+iORKTqjrG3LuvIW/w8haTLeW50/LL6REhNbYV0Gbhm0nrLqtOMJmR2+6TtvN/Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934343; c=relaxed/simple;
	bh=/RZvXQuviIKjERdOUPCvy5U2CWUH9PYXFVSplrN1NGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUhLuU3YO9yv7c6NzNZfu7qz6bDDGvNOmuD6IyjnaO0rEuFOyUXfzLVxiliTYKgZnoqTGjzAraSKtolkYPBI2kW090HPSRr9fnjdVGHRh3IYkWVpit1wJoFLauujRPBynI0/UNhjT4wvS/Lx7egPeP9NCnKdiGOZZew51lzCVmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duyRvp43; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duyRvp43"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so17150465ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782934341; cv=none;
        d=google.com; s=arc-20260327;
        b=jLF8+lcaSRdWOVEc3rjl5KCZVC6FEe3pCWkYeZdKvvxaL8IU9t/Mks+PVYbM0anNLd
         5mBVy+l+ROXd21ehm6YdT4JU61XT1p+rq7xb/iU+JfnhL8hR9GEtYoTSUWoAIvLkyWfc
         dYX5St9mvaXnazBUt84jBCUz42OejdE9rpGdqhr/VPwUEBrdiqn/PvnPJJHTOK2jypMa
         AyeEkZPPSQPXgwATQcJrHmm/Z3wK6kRo/1U02HhgOTrfYEMvcyxztTZ6GU6dQx0MLQOx
         CJA0IIhYZZ2NhSK3K6cn84d5tsysu4cyLhcCqagIkefALpGhzmxt6Cn8i5T7c2XTykmM
         lfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+YkcI/qiltpqXhaOZqyvCi7FfaSc2Wpf/xvgMARz/I=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=T15folpWO0+HXgkxYV1VJSPES/VK1QDIUFWQbIKFMR0HbfdL++HX+8tTyCoVEn5pRi
         5n1bzT2r2ZbbpSuSpyJ2s/b9RxNwpilrttfPe3ywsNoZMzFrxxqC6JY0AWY4BLDkXwpd
         YtqMYlBagzBJ4LcDbeNFqGIjLZhNLe+JsFi9Fg1LL/PvP8MT3oyh+bLHKnrD+J+/eGOR
         /wSBKEBi2Tbyht4KFkWGw4tQ44QaoSkmrlugokzKTf8zAeA9rwAM46aByiMVOEGcPBMk
         xndI/3Kae23ToPPutwXdl2xwbtFRVfvsnGeDlGdaMUcavLu1AdXV9f2V7vlkB38rwaiH
         9r0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934341; x=1783539141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+YkcI/qiltpqXhaOZqyvCi7FfaSc2Wpf/xvgMARz/I=;
        b=duyRvp438KLHq1W+DGF4NH22eOyCZl+HGzXhMEC9psSqQdDuwL8krG+04rzvUxpZh0
         sjHK5pfgUUy4GL7YVoPdLYhFtYezMux+t6/Etqv7vsbrz08e9sCr7qbmnfFWDHswzp85
         zQL8HKV6NGKgMpxRaeQayoaByITliQDUrJuNoMQ9uZ8L2vysFUFLpi2Xus6qfDMrlxqe
         v6aGFybOlF3cetA9/E8wCkiwb8z5GQLhEQc1N3E2qm4EYt3oZr72XD8t19a9fWVDCG0m
         L0VplM9Gb65fVYBzbSrC5761OoIsAdegfDwTjhXCsDO9mHKnYiH8KmfMbZvQm30AGna0
         1i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934341; x=1783539141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+YkcI/qiltpqXhaOZqyvCi7FfaSc2Wpf/xvgMARz/I=;
        b=jH8dD0eoc4Uuj66J35IPS0wSIW8agTF7sqU01DQR89LOlMr9WTIhIFq8Po1ZvA3ZLE
         g7I6BOZWquGyNgo9zlGnmkvqUH2un2pDcsqMz2DPgHxgdwlsNmefV8ye6WUd59A0RgY8
         IfgHT6x3zfXoEbflqeTRvI6R+I5iIjeqsG+IyXKDPHMSrMURnry8/TuKsYS5tYdW2Xmg
         gPU3JKLtPf5+hS1xm78huT4JtX1PQT2DJkUAIb76yrXdT9z6imH9r6xLnGGMDAhqD6ih
         8SMiTqBuT8rDr3ZXvOyNjmCup0jmHKoRMOhgqzWTsRsyhE9rckhKvu/uWIOnE0U5VblD
         1Leg==
X-Gm-Message-State: AOJu0YyB9GjhLKkdosdWBgyS1UNTZ7kSPi2jG8tTbZobNHnpgnvaI7x5
	XTqVfprReI5l/UznmLrFRAdy4jRvaQkgCFLuivkt5cYYM+biMuRgjbBzEiHl7G8eN6RiWnBnggb
	H0u5wBpX7BDkXkTmLrveoctFMgPeV+Ig=
X-Gm-Gg: AfdE7ckcasR3fdceOKHjzoBLtToMAQtkwqHkj5DP36VMac6FzQF2ITDzE0ltCy4+827
	cEq6YwRIrYVyc9PAqA9fImdYBdLfJQGHUGnlR8bgrtwuXXmKGCWQAoGmMv0sx1znUush6CjkL5O
	oiraG6esZlVSoTxKs98h9dCjiSTwNlokMQzIsO3nV2cp/pXbl1lKlci4qNDrZ3WPt0wBXJ27IVj
	uF/58jm5HX+PmmfjafZa9Bzie4fLzK9CPKAyq2wFxWl1ZKUzsLWl6GR3RNsH/SHr2+GrKm7bG7W
	gcYiWbnZ9NTCumja98qYcYeq+UJ4sTJdIXdmjXrrqLo9tNGdqS95fjZVXRa90Q2j
X-Received: by 2002:a17:902:e54c:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2ca53f73fefmr54977475ad.9.1782934341579; Wed, 01 Jul 2026
 12:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629152406.52582-1-leon.hwang@linux.dev> <20260629152406.52582-5-leon.hwang@linux.dev>
In-Reply-To: <20260629152406.52582-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:32:06 -0700
X-Gm-Features: AVVi8CczmSeujx_AKyHagQGJNsjmXmV7uzErQkbJ0H1vmGYLjCXAb29ckN_chSU
Message-ID: <CAEf4BzYVdP23ASHtAAzpuGH2Agx+aXRRxTsy6MZx0OgE+OffjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add support for global percpu data in libbpf by adding a new ".percpu"
> section, similar to ".data". It enables efficient handling of percpu
> global variables in bpf programs.
>
> When generating loader for lightweight skeleton, update the percpu_array
> map used for global percpu data using BPF_F_ALL_CPUS, in order to update
> values across all CPUs using one value slot.
>
> Unlike global data, the mmaped data for global percpu data will be marked
> as read-only after populating the percpu_array map. Thereafter, users can
> read those initialized percpu data after loading prog. If they want to
> update the percpu data after loading prog, they have to update the
> percpu_array map using key=3D0 instead.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |  3 +-
>  tools/lib/bpf/gen_loader.c       |  3 +-
>  tools/lib/bpf/libbpf.c           | 57 +++++++++++++++++++++++++++-----
>  3 files changed, 53 insertions(+), 10 deletions(-)
>

[...]

> @@ -1975,7 +1981,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         map->sec_idx =3D sec_idx;
>         map->sec_offset =3D 0;
>         map->real_name =3D strdup(real_name);
> -       map->name =3D internal_map_name(obj, real_name);
> +       map->name =3D is_percpu ? strdup(real_name) : internal_map_name(o=
bj, real_name);

nit: I'd probably pass type into internal_map_name() and let it handle
all this in one place, consider that for follow up

>         if (!map->real_name || !map->name) {
>                 zfree(&map->real_name);
>                 zfree(&map->name);
> @@ -1983,7 +1989,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         }
>
>         def =3D &map->def;
> -       def->type =3D BPF_MAP_TYPE_ARRAY;
> +       def->type =3D is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYP=
E_ARRAY;
>         def->key_size =3D sizeof(int);
>         def->value_size =3D data_sz;
>         def->max_entries =3D 1;

[...]
