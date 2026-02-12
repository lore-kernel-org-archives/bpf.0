Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023291F12E0
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770863032; cv=pass; b=CMP9q2BFb5o8LTIv3kc0XGu9IdrEuINqH+xGDjAyxfK3l5kQgje2lomKBKXVS0wtfFKHGAAsC1ybjEyorwsUfm0BNuNU4Y/w1CJTBMnGmn03lNB+YOjHDZBRk7NtTwxYfIIqqEyflTKmZ4uqFlTIK29ywd++mf7qXjoBTJSV210=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770863032; c=relaxed/simple;
	bh=JXzUbVwrHmWm7LZHDPndPcouqBu/qxjHlyBHr+7cP6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5rak0eg5efuLIRoraeJpFRX4GXR1JWGNMOtMU7aoybSQmpKMEvLLpWwkoputTAzKlw8894EGJ/QerI5NfsgerEFzY7QaoaqijTc8hiE2YXoDIeXngUdfVK0zmxeT4JkmiL7kl0j+2IidiHg4c4xnzU8QFpclEn3O920H4RdPuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkxS2ssP; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkxS2ssP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-437711e9195so2872145f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:23:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770863029; cv=none;
        d=google.com; s=arc-20240605;
        b=cCzFz1Ay1E4Kw0PpNQM7vZ6T6ioQHLvPDalu/AcjALYcPhiabhJvL7bh47YT/+CQc+
         nCTl2554ZS0ebdjvfAD0S23vaalU1uIkTma8Xnw1lasrw5BpbE6K9DbVkWNywokjpHWK
         ML3gRaD4hp6vxDvP4oz1U3u5G6Xm3Ym63DvJ+ccjaYWw2MbpaV8DvPsKmAiJbJuKDzVA
         2bk+m55Ew8KZoqrFIBTgeq6RIe24xe5WrEi/dMJYLlsW27sxoP6u8/JeioKMAAgVbVLX
         lRwMvtJT+c4n+jELpnvSHdyEje3HEorPmU/Pv4o3RxUJ24ABVNBQaA77hlBfHqSzXC+y
         QrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIWnvhD39kvyKZoJ2FiZuQ8z35RhjOXLOwz5+/DaVAM=;
        fh=gOsrNFwNKu9DozX1Jd/mlmCgaWkGmde7k+khY9odpAo=;
        b=FgjTYHIToxD56qK6w6ayIZPxSnVDyVY+EEFK9wCKR6HT5AejXQjBPMipKWdgbrHZrL
         y7LV9oDV+FVjcVAued2La8q58ttAo3T0CQVjhp1vLyoGfOdJ3Iw2mXjtSnKWV+he2hKs
         6kro5GOja2E3NiwSYqfTAqWOz6whnIXKI8aWt/e5pagikinuy11bP/XArU5KfSLZ68TV
         0KsD/iVrNbjqfNfRckkFvrQ/K21erSAjRoCRY+WB0DkEQ/uvrhM8I5e28To/vwvOwsPC
         Kt6ET6QSnQwQzVhqAuTy5U7ZFKznquOehbhZxZRMzsMSL++xzwmFoiU9zxuZhoRmffcF
         Wzhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770863029; x=1771467829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIWnvhD39kvyKZoJ2FiZuQ8z35RhjOXLOwz5+/DaVAM=;
        b=IkxS2ssPcdF5B1QB8b59CebJDkyfYYUDGw9yK3AZPRzwju3dHdBxd40aBW8XOJY+7R
         1Q6qluGHQb84fljwmrqvTNbtSqVpkJED7KuvPgf5ZS3KAwnIMoFgrwi6GypzOW2X7M6+
         e44rEmLMI1PFL0ygYGSQWg1X6/4tNvj1ltMDvThql7dlOhcUjsvTXeygT4D20qMXCk+C
         oiA5dmwFTHKES9EXJ6mkYvNPuc2Zp2qs28tRRr01Ft5j3G5oSXTxCS0gA/aD+p3gZW04
         UZ1GwFbT2PWx9Z37bzN7hu2J5Yr8Tn6Mn97CT4coN1QgJmAtG2uHzW+g7pNdYaBBGXgP
         uEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770863029; x=1771467829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIWnvhD39kvyKZoJ2FiZuQ8z35RhjOXLOwz5+/DaVAM=;
        b=tDvEXB5gzER4HMHqhV+v5d6loCMQwfS9O1Mc+QxLJsPkNnwZ4LJr4dZ69BddvUGrc1
         2HVirvy63XPi1mwxyvnycu/687VKUQD7m+43KaEy7l/Es1w3uUSuSUV8+Zh870qINPWS
         Rw68GjF0ar6mmdIV8bp7Ii9ueb1WO0jQCPX0vGJhFL8mv1cH4nwDBarVnQSBvOHtvaZN
         bBTUXsOhoDOp1ddWFeS9eGvdLB9jiXbMOt54zGo7KScd0MDojcfOmD1V7CDbxNYCiaeu
         roqYo/wzXRJBh+qiEG8/fI9DNsyK4NdB4wmaj5WQrM7btLP+kj0dUavhYX5YbynQafwB
         ISHw==
X-Gm-Message-State: AOJu0YyMW+h6AyWJ0NIjIAbUOzpjIBcJHsh+s3AUjpVnRLnvEQZbW7Dj
	gRcKbLwigDza0mZ5C5KoK02GFZDyU16SkeUPltNUwrGgVV/vvYdhimgRWGfd3Py+QCehIxwuoya
	TkVzWlYkVBf+18aA4FDNc0+qMbqoEn2y1HV5M
X-Gm-Gg: AZuq6aKL5L6W3kSpCnEAYu+YfFvNybV7KdcuJwCeeWw2iI/GYRS0Pzt/n8+LGnH0Bxf
	gFYVivAxmLWyPRoIbNpdMgXyiPW/htCo3drV6yCvGAa6OFehNpH1/Ac9ERC7UhYNfD/6H8e5bMi
	+srZgy1bMzPVDBMIixAEnOdg5hRQgbXs+2ysvwhIAE2QEm3I3eTqIO0IvefUqqTOp8KaszGbKJz
	SL2YPn8aueyHROpPYhTeBciijypaGIuQks3iQ4SsN16w/LnMinJ5oCMld+VlkdJKvpDTJvpvV6N
	mjxTQQy6AhH4A7Yk8gpDVaFvYtDmMgiWPDjiCYc51CtjEHN9eSqJ/7JjKnw25y9ImqY2wSYkKP0
	dJYORorgOXSZax/nSO6VgOnieBE43ROHBt56i
X-Received: by 2002:a05:6000:26c8:b0:435:a815:dd86 with SMTP id
 ffacd0b85a97d-4378acd0c54mr2298346f8f.62.1770863029023; Wed, 11 Feb 2026
 18:23:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com> <20260211-ptrs-off-migration-v1-2-996c2a37b063@gmail.com>
In-Reply-To: <20260211-ptrs-off-migration-v1-2-996c2a37b063@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 18:23:38 -0800
X-Gm-Features: AZwV_QidcKwS_h_3nfP-3o4fyP9qmHear3PiH18qqN7nu7jzuxLevcH65ZkAxlQ
Message-ID: <CAADnVQLZh4Bk++vEW97mL0mMCUJu075vQFS2Kkhf9zXP5b2zLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: use reg->var_off instead of reg->off
 for pointers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 2:32=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> - In mark_ptr_or_null_reg() WARN_ON_ONCE() checks were removed
>   because in some cases helpers that return local kptrs can now
>   return pointers with non-zero '.var_off' (e.g., a pointer to
>   a spin lock inside a map entry).

...

> @@ -17129,29 +17074,13 @@ static void mark_ptr_or_null_reg(struct bpf_fun=
c_state *state,
>  {
>         if (type_may_be_null(reg->type) && reg->id =3D=3D id &&
>             (is_rcu_reg(reg) || !WARN_ON_ONCE(!reg->id))) {
> -               /* Old offset (both fixed and variable parts) should have=
 been
> -                * known-zero, because we don't allow pointer arithmetic =
on
> -                * pointers that might be NULL. If we see this happening,=
 don't
> -                * convert the register.
> -                *
> -                * But in some cases, some helpers that return local kptr=
s
> -                * advance offset for the returned pointer. In those case=
s, it
> -                * is fine to expect to see reg->off.
> -                */
> -               if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !t=
num_equals_const(reg->var_off, 0)))
> -                       return;
> -               if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_own=
ing_ref(reg->type)) &&
> -                   WARN_ON_ONCE(reg->off))
> -                       return;
> -

This part looks overly aggressive to me.
I don't remember seeing these warns, so any known code or syzbot
is not triggering it, but can we keep them?
The first warn can stay as-is, no?
And the 2nd can be converted to tnum_equals_const() too ?
