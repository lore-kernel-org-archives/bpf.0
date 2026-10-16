Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36552C17A3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128270; cv=pass; b=gnSqjo+3efK4mF/3NUFCEGBLHgczuM/v/hwPyShkyhGsI0ZOkF7sq6Ct45dCpdCwuaqLoU37sMdeQOAIVlmCJZ5VAbwXnui5uF5pE4TIu9lJHncBbC4aD2WwkTaaI4EbcZQ4TbSK3Uamqi1TziHQV86pUlkeWTMqCOI+F4mnkGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128270; c=relaxed/simple;
	bh=BTRcAoLz9G3GYaIgNNZe5UyvedxRfE+nhPVx4QlhTAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE8jle/2P1vuuuO+FfZVq1uvN5wTgQ132rli9tbkqH+jvN8Br1adB9iG2vuiq1IOrmtcUD35nWiKjNWVnehLrtsPtoLLxbOkVSFGevBf4+DrWp45mhjN5vqUQYtPdGMQdyymDbG6cR3YcDcNBa8cKZTGCvRrWVJyLLsctPOxqfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KHjFk8kR; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KHjFk8kR"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6790844c9b0so4718306d50.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 22:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792128268; cv=none;
        d=google.com; s=arc-20260327;
        b=op+UjurwLd+b0gbBt2O+4APTK4L9ryk755rxPBrtoBxSrRPLyCWoxchnP2JY4ctv1v
         11gTJaVaO7SBcap5cB7IBe8Y9sYICVfFftYjxGuJhOQ0bIYCGYeA5F0sSROGJCX8Dl4Q
         1IGQIQ5ACPoCCvFK/cfykeo7R7mzLwyjIGcvNanUB2lqRqecoT3apCxZ6hx276k7Qwoc
         2m4GcDnRJKzaUyF0BWAEzQKzQD6phU3T8iWy6s9F5lPO1s1+ZasqdaZm6MhaAEyNbkn4
         OYoDukwG5xKgFNkb3m4+Z338P6G9APilPQ8GOyTWpPAzLKm0Vy7kth//zMT2Vn15Hj4a
         WH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        fh=3vcqH8X49zJ5MgKDR8uJPbKi91ifgv3b5h1bwYDwB5Q=;
        b=Kda+nwtByRu1oMiBAn61sOn3A0wDccmY0CmNoTv6ms7wQLgmSMGgJddqiHz+mrcu2g
         BdtUYKRdyrwb5Q7FuPaVrWfZcnwaVgftCgQjIHbkp/BWXfkz1mA727gw4n9XT4UG6M8R
         KAhL7ibPDO4S7d3L3GgMpHaou0oi4LzWEIi+6E6bdVM2A5pzDsoL69JlCZg7qW7Yq4Dl
         uK8D+vUZK3q1LSRe7W+OfvllMmKm2obLSFIqGCrbt3FDeG71rlSibnHQp9M06Eawiw1U
         lnswBo2LKFLo0TnY+sVt2H8y3/grSCBeBh1q/5zDwMxgTQoh7y1N0TDQvltvREDRxjds
         jR8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792128268; x=1792733068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        b=KHjFk8kRUSaJYwUrFR46vsWj1trK0vQ7AAC+mCZ8TEdAScm7KiB/NhApShU5rDP73z
         eySCGR6LP7fCOkNircLZhOif1Pk+SVTAjDIp9FXuJxkdEhj8brY3lLwLJASG2Z2akJZ/
         r3dMwoKEAoBeWK/E1pSg5wgK949WILrHl/gQAwecs56k8JOB34C+z5lWMsK+IuadUZIb
         +lTQNKyMBLPGhSZBYJ9rAFU11HxWRir5z8C7TxVGh6OXwjpJm6jd2kDe/D+DVF7g6qqO
         r01srOQpDRouKvS07zctGyyJ2wgzvbCryHu2MZ01+5WBAqHz/PD5RtZVmtLV4q0Cp8Yq
         y4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792128268; x=1792733068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        b=MIOARYKSh8n/weT3hoB7Buck3Txxiw2GQ3Un2diOeeW0BvOAqUPCDKXUGoiAQ+1JgL
         0adzUUTUnlmuWdZhCH94E2mPKsnryH0PZFpP/yHMxcn1YYdF/Si/ckpPUWB4DN/OKDM4
         NyhJo/5StaVDI8o6iyACgRdjudGVhUd1U4+7Pmja2IgRWHg4FR1zSbzDI/7hThDfJ2Xx
         GYjjYMbaXdYbs07OX1C69a22lntz19ZX7+Yg0eGFCQpu/tEfDaggocMg0z7Mqj0BP2nS
         4PPyx2vG2Q8YJ3fiqOMHea+5wGUQ6Y3EaWYlxVpdfwl4o9s+yVts60j62PVc3qWXow3Q
         Jw9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzeCEqoWPmPH9JTmi+kgB1RL+uFX1EarCgq1+OEAwbunFK6GPmM4CxaKOL6QaHk2u5ZhiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtc2ZhicEtMf3usKgDsE1v4wv6hgoUWH7tpVTmz2lm3F7KSVaE
	hTBHVrQUuE6zCXrrfF+L8B5GXfjNcnQ5AY3MwIuoiUNuBT5q7+1KSVtx1HrvovXlK+zf49qZ93m
	xGWflLOceHTf56GGNzfaWmrlEEmEmFXsJB9bllJRaobs=
X-Gm-Gg: AYBFou0KtkhLgDv3wywvUyLB6FN8b7/6R0mzXu/lwIL0jqdttO3bNqCXNIeWyYgjfZu
	d3xMKhFKx+hgCdPEUSABVzT0AGmOed+/B/iQacKNqJVS2w/4kx3Q+6FqPt+N+S02vaxW6ZDqFr1
	bhS1kFZgnwohgsBNvz+6hlljhvfMSOzv5ixxCaJmzfGfiJEPbygWyOcPr8KNapWji9EkPfUu4p8
	ac3TtYKakBa98LO/csLGNwGO+RcpHd2+mvEOMBXdY0vXJ50ALUrHZdgeI9Ao/yZcdK0w9KaHwfj
	s/a4hOjP/QNDctDwEBEpsLOCqh9cpwbnfammsI/xgLnV40XUxHTZCvbGfyS0ISIpoeasYfIgroU
	1/bl6OXDlHvKXKAzNPNyNcA==
X-Received: by 2002:a05:690e:138f:b0:675:3507:46e7 with SMTP id
 956f58d0204a3-67936984262mr8103308d50.24.1792128267662; Thu, 15 Oct 2026
 22:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
 <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
In-Reply-To: <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 16 Oct 2026 13:24:16 +0800
X-Gm-Features: AclHuK87alqiyIDJZ3M374_YEDlQ3Taa4gVDZp-YmbWB5v7D8853YUxGknzxZQI
Message-ID: <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:01=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> =
wrote:
> >
> > The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Attach
> > validation checks only the maximum access against value_size, so BPF
> > programs can read or overwrite BTF-managed fields such as __kptr withou=
t
> > the verifier's ownership checks.
> >
> > Reject value accesses when the storage map has a BTF record containing
> > managed fields. Iterators that do not access values, and maps without
> > managed fields, retain their existing behavior.
>
> AI is right. It also appears that iter/bpf_map_elem may expose special
> fields as writable PTR_TO_BUF. Could you cover that path as well?
>

Thanks, Amery. Agreed. I=E2=80=99ll extend the fix to cover iter/bpf_map_el=
em as well
and ensure bpf_link_update() validates the replacement program against the
attached map.

> >
> > Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > ---
> >  net/core/bpf_sk_storage.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 1d295a8769fa..b54fd90d4bde 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *pr=
og,
> >         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
> >                 goto put_map;
> >
> > +       /* The iterator exposes values as raw buffers, bypassing field =
checks. */
> > +       if (map->record && prog->aux->max_rdwr_access) {
> > +               err =3D -EACCES;
> > +               goto put_map;
> > +       }
> > +
>
> Could we preserve access to non-special fields of the value? Since
> max_rdwr_access is an exclusive upper bound and record->fields[] is
> sorted by offset, attachment could be rejected only when:
>
> prog->aux->max_rdwr_access > map->record->fields[0].offset
>
> This remains conservative, while allowing users to place special
> fields at the end of the value structure and iterate over the
> preceding fields.
>
> Please also add a selftest covering allowed non-special access,
> rejected special-field access.
>

Agreed. Since max_rdwr_access is an exclusive upper bound and the
managed fields are ordered by offset, I=E2=80=99ll reject access when it ex=
tends
past the first managed field=E2=80=99s offset. This preserves access to ord=
inary
fields before it. I=E2=80=99ll add selftests for both allowed prefix access
and rejected
managed-field access.

> >         if (prog->aux->max_rdwr_access > map->value_size) {
> >                 err =3D -EACCES;
> >                 goto put_map;
> > --
> > 2.55.0
> >
