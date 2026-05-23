Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6D3603EC
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525053; cv=pass; b=VT4xMY65A+GCZe9NEma1ZvkNSfBanlKh92ZgFkFZ73Y05vTaeUse8iEac8M58Ek3hDUjcHhm4pD2y3PS6NiEI/iZlhrVq0euxG1QDLfBWB1YRpWxnj4ZxIQUZ5mkbyr4pUsXEj3vk4q9/qcmaP0NlPdZ2BhRBmNxFRK9jyFdNrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525053; c=relaxed/simple;
	bh=5YUzcTRs3VRlWzNPlCfwQ7vEMTYY0urRriVE52jCL4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gH7MZJglDM6+Xbo42UT5Nf9rW7x7Cc1hvBhK1tgBFkSZ9ExHhQNYcYFddiZiLy4JQTQFagmImrFAMm0jExdAjB5eJW17Yj2JAJF3EKbaNGcIw/uW5wtvphMrMl9F1X0AUV78xx0Fow9MEQSImZWMr9iPKodviH/oqU5W0XCqsQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QekVDG0L; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QekVDG0L"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4526a8170ceso4044244f8f.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779525051; cv=none;
        d=google.com; s=arc-20240605;
        b=fdXvtkoUSYDu85czV3MQ7QRokQBuMd42xY05FQOwq6XgQ9UbPeBQHZ7wD5WGc+vryx
         U+it64UUUBDhAd9J0tE4Xxv8AHAqgJtsmlvsKQbYZbtyzpaUGb/I1KxjgQyV/eb0ArhM
         5epEwgFEjbj6+DFxgEA+OQoYKQgiEPbSYR2GOzmrT7BT0uZkcYXzD4dHLsY0dyCWeejv
         lgDuCtyrD29oqtQjEzKIbb6BfwQdcziS3QdW8Mkz7UEYLbnsgIVW8GZcn+WRcIn2l7CC
         jzUSLp8tXlYY5rvfRBZ5Fgp3KIXSVDi04aRilwsXrBHsEasWyKaPvEj4zr0zL3/hYyCL
         FuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qb9SR2DPOiU+QQKzv/kuhzlmQzJ/gw+m3RLW3kd81Sc=;
        fh=WYSF3SsiJhGVXJBb7Gjy/Gw+A6MeZC9o3Ol65WG4oL8=;
        b=N2HnXqp6GF/7ThTaaZXBWSG5oNShytZqD3+CyGa0xB8EiKfMIVOce3IAadkR0rVNh7
         tw3vQbKRsag7XcH3q85q/nmAUP9LEUlSXuHxQkJueIEK9yuygyiUhKANSUZam+X/n0IN
         rPBzkpM8ZzyncQZNzKbkaLw1iJ3EMq3Bg1wdWbFl3I+ieTqcAe/lRHPLABd5BrUijfOk
         UN1+nXMMerrfIPxug1pLVRDkyZfz+LL4VjVPFJlTZjjOhWpkLp3+ce/PGKQVpRRY/k29
         T81bYv043zhozduDZv1pvnJquTxuGBIMVtrne9C1vsIcdGIde3mid+xQ1WIbIiRb0tmH
         DBaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525051; x=1780129851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb9SR2DPOiU+QQKzv/kuhzlmQzJ/gw+m3RLW3kd81Sc=;
        b=QekVDG0LxZE00PFpSwlcysI4zdS/+J36IB//NhnNjtNs46hMvKP2EXH8/7Afx2/jNB
         FQoSNHSe7sw/KqJJ+YHF0lj2JUtwiCMyKZwGPvBd/ijW9SVZNZ/aZpxdSO/gn6DxdLiR
         WgN2HlwqDbd0B2LAcsiMGP2Fryaa2NG0/YATnnfdTBnJM8qc+BC94o4XN6nRg6ioEXR5
         4fFDbFCnSjBk0vZuQwCQk83frfqpetz6Uy5c+dZjsnNOidgG3NLgElqnjiLhV48heoH7
         0fVhRvuEk5VBDaF2f1dXvX4sy1SFFA2zIV5HRV7TNRJeUNfBPocJAoR6TTpfoTGpc1Rs
         WOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525051; x=1780129851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb9SR2DPOiU+QQKzv/kuhzlmQzJ/gw+m3RLW3kd81Sc=;
        b=Zrtxk8ZaM+uwyfpIS3wzvoCimDdcQ5aP0Kk8Dvjo26VZYOtfI/OZz4Qo08UvMTEeJ0
         W0/9EzQFlL8dYMktLuaPOF5X3kiK6N/ufl7aXy7DzvcHPGrcxE4yHYtcSbVjdloLxLm3
         xaJn12GYQmusY+fzDJaY3/jmZ6yo+I/edOltx5MvanIkysgAHcqaEb6kbc11unnct7Rq
         f1DEpT+Jm9DJSjeEi6J4KFvc/15uTGZPDegUVrYFqmp5JhMVcH7MeLdQcSs0U1K0oSHj
         0+f+ECx0TxFS8PMxEjdEtbiyfdm9Wskoa9fLUxOcw5YF/+pGf8xVpsnhTRaJjYV6uTAq
         in6g==
X-Forwarded-Encrypted: i=1; AFNElJ+VzxCICd5h8aHN50l5bSCJxesHRJcld2mA/NXwwtKza6RVhPTpLGaKW/BUpHzn06PianI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6URYD1YAu7wGIntlNPelwLcIehB8YLivenQR8ljnubg6N683A
	Wh3hgRHfJPK2SbxVIsE2+v3OWarwoFVy27leJfzN6VRfrd5Q22fi/gctwIIODdQh7Uy1WbFwHH1
	blYkUJjv3SU24TyRVYPPPtCyw1ZxP3DE=
X-Gm-Gg: Acq92OHVz2EAAptUby9Td0yXEEi6Zq0zoZee7TLewLtt6z53+ujIUX6K6mPKG4BhPl3
	4dO1Unn+uJjXOhgZCDN7m/h/DNyxXS7x2FNL/br+nKKCARuCK5Lyzp/5YgWymwrREy7ycylwOm3
	2JYfB/E+hJ7hv5DZHDptadxWfoSz1U18j4Y7LEaA3szBA/sW8bykyiukvd2O23Pu+JJ89zVnOS2
	c+837BCLEIyd69PQXZuRmIJw0D/hvsQByHLnPLEzx7DIneOoyF1+vKPUYK7CW4VdyDhN3AUxakg
	iKDvsmF1ZkWUzBHHEZ8vRteh8u/yqCeVIxL30cXs0VO5fNHwtLIwwtIh+zdnXTMJZ+Nfkw==
X-Received: by 2002:a05:6000:610:b0:44a:fe14:3738 with SMTP id
 ffacd0b85a97d-45eb36905a7mr11621529f8f.10.1779525050512; Sat, 23 May 2026
 01:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523074736.222994-1-anand.himanshu17@gmail.com>
In-Reply-To: <20260523074736.222994-1-anand.himanshu17@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 10:30:39 +0200
X-Gm-Features: AVHnY4KFkqYicZohpfIyHaeHMubyajvE_tZdPWjwjBunk_m4tAcgSI_CrWuo1JE
Message-ID: <CAADnVQJm+VnU9==jPmc=rn0s_SOkCqri_EyUDxWa4ZEho1nr5A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Add nelems overflow check in btf_find_field_one()
To: Himanshu Anand <anand.himanshu17@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 9:47=E2=80=AFAM Himanshu Anand
<anand.himanshu17@gmail.com> wrote:
>
> btf_find_field_one() multiplies a u32 nelems accumulator by each
> nested array level's element count without checking for overflow.
> The sibling function __btf_resolve_size() already guards against
> the same overflow pattern (btf.c line 2110).
>
> Currently the BTF array verifier (btf_array_resolve) rejects BTF
> blobs whose total array size would overflow u32, so this code path
> is not reachable with crafted BTF input on kernels that include
> that check.  Add check_mul_overflow() anyway to keep
> btf_find_field_one() self-consistent with __btf_resolve_size()
> and to guard against future changes in the validation ordering.
>
> Fixes: 994796c0256c ("bpf: create repeated fields for arrays.")
> Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>
> ---
>  kernel/bpf/btf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..b767a9fcf095 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3765,7 +3765,8 @@ static int btf_find_field_one(const struct btf *btf=
,
>          */
>         for (i =3D 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type=
); i++) {
>                 array =3D btf_array(var_type);
> -               nelems *=3D array->nelems;
> +               if (check_mul_overflow(nelems, array->nelems, &nelems))
> +                       return -E2BIG;

It's unnecessary.
see __btf_resolve_size() and btf_array_resolve().

pw-bot: cr
