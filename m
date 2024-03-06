Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2960250
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752688; cv=none; b=sNIHdyMroH5uibrkffGV/JAlPDMKHbakZr6ra1Q8qkvZPaegYDvSx8UYBr2ECXNsYkIOv1/pMiow2KR0koPu+8la5Qhl8goM5pGN2xPf/zwHn6SQKiLGuy6AAKYT7hTqq7uwfjL/CRJgoNY0Hif7nj886gLyburIBdA09DKlYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752688; c=relaxed/simple;
	bh=3CqH+Yn0QojVHv4eboB2iy8YNlCQwH0cOk+2Z5LXZ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW5bQC/KtKBqLHOqpp/3s1l5dR/E3CkHdMsgmngVysWc5SAYQI0PBUFzAO+18AsmcxERrZGj4tlvpO88JIwD8BV0OhGFtxvdXjgsFY8/ImJmK5GBSXYOq+RfFZQE4gYlTdXEPIg6/FGjub0iDDAZUmk4SJtIIS2Afu8W6cXmfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEeT4xcH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEeT4xcH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so4822982a91.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752687; x=1710357487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHiNBZvCn3wB5Ii9Wc2aJdBOKiyj3i+KV/1Fx6InuOs=;
        b=kEeT4xcHlmbXWKSCyxRU29zVefEFZ+tsC6CQCzpEA5njGpNoDEVqMcFeMHgrNsQZci
         +2b+yn3dQYm4bK1ns/N701tzdjSr4CSZqmbqMl8eZI43dEKSpuW7ZuZtPK20reLXJ5n0
         ESGcgjVSuWg8ejEPmeuamxOktcMWz/3XraO4G2Zj8PccBkXwnSEOa2q9qTkrL/rfXZby
         t8ec2uhDD8bI3MrLBzVChxi2m3m/McR7I8YQOpV+Lf6+hUROK+79YQr5nXTnJxaxL2Kc
         XnefcAwKUk7SA4et8b0PDylr/1Rppuyxy1VIU4nnheaHzjPGzf/IQt1XlHfyAx+LyD41
         ZsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752687; x=1710357487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHiNBZvCn3wB5Ii9Wc2aJdBOKiyj3i+KV/1Fx6InuOs=;
        b=CY45cOXJgsE+dwNgKBOfq4N9YTavmwKTIB+m8ewSE3fNJENtd1NhNQSakFC6NrNgdc
         0UmxHfvlIiqJpuMNSKnaNOiqiH1CqLvdrw6wT3rob3o2WdhrtGRWD03UM3Nrpdqr1/r7
         7Y3j5FD7LlhpOw/R153VqSHHtGI/Gb93FUfBvlgkjKA2fWrfzikVF43TuKAjoxEnJYWU
         4huVrlKO85Z+98U2vxTLf/YEKHmTFuStHEc0ewvmH6A1VEYIhu4uoqW0OmNhTiK6G6fv
         mHHlDFM74hcGoFyi5mWeOvba6g38uhgrv6yrteEPpKRHozSjc8JInIDHrYuql6067Sj3
         /L7g==
X-Gm-Message-State: AOJu0YyOtrx3u7v5f4Fa9EIdg4zfnxU7ZOlo3Yxb0eeDnzZCKWGV3aYd
	9rweSpUPF0o0i9mwMrQ3k2m2U89xeckpPV8by8Ns1BcM0tWTiZs/CaO7g2INJDF/gQEefklG/l5
	MR4dh+9lY/WYOa8uXzMIhGB7wimM=
X-Google-Smtp-Source: AGHT+IEDy+820iJLjy61Puk87tWheeRTDnQ52f+tOAW/xX+QDh2XB/rUsAnxWfEUqNyukyiqFvDHtOLdXnTUE40DwLA=
X-Received: by 2002:a17:90a:9f0c:b0:29a:5996:416 with SMTP id
 n12-20020a17090a9f0c00b0029a59960416mr13491738pjp.36.1709752686817; Wed, 06
 Mar 2024 11:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306104529.6453-1-eddyz87@gmail.com> <20240306104529.6453-15-eddyz87@gmail.com>
In-Reply-To: <20240306104529.6453-15-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Mar 2024 11:17:54 -0800
Message-ID: <CAEf4Bzaunjf+0Fu59k6Ga3CmoURn65U-k9M06nY0_FaMRMsM1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/15] bpf: allow all printable characters in
 BTF DATASEC names
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> The intent is to allow libbpf to use SEC("?.struct_ops") to identify
> struct_ops maps that are optional, e.g. like in the following BPF code:
>
>     SEC("?.struct_ops")
>     struct test_ops optional_map =3D { ... };
>
> Which yields the following BTF:
>
>     ...
>     [13] DATASEC '?.struct_ops' size=3D0 vlen=3D...
>     ...
>
> To load such BTF libbpf rewrites DATASEC name before load.
> After this patch the rewrite won't be necessary.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/btf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6ff0bd1a91d5..170d017e8e4a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -809,9 +809,23 @@ static bool btf_name_valid_identifier(const struct b=
tf *btf, u32 offset)
>         return __btf_name_valid(btf, offset);

We should just rename __btf_name_valid() into
btf_name_valid_indentifier() and use that everywhere. Please consider
a clean up patch as a follow up, thanks!

>  }
>
> +/* Allow any printable character in DATASEC names */
>  static bool btf_name_valid_section(const struct btf *btf, u32 offset)
>  {
> -       return __btf_name_valid(btf, offset);
> +       /* offset must be valid */
> +       const char *src =3D btf_str_by_offset(btf, offset);
> +       const char *src_limit;
> +
> +       /* set a limit on identifier length */
> +       src_limit =3D src + KSYM_NAME_LEN;
> +       src++;
> +       while (*src && src < src_limit) {
> +               if (!isprint(*src))
> +                       return false;
> +               src++;
> +       }
> +
> +       return !*src;
>  }
>
>  static const char *__btf_name_by_offset(const struct btf *btf, u32 offse=
t)
> --
> 2.43.0
>
