Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0E3815CF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256840; cv=pass; b=gSnzmn+OSUNU5LXAWpOM8uFSTu8kpxY0RWp8lOq0kKRB+jgrQjL1C6+hx7IvDCz53LYDL83wrHpk8GlwhF/NTBmEA0QGWUhBVcTfBFWB/nLgaCVUWMdhu7UHQ//jUHbh5GJmBMHPyhxOPWnDk2uve/XNujZfOvTEJXvXmZIdwfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256840; c=relaxed/simple;
	bh=tYmPxrlSsoqLeU9/Xo4jj8ah2IDyD8e0HYbLQlJ9Bug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0Fz0bDjppSruSO8JaubPaaHaIewjmPUoVK9wrh6sjMKB7jFtH7O5VZ9ibw5720j9nnEmjkIFx9p6PFIsqQZLX/RYBuaYIEPHe69C0qZKSolVpUPElPo/cq083sgoElQN2dIpruqUqBupPDKC17DuBnBmnJF2VSSn5Q4ivnrgqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfU6OJh5; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfU6OJh5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485ef63b68so38495b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256838; cv=none;
        d=google.com; s=arc-20260327;
        b=eaGPuRkZ0iY4qdvZtMYGRtMPQWOq4DxH643L6zfqpYcBYlQ/4UZ+N9sCduo0rRasRW
         8tVxMpGEtNOI2f/fSwCUhDJJxzAGkGTr0aOLiQAgeWIlEU95+qL3r5e7TlKfG0dN0a9w
         UPosSJ0sTGQ4ifEci+spbkSjK/E0IqOwEztFISDY+XsaWO0qwtVE9QiaAclZmQKLLPqg
         /RtlkhT5oKpskknSIrVkDhArPVnLidG9QNa6/gE66vGKLCxGfjE5evHs+SpHM9t2tkfE
         ULvG3tCWD/1c9uW4yi4P8hee28iUzipeo1AZogZ6EsOsJZ+6Nn60e9U+hlOPdVHprA7i
         byWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FoWB43gNjogI+uaKkawZlpVCdJf377KzQWvN48mgqI=;
        fh=2QOkEqGqpYMpD/8RZpNAalzeoOzBjFm+d9iBAJjgaJ4=;
        b=Fuu8NY7QiiF2AoUSy4REsjcUPutd8ji6eQt5fQaQOjPwsQC1gPRT3OVF+RTPq/NtcS
         n/io6okOu0zPypDontecLFW3S6HljpfEL+74l3HvteFTA/r0vHMQjTiA29C+PYu0hRE4
         DomJPdaFiRq+J6gfE/7c4oDj85hhm5GTTgIPsivv5p4I1HQzObKv1y2J/MiP5DhvGckE
         p4rNDQqNPGZKQKvssMg/cbydhegUvlawAEXxKBm7Q4XHSk+FngJCGCozXNVInLqqQyJq
         QY/IE9wI72LsuaigxD0FSSdUbWvI0Lsq4bwBcXzQQMhcCRnBdbpZioyTPc2OdbTWO1w5
         3BOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256838; x=1785861638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FoWB43gNjogI+uaKkawZlpVCdJf377KzQWvN48mgqI=;
        b=QfU6OJh5rnv5wIpEpkZNSONjXhi3sglR7aek2feWMBDfOiFnXZad1g0GoYNaLiNvET
         ZVY98Z0KlwMmRI1gmZVWjRa1U716OfWujbG48bTUv5WeD8oiYNTVVov5a8S44jJ9O5rc
         +rmo1VLqLw+CCtUnyLcO3HInVU1dHd0OGxY8OMqyhIfQk/Qy74TsU7OG2Le5fNlz7ry1
         uxv/O7hGRBFktiSL4f2U/GPz9dTQCNA5UBTfk/PkHZ1s5/ImdE/s3hyzh+/VTGcqUS7t
         sEV/ozWhhfeYtLuJarxjsOWUH6VPtaFNeGY92DNQGZTAK3PYW6lBxnEv68suJ8PDM+5R
         y/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256838; x=1785861638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FoWB43gNjogI+uaKkawZlpVCdJf377KzQWvN48mgqI=;
        b=Sbj4A27Sfr2eme6wvB2UkP/mD1abO5uKfq95nB41VIYVq6NNjGdyugY2KavvXGl9P4
         iyKwuBuM70MJyZen2XXyPkpwAqxnZQ4zT3hVZJBhG1Vbt8MYSBIIQIoa65W1qavlNR4B
         ++c/UnGid/qsjGUSg5AJBePptz2l8w1i5XEYzuNjtTyu0jWdchXwDX0x8xbjkG79d9b8
         efjxIGzfQ0+SMBGN9sPThEFjj9H0sFAZVYjGIgJb68gz0RKVA2OQlpcz/65L32yggq99
         Fj+8sswK6P1xcXt8y5ornnGJQl/ZUVKuP3DiOLLKx8KcuF+VE7VfNft0aupHv0x5xONy
         2Xfw==
X-Forwarded-Encrypted: i=1; AHgh+Rpy8qrWEurzbjzclqBKM/Va5eWfl4ULnbfVgRYP8OKAVj1k+U4PPRpcwKbrfvw/y1s/s/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpPPrW8Cc5qIzEVHywZ48OL9KdaSApc4jYeW++1AEoCQ9AEZr
	Hz7VdHWA8p654RetCB6uGJ9tKH37HETJgeWNBpVkIAVwHSeFpclDRVpTikttMiIypu+CPNeexaI
	ou0YRwaOF1fyXX/P7fQE4IRAeTNGND+E=
X-Gm-Gg: AR+sD111N7jFArMkFwGxHXHlZZMFEt6NTwZz2Jze8k9ObXvxJsR697z4x93rjVDdzHp
	bMneRb1/UpWxlMvdvC4bzFvA3SJSg+RKX7O7PI7nWQh5xiz0bYMImPZEygrTMRqGm0qJw1J3G6i
	rtczD8PRPQ78xj57TgrHRRBMphsQ/d7qbOibzjxJQw08A6Kjp5Ujrz4+jFng3cy0dDuj8BYljUr
	73JP9o5gMeE3x6xah9ChsO1WWRoKOj8iXnsRJfAqxHYIa/btbZImxN0kCwrH+L9E99nPDSAtdtp
	FZlCk0OeKH9gyVzVuUDvx4f2D5/vbeVWzN3LAYz/FBgKztL2kwuVDxVXjzs=
X-Received: by 2002:a05:6a00:10c3:b0:848:30fe:da34 with SMTP id
 d2e1a72fcca58-84e93334ff3mr3427763b3a.45.1785256838398; Tue, 28 Jul 2026
 09:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728071516.2706695-1-martin@kaiser.cx>
In-Reply-To: <20260728071516.2706695-1-martin@kaiser.cx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 09:40:25 -0700
X-Gm-Features: AUfX_mwBU2fSYUzQlxeVGMAPE0rd0fcel8omR5_pl2WtYpo40aONLL0k2wv_fHo
Message-ID: <CAEf4Bzb-z_YDE7DKsU4CvGe-i4+NnEhDet57iimid1iW9p3j8A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: don't preserve ownership during install
To: Martin Kaiser <martin@kaiser.cx>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Florian Schmaus <flo@geekplace.eu>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:15=E2=80=AFAM Martin Kaiser <martin@kaiser.cx> w=
rote:
>
> When a libbpf build is integrated into build systems like Yocto, the

Kernel tree libbpf is not meant to be packaged and used directly,
please use libbpf mirror version at [0]. And Github mirror has its own
Makefile, so this fix won't affect that one.


  [0] https://github.com/libbpf/libbpf

> source tree might be owned by a non-root developer user.
>
> The install_lib target in libbpf's Makefile uses cp -p to copy libraries
> and preserve ownership. This leaks the UID of the source tree owner into
> the root filesystem where the libraries are installed.
>
> Update the cp command to preserve only mode and timestamps. The copied
> files will then be owned by the installing user.
>
> Suggested-by: Florian Schmaus <flo@geekplace.eu>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  tools/lib/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index eca584fb061e..0a344ca4e108 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -231,7 +231,7 @@ endef
>  install_lib: all_cmd
>         $(call QUIET_INSTALL, $(LIB_TARGET)) \
>                 $(call do_install_mkdir,$(libdir_SQ)); \
> -               cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
> +               cp -fR --preserve=3Dmode,timestamps $(LIB_FILE) $(DESTDIR=
)$(libdir_SQ)
>
>  SRC_HDRS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h      =
      \
>             bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h     =
    \
> --
> 2.43.7
>
