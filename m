Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2E2737FC
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646768; cv=none; b=I/wf1xGaJ6Pzm+cjun/x8D8XVS4ufGjE294lmrlisf7K+PeKy3ehB4RmCQVBy2JXTIO8S7NqM/BQwzikF+S4DDU4wtA7ZGo5yqwaerxOLFAYQwjLO91YMIFr9K/A4BKZpnNLtuOF9H3GgSEZzFUoX+bIOe4fahzn9U2hZuMvG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646768; c=relaxed/simple;
	bh=fl3STTb9g1bN+zVFtiWTEIfFNejzAImVBStPQ3FGDh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YU6+H0pE7n6/nKM+OdD4Mt9dlmcPS+kztbuF8gcfianZBbQwK5j59dxZ0XiA6QunWMOUE4K1xj6tVOrrfGEoqyXFGn/r0ei3VlDAG+b5RpEDt8PoQ5NApzDO2/dp3qDXJ8FodDqwglKaSmvFP9+x5UIQzjmqiXU4qokUkWNkOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSKx+FRc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSKx+FRc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf52d15d88so2681285ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646767; x=1787251567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4WBQUJNBj4gm3nkbf1wAAHYIzbwVXwE0hHA6lPxo1Zc=;
        b=rSKx+FRcDHynsAUCASjOJZUHRcRrbywVgUqL+zP4tNZ7yJ+5P1oJQs/+kQETzRFdYG
         rRMttAspX2q4oz2hOd0HnuLs9dz3BHtgFIQPmt/EorF16ioM3D1Bpok73Fk8yOXj+2Ar
         5beGSNubFZHx27jmQudxRiY6UCII23wx/HtqcnCVRFDybOfxduQ8FLcwjHoAKvn4ORwP
         uwpzUZnqqZarOjhubyjyc21wxL0KZzPPIZfmyHmRBeHb6T4OXY6s/+5A8kh4rLuV/nl6
         xa7ET5kpOWpUyBCW1E8SJlNd3+WlrhZp6QkLY5e4JaIJR250oBAkMVlih0XxAwdM7eI2
         yC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646767; x=1787251567;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WBQUJNBj4gm3nkbf1wAAHYIzbwVXwE0hHA6lPxo1Zc=;
        b=c7cG49vt1i5x5BKINKJqeK8jz5oNQDivCyuvf60jxug6HNiDqYMNQP5mKkWP7KQwUw
         UqdhoaS7AtR/aCvYv7kqOUwa9AgWifXmdFyu3SDwNrpCnAbHLZLnRVRqi5+D6vM9YWj7
         FVep1RLmeuiZyHoB+Dj6vUmZC7pPvweIHaezB9hi1pFuUjNAqRURLU5xMXQDSrzKzjcs
         6RZB18MtCCL1m2kY7GrkjK41foWLrdtCVQhWnKgQWzAkZCllBX7QCiwCKsypX4efI38K
         dKtp7uYPXchtMxapLaBoFwyfoRgFg2kiq7iFZvV2ltKYYB2ljyyC9oIDlAHuOyiWXbzl
         HjTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8GCPXvp4TsIdZT1O1o08rQkDsYtl0yvp7DRWxAkBL+e+LCEvz0FcOZFH2tX83td666pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhS3cxuWK44F4Tl3QWl3X5AV1QHj+X3/864UXXXov1dbUCdLil
	hQ3SzfpEiwNiZI6Cd7hhAb1ERkDX8C2/4fk1rjLh40KgQxRT+lF6b2OwJl+7t1E1
X-Gm-Gg: AR+sD10FzV+V42EzViJPmG1EPVY3o+6VGatQTqokOYfoM6nbnPGDRWlKFWit1DtuAeA
	rAM/eoFdE5lRjAjio0hPqmW30mCp5qyruIQonH3p7tXi2KGWYbho522KUG5ZRKfnV7rNKhRkP1i
	Kv7cm5LWarUqFX9P7k7ARUV2ww78AYqEe5CGQHKEstCku6tKWEsspSRiFXIf2VQ6iaTHpnW8Mip
	sW4MOlG83ATPImSgc91oaSpLUHkeW8Y8CBNB0n6wa+SlDtMu4YoUOq3ybtMelpFNn6DxvfMqgpn
	LZulSxGMxh0CTsqPRnEU/kY5SfTOaXYyr3A9EzSvJnSRdZ+KIgBw9RfxArgBbXgVmO/8F+WhMpz
	9hKPGYh96tdEl2qasNy0EAmPLwKrUo9WAc7JYqwFow0ILLqod/aEyYkRYAJziQf330dRrufoup2
	85iQVVdQvZ/+XZVdsqjiC680EOL8JGchRP8hmTP4fJa3OYRWP6nx46pr0OK5BoUVPCbs4MvrrZR
	dUiHHOWwKSzvPwlQ04Q7Hv7EvIoDVXA247Z3DXd5ZoNHIMiCX/ZwkTm
X-Received: by 2002:a05:6a20:4310:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3cc553baf77mr9972283637.28.1786646766921;
        Thu, 13 Aug 2026 11:46:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm955861c88.6.2026.08.13.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:46:06 -0700 (PDT)
Message-ID: <9eeb3dac1f9fee71c49028d8dfb8d35d31b832ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Add verifier diagnostics report
 helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 11:46:04 -0700
In-Reply-To: <20260812233326.3575958-2-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
		 <20260812233326.3575958-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 000000000000..ba57aabd399f
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c

...

> +void bpf_diag_header(struct bpf_verifier_env *env, const char *category,=
 const char *problem)

Nit: no external users for this function.

> +{
> +	char first;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	category =3D category ?: "Verifier Error";
> +	problem =3D problem ?: "";
> +
> +	if (!problem[0]) {
> +		diag_write(env, "\nVerification failed: %s\n", category);
> +		return;
> +	}
> +
> +	first =3D toupper(problem[0]);
> +	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, p=
roblem + 1);
> +}

...

