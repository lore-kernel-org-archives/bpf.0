Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265D1A0B15
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040492; cv=pass; b=MS/lT6Oy2kPuvfFYzWp3laauw1zX5oUM/GGQgvOKPCZhpJkrLipgXBW0iPhak6gg2tJ6NWTBC8VBgEuN9qa14gpoFgK1MmsMQ6Mvs+2F9xUxiYY8O70RSTiGQfsYF0V7Mum4wZ4gKlM+dRm+kb1Zy7VQJ980JMYGIETy0vcYLWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040492; c=relaxed/simple;
	bh=rcDFV/jb5AFZGAv5ko2hhsutnZLwDbzbWS7PyUYRzm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja3O5oJJykrCYwCAapCMA4GSkWLaPSq1tu3F98HMMduEenLsYCji0DrUwpXkh9K5uouns3LpE6EaMh9nRXTHWazPzVkYrThwsMiN7Pb7EP9i6yXHKWOtzPQUcabAg0dzyJDzUvbjhTHtt3otDO618fd+K+vSAy7EChex3BGe1kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHml28c1; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHml28c1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-352e2156450so206464a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040490; cv=none;
        d=google.com; s=arc-20240605;
        b=Q36IL6E5WolvqtyupkALJj0OlzMr+KiajXmZT7LydFFUNU9WhmjIhZ2DiWGqhvpo5g
         W7nWLR6NzYwSDHSXzTtnVHYiMOnWHMwe1mgWxBMj5fk04BrapCZmC+OE3idrUmW0LENa
         YF8Vm98Z3e+b7TEPe4hscg1aC6oeJizmgHyPHGqyMlpH1fDan9+1+WGFfPSOXk41qDG8
         jJ6thiBZVa+txDyMGiSWe7bicFhhGzJMROoRDWTEWziw7WggDYDbFrqqYPcLqmyLYUC9
         CQE8xXXSTD3WvfJ6ilnCOHkH8RmzO0eTXVaraFOfa5ZWf03l4ZJw7xuUZLji0YbPTwpU
         MYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        fh=caksUSc9zxa3tEh0iPDBP+gB4y7BpiLWGSvmEXb53jU=;
        b=aZ13xOZ2LhXE70Gh35Mj5S2OORMzKBeg5Qk0TbrE37UjPa1d+XYa/695bf0802xuBz
         oRVFK0qdgConG3PW2o3h6d2gWkiHPZx9KtqwJZPSz8VfQTo65jWXGEEcyyJbGugTTilA
         sSsoFc1VmCwVDyycwfsDs199h2hIp2ajBzhFT9f7a4RGdFAVmKn8eJq3AtMB4KzBXeLB
         YctkxrjUqIWsinqjbbVm14XeFPY1v7oSW6/JkDSJ4x26xec9ZLZGzADUk4TGq1cDWFbT
         vWZGVNyfLkx/Np7BirTn2bM0Zr4NM6cry2DGgQBkS9BBTTGP6AN5d5NYqspjTPXenF4p
         5lvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040490; x=1769645290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        b=nHml28c1FdgbO3YOkCGuXVzQn72JQPBQKTQqY20Nx7bcjSWdzfAu2lYzleEwkSGj27
         jSRE4lqwk+n14Gv13vC6FI5rbqempf/GMebUz0X1Am3fHg/4AXlcyuyj50Rf000fzjwc
         ZPzENOaj6u0NeAG9eEBK8HfdNyvV591x7G6Sik6nuJkvOkCHrw+CpXiQvsFbrroowXLr
         zd8Ymwa+i6ua/+hb8WRAn1ohcStC6SDysXRQCD04ln6/3i65mmT7rWVE2fjLPxzRYf1g
         MrTTFIYIcq1cRiIuodLjjZFjp+i9e9dXfxL5zGUrUuS5KTnaBAC3FPkQgphBDmsKrGZg
         YMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040490; x=1769645290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEq2XLfImnI9UEC9IsU1TUIK3ENSgE7y7e+S18vk1RM=;
        b=T5SG8oM2rb0/Fvo4WGqZXNFrIRxPdH4BuMsVelnO1XxL/YdP6qfHfLiz5eGG+wqZsI
         3VNuQ8gK+tY0N7x1ZFvHS+ERxPlN3Hs8okbijNI4VEC4JyAl2d93nAIzAzVoPYUelyAb
         PWVUi2r1Ip5RzqAflMZr6+a0IY/LnXJO5aY2PxYx1oYO2UH0v/1/7Ap4S25ATLKpWO6b
         qxj0jtR0qvK0F0bPM3RbMrtQjZXs57q0ojb759CTTmDMzDyrtH8dHocHyMp3tAd7+Xbg
         yONGp+AqED/OdA6xoUrXDMFBpVBSZlAX+8cLwIvAiFuerTe+Y9EzbA/D7l/YHrNk9+bj
         tLpA==
X-Forwarded-Encrypted: i=1; AJvYcCWPlUbzLOXoC4VcgD0szEWrZxU99DVhBGpP8ZEaX3oLTJo9dPOZSIvUCZyHDsTXgbeJng0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZS1XrcdXQYZXh7TIYbrtoswJDAWWlCM8cSKPmHtMp5q/n3Sgj
	d98Y1idzSeq+eHnLktj2CerxW2fiX6W0IAhrigziWkZ/Dm8KH0p06Pn9t/Xz78a15LMkdCpingE
	Rjo05oVlJNTMJ0B2voEFzJfjYqouhvdc=
X-Gm-Gg: AZuq6aLBRdlfGiywi8p0z8sXaFqAHqXu+UUwcBirSuZlCrBDiF7mk+jWOAnLSYSvNtS
	1JbPOIWw0Of8zUC8gxQxmvyyp1tLT2/Fx/BOmSzYR2N+r8xU9qUbryvW0sL9eQp/vIMCrlLNcC0
	I9RlBgUhcMV0PQkP042d4H+jhVuTKNo8SNdKI+whI9nfoUQLch3u8vuyPE07/AF2ty85eDm31f2
	R8wgJxw8AxqaXrL+mNh8kz9907EDC6VZeIoIaNxjBllqja4ru+twFSpMMYLngq3NOdmKzGLYGep
	3P/pP+5Q5mOWgPXeAp0=
X-Received: by 2002:a17:90b:5344:b0:34c:cb3c:f544 with SMTP id
 98e67ed59e1d1-35273179d01mr16388848a91.14.1769040490112; Wed, 21 Jan 2026
 16:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn> <20260115112246.221082-12-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-12-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:07:58 -0800
X-Gm-Features: AZwV_QhgBqz09ws2ewKfqsUbDO_vJyCn2syHCxdPXgnk8kXxYqJ1jNQI5JIHhoY
Message-ID: <CAEf4BzYbzSf_jXwFxni0viHRHhYQ=k=Ggq79S=FRNmxQGdcS1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/12] selftests/bpf: add testcases for
 fsession cookie
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Test session cookie for fsession. Multiple fsession BPF progs is attached
> to bpf_fentry_test1() and session cookie is read and write in the
> testcase.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - restructure the testcase by combine the testcases for session cookie an=
d
>   get_func_ip into one patch
> ---
>  .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/te=
sting/selftests/bpf/progs/fsession_test.c
> index f504984d42f2..4e55ca67db46 100644
> --- a/tools/testing/selftests/bpf/progs/fsession_test.c
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -108,3 +108,56 @@ int BPF_PROG(test6, int a)
>                 test6_entry_result =3D (const void *) addr =3D=3D &bpf_fe=
ntry_test1;
>         return 0;
>  }
> +
> +__u64 test7_entry_ok =3D 0;
> +__u64 test7_exit_ok =3D 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test7, int a)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               *cookie =3D 0xAAAABBBBCCCCDDDDull;
> +               test7_entry_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;

you are trying to double-check that writing into *cookie preserves the
written value, is that right? Do we need volatile read here to ensure
that compiler doesn't optimize this?

> +               return 0;
> +       }
> +
> +       test7_exit_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;
> +       return 0;
> +}
> +
> +__u64 test8_entry_ok =3D 0;
> +__u64 test8_exit_ok =3D 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test8, int a)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               *cookie =3D 0x1111222233334444ull;
> +               test8_entry_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> +               return 0;
> +       }
> +
> +       test8_exit_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> +       return 0;
> +}
> +
> +__u64 test9_entry_result =3D 0;
> +__u64 test9_exit_result =3D 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test9, int a, int ret)
> +{
> +       __u64 *cookie =3D bpf_session_cookie(ctx);
> +
> +       if (!bpf_session_is_return(ctx)) {
> +               test9_entry_result =3D a =3D=3D 1 && ret =3D=3D 0;
> +               *cookie =3D 0x123456ULL;
> +               return 0;
> +       }
> +
> +       test9_exit_result =3D a =3D=3D 1 && ret =3D=3D 2 && *cookie =3D=
=3D 0x123456ULL;
> +       return 0;
> +}
> --
> 2.52.0
>
