Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30C37E30D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028191; cv=pass; b=gJZye0IalDVOW7iQ+biZqk4iGJirzoFCUp25C2g9xQIc2Imt2MmYkowT13DT41pbBME0zrFDKMEmLzEAQdRTEumqTPKF5gfA/lj8qUrkWZCyS12nQyiF/iOHNbjVfh8jBhCwXH5wnqhtueZtFSznl+Tt65TbpKW8PLPFbJhKLzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028191; c=relaxed/simple;
	bh=oEQ85Gl3lH6+Cv9RN6chqPqZuCmnNGFRnwc1Zh/B7zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSAukvLUV45B3dE6IrGUOWM9ULMuVNwII/0w2NSPX8OvcJ0iSpZ9hi0v1jBYZNCp8/2zapmQ6xCmYC99ZRmyvBIo9DNzpNaUr4D3rA1a+dB381NsOx8yywQkAb1IOWzDA3GJZ32QkrsSQa4BA36mjfSnQYztYT7XExrscmFZg8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIFDD6UO; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIFDD6UO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf906b007so2290314f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776028189; cv=none;
        d=google.com; s=arc-20240605;
        b=Bji3YsFY7mtpSSlWU6aG6xq9vDM5S9zjj9SRp3gJiYQModoCL2Ml+a0+S89RzsA0VE
         8XykHjKUwqj2EWTLyREQVE0+cfeSrfBHLhwF2xTEPgWKlWqNKroR1fNXN4PVyFaDiEIh
         Oyn0eRt8i83TeQr3MLnhB4qn7P1i4gNcH/Mxi7fFwSdzxxgvp7XnPmYAM9VshxGElQy3
         KDr33nhEHbR2qVFE7j11WHd30sggwdZFlpCVBjP3ND5Fxup7ezP39iLOSlN24G+6XHff
         /ynJQTyi4QI62bo0rdYUaboFaNUuPS77MvTim1pgrtwhqBt/Q1huxWEPyCBpdzwE5IC1
         EG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfWPCmksGjAz4lAKfxlGJt2rkOmogat4M8a0nj0icMw=;
        fh=fNerlSEvBv3G79OGo/b0s9zVlf6yC9IxlHC2M+mNW7A=;
        b=an0pg4hOD0r5+nlfxngzp8hOD3gT3Kj+Q7wx8gYoHiVKO5RkOI7HDlJiw1qvwDXupB
         LIUxCTww+md5vE1Q2hUitCPwNurHYfKrKKnsq/8bX+hUvlIHxCo35mMvMpZtiSg54n5n
         3CttKB00tKDqeUOPra+32STfv0jYx+SJYqyKQCcrB2iJhRms+Orr6PCK8hLKLjHpDHfW
         QE6kX7lERWL3jkOl3LAAkbfYnpDz+Ufu/+DqGN0C+5WfvvkKwBUtIoriyUnwIixoTOWH
         AhjJDGO/COqSb1dP7T8em3JTj1o1lOiZvdEqrfuaklrb7TycnzIwD2wAovvf0FVfhgIZ
         FKYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028189; x=1776632989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfWPCmksGjAz4lAKfxlGJt2rkOmogat4M8a0nj0icMw=;
        b=BIFDD6UOOORvczVKKH5w0UP1uzRIHSUYXNxwrx7jzh4l/HMZGvAHdUf5x1p5wT5x2v
         fXfa2sCMYgeriU8nF39ZTHzJsvJyTQHXQBTmNqTFnz6mo9Teed967aMbtz+yQcTehzFO
         OrHT3HMZVVe6akZSB1ccbN6DKyIVAjVqYpF7LzkshiXSbPhkP3I1vyhggGWGsh5xaIl/
         IsbNRAZ+yfroZDi+2yLiPNcQO20HrKhdwv+6lsPXgeRpAtPRs6+2qa1voqP4r/dcDOcJ
         IpU4lKBHy3fnk4B2+l/e34kPwC2t6bpEQzyxg0cYJjwqPDsPhaUPULO537NRYcncT0+h
         wZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028189; x=1776632989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfWPCmksGjAz4lAKfxlGJt2rkOmogat4M8a0nj0icMw=;
        b=a0qG6J3gh9sGIjqcnvFC1d9zpnyiVF0aq7Nci8H4xWwcagmAANFxpIRipe9cGoif7I
         jQNtDWDmDRTs9NE5JMqFChzSmFt9Ct3OhreP/jUKEtY9Da8jskXW5633OtpnP2BMyM+Y
         D9KKpl/x57BLiJyeQ/B0WVKmHMTcqDz2cdTJVvYeJTe8j2XeIOoQERJrU/tUUar6D+54
         jncmdmvGHOgPEx4RuJXIyYGTq0PIQA3UqTb569KK1BhjNoK2p0txybMvAWO7ohAfEy/7
         CnYFzIDFgnUCL8rrlhhP7TMC9KXWXZT4c8Y9yalyHACxeukwM/k22jllPzs56M5Vw/oG
         qUNg==
X-Forwarded-Encrypted: i=1; AFNElJ+H0DSLeVdtBci31mrpdRze5Wtv9EIttf/lXEZIPvxqSd95P/s9xU9B1m8XAFInhenmIHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiYWVQvkhS4gZPnvkHejdwVymh8u41Q5t9HrDodxFp6TDoXLy
	1WMigElTecYlZJ6LgoI83/ChsFjc5qjRwhPtdLF10Ld8Sxw1TltieTEpmQhGrczLzFkoeLRcPaC
	BwgsM4MUkYkNWWcKxZIC2Nq7/dmKFS2o=
X-Gm-Gg: AeBDiesUENYZTXp0L85qXoRqB0uFF4iFTAxgX3wIiQilE5h2tEIhA+/mc4i81uLBWpa
	vm6FlVrh4WZspP6dtNFhsWGAyNH+xoWy8H+wpUkHYlfyHxB+FTmgg6id6tBcsPjGHlYiw3WbuES
	+f+0lonG/qcV8WYiKLBe4zoBfmrPapWIUFUtgSwPVWDmBmWyuoty3oz2t2rMm46mhgnog1aO7S8
	9DidonkkcXd5+bcaAGmJMpaJoajb3Wc4xMK5E/d7axuXnIcbVlniUyA0mk57835kDUuHF0a7tVE
	7sqdpTIX02/zXK0xdarkUV9vXoeR6gI2sUCerrD7H64eERPhLZfKvkUDX3+fKPGheRhe6AqjnNF
	ViTmzdqa1XkjJw1sJS3Hd082dqg==
X-Received: by 2002:a5d:6087:0:b0:43d:708f:a63e with SMTP id
 ffacd0b85a97d-43d708fa6f6mr3675840f8f.10.1776028188629; Sun, 12 Apr 2026
 14:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
 <00e95867-edbc-4e74-8696-16a8f61223b7@oracle.com> <DHPIZX3045PN.2QCSGKPP43W3I@suse.com>
In-Reply-To: <DHPIZX3045PN.2QCSGKPP43W3I@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 14:09:36 -0700
X-Gm-Features: AQROBzDEoHs8AN70ZQU6rFFqi96tGMTpydxF-q75n3f12Cuk-TEdUaK2x-jPrm8
Message-ID: <CAADnVQL1uXfPr1WuM1B8YeJHC8y+roE+b0OT1F5saM=_aeOjBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] selftests/bpf: Tolerate partial builds across
 kernel configs
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 6:57=E2=80=AFAM Ricardo B. Marli=C3=A8re <rbm@suse.=
com> wrote:
>
> Hi Alan,
>
> On Fri Apr 10, 2026 at 7:06 AM -03, Alan Maguire wrote:
> > On 06/04/2026 19:22, Ricardo B. Marli=C3=A8re wrote:
> >> Currently the BPF selftests can only be built by using the minimum ker=
nel
> >> configuration defined in tools/testing/selftests/bpf/config*. This pos=
es a
> >> problem in distribution kernels that may have some of the flags disabl=
ed or
> >> set as module. For example, we have been running the tests regularly i=
n
> >> openSUSE Tumbleweed [1] [2] but to work around this fact we created a
> >> special package [3] that build the tests against an auxiliary vmlinux =
with
> >> the BPF Kconfig. We keep a list of known issues that may happen due to=
,
> >> amongst other things, configuration mismatches [4] [5].
> >>
> >> The maintenance of this package is far from ideal, especially for
> >> enterprise kernels. The goal of this series is to enable the common us=
ecase
> >> of running the following in any system:
> >>
> >> ```sh
> >> make -C tools/testing/selftests install \
> >>         SKIP_TARGETS=3D \
> >>         TARGETS=3Dbpf \
> >>         O=3D/lib/modules/$(uname -r)/build
> >> ```
> >>
> >> As an example, the following script targeting a minimal config can be =
used
> >> for testing:
> >>
> >> ```sh
> >> make defconfig
> >> scripts/config --file .config \
> >>                --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> >>                --enable DEBUG_INFO_BTF \
> >>                --enable BPF_SYSCALL \
> >>                --enable BPF_JIT
> >> make olddefconfig
> >> make -j$(nproc)
> >> make -j$(nproc) -C tools/testing/selftests SKIP_TARGETS=3D TARGETS=3Db=
pf install
> >> ```
> >>
> >> This produces a test_progs binary with 579 subtests, against the total=
 of
> >> 708. Many of them will still fail or be skipped at runtime due to lack=
 of
> >> symbols, but at least there will be a clear way of building the tests.
> >>
> >
> > hi Ricardo, I've been looking at this series and one concern I had was =
if
> > tolerating failures to build with incomplete config would create proble=
ms
> > in detecting failures when the config is complete, i.e. in BPF CI. So f=
or
> > example if say a BPF skeleton didn't compile when it really should due =
to
> > an introduced bug, we wouldn't want to drive on in all cases.
>
> Agreed.
>
> >
> > However, from what I can see, CI held up well with these changes in pla=
ce [1].
> >
> > That said it might be nice to preserve a "strict" mode which fails when
> > we hit compilation issues etc, failing as we do today; I couldn't find =
any existing
> > general kselftest concept that fits with that but it would be valuable =
I think
> > if possible. Perhaps we could default to non-strict mode when a make -C=
 is initiated
> > or something like that, and continue to operate strictly when building =
directly
> > in tools/testing/selftests/bpf?
> >
> > I ran the changes through the usual workflow I use - build bpf selftest=
s at
> > tools/testing/selftests/bpf level and run ./test_progs ; no regressions=
 were
> > observed, so feel free to add for the series
> >
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
>
> Thanks for testing!
>
> >
> > There are some comments on sashiko.dev [2] that would be worth looking =
through
> > too, in particular the concern about O=3D and M=3D mentioned for patch =
1.
>
> I will send v5 with those addressed and possibly a strict-mode switch.

and strict should be the default.

Even sashiko doesn't like this "ignore all errors" mode:

https://sashiko.dev/#/patchset/20260406-selftests-bpf_misconfig-v4-0-9914f5=
0efdf7%40suse.com
