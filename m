Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A92D8795
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290934; cv=none; b=V6QyECuEdU8GWPrbgB7RysnM2lWE+hmY7dILXlZHJFSFHSGcT2JAtFz+sYfcQZjAsSdHy9+9Ba1l+e77hlpj2hgprBoKbL+CZwmFX8RKqTKfXcatVvT9ZCkGp7k/oA05eoSb0uBqNJPBtcKbA/Fa+nZSxP0OJOiPEjR0C3+TrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290934; c=relaxed/simple;
	bh=GSk2z9B7hJEq02UTz0iG9Bc7cesMB9VLcCCuam+yD+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2XwwurEEB+GeyDXMxjO4tWUEcpwvL0TPYu6ZaF/IzspCqb2V+nb6j6p7vowDm3SMibB+0qqRkPE+QbHEvtJH37X+lAOnu+FSwbcj6jp2SWbClBitzvCbJqvcOzy1C7EkM8+fzQ9nJUfSIKHBCUqCPM8i9ZqRE0UIgS9M1K/06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsuBHRbc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsuBHRbc"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b41b545d9so529683f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290932; x=1774895732; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhMrHW8ir4DnhL82aR2HRTJe1emOfKGPa6mHPdc5eTs=;
        b=LsuBHRbcYIBI1nF9fWgdkmXW+uAt2SYYyg9oRYce62BAkzad3b3vYDxuujxy8WOIZK
         Z0yWBJFfbPpfzij87T9h48We71aBSRpMltnuZUu7Y0OnuWZ8Bl+tPi7PqhSMFi3TzBrR
         SGDFeyelG0Y0yGrJpDeIRHvr1a9B9dzny+OLlOWdDI+Pk502DLDNPl7pPtGmV7OWVZDf
         tsybaQSqysnP3USEg37Tv6tZsrMlovKEmyzCAw7oLKwN2uVuBGjeOw/BDZ3uO4BML056
         WQ+yLtGN9kkklHLPPKOyjSdO0sSyk/yCNsblSjmH4y4Ft7WrbF3WA6/2DrYNOFP4obKW
         laIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290932; x=1774895732;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhMrHW8ir4DnhL82aR2HRTJe1emOfKGPa6mHPdc5eTs=;
        b=LG8ZvmDx/4v53D860HsUYhP+Onku4Cu2gf7MDH6X9tgR5BO/2pJFEFg/KqlSnbpxMf
         6055FI7kLh58ryXyoCBzcsgAnQW8BxjYYH0w9/1PYehVB/PyzLCNnf7GbenbHt6SwjkD
         DpyY+X7ufKjOQDN7hNPkxGDTplKXGPwB+7PDHnysBFGEUMU30ZRKv8fhFv1Sh2wNT+v9
         8fQ1Ge5PmxnXIhWhK3HsXHc3HbaV99eUmCeHdERrzHQtfXc5wwzIE+FkyoMwKIWpHEni
         wHBJQImEeqbSpzEGWbSRPZZGa8+OkYR8/hjVn6sWVsn6JsrRUV5aJMe0FEaF1wwU+3HE
         lqDg==
X-Forwarded-Encrypted: i=1; AJvYcCURyWwpUwUiBwgVaVZj9uXKpKPfhhkRQcUtw7UYiAb+8jMWILt5JUT8lAvr7pvDjHmnZdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpM086ofYEs/T5SkNNw8JyWv4eluZL6mxuVNQpIeutXGiZBKiP
	CilWB0LkjZmADfEt/zt3KLZLOIjusgHstKzki9QToCH/OFi2Y/apLYgX
X-Gm-Gg: ATEYQzxH63YWnvma23ujtJOxHVWwNA3r7vqT32TY3pFLkqg8dOMZd8NIryN4WNtCEgL
	0FbYiPXWryhRYpVbRLVIAqrSE2vrjE5S4vl+v++GDmgLFCngQQS0D/Nt/YRg/LOHvwR+KCTNAmW
	5fvgeu4/iKk8F+RZ6lxofgW9qpk9o0ZF6/zPVk1S5oKOjbbYVAAKFe1yEdEr/eX1mt5U8VBMhuP
	zvL0rb03koE4d/3SpiXNxVCrDSiy1DeXFYK5Wk/SpVHDR1nbWHEFMrNDTGUxmHilugwHHRskizE
	Y+cQHNyjAe2lQaqxw8PiFM8Y1RXhwMZg86F6jt2VMaMDhDj9qdvyZHQs6CR2nA1Itr9v/blZT2f
	kzoVT1uWzBGtN9o9u/cN1pbtNz7GEm/O9Q/QNgWT+sOwd54ZJkPV4UxOGpTmVdhEuVD+jLZ9pzz
	Onex8G7ZRumPwRGBE=
X-Received: by 2002:a5d:5d13:0:b0:43b:446e:dfa9 with SMTP id ffacd0b85a97d-43b64264b28mr19867670f8f.31.1774290931607;
        Mon, 23 Mar 2026 11:35:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703343sm32545485f8f.19.2026.03.23.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:35:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
In-Reply-To: <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
 <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org>
 <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
Date: Mon, 23 Mar 2026 18:35:30 +0000
Message-ID: <87cy0ujswd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Quentin Monnet <qmo@kernel.org> writes:

> 2026-03-17 10:29 UTC+0000 ~ Quentin Monnet <qmo@kernel.org>
>> 2026-03-12 17:03 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
>>> users build bpftool without these optional dependencies.
>>>
>>> SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
>>> libbfd JIT disassembly fallback when LLVM is absent. Together, they
>>> produce a bpftool with no disassembly support.
>>>
>>> SKIP_CRYPTO=1 excludes sign.c and removes the -lcrypto link dependency.
>>> Inline stubs in main.h return errors with a clear message if signing
>>> functions are called at runtime.
>>>
>>> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
>>> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
>>> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
>>> proper feature detection in the future.
>>>
>>> All three flags are propagated through the selftests Makefile to bpftool
>>> sub-builds.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> 
>> 
>> Sorry I'm late for this one, I see Andrii applied it - I just wanted to
>> say thank you for this!
>
>
> Mykyta, Andrii,
>
> Apologies again for missing the review on this series. I'm realising
> only now that it goes beyond what we initially discussed: It adds a way
> to turn off the optional dependencies related to the disassemblers,
> which is what we agreed on, but it also makes libcrypto optional.
>
> There were previous discussions where I pushed back against making
> program signing optional in bpftool. It's one thing to have the JIT
> disassembler unavailable on a machine; but it's going to be a pain if a
> policy requires signed programs on a system, but the bpftool version
> available does not support signing. Are you really sure you want to make
> it optional? My preference would be to keep program signing a mandatory
> feature for bpftool going forward.
>
> Best regards,
> Quentin

Hi,
Thanks for reaching out! The patch indeed went beyond what we discussed
in v1, because we've ran into a problem, where some users could not
build bpftool, because their openssl was built with no CMS support. It
turns out openssl allows OPENSSL_NO_CMS which disables some functions
that bpftool/sign.c relies on. So to support this usecase, we decided to
increase the scope of this change. I'm not sure, though, how common it
is to find openssl with no CMS in the wild. Let me know what you think
about this.

Regards
