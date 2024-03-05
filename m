Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E0AD5E
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617074; cv=none; b=eL3Sa7CzWigxx3bqEHqWsaqcI0kCLPapKhEup8V05yKXZHHXoYbofNVsmzg4qCtHrY502XEjA1o8O9KzM94Ez+iVdpIk1xT7kLugXbksYylDL/5bURSLCHjPnGiTQCgUN6o1gBDhtjC6NWko3gL08fBdcuJBCZKseR4qx1vqd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617074; c=relaxed/simple;
	bh=XVge9CmhE9dq0MwMLZ7ssKBg8VWY0EMKoxlvu8eBDUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8NjUuQGzxuK7ZaTiM7RzuWm49g7Hg1M8moLQfrDCqZG2JmoWVJJOPdGz7ItuB8Pf5NXJ332oqzRTNMwFQrNEDSueWdxMMRg0qWu6piO7pSQOxm1il3t1eG6dX+AbdM6bmMiFnLEnQYSCbu/R7pxNgd/dyisTIJLGatuBI6iJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHABeMaS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHABeMaS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e1d327595so2175565f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709617070; x=1710221870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxVBp1zhZ4QIDfbscqJrsSoDtJf81TiRKKS7HYvzdu8=;
        b=CHABeMaSMubi43dxm41pUkU//ft944lEu/ECPag9y29Ib9U2ms5FnIxglJAr4g2jHx
         3fOaiV8Vkfg9hsabXy4m2vLpj4jTG110jr0ljp1cSNPTdlUoMKHSETSJHch6Elt8GyHN
         KtwZc0WhEI6WEeylk7KBBBoQjUlyhsdePhRL9NtmXSukDSHm3bC4Kb3Zmpb6IEPY5FEd
         e+nlUaTT97Dugpk7qjmJsDjiGaA7n8sj7htEmxJ94Ly2Z7HgnHfVEWGF6+p0XZ9vPllD
         UVfQgQqGAA97PHcPTZ/0zZqO4T9DTJCiQdYDz5g3bWKVYXbzUrcVklUxs3PZVWt0XeYA
         NVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709617070; x=1710221870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxVBp1zhZ4QIDfbscqJrsSoDtJf81TiRKKS7HYvzdu8=;
        b=NY5kDP+RkJ1ktG0JdSG8kBpjOom/j5OTFdlIc326pjQkd3Kr3lx1OX5LmBcdSxmhYv
         ++D0LXjl/yhWbCHJ+ESol71HCPRWKxx+P7mz1XkPG8IU1LvQrwLLbtY3P9dd5OgdWR64
         9muUbPJQzQIIzEQmJo0Y98cIlsXSB2ipoMp+PJ0fPtK/MnnysxvT5SsMkqcU9DJm4kAL
         rk9KXzvGOu5Q5Nl5BKzZnEs5bqfaHTDADo92cj6LrS0cq39xiq2QQM/hiv5Xb+9rO6Im
         vq5bVKrs/PvH4efAaCqlYy3w+MQEia65IAo/IzfwNAuKL2aZXe+/E19ez9GEKh3kKPFY
         r10w==
X-Gm-Message-State: AOJu0YwOpczC2bdlAP63ZuMps83dJIpT9IsxuiH6N9YSgJn/uzu+dhp8
	c1DPkhrrDnYLhDoGCiL8YUr48DFU6BJdJL/Jae9Mdr4/NGcndUK1wTTpTojTKRt2/i+CK66ipkD
	1tzocICxFY9d3dOKgeaXMjdMoJAQ=
X-Google-Smtp-Source: AGHT+IHBuNaHCUFGAwMGxNEt+OdAua8W/DgbAOBtk0jYWHM51CssFhog4684CK/89dzckl9mt+enkKSUfsOyzRiS444=
X-Received: by 2002:adf:e6cf:0:b0:33e:151a:39e1 with SMTP id
 y15-20020adfe6cf000000b0033e151a39e1mr7774861wrm.33.1709617070380; Mon, 04
 Mar 2024 21:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302165017.1627295-1-yonghong.song@linux.dev> <20240302165033.1628421-1-yonghong.song@linux.dev>
In-Reply-To: <20240302165033.1628421-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 21:37:38 -0800
Message-ID: <CAADnVQK1RTkyT-87=43WuJk+69mO8eK58AXojRvCYFHKD8V3ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Fix possible ksyms test
 failure with LTO kernel
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 8:50=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> In my locally build clang LTO kernel (enabling CONFIG_LTO and
> CONFIG_LTO_CLANG_THIN), ksyms test failed like:
>   test_ksyms:PASS:kallsyms_fopen 0 nsec
>   test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>   #118     ksyms:FAIL
>
> The reason is that 'bpf_link_fops' is renamed to
>   bpf_link_fops.llvm.8325593422554671469
> Due to cross-file inlining, the static variable 'bpf_link_fops'
> in syscall.c is used by a function in another file. To avoid
> potential duplicated names, the llvm added suffix '.llvm.<hash>'.
>
> To fix the failure, we can skip this test with LTO kernel
> if the symbol 'bpf_link_fops' is not found in kallsyms.
>
> After this patch, with the same LTO kernel:
>   #118     ksyms:SKIP
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/ksyms.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
> index e081f8bf3f17..cd81f190c5d7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -21,7 +21,11 @@ void test_ksyms(void)
>                 return;
>         }
>         if (err =3D=3D -ENOENT) {
> -               ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
> +               /* bpf_link_fops might be renamed to bpf_link_fops.llvm.<=
hash> in LTO kernel. */
> +               if (check_lto_kernel() =3D=3D 1)
> +                       test__skip();
> +               else
> +                       ASSERT_TRUE(false, "ksym_find for bpf_link_fops")=
;

I'm afraid LTO breakage is bigger than this.
pid_iter program as part of bpftool is using bpf_link_fops too.
I suspect that part of bpftool feature is broken on LTO kernel.
We need to find a solution instead of 'skip' a selftest.
