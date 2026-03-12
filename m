Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2E2FD1B3
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341496; cv=pass; b=Lm6EgOmITi3QGKCnDDfSkPKuWKI2HUGlBk+Emq4IkcgObjtCWeDKqAAf2ytH6Wi1/isc5B9Mt2zdL2g5C+fMgCbtFEbXyZJxFhO+v3Q9ZG7Fe9kf2d3qcMVtJNKl5q9m4v+Ek+f67VrwO4haxxGxgC1sVmFn0lcZMaVy71TBJIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341496; c=relaxed/simple;
	bh=jB2gR3dwGR8A6fU+LZV0XXQucGe3r77FgZs9S0XEP4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haZGdAXOiCQU9AP4zvi7mDntnJaNoNFyWodVD7hdyvoeOck0plDeZyQk8tdTcdiwkDa99GMwl7/kPMEqHI2LmBhcc1MMO1+wWEyObnTyTnKhk1YHJSxAeodRboeCCHWY1AFG5HiMNSA2aetYiZW8VJZQTh/0FMhGIv3BPhLzpUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4ykGlJv; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4ykGlJv"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so1906a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773341493; cv=none;
        d=google.com; s=arc-20240605;
        b=iqMUjjVIZYOTlht4VetjpBZr/8WhIfiyXOdiAKGWs0iLADGnfYwwLYhztErjTCtXMY
         Zf65p0n8ihdSuxNHC0f3R92+P/AAsDSX1iKrs0NPEDvZLWj4R55Kyxx5l+QC0TXdLXaN
         d4AHOuN1lJalczo3iYC1rzQTjoghemqd5JFogxTbfvF3JcDbmB2ZSg0WZshuDJwX1zOI
         mOApSKBUWVNK+NfxHrNimrcOkz0f9ttIcreMNl7MxQgZ8Y0lh7brb+n2p9gzJl0hBRRn
         b459IPO2N6x/5+5VryvNaddSpqB5hPRpa9hUg+W5dChs/y3Mk2PINkJYXjEBWIUvPwlE
         coZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QFnehsTB8Sk5/alV9Sc7lE6F+ZRU9x5rPocvi7MUWU=;
        fh=BC0DKPCDGhcYlv4TqRbiN8QCpC/xZQRpRcjA3MtsM+8=;
        b=Mc1WQYQz3kfZnl0pYkvgBpuQpt+2KNXNRhnSawK6pnFbESS9QZS6A4LfaZLGoAcykP
         /S89xtjxd/5lb361uYaDgTQ+kXXcqkNxBbePdbcSyocgNdEPTIzYfSmTfQ3xdaTVwMsJ
         ACjyaPdzEvKVYKHNyspEplvRnL8P6/fBia1zHiIPa5lX6Qxh4vhbVnfOlBy0RaR4nE5J
         BuA8odn76z4B/BjwzS5nMJ8tTAYiWWtz3xbjtxvEn0Xu1M8fOaEwyb3T4buxOPFiGZna
         UR15TElkt/xv+IdE5cw8GNOFI9CWAVz9DNpiqYCt9R6Hr3a8GSfkMKKCtP3UDpSBdiPQ
         Xd/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773341493; x=1773946293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QFnehsTB8Sk5/alV9Sc7lE6F+ZRU9x5rPocvi7MUWU=;
        b=E4ykGlJv8DM6CuX67Bcb84+TG2wtcNjvCdm/zvTfcVP8+EYczqafIWOaQad7UFSOhU
         6c9764tLtyyPkFwC4QydlouqXIXFC2r5PKmTaDPbkCmBUnxzddkMUMtNk1O6AD/bn4oC
         g5B9hzNb6Xs2BkO9wKMpnb6+ybYHaWMyM9i1msIbelCeoewKcjjwVxkqKbcxfvRB4W1f
         +6LpcB7fwWMyJF5H/+HpyYeNGkdGUvPuR1slcU6dvQJylX92abc4C9mGMFDIiW8V5MyD
         E0lgTTx55DuxwssKajYAPezAsvSFnTTD93/cs9vspxW7ovGJLibj5m+G1CV3oRPpxVPT
         4cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341493; x=1773946293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QFnehsTB8Sk5/alV9Sc7lE6F+ZRU9x5rPocvi7MUWU=;
        b=rqS0G9yaG9q08pHqDU7joEafjjpfMOZsw66/KtRc0Yx2qqN141tOfAjl4/Iv0asWhI
         0xyEaZkldjAJtq4sR5hNHAvETOZoX5/5o81fH/BMOxMelbcn2B7oUgjz2GjvAFzbQ5wY
         lKt2QiturznSSWvoot/zmRzrNB7V8pUswpa8gG/hR71ZFKnw/CGBYZzSRFkwcqKDm9dB
         rsO2yd2W+rXAaOYsTSLxPbi3XyXRi6PtNniyB4T/YeQ9qM28T1HTA4N4wetLSVJYyR70
         8NnnPyy8QhAuWhXspShcrhBaBYQhG7UA5JrngySVy+jkeoBtBGqnMUrxq2iWdI+89b3P
         5kAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUNbFELzILx0sTHCZDuiFGzJmVwxSXQcL5wenySRIlH4IfZ6TOu0o/X0QWALrKGC/lu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNaX6G5o6edgfEtTY1Z/NYYiuWpP810lpu1ZadIwTrvj0P3lj
	WEzYBxEkr1B77mV5wgoA6Oh5t7HWMGjCpUZlUMLEYaiG8pn2HSOJkKs/K2bE1nV/bss5qDwQb8J
	Le5XMd6Qr0DvnhDFT6UIFyfH69JDX8UFj3eugsf+D
X-Gm-Gg: ATEYQzxvRTmf8IpGK0HpxX7J3A3rZ58odf37+ekKbdPUFlN2clJ4m2iEcVP3w9amzOi
	H/9OuADWzrD6OnYi/pa+C/8X+LKXbWjYkxvURGOIMKkh2edYtL+BowvLkoHuEYJSP8qdoadPqxz
	1F5XNsYRyuEIHO6/GARuwY0uexHkGzwYG03k13xijqm6sFnTx11uFWeKiWFgTFw6MEzqFr6QP1z
	D7FKGeazzTzX7BfUqQnlzFYff7PrMkjEdl0zvY49bGPimHjWHuObf3i/YSdH3r6j3XXPoenWzCF
	H+Ou
X-Received: by 2002:a05:6402:1bce:b0:660:de93:f323 with SMTP id
 4fb4d7f45d1cf-663bd8c2378mr3777a12.3.1773341492545; Thu, 12 Mar 2026 11:51:32
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183818.2721750-1-cmllamas@google.com>
In-Reply-To: <20260312183818.2721750-1-cmllamas@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 12 Mar 2026 11:50:56 -0700
X-Gm-Features: AaiRm53aGx9QE4qkDhj8Xkv9B5u77uZIgqDbrnlQFU_VJ-5aCH7y7dOjmOyRIVA
Message-ID: <CABCJKufHM6Nny9c9zTpwOzZzzyahxa40fp5JTm0H2oW-EO=9jA@mail.gmail.com>
Subject: Re: [PATCH] bpf, btf: switch CONFIG_CFI_CLANG to CONFIG_CFI
To: Carlos Llamas <cmllamas@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, "open list:BPF [BTF]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

On Thu, Mar 12, 2026 at 11:38=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> This was renamed in commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG
> to CONFIG_CFI") as it is now a compiler-agnostic option. Using the wrong
> name results in the code getting compiled out. Meaning the CFI failures
> for btf_dtor_kfunc_t would still trigger.
>
> Fixes: 99fde4d06261 ("bpf, btf: Enforce destructor kfunc type with CFI")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..84665f76a3c6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -9003,7 +9003,7 @@ static int btf_check_dtor_kfuncs(struct btf *btf, c=
onst struct btf_id_dtor_kfunc
>                 if (!t || !btf_type_is_ptr(t))
>                         return -EINVAL;
>
> -               if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> +               if (IS_ENABLED(CONFIG_CFI)) {
>                         /* Ensure the destructor kfunc type matches btf_d=
tor_kfunc_t */
>                         t =3D btf_type_by_id(btf, t->type);
>                         if (!btf_type_is_void(t))

Thanks for the fix!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
