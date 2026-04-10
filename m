Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280B33C1B7
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861429; cv=pass; b=ZmiOzNtzm7MP/nYGF370TMOxUsH5biw8qsp/PkmBE2ZcTyp0UvmijmWm8Oj8d4r0aQav+49qP2hvcMUhEE7+Vts1ql4Ko0atpl0ihAHM9iDzUj6uT7fSJjdG0H70u6EmsiZ8dTiCLkKvylh30eHij2DkBkKNvx8E+auWMnPnxJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861429; c=relaxed/simple;
	bh=M74ioG4lJtyheEColDy9jqyGf8j7LT0pBdxo2BvH/jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLklAWtgWZW7X5MqfJAc4EFicFM5exuyKrerREDcx6EgO2Avw/OhW1A/Ads/6jtjBiVFX26I5+lbQW4/5TKsffTd4EsNfLSMIEQvltHPAlHj6vOjSVSoi9aa8XygWPj+KGljenW2FSj0Xw7OGLKW6rluvKN1sT6KcVcQNpCnaPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaMC1Rzs; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaMC1Rzs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso25017895e9.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775861426; cv=none;
        d=google.com; s=arc-20240605;
        b=L90/YHll4hCc+C0DvgwEU5XHrb+Xoa7ktPMgl1IIO3Hn7aUHC0EAh3ElIO63+UrvVc
         EszqGvHPQbaTyNwfSU73sIithbBbc5Pdji7ncrEsz0oZAeKbF9AvfK/PGjw5F1PRl4KK
         QjQNhd/mz6A2k+1xn7QlW0y4Bapx40U5AeclOclTKBXNKgL6IGinzc4PWOjdsPGLVg4b
         tlZAoZxud4nqPhJ/XF4jV9hBwRoxLywKLur5KmAbrCYpghTSYy5LPWVXb3WgcapaxCEd
         YBNv84LOhUL8xi9/8EAzlfuILeUTARI/fLOER+zdyoXXmSFWMQ7lmnMKhffCq4rA00KG
         jzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M74ioG4lJtyheEColDy9jqyGf8j7LT0pBdxo2BvH/jk=;
        fh=A27ZZSIXRkrEHOJZp4Z/3AR1J2hM3fVz2Sa8rDub98A=;
        b=HLw725IkmYPXian7DDSToH4Fsuel8D77vB76uGI9YWhIeGdIccDBrhINUzXUPOGbSY
         CU2wobJvVQP/E49MdMLVwdm7NQnubZ7b7jpLK4UfOqKe68KXGBfGxQL4nMA5ERe8HGng
         qTAPnCwFPvOV51A5YtOxpWGAp4JW0vxzNEOuo2uzueaICP60bHR2we8p5F+rPK1UoGjz
         8/gIvXZGkqb7SCF8DEHh3fyuEMtZAa6923EEc4Pukly7vDwy2uE2TcGQdf8cJWcv0i7Z
         6a0AcK2gzerf4vDx0kCjBeyfS+VHFSrgNpK8qxeXXzXAtLwVxuJPaDZFM74I9R3h7Dar
         fAwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861426; x=1776466226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M74ioG4lJtyheEColDy9jqyGf8j7LT0pBdxo2BvH/jk=;
        b=CaMC1Rzsu19QvkGP4LKznfb3b7rD4O6eZvl23d9nIypC2dSs/YOpEkYH5IJ4JB6am2
         WgMu6B52uHvxPbbWen+uRW/JOBKXrpARfFpNd0tt6BgWE/kGCIjeUlT1e0eIWZTZhAD0
         QIm3C2XBWFmO62H4yv5o8ynbNDsycdBY8uJEATpO3p7sP4QV7VGPjUybn74CgF4dD07c
         ZGrzvtXnqMvArAZqfu28QTi5o0TBiZBz5oGn0kma4jeMaAInpGK3I+ly13bocusD4Fi+
         bmKldFzqUlb2yNnBYImzUnrEnbVt7sHZwVlcLAeeM31VI8SFDAvcCdkhhDpREDqfILbi
         GgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861426; x=1776466226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M74ioG4lJtyheEColDy9jqyGf8j7LT0pBdxo2BvH/jk=;
        b=r45mJQpmFwsbRAtwBFayIQsZ067TrI/d5g0L8vjL+B4AMJ9eRyE7nSvbExYu1HiewJ
         5bZQZYUOBULk1I6eZblLCQE5wo28RvzAAc6lZKb9lFhskewGkkHjoCJFUlJzGIEraxiY
         a7mrcyypbY5AnAhR568BJ+jri6Z05+OFQzle/7EIhePnBtkSXi8xglrJAc85xVMdQ3sr
         8l9FG3Ac5cIcQlAcHbJktxnsr+bSu8ZfwsyrTHzoHE1SK51Gg8HOta8q820lw5085SVW
         fLVLcFAuQf7K/TtV/RWvc+hULiaPUkIoVRmourTDvdDpeX/TabpEi4FcBFmXhEBqtT+M
         uwKA==
X-Forwarded-Encrypted: i=1; AJvYcCVtEeK3cxY4XOgdBpBfDaTT6vEsijsFd2DJXqtzJI8Mk8fBqQLwV72+sZlpWtyixoB1Wyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBk7TiDXMtjluIXxE7aHN7hAvoViAJJE16okxdKEwuzlK1AteK
	dXuamdMbQ+1w2wsDDk7DgXHdbQoQyUjC7TbAnH7FG4S8Jheei7zREbxCC2WN+8bhPHrckPfUdXn
	nVmUObj5+hH6lKu6AVj40fVt2kajiLlN6Vcgj
X-Gm-Gg: AeBDiesaCFAz5m36OMcwUfBosRJZpstBbf2pW9fbQkMx3RS4CcfR66pJ+H01Q8WK8gA
	4esHF/8WJv7rHTUV5/0aOXv1IppSspBWN/xjSOb6WqF3Mcjf9ULS0F90tKmjStqyli6e4pgz0ds
	1WPGOVbLJ1dVjFbuxuS8vo/lJ0BrdwvMkBu8Bpj11gvKbRPC6cHk/iv2DqhkHTaGhBOrORiMID5
	2rBnbPKV7qa1qMfFrYfqp49ZPBNBMY3ukNyVBVXX/5M2bKbySKB5C7Th+FSL3z/A+REFtuPr2KY
	PBL5Whm/WT2VgxdktGS5HUehyi5XmUZhFf361a3I6NRet7IpfmFn6W5cvBxPkKBYZJJDjpgARr3
	FRo5zPdGCnixdP8FiNo8Cn+E+yQ==
X-Received: by 2002:a05:600d:8449:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-488d68364fdmr49744555e9.14.1775861426240; Fri, 10 Apr 2026
 15:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163041.8063-1-emil@etsalapatis.com> <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
 <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>
 <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com> <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
In-Reply-To: <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 15:50:14 -0700
X-Gm-Features: AQROBzBxWj3sLVLWZinK071fIbyVdqZK6G2OTUZwgCmBFPgJLOi8E_QXQQPbzA4
Message-ID: <CAADnVQKU-ki0azXbZROivqVrajGZ_yHuwJj5U-=byFCOxKpSmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena scaffolding
To: Song Liu <song@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:06=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Apr 10, 2026 at 1:12=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > On Fri Apr 10, 2026 at 3:44 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, 10 Apr 2026 at 20:39, Song Liu <song@kernel.org> wrote:
> > >>
> > >> On Fri, Apr 10, 2026 at 9:31=E2=80=AFAM Emil Tsalapatis <emil@etsala=
patis.com> wrote:
> > >> [...]
> > >> > diff --git a/tools/testing/selftests/bpf/libarena/include/common.h=
 b/tools/testing/selftests/bpf/libarena/include/common.h
> > >> > new file mode 100644
> > >> > index 000000000000..5acf9b994943
> > >> > --- /dev/null
> > >> > +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> > >> > @@ -0,0 +1,67 @@
> > >> > +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> > >> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > >> > +#pragma once
> > >> > +
> > >> > +#ifdef __BPF__
> > >> > +
> > >> > +#include <vmlinux.h>
> > >> > +
> > >> > +#include "bpf_experimental.h"
> > >>
> > >> bpf_experimental.h is not needed here.
> > >>
> > >> > +#include "bpf_arena_common.h"
> > >> > +#include "bpf_arena_spin_lock.h"
> > >>
> > >> These two headers are indeed needed. However, what's the plan
> > >> with them? They are not part of libarena at the moment. How should
> > >> we include them in the future?
> > >
> > > I would propose making them part of libarena, and adding libarena's
> > > header directory to -I for all progs in selftest to simplify
> > > inclusion.
> > >
> >
> > +1 on this. We should have all arena related functionality in a single
> > directory.
>
> There is also tools/sched_ext/include/scx/bpf_arena_common.h, which

imo tools/sched_ext are bitrotting. I wouldn't be surprised
if they're removed. It's not really a library or a tool.

> is similar to bpf_arena_common.h in selftests/bpf. We can have sched_ext
> include this version of bpf_arena_common.h. However, it seems weird to
> have sched_ext code include a header in selftests/bpf. Therefore, I think
> it makes more sense to move libarena to tools/lib/. WDYT?

I wouldn't. In general tools/lib/ is not a place for generic libraries.
libbpf is there because it's needed to build the kernel.
libarena is in selftest/bpf, because it's needed for selftests.
The kernel itself doesn't need it.
I would remove some of the libs from tools/lib/.
