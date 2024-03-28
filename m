Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE90208CA
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666453; cv=none; b=IK8yTXtNE0Wd4U5na0rDbnexa8c+TmHe3xwU3LPGorE4ELKbZAesYjCRLTt3B5doJXdNNGK/5PveWcL/5+EjTSulRJxDUnPvUUuAmRgV8JaET/r0FKs4XPgfFMrscNlMZXpaFkGBz1Z83G6u/6HWDYALm5tcwifRKWo59S+ZXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666453; c=relaxed/simple;
	bh=iyfyPI9ZMqUKkXcCqyZ30ho0nIWAaisUou6rEyfWPQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om9Qc/VSmZ90KyQsNqwEDdozTwyu5oKHVoUBQdRrkGBcSW18AYcnN0GNiJmleR9rss3xKu7x4vE9Eku9oN/YTaSYux1cUGasHZO57mqTJu1iNRecmW9YV/ezDXInOPjUs9W3NakGyyDh0s9aFDDN8xT8vz9hOBVYoUXS8M7KuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgsRkZsR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgsRkZsR"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so901472a12.3
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 15:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711666452; x=1712271252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04wGNV2FOq+2Ciiraub2vsrzgc+rQwyjpbWoqZuUAvQ=;
        b=GgsRkZsRBQi21qDRYZtCEq8FsmuDoj24wev0QPoiCNIkYsXJBd3Tj7LbqpE+rRoedY
         BV1YLKPOCyWsZ1M9v/WpQqajiaOcgPH3mPyFznmjr0Tledckh/HvVpoSgB5ZqxLLtUze
         82DhuDqbp2jWWvdunLPJAO+5aZ+l7vr0yQ2uwqzDUIQqfxwsblJx2yME8oxUDSZO72Vk
         +CLtaOKTyorWT8cB7VohzU7Iv3t1mw25Insx2yVS1ULIF5xeQoMfYTTKo5ycToDBx2IP
         oJpKWvsZEWolgmSqSDmoUf+odTBSluLv0dYS58St4Msg5IGfYSQnuq84XcodfsJKtGp2
         NQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666452; x=1712271252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04wGNV2FOq+2Ciiraub2vsrzgc+rQwyjpbWoqZuUAvQ=;
        b=Uxt8oFzp6yzknzjVHFEPq4e0/chSpwn5/xMrVm+2mA335vt8D8aqekGbD1L/4Qnmy9
         Le636gINjvqwLd0MQtolXvEV0JdmOTJYcnmort6aHNgTn45rASJNQ4nr0twbEiOT8/hX
         vXRNiQVQfDrZRKuLfd1lL582UppZhUSRXGObzJDA0+yMT4KjVD72aomo8O5Ydo1YL4HQ
         9nL+1nw6yBKRg1GO1N0/4TogTNB5HL/exGdx2kaYwZP2yBw608oKlkJ92U0Iew4+vV8t
         tK7x7nsZzRgXLLkGAewVwnlKzvKR7NiEQczqqi8UIALR8u81z6mxtY7f9eyMGTDhlRea
         T8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA4yg04B4+1OIpXpNo2v310vFYYc+yI3YZt1K298hbMETSOayIx2FeL3Ne6AbtLAoIybWSI6roxdDtHNYisvmBvKKx
X-Gm-Message-State: AOJu0YzIW1abqts3s1etnJcsziCE41H4okmaFWvT7sG+s/Ac89AbK2Ox
	5gKmwNGcQUW2BeSrrMNOHFJetk40aZ4guaRBjRN+YuwcsmCXOk2MreOlm1fGJ7Slc29evyeuTeM
	UpeAXnVw1iQANM/XOZ8DPzUJS/iY=
X-Google-Smtp-Source: AGHT+IGZYzsrGzppwi3Firmx04LqugPf5fD+3Wglmw7igbG4SjFF7Lb+/q52aksHrZiGxUiG6/G3hxwLQwPvDz6Dy1w=
X-Received: by 2002:a05:6a20:d387:b0:1a3:3c5f:2ebd with SMTP id
 iq7-20020a056a20d38700b001a33c5f2ebdmr767919pzb.59.1711666451522; Thu, 28 Mar
 2024 15:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
 <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
 <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com>
 <CAADnVQLUVEWZB2WgkdCGkyh3T7ocZf1SkqWLAz6jGK+9LU_MYw@mail.gmail.com>
 <CAEf4BzZXYmDCP5WJ786UN+zBS4d9TrZM=cLQCZ9QihRjbriyUw@mail.gmail.com> <CAADnVQJKdwz0n207qV0LJeGyjbht4S=mme92RjwJfhCS4_dF2g@mail.gmail.com>
In-Reply-To: <CAADnVQJKdwz0n207qV0LJeGyjbht4S=mme92RjwJfhCS4_dF2g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Mar 2024 15:53:58 -0700
Message-ID: <CAEf4BzYsX__LrYpisqT2K0BpKWYoa4aXeZgcGHE7WL68Xz2djA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 26, 2024 at 9:50=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Fix in the sense to adjust or add another generic
> > PERF_SAMPLE_BRANCH_xxx value? Or you mean stop using --lbr=3Dany mode?
> >
> > > I suspect retsnoop quality won't suffer if ARCH_LBR_REL_JMP is disabl=
ed.
> > > To figure out the path to return in the code
> > > ARCH_LBR_JCC      |
> > > ARCH_LBR_REL_CALL |
> > > ARCH_LBR_IND_CALL |
> > > ARCH_LBR_RETURN
> > >
> > > might be good enough and there won't be a need to do
> > > inling in odd places just to avoid tail jmp.
> >
> > retsnoop supports all modes perf exposes generically (see [0]), I
> > believe I tried all of them and keep gravitating back to --lbr=3Dany as
> > most useful, unfortunately.
>
> I mean to use PERF_SAMPLE_BRANCH_ANY_CALL | PERF_SAMPLE_BRANCH_COND
> which I suspect will exclude ARCH_LBR_REL_JMP
> and will avoid counting normal goto-s.

This would be equivalent to passing `--lbr=3Dany_call --lbr=3Dcond` to
retsnoop. And yes, you are right that it doesn't record unconditional
jumps, saving a few more LBR frames. The problem is that it makes it
super hard to follow what's going on without disassembling all
relevant functions down to assembly and following *very carefully* to
understand the flow of logic. This is normally absolutely unnecessary
with --lbr=3Dany (unless DWARF line info is screwed up, of course).
--lbr=3Dany allows to understand C statement-level code flow based on
file:line information alone.

So, in summary, yes `--lbr=3Dany_call --lbr=3Dcond` is a good last resort
option if a few more LBR records are necessary. But it doesn't feel
like something I'd recommend typical users to start with.

>
> > I'm missing how we can get away from having a per-CPU buffer. LBRs on
> > different CPU cores are completely independent and one BPF prog
> > attachment can be simultaneously running on many CPUs.
> >
> > Or do you mean per-CPU allocation for each attach point?
> >
> > We can do LBR capture before migrate_disable calls and still have
> > correct data most of the time (hopefully), though, so yeah, it can be
> > another improvement (but with inlining of those two BPF helpers I'm
> > not sure we have to do this just yet).
>
> I meant 32*24 buffer per attachment.
> Doing per-attachment per-cpu might not scale?
> It's certainly cleaner with per-cpu though.
> With a single per-attach buffer the assumption was that the different
> cpus will likely take the same path towards that kprobe.

This is a rather bold assumption. It might be true in a lot of cases,
but certainly not always. Think about tracing __sys_bpf for errors.
There could be many simultaneous bpf() syscalls in the system, some
returning expected -ENOENT for expected map element iteration (so not
really interesting), but some resulting in confusing failures (and
thus "interesting"). It's even worse with some file system related
functions.

My point is that in retsnoop I don't want to rely on these
assumptions. I won't stop anyone trying to add this functionality in
the kernel, but I don't see retsnoop relying on something like that.

> retsnoop doesn't care which cpu it collected that stack trace from.
> It cares about the code path and it will be there.

It does, retsnoop has a bunch of filters to narrow down specific
conditions, where process information is taken into account, among
other things. And this filtering capabilities will just grow over
time.

> We can make the whole thing configurable.
> bpf_link_attach would specify a buffer or per-cpu or
> a buffer right in the bpf map array that should be used
> to store the lbr trace.

I'm pretty happy with existing functionality and don't really need new
APIs. I'll be posting a few more patches improving performance (not
just LBR usage) over the next few days. With those I get close enough:
4 LBR records waste with --lbr=3Dany.

Thanks for the brainstorming, internal per-CPU instruction
implementation turned out pretty well, I'll be sending a patch set
soon.
