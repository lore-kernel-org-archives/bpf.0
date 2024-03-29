Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5513C9AF
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749685; cv=none; b=G074atiGG1ukviPjbA03BlQ/C+b5Z7HkGj4PJYgx7cpLloejSS72fOHhpdvewj2ZhJa36aSPYMv5oqfZvREacnzkLg5qYrTgs1Cn3k6fckgb8n+fD3zJLYcSuAR/y0gvFMir1KqT6F8IGY1Xd6DAIVYvBcZynpc8qE6LqZ/kXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749685; c=relaxed/simple;
	bh=7yp+GfJkUVyfQWb1v0nYSA4qyI2wVytYT7c0mac9+6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btvAXrrBTSKDHNdJ89tSrxDJE24yZN/umQgEHfeQhgeYMahEISvcJ9gV96wDxBtBwzniXFylBmG/Z8jqEP756Fpgtyy8oCVKbY0kprSo7d2iWuUXTvOMKWHF6jAEINQvA9sUA0BK2AGA5GQqhwHXKT5ufwE7v434e4sSbNhUuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAUXWuIy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAUXWuIy"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4a387ff7acso292581466b.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749682; x=1712354482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM17T8yif91gEGVp6nPkERQV9c4hunLcQJVV8VLCjtY=;
        b=OAUXWuIyzoIpp9XxHw8VIAJ9pIbZhsJr+9uAbwncedX/t9/jhEHk7rjtJ3egJk6Tw6
         ruaSUgiXC0IlNSuW2JgUORAmmvWxrPUmlIqk2KDcSchbN1m2jto1UHQfZnnI9pM7YYss
         T2l3KNLdd4CSdIagmGVxL1lmzs47CiUdaFDALKR3G4RRaLV3B6mtrdHr7hbUb2OeRiBO
         QrjpMtIoACajcFhwIiYUin7Dp1f1Z3l+UdhHTxDcLSAdQZCPlLIjl7XedSdj/X+dkt2t
         YG/2t1/lwDE440LQHjKUiEwZ3jboUEY02Lc/Xmx9JWcMZ9VsfhJJiP/f0i2tmONPiK1V
         oaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749682; x=1712354482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM17T8yif91gEGVp6nPkERQV9c4hunLcQJVV8VLCjtY=;
        b=oDukCa4x5krNmByhufMSw6rECcniooQBDsO01eWFAb84Z58Snp37dFGcunY1fOsS91
         moRYPDrlrmlrHGNbOAzNqsv+enxZ4P5UaTifFj1DP3vwhy/aHLkQ+65X71O/zgPc7gJp
         RRQL15n+zNHlpv44GeD100d9jDBRcoyaOd3wn4oX8D1Wd03Exc5NGiuf2MqjwGS89zgi
         E+ylmRMkdUKWTVHCf0phItjIKHVih1QZCkWhaGe3naJ0ZX74zJf2qlKcXJFdeM55YvP8
         WWPqa+KvQdvK5nxRkkmUfIY1IHb2UqgHgtrDdtvQ0FfqMpw8cUeTFLirTkNrB6k/ixY0
         gaTg==
X-Forwarded-Encrypted: i=1; AJvYcCWT9lG8dKszdFLfXQ5HXkOdhracShdX8l4U2ArGJSR0INrVT3GnQwdXRckhE25bibawjQfz4dZDf5A4adyt/dQp1/7Z
X-Gm-Message-State: AOJu0Yym1d1xOd03q+wa0WLY745U0FCFUxcGM9R8j+nKfTNLbkSz/kMT
	f/6KY2fbAs7rgD/0wMCF61N+xzDramctxi1dwu6Y+le/MmxdwA/4Altu9ih7ETFJ/W5dwWDAwh3
	ipfn+O9fT4W7EHyrYjeAvoGd54a8=
X-Google-Smtp-Source: AGHT+IFygwz6rtdkvE7cNOrrq3Xd28MoILqUqYxjczeNqp3tIBq5gHAA0zmLEqc9TbXtUMiPgotV28nNmPzu7nua1gY=
X-Received: by 2002:a17:907:972a:b0:a46:575c:a9a2 with SMTP id
 jg42-20020a170907972a00b00a46575ca9a2mr2836746ejc.45.1711749681974; Fri, 29
 Mar 2024 15:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-8-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:01:02 -0700
Message-ID: <CAEf4Bzag6ZteES3JKvXZK-SJ2GkUwo+31Aq==bPXMi=hknmg8g@mail.gmail.com>
Subject: Re: [RFC bpf-next 06/13] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
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
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..9694ca3c5252 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     +=
=3D --btf_gen_floats
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
>
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> -
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized
>
> +# Switch to using --btf_features for v1.26 and later.
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       =3D -j --btf_feat=
ures=3Dencode_force,var,float,emum64,decl_tag,type_tag,optimized_func,consi=
stent_func

typo: enum64


> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> +
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> --
> 2.39.3
>
