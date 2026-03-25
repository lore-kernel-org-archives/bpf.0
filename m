Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050233E358
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464767; cv=pass; b=QY62p2kB1Ydkse2ZtY57wUtxhwVOncwOpMcwe0d0R+nhvicwxR9oPqg8RuTaDeihxIi+P0SHAnuDbyyzp4woUEHEhHRuJH5nn+0+nD8vnzYoJh0JbYmB6hDrndbXPgiyUzxtWluzPbKWnj4zA59R/Opb74ghMJONQOdUEfn3iKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464767; c=relaxed/simple;
	bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAdl2n7bzf7i7Y2LxXIsrD60q0yG+OfEzm/Ugk0Jde3VCyoUU8fTcYaiTHYHjcvNvd8S21RbLxq7PrqDmw4HD9bTZAvpofdjKiOea3Mf3qRKrPf24wmhOuLwZLr/BfgoPzbNVZZpSmTcG6wArseUKlEvJpM+JTBZhw+OTUZOhb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpsEbnoo; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpsEbnoo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40003d13so99160f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464764; cv=none;
        d=google.com; s=arc-20240605;
        b=et5it2OK1hLIgefQkHWNwxRrM9BlHnwGWN5ktYId9LCYRUK9fJdZunHUU79CkMT0o3
         RyBiG7FFq2C54CixA8IVw4/zsj6uPwumYlu5n5UzbmMJwWZQulvOEp7QQcFb2Tx/I73Z
         ZRholqRnvFBQFoKS+6kYPK9pIhZPQFYCbQVEfSZzFc9x97cVaBrtH1plEYaRHaR6o8eJ
         2jxYaSLMuetTdIk7RMPoiXmY2V5AWCrZqK/wR29WYYWzl+aiYPYziCE/q6CEBqgAq+gB
         szCo1JxRLspIWt+nxePzYYzLnDwmp1HW7h/TxsoGsaI5e9IhLGatVBCaqYFESihYX9Vj
         hL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        fh=jLb8mxDRH71BnQN74wGHyY4egPeVV6wv6T+DNrG2qw4=;
        b=DJKcIfZn/61mdlDgx9xXc8Zvc2uz8sQ4O3bT+tBrwTv/EU8D4pmRPca6MSju0OaGAu
         J7UmcTrL/Zn2iKaVLlSCqzRVkKhvo6+kUKAD/7eGrdSie041f9Y4zQ6x5nNdDiU7qiDR
         1k0V8bfSSwNJmggA2s+wvKBrfrkmKaebvaj90EfA/4mMWIHqBglcdf+KD6+K7VRP0ZBd
         aN6WINOieQZtLqZCCCbjxuVV7nT8SHtRXbzOKvWAcM3wym3l4Jyigon49zcQlXTpV/ID
         yS3eI8cKSV0Jh2bpLkiysFmiAybRVZM5RjATAG7Q8R87+yKE3MQdhI8Rf1ztWWjHwURC
         Y/OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464764; x=1775069564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        b=WpsEbnoooxXCNTJ11ktlsCFu5t71/WZDF1vW8qetyYcq2XARbPXZ8a48hlOV4hB2of
         gUrFH5B83F6ezS/zulaq2kJ3GQHu+zwaKy2S6ra1LLG0WwRy0AAxjsmFcfesqlctnWKM
         TELi5PbjmS2/t7tq4dp07/oS67NO7XjvnhjCSiEN8tlOmslaj9cRqKVBM/lF7J76m7gY
         d51SbZmK8hZ00+4Kwbhjzv5ZIJvQEPY1fgonUora/uFUUy6mhGB4Y3sS0TSa8kCzgGz9
         tREUNZoPlptKLVGYorsSYna0+qy03RxRU1AabnxSfxe1Knyogd3J/fyoK1/AAcqwdVzF
         mCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464764; x=1775069564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        b=Ip1LO9lgbEWUg8R9b2s9xSlWUC52c2mxf22Bf/VSDwF/L1pvb6sNyS5471gcHyqJBa
         6/COGGvf92bCElI/G7FbullKdsyQqTwimLfy/VQe13Un+40L4Rzb8ux/me+0W1y/rC+u
         AHrKnkEA8RL1pbl1ZfrzjDYjUU206bB43QwGgEVxzlIH7yq9cjz8tmNA0wwxZItDcyUY
         qmm64C2gT6k2lVhmeVVqMFPrLdbrzI93Ai2FTmZbqViC9M3DHJf3PKll+oObj6jYIqMd
         iAtgj4iAbvP8MdiFnW4+rAZJ86NaTtuG84m1Ov15qfV1YI7NuReL5jpyrIVLqlB/5z8T
         EbPA==
X-Forwarded-Encrypted: i=1; AJvYcCU97hkUWfjCai6vQYTEHcgn+VUFb0QleXbhYhzUV9Vm700PH4Anle7WUzY+6EnknFSfhbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2+ttKOm/TNwvfdYESqyKz6kSx8CV2TGqBO9qq1oac+EqNt2X
	FtI6zyVSxvrw8ljzyqvvG8tkeyZZZd4rPeuqVKfYEA0lJrQzup1ErXcMAxAkd24b2Y60YU7B5jI
	xjbuQBWrcvcs2Tz0tTUOSBQCvW3Z4t/4=
X-Gm-Gg: ATEYQzw++Q0DC+ZwNKHBEuQ5lY1W9JJxF5bZITEjAtOkldoNAOM+p6IpeQ0iwyrSHnr
	3mlLZokCdS2gYRvHI5lMBM7TDA7hdnH4U/No7qMb0OLvgm3FnvoIKxQRz21YLY8yBYgYnsXWv/q
	p1PlNzxagAlZgdTXPNZqHHpfVMtNjVlRnMgKtyttS7PAp3fh5MsQqmeuCZxrYeHkIczKd29Zazt
	hfEY6NIjWFLDMUyv1YP/04XyaakjBN9LW4Cm2y+HX5OHoY/MtIwxH/tKCEiCUHpsM8NaMoTjh5v
	pRr3+UYKl/dApqexGv73DhZXFUhV4Uu10pkCVBbTEBnreXgOO02mHfHJNj2ElkddKWHWq3unr1d
	NerVZOY0GYc1EE5bxM+1DHQyBOw==
X-Received: by 2002:a05:6000:2902:b0:439:b203:7711 with SMTP id
 ffacd0b85a97d-43b88999255mr6286811f8f.3.1774464764139; Wed, 25 Mar 2026
 11:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324174450.1570809-7-alan.maguire@oracle.com>
 <ef3fe9d80d24f7498410bffe938da1882448e5b6012fcc3ca97fff5645018ba8@mail.kernel.org>
 <1cb3278e-90a0-48d3-91c6-4b7c552b96b0@oracle.com>
In-Reply-To: <1cb3278e-90a0-48d3-91c6-4b7c552b96b0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 11:52:33 -0700
X-Gm-Features: AQROBzBDpjXt-Sd5I3lcyCBSgDJ1prhwZly0KRnadhMExEvYEic6S-Jks5fAv-c
Message-ID: <CAADnVQJooXp+aVb9UTQN87=Bu8i6JAb18Rz7N-cZVVOKTLT3mQ@mail.gmail.com>
Subject: Re: [PATCH v15 bpf-next 6/9] libbpf: Support sanitization of BTF
 layout for older kernels
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:40=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
>
> I'll wait a few days for additional feedback if any and roll v16..

No need to wait. Fix quickly and respin. Let's land it asap.
