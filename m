Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65626396D19
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445590; cv=pass; b=hXGPmvcdsxqIb3plFfDq2Rk9i3jLLLLAXc3jrxtNEw90ANsuvnyZK6w6X36UKiGd08gkIKHl3CLTg17ngnsWlt2bpf1Z30BPLRUTqEUprM9A9Kb0tGq3s8u88ylaW0NlHZrb53uQCUJ1bn4lu1btz2zImiWUBtdOdfRdsTDeLDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445590; c=relaxed/simple;
	bh=/9NoELIhjtPsKswgC5S2LE+1nt0J/KfgNCvQxcX9U4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rExUxA3Zs33zLhSeNMXUyvNFP+IiaMFvlS/f9SNl9Vxi7xOVYUWeYO4895opSvto5JKCauAImv4+JYh8StOrOH0zghrDejQHp2SCdc47NVpV40vsBz0O5mOkrDvL/4aezCF4IuA1QK2Kd+lYu8W4Fun3m2nHD7FTYMLFeJDS1YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrVuJAGY; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrVuJAGY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7650202fso786756f8f.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445584; cv=none;
        d=google.com; s=arc-20240605;
        b=bDNZQLd91S/pFNzOZklsfIr2jCElrMrHSZ7F3Vh9zgAktEgu4TuiD7rDzg/fJQyumW
         0SVPzhszNmiK3jLmH0uLnPk5qCtAcd4AyivUU/oneONqovfn0UvXcZ47O6EGZl+wAlGI
         89lS8s5geGiAIJVxUqg6t2VOQIGNK+Jl6ZiAPD2adaW9d5//9AeFwBjfKdNo6ZFXdv5X
         jIhteDueS25rSKj5mMZeWYFuiEFzWKQ5gbh+LZDiSF4fsHSG1TkuAmsfEv0YGGDF0CVa
         OiMTVleLod0iDDOIBheISOEqpJQZJt6IP5RnpXZPMcRjGh0qi6B1JAwb2z8Cfxp8HExc
         OAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8KOgE8iSH6pUrYsWI3NkQsumvdawuSHT21E3osNxUw=;
        fh=AesC4Vjfd+nZ0HVuePauLzwhpBoDADMa3tB4+FynBRc=;
        b=JAjelVj+gmzVnjdg7q6K7J3KaMd9OWG0AT+880juVGk4Gx8LHPVu8gbws4m8FZtlNT
         TTUYrOtQe6dbHtxxhZixRFzkjmJcP3qo7k5lf5NLAk4SdXHTbt6Rj2MKUuvzIEo/JRFI
         Yte3rzc7frGn8oGXq3r1NfaHpv2RGuL+CwctMI0KzDyuZx3MXM14dndj523tioc+pBkC
         +VnpwAKDQFwPjmh4avX5DKnxKq4x2TIGCDPShHziBjKXDSDA/YDnXP1IBGuSJ/oEyQyA
         7u+R+7ht96varbh+/XP8uVXG35eJWUgPz64kbu8n9LTdWgQDeqWqcK3QoDPabJPwG+3M
         nSNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776445584; x=1777050384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8KOgE8iSH6pUrYsWI3NkQsumvdawuSHT21E3osNxUw=;
        b=QrVuJAGYrNpmK6DQ8VQU1AZl8l953b/uBOWZ+HvSBrlCBb9NMlnZ0vVJjvyakW9lSC
         LmWHVwIt80Nr6ueCRmkVW1VnBhAZiAMbuRkl4OGctPBFJdMrxm+xIAv4+yWN/FtTqMe4
         lS+16sVtExfIxW1cSAzAR2t0TCyGedPcWjbXTImco5gb/UxayLHNB7J0sJtFLYs75qNc
         HM7u+pcTPMH4vi5i+hyOjdw3c6gZqQsTPyb0AQUVYZ1FLZMVWnJMzHc4YQTPS+MqUXpi
         vEqKpbiSxaf/TwQwUJTe29+VFuzaBeFMQaWweBwJWVnwZb0dvxSVeCXssx/34O/PkRRQ
         iWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445584; x=1777050384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8KOgE8iSH6pUrYsWI3NkQsumvdawuSHT21E3osNxUw=;
        b=KkCbknY6G6TzOkojgOLMzWtqpFBxUYww3A9FvdGZCkdzDOc6R49P1jgOGAYskv2x83
         d7yn0G5bKIjRLObKJ0X+OA/z7m+5teWExgyRV2UHUsyCbd2GxnJU23jmAnpe1bEMZlVm
         wnvYUqJGhEzdG6bcIMUAMJHJVpNIh0XbU0ZLmhRepBQSy7ObEBilERZ/DdqFJbqLxZLu
         wVPaCO/QF5vOs/MtjiR8nBXmKdIVJoz6Yy0bFXwQ5J6NOzlyeXco2+Gt740dGOPnsThM
         1EzimIp5AznDjw3GdztF5e+lfxzf0C91WY2SFW7aFt6sAc6uyLcgGxcg5CPaSbj1dOzQ
         +UCw==
X-Forwarded-Encrypted: i=1; AFNElJ9ThA8WOflDYlkBxsvvs1gPHx1Z5SW0S6ajywOf6ff4xjlcsCnL8adg15V2YHgwln4B/AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPPTzkBd0j3Ys1hJi6XEnr5MRAwzK7HyMoLAaycFViW/3Z+2H
	gIxfZC9Nf3wwZQAVFdOCjfUq9NdULkqCXVZeAk2+ntYtdJys9XzIPQrF69rc75udq4+uvOmD4e/
	QSKoE5HvJMxkv+8n03PZeKavIQn/bMrI=
X-Gm-Gg: AeBDieuuP5TIAEXV7XJ85lP/SP1fbd5ESDPyAa27HlRVhL/ayUrBeMO5sgdRa2gWjnw
	3xGQ6TsJ+nI7/0sFt22FrLfXyG29ILCoZ2/R/KYilGyuGWxCvT1TtgH5x0bkkP+UbGhLgibCe8Z
	6gTvlYvghv5Zok1jYuUIvTCXnhjIutyPlLK5VedwLnApzgqGke/Rqg2yNEqiAuyfUV1UVf5N6WT
	nF24Qq/ZEr/6LLfazTCiVgcpGXOlN/j6kKy3f0FsEnuThajB6+RS4qUmMJJuE9LdCbpUxOviIAv
	OyEe0RWZNufS1f2H4a1m3a8BWYUhEhIoDHvAWRylepkH/bcCjgHTZNC572s4KVRAimM397y1zDC
	PkQMPb5Iocu+vRG+ZFAG3NaM+GrQFxh6oYRC4
X-Received: by 2002:a05:600c:1554:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-488fb77810bmr55966675e9.14.1776445584037; Fri, 17 Apr 2026
 10:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
 <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com> <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>
 <DHVKPB8FLV9R.7ACP5WZ7Q751@etsalapatis.com>
In-Reply-To: <DHVKPB8FLV9R.7ACP5WZ7Q751@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Apr 2026 10:06:12 -0700
X-Gm-Features: AQROBzBRcysTGE_W4h58VKJTeYZtYbRC7u1S-fCLgiytW0-NWjlH5Em4eLJybyE
Message-ID: <CAADnVQLtxN_+H0KKFdukO48c9zsR9m4RzpEQGhj0RHMUFvu9AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 9:33=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Fri Apr 17, 2026 at 12:15 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 17 Apr 2026 at 15:43, Emil Tsalapatis <emil@etsalapatis.com> wr=
ote:
> >>
> >> On Sun Apr 12, 2026 at 3:22 PM EDT, Kumar Kartikeya Dwivedi wrote:
> >> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com>=
 wrote:
> >> >>
> >> >> Add a new subdirectory to tools/testing/selftests/bpf called libare=
na,
> >> >> along with programs useful for writing arena-based BPF code. This
> >> >> patchset adds the following:
> >> >>
> >> >> 1) libarena, a subdirectory where arena BPF code that is generally =
useful
> >> >> to BPF arena programs can be easily added and tested.
> >> >>
> >> >> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for acc=
essing
> >> >> memory after it has been freed or if it is out of bounds, making it=
 more
> >> >> difficult to triage bugs combined to regular BPF. Use LLVM's recent=
ly added
> >> >> support for address-space based sanitization to selectively sanitiz=
e just
> >> >> the arena accesses.
> >> >>
> >> >> 3) A buddy memory allocator that can be reused by BPF programs to h=
andle
> >> >> memory allocation/deletion. The allocator uses the ASAN runtime to =
add
> >> >> address sanitization if requested.
> >> >>
> >> >> The patch includes testing for the new allocators and ASAN features=
 that
> >> >> can be built from the top directory using "make libarena_test" and
> >> >> "make libarena_test_asan". The generated binaries reside in libaren=
a/.
> >> >> The patch also adds test-progs-based selftests to the codebase for =
the
> >> >> libarena code, so the new tests are run by ./test_progs.
> >> >>
> >> >
> >> > I am back in the same position as I was with comments in [0].
> >> >
> >> > I.e., again, I don't see anything in the stream output (passing -v t=
o
> >> > test_libarena_asan) when I build it with clang 23 (LLVM tip).
> >> > What am I doing wrong? (Leaving aside all feedback about integrating
> >> > it in the regular test runner that is still unaddressed, thus tests =
do
> >> > not run by default).
> >> >
> >> >   [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=3D47NhYYviZttjCPb=
_CXNpa=3DDUC0=3DxSvdNZdA@mail.gmail.com
> >>
> >> The series introduces a selftest for the test runner called libarena. =
It
> >> is introduced in patch 9 to avoid creating a runner that does nothing =
in
> >> the previous patches. Tests run with test_progs like regular selftests=
.
> >> For ASAN we do not have LLVM22 support in the CI yet so test_progs doe=
sn't
> >> exercise it.
> >>
> >> The stream output is suppressed by a switch in asan.c to make the outp=
ut
> >> of test_libarena_asan legible. Each test that expects to generate ASAN
> >> will generate a ton of output. I will add userspace logic to consume
> >> the splats instead of emitting them to keep the output sane.
> >
> > Why can't we put everything in test_progs instead of separate test_liba=
rena?
> > Then add some logic like existing stream tests for verifying / testing
> > the generated output in ASAN mode.
> > For example, libbpf doesn't have its own separate test suite. I think t=
he same
> > logic should apply to libarena.
> >
>
> libarena is different in that it's BPF code we distribute as source.
> Plus, the test runner is an example of how to set up the arena state.
> It's very little code and automatically identifies the selftests without
> having to explicitly enumerate them, so it's not extra maintenance burden=
.
> For followup patches it's been 0 LOC to either the libarena selftest or t=
he
> test_progs test.

I think what Kumar is saying is that we have only one runner in CI:
test_progs, so all libarena tests need to be covered by test_progs.
