Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5D47A0B8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136272; cv=pass; b=P/NAP67BKQWSQrtFaOOXgERd1SvHAF/WjdcYWfF2+vDSYz1VPyrq94+ri9OOtY0eiTyAWn+3SWfVQXuieNZS26/VDe4dqoBX3yRJkbN0fcLaM82jq7m7+xQ+Q9ZT1KhgverOLDtSwWePo7vD02mY5QGGYUnXVIKU4zqimDSsi/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136272; c=relaxed/simple;
	bh=cNuKMIcek4rkNIhg1DjvTNY6u94NrZCdTQHA/3wIBW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnqLl726Ndw1mh5ObIn5P0kBBCFd4FOX3hBXdzjJmGHVj9QbcsyOpGzHtTt11pJ+JOdXGCaqy9YFLpVXg99I1A3nypXxk3P2kj5+lwAF+yWL2bcm24c5xZv54/PvPKvVBhNrZFBbmaLjmpejiZmLWgoWNwV6eLS4YhrqY/oukwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNCYOZMT; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNCYOZMT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso4795ad.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784136263; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7g6a6EOMlPBN0QoLezWaPILfRyaOhECstADIrU1mrX5PZ3umZ52jH4U6VAE0Pssa5
         iNCL8Jnf4oHhmUWiZEIe1CAiqtshcg3Cz7+m8KEY48CHEGxvoTSLmaiItklbUxn2oqwK
         qg1ySeDz7ILmSDMTXaMnj76pZRsOPriDeLDY8l1aCHIe94Cr8AVbyW2xf32njvNqghWV
         P8Ws4vcA7dTffSZuQVxcuKpJZmnF0OaPNQK/XCEie73Fym3ohpeOKxFij8BWctCTGV32
         zRY445e5ZGrvBmR/BTzpsKgm/x+nqYbt8ybZJP5KSmKE8o2PUXRCPs6qxrut7fmLgmPS
         wRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        fh=VaJUAPTQIC/Vl8q3puA1TEFOP0Uhut6IPRXmOlHq/Fc=;
        b=PyEP+/gv16sCzw9BaK8bzUdtuc8+EP1tJOQm69HTd0G2KyQPQqiaBKQGcBwXVHWt6h
         RD93yHNm2zj07uSEcRoPjdK1GM5GpBZxoSiVaFCgt+4G089DiSenXv5tj9mMSEf56dPo
         D/f0wsqcBVe/nIqGuwnjEjYJZFmJavuEV/CMv7BKPkKsa1vC5NnHt+Cf7x2p92TFIIZ3
         vWkmJK900JPFcP3TbPlq04h6AEIip3V6NBUjFAT0LmaURk/nWcGe2i5odD8XKNnxjWmt
         UeTcnsiU3nZvmVWc+XHh3EH07B9Yvv3Upcqemuotz8ihP5T3PyCu+rmFSzVbcWLj05Vy
         nsgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784136263; x=1784741063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        b=dNCYOZMTjKvT0n9mozUVbvLRG1A14M16Z1TvZR3ewSOJ+92NuK981pCGbz0cJR8G/v
         HZ9PCP8U3kNdzdLB1nQyZOJmoUURtDQjt5G4xiEnxaLmIB+YqZ+OmhOctzJMfTUzSCyl
         8dIAR1FJOjGZN1ZxAcLnf+sedUEutez2ZDGxHHev48ljqHuf9Ac7o3Nh6ehLVcbCH9UY
         1d2hJZCCJDaxcxpxH1DPiMp+AoH0JjEUkUWT/MkCA5BElQ5kA1voBaGJZhKWrG08qtIG
         9feO3TtNOD5T7kkt8prcTYd2hJICs34SDy19QNYsZjM7y5d2BOIsiaScDe+/TN9LTuaB
         OWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136263; x=1784741063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZWZPrQd54BSDgxOyeSGv4OPeqvj2vn4bH0lrJGj4Ms=;
        b=LRTtsZPpBYk7Rk3kGVpowFqBPqpcKhhVoxIImJM5EOfd/BQckooo4Yqcj+PPtj5WZr
         +jVl9a+lOhj6Kgqyx0YNvqw/hAGt3NaDRnVyUp2U/Yc1ErQiF9FfeWq7EaHAIQOH0Z/g
         IJ/eKh1G4KK4FtP2HluwmqifLtjaOpAe7JYxbxK6+lpTNbO2xllDxF4Gn/8uY8K3cfRW
         ThaLv1W85+8fMmfLXLO2Q9NHEfBeo0DANsh89wvH2g3KrjHYqSsDAgM2FYOzWucg5R6D
         bO2gJVKdnwXISMq93IQ4Ya4A2HHnYIzxOy92lc1wgja0J1GIfNecgbokVP3TZ1+/uxX0
         Eplg==
X-Forwarded-Encrypted: i=1; AHgh+Rr92oaJx1i+UKUK0I51u9amSm4B0inoBPnyFabFLqlwcR0dt+F/UyyL94qDuBQNgW/Pshc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzs6zUh6jdGJvD1no7BkgSRWSsaqzK3JenWyCW5fGuGQi7c0AB
	KSTCLlcYT27pLMGHvnDKg6xw7k0cykWe0D6ItQpTGR+6zbxUj2U0xVyat4H9Ej12ujOuGlE3V36
	eXAZwSbkdItOn1nqiyVKTVQINnP+Jf1/tvk6i6SrC
X-Gm-Gg: AfdE7ckFFjjbDpMg5NlpkVgc8wboTU9BpU1NCekgRjf69lVGd3wYVFBnRM4RCIMab2v
	k9IfnOXDQEboL7RE86h+kpUuIGniaN697MSzuLg9/c0U5mKQqpephCj/BDurNaY078Ec2VAr6IK
	PaMESOL6VlrOKSmOBqc8YK7chKZ1+uX93HYVebN1N6aZfNpC89X5WGlawYyLG7x5EbiA7CXvdmA
	t7V0vwNYJ06XW58GCM9uqxWGskBc0tWcsVMQ7TW0FPSkxngfzLmKb3XiLCg+REzAsmD4emg57W1
	Ii8I1nToN+x8Ms4DaeVaP2+EEcg=
X-Received: by 2002:a17:903:3807:b0:2cb:14c8:1ab9 with SMTP id
 d9443c01a7336-2cf18cd4872mr182285ad.0.1784136262817; Wed, 15 Jul 2026
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 10:24:11 -0700
X-Gm-Features: AUfX_mybqHGCI446L5L7h2Zp_6_VyrODdqkNsCPAiWVWAbvp3R1ALNx_UrcHOIY
Message-ID: <CAP-5=fV=_CsZFJf9HhNrJ+=jXCTqqDGd=HvwjMWu2WEn9bXqbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:54=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> I ran into the build issue mentioned in the first commit, because using
> an option like LLVM=3D-15 is a documented way to build [1], but only
> some of the LLVM tools defined in tools/ support this.
>
> After fixing that, a lot of other tidyups fell out. I didn't go too far,
> for example some selftests include tools/testing/selftests/lib.mk which
> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
> tools/scripts/Makefile.include and I stopped before touching the former.
> Some other non build scripts hard code toolchains and I didn't touch
> those either, this change is only focused on things that already
> include Makefile.include.
>
> [1]: Documentation/kbuild/llvm.rst
>
> Signed-off-by: James Clark <james.clark@linaro.org>

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v4:
> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>   already picks the correct sibling lld version. (Sashiko)
> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version-=
v3-0-8854bfe5af7e@linaro.org
>
> Changes in v3:
> - Add warning for empty $USE_LD
> - Use $HOSTREADELF in bpf Makefile
> - Rebase on v7.2-rc3
> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version-=
v2-0-f12cc4f031d8@linaro.org
>
> Changes in v2:
> - Fix selftests/bpf build. LLD needs to take the full path to be used
>   with -fuse-ld=3D
> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version-=
v1-0-6cac1a9a4c8d@linaro.org
>
> ---
> James Clark (4):
>       tools/build: Allow versioning of all LLVM tools defined in Makefile=
.include
>       tools/build: Indent if else blocks
>       tools/build: Allow versioning LLVM readelf
>       tools/build: selftests: Remove some duplicate toolchain definitions
>
>  tools/bpf/resolve_btfids/Makefile    |  3 --
>  tools/lib/api/Makefile               |  4 --
>  tools/lib/bpf/Makefile               |  8 ++--
>  tools/lib/subcmd/Makefile            |  4 --
>  tools/lib/symbol/Makefile            |  4 --
>  tools/perf/Makefile.perf             |  7 ----
>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------=
------
>  tools/testing/selftests/bpf/Makefile |  1 -
>  8 files changed, 46 insertions(+), 62 deletions(-)
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
