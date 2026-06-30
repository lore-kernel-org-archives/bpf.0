Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DE47B41D
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852950; cv=pass; b=rbhvQ0Xh2wzeMc7uaHCj8w+SNKNeXspQTZ100K1pTTenKorsdEiuq6pB6ZNSDc48rl4inNNrw1cAUOdV5k7EFZEjubyWzNvTLY0W2nezvj1nHEh4LemfFpvDFKaYpvnWKN7t+N1kXqs7qMDXC9fDr+pUnLlYvTSqijkBZJgwscc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852950; c=relaxed/simple;
	bh=7Obh3TQNzHVnGYC58vFCSCqYxOJCAaSy2yOyjKHKMvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFHbdzSgaQ6zmUEagwGKXq2M/ajsQm62HINCIszge0or0/Da/A3QWqP4xyq6VSXJCi/aUsFblAZGf7eUTYGB/J45gWPilagk74x+OHAEoZrivbxbiL2JLpVpkqox+I98oJ9r25H4kMpFlNhVok+sHE7kuEcOxhiFCSbIl8KJSNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4mjr/b9; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4mjr/b9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8478a25f268so1659572b3a.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782852949; cv=none;
        d=google.com; s=arc-20260327;
        b=UvJkYdG/sQB0kXcnvGgFNYL5bo0RPnU+53f28/XVHlLvHOxV3wBeTSw13vsdSVUuZu
         92mmwV+kfOUhbZs4I30rvKQKrhjyfsPaLbWcB1O6td2zUQ3E8CKQW+BO4InPsHU8gIAv
         jC8HxVBB6N+POshcU3RAV8HkpzN2mlAUQS0rqi2jH88uZjPCd9vDaRawOsTeLWIrcpbJ
         Oy0BRF/RTFHcQ1ktKQApFaqZLCgfLeoLaluRaQteSiG40v3D9NjV62W+fgEsjUEcULr3
         KsC1hsDGAKkjkaIZciIJ2ePGTR9wKIJfDOHlOozeAtkWlCWLsUSh66RTlYzEVrhARQTJ
         tahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gdj2Nu4ApacvsUxlEctmhteIRZTulEeQ8s+7ZI+ztpo=;
        fh=yBXICqLeCxM7a3jO8AW3apN6ZaetuXE0ZwHrpDaQgpY=;
        b=epM6aKMDGz0H4qhh5vNTY/ECt5U2u3oYaG7lZtNizCWKmN5GjezJUIG7MTpwtPBwjZ
         wJhdGt1RzOej5X8gxDdcOQmk+aPjHomooCsVFCypIEirNWJnx5sG60x8cZPglFumFvTR
         qX25YaXTsJHAeVly6Nkyz+WdrSd3E9Nzmi0G6WzbJXnGLRTH+kYLr4M92+DtIUS/Fq9Q
         +EgKQlAlKOqo3yFw9csWpMAcF0JHjuIsipU0AvkXmBIk24nvpuJ+7srNgx2NCFDIrrUM
         cK4bzRvQOC6fEQT1+4DBBFwcYMbPpS4lBbUdteTzB4Om87wgNpsd2LSOaiSO27o4FVLg
         7YNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852949; x=1783457749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdj2Nu4ApacvsUxlEctmhteIRZTulEeQ8s+7ZI+ztpo=;
        b=a4mjr/b91IGofi2EpN7FICd2iZyXBTUsJTcZv6qXHXluFdwhHKH+RCMxJsXMF+igpq
         tXCuh2q5SfQBmoZFoO9kcW49rKElJJQ4suphOUcGArpIQNp/3PyeHmEY90dDq/QzhlSv
         IyuQDgIlRQ9XZsAg4aZqJdim8EqT1LvnuHzGiXPiMN4IO3M/qyzWJw6NkpGkipHx0wn9
         Wg5ylkPWLAb1RaQa1LEbbX5UdoqDyBEMcDpuQiaL+44Cp+ZsTANeYMvXBmVMtltjpYQc
         NoYvOwx99EMOZeVQ5weIMXRvvJdbfwmnU6T5c7MH8PsNa3KCb3RCvPt7jSusvbz8jVKP
         I9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852949; x=1783457749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdj2Nu4ApacvsUxlEctmhteIRZTulEeQ8s+7ZI+ztpo=;
        b=R5oh8jRghIXbcgPEQhVY00U1QqWFHfgdSaP1+Zsu7+d/n54/FlYQj/KCxwSCtFGseQ
         IOk2ZNjiBjnEJBXyMdM8VJyQgeqvJbhQnriCIuofKcwt7ZrGGV3qqEHx6HOUM7TEe+eL
         9x8wRAKk1fDbVEPxL63GK2SyhWhjDOdym8RRHuicr6CdlaWTvyhzueDdEHIH+e5JOofi
         qZCiAKegdIyir328/WYYjWiwUxCzEahnwjhccO6WvAmoDlDp1/F7q7BZBrcqBhjAKh75
         ZTayhemD4Y1qbGH7yS4d7+mMYpANdQI7trTqSHoWPxWgxLZoULQDH+U2ITN2RRrhsodq
         e9NA==
X-Forwarded-Encrypted: i=1; AHgh+Roeu7dMffzQFcUkq5YJuWYJ8SKjK54bWj//V7/cDNsXIdShXlEyD8vKy8S9H4xzjlEitys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDmTpfdo6dkvGRU1BmX4lt8Zvd6Gz6vvjkJEQE5ObciuBfqKY
	2iynGxVi0wOnkkM/0pbusSf6ZO+eWaJUsl6hOtgFCVT1nlRFQQ0Bl0xejqy1d09T1f8UZOT+QZd
	xDotahSvw/BA8GihRQzTCJMukqxLrej8=
X-Gm-Gg: AfdE7cnHpIyDz5MsdpRbK0jCtSW0guyNSayrSL0LAc2HMKTo6GQgnhT4OUpcPjPplWT
	BlRN0WqcZpwfJBvAHNf4OuIFdS1XQYhma1swNdLqimJSVoqOdbM0NqPgy35LmBQiQmx7KtSe5EK
	ChorJ2uooX3yZHtApAvxrGNvGspM0TT17zRWiSBDw4TIEfawv9gSMQlK0C/66rzXwI34i/qurQ+
	foJGfHoWYA7JCp22JXl1V0RNKEPD0AzbLB6fW848GTXkM+wTSPaGYdeoAyNchZdet0UKYpeumr7
	VUs4OryE8BVBMbBkwsf99VpGJKeL0epo+g4TYfY8AQ8TD18qgrOk2EczHu9+R3F7mtjR855ZkDO
	ETcP1
X-Received: by 2002:a05:6a00:13a7:b0:845:d285:3b6c with SMTP id
 d2e1a72fcca58-8479f2c67b6mr4372390b3a.56.1782852948730; Tue, 30 Jun 2026
 13:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624204946.2901178-1-andrii@kernel.org> <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
 <CAEf4BzbUEi4zZxEBggHzbYRaSMtQ6wWJSjHhqfvE-omvGadApw@mail.gmail.com>
 <da07a0af-fbcf-4936-8194-1dc2d58bdf59@kernel.org> <CAEf4BzaCbvsBePEaiHaCniXWUBhgDnJ99=XPL4idLY3_xkH3dw@mail.gmail.com>
 <67b2d2f5-8632-4c39-bdaf-07a0d4d48c1c@kernel.org>
In-Reply-To: <67b2d2f5-8632-4c39-bdaf-07a0d4d48c1c@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jun 2026 13:55:34 -0700
X-Gm-Features: AVVi8CcIDbgPYBKuKZymmK4BlewFcDu6cfwvW9XNLN9x5EvOhlKK9N5FgMFMt44
Message-ID: <CAEf4BzbPufLfVWPhgHMEMiZ+C5DMsgkpcZ260sVOWcG7_QEH=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from
 format/argument type mismatches
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:37=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-06-30 13:15 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Tue, Jun 30, 2026 at 1:01=E2=80=AFPM Quentin Monnet <qmo@kernel.org>=
 wrote:
> >>
> >> 2026-06-30 11:32 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com=
>
> >>> On Fri, Jun 26, 2026 at 6:30=E2=80=AFAM <patchwork-bot+netdevbpf@kern=
el.org> wrote:
> >>>>
> >>>> Hello:
> >>>>
> >>>> This patch was applied to bpf/bpf-next.git (master)
> >>>> by Alexei Starovoitov <ast@kernel.org>:
> >>>>
> >>>> On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
> >>>>> Building libbpf with -Wall (as happens via bpftool's bootstrap buil=
d)
> >>>>> surfaces ~120 -Wformat warnings where pr_warn/pr_debug format speci=
fiers
> >>>>> don't match their argument types: %d for __u32/Elf64_Word, %u for s=
igned
> >>>>> ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applie=
d to
> >>>>> signed values.
> >>>>>
> >>>>> Match each specifier to its argument's type where a correctly-signe=
d
> >>>>> specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions=
,
> >>>>> which have no signed form, cast the argument instead (%x->(unsigned=
),
> >>>>> %lx->(unsigned long), %llx->(unsigned long long)). No functional ch=
ange.
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Here is the summary with links:
> >>>>   - [bpf-next] libbpf: fix -Wformat warnings from format/argument ty=
pe mismatches
> >>>>     https://git.kernel.org/bpf/bpf-next/c/df3153758ddb
> >>>>
> >>>
> >>> Quentin,
> >>>
> >>> I synced these changes to libbpf's Github mirror. Can you please
> >>> update bpftool mirror's libbpf reference to include this change, so
> >>> that I can fix these noisy warnings for wprof? Thanks!
> >>
> >>
> >> Hi Andrii, I just synced it, thank you.
> >>
> >
> > Thanks, Quentin!
> >
> > I got a bunch of new ones with latest bpftool sync, I haven't looked
> > into it, but thought I'll mention in case it's something on bpftool's
> > Github Makefile side:
>
> [...]
>
> Oh, I haven't observed these on my setup, I'll try to look into it when
> I can. What compiler do you use? And do you see the same when compiling
> from the kernel repo? The Makefiles should be rather close, in theory.
>

Just sent a patch, bpftool's in-kernel Makefile needs a bit of
adjustment for boostrap version of bpftool. There is a note why we
don't see it in kernel build of bpftool (re-added -Wall masks this),
but I confirmed that with github libbpf Makefile and wprof setup the
issue is gone. Please take a look.

> Quentin
