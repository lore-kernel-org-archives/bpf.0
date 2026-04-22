Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB823EAB0
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820263; cv=none; b=s+PNhn3ugYBaRaF0HJCIKZSOelCuv6m896tNaT5vZaO7BY1JOqkNH8DVrA+RUc5lByxGOJCS1tpexxwI6i4sbR/W9WM7UhANfDhR9TU/i3GYhHQ77gZSuyKzuebDi8ZNm6m/UmiRrk063l5PyvVOFuZ94wb4KbIhJHqy7T5CRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820263; c=relaxed/simple;
	bh=DUKgx1rCLE6m0SecaQACluSgGEikDeAjV1aFQ/pVo18=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SbNIkw1t20YEIVlEmzZNWEwEWKQUTfhG9tf8IOCOBXyvvq5jq1m7IJ+z9o6JP5bXVC0smthSKrN5SVgYggmLIjpEfqs6M5GKcN9JpW1qcf5Y2JbHmbGItmpOj88760VVioP/vKRPTd7hIExpJISoQcTgoP5c8YUx++SlEAHDULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpemtFLH; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpemtFLH"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3855492fac.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776820261; x=1777425061; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4KKy+GeCNYRz5/9NiO9N9jwB8Q0FzgbWoQqLXr4fGM=;
        b=rpemtFLHxwVT9Vaw9DgNw0Ss3zadVySCaJ0yE8CkNU0/6DY2o0dOS/gA5Pr15zA5bR
         85hoVO0rdiwd9DUTtjuL8kylX+gXK+5sbCI9VMp1j8K+xgsH2tdm/VtKFfgGUbCelP2s
         w8Sa4L8ifowriPNlycHgzk7lyASHjBYPN5HkkQmxyuo//Eqkk7WWfxIp5JydpU9wqDSr
         CQ4gmB6clzL6ld3VB4z+7k2NlY/IVTQ8/2HhHt46s4CFhx5VDZIHCugq2gd9QzzcoiRC
         b+6yvbBOrF5RztNYCgWJj2K9gienbwLsUUhIy+66p27I++9szzDsyX5j+mDJ7b0IEdQk
         O4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776820261; x=1777425061;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4KKy+GeCNYRz5/9NiO9N9jwB8Q0FzgbWoQqLXr4fGM=;
        b=Phei3nPux2Oc2uXY+3bYVZNINjgUHCxUWxdVD8fzCUjYmSunSB9F4fwycbtNIArHVv
         HH4Jk2sbv9MlRrPP2A3cb8OexnGcfVx2FBHLHnbh8KpcMgzHo6f9Wvc+sD9dP2j9Tqj7
         JYCk4ixpeAmxvVAFCWDwoxxW7YEm4v9fMfgGcNwHUEymDijKAegFm9fvhGp0UTcCpq9C
         REDbX/laO/jSoKUuch6N/sD5qcM3asqOIoxzxOi85p1Oi/FyLOB+ARKnBk7iYYTYwQ+3
         HOZHPtjJOVjnUWDRCocyoNK7Puda1L+/Hk9oRgEgTRCp9LkF8zMWWcHLmQYSJuj1B/62
         MWoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2+tu2hkjj4YpsC6zdmO0dwzfRf9adUWSL7fITAsr/xDwHaqwJA6QtmWbzK7pZOH5SlAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh83GWbywTDnB1+ph9PQUQhoDhgEBd+7oLf+BovIFsGMaLXv6I
	jHY7hiIAJuJTueTz0XlhXrDFu0HX+RhaWXGF8ExfCa6QXPsA/3xUMgamSI64uA==
X-Gm-Gg: AeBDievrjU2XwjfRKW9XgOPToRozNH2WfIL3j8V9M8V4zdVJ2AMrgco8MP7rhrVaBhn
	mIXHvA4R7IpTGvefLs4BB4yzXIHhEj+v59YVRaZDjZlSXTlFTRbeY4smcsSKZPUhGICO+uOL0jX
	LxwzF7CdN2GY0MU63uBORmNg4v/dOe4iE3RivHgM7a4O2UwQlTFlPpD1XSliU6NuuEpTTSIyTnu
	aRfG1g0VPewPhP/NN2iQ7/SZk1tBYf3aQaAXWj6XM1ad+xt81Zbe/1nSooIZeCLJXq0Iy4yRWY2
	nARlEAVSI/2jVsklukS2wqxULB1Sinj+DkqU6sUOtAD04XNiJ8xCdyXq2eUaxqJ/w9f959/UGYC
	BS4qDNl0Cw+mMehg6PGEgp1I5+8Ml/7o0iEHbcRSUHYKDHI9fCHPDOPqerhIEvByBsX3N4yJqdc
	cflL1QEdSynhMeqnrFAOKdcKCYMN56n4Lis5LgQhrUsYTOxRwcpy6xHCj/gpLbKo8+5rXXth+wU
	b5LbPgTOkJt29FhB5YpDck/3lh+
X-Received: by 2002:a05:6870:8108:b0:41b:f7f5:e8a7 with SMTP id 586e51a60fabf-42abf2ec957mr12919832fac.15.1776820261416;
        Tue, 21 Apr 2026 18:11:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm13931079fac.10.2026.04.21.18.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 18:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 18:10:59 -0700
Message-Id: <DHZA7QEOVHFP.TYQTEC54FX0A@gmail.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Fei
 Chen" <feichen@meta.com>, "Taruna Agrawal" <taragrawal@meta.com>, "Nikhil
 Dixit Limaye" <ndixit@meta.com>, "Nikita V. Shirokov"
 <tehnerd@tehnerd.com>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH bpf-next 2/6] selftests/bpf: Add BPF batch-timing
 library
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260420111726.2118636-1-puranjay@kernel.org>
 <20260420111726.2118636-3-puranjay@kernel.org>
In-Reply-To: <20260420111726.2118636-3-puranjay@kernel.org>

On Mon Apr 20, 2026 at 4:17 AM PDT, Puranjay Mohan wrote:
> +#define BENCH_BPF_LOOP(body, reset) ({					\
> +	__u64 __bench_start =3D bpf_get_cpu_time_counter();		\
> +	int __bench_result;						\
> +									\
> +	bpf_repeat(batch_iters) {					\
> +		__bench_result =3D (body);				\
> +		reset;							\
> +	}								\

You're trying to save a nsec by relying on bpf_get_cpu_time_counter,
but then wasting a lot more by using bpf_repeat.
It should have been bpf_ktime_get_ns().
I see no value in bpf_get_cpu_time_counter() here.
I bet the numbers should be the same.

But please use plain loop and may_goto if necessary.
For tiny (body) it may be noticeable.

> +									\
> +	bench_record_sample(bpf_cpu_time_counter_to_ns(			\
> +		bpf_get_cpu_time_counter() - __bench_start));		\
> +									\
> +	__bench_result =3D (body);					\
> +	__bench_result;							\
> +})
> +
> +#endif /* __BENCH_BPF_TIMING_BPF_H__ */

