Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B163DDDDD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858779; cv=none; b=mPLsmhjzOVzYlg690Ap9QwOQIR6BibNqBsK+gsyAqS9PotzA7ANs82N3Nza2/2xJILygUJsHoLFRTTc4VvpY64HPb10pss//JGx4tCA8r1iOWV50TNDxWRYQwmxZ3kgkDL3qvADsIgQXzZdEmti175EQlWQKW68mYVEddeczIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858779; c=relaxed/simple;
	bh=TZr2brUSk1eFpIOo0Z9h3SwUdN4rr+t/XQKcTwwBSV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixNJwunfny4Ibi5s/hZfOOEKiJ1lC1EVwTqAONkh1XyaEx2ZAE8cmX3KGbx81eDRXCcsBWRK0KeTa1hfgedWd6fK2wdeed8jxGsNqGk5jZhRJ8QYDHdejvMCKiTPti5v4hVqW4XxmRukDfn2qGuByDaCCrIJMDE2meVu5UKGKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaO+/OAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaO+/OAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5BBC2BC9E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858779;
	bh=TZr2brUSk1eFpIOo0Z9h3SwUdN4rr+t/XQKcTwwBSV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SaO+/OAuINyERa2nxRjn2BA/9e1kjcMob1l+SI65BTHylWxzfFdIXRt8KbEwuy/jl
	 4VeRkuxIGLJ5qMD7RkD/9EpstH9fxzMj5jmWrT4PaQtYdLmDNmautUjhx6l/51TU+S
	 piIyQ9EwAMCXTtyFuJNucGDCVBsagbLfbA8em9TYsdbkjYuGfZ1RLmfP1qvfeqH6uh
	 GXPFMqu6vMfY3BdY13FMvId0KvDZj/RfvzuK0AYDtRbWgjbT4UXSilJa8Egs8Z8M8u
	 eynq2gPiFfWRecxKxUqbk//HxvgvlkN57ItIzr0lsqLYzA2SCqy9NJZJ3F01FuegtU
	 S/dcNYgFAmpnw==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc5941028so357745585a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:06:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1KKW5jJfps3euMxDvzUu9bCQTBeWcNhxQhNdCp6ukm7KsmB+zvbH6Jxzq32ItbRxwqHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy095qqOEuF4rY+2hKDN/44NcUwnS+Oab56e/+B0cZ1ujipFOzA
	i1yJzB4YN6MrU/UiHcpNLv6kxRShaxE4e8TYsAGjzIFo5U+9pRcvELTw0y6u5h20mEiIEdBVu/c
	us8FLMjRgQs2l9JEeRbo9OwPgqTJsSQE=
X-Received: by 2002:a05:620a:4548:b0:8da:3443:9a6b with SMTP id
 af79cd13be357-8ddcd40a799mr765896585a.3.1775858778809; Fri, 10 Apr 2026
 15:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163041.8063-1-emil@etsalapatis.com> <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
 <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com> <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com>
In-Reply-To: <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Apr 2026 15:06:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
X-Gm-Features: AQROBzDm38UGsMnq4CucaXlWck6q1bcWcIkOw5S21TRWslkfTH4kZbN2fVEAUYI
Message-ID: <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 1:12=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Fri Apr 10, 2026 at 3:44 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 10 Apr 2026 at 20:39, Song Liu <song@kernel.org> wrote:
> >>
> >> On Fri, Apr 10, 2026 at 9:31=E2=80=AFAM Emil Tsalapatis <emil@etsalapa=
tis.com> wrote:
> >> [...]
> >> > diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b=
/tools/testing/selftests/bpf/libarena/include/common.h
> >> > new file mode 100644
> >> > index 000000000000..5acf9b994943
> >> > --- /dev/null
> >> > +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> >> > @@ -0,0 +1,67 @@
> >> > +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> >> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> >> > +#pragma once
> >> > +
> >> > +#ifdef __BPF__
> >> > +
> >> > +#include <vmlinux.h>
> >> > +
> >> > +#include "bpf_experimental.h"
> >>
> >> bpf_experimental.h is not needed here.
> >>
> >> > +#include "bpf_arena_common.h"
> >> > +#include "bpf_arena_spin_lock.h"
> >>
> >> These two headers are indeed needed. However, what's the plan
> >> with them? They are not part of libarena at the moment. How should
> >> we include them in the future?
> >
> > I would propose making them part of libarena, and adding libarena's
> > header directory to -I for all progs in selftest to simplify
> > inclusion.
> >
>
> +1 on this. We should have all arena related functionality in a single
> directory.

There is also tools/sched_ext/include/scx/bpf_arena_common.h, which
is similar to bpf_arena_common.h in selftests/bpf. We can have sched_ext
include this version of bpf_arena_common.h. However, it seems weird to
have sched_ext code include a header in selftests/bpf. Therefore, I think
it makes more sense to move libarena to tools/lib/. WDYT?

Thanks,
Song
