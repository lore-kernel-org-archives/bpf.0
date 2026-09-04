Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2953BFACB
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492633; cv=pass; b=WAbwstTXuaanEyFhH6rihBWGgTHkzkAyztGrr8HX9D3O5jA3MpvOPGLv7AXoCTywSbrb/gxYJxlqqLk0xmdNRZR0nsGqUZ80qGbxVGuRdJyrbmcedrZU++7eP2JFxVWlkuAF4JktBIDoihpClviBDxKmO4mmWa0K/eZVP6HK7yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492633; c=relaxed/simple;
	bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MquSGRVI5SW1W+dT7rPlIx9LcL51AyvnTPzwSbDeVLabQX2DPFpMwEvGHALb4uANOXweUn01EkymEV0B+ApV9v0QL2DMsi7F59chAsVLBlLzjjV0TjEldBgwNL8yfi5QQ8oF9ncFjTQ0edRNn1pGAjyh6dLx330k7VoW8ucE9X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DScELcuC; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DScELcuC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso435216b3a.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 20:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788492631; cv=none;
        d=google.com; s=arc-20260327;
        b=cDgXUqdliZ7/OJ4rlWQst0atGNjGJFpzK1AsFRWFLrVQDYZzc57jGay7SEw1/2tWlX
         U9kJElADVnyHVZ2k5PsmFozY7CSQcZjnhOE5c9llrxTMrWpRgk8J2lPt27U+SWE2KnHo
         28N6Aere/p8T6UpWLyt/TNIyLBR0tAkg7U7hQUdL6PfLxnNLJeiO3EmxHLeuY/ch7/ga
         C1uwsI9FYEUJayyyR3es1XHc9EyIfTDG6VarTm9ZnUS9lGn25gUwZS1RMOZS43QQ8KoW
         YqSRuGV9wSlLdAj5fqnrIuTrCVfxhLWc/T+RKhQ6oJO7/VTQ9w3X33s+iQoF0SPaB9Yu
         OHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        fh=A34Dr6zItjbvWfocghnZ8vyN4Mi1OMmhb+5vajPFabU=;
        b=oEs21RpyxXgSf4fnkvvkwDSaoEWhO+hrt0tgQKgMSbJ1SY9wnA4lT/34lBplsiEa8h
         LQOy4GnwjULPIORBIaxsPbrc/8QZJHxC7kAhm/avFBl9g1bPknl8Cgu5T2xjfYU4zRLo
         ZbNvJcF6sH9gl/K9vj+RYjC4+Gm4AleoXIWSQQPjTQgCoZ65OEMNYzbTa8eb2wLhvrRN
         EZ9toGV4vRUTksRxaRN2wfI5V5KPLTo5lLl1NIE45JMUbu1GlAgNrzzZbCSDMyRPZIch
         KlKHjCoOtrVyAuXydNwmxOsljwzR9rSd7Rq5itVSXmLL1FH/6YBZuNgFNCZeA7rwEBqa
         D5cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788492631; x=1789097431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        b=DScELcuCtb9njzxK1FBbOSv40paWPLLE1GjOOkMorvsNbq84XSpo7TZu9tzsRDFEfd
         m4SnWnVQYv0Qv73p9Zts2mnoDB1GQmzVgnH7XAzwGZ5+r4MEY9jys8kRFkhkHeS++nVb
         fzRxtWsZqIDZ6E4vCoeBLXQWdM6R0mmarOqSgy1LofWrnJeqprtr3sVfzGUJeKFUWCB8
         etZt294N1SZHavEsg1D04JvYSX/vQ5FcXoT+f8S6PHe1hy/ZXTQyacttti+ddHRYz0DM
         tOx2Yo5D+RnJAV8dfsiFyk6Ia9D4eKhLmlgy7wG9fN6g7VfdY4RKJK5fqyYh+aozjMw7
         hfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492631; x=1789097431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89OZ28yLXrgIx5/x+Z6isXYU+LEYVlikGayjBJlRd0o=;
        b=LdF7oajMK3SyOqHf3xU5Rw7Jf4BNwFwam8IiazUEwudG5ekQiMDvMj1kDBaVoS8vU1
         nEdynTA3l6OulzPPr1ighCr9yxZVyse7l78uXujIN9pMz4XxUJH969xoFbHYaBRdCGsZ
         7rzke0lFD9toTXoGfnHFEEOVfkUTZ/6NiDGkj7kjxUpGzEO/P4bGSLLqkG4reKpszBmY
         jswJiZLLIlLyXE8QUNj75mDmgHCJqWLQHyuUSfZfrsUXdv8kVV2hdF2vOcBucqSb7LJu
         HsbDZe4kd/8la+qJnWvqHiD/zuQynrQJ5AEO+q5j8WA9Ls4ckPiDd2fspQIPnfg8l9S2
         7PjQ==
X-Forwarded-Encrypted: i=1; AKwUvByEaGauFI4FVItbkp5kGJ483N9mbz6mTY6qNodf+O07TSd+cXqigU4OXJ+mAwpb3Wz20So=@vger.kernel.org
X-Gm-Message-State: AFuF++klIKW/4dGfylLIO3aLCeCXeOSXnVvnKURec7FMU2/2kdD6cu8v
	6SxhM7Bgy2cqHASqW5zkrAtHuBsj61Unwz21/sgC+3mPssEj885tLjbd8T99Q8ZJ+CllaOj5pTY
	ttCB0eAmYy8fCvMC78UdgpKSEleJlLow=
X-Gm-Gg: AYBFou3XYIkDIeTKQPtnHtox39VZSNk234AG6KQpdJjU1UGQAjuMzQ/ynKjr8ooaAHU
	T29+xgLkxpkQYmMY0b+6NbE0LEBmYt5sgJPiCMZbGEBKnlQ0L4IjLlzklmfUX0ZUJNPTaoZ2qmL
	Ifsy+YgGR7UhBEtxycAufbhXj1I6BkA64fHrSCHKnx5DRP51uzRiaKTjh837l6+yVWbEI3Hv/o3
	ZOh8yvs3kcdN/8b0/x7uJyE0sW6aV63+9RGQsKs0W+MxKLwt+1ju/bu94Cao9ayY2QaZFhDPIEq
	Pds8UwfMEyrOiT4heit6pSZMdWYAfsjbK837zaq6CVFRPP+X5OUw1l957Ktc8uLpdTIpv/ZxEqb
	UrrRzzUxJAwJsgrTIUxzXwieurC4WNiw7OkbXqUQ=
X-Received: by 2002:a05:6a20:e607:b0:3d3:adbf:777f with SMTP id
 adf61e73a8af0-3da3a16a54cmr4369460637.20.1788492631017; Thu, 03 Sep 2026
 20:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
In-Reply-To: <20260903090211.50d15220@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Sep 2026 20:30:19 -0700
X-Gm-Features: AcwNN1WyvVt58Liz16r7F9vxR4fcT-OGFxVmu7RBiJk3u4EIptgNFRgcOxI3zUE
Message-ID: <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 03 Sep 2026 09:21:18 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
> > On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:
> > > I don't think bpf fits here. I haven't seen active use of RV and even=
 less
> > > so of any request from people who want this kind of programmability.
> > >
> > > So Nack for now. Sorry.
> >
> > Thanks for your opinion, however it sounds a bit harsh to me.
> >
> > RV is clearly not a popular tool, but I wouldn't say it doesn't have ac=
tive use:
> > we're actively using it to validate the deadline scheduler/server chang=
es and it
> > already found a number of issues (e.g. [1], [2]).
> > The RTapp monitors are used to validate if userspace real-time applicat=
ions
> > interact with the kernel in the best way for predictability, as far as =
I'm aware
> > that's regularly used [3].
> >
> > In my eyes, the missing piece of RV is in fact this programmability. Ad=
ding a
> > monitor now requires to write in-tree built-in kernel code.
> >
> > There are strong use cases for domain-specific rules that aren't genera=
l enough
> > to belong in the kernel tree:
> > * stricter RTapp rules that may not apply to all use-cases
> > * verify some exotic system within Linux (e.g. a co-kernel [4])
> > * modelling for functional safety certification process (used for in-ve=
hicle
> > OSes like RHIVOS)
> >
> > BPF seems the natural tool for the job to me. Mind that RV monitors wou=
ld be
> > simple users of BPF, requiring only modifications in the RV subsystem b=
ut using
> > standard BPF facilities.
> >
>
> As RV would simply be a user of BPF and not modifying BPF infrastructure,
> I'm not so sure you have the jurisdiction to NAK it. It would be like me
> NAKing how you create a trace event.
>
> RV monitors are a very good way to make sure the system is preforming
> properly. This looks exactly like a perfect use case for using BPF instea=
d
> of having to install modules.
>
> Either BPF is a tool for the kernel or it isn't. You can't judge where BP=
F
> gets used. You can only judge on modifications to BFP.

Ok.
Please add
Nacked-by: Alexei Starovoitov <ast@kernel.org>

when you submit it to Linus.
Let him decide whether bpf maintainers have an authority
to say where bpf is used in the kernel.
