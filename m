Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7B27EFF7
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776036356; cv=pass; b=P8bz5rlOXKpMm+IcRfrdZuk/Nktx7d5tOvCM+z/FvfncJPzH08g2DW+M+v8yFjh9PMpoQnxzKX6FhjKBHFR0l0q1NEpfKbjdT0qawDhaDztvL0xNSb/gBcggr3QdZZepC1VydFGCSSHfNjjrb6GMh9Qd8GLAiY0alCE1nJI61Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776036356; c=relaxed/simple;
	bh=kCkuhmQWo/+3W0eDw20t1t6YJtjW1AAKz9jzC/5HJUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXUOkzsHnw/a0u3k/hKotyqmEXQHq1m4ufe0YEwYPqix7Dm39Hjr3Gnbm5KSuPnHDGCjOBRjveCeASzzi0jW7t4uSSWCPbmwIHgGZupyNWliL8yHuEC8MCzBte7+5PKn8Y152RaVe84+UcVsDsqrXAXvWqwFydfr+KSA+juGbKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F32/fBHX; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F32/fBHX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso35415315e9.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776036353; cv=none;
        d=google.com; s=arc-20240605;
        b=QdyD4l+xBisL0GcWsAy8ITG1+PIgpkzY54RbBVVY/77iH2JPgXmxVYn+fj+pLgaVay
         q2SK5OfL26G/Tac9gRSKaDEVIbDv6uVIc/1HZmvjscUdOwJN8cvMo2zIrTPLjI62Nq5z
         X0hF+vCjHfOs5Gn53FLOC4ddqRdxGgrs3vDiNQc5lNW3C8SzjcGBHTj60SXz7BbSx0XL
         6up2c4f2Q1Sz0P3ssA+3tiBl8k5EVilw/oSb7T0C7JQly+5wRqbnWvCV0dHkwOrajqf9
         rEpZX3T+sCV2RVpGVpY1fBPMf6kaqFPCRe267c18UG2TYyXt8HqzT4YCIC6wWZjebWkx
         TdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G7lY6S0pU9c7AjVrY03td+fWYDXzqw6gdlJRpqpY7N0=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=ZdcYA/BFXUoU6r05jqhURg28ySmryrfjmt55QRRhbjZuiplIytePFkBsgy5kbtgwaf
         HL6K7V/OX/B2ccK1jOnuWKXUr5LjBBq7q6eBDBBK+0ql8+62lgqJPmQSqhaX8V85z8Ow
         q3hXB7RtkEYHUuSnSg+vc4vZn6yUhpZtRi28cU9VaLtY9axutKZv1PqkvG/jOzmcUvHK
         KcbcQn9a5gtztMGFcqHfPHX9gDGLK9TarvmJrNpJ8PvarRJM4hmFMx/IcWYrFnY7OvN/
         lXVDusnFNlITXdGZCJZ1Y8bWdR0S40rWcFT6/NCuFZoFnl4OLZMhjhpYhKRE2vDIVzsL
         Zb9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776036353; x=1776641153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7lY6S0pU9c7AjVrY03td+fWYDXzqw6gdlJRpqpY7N0=;
        b=F32/fBHXJXgatIFBoJGWJCOUz6yzx4NTITkE2kIvO7MQakqfbpyCzVF/h2WmXs9hLP
         93fcmR8m7jeOGgyGecSyB6XiZKdJBqRLs9rkJsGzTFJHVib8ZEO9SkNgCkXt7ZhA9hrC
         R6tb42w3oT28mQ4mA2gbLHvgA1L0J6gXW++uOUAkzlZolnrgAgDuR+2uJOHx4zyi3Qkx
         zwAYtUD6OsnwaktwEKLhgX89+UKsINtpo3h6p1GowSNzPuzwTSoZkbxGB355IpXH3dL4
         QKtif1voSNXx0n2WgnjB495x98OZQie1iw5JDJlCe+E0++7bXaWv++23XWtE0cfAY6Sz
         ylPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776036353; x=1776641153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7lY6S0pU9c7AjVrY03td+fWYDXzqw6gdlJRpqpY7N0=;
        b=CF9NRF5ArA2sIskbP7cmFTktoapX5DHNk+L/O0iV5VzLj8mcQDGTWzV03WQx/zihEh
         H5JZV7pOe+4nfSO2I4aQXPhjQ/hG3ENqtc6aKjxgIcBXDxd24GM7JmIg832kuwuRJSi3
         Jm12dEkS8t/HqvNKhaOqn28MuyvTSTawhDPY0mX9WHcyNoRgMOEcRWabEB8uIXngc5iu
         n3j0T3cUBtdLyxV3ZEWOsKKY1UZhZzlfVZmg3ETDGKOb8wt6djMJTHrciAiiNX55QFgf
         3tVNomPIS1pvBT5pd04H+xZxoHPymVl7P4VtvJDSL6CS/AUpebJ1/nthGHaqxVv/HJXZ
         wUig==
X-Gm-Message-State: AOJu0Yx7ksa/rLnNw/LCcqC9oAttOWmBI6Q1uePLPVqdGhongmfSr35/
	5d3OndCU+YC4umL5u2jr5hsKehYJ9d9Z9SY+QgNYsucVRgmzfoirDmRGWF/G79c6CPJ+KCehsrN
	m5PDGSTIqV5YxdYuH/O9IgBDnKd4Hcsw=
X-Gm-Gg: AeBDiesk29hygThWuJr4yzLng0eth4EJS008jUFZlX3QTMN6lg3rDR7n2qI0AJYCDFz
	dTKgVQY+k9FPCIcL+RAnvhzSQ27m8dS3pZazSqDOEDKtUnjc9dr1YAz1BqVAsipPiq4h/o5pPUg
	ugblR1c8a94UuVuNmcwVf3n5vfN4J1GzDAyYJpldPcYh1ULV7Jb+du1uqvaIyZjY+7FC8dCbHBL
	wZZAnsv96rjUQi2jqmmhdntgC2LEGVGapnAreTTwQ6uy9wHSuzYj6IjkU0tqqdIxQAJYfxnQrMq
	fGHWy+xTvs2r2x+H2k3wgrSxOwigeDO0b3Jo3PvuG3kyxgth0jjLWiwOf9cBn3W/D/gMJEIBnrp
	Ec4NNsVolz/Y6Ul2VlzQx9gn/rA==
X-Received: by 2002:a5d:5d83:0:b0:43d:1c49:ce35 with SMTP id
 ffacd0b85a97d-43d64259c9fmr16130369f8f.3.1776036353137; Sun, 12 Apr 2026
 16:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-18-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-18-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:25:42 -0700
X-Gm-Features: AQROBzDiTfmJwWkT37i85zaKDVEWIcQ8lzRgXP9wCr53_nEV8epEuQwYMa72y9Q
Message-ID: <CAADnVQJJcEP1zmj1X=GmtCo71O8OVYTV+akF_z0MwxLC_m6+dw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 18/18] selftests/bpf: Add resizable
 hashmap to benchmarks
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:11=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Support resizable hashmap in BPF map benchmarks.
>
> Results:
> $ sudo ./bench -w3 -d10 -a bpf-rhashmap-full-update
> 0:hash_map_full_perf 21641414 events per sec
>
> $ sudo ./bench -w3 -d10 -a bpf-hashmap-full-update
> 0:hash_map_full_perf 4392758 events per sec
>
> $ sudo ./bench -w3 -d10 -a -p8 htab-mem --use-case overwrite --value-size=
 8
> Iter   0 (302.834us): per-prod-op   62.85k/s, memory usage    2.70MiB
> Iter   1 (-44.810us): per-prod-op   62.81k/s, memory usage    2.70MiB
> Iter   2 (-45.821us): per-prod-op   62.81k/s, memory usage    2.70MiB
> Iter   3 (-63.658us): per-prod-op   62.92k/s, memory usage    2.70MiB
> Iter   4 ( 32.887us): per-prod-op   62.85k/s, memory usage    2.70MiB
> Iter   5 (-76.948us): per-prod-op   62.75k/s, memory usage    2.70MiB
> Iter   6 (157.235us): per-prod-op   63.01k/s, memory usage    2.70MiB
> Iter   7 (-118.761us): per-prod-op   62.85k/s, memory usage    2.70MiB
> Iter   8 (127.139us): per-prod-op   62.92k/s, memory usage    2.70MiB
> Iter   9 (-169.908us): per-prod-op   62.99k/s, memory usage    2.70MiB
> Iter  10 (101.962us): per-prod-op   62.97k/s, memory usage    2.70MiB
> Iter  11 (-64.330us): per-prod-op   63.05k/s, memory usage    2.70MiB
> Iter  12 (-20.543us): per-prod-op   62.86k/s, memory usage    2.70MiB
> Iter  13 ( 55.382us): per-prod-op   62.95k/s, memory usage    2.70MiB

No need to list them all. 2 or 3 is enough.

> Summary: per-prod-op   62.92 =C2=B1    0.09k/s, memory usage    2.70 =C2=
=B1    0.00MiB, peak memory usage    2.96MiB
>
> $ sudo ./bench -w3 -d10 -a -p8 rhtab-mem --use-case overwrite --value-siz=
e 8
> Iter   0 (316.805us): per-prod-op   96.40k/s, memory usage    2.71MiB
> Iter   1 (-35.225us): per-prod-op   96.54k/s, memory usage    2.71MiB
> Iter   2 (-12.431us): per-prod-op   96.54k/s, memory usage    2.71MiB
> Iter   3 (-56.537us): per-prod-op   96.58k/s, memory usage    2.71MiB
> Iter   4 ( 27.108us): per-prod-op   96.62k/s, memory usage    2.71MiB
> Iter   5 (-52.491us): per-prod-op   96.57k/s, memory usage    2.71MiB
> Iter   6 ( -2.777us): per-prod-op   96.52k/s, memory usage    2.71MiB
> Iter   7 (108.963us): per-prod-op   96.45k/s, memory usage    2.71MiB
> Iter   8 (-61.575us): per-prod-op   96.48k/s, memory usage    2.71MiB
> Iter   9 (-21.595us): per-prod-op   96.14k/s, memory usage    2.71MiB
> Iter  10 (  3.243us): per-prod-op   96.36k/s, memory usage    2.71MiB
> Iter  11 (  3.102us): per-prod-op   94.70k/s, memory usage    2.71MiB
> Iter  12 (109.102us): per-prod-op   95.77k/s, memory usage    2.71MiB
> Iter  13 ( 16.153us): per-prod-op   95.91k/s, memory usage    2.71MiB
> Summary: per-prod-op   96.19 =C2=B1    0.57k/s, memory usage    2.71 =C2=
=B1    0.00MiB, peak memory usage    2.71MiB
>
> sudo ./bench -w3 -d10 -a bpf-hashmap-lookup --key_size 4\
>   --max_entries 1000 --nr_entries 500 --nr_loops 1000000
> cpu00: lookup 28.603M =C2=B1 0.536M events/sec (approximated from 32 samp=
les of ~34ms)
>
> sudo ./bench -w3 -d10 -a bpf-rhashmap-lookup --key_size 4\
>   --max_entries 1000 --nr_entries 500 --nr_loops 1000000
> cpu00: lookup 27.340M =C2=B1 0.864M events/sec (approximated from 32 samp=
les of ~36ms)

What about other key sizes? That would be more useful info.
size 8 especially.

and different entries.
Think of holistic benchmark. Everything that one might need
from a hashtable.

key_size=3D4, 500 entries... is ... ok. fine. but not something
anyone can use to make a decision whether bpf_rhash should be
used or not by a user with its own use case pattern.
