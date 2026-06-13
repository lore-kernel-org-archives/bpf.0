Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D701DFFD
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315138; cv=none; b=cSHcey/vaOU9vmeruKWOIxO9G7v837fXQBZSw9jbsVLtqMmGE3aUqeu39cYF5lfn1TwMF4JATJkn5yFikjCyrcwWTjQHOQ1U+TCTu2dMpuDUBaO/hgXdU1Jg8v/RkdsrL7UyzY9sShl9mvitWSGb1vzY1u0vZdwSf2iQe/OWwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315138; c=relaxed/simple;
	bh=B/MBdySuhNaMXHjJulAyzWkzXJcOuRRIe9fHeh3B8x0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W2IFf8FO7M0QrlLJNGTF4Zc5yfIIoup0fx+kxp0/AaaNuV99P4WSdz17TroViYkcdokCGWY+Yk6rCK4jH2uytYLKi36jP7SY7WMu216o/8XgC0g6cOxd6uuh5p/wO6XaUer1YRHCJHe6c2WEIeSNAoR0QJe9QayCRjkqM17jG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCAOe+pU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCAOe+pU"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158c621ebbso186889485a.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781315136; x=1781919936; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMzUxMvNhBtUJndLxxok/r/+YSwP+zstTo1WTZAN5zE=;
        b=GCAOe+pUA/zZHBmaLiXM0KZkqZSzR306NzaTiYavuQg1tfIUJAHUXKvIPk758CNqvy
         ZAiIlbutLbNxnbaAn9QvqHZtrJYrDC+dR6FxCPBG1EAA4rxJwbZcBqC2+LSazt1KK5oE
         LYLr3uZkS+D4n4AZo0BBa8HPq9dI+zI/5gE6eSFBFVAuSSFLnue6S7CP0QATK/I6m7VL
         URl0+DhirH0LLC1MV/k9v327VEBcma4qIXh3A8FVFua44pSEucbkWCY7iLzWbNQ693SD
         wS7RwAQe0okxNw4DSV5Ww3+t12SeKggHvezKTaShIyrc+YidbJ4JtzzCiT/HGDkz+1Ci
         HTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781315136; x=1781919936;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMzUxMvNhBtUJndLxxok/r/+YSwP+zstTo1WTZAN5zE=;
        b=sLIs7pGbPLBN68yKlLe/ldu/Ovv2RiNlntlnLt07y1Lyjr8bjEBVXg78NLFr0N9a3t
         r0twziXjMH/fZtvNuYrO8j8vVXKMDSzOXsXLEIdiJComlclhCMHRZzvvPiqg1UBu93kd
         Q+ktVCab8GlKFuXgLyGxUrnIAVKQ1pYkTxpsUp5DgfnmO+9xBHyGrJHvMOMu5CKjJF7L
         7kcTxZIjcEBRDdIER/nZuRR6UzIWWivy/mQRugi83ZscFF7NfTpwDAzD/IXR5zmxM9eT
         fVmvxWSdyjPy2vBnRdffRbjpcikgX7hKtUY8RFoyZZBqfsSEF8oiIszk7pytECUHVmX+
         lFHg==
X-Gm-Message-State: AOJu0YyxMCRKAvxTEkIQ0FN/6aJdLIyEY/+0WRnH12QfpsBruk960EJN
	GOuKBF/cJa1JiLlXmNH62pfj1rs4qRpOOGo4R3b0YWXQzKUJSKiSGST6
X-Gm-Gg: Acq92OFWj+zKo2U0bj8gQq2wuqI1pN7dFZOvoXWoogo0WXgQYGYilyufUHw+G9K2B6U
	LbuU2HLlAcjFtCT1fU6UHiemvyBJ2eKPlyta36THG2PiB9LteoxvHXFLDmleJ5+0VzYRrREppb0
	RWpcdjonD6GC1fQf4p49unhJodStJcdCdsh0HPo6ewAXsLRl0r9SxRnUY4UdBhVqDcApWXtO0CC
	BLhh40SVTPDUt0k1BJFcYv9W2QZ+QZNSyw5tUNNtp4ReNIX4pkw/usfFGLiRsWxIPPl/h+sptGh
	jHiMsvmHZ4VVH6M9m/ZKxuv9cD9umx295nS5Rilcnq1KnOKeCCRvpVm1Pwj9r8X1pt+IG/4FskA
	74O4QjprUH5Y9w3K3f/qXKbTTWmoBuIy02WHSDS6PsLU7sqEf3TteKb7wJERjUapNh5ZaHiJY5/
	syEUIuDN9HnsvvkHeYb45sDQoujLM5UpdnNvUgSQgDPYyd2aHOy95pHtle3drdmAld2GOqcg9g9
	sS1/ksNvrx5qSp7NQ==
X-Received: by 2002:a05:620a:f13:b0:914:babf:9f56 with SMTP id af79cd13be357-917f1b5abc6mr367245985a.39.1781315135742;
        Fri, 12 Jun 2026 18:45:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6af40sm41224886d6.8.2026.06.12.18.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 18:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 18:45:33 -0700
Message-Id: <DJ7JIJEZ333Z.28J0XFPQ1RAFC@gmail.com>
Cc: <bpf@vger.kernel.org>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc
References: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260612220651.2507843-1-ihor.solodrai@linux.dev>

On Fri Jun 12, 2026 at 3:06 PM PDT, Ihor Solodrai wrote:
> +static void stack_map_build_id_cache_set_resolved(struct stack_map_build=
_id_cache *cache,
> +						  struct file *file,
> +						  const unsigned char *build_id,
> +						  unsigned long vm_start,
> +						  unsigned long vm_end,
> +						  unsigned long vm_pgoff)
> +{
> +	if (cache->resolved.file)
> +		fput(cache->resolved.file);
> +	cache->resolved.file =3D file;
> +	cache->resolved.build_id =3D build_id;
> +	cache->resolved.vm_start =3D vm_start;
> +	cache->resolved.vm_end =3D vm_end;
> +	cache->resolved.vm_pgoff =3D vm_pgoff;
> +}

sorry for broken record.
claude's copy paste doesn't bother you?
It could have been:

struct resolved *res =3D &cache->resolved;
if (res->file)
	fput(res->file);
res->file =3D file;
res->build_id =3D build_id;
res->vm_start =3D vm_start;
res->vm_end =3D vm_end;
res->vm_pgoff =3D vm_pgoff;

or

cache->resolved =3D (struct resolved) { file, build_iud, vm_start, emnv_end=
, vm_pgoff };

and probably other options to make a code easier for humans to read.

You have to explictly tell claude to deduplicate otherwise it keeps
copy pasting left and right.
