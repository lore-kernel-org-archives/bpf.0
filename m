Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31712153D8
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770944059; cv=none; b=pQWz/a83VD5e5IEJPHdZZdFqLGrDExQfXSshMpeTy1uKrcJRip7JD6U31gM3OnRF8ZYrB1r1VtsSdN9HkEwTCmqdejbnuMT7tjBXw+w5he2lw/Y5gThaNM1dPNPwxeYF75YUC53SP1j2vgIBtYkzIZdF23EKu5pr6gm/7ANirMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770944059; c=relaxed/simple;
	bh=SexALKQGglCr1gSOIH455qV/JUI05fAzQwrmdPsB2cE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQjn3m8y8X5MRS75K0201W80Sd58wl7yCgzaTdxXMhC/ahsXz5XVaOaTKZ4WD/bpasDJY4mQTnfABVKs55DvQvhjB2zyc7nrpMLDDlmKYAUTyzN7bC2op5OyZkZqrBae4BtP6BdwTp9uugZNy4+i3EHgzCySoE/HBqIeuF4W/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNzbM6nL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNzbM6nL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so389530b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770944058; x=1771548858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SexALKQGglCr1gSOIH455qV/JUI05fAzQwrmdPsB2cE=;
        b=eNzbM6nL1asQZckheMJG42p7qs0LGAXveWKqyScHXib7MlF+jxZUdRckDvWtxkiRpF
         REQ13xNsfxexUKAB5e8FO1PRS78rsAjoEIuEmjA8AFejcsGgupHoJ7PJ3dFHo7zbVkRi
         MnfJ4SiP1CDRo6JZmDV4tFzvz4v743Q4I+Pineapm+dcsO87qTzW42ZmytcCvwX8AKlk
         VaQ2rzTGTXOqLtbrVSRRG2GkYJkxmKEB7pjIVtV0VKoiN2Zrd8L5i1MiR5H9F+Ak7+Bc
         ACGHl+kEnNRYq2cAtcZHvbcHRRC+/0MHd35i1GvemFZJgBrEl4/0w8IlAYk6qCj/SFyJ
         ceCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770944058; x=1771548858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SexALKQGglCr1gSOIH455qV/JUI05fAzQwrmdPsB2cE=;
        b=JEPF+KaCWTqmEJBYXaDvjo3UevpfmRwcsfFEuRrngA7Yt2a/JIRqSBNaAMDFdIYyKR
         c9P6CdJrhjZSUFeKXA5letp0LAjXRrSaUtRbzQ4rS7Vf5rJQ7e7xJWuFfdBjGwoEDi/E
         l/EibxEBQkDO5spKkS9cUsRPYMsUl18bXTW2/vznMnLY6ez8zrFtoHiEiJNj9Dryyx6Z
         ktWzpCCk0ZBDf7PY6ctU+7zmgFF0cr9YLsTZI37Et/iXyvcq3sqYVieSkDDVqE0W/vSD
         P/ZuyBCqdy16eai7GyumfMFStE31U0tNX3KONDRk/EO5jkqtZp+2hCyGZa8ICUXSi3xo
         +Bmg==
X-Forwarded-Encrypted: i=1; AJvYcCXYqfRyVbN80R65vm23QmxBGS7ZFUJutbcBf8BomFzTf3NIhfHHqn8a85Ji3jwNX/Md7VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfVGXg1ENZ2+nOfvaGFExvxdGgeA1J9oriDCz8IiqCLc+V1sK
	5nHEgyweK2O2JSghFdBVXuyoXKDkUBCPqiwJqxoUz7zqc2xFo7qnJHX5
X-Gm-Gg: AZuq6aJk4VoPjqlmhpCfSiwj6AuaYhu2GuzY6zIMhOvJNid5hjSalBC9bC7yBd5vArU
	LLrfIwETvhvGzsLCp9+v6R4vhF9eB3TiNK01EJ8hMQc5Pb9YOSnAZ4W3gQHxJkOXelrSmdhRBdx
	VXMZ6i5eXFO247ZxK20Rmwa1hdjxVD4bxUBYxX+Iu8wMRw7FlhfnWwpz+/5qa2GtQcuMyaLnjdt
	i/fxzhM6rqV4jR9/udd8MhVw+5WNyJZfFyWB2O3+I4oKdgHbPn3ShaKN2fTRepEcKRx7hhc0GWg
	SuGh+Qb5uUg6a/MJWh9K5BKkmddCJXfLPUEUkRksStmXw4TFPiJ45ydfW4J9wKwj4DuMoyrRPN6
	ZeQf2bmUcf8oV7wDIeIBFdflIeb5fXusBD9A/fBp2G9462/fe6NTxjFbEViFt2z9Go/g1fKYQyY
	ITl+YCQ45u/n9Nr3fDD0V1bOYG31eGsRSXIynig16RpiGzFZuEzGM=
X-Received: by 2002:a05:6a00:1891:b0:81f:41cb:c7de with SMTP id d2e1a72fcca58-824c946e63amr249485b3a.14.1770944058122;
        Thu, 12 Feb 2026 16:54:18 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2ac83sm495168b3a.12.2026.02.12.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 16:54:17 -0800 (PST)
Message-ID: <ddd2b51bafbb20df997cee2f24ef133f20e2f879.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] selftests/bpf: Free bpf_object in
 test_sysctl
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 16:54:15 -0800
In-Reply-To: <20260212011356.3266753-12-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-12-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> ASAN reported a resource leak due to the bpf_object not being tracked
> in test_sysctl. Add an out parameter to load_sysctl_prog() to properly
> clean up bpf_object if a program was loaded from a file.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Maybe make 'obj' a member of the `struct sysctl_test`?

[...]
