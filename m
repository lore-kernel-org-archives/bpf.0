Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339186FBD
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687931; cv=none; b=gBWjozdrn0BCszIgpU44tqs3IItXJLJ+GxDIOYQdxZuQ9fVwFJla5KmSXcj99/+2499tj/1NUQFiz9mGcQ6HEZnTuIo5EzXkx++HEBAg9Hv8DA0Cho0IzTGbYPf2sAgPFw7O5noh0Hcos8tbr15GGmt25y/s700z6MmhKc/v4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687931; c=relaxed/simple;
	bh=qqPCRgJKweKwg7gdkuIEyiqjihuHPsU9Rm7PaKT9jXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjxI1NPNUJoSLWgeT/FDd+05TlOBhoZ2rBA13E6aQ510GRb2OpqL3Tg9vgX2m14jhpt2j3X/o0nhsLwSu26m+V8ak4UXsnRlIUKIwqiCNxY9MmOz/AzjwQoluHQ+DoGIezkHjVkzmIO3H3u+jOaa39904NPYvBZu93LKrEHluIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+mH+bZb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+mH+bZb"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51340e89df1so3769927e87.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709687928; x=1710292728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uyv0RLTnkU2mtnD9B8wXgr2MTy/p7zHrZYtb9LS/BaM=;
        b=h+mH+bZbECgEFWiOCiyLaPIYDY5XqMmwTFv4g0HbHYebs9x6RhcsVGziv/WICEJGPo
         PsJxxmbBPn/HrxIhEe1PXT3FKMvB+XvIljXZLdZK5XuEQDZBAiuQDwWq1G7eKoSGwnXy
         Ecl9kVrFV/mxFE5+348ncl6EeGW4vjPmeA0VDQ/Q+iI1SAQkxnSJEDrdQq8Enf52fH+H
         TmPzdajPQ+Kv6pWzOABrVCOLQIyhBU/1CPgMuY13hM7R/WZcXliJE1D6KQ0GxGjq4vhs
         TcOsa2KhB0QpZ2SHuAKB/weQSZyX5/rFi0fdedkmaXWLZxYmtvw/8WaAKkhVeCD9mDYR
         pumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687928; x=1710292728;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyv0RLTnkU2mtnD9B8wXgr2MTy/p7zHrZYtb9LS/BaM=;
        b=fmlcv0cMhWr/2WHxoPEQkI3Nuf8PMh0xbj6trMTAYlm4hIRcHT84GLuBt9yI7ST1lN
         9aXdqJX27KsgiHNA/b6m+lmLBvgll5lZ3GTJdNBvAxCZb0pMPts2LN2O0DOFFY/NB6Df
         Dvh2uEMnLI4EIQ8sbXKgnjDzue86q0QWBZ9ycM1XRbdxx9v9+gC39OWqhvQ1svtpXJcY
         cMtEr2lRJDR5xUSLbGjrYef+G50qVvzf40B5VKK1GMLXrWzASvC2WA0vZGZNtwmg0Hhz
         6TVya6qFKm2KCL71OTBBrtCwBdpik5Jr8kZzIDQocnefworYPJm1pyx/UeOd8J+5UTSr
         Iz7w==
X-Gm-Message-State: AOJu0YyMJGw4IvaluhYNaYkZ5YVTcO5fzDhcPEQmgvsOuiBHa0hxokAE
	UjTNCtz0OqSipdHmAX0z3HKCLbdZg0EWjeg7UtDUM8H8p8GkUvla
X-Google-Smtp-Source: AGHT+IG3tXCYA679vNTTKt8AxviTX2uXdF39kgm+TDIalw2O6fOKC4bQfBB6K/NdRpbdoLINtdxA1g==
X-Received: by 2002:ac2:5f49:0:b0:513:37a1:ae60 with SMTP id 9-20020ac25f49000000b0051337a1ae60mr2030835lfz.34.1709687928011;
        Tue, 05 Mar 2024 17:18:48 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906445400b00a44e3c8423dsm4317643ejp.24.2024.03.05.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 17:18:47 -0800 (PST)
Message-ID: <9f7b80ce5e10f18d4ab43868dbae5e8b0aaca14b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] libbpf: struct_ops in
 SEC("?.struct_ops") and SEC("?.struct_ops.link")
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 03:18:46 +0200
In-Reply-To: <CAEf4BzY6FokZYmNgGh=q5+icLxJ2p5Z9S6UxTC2AdJ4qz6==mA@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-12-eddyz87@gmail.com>
	 <CAEf4BzY6FokZYmNgGh=q5+icLxJ2p5Z9S6UxTC2AdJ4qz6==mA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:55 -0800, Andrii Nakryiko wrote:
[...]

> > @@ -3688,7 +3699,9 @@ static int bpf_object__elf_collect(struct bpf_obj=
ect *obj)
> >                                 sec_desc->shdr =3D sh;
> >                                 sec_desc->data =3D data;
> >                         } else if (strcmp(name, STRUCT_OPS_SEC) =3D=3D =
0 ||
> > -                                  strcmp(name, STRUCT_OPS_LINK_SEC) =
=3D=3D 0) {
> > +                                  strcmp(name, STRUCT_OPS_LINK_SEC) =
=3D=3D 0 ||
> > +                                  strcmp(name, OPT_STRUCT_OPS_SEC) =3D=
=3D 0 ||
> > +                                  strcmp(name, OPT_STRUCT_OPS_LINK_SEC=
) =3D=3D 0) {
>=20
> I'd do just
>=20
> strcmp(name, "?" STRUCT_OPS_SEC) =3D=3D 0 ||
> strcmp(name, "?" STRUCT_OPS_LINK_SEC) =3D=3D 0 ||

This is better, thank you.
