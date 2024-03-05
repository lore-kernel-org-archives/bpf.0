Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D21C2D6
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675002; cv=none; b=VTZA/9BB2vsOgEcuvfoozF3PGNTNv9z3pwHpwrJjixdiP/C+oRiSCr7EKyJoruysCI5+nCNhX16bcl3oCvQgiXCP2JeBkrlLfqrX7I5oE0f+du/2V9vhH9AzLUPmUWe4ytbc6Mtzdhv1gySL+aJmHgUxRE1oV+GL4dfliJi/D8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675002; c=relaxed/simple;
	bh=UuezJkdkT3TfJzQOL6SpLWk0rKHSgdDMslZR+8CRvsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d45UYOA+FR0IEzeIM30crsC+RIefwI0oPgJ7tbYLLonMqdMFwCpsgONyKirB61guPRyDD9jrd1ObdnkvfQOs5+vrkud+HkEeorpI3M6Kpexh2uaKuxr1saUCVNH0qyOgtIlBOYZYYFWoTUDF1vjptDH9G4g1GxtUgs/JWNBSeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdXvxumv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdXvxumv"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e56d594b31so865159b3a.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709675000; x=1710279800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Intp0+6uR7/i3U9bPDDPJd3kSrngtnhTN3LtbCqvmJ4=;
        b=OdXvxumvj2OX+pUsiqGAqpXLNYNskGw0ODb5oNSq8wx9ziNRGUYD/GDugZo6zpOX9O
         aycB9AzJaC9uCLZbf4cE/fjM4XBUYkzT1KGqv+JyTyNO8OXCpWc6IT4c47MD+j56eRom
         JHAzNty2QocAopWqRZ4yysSX84iUiVW0c/1awVJKcz3TxvLRZ/zrsm5fYSoA9DLt2+AM
         UdLoVJPh/C7NAd4ntGts1rWQ4ghw5ovGJa6tnLtzrZ9z47vXEI/hgrsd+vE9f/iwimjL
         tZ0UGzf2ZK6zptxtiCeihTztDHTyjhlvVKAEyiys18fLC0k7C4nuihdvD+XkLknUJwr3
         0giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709675000; x=1710279800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Intp0+6uR7/i3U9bPDDPJd3kSrngtnhTN3LtbCqvmJ4=;
        b=N8KQfy/zlq+wcSOhZdXd0NgCzu8PV+RELvAN/c3+MhYFhuJ8iNbXr0/yzWO/5yRylJ
         KIbHM+VXNkI2vADAxwa3LTGTvk9UUlZl+iR8Nw4wT7rFV5KiaQFJ3ljBa1frW/O1ibHF
         IrEF8PJsbJRcqDDQ7BV60ngAfUhemwJJE5O6zVBk/SR3/1c4RpifhtM87siNDRBWNJjW
         mBQ6xKl9oRAncC+N+qPR3yjm3MJ334tlxb4/LP+K2QWIKksxgKz7hR4YytvsNgHfJHgU
         91EIFw/cE0g7Cvpq4/MvArP25XHEOBLaxLd2oDm7vO1NVNMQxy6h6jnJ0WNtY73zGhZN
         IUGQ==
X-Gm-Message-State: AOJu0YwDOvfmCttjwrifSWRFdQXnEB/RNV2umBG1o1vDYn0AWfDj9ikl
	pN/3lE25VX5auUhNzToawIqjLTslMPrx+yDTZgi9p/uckQ9bVeL83d3aJPPlmSyzq0uygkotyA0
	J74qthPjWy0Xf6mcFixhaLOD2guw=
X-Google-Smtp-Source: AGHT+IEfiH9fau3FxuAotQU3PQeAsroeLzsl3FwX/mrjRngTPnNCL7hEEPsIG82Th6qIhFuzvAKdwQtwLXquwIIzLDg=
X-Received: by 2002:a05:6a21:3986:b0:1a1:4b26:ed1f with SMTP id
 ad6-20020a056a21398600b001a14b26ed1fmr3185905pzc.32.1709675000421; Tue, 05
 Mar 2024 13:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-15-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-15-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 13:43:08 -0800
Message-ID: <CAEf4BzZ0tkh5T4EjwHGH4v8LxzG7y_WMfbefjaU1==Kf_adgtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 14/15] bpf: allow '?' at the beginning of
 DATASEC names
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Currently kernel does not allow question marks in BTF names.
> This commit makes an exception, allowing first character of the
> DATASEC name to be a question mark.
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
>  kernel/bpf/btf.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6ff0bd1a91d5..a25fb6bce808 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -761,12 +761,13 @@ static bool btf_name_offset_valid(const struct btf =
*btf, u32 offset)
>         return offset < btf->hdr.str_len;
>  }
>
> -static bool __btf_name_char_ok(char c, bool first)
> +static bool __btf_name_char_ok(char c, bool first, bool allow_qmark)
>  {
>         if ((first ? !isalpha(c) :
>                      !isalnum(c)) &&
>             c !=3D '_' &&
> -           c !=3D '.')
> +           c !=3D '.' &&
> +           (allow_qmark && first ? c !=3D '?' : true))

ELF data section can have pretty much arbitrary characters in the
name. I don't think we should allow question mark only at the
beginning. Let's just allow any printable character, anywhere (for
DATASEC only, of course)? There is no danger in doing this, data
section name is not a variable name or some C identifier, and so won't
be used like that.

>                 return false;
>         return true;
>  }
> @@ -783,20 +784,20 @@ static const char *btf_str_by_offset(const struct b=
tf *btf, u32 offset)
>         return NULL;
>  }
>
> -static bool __btf_name_valid(const struct btf *btf, u32 offset)
> +static bool __btf_name_valid(const struct btf *btf, u32 offset, bool all=
ow_qmark)
>  {
>         /* offset must be valid */
>         const char *src =3D btf_str_by_offset(btf, offset);
>         const char *src_limit;
>
> -       if (!__btf_name_char_ok(*src, true))
> +       if (!__btf_name_char_ok(*src, true, allow_qmark))
>                 return false;
>
>         /* set a limit on identifier length */
>         src_limit =3D src + KSYM_NAME_LEN;
>         src++;
>         while (*src && src < src_limit) {
> -               if (!__btf_name_char_ok(*src, false))
> +               if (!__btf_name_char_ok(*src, false, false))
>                         return false;
>                 src++;
>         }
> @@ -806,12 +807,12 @@ static bool __btf_name_valid(const struct btf *btf,=
 u32 offset)
>
>  static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
>  {
> -       return __btf_name_valid(btf, offset);
> +       return __btf_name_valid(btf, offset, false);
>  }
>
>  static bool btf_name_valid_section(const struct btf *btf, u32 offset)
>  {
> -       return __btf_name_valid(btf, offset);
> +       return __btf_name_valid(btf, offset, true);
>  }
>
>  static const char *__btf_name_by_offset(const struct btf *btf, u32 offse=
t)
> @@ -4481,7 +4482,7 @@ static s32 btf_var_check_meta(struct btf_verifier_e=
nv *env,
>         }
>
>         if (!t->name_off ||
> -           !__btf_name_valid(env->btf, t->name_off)) {
> +           !btf_name_valid_identifier(env->btf, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> --
> 2.43.0
>
