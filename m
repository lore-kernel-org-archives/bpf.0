Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3658234
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200970; cv=none; b=gRco/66+K1ccMRHJuK1aA4/6Q0g+ua12db4VibeIcdcs5tEhH4tEehFKJFYSPZ0IAbKaucEV/Kf45pkDaqUXG8Fg2jUxVwUkqgI+07Dz55s/yVt9jWhpTf5zYFRy2OFOAgslq+ipbylkov6FzEdjnDycT2VvyDUogibX9GgyBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200970; c=relaxed/simple;
	bh=qXyedWwtoBnrE9l6BzFjAypj61IV50APm3+iBvgpmxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzXThnT6YPk+BXiee/V0GEnMEMXkoCQI5kgdr8OE+6Krv3Ki7fktFXn6lTmbNHhVb9q5aj/z452kcQdIqoOSh52wqHprEmfdu2DIrJ31XMSE8Y/7zunsXXPi4UWkw5NVTUGBco+POKJBY2i0XadGLPs0xVeAFB4PrluWh53UxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbqfO/76; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbqfO/76"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e99b639e0so766285f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710200967; x=1710805767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vfzoxjMPZ9tlEU3oYSsGsaYtcdsPpUgvMYU6t0AE00=;
        b=DbqfO/76dodsSUqZaUvMoFdgOg+cWUfAcTEYOPzQOVvGI/FzdQBCjb1YQYADhyl2d3
         WoSB25luJpXpem4PaTNMqHfssdjlo2JaLufFJMFdE03UO3L5FTo57DKKzNUeSnS1+2OD
         AbYUhBpeN/sDupkq83MUAaEXniDFqhqDluB7YPZIiMTtqKtWAgpnyE8VsQh41WmepKZ/
         VlCa8PPf1vPJUzXq3qd4+eI3UEplJ0b1CpkDOPIblrE6PIqkvMxJ2pSFnFfPCRBgom2t
         cJcYaBzghNXOPJI2XXV2y75nusXXUb2k5yiF21YP3GSt6RnBud+n3Lssf9wfWJAMjFrq
         wr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200967; x=1710805767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vfzoxjMPZ9tlEU3oYSsGsaYtcdsPpUgvMYU6t0AE00=;
        b=E7DLzLV2aYzcyiZ9o7RMaf0WxlibnBKB0Gf5jpNrs+igCtFBRZgztpGa0U7RjSDMTg
         Db/mHWj/s1rQQXBn/1Xr0+olKlE2/OHbqJV7oqPi0DH20O+wbB9XKWLcsqm7BIi5DWlA
         qZ81YbeLUwMgrtByOxRgXpbcDUhZs+xcYRG3iEBQuo3Umv8eON3H2BjN0iypwYX99to4
         cuC2BMrOwHdJybrNsFhc4zX6k6VnxgkhbsgnhT3yZu+/uzBKOH0rCQEKcRNop/XR4syg
         vKd6kt0E00fEgJ3GscntyTUWmHEAUO0yeCIFlQvv4crqYhRWpCdEHvMD5QuZMbax+m0G
         gwXA==
X-Gm-Message-State: AOJu0YxDucXjcKUIJoMT/fi7mKgxttKTz/5QMSxXNcGU2RMxk/meVD++
	G/b23ehspBseIu3Y71f01H3OTZS3MgLnTE35CkSE4qdMHCAGWIWbmb2QMKNBtCZb5aI2dqr9/Ix
	g8LpqGc0m0UPhXjUqL76BLzUPtwQ=
X-Google-Smtp-Source: AGHT+IG8xdn5sLCDztwvDDZo4l2prvhXh3oTeAIynJFIlDG+dAYdzk27/B0IQbvnZK2uVb5xEQYsQCOWrvJwMUT7dWg=
X-Received: by 2002:adf:f68c:0:b0:33e:800d:e87a with SMTP id
 v12-20020adff68c000000b0033e800de87amr4904176wrp.34.1710200967338; Mon, 11
 Mar 2024 16:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309004739.2961431-1-andrii@kernel.org>
In-Reply-To: <20240309004739.2961431-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 16:49:16 -0700
Message-ID: <CAADnVQKpCO+kF3Bi6gzpVWr_RUq20gmr+XgmytF2Ngv+gSYnCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:47=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> prog->aux->sleepable is checked very frequently as part of (some) BPF
> program run hot paths. So this extra aux indirection seems wasteful and
> on busy systems might cause unnecessary memory cache misses.
>
> Let's move sleepable flag into prog itself to eliminate unnecessary
> pointer dereference.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  8 ++++----
>  kernel/bpf/bpf_iter.c          |  4 ++--
>  kernel/bpf/core.c              |  2 +-
>  kernel/bpf/syscall.c           |  6 +++---
>  kernel/bpf/trampoline.c        |  4 ++--
>  kernel/bpf/verifier.c          | 12 ++++++------
>  kernel/events/core.c           |  2 +-
>  kernel/trace/bpf_trace.c       |  2 +-
>  net/bpf/bpf_dummy_struct_ops.c |  2 +-
>  9 files changed, 21 insertions(+), 21 deletions(-)

Looks good.
It might help Benjamin too to add sleepable callbacks.

Separately, noticed that jit_subprogs() doesn't copy
sleepable flag into subprogs's aux.
This patch doesn't change that.

Though subprogs are never called directly
probably worth a follow up to copy the flag into subprogs?
Just for completeness.
