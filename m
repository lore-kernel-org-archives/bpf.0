Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEC3C9ECF
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520838; cv=pass; b=ZIFkoCQ5hJbrrFPj0oN5bg10khGN8VsNAWr95mVfeZmQNHxcdyECroHqUpOWHGQnY740T0klpf1UAXwtwEGLaEA4oUjPcusX5y3UWgHumxA5lgJT3WLIdrjytlAx3Lf9wGFjW+Azj2gxJ+Vf/QVraZf8OlLghv2YtCNOXZHGlRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520838; c=relaxed/simple;
	bh=aUp0EOonApdMlLIdV6wKR+tzOt6Yqq3mjvhVkzaQr/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWCa3eeJqb4TCxm3oEFBNOceXF6AOwB4Yf5g1p3lmXXOfYSWHxXnfOI1NJFgptVxPcVUb4REbRQAcwwJZ7qB3QPZdT8W8LuuwMI5NxmWEaYITj9B0f/yjwniDeCNUOKZDs/KVu36ul26g2sFyf9FzEeTl09kQtrsgc2dkP/M/Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4qv7q5b; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4qv7q5b"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-799001d73bdso6429647b3.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 03:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774520835; cv=none;
        d=google.com; s=arc-20240605;
        b=F3Q7+Q8yA7E5HmTlziqEZGbCmT/FIEDiYrdDQHpqrJ486JIG3r/z8EELErjd14Fx+J
         pU1oqH4z2YeUIIp77JAA1htrqlU9C/oZwQYh3ljgl8Ie3QKfSPGRpSo/4i3kQOBFdVjZ
         NNHbGkTEsLqvPr8KfH++mid5yVqIJAQbIUmad5sQkt+ioQdaIPT6vYz7OiC53FB3w8ej
         ZuRlIuHIr/9eK51+YEZKbJuqcQU4Vo3lg4qX66S/EVzJ/Mg22oqYWIMDuEiS5/gOQGkT
         ZVHzWchwtsUDnPt1sNEKUHlw8yAkNWdoZaojJJOr8+FjbeUDiylv19DhqN29czmkSNj7
         vBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7vQXBz2pqP4F/ZTOpfUQ182jsAxAIbjKK/mHRfShgI=;
        fh=2LJiOu7j3qquKO0JaRChG8c9C7uM1nj003PH4nYYBZU=;
        b=MWPfECRZSApzrKW5pxFbtDUsZ28WQHLD7HLpUCn4F5w09gSBVTOS7xAZLbLkzoaizh
         ex7iRCPvCg8P+/X8G7k47azKXe6YXV0K6txIDGF4cfzwFl/4pdrTeScGflNnDxF1kPK/
         YVoyHKwwxub2/BGXJa/AXo59ZaOXII0if2N5HcHzbd3LG4NsDtyx/xI1xSy+LXIpC6mP
         Ol54m66iMW1PmItCOxJkjbIFcA/5Er1ZPgrJuEEd5WwcorI6jobky4p+VOlZvMxvpc0h
         uU8t+4iIOqaVxsmsfZDGl1jGKsuTYlupNThTT6CP7M+ZEiW/P7pgs9j9meNnlXrSB4Va
         7J3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774520835; x=1775125635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7vQXBz2pqP4F/ZTOpfUQ182jsAxAIbjKK/mHRfShgI=;
        b=K4qv7q5bkBzrcSFspTP2AtxMRqiqbsvwHZdiNgcWg3hGQQwvfbAjENHXvrl/LDNCEk
         dVf4CDlE7pphNPZYm9ySTTnmfkQogCZfclQinerkszoG32VezwjZlD6QAOQ1+4jZYwGk
         6ASuGLaFDYWnq22P9hdPm0vviW+57TK9a2oR8deNQ/DW9scG6jBx634Pj6RdBoRCedl8
         mnKrAPXV3ALianF8J0JwEBauSAzmrRn+8fayx3cqoQWk7mb/EWOrCQouQJ5F5bru0vMT
         jvKBGs7UzvAVZqef/Wc2OEzvld8h9JwFRIC33oCX0ugb43WfqPU8ff+qLtwFItuC5j39
         4Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774520835; x=1775125635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7vQXBz2pqP4F/ZTOpfUQ182jsAxAIbjKK/mHRfShgI=;
        b=MD3wHlq1lp6m/XyaaLrZI3FKd/La/vOV7UfzUVmKRi1YE1tACWwqHogMqJqNRk1LW1
         EuX2TR9RIHA0U7pwun3Bg2QJF11PATHAseHqdn50UTxl4K9pDl4Pm8vMFTSQuYCYDVW9
         Pn49XDaB2uRDckIvf0bIr5My/Eu98T3dHswzCCImPfXxAF39iWcJJS7FLCn5N6bYkGqE
         nE/7V3CUMqDG3nLx6+lQWw21Q0dEbdgpPLbBHmsjVbW4P+ggVUtNMkvrJoe9DwLUo7MG
         QyZsZI/MagxJ/ceDc+2JeWlIjYCIp1zNk0VWen0FRKoO8Fq2SSRmgfONQWYiaJbD2R7n
         eH4A==
X-Gm-Message-State: AOJu0YzSxwYhmhvTdTAp8RCDo6YXj7krYd1DkGJpSWCByG9wzvsX5Vgg
	kR0Yy9rz3BA9Kub3mZYzWSVGzlrb/zxY8lfCIHlnwjwcvfw6nUZL9RQWd/fOXVfVXOxFdaRd3cn
	kbAbLKXhp6BqpoLmQ/7uskDxs5w37PQU=
X-Gm-Gg: ATEYQzwK2R9EyHPA1rAYLYXSXgVaFj42aXO+ucpkPCh4xx8RlQBYUhOYc9f4I7rv8UJ
	ree5BjXA2FaQooeQvH285z3WrJPrDEEwbeRNxMza0m6Mx8LgvBvlrsEriKUNnZJAd3RKfv+qdea
	gljG3WQS0niSlxPRZVcGDIT5ZZEIpD+teX0K5bq317upslrrTWvI5y3XHorUAobnmyc2bC1PNG9
	50iiBNMz/xvZhWwGKvOrxor738qt8WQFzixYq3EyiGMK6r0kZP5QGiZlxmcu6qJvoqzHP2U3vWf
	e7el+w76FdHmvJeDqKD/Co9ui1kBlLvmOr+gQboQuOKm8QUKcOaaTAN0ekulNQbBO7Q=
X-Received: by 2002:a05:690c:6e86:b0:79b:ccb6:a839 with SMTP id
 00721157ae682-79bccb6adb5mr16161747b3.13.1774520835420; Thu, 26 Mar 2026
 03:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326052437.590158-1-ameryhung@gmail.com> <20260326052437.590158-2-ameryhung@gmail.com>
In-Reply-To: <20260326052437.590158-2-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 26 Mar 2026 18:27:05 +0800
X-Gm-Features: AQROBzAkotHiJYnXK4nNC2eoY2gJYRRNM1fPGgegtGUJFM62GXMcwDhpt7d_vXg
Message-ID: <CABFUUZGnj6jOifYknYahrEJjzx9inbT7nz=OGmdr_MfUEW-HHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Fix task_local_data data
 allocation size
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Currently, when allocating memory for data, size of tld_data_u->start
> is not taken into account. This may cause OOB access. Fixed it by adding
> the non-flexible array part of tld_datg_u.
nit: seems to be a typo of tld_data_u?
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
>  1 file changed, 7 insertions(+), 5 deletions(-)
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
with `start` now included, `size` seems even less likely to be a multiple o=
f
TLD_PAGE_SIZE. Could aligned_alloc() fail here?
> +               malloc(size * 2);
>         if (!data_alloc) {
>                 err =3D -ENOMEM;
>                 goto out;
> --
> 2.52.0
>
>
