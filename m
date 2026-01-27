Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653092264CB
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493199; cv=pass; b=hepy9zk/QGkGOui/kkX1nqu/ciznxEWHDGR/m9FkTB7OIvwXlpigUR0NBBUMMruHo7HScOVDaMXWgApYcBBhjhIKTA2JKY1EUow3bRNL6NKx2cJP3pRm/m1nD9dNItF1GFyargwDYxr2Pv8K5oQsB+5EM9ldXg+yij30i0pKvEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493199; c=relaxed/simple;
	bh=lg0tsfQDWojPjMpP22GM/dCTOrwGgQwX/QqTsEw0F5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZqgHeOw2Hwe/FBwt8taTT5zP+53dbzwXeeGxODz4lDTA+BQtGKzjQG4RoRCQFAOFCOAJOhyLdK2zJNu++TA2fDlEkE913Uy9vlv7wZTDwYUx7jJChHDRED9eb2/f0eWhfCG5fJCCyuOCr24/AjyU840hq53KhLvKgP8p0mlyZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa7CI3v5; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa7CI3v5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794719afcd4so9782027b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 21:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769493197; cv=none;
        d=google.com; s=arc-20240605;
        b=PqB1++n+utJBq/YYEJ09+0ZBR8SOsWSmhH0nhopt07yES+udD3l1YKrJE59snMdlaD
         NgpOLXKndyYvCTjIksWR/EoM9v5VIsouAC6Qo//wA/No/6cvnV0PWJssGdNBSmAM4Fhm
         xRycuuO5w3COr6cPGBjzgeepOnvyO4mAzS+IvSM+Y2eRPlz6mZASajiq33p3j7mzxW7T
         Z0bzfXbaziIG5GxEM4CsAvDutgcXlIs30pxuZNy5r8krlJgEsFyTyoLv6ZNRNX8D9d56
         V1i/6b2ZN6hlrKNsaGTcflr3/C0aRLSkhjdxWIbCUY1mxIf5SAIdqtyZNiVQwU9DM+uv
         0uDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LeDIVD1rpzqBRdVcsIFn6kXLZVWyCLZm8MCh2bZLSqk=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=hYBQ1vaG9r/a+Wp6fhPESRPqRcBlCbc79uKhzo36zJswmCnNUGoXkfqFl3j021uU4r
         GpuGIZNYb/BoUcxFkN0eqayvFyaaneZThRigZqkowj5QELWMHiC2x8bbRbtWyLuAJGwh
         sKXoEWw8mc08/mvvTwioJxe6rCDWB6G6hlJgNVEOKBRtOUx/nqeG5naUM5NUXZqbSXgC
         MWm4R/Rus2nZTEHsltBxXkj2qjUXPy6vFZHaonVp2eyTYG0EcMPkD36fPicviJ3v5XUv
         dhm6u9RUzJyYvNUGVbduv9ygS9Z5RejZi2xaNi9BEznuoBinjI4lvlIAKYOj8YPyuuNj
         PuoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769493197; x=1770097997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeDIVD1rpzqBRdVcsIFn6kXLZVWyCLZm8MCh2bZLSqk=;
        b=Oa7CI3v5ZCn1R4kgJhFqmVI6WqwjJaySuUVWzqp+8hhMhUduNW5FdCxK6misbWdoqU
         9fKm2wal12UwmTI2JG1UFq1LoE8372/4k3cvcQ8ahDO6aDY/+pLy7PihkLcYropFwzdG
         //Ian7Dj6rQWAZEcCDJLVK3f7ONCmh9DUDZobX7FUa4UeLrU4zjFDh4x9jSIRQPs56vY
         rl2Kuv6xLpGS4yrvTLcXLN2hZCIEciNy3mk0tKmXXjuh4G13K0keoIBIHBstMQrfWbvW
         hCpfw9p+hxDpZvvMX10LMP6162KmqT1rmkUcAPy2vHZRYqbP0Fvm2Sg+lWaWvBdN7/eD
         2FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769493197; x=1770097997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeDIVD1rpzqBRdVcsIFn6kXLZVWyCLZm8MCh2bZLSqk=;
        b=N5YYpv1D2yGj1MKwqAISGxV2iFqHE6kjy2Qlu0k+Z8BBzLRTqU1ymVuJ6V/ncNIpiv
         0CIoSNIHNk/oEgPcLkhOMoqXiisiX8rtV/kgh8NCGCFtgk2o2g9c7x5qlwdfCSOm1sbw
         5crB2NxLF0x1yGhA0/Bs3nYZcW+OZzV2A7I/kKBJGqdljiyC27mOh52+ObC4JQOLe1G4
         Sg0cLqEBeCB8PR+DDfmL8iO8tZT2vofAtE2kyPiPoxbsEweWjMLcvNq1ve8C++fXLE4P
         +7RDqOLTEmAoRG+M+8QNzDD02SWarpgF0CWb4ARE8tRuxzS7DatNSIh9HavKgWonlEJj
         Ccgw==
X-Gm-Message-State: AOJu0YxkUMGv5v+hiIIAIEFRwDoqhKoh0BxkxeR1IrE+y6dVjYNnmQfH
	kCKu6KG1hIWCXNtQYNxzToGvu8K7ggGfXYMROPhUq7X3dJVd/LpFLAaky+QRneSRSvsKTUuxfc/
	xunoSaKtqGOjhEFZYT8SyL24tdvHp+Gk=
X-Gm-Gg: AZuq6aLCvhXYqW0s2xLDnQOsrwgRgB831xBpfo6ZfG2Jq+/Bz9g311z2zI8jApnEnMY
	b6WSvls2gl6g9pOPmxgjDTFzIYP5Ft8dCv8tP3HIOfLirk0N/y6D/4eqOzVbXy+K2XePtdMuAoV
	8x9GZgYhrOdQzHBzhfUcUBe+hQCoIxhF3MxY6gypnGfUuROpm+ebAKtMbJzq6T2C4Wvap6YziBv
	QQ7PxNsvkCkl1qDBqPIGu0AL1wPb5nGIHly04q9mcMLg7i30/1Gwml95sRRXqRbjUhOA2s4
X-Received: by 2002:a05:690c:6b03:b0:794:722c:3a6a with SMTP id
 00721157ae682-7947ac7f221mr3895447b3.51.1769493197439; Mon, 26 Jan 2026
 21:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-4-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-4-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Jan 2026 13:52:41 +0800
X-Gm-Features: AZwV_Qjf35hHKQUxt2WbxyqXXiuhYl-WXoFHvpi_hheh4V1RgfaGbVlbUXeOUQE
Message-ID: <CALOAHbDSYceqjsWLOO9mD5gkzrO=jnxgiRL7pcSuYjLP8Nq-9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/17] libbpf: fix return value on memory
 allocation failure
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:53=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> bpf_map__attach_struct_ops() returns -EINVAL instead of -ENOMEM
> on the memory allocation failure. Fix it.
>
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..46d2762f5993 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13480,7 +13480,7 @@ struct bpf_link *bpf_map__attach_struct_ops(const=
 struct bpf_map *map)
>
>         link =3D calloc(1, sizeof(*link));
>         if (!link)
> -               return libbpf_err_ptr(-EINVAL);
> +               return libbpf_err_ptr(-ENOMEM);
>
>         /* kern_vdata should be prepared during the loading phase. */
>         err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vda=
ta, 0);
> --
> 2.52.0
>
>


--=20
Regards
Yafang
