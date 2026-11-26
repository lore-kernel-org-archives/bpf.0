Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654191;
	b=S4/CVv7jZ+lMvDgydQFwL6uP+ZtUNYRpdAkCCVaL+GEnrzt+e0Dbk7Ovv7MY0hAOQblf
	 OtVVKq8DJPn/KRNwBR49+QULhsIMX/maYKegKxJpg28LcFExvlASxQ0G4ZI1Q3NlvsHKG
	 eNPx+A3bRt5jEXIK4nfEisA7c4Je1bIoddB2rhbOGPDX5y2fJJcB/82hJ5TlpCfKaFEfx
	 m7eX0eJUZuOGhx06/h39SWIbSZ7PqNXzujUooDGmLikW1dWoIbrMc9/esKcX3pZTgTlOd
	 ZSFfhtkDMGY0aUJf9atXaH2h8eCkt86EwYFRG4DK6TvhKsnzXS2kSpT/BB8aC7DNvow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
	b=POGAOP526GfVV3PXNtaxRH+A8iP4mkP2akAd17W8yLT66d+7408lnBI37kbLxXMRcrNy
	 ZPuPLMWiadcaH4it/bV3V2PKLkzBTNEzCOYkF74wW7UmuaMvx83f4fvHJwKC9dA6DmNES
	 aHbtUGFimrMlskDYYLmDx3pY8RHhtd/jAjmvV+Kksc72WJk4jhgm8NPfg+fkoKXDztf10
	 RPocGv6FNyoA87gVsypip05ROeUpN6GKBQ3ai24pObDhXW18ytiLC/yVfPl1tjJ24I7rA
	 PFDVLntOSgBJ9z5+Jj1rr2wgA3W9nClG8h/nvO36Tfeww0kxGi/ag8LWDMs5GgUgJMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E7606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 593E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c516a574bffso106805166b.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654190; cv=none;
        d=google.com; s=arc-20260327;
        b=lmOBV4JiDmFTby1Rop5zqNiaRnDFTa/mglcEJwPz8bezhmmD+/5A0omMFkw7HWwPor
         /71oKLGpnrQY3sljl8fnmPIdy+rWha/BOistA2dUcmBjebgo+QJ07h+BfEezNJ9zGger
         8VsjR4vvlpXcRDEvcrNSD5Eco6XwtSiE3vdlzLpQ2akn2aGMx73Mz/bhHu/fRnwU7PIJ
         lmhvHMqhkvaRcIBgelFb+n5DpFXqgDgN5RPP8jaV6+8qg70Qkm9m7cDEJbdQQj6TAVz5
         vhtRYxeV0M4EL3W0aivt7qL80f/ONikAfqvK8Qhfw8iJpb1nwIheBTJ3NRCR1SwbBRlq
         0YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        fh=E9VIiU1zeFdHIB0+lnp1RMhbuR2dfLFUau/fewqkx6c=;
        b=Hym14sVEePs2TiO+uB/TaATYxfPUmeCo1WVUDghRM+Yep5pMMbzNG1jR31Mf+VHX8l
         rLjz+iz8/aU1SEemEp46j5tDypILy8CG2RjbNmrtL/bMHo36aMsCOHLNplHR4JZIIez5
         WC2qQu2472nMnbl4fyqsNqVDd5XowD7gsOec7z4e69W/no423SJdOqrXBTWlj0lOByp/
         7BhjReTdV5r+peoN85UaKR1SDnnYikHbrFaVo6ufs+WS9UE1wMJCCQs34h0RDn4vUTZF
         41nuYrc7LFiCje3RnpTGYUQsho7UR1c/Mby8WiCve4uBTiTmfij5ESqVGPAw4T9Mgcy7
         cmrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654190; x=1796258990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=TD3ha0rnSCMzB6EDdCanCIo2aztnTVsAWrsh8HrG5Y/aRrFlN2ndLBXw880f1YHLZ/
         QSfxPbJeIna1/g4lWyiIQwpwJD12i4G3TGAPhErD+7VvOdvbXoNFUGW/sZDUdcKc+k/U
         fLW/extCpKtDduL/D3vHzyoVyDpb/98nn+tR+abZco9jsGFWEFngZqgt6TnMkhRshp4B
         KnHYS7XEZFGjKsHdNaQA1fEyq68/xePBost3IMRVEVegEsUL5tFkIeCHeASNeG2SkZb3
         JP9uGCT2U7VP0g68JLBP9wLuAWo5qxzvzbWaRKXYpp5AAo+d01ZiPGTRjL3TT/PoWk+S
         RpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654190; x=1796258990;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=hPPicZqYBwL6kUm94vedFVpD6f9CHkdziXMJo2wnddJ0SExPQDuD54eafjbdSUWaBm
         TC/A6ofx+F5KP/c5ov/VYVauaSyiobI9gcRqCqMAUo+m+s+b7HizhTALQ3vNx+E7dAwn
         df0titjAsKeYUbW7BMPehT6988QAChN+O+2sb2PIUv58ww0MELa6x3fhbQnv/yZJRO7I
         +5MkKElB6hVo6lcQ9qqmN6bHD2eQsUrJEi6rFKoNvUOaq5oYrswuUaOS3MfZU+MoZnTi
         luqRQRs/EavCY7LHCOqbw2eOdSRf8Rf2WVUTXPEvT0PmCqrf0tsEh2FKJwS8chKMShYP
         ucIw==
X-Forwarded-Encrypted: i=1; AL+hErHyYzvY2+BbYL9x2zXrZkZCE73vJED4ERQukarn6Vu5Yllsnw1PDzLV07pHOESfGv14dB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qy2DQ370UbHi38b6lLnuNdC1jZwVKTKZcxlG6Vo1MThjE2bIx
	+FM3vYiuA/4glRPhgXZQP1flyGMn+0dkv3VscUPSEjGLNvZsqYq8c845XWHR+6D8FVBqd+jRe+1
	qnlfds0m+sIBzixI/ADdxt1FyoMTA5ebwaDAwvyGr
X-Gm-Gg: AZFdTZfJbSXp6HVZrIWNEgP2uTsi0J7g4VkLD+eJwzLZ0E98RtINvFg2wpUQZPw2PmK
	ONkiLjnYaOf/x9FhisDE5uuoyb5RTohvISd7A6V0gzic48NnYGx4tc6alR3gr5fWsgBKy4UPpdH
	w+C4nElL1L9jZ60kfajqNqbk0cAE1tOGS4vwdaSK1Tvqt62mDJhfII5PhEB49Iw5eVOPU9O5BnX
	gf7HuIPq5UGY1R60KxwXHifyc8lH1A1gvdJs6mpqwo1uXkVl+FW485O63pmFPSPh198DKtLQzFL
	asCwPPctnKyUhVRLD9ESZS9oL2aJFOy5ilWOM/2CaVDVkhYwS+mUTnFfKXQmZAySgiWSxSmezPL
	AyOEH7Z2YbeNwmjvCRudiN8iS2mUDU1SQ1R+VL4/CITf1fuBOdySEnuxpyTvvvncnPGE=
X-Received: by 2002:a17:907:e11a:b0:c3f:98d4:dfe2 with SMTP id
 a640c23a62f3a-c513aac21bemr1112327466b.18.1795654189395; Wed, 25 Nov 2026
 16:49:49 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-15-wusamuel@google.com> <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:49:38 -0800
X-Gm-Features: Aa3M54ol7ULgIQ7PyJ4MZUA4jeAQllgic7NBQxD7ZgZ6wx9FC8B6-VKox80ApLQ
Message-ID: <CAG2Kctr9Bg+4uz+cKWw79S6qFRPtW_PRDt0rFY73F6WpauXG9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] kallsyms: Add KALLSYMS_QUERY_BY_ADDR
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find the /proc/kallsyms entry that covers query_addr, or return -ENOENT.
> > + * ftrace trampolines and kprobe pages are not resolved yet.
> > + */
> > +struct kallsyms_query_by_addr {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_addr) */
> > +       __u64 query_flags;      /* in - must be 0 */
> > +       __u64 query_addr;       /* in - kernel address */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> nit: same as in previous patch, I'd keep "sym_size". But hey,
> "sym_len" is even better and follow same naming as with sym's
> name/module, no?

Ack
[...]

> > +       return kallsyms_copy_sym_to_user(karg.sym, karg.sym_struct_size, &ksym,
> > +                                        &m);
>
> nit: if it fits under 100 characters, please try to keep code in
> single-line form as much as possible

Ack
[...]
