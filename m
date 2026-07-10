Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A563A9D9F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664589; cv=none; b=GC6TEsalPGFcT6VZejBPD3JaOHW5LIarU9kd8K7CTlkCwvE35AFDUMZsMwlAXqAkNNqKEiG+6LtMhIB+JRCM5SERdBa68/523xnWUmTj/mbYbEKUCPaeqfNlu5Bm1zhcoAbJHnA0BwXnVeeuEFQZEp6V3WTuij5+x1vpG56rZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664589; c=relaxed/simple;
	bh=PVv2MCpFxt2nbQ3TmkpbKr8KYkb16+WqF2Z6hSpHJU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc2uK6cbE2FT/vQvJPlNCb/9aBHBURXfj+i15A/Q/8pZswdhitJdgDiA7Zis/TpHYeIDe5GYy4/wx412at7qs3d4m4LU0m9UKOFhf2EIlYMl5+qVV4Y46Sumvbe32sO/GWlCWGpNJif+w0IGraPjFKHcoXbohK9v33pPwQu7Exc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVcxYCC6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVcxYCC6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso528925b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783664588; x=1784269388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PVv2MCpFxt2nbQ3TmkpbKr8KYkb16+WqF2Z6hSpHJU0=;
        b=oVcxYCC6UfcO5GpsYhyGPl73/E0VLWOI/fSKouSFUmKhFxXOHWoiBi/84X9pfsSBe3
         qv/0CACClL9NiEeefu2J1cTc5S/5bQcuDs7DiL3xg+YserrTTnhz26O7IaoeOe9yRR5m
         Z6y7tNUnC4aPTk0qFYDzs4lOgTj4+EjPf7KiNFVD8u0mbWX3MfRHdPNets8vW1fiTcsk
         ZsW3LLrvXqT9ok55jHkUNvrI4/blJ05fy4vCKoIicatUr37ghiBR0WyLMrtZ6Zoc0muL
         t1NgAS6ZkU+C7f2G7WA7oc2uy8T9WH4pqi1nv3G7AH3qm0ViCg9IfARizlSjM9SFI7a1
         gd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783664588; x=1784269388;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVv2MCpFxt2nbQ3TmkpbKr8KYkb16+WqF2Z6hSpHJU0=;
        b=Jylivrw9C1WJJ7CxOSC1MbIrAUglGVbWsCJWbVOSrY6TMqYSowdBtaRvxoAtp8N0zC
         OPLs294UanP+WPlb6OIPkX5OKxx8KNWejDenlnA6fbHhvdZeqVzssTEAUtAY7kf73V3l
         f7U1Jqe1czWdhFFHz3Ilc29Yrr5aYvljTYDvw+EjfYS6IJi0d+ixN733KjdHFJM10LY2
         2ZOX7aZPy33P/6f3U/pEfijLT+b4vIUfCWRgE056RCeAHYMMLF2erWA6lyDANhe6oyBo
         p4kXTj/dQxfoqigIRO67Ss4BKcVPrj8S9SVCuylj8P2aJlilENWLKofmHSKjnWQmTUcg
         BuGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWYQD/osC9jAxWLEW2uI+YJRB5xMAMfmz7+kBgiQofpULWOPlWuhilxmEEUlnsswSMBr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DhdokKrIhGwcoEQnNWH9bC9VEn00nCxk8euteFifEev+gjOF
	PFOICz9c9KoBzcjhwy1jgKu07bky3cO7qiw2ztNMozMuxm+NGK7yoEpZ
X-Gm-Gg: AfdE7cn05tFNUQzyZyoNiRqXxsLeDy1/RM16TbYD9ruPgp15aoV9wZNCZwliMbJLJb9
	p5LQU0FEhp4gYZ+zH/RV0pd13kqNPSszWPH8xYeanP9uhP4JOa/GuAseAT6GGxfWQK6FCspE4RA
	4gM/l9iJJbq8pWRLqs40YsxqVDF3BEHz3n9od+sl+lgF3XLVAP4vc+dlFzSb7f1ScCkHlSd4ArA
	ulAldFLhGbNcIoc7m69IkEkdQn1gIT4x1l/THCfhBZtgDOtdhpsW8nkEH05HZq9j3QifEXnMLEj
	BDqGMqbYl3P03zMhZtzO6cPlCVYKxvBRvsi3T8ytdxZRgNDDEnawf7qycibQFjvr7wSrV3wIQQG
	o3BsPySdIH2cOnbS9ZraW1ARrUx5UkcmYhYwKHZFjmC3FxtatKO6DPkByC6krzyciHPUKzB3NVA
	TXEj4YMYpd/89IcpnFjKHLvHK/uUd7HQyyKCnvDH8B
X-Received: by 2002:a05:6a00:2e08:b0:848:7475:29bd with SMTP id d2e1a72fcca58-84874753fbcmr1656412b3a.7.1783664587901;
        Thu, 09 Jul 2026 23:23:07 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848414a34f7sm3768820b3a.44.2026.07.09.23.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:23:07 -0700 (PDT)
Message-ID: <4349d987d34f9426bdbb09a5d02de61da8f3e746.camel@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for
 buffer pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, 	memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, 	jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, mmullins@fb.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 09 Jul 2026 23:23:04 -0700
In-Reply-To: <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
	 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
	 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
	 <ak8XSRiLKx5WcIQw@u94a>
	 <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
	 <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-10 at 13:52 +0800, sun jian wrote:

[...]

> There is an observable effect on the target bpf base. I tested it with a
> temporary raw_tp writable test_run reproducer, not part of the series. It
> attaches a raw_tp writable program to bpf_test_finish and triggers it
> through BPF_PROG_TEST_RUN. The program does:
>=20
> r6 =3D *(u64 *)(r1 + 0)
> r6 +=3D -8
> *(u64 *)(r6 + 0) =3D 0
>
> With KASAN enabled and the BPF JIT disabled, on the bpf base without the
> verifier fix, the program loads, attaches, executes, and KASAN reports:

Could you please identify why the behaviour differs between bpf and bpf-nex=
t?

[...]
