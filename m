Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3D38643B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601367; cv=pass; b=M0yLvItsbPO8uz7+2mDP7uWH8G8oStZH9YGOMlAMG3rjhauOt8sW9F6XaRYsKzLx3bF2i9e03Z8bP7JdokVm+sTm+QsUZTLdvylCFgszNU0kmnqYJ1eap+5Z34RXeVMSNcsuHLxXBynZ9W0kZkNSxe0Oo8qOvrrdYqHgBpos5TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601367; c=relaxed/simple;
	bh=3StVfIxQRjhA3YUmtCoia283sZ5HJiZIzNvJNl6hRdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVwFJrWbUt3PF8PK8E5rbxLGT6D6xzqu71qOBn+txIKh+9Owwhm7IidDHLvVpR/Pk18cvzT3ZFPIgTQU0JdZ7COfTrFaVqecrsZQdyOcsC8hU5+yF2MMlB6PiMLLtLl/Lin/Fwkm7JWE3CD130rvZDCapcBv8pUfLqpx9W7jjbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7i6v9gz; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7i6v9gz"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3331520a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601365; cv=none;
        d=google.com; s=arc-20260327;
        b=FmfOcw6wOhcD14Z2r3UFnOz0UcUaxCdl5z4JNGLT7Nemk9Hu7yaqiR3MjLXoXVyNSN
         2SuivREGBtqXtRg0zY7nsdZLQmSmcs9ype09NPXjQtFXVFGQqN37Nnf9XW5KULCN52vS
         HDvlpOf+ywKJlp81piakEtr6y85U+3bCh6Lp6uvyvpVrUb+7jZPyYcOqQ+VPOLVogboW
         j8biU0RBMU5lP/IC735QnHZBZ0Y0Effl4fmoHaZjD7D9E2OMS3NDg+/Q3lwRoGLZeuHs
         IDooee4lA9RXm8nvOl+LpuPMznbagrrK2pAR5S0gX0d+GymmpJ0hS7aVFquoBrkxZGzD
         1Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gtyz3PrWS0/EbBBMSr85uBpNE7c9ArKZmvKGXQmGL8k=;
        fh=nqcOef/kywzr9d9QbNsogATk3v5A+nXOrN5Mrs0wZkk=;
        b=nVvbWbFgPR1XjOdgCave0H+yxD0OGfIkDku4eXW5re/GD4KAkaHH7FNd1XHg3FAunj
         CYF/lodJrL0eecyZrRYmz318aWCgqv2LMD+5cSIVTI7XJQsrBB9hCjCcVWV3DVV2VQAH
         +y23wYY7TYQbLlKt0mJKQMPvmsonmKRoAQhivWTuCnGKwomyxTcmVP/hgUkLAsZq/2ZP
         mltG3iCCS9vi/dr/d5wCKevEJvWbZEkp5giZWTPMcd7/YPEeQR0/BsXxtxFkjMVtW3+Y
         1NJF2m8gO01Jcfwahc9WAJHY3qrcsBkx2sHwliyBzj3FcUypJlTcPXE8aCGN/b1+/tjD
         ND8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601365; x=1788206165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gtyz3PrWS0/EbBBMSr85uBpNE7c9ArKZmvKGXQmGL8k=;
        b=d7i6v9gzcWgop69Nr1oVl9x+qpaZD78heJbW3TRh4Lv7e67GAktgdGcmxyr1quk1Me
         /tOhQJQh1BtXm+iDJYnq4yUx6iM8xf4mD5HFFx9s5pZlnRmL0OUrakzFWPt1EVVFpH2H
         TwhcetanZDXrlF/2dd7wB8nNqkSMrtRUWuvhbPcYqVtN6bqq46HE6j7iaOQiSrruHahS
         Jujt82F8KE9gM54dsqEeS/gFne/FTidvqyuVzQhH2sVWGsW+ASEbmgvJeXc/9pzBOtSa
         cayHgbgRfIFrnhrIjlA9wtev8wnAiQKSuV3gKJKjhH0JeNk8/elexBF8ziLEh/fcY+bc
         Buxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601365; x=1788206165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gtyz3PrWS0/EbBBMSr85uBpNE7c9ArKZmvKGXQmGL8k=;
        b=qW7A1YX1VpSh13GS3dzR5IfpNhxP8GmrTAINpvFP2DgnHGB1LaU2UgFUrTDixwO1DW
         UThvxU7QHAO9zvDelBEcleNWLEcvmR1zwC2R1nQDPgEBn5f6iNHoiyt1xX8x6mzlq7zd
         MgSydzZN+ZRj0Mq2+Ed1HcCfCJ3HJFA4L4q6gaxaGNZnAEZq48AoqiFSmR3xMJhjULsC
         umQD72JqpNE/KFi1hSMltY5SBrS7j51qw8SEUL/0kTqwd3wkFLT/mcRDMP8IlwyV2MPH
         JLkLU2hmLiFB5sNPneP3V2OVb9VTDwyPFi433lAUNPz6guU3JG83aEWqasdo03Jy0ezw
         2oNQ==
X-Gm-Message-State: AFuF++kmTeQYOBzBqxNo6GGatcgVtEx2bdTTse9S2Di5Rv6tVFbwktau
	UDGZtv3AQ0PY+vt23vXraJj/BzYEm8JlOf0YfpJtUFsary4V0iWxy1xjutwTc3jD4OZmVopPQzR
	29oBDKsiF2i4Um68IJB9BLYfDPunVMImHyg==
X-Gm-Gg: AR+sD10mt5n6R7VEJKDVIOLtq0U9B+Mjfajf21ZxKKVf2nS9StfCG36TP08qTv5WOAQ
	srUSUnajm5ZnxVrq7HWA1SBoaMb9WzgC60jIfOYj2uTcsHrH7YTEW6eb2Y0hOCjy5wzBrMC3OId
	sKjRxVyVbz6ymAyuZyBZQ7o1OUFTVct1SRaUMRuAqmy/2jeMk1NwWIjAhTw/qWkRlIFra1an6Dy
	jVWAgOB8yU1LZ1RXULUi0YkhSVpIOXCTzAkdHko499wjlOt0G+IshLqPVraJZDWDqSr5VnCuiVS
	Y2JC2VxjQbq+/uS3riowBR6+DdNrL5CQchGcM2EKct5NCxQTFUo8tqxR9Z1djOhy9Tg67WU5SSB
	ODM9EOSqbsoPCtcxG2mweAIalZrNUoSutbOGqkeB5zQ==
X-Received: by 2002:a05:6a20:a11f:b0:3c3:89cf:f3a with SMTP id
 adf61e73a8af0-3cd4ba0546cmr37374115637.5.1787601365543; Mon, 24 Aug 2026
 12:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824130245.580545-1-tw19881113@gmail.com>
In-Reply-To: <20260824130245.580545-1-tw19881113@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 12:55:50 -0700
X-Gm-Features: AcwNN1VJSq7b5h0MehG90C0B6XHEJR_ndE-6qMavgPCjsfCbOEgAgFMrtkI0UG8
Message-ID: <CAEf4BzYOVeD+U86qtH=HuwGpARXytu-ZaeN1AxSv1amXL0wWgg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Ignore exception frame section
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:03=E2=80=AFAM Tw <tw19881113@gmail.com> wrote:
>
> Exception handling in BPF program is not supported right now, let's skip =
it.
> BTW, I found this when building BPF with Zig compiler[1].
>

Instruct zig compiler to not generate .eh_frame for BPF object file,
which is not supported anyways? That's been a solution for C/C++
compilers so far.

> [1]: https://github.com/tw4452852/bb
>
> Signed-off-by: Tw <tw19881113@gmail.com>
> ---
> v2:
>  Revise the commit message.
>
>  tools/lib/bpf/libbpf.c | 3 ++-
>  tools/lib/bpf/linker.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c0174..05727c418 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3867,7 +3867,8 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, si=
ze_t idx)
>  static bool is_sec_name_dwarf(const char *name)
>  {
>         /* approximation, but the actual list is too long */
> -       return str_has_pfx(name, ".debug_");
> +       return str_has_pfx(name, ".debug_") ||
> +                  strcmp(name, ".eh_frame") =3D=3D 0;
>  }
>
>  static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c392..1fb0efdbf 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -599,7 +599,8 @@ int bpf_linker__add_buf(struct bpf_linker *linker, vo=
id *buf, size_t buf_sz,
>  static bool is_dwarf_sec_name(const char *name)
>  {
>         /* approximation, but the actual list is too long */
> -       return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0;
> +       return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0 |=
|
> +                  strcmp(name, ".eh_frame") =3D=3D 0;
>  }
>
>  static bool is_ignored_sec(struct src_sec *sec)
> --
> 2.54.0
>
>
