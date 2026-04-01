Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E31A6810
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008138; cv=pass; b=egJGLCwdtnLgIxZSsnUhKG5q4nP5Gmr7jg5bXNp0hmaX6WLaFcdA252e0ED3YncN83nNaLU7TGse6qVrfh2FWpyN9r2noufBXirUPYlQMSH8Ym1d4h29hmMRYUlW1orBR3mRKMrPNLYvPmH/7JRxBRGmm7ih8zapdf+VkB2C+sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008138; c=relaxed/simple;
	bh=nbE/8kMb9ldhkiRPc2KHbdfHDPJD65wHmz/xIutxEaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thvgQPhI/Zvr69aAWnUNJp9FLw1H5ve2kbogrls0OvF3g9uTmYj+9NR85N58mfSZjG3CyzWhc+X6PflZYGVvMdxXsyhbCJNwMiW9jncH9c1ZVhQrSUouFT4I9rCd9JCzlBspJ/ZR78AEC7QUuLDVz+VNcBGT7ymwys1ITiVTidc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZdkNlq9; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZdkNlq9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ab5fd969aso32170107b3.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 18:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775008136; cv=none;
        d=google.com; s=arc-20240605;
        b=aYK15vcEPmB+QUMv0u8+oK5VlDr1t01T4BbRMTZYJoArsnN+q16mWwf3j0+QOgsc83
         jVuPqb0wWoL6X5YfJbLbLfvQDheRdm08dgziv8cs2X4w5sZDfw3Dkqv2+no8O8f6Sady
         YtB5uDSOeJCtrnsB9AHWl7XHNHP9zrOvhgaachiDoPl0yiyBR4pnOlgRMZbz1s0+cgMr
         k2dZQv/oogLv44699NEwuHGHW5gk/v5DA0dXtvOFV/RouXStaJA5UA4sFHE5CB8tT2CL
         fxFKQo97X7fVFgcuJbZS7meu0wyYQS95jkxpjCYw+OJN6QOnYjDFePvFrF3qXTCIjhA/
         jmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7d/oZXVGlxIdX+Q7YLLkdN7TAXpJQE/SytT8XM4eJ6c=;
        fh=jLrlXpAN1N+6I2c7BxDrN4VK5iGiuQSN/y4zidXjizY=;
        b=dNqlgJc9zyOIS/JmIHU1kTb1n1/qO6B1cgozIIP0D5Z72UeSnnnH7YdDWn+d0sudZN
         vDgu0RZG7wDPWREinPXPtlhx0oW0+Af9O8TUYB0AbGe9ml6331yqfhVbhOb4D0gYJmLH
         3VkNKnpE2+C5m5IeRNZjbjpBEhaUboLOQ4N39jovxxDuwcsSOMXJKCOSnu88BS1sn7jB
         e6/mphDuFUHa9X7TTZyncevdkZVhy2QiC9OXX4e9hnDIKyD7YC5PlQcbLcXbWMEJdGqK
         ca5yfzmHW5jrAO0vgqtQFcPYRtXi6K1oPDF4oprD5QAPAtIJO9gGXK6R2SSQ47L4kSak
         sqbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775008136; x=1775612936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d/oZXVGlxIdX+Q7YLLkdN7TAXpJQE/SytT8XM4eJ6c=;
        b=pZdkNlq9xXwOoFj9AvLht8ktudhX7xC+caEK4dl2FglssBsYSNs2d3eMH9qqNC7IWA
         KoSLBruC9AyPFwemvBK6W62aXZtjh2WwdfdbNEmV8ETlAF/pCv7vVKzyj6srvyJLdowl
         vqWBLlxJPk++xuKmNRdSqoAIi5Mo3fN3WgfM58i3rCpJfA7gMY5Js8nrCQSHMi4soRQf
         ZLatWVnmJURuLjaNzpyoClKfNET3z+PtjnIETIYnw66De95yjVKZGb7otgYvb14HQyYd
         D1+IiauQ1cZm+XHxK/kDhZsSbB7h0mSF9L+HVMU81ClMFEXORsccSuT412WtFCDzb2a9
         KsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775008136; x=1775612936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7d/oZXVGlxIdX+Q7YLLkdN7TAXpJQE/SytT8XM4eJ6c=;
        b=Lslyv7qw2QWQGuzo9uZr46NOJD18XLlrSS6ttz0QlbD+eApFZCORVT2eaoL472zDZx
         RMplwMPh2BglCWDIOZekdb4PBSxExON5tVQFiAt84sTfXgVtQZyTJWiS1oXKEvwZ6atq
         1l5kbrhkGyrIFGa8pcviTcEV2VUrP0ZBoNfzD1RHIB3I1mCc9+AmeFTwcWuBGWUEwt+w
         qvKFX6M+6ZMc158DFAjaritrwTd6SeV4NhjMIM55TISBt2mV3S7ugMVUtiemVC/HwzrH
         jUUQ6nGNNKVwPRlOTqpncZATFx+PZZ4XkbFpx0hDBK+h98cAea8N7fX8ne7LxKQtFAbc
         XgFA==
X-Gm-Message-State: AOJu0YznfpBOvDGAxo2Gfoghx0Dhzh9oyA9EG1DM7hO+h1cZGg5zD40f
	XEJbOrR+HGR8voGd2Rmy0Hk//jZHWifOF5BIMcNfduUgENhEFg+salMEqD4QYKrmKGOT6VZZvxg
	aey2+pw98fiezYvxzKyVWDBfXlyA6VR0=
X-Gm-Gg: ATEYQzxzPGI5KFie0RpZMRdi9QrtptJw6xg/shaxv/Iqkk1ir/bmmS4mb0sStxgls/n
	1FKb3H2Z00O/ssw7Fa966rmiA74UgewgS9aVxHO7P1frhZMQlGXzW1ygBnkYNtLGyWI1tunLFyz
	txeiWd4TasHNPam+1bFwPN7CUwpAXU1DBpwHduhBZggnjQ3hHA7aqOhBtDe7eiVusbvxL1/1iRJ
	hyF/sxhTwHaIwJ2sMw/cJVPkgfPn6+zdI1Oe3D84FCyzktpO4WhVOAzi26hmGYV0IA1e+mOkpjX
	oD222Agg1pWSY/e/Z0JBcxmDs2Ol301PG9V3MpAaKx9RAn4VJ6iZF/iXcQtSIg==
X-Received: by 2002:a05:690c:e3cd:b0:7a0:17f4:e785 with SMTP id
 00721157ae682-7a21262f90bmr21255597b3.39.1775008136581; Tue, 31 Mar 2026
 18:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331213555.1993883-1-ameryhung@gmail.com> <20260331213555.1993883-2-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-2-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 1 Apr 2026 09:48:45 +0800
X-Gm-Features: AQROBzANKeGQ9ERSjqMqk3xhXczgoamwg2zrLiJWqs1N8BBwoDMus9vnGPiGNGw
Message-ID: <CABFUUZFy=dxOc+DQ+P-=oYg1NT6DfimA-HMC14kmt8cwM1xuww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: Fix task_local_data data
 allocation size
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:41=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Currently, when allocating memory for data, size of tld_data_u->start
> is not taken into account. This may cause OOB access. Fixed it by adding
> the non-flexible array part of tld_data_u.
>
> Besides, explicitly align tld_data_u->data to 8 bytes in case some
> fields are added before data in the future. It could break the
> assumption that every data field is 8 byte aligned and
> sizeof(tld_data_u) will no longer be equal to
> offsetof(struct tld_data_u, data), which we use interchangeably.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
>  .../selftests/bpf/progs/task_local_data.bpf.h        |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 7819f318b2fb..a52d8b549425 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -90,7 +90,7 @@ typedef struct {
>
>  struct tld_metadata {
>         char name[TLD_NAME_LEN];
> -       _Atomic __u16 size;
> +       _Atomic __u16 size; /* size of tld_data_u->data */
>  };
>
>  struct tld_meta_u {
> @@ -101,7 +101,7 @@ struct tld_meta_u {
>
>  struct tld_data_u {
>         __u64 start; /* offset of tld_data_u->data in a page */
> -       char data[];
> +       char data[] __attribute__((aligned(8)));
>  };
>
>  struct tld_map_value {
> @@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
>         struct tld_data_u *data;
>         void *data_alloc =3D NULL;
>         int err, tid_fd =3D -1;
> +       size_t size;
>
>         tid_fd =3D syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
>         if (tid_fd < 0) {
> @@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
>          * tld_meta_p->size =3D TLD_DYN_DATA_SIZE +
>          *          total size of TLDs defined via TLD_DEFINE_KEY()
>          */
> -       data_alloc =3D (use_aligned_alloc || tld_meta_p->size * 2 >=3D TL=
D_PAGE_SIZE) ?
> -               aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
> -               malloc(tld_meta_p->size * 2);
> +       size =3D tld_meta_p->size + sizeof(struct tld_data_u);
> +       data_alloc =3D (use_aligned_alloc || size * 2 >=3D TLD_PAGE_SIZE)=
 ?
> +               aligned_alloc(TLD_PAGE_SIZE, size) :
> +               malloc(size * 2);
>         if (!data_alloc) {
>                 err =3D -ENOMEM;
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 8b6f7af43648..1f396711f487 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -87,7 +87,7 @@ struct tld_meta_u {
>
>  struct tld_data_u {
>         __u64 start; /* offset of tld_data_u->data in a page */
> -       char data[__PAGE_SIZE - sizeof(__u64)];
> +       char data[__PAGE_SIZE - sizeof(__u64)] __attribute__((aligned(8))=
);
>  };
>
>  struct tld_map_value {
> --
> 2.52.0
>
>

Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
