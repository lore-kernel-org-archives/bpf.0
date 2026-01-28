Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690A1CAA6C
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567777; cv=pass; b=fC0L6jbaOiiM75o7rPVlX0WaBDemvpyZMx0U0XEi4d7zITLe/530pen46VFSoGxoKVvGA8Cw1s04qJcEMvFOwvR2ISFAJjKRWe6d/MkTP/1qBC6AjBlhaWJy7Q0NrHfj9B7w3Tq69zwns7Tg529K2bt8imPHmRiAi32XRf15bo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567777; c=relaxed/simple;
	bh=hUus9C0267LZStjqLKtTofMulhJeWMqsPZPiOivDLIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8sXmURO4Enm0+Uf7EU9xyLBXh/NECJF7DJDOXObIwCEIkaRGcFc2Uua+uTWeu+AOS9wLsX3x2ZGFSuOf6DkURdcQjstH8dxveBvphSgiMiYjx+lVLjooiEUF9/s3KWnh/B3yx6KCsUOFIkVu0nulHnABXPw8fC5lHdyoXIJNLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvlBS7FW; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlBS7FW"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359228b7c6so4149767f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567774; cv=none;
        d=google.com; s=arc-20240605;
        b=f38VxmybUrbE/aqFCd1SN1N8sx94tkz8n21+TAvehs6DAUSyjeKhh7taHECSnatTZI
         D1iMRlGf1Udl9rBmxUUHGVBppGHE+pScNpaYfPG21qDeXOvdsjC5hPyE/tfBvShsLz5c
         uqAAXdklcUbXz5yvcB0Uk/d5Z6Kroh44WfKxEJFhUUWcK3PMqMbWtefuxqTuU3qYA/bu
         9VwITVUccp/pgMpL6x3xUYP3+Eskn/+1G5vpbwjFPQlHZny81839NnCDIEPHyRdYLfI2
         0/hrpW66CNaUlIfhA9qRm1o2XVPN7ytjPmE6M7jZw0JQjWss+BYJga/VSYd+v5tIWNuI
         lHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UM5XhBWmfUqpAQYNQqZNI0zZryhWS/7N2GjKKzGnDKY=;
        fh=07919j3mEGtUJ+mScCnPzO16vurW6cKq9ZaYr312Wzs=;
        b=N65jEVCHD/8V+zQGcdJ4QO/pyXTKAqM7g6mrU7s2o/q5NYKUSW2wT1tOP9447MekQF
         R2sJJ+LGC2Zaj4ux1PqHIB8qP9XwfyO9lU8GLsEMSF8Jt0a8MijGQ/v8ZU+zyPf5RMjB
         qASe3NGfQnbpDfEN7mgOxg1EQJWmMynriusosYIwRhr4BZ0SeUPUxrL4WAragBtI/kdg
         yax1Q62etivboyENBjMkh93nPJKMbTUTCItNEsyJ7aW0XXBby75dXb9Xokme+DDiPLNF
         mExHZQ2F52VFCxc24qgr3C2Gafllplhg3KZZvkMIHt5meimDGa/0L31DTf+XOZpXiS1p
         t9yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567774; x=1770172574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM5XhBWmfUqpAQYNQqZNI0zZryhWS/7N2GjKKzGnDKY=;
        b=LvlBS7FWwQ1Hc7kKy4NuhzizhQcVtBder8n9T4rIg4T0yFTEFv/aP5p8VWkaim8/uK
         dTZZg0vHsb5PD5SwC+gDOVEcIL9Lz4wnQwgEPFUyNSMO8vnV1dtVIAdPwjl4qhif0xB8
         CY+H3Ctm69tHQxpmYiYhtAUbm5z5HORcQ/t1HXMlOHEcLT18m6PszoCVVZaDH3OS+bId
         wM9Nm4CvKkY7FipXA1yJLeIWZtpLm+LcY6H0WGmBHIIe7aqrSmGWDo3zBgDs8jNrnyam
         l0TxKNAMmAOKj1TA/REe9/G0PAVEmkjmTTamX4CS/dGUS9E3DtLWcgxwg22GmrhCfrWn
         B35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567774; x=1770172574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UM5XhBWmfUqpAQYNQqZNI0zZryhWS/7N2GjKKzGnDKY=;
        b=fC03irAxlzmfTeG+Fcwz0OKF0dRbXYZFr1leuKhhov+Cw4Ka5WBNKh0xLNbIvNrrMh
         nqQcHEl1hboDuEWv+qIb4QtSaBdHINuEx74IlihEMQErFqJe0/cJGL93lQXq7ezw0kMX
         v6laH/fmJY+MfypOWEXy3qPwA1OjbzukPN6ZbMlLfBTWDKpmOUYumufJiWmwjJZ0GPNi
         0LJHZ3oBQSRMqyCUfld40bO3958xszAj/7Yz3u07B9T+2EFtzt4U/IKHeWAVw3PFtvDH
         qNkpl6PKRpT9JBZpqeqeUrrKJp7Znah41V+jY7sHcouHQc818m58OFY9vfxV70j3r/7X
         CacQ==
X-Gm-Message-State: AOJu0YzoJMWRf7qJGABgre1J/jm3714dhVEMNp6I96uQ0xWp8ZJbLcAd
	A9uRwYuGq0s9j/yXu6jTeV97sJzKr1SvbCEYlNzwPbWA+7mxNOjgK2XHvDhzvpHwDJDvTLF2Oun
	LwtuhC7rupl2SEGFArDgcSbxdU5J8QFM=
X-Gm-Gg: AZuq6aLE/+MPVQesxTCsnl4ATk4tJGza7osSdgbJpLiWb93ghC8ZzaRpGgP8j1AYA93
	yVAjuUdGUoNuLDRYOGu21qhBcpfj7SiM69YB2aVIVz5DWUnpl4goHmlF4ag/wmaiJY7VwIeHatK
	C8aqYAJMTSRiBkBvHUZgJlxud1M5mAz9KWMbfZuutLGQ1TW/Pe2agPGtXAp14u4cKcjBmE5jsox
	HVymLUPxQ9iv2puwSHq0LCetVNThlHFD515S2/14t9YEc+h77L1pynQelZpJDt1+EKKLeoJI0oj
	/bsoGT5e+QqHH6DpGJb6atxTyXmxG1Dmk7wtgmq/C8gfvwZFv1oWjwHBXZey3m3hoL/+v6ePpbK
	VKnlVyL6355PmZA==
X-Received: by 2002:a5d:4090:0:b0:435:e3fe:7409 with SMTP id
 ffacd0b85a97d-435e3fe7613mr424501f8f.44.1769567773748; Tue, 27 Jan 2026
 18:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-9-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-9-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 18:36:02 -0800
X-Gm-Features: AZwV_Qjr1yB9i8Lq2MOE2y3RKda6tsXy51DqTI8BjD0X2b3ZKN_U0AkHDm99N0o
Message-ID: <CAADnVQLi7uKnqsR16mggQm2KBn2z+mZ_kYVyo94giGK6LgZ9fg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] selftest: bpf: Add bump allocator for libarena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	etsal@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:16=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
> +
> +private(STATIC_ALLOC_LOCK) struct bpf_spin_lock static_lock;
> +
> +private(STATIC_ALLOC) struct bump bump;
> +
> +const s8 STATIC_POISON_UNINIT =3D 0xff;
> +
> +__weak u64 bump_alloc_internal(size_t bytes, size_t alignment)
> +{
> +       void __arena *memory;
> +       size_t  alloc_bytes;
> +       size_t  alloc_pages;
> +       void __arena *ptr;
> +       size_t padding;
> +       size_t ind;
> +       u64 addr;
> +
> +       /*
> +        * Allocated addresses must be aligned to the nearest granule,
> +        * and since we're stack allocating this implies that allocations
> +        * sizes are also aligned.
> +        */
> +       alignment =3D round_up(alignment, 1 << ASAN_SHADOW_SHIFT);
> +
> +       bpf_spin_lock(&static_lock);

In the stack allocator you're using arena_spin_lock and I'm
assuming it works fine there. Why use the old one here?
