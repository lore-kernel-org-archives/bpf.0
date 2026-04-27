Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD631F98B
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302073; cv=pass; b=EQ9EDva8D66Oq77d4wJYUg4qW3yP93kJKBMNIKDcwMY4UklWWXYJuYJoG54MVW47qcQL7yDscwttWhN/dtiRyDoVS1uHvoHrOpSY8voDrgfYsgmKENojd5jXgRfkCi2Y0UP0xzsbFAY3XT6agq1WgtQCyXHWv8YXCuR38BQoc3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302073; c=relaxed/simple;
	bh=rcQT7/KShC9VR0GIxi4YEYDYfvyBuPQTsb2a6WjuRoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxGGOkuKvab+X6aSglyRgmp97MF8y3G5VqLMfoTEkLdbERWp5jqZ1zVW2IBn/qah8135Zga8wa0tJMc/OOfl+nRtIu9knmwrneWpr+Cgw/KUrYxllA9RUHVcYGamGOei9VgL3dYTpeoOTNu4kM5mhlmKMB4D4Oaz1XfPJqX4HZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDsBbXrT; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDsBbXrT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso76511265e9.0
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 08:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302071; cv=none;
        d=google.com; s=arc-20240605;
        b=KNFu3FWjkgL35viNojd0HZwSEtJhy+PooC8bevWDajEsmz+Pl1w51hF5kZvkc5Exee
         NBUfGJMu0kzog8gjQp4ltD5W+y0RfTfQkfFaAcNwmnyJnxoKUG7dy7Ax/n9auQ0xn4g5
         KelOqq0A7BDKcH987X9nKZMKUXkyFAmVb0jALKsHxhPlBL4dTH2ZRNbg5oMJICcc4ulA
         MV38+kQSYhA+Taj/xMBz2Kg5esLKXonzy+QughszsN2mE56cw/a27s90d2luW4TocMB4
         zGoSewxkVSelyu47ca7KOMQjIrOtOox7nq3xg8ce7p6Negkfk/X8/ZlKj18Sz+Is5TJf
         4FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        fh=wzHvF+Zeff6CSuJW5RAKCvcuhhBwS8oWsZoFV5g50a8=;
        b=Vi2z7Gi81F/ZC9Qsw8dTrehbHJh0Ott6BqDBRM2SnuWeiUWFIzRb8j99vzkne8cQUg
         uXIr1TRQLih/BnfR4tezUUlLmqcQCX5e1fLroWK8gLIgTI1TeW/1fowv+qU5DPoZ7ULJ
         +F4aK6/RjykDRFD3z2O/TOxq9e4ojvs8heQ7N80+UyHWS/J3kbO142vieJCzGYZXXfCl
         2KQNDOdHm00HtRDAWDv+796WVGxTaoi1JW0jah7tkCJqU481CVx8puUC04bPexagOqqh
         6arYXryRrVeKb4cXixPlFkpsq64IGg/YqrJJBnAacQ0FGD5C11maBlcAZAxzAvuELC/p
         Z+Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777302071; x=1777906871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        b=KDsBbXrTU/sDYCclNKcvEKSRAoNylE4DU1o9lAz3dubZe9XdYhHeep4cMGOjyZL6nA
         jIhwYMHVEOZ6AWjk1C41nyaM/rBW19UqlYGnjVY2a7T+kkE7sTW2YbdxgplcmohIAkWz
         +nd3IGJGraEWRAmQIFE/aa4LFZP4M2nK2CBrEfaTjcKOGEj4BXv4oB6GeAVwGG+6e/4L
         sJiGX7bWpEWo+pECMw1s3Vu+dHmwFJLNsMUQblMNvO99SI2zDHzwbbaDSgzZmVc9OPyF
         5RH3zy+UDodOf3O0+LhM9/q+FO/2EfQSkgxhBvSMVEQMeG4qMys3xtj2O5dLUI7ICvcq
         zeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302071; x=1777906871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        b=deCNZTrBVmUDN34dls+1xuS7cOiLioJBC15L2HIVSTEB0pNrMKMVOOOFjl5l3gWcr0
         BGJV+kzNXnE/rFndBydsx3sJ23yzU0xLjXpMTVa8dUWyiS/KoUpszfP/vNMANavIQA5c
         PwEfdm87xQsta3Gu4SXqO1mYu8A+RuQ6a/jSWaLZhcDEUso37nh0xfQ5vjdWGYQYU5cy
         KZi9ab5mjRg6BpcqHXNTW5Uwv7suXLM/QrbOwfReCaiA9rVeYxvC5oPMauki/rqOd85C
         KX9/iHd1evEJhtL4wCG6nWo0G/6DqwQjzky8E0ra3UtLwUYqmXU/jnxm0RGOVpwSa8n0
         DPWg==
X-Forwarded-Encrypted: i=1; AFNElJ/ESDm2Wc9I/1EDxcC6foJa2uM7d7TTuz/MdrjY1AbaisIEqTaqbNv86v0/XrCNFcMCuT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1U4973JCHaZI/KZQoecpwr7mpkGaC6wLw46/fh/leyPsLiApa
	9KnbB0K6r4WQlVuGu+4GAlFBvuDD8/exQZK8IMPmena5uLfG5xqLg80+n/Ml3+ex6Sfgl2ar6rF
	fyCphSWOYeDTpq8lq58kbHL7NN4PJswo=
X-Gm-Gg: AeBDiesvTk90BhiQm/ig/2DIKZvHAESIE5Dq54/86qcoAUVL2Ol47vo0NGGnw7Bvtvh
	BUiZ0w4l0wJcUWC+eTZAcJUMVFWesq8BkY5WOICKNbugacZ2UlqHUape4doS/zaNuQcFjM5zNBI
	DjThv0RKtGxjIKoMEb2n6oB7GiGTXv4fiAzA3KxwcYe2XszQcw6OG8vSDGK4ZiiK5NvkMekioxH
	s5nqHEMHkqoGLbhvpaI+FuXw5uGRPqsbb40Mioug4x+y3y15fAai3nGSex//hU/YZjCUtR3bZgX
	pJtuGiNF3ieJ6L2pTY3aCcyl8gHrUH9kEo/7xaWA+plgQswNzECdR+8WQVbwENM3tfOffU6hC/u
	+dGs=
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr423287055e9.19.1777302070487; Mon, 27 Apr 2026
 08:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
In-Reply-To: <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 16:00:59 +0100
X-Gm-Features: AVHnY4IasoXaoqIWZAdmFU7XS_Idge0ITPUKZpISd1rL0jATf9af3D4zNm_fFNY
Message-ID: <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 1:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Apr 2026 13:43:15 +0200 "David Hildenbrand (Arm)" <david@kerne=
l.org> wrote:
>
> > Pages that BPF arena code maps are allocated through
> > bpf_map_alloc_pages(), which does not allocate folios but pages.
> >
> > In the future, pages will not have a mapcount, only folios will.
> > Converting the code to use folios and rely on folio_mapped() sounds lik=
e
> > the wrong approach.
> >
> > Should BPF arena code allocate folios and use folio_mapped() here?

no

> But
> > likely we would not want to use folios here longterm, as we don't reall=
y
> > need folio information.

exactly

> > Hard to tell. But in the meantime, we can simply use the page refcount
> > instead, as a heuristic whether the page might be mapped to user space
> > and we would want to try zapping it, so we can get rid of page_mapped()=
.
> >
> > Page allocation will give us a page with a refcount of 1. Any user spac=
e
> > mapping adds a page reference. While there can be references from other
> > subsystems (e.g., GUP), in the common case for this test here relying o=
n
> > the page count is good enough.

makes sense to me.

> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> >  kernel/bpf/arena.c | 2 +-
>
> BPF maintainers will probably want to carry this in the BPF tree.
> That's fine - please go ahead and add it.  I'll carry a duplicate in
> mm.git so it compiles.

We cannot carry the same patch in 2 trees.
Sooner or later it will create problems for linux-next
and issues during merge window if more changes
are done in the same area.
The only way to share a patch between trees is to
create a stable branch and pull it into 2 trees
then sha will be the same,
but mm tree has its own way of doing things,
so this patch needs to stay in mm only and if no one
should be touching adjacent lines :(
