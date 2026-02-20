Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25D2EA468
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628679; cv=pass; b=J+28hclFAIX2IOdrG6J2Fx6vHVZ31MTon3r+iEV5OMDHvPghRdDis2oNEMbb+Z1+pLdAV6mn0x8omsBGbnb6dAClKDdlq2I+xPFjQBSwSDDB0PxpLCfquC5yv4KMpd7K3PkrXdVsDz9eeDpsEK4oSfF1izqgWeg4/hJxlo+GBiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628679; c=relaxed/simple;
	bh=o1PSwEqlQFu4PMd73N09DWDWcH91RMVfhVxESBCLNNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9fgdRr5oU+nFKUXzVE/3qahC0pdCctlSk55kq/fSVkeos5sFNRbScD/BYhBWmDuFH3S4f0XMXEBKyT1Eh/DGgjlTw7715UM+JLRtGIQdHWiyb66A2p9you0b5fAWwCx52Jpqua797ts9i6/ROaR4+xvDv7Q2F7mb0LDNi/lfpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS4udWDI; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS4udWDI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43626796202so2293005f8f.3
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 15:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771628676; cv=none;
        d=google.com; s=arc-20240605;
        b=Otbyn4MGv8cMmFfQen8yI73pfrdppBSfAFGIc3CkNbSliECeF0ASE6K/KmUsdbDx6N
         Lp/nS3Upz2IrTOlueSp2sgKqaiLUGIenU7wkVuQsbg/ytKeZHzgBua+DBzo3uOY2bB5K
         u5lNPJF8ckT2N0//vKB0agzZMmlebrG5NKq7bwvW8OiAyFObfjhFPmrzDS5dBxXjUiOR
         nnqSZc8Y8wi2roKLXXwcXq5JE2YwStgOiWPCEmOX6pc2E//jAmr4PGXSK3fecAELlTag
         wpdNe/wrMVRLg/N9of4NLODr9QL/swswWupMbjRP3bdR8LkcJl5voAmw2oKm+S+eQfRr
         c9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0xxEqMeNHQPDehpi+Iv7LuQVJPrGMivlZviDytQ+j2M=;
        fh=iNGJXngWUPIj2qluOM64QXkQSMt3jewt6uz29WDbjqU=;
        b=bEKMzclGzlwLyucrv7/qBbpeYPNDSf7q0uUBqx+SMQEKXk0ijzCbCuLj51N9Gpf2ix
         0qWC2b/q84FLxt5U4S1fQ9RcnfxIkf16GV2TQA/Kj7U1kjCFrOweDukMZoRmYU20+C+B
         vdwEaGORfwp2omwiz+bcCLqliwKF4nWJ/QsUwrC/eDs9f6QH4eqVVJQo80OL4LU2bqXf
         +TGm9onLzhJj3nziUJRviZaBQhMpk+3EZXHqKFCak9y9xYiG0xz+xVioWhxZynFcjq/D
         7NTs+PC48MEN13jXEkvYpN+hckAP2HdAVbltOWuDbdhzaGr4LZe4yW8QFXaVoyB7TjRA
         0j1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771628676; x=1772233476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xxEqMeNHQPDehpi+Iv7LuQVJPrGMivlZviDytQ+j2M=;
        b=gS4udWDICAaw77pPTnRPnDkzNmbckcyjxMGHILCKbdPFPA8vRKx65kppw0bWI7MfBS
         WpHxQn9mzd8LUJaVuCovTZ25jEQn/EUQOg3Xq8a1m0Br7aJm/QxP/Z753FG8UAXW2lFP
         v/uH3PH1oACAFeOB4lioPGMx8qXYzp5TwaDHKbTggwauJ9qY5mCY+a63XBh71UAIncQS
         xsKXuFU4ulTJ3J6GoTgAhpIARsJY7b7YCV+HU5jLijL2cN7/QXljhb/H6dP1rv2r/eiR
         u0wxGK4jka981apIx8O6+vP790TXHHbscOscjCFaE8EIRaZkQaZylraOfRbpOF6TOY/2
         Pd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771628676; x=1772233476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xxEqMeNHQPDehpi+Iv7LuQVJPrGMivlZviDytQ+j2M=;
        b=v0aINPSAFkinAjbgn82dSsM9fl77jLvW5wvjRqUyxwwiorNIMvtCUifop3+K0F0h/9
         J3ZjqY8+hACHG48jvLEFQqb2m4xUjgRBWYvxWZ61Vs6qEndC6FJhpVL0FiGx98cV/i88
         E2UwjcU6NoaVtL4KqT8mqPQBweMeo4mZNl5o3IykSh/hRAcjVG+VwlmgGK0jkbS1940U
         M5fji9mvFYsWeYK0BmJJWfTTqWn5TV2FNjtpua4sul2v42kxbgkWTKIn3ywQChDm812E
         vHApYj0AFcTTQRjUNi9u++lACmJzoaR0v86fngRKApdJRTC0mYoJXZ+cwOtjCDCiLmkV
         kKcg==
X-Forwarded-Encrypted: i=1; AJvYcCVyQP/djyUACQ094js3mwO0liSKCoS8SutCogNrYCrF5gq5xDQqrzSWZKEu7o7FYfKsxLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZ+97foUJ0jyqvest7B+mO6XYhND6YeDGeSqdrwEiQ3XCmKim
	NSv3t+wE9svsII48li5brGIaPvMxkEkUaC4rQ7N6swezhAzsctiL56A1a7Ko5fSvOqDifIJHhBy
	9Lj+/N9MF0MkFP6h67u4eeMW9OxDWlx0=
X-Gm-Gg: AZuq6aKQLEBhl4i9x3WAvv338jCffbtGHnkyjKovlcb648GPjEX3y3ZwvMsmFsnWGlO
	29qtD7FUhEWfllwxeFmPRPAdAIeOJSbI82XiraFx+gpV+/v+QtTVlAgvQuelX5u0wvyecteuUpo
	v3U3cCq793AGhm4EibXtp8rJf4txpw5dbOM/U6miAMlxTtiUl1VUVfcx4D9FGBnc7146S5D0UVc
	C3+Y7QVM4MQ+YcOMXdz7jIe/McTT9PCBjcr4G3HMbmlg/cjeG88TTqbD7kIEGYsInHR2uR8x3Db
	xKCUjKwWSxt96cuPkAbj5uGkDkCm6/0b/GAj8FncirilVYaGjFo6xv/rKEpTKnkZAJeHQLYFLWw
	0WQOZo5Ayo3jlmTS8i9XN/fO/yA==
X-Received: by 2002:a05:6000:2507:b0:436:1a23:3949 with SMTP id
 ffacd0b85a97d-4396f14c9f0mr3128730f8f.10.1771628676363; Fri, 20 Feb 2026
 15:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220182011.802116-1-ihor.solodrai@linux.dev> <20260220182011.802116-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-3-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 15:04:25 -0800
X-Gm-Features: AaiRm51IrlognAPzrrNojtkEiTSM06FjF37xKtXRcGD1D0poaTrF91MyMbaY9AE
Message-ID: <CAADnVQ+VhXCM0DuDz7nRb2iMoA68igMrgeTwE3c14x7FmFJYVw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/7] selftests/bpf: Add strscpy_cat()
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:20=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Add sized_strscpy_cat() to bpf_util.h, which concatenates multiple
> strings into a destination buffer with strscpy().
>
> Add strscpy_cat() macro with varargs.
>
> This is a convenient helper that provides the same guarantees as
> strscpy(), but for a case when multiple strings need to be
> concatenated into destination.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpf_util.h | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selft=
ests/bpf/bpf_util.h
> index 8c95ef7ed7c0..61bb22c3e517 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -52,6 +52,34 @@ static inline ssize_t sized_strscpy(char *dest, const =
char *src, size_t count)
>  #undef strscpy /* Redefine the placeholder from tools/include/linux/stri=
ng.h */
>  #define strscpy sized_strscpy
>
> +/*
> + * strscpy() analogue that concatenates multiple strings into a buffer
> + */
> +static inline ssize_t sized_strscpy_cat(char *dest, size_t dest_sz,
> +                                       const char * const *srcs, size_t =
n)
> +{
> +       ssize_t pos =3D 0;
> +
> +       if (dest_sz =3D=3D 0)
> +               return -E2BIG;
> +
> +       for (size_t i =3D 0; i < n; i++) {
> +               ssize_t res =3D strscpy(dest + pos, srcs[i], dest_sz - po=
s);
> +
> +               if (res < 0)
> +                       return res;
> +               pos +=3D res;
> +       }
> +
> +       return pos;
> +}
> +
> +#define strscpy_cat(dest, count, ...)                                  \
> +       sized_strscpy_cat(dest, count,                                  \
> +                         (const char * const[]){ __VA_ARGS__ },        \
> +                         ARRAY_SIZE(((const char * const[]){ __VA_ARGS__=
 })))

Interesting idea, but this is not bpf material anymore,
and api needs to be discussed.
Let's drop it for now and corresponding changes in later patches.

Re: patch 1.
I think we can do kernel's trick:
        CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS=
__)

We have ___bpf_apply and ___bpf_narg in bpf_helpers.h
so strscpy() can be 2 args and it will make patch 3 less churny.

Also combine both patch sets, since the ASAN one depends on this one.

pw-bot: cr
