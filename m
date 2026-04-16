Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C349B02
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372242; cv=none; b=a1JaXvmhjitqOqT9ZyslUlbREIeLPEOgFcpNn4105kS4y+3x+jkeeT3fh37lG5GXNdQ+XJmKw+ay56XLDBFPup42E1GPwkgAzlJqTHK2cG8J6MDSVv1gS8jsrNyWuq9etDmyy84vlZqCedgR20wmwQ0q65McE52cJYFOygWaFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372242; c=relaxed/simple;
	bh=QGIef2DKgkWgTSLm1/zluKhpQGzjhf8XEtto3PhCWRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEo3kBeymrOuPJVg9zSfyPF8ubI3nQPaGBaV9f2ibVBvixKJ+qLzo0VBcam9doswQbo3/xlrSb4QTI4oqmRxWYQKhch19+RBSdXcKH2K7AjzDWZ5QFJBqly4M2nBEnEX6Ajqsj+J0ydKVY6gcTJ2e9sFjzcO3vvNPMkVQtdX1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR52t+5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR52t+5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA184C2BCB0
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776372241;
	bh=QGIef2DKgkWgTSLm1/zluKhpQGzjhf8XEtto3PhCWRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TR52t+5iM48OmNZPMY4itWRLW9UdIQQgLliQ6z/fHESwXjT6VvaaCjbv4hEzgx4r3
	 MM2GFs2nYRRM6QBnnIJC/AQW9fxpVB1glXpCQz80112AWKzfhjDsezhrUG4fageCso
	 pLehpbquA1CeUOe8rfoLYY98QL+3aIDwwq6W4gK2/hqodSZRWyzDwEYljXKbO6oXwe
	 2mNY7d/kLZ4Emv2i2pXbvzJQ2FuCdZ1b3jNkONst4MFBhXZlwbrmwsz8DzZ0Ju2Im/
	 Jk6vapRPXX29TVJViIMwsknGHlgFyGRe51W9X90x+IY84YHY8Ris+AHOb9D7+/Fc5c
	 82A4WymUihOSQ==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a48deebe95so67866686d6.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:44:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8AYfkwTGkgNT0KXv5UaxMhdE4QoAYK5L/dhPwWahYTYpx+UHUeq+0AmnmKO09sK7YW5Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0Fj3pe7KIjPJ+IDsoUAcTdZgYra6w+IXqYuMQ9oj2KpaF6Po
	vw7f5DsJMxwYBvLfMk/NzMiQjSoRDwB9VfIPz8QogSlqw8a/cSTxvyNLxP94CJLbnjKar1L72Rr
	oWs4M1tU0TxpRn9yRph019He2Cm3n9Tc=
X-Received: by 2002:a05:6214:3913:b0:89c:e4c3:dc1e with SMTP id
 6a1803df08f44-8b0281103bemr1156536d6.34.1776372241130; Thu, 16 Apr 2026
 13:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <aeFFQL-bOTN5dg7V@google.com>
 <aeFHKUsf86jw1v9W@google.com>
In-Reply-To: <aeFHKUsf86jw1v9W@google.com>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Apr 2026 13:43:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nvpP6UJ0xO0yJ=FcAVOrWDX6ASvcp04kWQfYBx=72mA@mail.gmail.com>
X-Gm-Features: AQROBzBanASTY0BkJkcgT7VjU9AKRM0hDAO5yFVylM3s9r-i6kiT8TQ7cxX2bF0
Message-ID: <CAPhsuW4nvpP6UJ0xO0yJ=FcAVOrWDX6ASvcp04kWQfYBx=72mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, memxor@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 1:31=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
[...]
> >
> > I haven't had an opportunity to go through this patch series just yet,
> > but can I just say that it excites me considerably! I've been wanting
> > to carve out some time to implement something exactly like this for a
> > very long time (since BPF arena maps were initially introduced) as I
> > think it's going to be incredibly valuable for BPF users moving
> > forward.
>
> I swear that I also saw a notification stating that this series was
> applied to bpf/bpf-next.git (master), but upon checking I only see
> that commit 4c5f21d4dfa ("selftests/bpf: Add tests for non-arena/arena
> operations") from the series was applied. What's going on there?

Part of it was committed. From patchwork-bot:

Here is the summary with links:
  - [bpf-next,v7,1/9] bpf: Allow instructions with arena source and
non-arena dest registers
    (no matching commit)
  - [bpf-next,v7,2/9] selftests/bpf: Add tests for non-arena/arena operatio=
ns
    https://git.kernel.org/bpf/bpf-next/c/4c5f21d4dfa4
  - [bpf-next,v7,3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top =
level
    (no matching commit)
  - [bpf-next,v7,4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE macros
to bpf_experimental.h
    (no matching commit)
  - [bpf-next,v7,5/9] selftests/bpf: Add basic libarena scaffolding
    (no matching commit)
  - [bpf-next,v7,6/9] selftests/bpf: Add arena ASAN runtime to libarena
    (no matching commit)
  - [bpf-next,v7,7/9] selftests/bpf: Add ASAN support for libarena selftest=
s
    (no matching commit)
  - [bpf-next,v7,8/9] selftests/bpf: Add buddy allocator for libarena
    (no matching commit)
  - [bpf-next,v7,9/9] selftests/bpf: Add selftests for libarena buddy alloc=
ator
    (no matching commit)
