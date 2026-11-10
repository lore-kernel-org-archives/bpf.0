Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794344063;
	b=zeRszPTSlEReJA85nQiemwiFsgO+rLo8XNh2k/gXQyFiEmHmw0107KERpQIyW4Gt+ncj
	 fmuIvrWyCTUBHKQ6pUbGkWfKpcUewAMOMJ+0zKLNQO7px0Hg6u4zBmRTi3R8LhgLBEpKB
	 wVFsxzBkLBK1S2uwe/eYo8XGJZk2Ai7EU9gE2ZO3CdgFyTJTo+zhH6rafBasu7lHQlJSB
	 pdljY8qNm3Dz9wQvOCIKg+lwnF9JKtgcJo5LMvsje6pCUWZhIsRkzl5rz2TlmPVCbRpXU
	 oqHSVCnmdtRscoNCW3QwiaSCywTH9YgolpzwbEg5O9t2oXhTmspZyxFwmdeluhxFM/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
	b=1051UD91+MnzY6THGusm9IggCF+yQFR8x8ZfJURLX3XgAiAYt20FGUI67AfO043SCANH
	 HCzj3cp7LEFu2sc1GERHow7RxzDm0929Y29TY49UKds1xy3tZ6dFBAjUtWQn04n8JP+tg
	 jDhV99lCDiHqjkdPwBWCbivmrSmVWR1IG/eRn6SVpAAqc/FzH1qQqsa3S+9hgGl0v1Yau
	 qz7VBT6cnmIbwButs5zCSkxCaZJMzCZaxGLqLQx9iKIEpvdKqhGeEbeyOttxUE0bKq9lI
	 e0O9gOF/3CJYm2YDB2wV9dH9eMga5D/836uSZPndjHU8hu04NiweLlci23tP/BimHrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JgZ5Sbyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C606A327
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8150C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JgZ5Sbyj
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-54492d8a988so9951cf.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794344062; cv=none;
        d=google.com; s=arc-20260327;
        b=pH1Knta84wHqAN7MLmAL0g9gNCKIJE6d2vVwxlAr3jD5zr/qjwmR6hfel6SohPb4LG
         dfY6gf+FXD+xSzZvTLVxmB+8NUu+mzA2LFPJyEvh2jJ+iF4j9hPopgEUvl8Rg0HW3BbH
         Tcg6vVnyfrGWcsi9WHaWX1LjEyEUWv/n+yhlPGAKrNZ+F4Ru6+/NrojIuPAatAocSMmt
         kwFueF3HRW0Mmfvt8dBSB6OR8hGIa8DpRvfjl4JEDeFR/JEXYEGNxPFLGlUOwDTFZoo5
         cAUL6LXk4r3j4T61+YAMrjPKfXQaL82tIrcM++IiHAhpDmvJ7i/qNgW1IvOYuYBnVtL8
         RwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        fh=L1714vWCGaVlpjsru50/NrKLNqGeQgr18/td5Ar+iiw=;
        b=FPrKvsFAq/RWtZHmyEFaOAqT6i9pjJlMzAbKsEVIqP9EolaZvZjHlpxu5pAikvIEak
         EWwiDCBN0J/RhceGaTFfpGUeGh1EwOg7hCLi81lWvCE6kZM74/1+u8mK3Z9z6pC4w+of
         6/qrbttIUAT5kY3oSGal1jrfpyCtOlY9avqTApxBwIQ2ow/W8yhdnTvkfiL6RVz6gRC8
         8K74sWga8MTUQWcPKJbOrUuNm3v8pMqhr9NWU+3vN5Q3joZahVR0PZMi8Jtk6BvK9eEA
         74LoYwTOOqBnOYLpWxN45eCd69XiX9xsP/2xf/Wor++fwUGTr+ImaVYKWhletOnXD1xI
         Ilcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794344062; x=1794948862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        b=JgZ5Sbyj/bfTX1B8fNhEYDl5JbvzsY1ATjB7buyxeVt+W8gB3qInKF3nG1mSpWS7Hq
         HOm4SmWKKTKKCnp3ZEBCWtqjTye+taOOsvKWqAl/+6vCDSMwmWTk6TVM/AwaW2zXSmaX
         zpC+XqEpMqOgmJj7MIOauDRJgHLcDHQAUFouhWC2eeugb2VFqD2qkbIWB/GZSy3Wv0zC
         VoPe2Jw1B1RSXo1orcbn1RmOrLIivsFCJeGUzmuzrRSdEdYjFAtWJjMgftqBs/UtEcVa
         n+sEaWQ9fLVVINL5CH2z/MyOc5Nb25mNy7hP0DVd+Aji5+Blze+HOfFUjkYB3BCAtYgj
         IQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344062; x=1794948862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvRZ4NPr9zuipnBz8AO8lnblNbdj7j1u7mqaDBMXrDI=;
        b=2dAJAq2k2f8zYzLzhAnF405OZKBc4vXo4eYoFWV2rsRyTk6SusJP8J3c8rZIPq6vkx
         ypkOqnHdobLT8mdn55hJXwfAALQ4oZ8ul/WZx5zDsrPbIi/z5MmAKBPqGl8P6Iw3iTHl
         8g1U4B5oX0Av4EwKhRgKhWvkVvOL83XfJjQPDWBLCHd+pK0yQdeRbsEKZ8Bf7ZhOqiXI
         k4F1vwnIcf8GWQwMbFHeUC8baGiQ+AVxn3fAXTnWyi7B1avqlXTIFU1OQ3PStNEzni0T
         b2ahpsxftU5KfrWNGIWqa4GH4NLLPQcF5vG5CsljjoO0zh4JXxLk3//N0Nkh0clvTETr
         gdAA==
X-Forwarded-Encrypted: i=1; AL+hErHlyhIiojX/fkfo97cTAwWXre6FJKkc53yeJHIVvgAXE/uGR/CK8oDnmGnJoWEfs04C/rQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z/Q1ZpUmZdNjj47kISDAozSBQckgPoQxkAzwBQP4OheZrT2aB
	4cr+lFsijd5XHjzUajSyGRCdjUR/DtyIPMxxR5dAVE0HJFLDxj2h5ji1b/pXhpuHDaRwAwbh7s7
	0lr3EjQtzwfT2aI5SRs5z82EEf7Xj8KucW7d57B+S
X-Gm-Gg: AYBFou2mx1u47aeH88ac6lSaUQSNAod6HL2O4LK6f8sR9VoTnGwJeahi3c7RncMTV4i
	X/r4b4Vc16KX/eAX5OTiYxB0W6IfSvxdub7JeYI5iV2/0YaLzE9zyWRH3v1vUvaOX6s/slx9SAj
	96nBAHtRfluDy+fU3kScgzt4mJI6FIrG2nu1OH36PX7wqNn/rEe43iEj6X6kRxrKt26/JiDyFUm
	7zx+pb14i/mG7TwoudREFIuhA+74U9FXSy1aG9OsFSH7ZmVP6HESaQrqvdvAdh4bFNkk+wrLSej
	IKxiTFleBkV3C1+V/bwq2aUchcyzw7jkMiB+JB26jCTZFugL3NJA53qdD7m/G7KeH2ggjeuxjei
	+iD1lHcF2rbJpIFcYVkzQTPFt40epE5AwfGyNjB05GUz88kzTri2eo+esxIArvFpIXu8=
X-Received: by 2002:a05:622a:4c8c:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-5569edef00fmr3545561cf.3.1794344061730; Tue, 10 Nov 2026
 12:54:21 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 12:54:09 -0800
X-Gm-Features: AclHuK8u7iu3KreUV1BOly4WRgYcjdLxbePAeQ91RkjuMYcADS4FO3F63l0qY-8
Message-ID: <CAP-5=fVJfHEt1NTJg43tyGoQuJO4AgBaHzBZQHN9fqPef7i5=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tools build: Fixes for libbfd -lzstd dependency
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:30=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> This series addresses build problems when linking against static
> libbfd/libopcodes on distributions like Fedora where binutils is built
> with zstd section decompression support (requiring '-liberty -lz -lzstd'
> together).

Hi,

Namhyung/Arnaldo, could you help review the tools/build and tools/perf
parts of this (patches 1 and 2)? The objtool and bpftool changes have
Peter's and Quentin's tags.

Thanks,
Ian

> In v2, commit 89d001d48ec7 ("tools build: Add zstd to the binutils
> library feature tests") landed in tools/build/feature/Makefile at the
> same time, creating a merge conflict and only adding '|| $(BUILD_BFD)
> -lzstd' without '-liberty -lz' or the corresponding
> libbfd-liberty-z-zstd feature check in perf and bpftool (so even if
> test-libbfd.bin passed with -lzstd, perf and bpftool would link only
> '-lbfd -lopcodes' without '-lzstd').
>
> v3 rebases onto perf-tools-next (v7.4-rc1), fixes commit 89d001d48ec7 in
> patch 1/4, collects the Acked-by tags from Quentin Monnet and Peter
> Zijlstra, updates the LIBOPCODES_LIBS comment in tools/objtool/Makefile,
> and moves the AI assistance disclosure from commit trailers to the cover
> letter.
>
> v2: https://lore.kernel.org/all/20260909204122.1993010-1-irogers@google.c=
om/
> v1: https://lore.kernel.org/linux-perf-users/20260909181030.1870496-1-iro=
gers@google.com/
>
> AI Assistance Disclosure (per Documentation/process/coding-assistants.rst=
):
> - Tools used: Antigravity coding assistant and Sashiko automated patch
>   review.
> - Summary of prompts and assistance: Rebased the 4-patch series onto
>   perf-tools-next, resolved the conflict with commit 89d001d48ec7 in
>   tools/build/feature/Makefile, incorporated review feedback and
>   Acked-by tags, and verified with scripts/checkpatch.pl.
>
> Ian Rogers (4):
>   tools build: Add explicitly sequenced -lzstd to libbfd feature
>     fallback
>   perf build: Add explicitly sequenced -lzstd to libbfd feature fallback
>   bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
>   objtool: Add explicitly sequenced -lzstd to libopcodes fallback
>
>  tools/bpf/bpftool/Makefile   |  4 ++++
>  tools/build/Makefile.feature |  3 ++-
>  tools/build/feature/Makefile | 19 +++++++++++++------
>  tools/objtool/Makefile       |  7 ++++---
>  tools/perf/Makefile.config   |  3 +++
>  5 files changed, 26 insertions(+), 10 deletions(-)
>
> --
> 2.56.0.385.gac671c819a-goog
>
