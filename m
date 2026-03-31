Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483440DFBD
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915305; cv=pass; b=sagXGLvOLf8Aai9ZIiBTdEAWC3qJzqwck1mYl34gpyfwI2L/FCt7jr4fPRJt3AEGOreBm3Jo7YEF2+HiaO4O5LC5PBlpohaz1PIG6+LX0E7PoM0gjqRsnn5+ookhCRyEA73frvqHzT562/h+L/yn3JZCArrUx664LYEVt8FTne8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915305; c=relaxed/simple;
	bh=d1dAOL0LZPAkvvghsbCJEAfRHchndH0E4XolojjvAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYN2Xr00mOou/jamMF7GBjqgnf0RY0RY65JkHdhspRyxw6zMFuqtre8U+us9kjXQMJv5uR6yjdtprDFcwihmeIVve+btUJyXYM1gUov5+cll+rGlWTyRbwEEBBBTXJMeXt4lgMJvDRyEUPmKDTl8+St0GPF64zV4Zy1WAlStapc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up3bkFwA; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up3bkFwA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so214869a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774915303; cv=none;
        d=google.com; s=arc-20240605;
        b=VYFTW3Yf0mF1j7PIe+4L9uiqZVmD/wHkrJVyYrkq3qwdgybjQYA7oktC544uF2V/VD
         /6IVcG5AyUq/luwLVto2Me+A3zhwpRP6VwbcwfD5Er50EisUJxssUd9gLvPKZwndgpsY
         sdKT/5P0rfCJQ5i6+VmKlf2nIlHuT5khwbgi0l03VB2R7xPZxGgZhZ4shnTDQpvGQFW6
         oVlFEbVDsxLu+gVqQuKx4G79I3ejfU2BmjM9w1k+k8fnaNXkJnyktOTv9gh+Ip2zNV0V
         ToQIUQj2m4INcKoVWmXk8u67Kgb/gkAUAOXOCywLKiYo2wmLZ2Z7Qz1+hhKu+UbA7p6O
         Xqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=inmnSok5FOieG8UOQOyMnZeXDdgg96/7Qg/Nmaf/Xus=;
        fh=YXhxD3wyK33+PQ10KTCk2H4vVOOakTCPA9bwY3a/OaM=;
        b=AgRu4QqhEFhrF1Z533Y4+1mcdLykcu8hWpEtsOl8bzSM37rx07wuTnrvijZfRICZWD
         1hqQvbE9Qj6xFMSkghMiM2ke3iEC+lrpHXGv1QoxQchg4kj3916OkHE9j9CgOYdRjZdE
         RxIBI2lknE3s5kVEy2UeeZOflGVGLHBtML2Q54xongOKOmCzUHkJeYArrYbSH12OsaKN
         P6OsAQ+a2zuR6eKs0icHXXWskE6+FrOqYlEbkI4gKF9jCG6eU8ev/D4JMKuGV54lW45m
         /auFTbUXA6FRurbW2omfU1FK0QbzXJYnuA0m6poTB9eDBuz5XP+Wkkf+julMv/9fTx2X
         hUHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774915303; x=1775520103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inmnSok5FOieG8UOQOyMnZeXDdgg96/7Qg/Nmaf/Xus=;
        b=Up3bkFwAnwPOqtVVUO6xV9M1Z0mO/cFZGtUE8UDYPgaCVcYfv+o6I0Jjy9fCm5qN+K
         JCZ2Tap+HxXgfCZxBSofPieXCVip/ZC2pmxTtWyovMM7sEPEVkpgqu8jGinJTcQ79qvy
         JtCg+EiCu4hPiZLNEp92CAqWnmH2pMA0FCX1D8S81I/WQgK6AaRRq4hlxW5gbVbg7cE7
         AcqzPItwx634KUaRQE78sJn8afCnqCiudQV7+6OL+yKOgpA1xA5lCnDP0XMOgKRhTDma
         p8nQWkZP1lG6hVD82qkgUNjQ/KC0KYu7+FaSMDfsgjbUFcx7S1UyNOLWsQCEEVE656Vz
         dqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915303; x=1775520103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inmnSok5FOieG8UOQOyMnZeXDdgg96/7Qg/Nmaf/Xus=;
        b=GjkmkDGcUbW0o7U+mxJhpTrTzywLdRkcXfbIPR6nYCKKbSTlOj7SLi1lvTpJK1auqq
         8J/HGs6+oPeOTyGcrMNO0uhwmlh+CxGkQLOX/e0jFiGTF5p9Q4cy8RdYxghNtFsic2/E
         iIF16C08YNVwldyHD4HjyzvqBFsa3AooiL2oeApCg+sTxP+5huOYXHxFI8djVeuOvsts
         iOuqylg06pzgL2dDQvgNzGhnHncB/hZTA4xM4GVjiujabKQ8xUeeQSCNp2RZksQbjaBk
         8oh09a+k3PYFcm7fxrDwgBhqUI3URcI3xOQJ17pjjl2NDs7JmQf8xPPEBk50qCdvE56b
         PaRw==
X-Gm-Message-State: AOJu0YwGP67jgD0G37Jx1cVfTxNxiCuoh5u8jfFsuYonh4b+j8vzPTNb
	TTQzyR3wAfrN4U/GdKOwJ2epwTsu3tHL/Qz0Yg9hx9WigKnh99iqJ88453BFs7upFUNDWmEcjQS
	8D0lubtWow1W245Noq0GxmcSXFZYDcM4=
X-Gm-Gg: ATEYQzzAZYqE2XsHpG5Eg3O8RNbNpmknbKXVs/LdP8zMeKxR1DHDBC1UdfCOyA+k+Id
	6OzzE4m9CujvfDQH+KknbJoV5y6uEcWD4gQxf/fIlKm3lM6pYhgUvEKAlXJGFBOZcdh8OuVYtYF
	0p4rDb0EgFSkHAhq9sJc/PNhUtO3o4uiJLI93j1fU2XsirAUDhbGz8zaZ+PexisoEQf/yIxncuG
	8p9Ifts8SQlcrXM8YVSfwBF3FG5JkPcU6eTheJwHo2W4bSIsdYie/Ueg54XnJHK2CwOoco1TJuY
	6HL4bsE9wRNt5RlOw5QpTZs=
X-Received: by 2002:a05:6a20:6a22:b0:39c:1f90:2867 with SMTP id
 adf61e73a8af0-39c87bdaf84mr16344116637.59.1774915303447; Mon, 30 Mar 2026
 17:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com> <20260330-kmalloc_special-v2-2-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-2-c90403f92ff0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:01:28 -0700
X-Gm-Features: AQROBzCiqZVlLYzaBKfIcE16uLxTwHe39o5aNemYccW-HKJjYuuTDhm4jW41Zvc
Message-ID: <CAEf4BzaWJiokp=D6dK6Rma02iQ-GoDJnOqZUQuHJ02jsz=n1iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Migrate dynptr file to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:28=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
> bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
> now that kmalloc can be used from NMI context.
>
> freader_cleanup() runs before kfree_nolock() while the dynptr still
> holds exclusive access, so plain kfree_nolock() is safe =E2=80=94 no conc=
urrent
> readers can access the object.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4c3011ef631f..7bb8b1339e2f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4435,7 +4435,7 @@ static int make_file_dynptr(struct file *file, u32 =
flags, bool may_sleep,
>                 return -EINVAL;
>         }
>
> -       state =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_=
file_impl));
> +       state =3D kmalloc_nolock(sizeof(*state), 0, NUMA_NO_NODE);
>         if (!state) {
>                 bpf_dynptr_set_null(ptr);
>                 return -ENOMEM;
> @@ -4467,7 +4467,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_=
dynptr *dynptr)
>                 return 0;
>
>         freader_cleanup(&df->freader);
> -       bpf_mem_free(&bpf_global_ma, df);
> +       kfree_nolock(df);
>         bpf_dynptr_set_null(ptr);
>         return 0;
>  }
>
> --
> 2.52.0
>
