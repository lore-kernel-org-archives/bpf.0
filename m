Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB2352021
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942461; cv=pass; b=k/lDHjDyUeoVv5iY5/s/1xaXc1cq6iUWLMsUfox1M5NFBVVWuPS8+O0OpVoteg3NjxnsFH2wedzi1Wu0ewUiDXoI+W6fTihiniToGxQmNXq/9s5Lhw4ZXnXdBPPqMwAzJumfMF0KZt+mEyMCcrwvANnYY6nI1EzAde7juh8c40I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942461; c=relaxed/simple;
	bh=cdobpiwLWv7oVVX/pldaFU009Uk0NSg+Z2E2eK4qo7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=La0ixdj79ZbSj1zhq8gsnbaMA2KtsCz7PXtLbBSmDYkCj4n4imarCp1wMC3K1GxIPfN97ThpTV9t3WdvHIdmpesHCSaIvXeAa5EFOUWXq59t3z8Zymde6a1Ct3N04sBNPOrFt94AJlUaefrjvbjJq6w9xYjMOsx08GmEcoMfijI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUPy1lFt; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUPy1lFt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso31643885ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780942458; cv=none;
        d=google.com; s=arc-20240605;
        b=cAbp4CwoUEm/RslcAVxWtXHFcQvbuwYOfsHb49RKyBTs/AqWJ6/UjE1EqJq3OpMVl3
         0vnk7q7Wd2apCvidCZ3vaYqSnTIRj8FkhRF76Jb+ZmrBAPO3T/Azrk7MKGO/TmZ0kFgD
         63lzWT7tNUPpJwmNIXCHuCao9gmwQ0fOBbGnuv0oJBgwHZ8tEm/BHU5KvhxET8Un/bIC
         dVV1r8A0kFXI+Ay9pyWv9INEfJIUdZbX1/en3O3qxd5LNqRnqDlT9t68PwCKkV+r1gVU
         7pFZQ8sXbtzdPlZCawVrtWdENgbyqDs7v7/IiJ/vEaj04EPzxRXifcwPSz+s/k4DUqEv
         p69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLVgW0YpQ2LvPnx562WBAcfO+Acupv1Ug4Sxu3bRE0k=;
        fh=K9q+kWibaSNW/zvOXDSSIYsSM0i7+Yq8uBM1+SvFFHM=;
        b=jInVrFjDSbzu9nUB5BoKxJzWDirGCZHxmcCyIVhWpWX3GzoI73dMwAzcBc/lwl+UhI
         vhYB8BwUkTgAuEYKdOjMl+SS3pIN6ThrGMBzeXcZc7PTT4Ik4/RDc6GBxlFtxkToKuPh
         6W+XHKrhF1TqbD5qm3ccpa6nOhOyzc2h3VY6B+s6WKjzAlSGW+ISDIa02HBoQWAz+LUJ
         z1AQfV0xQIBnJFAeH3Agpe32miN9LREMy+VI5e3zVvKDxEKIX87h11OGFUtUfU0+Dgqj
         vNtVE0V2eMdAdR7/+dRQovTaPdK5hU+w61fEx4N2FCFJPTla5penzhu3dyIflaIwdAsV
         DG/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780942458; x=1781547258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLVgW0YpQ2LvPnx562WBAcfO+Acupv1Ug4Sxu3bRE0k=;
        b=CUPy1lFt2e62Q3gx3DrcJT8CL7ht1lt5Cqb/ppN/yOepqEoKTejdWxMU4SH/r2TWkF
         7Ju6SAvv0unNQTWDoio4oeQ9tdyUhmJaqf+iAcJ7oCNKy6URZB0Ib9V1x8rJcTwv8uf7
         MmReM+YFzR28VzN43fJSSCMSJn2TpPbL4vK74ZioYRuKO16N06H8aU2oRrobm7Pco1eh
         4e90ZiGmna7jobG8/e3f0zO7E1y3S9QSRKVnXw9ZkF0CExzmbXQ8Q6Fhp3w2MrKBi3Dj
         /+Z1KoUjTas+eqq13ylQwJ1DPZM5hmeZpUQ45EHfc2SR9fMNh1CDwVNJo8K2Onfb/8cN
         6Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942458; x=1781547258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLVgW0YpQ2LvPnx562WBAcfO+Acupv1Ug4Sxu3bRE0k=;
        b=mkW6Xe6+AMk+Wu8YNZFlh5TBsvwcJrxdn9PpObgh3g5NbfhjhWECj6rijLMwVwg/v2
         WaAeKo0aydeUmVo5vKHL5gJ3z7XER9NL71frgYR7BfwYVaF/p06iIHlIDEorumCNI4Sh
         MyZmF+gFcSbE/CYb9u2nmquvDzIX56AMeXDRujkn27o/W1qdpTaicrKaWJKBR8S6HEME
         X0kPfWHmrbwWROguGdCBpoCuFZCVJtja38yxHzEiR0meIRW8Y2YD6PDtyj6ycEMS/Xkm
         HHB5yUjaf3kKjibw/S96+NqU7/jqhByaypgXt6jRXPyzoZ6xwLXH1Z6R6CWBeVyuxYKt
         8mug==
X-Forwarded-Encrypted: i=1; AFNElJ/bYEebSfLK3HtJEZmyJDqiyJVY0RaIoRH2uUVVoGTAV4XMSS9zrDBvAKR7jURkyLCnYxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLlEGBep1vn57rLl5rf75EPwJKVOhqO6vRa+YiXtgZLYETanK
	nmcU0tt69wO69wJemAiacG8deG1KQ+NgmLt3BfHlzUgkXqM1uGH/JeSIS6E5bBw1SMFBqK6l+8G
	kQsNw+SPVh2mMr6rU15chLx+9Wu7tjy0=
X-Gm-Gg: Acq92OETM/FayIXRXOji+n1+mRT7jdLo5b73snf+lQxyh+t4RwvGBeQSCt62Gm/Yb/3
	H7RxB9Lwl+cXqY06PCN3oVKDRrh2kSbdZzQW3Jo9GK8fEu8sNneLHjLb/TPjaObCDgmsK+67S+R
	NyZrLMd3JPw7wxj+ojFY1Qn6xoHWJuCJZPe48UuxDZKv5ul07UGmLytqiBPejAbMElGIO5uLeIr
	dt+dHO9dgpIy3Yu3pEHJf//YajYMXDxBdqT2pLd8Z6x3gBNqT5AcnKl6pTNW7nUNV3/9wwNKKeW
	iKpjqricyCCsdNk7KPbj9LOG0KE0EUOtgDjNyNnWuKD77xbJWyTfY9SyRoPITCjtcbUdM14riO+
	sILPLcfJgSsyRvBWqsUnBcYZvUQ==
X-Received: by 2002:a17:903:1813:b0:2c0:c262:b919 with SMTP id
 d9443c01a7336-2c1e78e4e97mr111388825ad.5.1780942458521; Mon, 08 Jun 2026
 11:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031604.888137-1-chenyuan_fl@163.com> <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260604031033.806727-3-chenyuan_fl@163.com>
In-Reply-To: <20260604031033.806727-3-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 11:14:04 -0700
X-Gm-Features: AVVi8CfeHqtpS-HGlLc4glXkts_Xp6ARPR9VGj-S1X4pyp51n5kXFrLsUu96gpI
Message-ID: <CAEf4BzavhAkKLdmsZLd0r0bUd-B1XKS6a+Ec9xfqaZVZNiu1UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add ARRAY map type to
 token tests that use struct_ops global data
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:11=E2=80=AFPM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> obj_priv_btf_success, obj_priv_implicit_token and
> obj_priv_implicit_token_envvar use the dummy_st_ops_success skeleton,
> whose struct_ops programs reference global variables backed by ARRAY
> maps.  Without BPF_MAP_TYPE_ARRAY in the token allowed map types,
> bpf_object__load() fails because the kernel rejects ARRAY map creation
> for global data.
>
> Add BPF_MAP_TYPE_ARRAY to the token permission mask for these three
> subtests so their skeletons can load successfully.
>
> This is distinct from the libbpf probe issue: the skeletons genuinely
> require ARRAY maps for their global data, not merely for probing.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/token.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index f2f5d36ae00a..1812de87bedb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -1214,7 +1214,7 @@ void serial_test_token(void)
>                 struct bpffs_opts opts =3D {
>                         /* allow BTF loading */
>                         .cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE)=
 | bit(BPF_PROG_LOAD),
> -                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
> +                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_=
MAP_TYPE_ARRAY),
>                         .progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
>                         .attachs =3D ~0ULL,
>                 };
> @@ -1225,7 +1225,7 @@ void serial_test_token(void)
>                 struct bpffs_opts opts =3D {
>                         /* allow BTF loading */
>                         .cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE)=
 | bit(BPF_PROG_LOAD),
> -                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
> +                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_=
MAP_TYPE_ARRAY),
>                         .progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
>                         .attachs =3D ~0ULL,
>                 };
> @@ -1236,7 +1236,7 @@ void serial_test_token(void)
>                 struct bpffs_opts opts =3D {
>                         /* allow BTF loading */
>                         .cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE)=
 | bit(BPF_PROG_LOAD),
> -                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
> +                       .maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_=
MAP_TYPE_ARRAY),

Hm.. ARRAY map is unprivileged, you shouldn't need this. Are you sure
this test failing for you is not a consequence of the issue you fixed
in the first patch?

>                         .progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
>                         .attachs =3D ~0ULL,
>                 };
> --
> 2.54.0
>
