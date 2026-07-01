Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C33749E7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944686; cv=pass; b=IP8NhBjPdqL7zEXuaqaacDnaDSPU1JLyH72l9909HDy/r/GKZ6GLm1u3MP4OSdh0MUCgp9DgrsEAbjfG9Ixj4cLaUlOzsVk4fOYEhSr2fQ31FPkRAZhPKI2qPT2fMei2igcpjvXZNUDDATDQNUVYXn4Xub6enbwJ1LjfMcGBYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944686; c=relaxed/simple;
	bh=IXf8gz5n5cCHK5E3rSG8n2wYfl5DmpNceUHuKVfskoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0BtXT/EZWsqCwsOc3CLEbSF4bRj8WlAX1IUb8woQ5iSL1S/QrHw2/26xLk2oxRQx6fj3dPHXVqRamen66BEMJyGeo0+hvq+qYg51TCSJKbRRjsLME+ol6rSbejAwNypvZ/wKUNuUuG85jevE6QBAzFv8231EKUJlLMewrta0rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNgBN500; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNgBN500"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37ff798fe89so791404a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782944684; cv=none;
        d=google.com; s=arc-20260327;
        b=OF/iGt6sS77LOy9CDU1mydb5KOeWcj9QAHhAgvdaaev/FGz84MfUjyw/UN9f0BEj7b
         YhoJhbHObWA4ccPdgBY8leIm5yuihAoK20o1JNIZ1ZL3MO2n73yFzBP2p44E0TffHMXC
         phh2iKbustoLoi0z5KJUhPdNC3WEuJ4Cn+G4rFuqoX8AZwOZVqdBNQPHk/Xp6qJDgbkJ
         NnvHMq2SkjP5Dq2+iYDHpri1Ar6/JPO+Nc+Q3pKYVCoxfeACRPbGuAel52Wsa1lHgVBI
         gf8JC5dbVp3NT5SSHumhV9T1Xk7b2rNT7Ysqxj8v9hksc0uHw4QaR7c6UoaNQUJWmBwR
         1DGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1yFeJucqFnCUSeSRxPYIH9H5v+xydKmvVf67iGU/as=;
        fh=6hmPMIKZIOQU+lZnLCzA/xlUTqjAYydvNmOrLC4vDGs=;
        b=jMRyZ8QChjZBQPHXktyxj91jUYslc+UgnADdu7BdSJLlpSx64RJvBZbI7ySHiPMOOn
         E298cY9l9OPZgGBEbdqxatswODq2wZpraAvOW9XMlhq+Z9P9cPiAYXrZyAbn2lJlOEP6
         VXBbYyK4j4YmFk7J3qHUZxG7m4gt0SihgUBZfUKCuRRD7HIGhlJjVUoJHJ5NwhuGfMfZ
         bxQytEzxvVmXXTa4uPof42OyKsKv99OTebUP8sxgZ3doweZ27PoRdt8hOX8zIsDsupvk
         AxPJ4ezEdulDqlsnArrLYYDieyy0pBrvCtnJpt7e7ft0ZEA00qr7S8WxWPhItbgCwDPz
         E4RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782944684; x=1783549484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1yFeJucqFnCUSeSRxPYIH9H5v+xydKmvVf67iGU/as=;
        b=QNgBN500YbfhQ7K+nw7+F5DoNAmQ/rh66shGavDhRfQRnReuD8uVVRC5JdhfVWjE41
         0qMEMxv73cQA0dpJUNBeHXdEw5litE+wfYluv+LfXXsGFtJp6Cn4iG6k7d8PNjvnSbP4
         CWdJtEcPz/lXRRdsyQC9Aown4dgJpDCCkaRqdCzBgT2XR3KCK+Lo4btvTYuNAlaRpC6p
         akKLqfsx9jDNgFAFqwhVbzskwdpUR3fWeGry7Os+FESsZDYYF9N23ToUeWoEKeXEkUMQ
         QuUaVYKaTbAnJymXR2NKPwZILSO6b9cn2wZKB6YonXbfqcUlMkxKk4jIM2UyUwoVAmN6
         sGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944684; x=1783549484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1yFeJucqFnCUSeSRxPYIH9H5v+xydKmvVf67iGU/as=;
        b=NL5//6MxOJnngpkJ3t6HRiorXut5WUoyTmzzFZtsXjlKkufCe4QMxX+H+rs2HS4VhF
         S5KL9fwnzGruWsT6dbgbIdxTRoVxs9JevOR5zsrVED6rtN4+zNT4z4u8+U77sB5LGz09
         lxqhkfA2uBbQ5aKHWqnBr31pFcCPQipxpjN7XuderDWlvQVFYw9dHc3qCsmHyHuwjSg3
         p/IKfteEb6nwmkzD9NPQ76V6giDkS1fMa8axQzR19cQfkk/6FWr7lo98tOmMvRkEzlYR
         jQiR6vS+h9sBbZPbGi/EysbndR87CpzEHc+zpmwEsCHD+ATJnF5cKjDk2Kh1SWHw4wNA
         HJPw==
X-Forwarded-Encrypted: i=1; AHgh+RqZPDRmhiE6e9OID5xQhXG2nXFYwau2xXZd36mFqQIzn0yiwaXYEvN1l7M+T4pldP30z1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uH7aQ6GsoiYL7YwfsjYddK+/KM2alOpkNRbXvV/TdIKreyq5
	EetxFdq6zVgrJTBVzqZDDxBMqZDcanFFYrruOXXYH/JZrW15c+5vVRAsP6HT+yzOhS1X18PY3wO
	v2mQl919d74i0cc/+FdmGHunJaLuGiWikRwOo
X-Gm-Gg: AfdE7cmFFUY5K5L2Bxxx9jaTnirU1Fd1ZSrPYeNRO9I5bULneOE0naVsu8WkjlwMJUF
	nS/AAXYC5YnVieePuefc4g8MbXArbo8spyd4HObOfoUsv+aWXkpMeXIsUuH5s1x7aWpWAbHQlc+
	OZ4Y+nlgRWlhtJAO5MYYW9zas0j7YABx1CgH/Eb0K7y/6SVIdl0oVxUcmmjU87hLgwjWhwuSgRz
	afCZbU+8twki3E4E5FzK+hGIDy++OQsvbFRoSl+rek/bPC4bsxoKdJbt8kwxT3+tCss9EHbLWJt
	yLkc/uX2Wr86QqFIrbavH6C1XR0G1rP1zr+ACTzn1jSJfQ2VYnCsnA==
X-Received: by 2002:a17:90b:4f4b:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-380aa184432mr3263591a91.18.1782944683513; Wed, 01 Jul 2026
 15:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626172026.7327-1-jp.kobryn@linux.dev>
In-Reply-To: <20260626172026.7327-1-jp.kobryn@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 15:24:31 -0700
X-Gm-Features: AVVi8CdBHnAQ-dVGbD-wbbUQLjWhZ2YL-KT_zOSpJ4xXWUxIe8qhM2sm7BSyxYk
Message-ID: <CAEf4Bzb-3GA2OGTOBg-dgUNPJfH8-PDi=3gFZbyZLMmP9DFvLQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/bpf: make it clear that kfuncs should be non-static
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: ast@kernel.org, roman.gushchin@linux.dev, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 10:21=E2=80=AFAM JP Kobryn <jp.kobryn@linux.dev> wr=
ote:
>
> The kfunc documentation mentions how the macro __bpf_kfunc prevents
> inlining for static functions. This makes it sound like static kfuncs are
> acceptable. Although static kfuncs may happen to work, it is by chance th=
at
> the compiler chose not to rename these functions and BTF resolution still
> succeeds.
>
> Make it clear in the documentation why kfuncs should not be declared
> static. First, remove wording that makes it sound like static is ok. Then
> point out the external naming needed for BTF resolution. Finally point ou=
t
> that sparse may warn on unreferenced kfuncs and that this warning can be
> ignored.
>
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> ---
>  Documentation/bpf/kfuncs.rst | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 4c814ff6061e..1dbaff8d4805 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -276,19 +276,26 @@ This set encodes the BTF ID of each kfunc listed ab=
ove, and encodes the flags
>  along with it. Ofcourse, it is also allowed to specify no flags.
>
>  kfunc definitions should also always be annotated with the ``__bpf_kfunc=
``
> -macro. This prevents issues such as the compiler inlining the kfunc if i=
t's a
> -static kernel function, or the function being elided in an LTO build as =
it's
> -not used in the rest of the kernel. Developers should not manually add
> -annotations to their kfunc to prevent these issues. If an annotation is
> -required to prevent such an issue with your kfunc, it is a bug and shoul=
d be
> -added to the definition of the macro so that other kfuncs are similarly
> -protected. An example is given below::
> +macro. This prevents issues such as the compiler inlining the kfunc, or =
the
> +function being elided in an LTO build as it's not used in the rest of th=
e
> +kernel. Developers should not manually add annotations to their kfunc to=
 prevent
> +these issues. If an annotation is required to prevent such an issue with=
 your
> +kfunc, it is a bug and should be added to the definition of the macro so=
 that
> +other kfuncs are similarly protected. An example is given below::
>
>          __bpf_kfunc struct task_struct *bpf_get_task_pid(s32 pid)
>          {
>          ...
>          }
>
> +Note that kfuncs must not be declared ``static``. A kfunc can be called =
from a

it seems like we do have static kfuncs and they work fine... And
__noclone in __bpf_kfunc is meant to prevent compiler doing
.constprop/.isra and other transformations.

> +BPF program ``*.c`` file outside the compilation unit that defines it, s=
o its
> +externally visible name must remain available for BTF ID lookup. ``stati=
c``
> +linkage allows the compiler to rename the function, which can break this
> +BTF-based kfunc resolution. Further note that sparse may warn that an ot=
herwise
> +unreferenced kfunc should be static. Such warnings should be ignored for=
 kfunc
> +definitions.
> +
>  2.5.1 KF_ACQUIRE flag
>  ---------------------
>
> --
> 2.54.0
>
