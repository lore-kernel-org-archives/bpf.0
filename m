Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795384812;
	b=dRdJCZP5bYjpWS/PNU5JpUo8vOyrLUeIbyuSo9q++hptcjykzpQgfGmMqHkR+kfG5/97
	 +QajsnS5wia+1F16xMsgcfBSRfcTWBH46ADjtFNMBu0K40U1pyhD4KASXdqq5Vjzr5qMe
	 b+SFdnb0ucNicIoexPG9w1UXcqEOTIGD+hGUr7Rnw3IFU3GGdYDW/ZwpEeL+rkCEaJqau
	 X0yKa73IOvg1Gk80ygqIbOjs+kJhb+BZXeRfdCFAxZ0VVdiVLaN1R+cECxkMFiGQeXdCN
	 mSclMaRatJ30Pzb/u3txVyJSa2H+/KmziqFEPguoGDvAUJ3lFhy14s8sOYZJDuw1FAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ObBx2wLZ1lWaJ7WR4wKxB7SLrTibQ+FBYE6OiDtedCw=;
	b=EiXvxXrsdeNT8SgpgS8XnF/uDp9SNUJ61BJ+M4r6RLqfA843RHF2XLLhjoldwW+SRaHR
	 u7u5Aqt/IPA3X77HsNZvU0NCef9A8+dvewd5G9qUqapoj0BcLpIq6QRROEz3cuGWVOKW6
	 F+u3EaqaQd8nbXnw4UO+tMq+ao1tXog2fUbDrTPVYsd2p3AQU3k+GGS/sper4PszWmXO8
	 WvQAEoGpqoI7QrrHpLDAeUOyB3tBfWwT7weDRZHi4qHKYdbwRsFDAI2Nxkz6XnRBKjmIV
	 0jjBc8bBh7Ic6ePaFHxAvl2OIApR3FGRxctlCr/okpdh14YHRijvoLIw4ZrXemw2lbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhqDne6S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E99606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 22:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E99606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhqDne6S
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76ade741cso5036875e9.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 14:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795384811; cv=none;
        d=google.com; s=arc-20260327;
        b=LZi7tMcRi5a5FT/g8Q6oy/nqbxJsHSEY/7/h4TF/jBWPjYLH9INyF4owZ3TG7o25aD
         1o/0FkE+WPkjd70zB+Pak7fu14wozOddlvJujwW7HAi6C68ozuthjP0FTIqGococTpuS
         8I77ISywxktWijlaqg3sh25XFlNxxawiTxC3va/MUKznqyw5PJgrazcjDkjgzMf43SZw
         zmzaFobvltFlCI3VXT1x7TZEwbBiT8VwmxinhFxSFp+/rHJxor9i0/wY2i2di2bO8WCh
         yRGdBP6du6Svb32j5AyjSLskU4dT5TtZ6ffiYlV8LaNyVYN+G/gjP46H1T7RclHkd/1+
         x7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ObBx2wLZ1lWaJ7WR4wKxB7SLrTibQ+FBYE6OiDtedCw=;
        fh=egDHTYiRlWEhjX79I8tyYfgSLjlZiSst1N6eRvPbXzA=;
        b=cD2d52hwtD6nvzLHBlVUuTi+px80wR7XXtGY9bykZxRJDuSSKtF73DLSHQFz2S7/Ns
         77TuD9zicsAdE+vkaokRt5UuCGruTTKG/ZhU1SzpB1vydShr4CLSk0yKnFpDtfZrdhPO
         otoJONPuHTKXI+6QA6xkTv4RYmwhzALRXLPogkwQrNS0nwH6mvqQLN+uOPfhSAcvLT+d
         S/8K43dFSzh9R+fTQHXEO1gu2egIy2Wl5AxBNGNqjoFz+2Uzhaq3fHGWdl4L9O70BMK0
         g06ODoR8K9eWrqwFRCWvBbpeeZzVyaxiHhZLO2bkStlOcL9PKkjf2yqfS0IOlU1neTC0
         02Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795384811; x=1795989611; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObBx2wLZ1lWaJ7WR4wKxB7SLrTibQ+FBYE6OiDtedCw=;
        b=UhqDne6Sjsmz/gFJDlnpTGiRkCQk7BhFefRCnayt5PM04MlSS93kPtBgfQ2UCDmZi5
         isOVkQBBPnKJ91kg0nJWpdhTZ8YIN0NDPkmjMeAadLTbF08E26JM2nWuflnhhz26pxBg
         i2Ksvqa9V/9hcb0DX3Loi3pPBm/OekYrVixGrUO5cEvJv0OKvkCnVTBYpJW3xtTuQThN
         VIH0fLy/7hAhmoviSLEE2nhwpQOdGtG0j2DRLwatgx6/DYBZlIyOPPJ03iKtmFbYe4Dm
         QpKy+5BnlSHJDEhZ4BNBe8zBD/zrECWw/g6VA04eIftthBnPKcTGBlnOWomMPYDnO9sU
         9V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795384811; x=1795989611;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ObBx2wLZ1lWaJ7WR4wKxB7SLrTibQ+FBYE6OiDtedCw=;
        b=ywlqWjxNCDUlLQpNuPdfkQA2Zi7vrWZ90Bk0KnCTyJop1kJ1jvNwuTVGbcq0vgaetp
         9Uu5l07YdoZPUJntqUX3lKfUpuZ3t60Wrbpbiidcx5YSDlB+Q08W+2fVToie1c+M5NlO
         b8ylOEFPQ/OcGYud8H6rc0JdBM5x3qXUIn/b2rj8F0ygm4eIeZ9PVzupiYnO0FH/X8MU
         tfx4rTPOLco3Cz+utFnpGGCFcKbf/QzC/rkN6t7lWWoRcl4DY6olaVtqnDq1b5D0zKlG
         kKyeTYdrL25EXv1WSmMB37lPGs74cseHzpNtOjvEaT74daar2f7bty5RADXW9EZMw6Hy
         YOmQ==
X-Gm-Message-State: APuU4Z8p4Inlu4hJhm86YsOGciM3aIbL48IIn2zwezJ5S35FrvElAIWk
	1zdVTVxuR5q67/TrcZmDTAvB3kakkzK6jcwoKsm7RkS/tuF+UU9qHeJV75civ8AZJ9RgQgRLqeZ
	PKx6L/nxTpVH56HhVHWzJFz6bXv1LTGRoe0aPlp0=
X-Gm-Gg: AZFdTZf+7DFFPbKkEk9S5kCRee4dv4GBqSTzKMOxxhsy9gWnaR0lx/mfudP6FMOcej+
	ewLPGUPlyrmJTcOhsWoAEa8LpSzb34q57bmWSVBPvfNdFClIj9sLMO5v03+/tcFnqmWS2n5X1C1
	J3r1bnEg0Pa6/QeGcfCfEW89vIBHuQfV2vr1EI0gOxnh/u/2kLLeF07vSMyB8VlehfqoZxllhqv
	3KS/t25sL+dwXUSsJ/KNqdfiNxM78w98OA1iv0oufj/+F/zTTJueN4vbGipNYzzfyOIem8ZosxJ
	YiaYDTtC6SuMC98qwpFNcTSDfXrXTm88HocCoW3A7khwY2Vevbuw3gfdvix2Kq9QhTvVYOykGKv
	n7LP9dnNIwRt7HZf8erE9kCbUDBasDJwkqG17bxn/iqGgmSXU7wXycE4DNQpsxd0k/yRH+Spf12
	/Bmtm/cdvwEMjbanMIKyFsuTHPV7kSl0aYP9Dhzldura67b64LMtzOceDzlOkAD6Vuy87KR2dVs
	cLgwYKeKrSWVDKaMVRunpNg3TIGu4cKlTWJvjY=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4bb8881c630mr214065435e9.27.1795384810518; Sun, 22 Nov 2026
 14:00:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
In-Reply-To: <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 22 Nov 2026 22:59:33 +0100
X-Gm-Features: Aa3M54qKKhsUFTei5EMS4AX7nLbtFO46YTvZfgyv2aoJQjyCxd2fcTrkMQbysJA
Message-ID: <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Borislav Petkov <bp@alien8.de>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Boris.

On Sun, 22 Nov 2026 at 21:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 09, 2026 at 05:23:13PM +0200, Kumar Kartikeya Dwivedi wrote:
> > The advantage is losing significant amount of code size in JITed programs and
> > the associated runtime overhead (you can see the numbers in the cover letter).
> >
> > Do note that we can make it more generic, we can follow up and optimize
> > copy_from_kernel_nofault() with cpu_feature_enabled(X86_FEATURE_SMAP) as well.
> > But I didn't want to go there just yet. I am happy to work on a follow up if so
> > desired.
>
> So we basically disable SMAP around bpf programs when they are about to
> accesss potentially stale memory and the only line of defense is for
> is_bpf_text_address() to really DTRT.
>
> And once we open the floodgates here, I'm sure you bpf folks will find another
> creative way to flip the kernel on its head.
>
> And all that just to save some bytes.
>
> Sorry, this is simply not worth the risk from where I am standing.

But wouldn't this be strictly contained to BPF programs? I am also
fine putting this behavior behind a CONFIG_BPF_SYSCALL guard. The
kernel will panic in this path otherwise. We just want it to handle
the exception when the fault comes from BPF.

So I am not sure I see how this risks making things worse for anyone
else. It's not about saving some bytes, if you look at the cover
letter, we reduce significant amount of code and associated overhead
from programs running in hot paths.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
