Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DE34751B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809446; cv=none; b=BatMF+nkPnWgrxVbGY0Oalxkc2mqzrcPA3Y+9pNDrGRGP3t2+2fEXOPy5iJftiHth/wHXKC4YLdwzv2vAPjGi5Kp8LzRjG85ZmMYipA3j7HpirCk0JrM6I9LxpOP+UgKiwbeRqDonW5GlrJ+5ek3QwVWIfL7KFfAe+XFYvDPUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809446; c=relaxed/simple;
	bh=DkKujoLCZbQk5VCctRpqSeNz8OfCQ0Z43QhKHcpPxwI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rQ/MfuS7hNdFWpfQMYi6/Z/FsPrPgslLtQUlfYfR582Ao4rIq3BApU+l1pLHONbV9y7D2I+YPfq2pI88887dSVJWc/gV5QNAG6XSkJFPUAsUfEcEG2/v52+tZL9yCtNV4oFx/ksKjk+1ivKcPHWBkcuRGYxc2OHKpNuWpkueU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chAS+EPj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chAS+EPj"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4232323a7daso2236153fac.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809444; x=1777414244; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HGO8rF/lnkhGeanpJK3CZvTuD85OSwlcS4r1bud3os=;
        b=chAS+EPjTquxGL7kWwj98ps6q898kl/ZV+fCxz6zWWvFni6tSkjmoeqFEiJInPfIEK
         oM1T1BY8fsL/DA7LwOKH0/E6uOpmC0sgpC1UtIp4+AodiT7fCFvLTkej9tZxKshVpGqH
         g+7tvT1ZZAuro9IW5F5QMEX7WXT/g8vOLZCGf7iBTsHhB3C4lrMLXg+TsGqtUehCGaIq
         LAHXji7b/aemvDie3guH5uvHfKzGL0ARAp5bOOXvUNPkMXxuSY17EjpvLq8nTia5yEnI
         8KC3GyDjj25wKu+qYKGOsIo4HErQntPDdmL4iJRna+K0zY2xx2LRoVMtsG/mBI4LFI7+
         XS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809444; x=1777414244;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HGO8rF/lnkhGeanpJK3CZvTuD85OSwlcS4r1bud3os=;
        b=lURZTeehBACWMojbH8Es/PqsMiyi8UKxp3MC+XqDAqJJpoTrDv8JTlwho/xqO2a0pH
         3JlAAwioTQ6J/YotNuWIHS/7T1En+abZYHvKAiXu6dbf0VAM5rC7lwAoUPgB8Gl08h3h
         nEEL2qz8PV26awRRTxPQE2ZhWyRoN3crtij5O4Z1J3zrt3SNbuVvYPwTnoWGfurOcd6v
         DeHWIoimW9wLVGk0wN3d/FHax32NnYTI1wDd463EeJe0uYjps7vQCFpQG+i1JrvNog6B
         KvxEHdktzjim+byT3d1rnnrTKFbmw+2/XAdNzVdCHGRz7Oc+WNpnsCh7tBNofJ2q+xZ+
         UNYw==
X-Forwarded-Encrypted: i=1; AFNElJ/g3oTsIg0LqviQUZdiCPvn/fvRLsdD2rPwRfp3gcEiN5QxMxEfhxvmXbSZQmS1pm++RsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVY/2ayXTFfWDXaUWiaqpshHpnkEuO9iyS7QooZSQVfd9eMnH
	f+vkb8GiadAbp4GWh0CmBajWd413qFuKWhJsAAfpgNWVx9NPf1p1ENHip8ufUg==
X-Gm-Gg: AeBDievEva9+WCNT94Dmvl0YA8odMH3ETQV5pjdF/dwRXZ4dJsKC9EMTkzQ6sp6tzJX
	AtCmee9aO8mdZsoosSrLMeJivG3+x8wqc+HVxs1gpwOn3jUaAnVxc/KTVk9bm4QWgAoh0FIyNVH
	ODdyJbsGcdcF7GUv8Hefh7gttqzx8fH7ZIuYipBJ7Nk89I8nYx+CgHGK+b8uAU2lYduj2AtvkG8
	h6DMOnfjLCwWCR+Mus5vujcdwLdBNOIglmmC55yT2rt5kOugsIt7fqn2fAdM8sSNKQleCxDNOXP
	wePxebSm1+dtdWiCurls3WO9S68dzK6lITCszThC9u2JL/l4DubCpygTDOuQSWeiZz5oStz9KPQ
	qi/lOt6lQUmkHGUPPN7FyEetMz67yO31KJyYgVbZVZfg480InUOiJ1Yzs/QCTGPQt1tyaiajVw3
	EIJocnokSGnsD0QjMzdoaiTmRmP7WRWuI8IMD9+duMnCLfUgF3jEq6aENiMPVuLjt+DndtfXRsr
	Y2VTOpLK71jsvxHXXQhas9NaYr3
X-Received: by 2002:a05:6820:162a:b0:67d:2cb:207a with SMTP id 006d021491bc7-69462f45596mr10882482eaf.55.1776809444403;
        Tue, 21 Apr 2026 15:10:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac54ec5sm12457236fac.13.2026.04.21.15.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 15:10:43 -0700
Message-Id: <DHZ6DPP9Q67P.17W3L0YIPN8Z4@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 8/9] bpf: Introduce bpf register BPF_REG_PARAMS
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172007.3512280-1-yonghong.song@linux.dev>
In-Reply-To: <20260421172007.3512280-1-yonghong.song@linux.dev>

On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
> =20
>  /* Kernel hidden auxiliary/helper register. */
> -#define BPF_REG_AX		MAX_BPF_REG
> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
> +#define BPF_REG_PARAMS		MAX_BPF_REG
> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)

...

> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -630,13 +630,13 @@ __xlated("...")
>  __xlated("4: r0 =3D &(void __percpu *)(r0)")
>  __xlated("...")
>  /* may_goto expansion starts */
> -__xlated("6: r11 =3D *(u64 *)(r10 -24)")
> -__xlated("7: if r11 =3D=3D 0x0 goto pc+6")
> -__xlated("8: r11 -=3D 1")
> -__xlated("9: if r11 !=3D 0x0 goto pc+2")
> -__xlated("10: r11 =3D -24")
> +__xlated("6: r12 =3D *(u64 *)(r10 -24)")
> +__xlated("7: if r12 =3D=3D 0x0 goto pc+6")
> +__xlated("8: r12 -=3D 1")
> +__xlated("9: if r12 !=3D 0x0 goto pc+2")
> +__xlated("10: r12 =3D -24")

maybe shift it to r15 right away, so we don't need to touch this code
if/when true r12 is introduced?
