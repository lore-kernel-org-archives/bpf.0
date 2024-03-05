Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB023758
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666133; cv=none; b=pi/PhcaYXPqqs7vlS5FXPdBtZA//e0bT+x4qSaEdDcFaR4DEPYkRYPE44QdkdBhVa4B4d/HU/mNpt5WncQ6Tm36R0nCf5amMSQ4UKjg7S0hJLZ3khYnf4A18K7wk2FR7b74pNCRBYy8MH+7qSGBLadYM3eVKS0L10w0iy8M3nqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666133; c=relaxed/simple;
	bh=w8YbVR11CkjEkMVeyOtuXLrnHFBn8Y0ct8NJUNFf1G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRh5gjwufOlvRrdGgfnUynbKTYaQXQdJtl81uh7roccWliNGlXNFgcoTlj/7ANYMkFt7rFrqv+FvyfWBKVvvfEHT1MFM9QIetVf5U1vh+qkL02zd2tLZJmZKARnVtFYDRhksm/5F/oCRQ4PLZokpZoXUraTNgHheVZP+kpW09+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIjN1Z1I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIjN1Z1I"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc75972f25so50631835ad.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709666132; x=1710270932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6QXxM4MzTSxraAkFoTRLEMaoiqyEt1TvXvwtfErufE=;
        b=VIjN1Z1IWCJeuRky/oa7EWjZujYSSuuhcg8xyo/hGur70Bumw0i4Kg85yJx5Y+k9XI
         m2ZdHH7roVNKGM+gjBdFk+eei5FuKVZYlLtTlsYT6It+o9O24M/O3psd+7x9biGB0fmN
         lCpA2o0wjJ10m7eXYRDAn1HpJcRtXV68S/HnZ+qsNHxg9m/mnh3SQwvh22ZwzVyK4R3W
         Zd4Udp7IX0xhD47aT9JIPhjFawIuhsg7FjxV8yA3+MJ5VYrNnf077ptamYt9Z2Hp0idj
         p19i79RLxMo86Jp8QVAr/xSibNojOrpEIXtqLcuklfaKNxbC3XpiFQc8Ac4SI2v0Zk9H
         6bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666132; x=1710270932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6QXxM4MzTSxraAkFoTRLEMaoiqyEt1TvXvwtfErufE=;
        b=fkuEadF9bzmhdGJkp5oMU+H9qSb0wY2ggGQZpc3DCY2zpIpm4mdT+RtUg4JI/4CED3
         3fHcszhXfeX6F8IQMLJK9q9/GzLARMiJ27oeQS/d8EXDS+VwfWgm4jlNH8W1rf+jT/rC
         gf1OBOFkCE87kCN++qrmK7eGeE5cCGmd3NjOHd+N4LmDr5zKP5q0ip7CN1bImRuY7s7S
         GrnCoyQU/zb8Tbzvve0o3tjGPcjAEJR2G8oG/aZdpo/S3bXTh53a51vyjiLt08xBgrYC
         KYbLDywc0ZUIe4LzA1eLsYX7vhZe3LceWR6LqjkeozyNqhbOFIIjhb1Fhqt58Bb87f1+
         /K7g==
X-Gm-Message-State: AOJu0YxGpM5B2NwXYamXJAIor5F1F1cJBOSFLPyW4S0HnFaoJYWjmSNZ
	yPSCwUKSQEDm/s+Sa/+psUJkujtrtGbzWYZg54Y3l2Ksqq4azaA0LGW/PxD0v2/7hBZtGj+u9iw
	l31aTHYSa352cVJ7S/Tnxy925F2srvPV7Jns=
X-Google-Smtp-Source: AGHT+IEpR/Ds3oqfuPTK6BuYVpWcqv/3kJwiuX1AHqggCqrJB7Eq+MRAClyh2y/sX2xmODm6819UxYzOR9TXlvmyg74=
X-Received: by 2002:a17:90a:5986:b0:29a:e05f:3f55 with SMTP id
 l6-20020a17090a598600b0029ae05f3f55mr9719886pji.2.1709666131735; Tue, 05 Mar
 2024 11:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-3-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:15:20 -0800
Message-ID: <CAEf4Bza=OqRG2xfn8U1rEQLWd=U+rwDQze9wj5iPxsPeMMLfuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/15] libbpf: tie struct_ops programs to
 kernel BTF ids, not to local ids
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Enforce the following existing limitation on struct_ops programs based
> on kernel BTF id instead of program-local BTF id:
>
>     struct_ops BPF prog can be re-used between multiple .struct_ops &
>     .struct_ops.link as long as it's the same struct_ops struct
>     definition and the same function pointer field
>
> This allows reusing same BPF program for versioned struct_ops map
> definitions, e.g.:
>
>     SEC("struct_ops/test")
>     int BPF_PROG(foo) { ... }
>
>     struct some_ops___v1 { int (*test)(void); };
>     struct some_ops___v2 { int (*test)(void); };
>
>     SEC(".struct_ops.link") struct some_ops___v1 a =3D { .test =3D foo }
>     SEC(".struct_ops.link") struct some_ops___v2 b =3D { .test =3D foo }
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 49 ++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
