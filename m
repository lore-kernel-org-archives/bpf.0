Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1A248873
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929728; cv=pass; b=haC7kzThhspSL5zQEbFU8giV+krAr9jWHl4s8E2MAXY8Zb0DfzHvPOGiqBQMUYF+HxllS0EF07NVISOp81xqtD9Qy708626wEreJ4jRGiBlyZlltxf95cjB+OG4Bmwd2gMpktwo8sbmUnG6Rk6U6K73foj80F/wOiM27tN9N3TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929728; c=relaxed/simple;
	bh=7nSzcLTzrsVem0dCJXM85ZkctaHDk9+vQYaJP8p15O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqc6vjZVUP75MnzYA19B2a7ugX6a6cpAf8SGvrDog5KYMYhZzLi+ajPjtspQvImbwM3mOhbHLvf3Yq8t+NZg79fiGRbxXazb0KXfTsObK4EU3GHtTLPEhs0+mm6XToKsFOOb6AXapwGXAWHelivzftDvTT84X0H6Mh8bA+UYYIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po/CBtg1; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po/CBtg1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37defb2f231so491326a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782929726; cv=none;
        d=google.com; s=arc-20260327;
        b=E1RubHp2tDmP9wEMGjuVlzddJ6OCc10QRqEQt/wk0/hJvUtJqnYnzEaFmA9xW6EFRO
         bMmOHzscrzjh4wSM1G/AdPtXz8vxWQeY8ad9SAQ7LCJZMx/kd59mE7PIQ6yYyQjR1x/v
         g5Dzt4tTLl6SEAefXXk/UeUPGGAC3lmmttp9Wr9OdgeWCLVTiwwDsU3I613LVUA1pVfg
         jVsoeTDmN/KvPtl4mnfvmrahiZyed8XX2ZFaL2c1g3gMRZ2vSkDfIAdLhbPx+MgFyJic
         I9gfDeG1iD3IzTTUwItUGw47nRAnC+JbzARw9sWoR7pnUgVmsvKppGLgJGzKP5ByvVil
         UYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q1nKV/KkJQB92AXXYWGqyaPHuI72ASXANxWmG9I4gh4=;
        fh=SHcJ46kg5u7NVf8n5txIU5o7h8agRqssbFx66mDs6pc=;
        b=oG24OTKfmZDODT+yIsqN38y6smvIrahZY5wTt0VbSujIxJLR+8PAxJ9kSLFGds5x8e
         t8ZKwCc6YMGxWXh3R+yEwOjlW3nG5GAyPyfP8yFj8vS6gHFM14ZIVSxTkdwPUgEMcnen
         HbCjtP+ObZe+TPb0+1lcpUXHyHzskLFYL4qmU6wV4CD8Tp7w6bqst8G/8e4Yd2Pnrdou
         lt9GlpQm7I8GYKTiPWjT0BRLYb7oM4uLPrONE0tC3SMcSkfrdVhuBYR//R8rdD/umkIr
         rbUzukkU1rgljmX9CkxAj2qhzA3pAiypHS8U0/p6fVcu72wM0OwUFHdZ/lJEGOJd/BJN
         01eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782929726; x=1783534526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1nKV/KkJQB92AXXYWGqyaPHuI72ASXANxWmG9I4gh4=;
        b=po/CBtg1ulBZbRoJsnJWrRayLQiSwmBmfRnh5tvsOcEnnrYxcEJp4PmN/zzaFz9r9i
         hRKmWj5RFIi4u8VTP2Ivj2UP4RCghxclRVPJObfztE7y2O92S9xseU5PBfw0ksfT1w53
         w6qlxE2WX0OQuWVUNzi1UliZaTaiasp+dXYVAmz1WjhloxQ0Eh/EH9u92U6I9sigqSOT
         SDnlAz/39iQN/c80seIDr3V+8s378nT0c/2OI5CwZw1BqKQ9a/jAKHYEVjMQ60jGDtIp
         SdgZdkGD1S9MqyD8wa70n7eEMe/1K8+Q4EoCDZdURZlojKKKEPd4Uk4yH5XU+1zY3BPf
         dzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782929726; x=1783534526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1nKV/KkJQB92AXXYWGqyaPHuI72ASXANxWmG9I4gh4=;
        b=PFCw/QfEeD/R6i1m565gWtJ0hVGBCw7ZEIzjaeLJzH9PoBmVb8L4+wZsRfGn4JCRoV
         Vg/h7xdfy7dgqH9LaoowrSUOL5VrmFFcBjONVPmcxEK9W+K7rm45kJl3YgbQVaa8/S6k
         UtcTiaH6O3T4UzUxJKXzq2oI69A+iIxidCqvR039g/6eyHOQy5tPKx1avUVZ0w1JHafQ
         YYkrMAkAaNIStKsam47viaia5auTQDogvjq6gBbMudbqQXhPSeCeHvjlkOXSz5w+pcBu
         f8kg3b5haTmrv8v5l9w5HdjfCTSG4/XbFeNRyU8HmmuEsxonZWqcUERP86V1mJNR6Qlx
         6CjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfGdjDsqLLtsEkwlCWge+s0wXAXDVhqgTlMEcZPJ4QxeJAl/FbJOrU1PxR8HNyX31p9+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzOa4ORIJ6pcxCp+MVv1Ls19ou20pmIzl3uxkumj1H0ylUZAt
	S2soz0VoBNq8GBxK55eh97G9qkWPhlLwedAHb5+7XZ1Ri8RafbSsyCes519HdMj7lyM7ypn4TZp
	snam8vE/2e6yo4lercydkmrgz+j3M8LE=
X-Gm-Gg: AfdE7cmAsMHEYrNxOK2HINMtzJAIkdpwrJmeRNhHyVGNS7RqoYnuEiYlkMeVYFx0J5E
	6SpN/gVWJrAvlqjMPPm+eUTjtduIVpUQjNL+Yqqe6mudZYdxrMLDZp8ZIj7gG011kGa+UkNW2Lr
	SuUx6T93aH7axdX8jWoqJ+JQsYnWlrT7wf26c510fHxmQOnYnwttkDFzqKGknyx/4Oyh+P3UK2b
	J1sm6H2zuG5rd7EQ9oimI6dDW7SZa+2mQ9VT/K4myjIS2THCwD23ra0jnAycvJXfVQkK5SqD5qr
	8RKd1KdwrWw3D7ClErQe6s8U81ldfaHiYyIDUzwrw+XkDd1in0rdRg==
X-Received: by 2002:a17:90b:390b:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-380aa0ac578mr2648449a91.2.1782929726253; Wed, 01 Jul 2026
 11:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630205418.3483969-1-andrii@kernel.org> <77ea35c8-2a06-41f0-b808-9743dbd3ea51@kernel.org>
In-Reply-To: <77ea35c8-2a06-41f0-b808-9743dbd3ea51@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 11:15:14 -0700
X-Gm-Features: AVVi8CfMz6aP6_OfKBuah_J2LzOonBm72rUquS9BZifApLTrxTdaY_N231KDMpg
Message-ID: <CAEf4BzaDjuLTsoTFXpPMp33KbKHvXkDv0Gwf2T=JVQBqGgZ+5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from
 bootstrap libbpf build
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:54=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2026-06-30 13:54 UTC-0700 ~ Andrii Nakryiko <andrii@kernel.org>
> > Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> > started building the bootstrap libbpf with HOST_CFLAGS, stripping the
> > warning options that are unsuitable for that build by filtering out
> > -W -Wall -Wextra -Wformat -Wformat-signedness.
> >
> > HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
> > and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter being
> > what actually enables -Wformat), but leaves those two -Wformat-* childr=
en
> > in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it then
> > warns:
> >
> >   cc1: warning: '-Wformat-y2k' ignored without '-Wformat'
> >   cc1: warning: '-Wformat-security' ignored without '-Wformat'
> >
> > The warning is easy to miss in an in-tree build: tools/lib/bpf/Makefile
> > re-adds -Wall via "override CFLAGS +=3D -Wall", which re-enables -Wform=
at
> > for the libbpf objects, so only libbpf's feature-detection probe (which
> > uses the passed CFLAGS verbatim) leaks the two warnings. The standalone
> > libbpf Makefile (github.com/libbpf/libbpf, used by the bpftool mirror)
> > instead uses "CFLAGS ?=3D ... -Wall", which the passed-in CFLAGS overri=
des,
> > so -Wall is never re-added and every bootstrap object warns.
> >
> > Use a -Wformat% wildcard in the filter-out so the orphaned children are
> > removed together with the parent.
> >
> > Fixes: 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> Looks good, thank you.
>
> Acked-by: Quentin Monnet <qmo@kernel.org>

thanks, applied to bpf-next, please do another bpftool sync when you
get a chance
