Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101683D0C4
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749611; cv=none; b=Cl1dB8xRq38M4/00MWcJrbcMdh0AJ7Y+Cf6m/c8PCVVTKRm2ZCafFgHdFNx8aYRtRFdZK1Clp5oHqOKsWyRPMmw10kygYj9YYstyZHxvjy48CulgSSlrRC9pRG4jFX+VIQvMmT4xoa5hvYRTYkpZFbY788ekFNjxzjxgwG886Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749611; c=relaxed/simple;
	bh=pR6QTHaLQRPpv8HHpTHBgdRM7+Ir7ETa/5eOrBEwZUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0dbn4KGaAXQvsxYLoBWOkz5f0FjmNQvfpbhWzN4pzTx0d1Dd6LuiMMIalg7QV+fZUOa6jQ3c9cnXBB8f3+/ewfOt3Ly1lsCLwFFt9kurANJEZACXwMh+nsqVMODBPzSz+e4viqV5IChHKgV0GEPabWVJc7/TQCh4DbGFmKTcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8OX9LOe; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8OX9LOe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso1633583a91.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749609; x=1712354409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvV2fYO6oE+qJ8+9n7NnfZbzi5Pg23zvcOCfwlrguBk=;
        b=F8OX9LOedGYw4IzMIWXd4NEtitN2xQETmd0q5/sQ03U+3Tz80RKxQ+NZFCkXb8Z2BG
         Gdf1DJhjML9PUMGPDIuTFtDKUZEjyMeCCDpTPD4tG/edhnAOv3yh+Cfzehj/K8ijgbbh
         542Um9uLXXnaE3l4Fi6qj0FtcbLZOlPl3zJJW8sqoemRa59fGKSyePtW9krImZR8jX8Q
         BjmZXdh3FoHCNU/GtMuyVvU6KTWJ+ojnxADKy3etk/QVqh2DwRKHTg4ulnrZCBxl7nKf
         O/UdY7SouHdTMqygQ3QOxMvuo/DCNfk1LOTMv6eeh/l4gdKV6DgwsfbDe3YAFP2va3Mi
         Vn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749609; x=1712354409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvV2fYO6oE+qJ8+9n7NnfZbzi5Pg23zvcOCfwlrguBk=;
        b=rZ6lGYhE4Xf75MY+o2Dv2jUQbsqng/d0xWyk0oHKTwZ3B+XN/asf5DCPvd6rAE6HZN
         /WpevmLopxKmea2Ib21Rk3fWnt1s93MslyD6bxeFhMnuXTl/uxrK/W7Al8bZ2cJ+GCsJ
         IHNeGWLZ2oAq9fId4oGH1ZSOq3t/5gQh+qjRWBOgzJz9UosH6psvB2d/XN27oiE2ced/
         58Gr9CVU+HQ6bdIjlNraSEZa0o+W0KDsvDeUw6gniklJN6F/6Iurbs9tAs8t8dste0Lf
         5WfQY1U5rmMU6gQHeLdxC/kHZ94Dtv479V1PFBy1GvIihgXSDETJtOtWz4F+pcw6CGoX
         aOdw==
X-Forwarded-Encrypted: i=1; AJvYcCVArsoGPug3mpqceEgzw/dq4rlSq2QnWIvEAREVHlpqBGjEGPDiHkbyLtmXbfGxRG4a+bWnNvbzaMDOek/NYZ/zhxeR
X-Gm-Message-State: AOJu0YxXqPuMwTTCD2d8KC1gqVid++lU8u8BL+8ZOzVMvKLjHKw8y37a
	SxKRrBcFW+TZAHgRyW7PfDl4bwMdyU89ecvBg0FSuAGaUoTjorVN9GKOihUFYICWJiBOMFXRbLI
	z7Df7Qc24REmH0oi4qMWzXFbb81w=
X-Google-Smtp-Source: AGHT+IEyOnmVgCnQG2eex+E/qBRr8ZyRe6jiGW1jEwaDVFkPMsBix8rs+oUc7tCTSH8IkXknfdXUvH5Mijmkmu7tMfg=
X-Received: by 2002:a17:90b:30c6:b0:2a1:fbdd:4219 with SMTP id
 hi6-20020a17090b30c600b002a1fbdd4219mr8899420pjb.2.1711749608453; Fri, 29 Mar
 2024 15:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-3-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 14:59:54 -0700
Message-ID: <CAEf4BzYX84vG1J2EPO_pBhfydbPf4kiFO7YcQ+h7a3eNUz1vnA@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/13] libbpf: add support to btf__add_fwd() for ENUM64
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Forward declaration of BTF_KIND_ENUM64 is added by supporting BTF_FWD_ENU=
M64
> as an enumerated value for btf_fwd_kind; an ENUM64 forward is an 8-byte
> signed enum64 with no values.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 7 ++++++-
>  tools/lib/bpf/btf.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..dcff6c29c851 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2418,7 +2418,7 @@ int btf__add_enum64_value(struct btf *btf, const ch=
ar *name, __u64 value)
>   * Append new BTF_KIND_FWD type with:
>   *   - *name*, non-empty/non-NULL name;
>   *   - *fwd_kind*, kind of forward declaration, one of BTF_FWD_STRUCT,
> - *     BTF_FWD_UNION, or BTF_FWD_ENUM;
> + *     BTF_FWD_UNION, BTF_FWD_ENUM or BTF_FWD_ENUM64;
>   * Returns:
>   *   - >0, type ID of newly added BTF type;
>   *   - <0, on error.
> @@ -2446,6 +2446,11 @@ int btf__add_fwd(struct btf *btf, const char *name=
, enum btf_fwd_kind fwd_kind)
>                  * values; we also assume a standard 4-byte size for it
>                  */
>                 return btf__add_enum(btf, name, sizeof(int));
> +       case BTF_FWD_ENUM64:
> +               /* enum64 forward is similarly just an enum64 with no enu=
m
> +                * values; assume 8 byte size, signed.
> +                */
> +               return btf__add_enum64(btf, name, 8, true);

nit: let's do sizeof(__u64) to keep it consistent with the FWD_ENUM case


>         default:
>                 return libbpf_err(-EINVAL);
>         }
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d91c84..47d3e00b25c7 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -194,6 +194,7 @@ enum btf_fwd_kind {
>         BTF_FWD_STRUCT =3D 0,
>         BTF_FWD_UNION =3D 1,
>         BTF_FWD_ENUM =3D 2,
> +       BTF_FWD_ENUM64 =3D 3,
>  };
>
>  LIBBPF_API int btf__add_fwd(struct btf *btf, const char *name, enum btf_=
fwd_kind fwd_kind);
> --
> 2.39.3
>
