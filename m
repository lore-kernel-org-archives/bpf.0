Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D5408223
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460986; cv=none; b=Djd040X4WkWNhCiuvqbqJxQ3EcAIfMiMa9xBRo4OIZdOtxrMTGE0EkTL1vQJV9VN4mglkkjnHt/yFx9YBwEMorixCS6eve6n0J8vwCvPwgaQOmpZAaV2gn+APCPEzKtd1h53/gThSVoQmvocJtIHux4qPKz3702AuRTIH5S/xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460986; c=relaxed/simple;
	bh=fEBUBDKjfAQhclj6kewAQ+TMtlrXCeB4SMlk67VLlyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jc9jAgxqfWUllrXzrwciFuOQwnB8CHM3HsX28p3ECj28vHajDuQE7LWgRg20vJKfn6FlM0+vqhcUOPacH8Ir/bZXNe4URXWHG7f4NwDmD88UGes53aO+yY6eozXkoerHwmZKQVz9nY7aipqAA8RLwykClLf8QjAsTjTNPoq1rQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQujRfPD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQujRfPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29100C2BCB1;
	Wed, 25 Mar 2026 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774460985;
	bh=fEBUBDKjfAQhclj6kewAQ+TMtlrXCeB4SMlk67VLlyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQujRfPDB4QAm1IuNe9+5IQk8fzFcdpuN8JQLrS91/TEVnxRtIlFMdlbuiWxPWTck
	 ksCz1bO7syyNpe48fW6BNeGe9mSxM9Wo8ynE1+0Eq1/ciJ4/wRxoNu28T4dfV7EwZ+
	 zJembuCr4/BtmC4iB5QRdd8wfUtrGutCqL4JHuO2q68wx2BmHmh5G1b0juZ3IUlbu8
	 B52x+FP136RfD6X+U8uT9pGopPU1EjhS+BLglK4VNdjTwf/wamwZlcihYEQ9+SOz3O
	 x0gedn2fKUYTue69e7KGxGY6cSf1FU0DtADbIt/QlCHgvMRTZxzktdH8zO+RcHV5XA
	 8k8+Ia9PP3iqw==
Message-ID: <59aecdf1-f023-4992-a277-eb7d17e46364@kernel.org>
Date: Wed, 25 Mar 2026 17:49:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
 <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org>
 <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
 <CAEf4Bzb9b3aa5TmSsi4zM7zyFGOhnQWjPCMObPyaFCbfu3Ow9w@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4Bzb9b3aa5TmSsi4zM7zyFGOhnQWjPCMObPyaFCbfu3Ow9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-03-23 13:21 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Mar 20, 2026 at 5:50 PM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2026-03-17 10:29 UTC+0000 ~ Quentin Monnet <qmo@kernel.org>
>>> 2026-03-12 17:03 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
>>>> users build bpftool without these optional dependencies.
>>>>
>>>> SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
>>>> libbfd JIT disassembly fallback when LLVM is absent. Together, they
>>>> produce a bpftool with no disassembly support.
>>>>
>>>> SKIP_CRYPTO=1 excludes sign.c and removes the -lcrypto link dependency.
>>>> Inline stubs in main.h return errors with a clear message if signing
>>>> functions are called at runtime.
>>>>
>>>> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
>>>> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
>>>> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
>>>> proper feature detection in the future.
>>>>
>>>> All three flags are propagated through the selftests Makefile to bpftool
>>>> sub-builds.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>>
>>> Sorry I'm late for this one, I see Andrii applied it - I just wanted to
>>> say thank you for this!
>>
>>
>> Mykyta, Andrii,
>>
>> Apologies again for missing the review on this series. I'm realising
>> only now that it goes beyond what we initially discussed: It adds a way
>> to turn off the optional dependencies related to the disassemblers,
>> which is what we agreed on, but it also makes libcrypto optional.
>>
>> There were previous discussions where I pushed back against making
>> program signing optional in bpftool. It's one thing to have the JIT
>> disassembler unavailable on a machine; but it's going to be a pain if a
>> policy requires signed programs on a system, but the bpftool version
>> available does not support signing. Are you really sure you want to make
>> it optional? My preference would be to keep program signing a mandatory
>> feature for bpftool going forward.
> 
> Hey Quentin,
> 
> I understand (and sympathize with) your stance that packaged bpftool
> in distros should be fully featured, and I think we should push as
> hard as necessary to have it be a case if it ever becomes not true.
> But the truth is that bpftool is used in all sorts of limited
> environments where its full functionality is a) not needed and b)
> logistically a nightmare to build, so having Makefile-based opt-outs
> for some parts seems like a decent tradeoff to keep bpftool relevant
> (instead of forcing people to do some ad-hoc hacks or
> reimplementations).
> 
> There is nothing stopping packager from doing a custom patch ripping
> out crypto parts of bpftool if they really decide to. Only users and
> maintainers push back, really. But apart from extreme laziness, why
> would upstream packagers cripple bpftool like so?
> 
> We should stay vigilant, though, and if you notice some distro cutting
> corners, please bring it up on the mailing list and we'll go from
> there, ok?


Hmm OK, I still believe making it easy to turn signing off has a higher
chance to lead to the feature being unavailable, but if you actually
have a need to strip out the signing part to build and run bpftool in
production in your case, as Mykyta explains, it's a valid argument.
Let's keep the option for now, then.

Thank you both for your replies!

Quentin
