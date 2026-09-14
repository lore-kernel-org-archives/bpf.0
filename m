Received: from mail-oo2-f16.google.com (mail-oo2-f16.google.com [74.125.231.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EE38645E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410342; cv=pass; b=eRwluY3CFvMLUC4zUwC/CL9Z3wj28CudOuXgyGHEqGkbfbj8jkjFErsqOCEKETTrzliAuEF7Q51zwMKouegSPW5zauH7aOdF5ncJmwSOlX8fWcCLPYD+lM8YuK3+dbDtinAUbmDqJ0+aQYHBr5XnRFk36oQMppHN4bvfuz+LLYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410342; c=relaxed/simple;
	bh=M05cKKzyMe6gEci7W/N5xN6B2lG87e4rRXDr2YH4Gn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syS0HJ2V4Gq8xTt7dO9hrXs3hFJ5UJh01eJQh62OC6WXkaQq+1nhMNRaQtFcT3glVcasmMg+E0CRWl098iK8CJwVdsOsc+yiZUJjanepUhPsBCSIG+Dm608VtZLeU0fO9Zr/pm9GbtiRpA1EiiT3Lf+YoLuxqnKyilNfQf+nhx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhRwOt5L; arc=pass smtp.client-ip=74.125.231.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhRwOt5L"
Received: by mail-oo2-f16.google.com with SMTP id 46e09a7af769-805bf8c2661so1606507a34.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789410340; cv=none;
        d=google.com; s=arc-20260327;
        b=sSw0xNtQg3jVLI4+YIrg26itspXqdXRHYxs3yzh3V3ghlxmBc5ISEphZYblKheHNDc
         YV+o7AvYZWtXDjGff4S2VkNs5nxbDSbythaosrxLAPhP9SZkpJJc0Su5slVk3PjsW+yW
         sBquuQ1Ei+b+n8h+IkNbnfVLKveLuKkTgDuFnJTbBJhPUD791dX2V/7TyOBM2FlxdEbe
         XV3e+rJEN5Lv6csbeN1h+hac4AW4oDF+Kxxq8onpgqdtIrOR/KbBgThN3B5v7XrfkC1o
         sLVmCtjRPMRCIXxdtuS6sJsSOtOYJo525hl6OcDApwFscpn5v0ODT7McUsFQc22A4oyN
         Ipqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U651fx6dEYbgcs9HadXqwVgaBN2uUjOTpkPkaj2tUlo=;
        fh=UyILnoCeHYJ+Auaz3rzrPjPA6v7KARKY2uz4udGGDFk=;
        b=stA+iF8l7DA+1Q5lo4MgyuPgbAi/zQ1+RuCb2ou2ZITBvAILIfbYUyqsGYTS44CyQ3
         IgaGfuYIgb21onQTj6bZZ9erqd7+FONvWVuDU/B9j4KW1BMQNGWw/v1LzfozT18v9yGu
         SbFCFxv/+H+qccKtj0/F+rGV3Nk8suhbzjYEfil0eDlMAFRswQUnJRlBa/KJTNZ1bPhX
         sN4d8cLIGC1MrcMjuQn0po/+Dt8BWZHb22lb9sQXrQ6sxn3DqnFv/wXjrHcmgOrlP7Kn
         bTqygiWV1ZRqSYLD9uVF5b6MM7SsGjlDwMmCaFzGdWNvnBldsn3QaF3nZrrQCJ+Z1UaS
         GIPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789410340; x=1790015140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U651fx6dEYbgcs9HadXqwVgaBN2uUjOTpkPkaj2tUlo=;
        b=lhRwOt5LcPQwCa23RxJjpcmFP5PNada84hRS1iRL67lMg7oGzS9VrD8XU+P5YhNfpN
         kVKGwa6dNvlSj4PxxZfhzG9IunzlkJ31g1C8og2Jxiw1o/dsKzZKe8tLqxIURssaZi0b
         uWl9mu6gAInzTgOJ80IUgCqsuY1TVBeBJMVTKmWnmfVPgPLYg8pFqU77nWy1jvwRPvs6
         EfN+bh/wZlT5W3C30hOHBIB1M/8whF5vf2V24xsVSgQgjkC3xPC1Nve1d+qn7J/C1eiO
         LIDt9qg8AUeHD7ojQ34+3TJK1W8gn/wHDafrq8RY3bjqpnro1DHFJ/nm6ENioRA1DaZk
         t9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789410340; x=1790015140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U651fx6dEYbgcs9HadXqwVgaBN2uUjOTpkPkaj2tUlo=;
        b=DaI7bYrZIDfPUWJ3kbA17rxY8SseK+OWNV0W0FMvIZP088S8a45Gs8HjHvvWpOyjB9
         W69RnqUfl++O+Y1QAQVa2mGZSMjuULdYnDRlZuEeFsZ3ldL39VsIkgFTWr591Ytspht8
         QeJkbVUIMcAyN85EOu4N93EYDF0k8xfSVvHHtZmI8FOtTsD9Am9U3YlLpIfed2zHbzKq
         eKhv/XtUkB926OPXstq7rN118jC9bhB2Gdk0QNGYcMHYIq8ILpY/WWkxD1HEdma6VCku
         PbHGcIEYKzILH4OaHVeAZCZPDhcpH5yDoUVmgEFBGe2L85t8Oulm9nQT9nCDjoQZtPkp
         fbng==
X-Forwarded-Encrypted: i=1; AKwUvBzBz63yNhNnlBNghG0zM+YQJtr1htJlRq6Q/qjj6CtDLPwyjFOFgK7STNayeo4BsQujiHM=@vger.kernel.org
X-Gm-Message-State: AFuF++l2JqiSRy9HGLbREaHrvRyIW7oQq/tJ/qwVQIuosvzUVvCueZqo
	41sTaL5oyqlywjnuBXoh1Cehx8vvNZXLofHJyNTEIIyn1YaWMEPw3hHkNLn7WBPyn+T+WjLg0tc
	3RKGLoAxcwhfEc3eczDXTRvSorqpYKTs=
X-Gm-Gg: AYBFou3MdJC18UsPpZE+2jD6uDn+28xF1WFnT6Zp0OtUf6wDLtnXkEfsu7On1r+BazA
	kSa7RzcgY1p6pSyCXxK+L1V81tlmdULuw5zjXwnpWll2pAdAgJu96yXXHj1uA1JbtpXd1lUuDJc
	aJ2KvBlloIlw47RRHA744qSrKW2/ZnHmUD1DYTYVsqYzr1OIHwcNw3WpQmlA+R+iGMKelcr8jgz
	hqCiA1xX0Qf1x39Vf3S8MnFMKcgTvaHA/xSuhQ5NDM/ayKVdGA/ju2cT0X+CGbSwuCsofrfqmrs
	JYnLdUtjKKCRkgPUx8kMgTeMZMPe0EEq5bSWjl3lMZ/9ZXLbIByuMNkNiQ==
X-Received: by 2002:a05:6820:2213:b0:6b7:46fa:16aa with SMTP id
 006d021491bc7-6c54292a26fmr2212816eaf.63.1789410340130; Mon, 14 Sep 2026
 11:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-libbpf-log-buf-fix-v1-1-f592caffcc71@gmail.com> <05221557-59b5-4d93-ac55-d9e372d0862b@gmail.com>
In-Reply-To: <05221557-59b5-4d93-ac55-d9e372d0862b@gmail.com>
From: =?UTF-8?B?THXDrXMgVmllaXJh?= <luisflavieira@gmail.com>
Date: Mon, 14 Sep 2026 15:25:27 -0300
X-Gm-Features: AcwNN1WpiCNo8BkMZsFY2qQC5nwNASs0EdBNHmV87IALQDdz9LKh29qKxXvtpoQ
Message-ID: <CAFTBxmixD6bHH0Rn+Tr432tbgfzbKcrMd98s7_NTTF-Mibqh2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix program log buffer size validation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:22=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
> The change looks correct, few questions:
>  * Do we really need a unit test for this? We are not testing those error
> conditions now.

Agreed. I'll drop the selftest in v2.

>  * While here should we rewrite the first check as (!!log_buf !=3D !!log_=
size), to
> cover the case when log_size =3D=3D 0 but log_buf is nonnull (we check it=
 later in
> bpf_prog_load()) (AI)

Makes sense. I'll update the setter to validate the buffer/size pair
consistently with bpf_prog_load().

>  * Fixes tag is probably not needed, because this is libbpf, target bpf-n=
ext.

Agreed. I'll retarget v2 to bpf-next and drop the Fixes tag.

Thanks for the review.
