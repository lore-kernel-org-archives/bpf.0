Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4C34320C
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770584083; cv=none; b=f7MTltvnWilLhktvBvkGe6oN4zAoNpwPrHWRT4qms/sgUptindCD0K+CXEAWa7bBO0sGuQqBmkVmS7OnZxzTpdB2QN6PYJQJMviFch2+mkLaqjVFIG04gw5dZCTRm5+/Qtyj73j3V1VSqjj9z9up8mKI3D1Nkv09/bIboqJUZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770584083; c=relaxed/simple;
	bh=eK05MBlMzImiefkpgxbWyOhV3iimcUuSiDy9MKaaclo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaBG87Au8E2DLpGcvotK3zYEea9hXrWlcEDR4eIEHY3UWLth57FWl3EWE6s63pijYmiTvgqCycS+8H56KiYDt0ezISL7ICpUEw01tNISAxviDh9QpwDoqoWn76SS7+OTAzbEcjbqGDKk6WWufFs3EEKDq6vYUmbvwa6i7pV9dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlNNroyx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlNNroyx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801bc32725so17715845e9.0
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770584081; x=1771188881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7EEz2ZzYiyLdsMM9R6IByMZnU2nWj69epSM+E7T1+is=;
        b=BlNNroyxn/uXbLwXsxEsV2WCJ9mosbbv24+LgpDT5WINiiNgj1RlSWHDCZtYw4FySQ
         lhgJy7k0Lm67GTUGjKcZ5eRBQcQW6MjgKYQ92Z+80kWe1eSi1ldOFCIrxfdbKzdILnka
         i9LVKZuKFoguKOWrd5ueeSjiI4R9diFek1gWHv+znWhJbVjlAhnbUt1nPdo7W9Kebo1a
         +6gx8mS+A47Un4TcwtJ/lm6yCbxKiXfspgEKDuG3W5+AjV229XcwaqTgc8qEvikOIEH2
         r+MHlPHDLuv8uftFFZ/MrFyW1N43+1TS+2APV4++BmOPLl8DCPVXXSFr8Hry0uBobk4N
         zLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770584081; x=1771188881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EEz2ZzYiyLdsMM9R6IByMZnU2nWj69epSM+E7T1+is=;
        b=F5U0tPv7ZMBVzL6FdV0tI0486s30mvHBOW5Nny6/ylQalYOIwIaOU+vX4Im+6QAl5x
         BeszaVoeveJoRpqcFJA+yzC7T1ukoa/z1mX1LKEThk6C5uRizd7TE3L0t3opDXl1YUSa
         Ph7KEmrwJloMZHQQhfu99IiTiKZHk94a0kFZf14RZsmOygChe1QMrBNj5j4KQRo0ccp5
         apw9RV8MBeDbKa7CRhDCn1OMk7eCsS5ImL4n/BY7YGuOvtJC37r/r+04+Dv9bBn39s3Y
         zH0+CI1lvyYGGfHMzHHiStMwAUoxXoAKpQ4rLr2Nm736uRJywuXdz+fXOGTJFcpDBUmJ
         mtkw==
X-Forwarded-Encrypted: i=1; AJvYcCXCw8jbX71HKh+YCa+0v4xVOfx/WKzD9r0752k8kg/M0ep2T3YYO6fkeTdj/8Md7MkoojE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiaJ000D/vsx+AFGCG/+eLzebIKJwn4X0yhltZnux75hKN7jc
	1eU0n0qkcwZuvuIkYou+viDVrkax/sKWI+GveUABJwsRxj0Ac0l23ycs
X-Gm-Gg: AZuq6aK5wrx/NP67mbTAEbjrYhAb2SS+xmWE95tEgKJtPEcONA5FrS+Pn9RUn7HCSFm
	+tkyzfqN7LuLCO1vEQJvi27Xq0JROnuoOjXCCAhLhoO4/mFMBC3YA1prMUbMGAuUMRENMaZSf2s
	l6wjOvA9XLr2LOwVnQtdk+4JttKBtU2rOR2WJ7QBCTM/fhBK5v5GVlbtd0xmQKBjFqpNHTi/O0E
	jP8+HeTidXAv0c1DC3OyI1Ygt3rJh0jR1DArfGW16ARFTW8ws+dBKrEeX0jiP0AUrakVLg6/eyS
	63JOde0gL45L3FFq5Dh/8/J1kTyJDJ2zG0yJ5hKsJPrnTnN09ijn8MXccFzmo6cpCviZUBKl9Qq
	8QybFXY/AcaArJmsGDqLUquUvUHzmQaw62Kop6ZZFhP/goxUJv48RlFRKNvDvFRCS56HeAkbV1+
	Y=
X-Received: by 2002:a05:600c:1e0d:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-483201da2f1mr132554955e9.2.1770584081273;
        Sun, 08 Feb 2026 12:54:41 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm22939470f8f.13.2026.02.08.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 12:54:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 8 Feb 2026 21:54:38 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYj4DnCDlUHUSPgU@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
 <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava>
 <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
 <aYWjxMeXABGcYqEI@krava>
 <CAEf4BzbUX8xEp1x66ugtj1C6sxWPJ+_9EpyVmy3TVOMiKrFcWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbUX8xEp1x66ugtj1C6sxWPJ+_9EpyVmy3TVOMiKrFcWA@mail.gmail.com>

On Fri, Feb 06, 2026 at 09:03:29AM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 6, 2026 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 05, 2026 at 07:55:19AM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 5, 2026 at 12:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > > > > On Wed, Feb 4, 2026 at 4:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > > > >
> > > > > > > > hi,
> > > > > > > > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > > > > > > > link that does not add static trampoline but attaches program to all needed
> > > > > > > > trampolines.
> > > > > > > >
> > > > > > > > This approach keeps the same performance but has some drawbacks:
> > > > > > > >
> > > > > > > >  - when attaching 20k functions we allocate and attach 20k trampolines
> > > > > > > >  - during attachment we hold each trampoline mutex, so for above
> > > > > > > >    20k functions we will hold 20k mutexes during the attachment,
> > > > > > > >    should be very prone to deadlock, but haven't hit it yet
> > > > > > >
> > > > > > > If you check that it's sorted and always take them in the same order
> > > > > > > then there will be no deadlock.
> > > > > > > Or just grab one global mutex first and then grab trampolines mutexes
> > > > > > > next in any order. The global one will serialize this attach operation.
> > > > > > >
> > > > > > > > It looks the trampoline allocations/generation might not be big a problem
> > > > > > > > and I'll try to find a solution for holding that many mutexes. If there's
> > > > > > > > no better solution I think having one read/write mutex for tracing multi
> > > > > > > > link attach/detach should work.
> > > > > > >
> > > > > > > If you mean to have one global mutex as I proposed above then I don't see
> > > > > > > a downside. It only serializes multiple libbpf calls.
> > > > > >
> > > > > > we also need to serialize it with standard single trampoline attach,
> > > > > > because the direct ftrace update is now done under trampoline->mutex:
> > > > > >
> > > > > >   bpf_trampoline_link_prog(tr)
> > > > > >   {
> > > > > >     mutex_lock(&tr->mutex);
> > > > > >     ...
> > > > > >     update_ftrace_direct_*
> > > > > >     ...
> > > > > >     mutex_unlock(&tr->mutex);
> > > > > >   }
> > > > > >
> > > > > > for tracing_multi we would link the program first (with tr->mutex)
> > > > > > and do the bulk ftrace update later (without tr->mutex)
> > > > > >
> > > > > >   {
> > > > > >     for each involved trampoline:
> > > > > >       bpf_trampoline_link_prog
> > > > > >
> > > > > >     --> and here we could race with some other thread doing single
> > > > > >         trampoline attach
> > > > > >
> > > > > >     update_ftrace_direct_*
> > > > > >   }
> > > > > >
> > > > > > note the current version locks all tr->mutex instances all the way
> > > > > > through the update_ftrace_direct_* update
> > > > > >
> > > > > > I think we could use global rwsem and take read lock on single
> > > > > > trampoline attach path and write lock on tracing_multi attach,
> > > > > >
> > > > > > I thought we could take direct_mutex early, but that would mean
> > > > > > different order with trampoline mutex than we already have in
> > > > > > single attach path
> > > > >
> > > > > I feel we're talking past each other.
> > > > > I meant:
> > > > >
> > > > > For multi:
> > > > > 1. take some global mutex
> > > > > 2. take N tramp mutexes in any order
> > > > >
> > > > > For single:
> > > > > 1. take that 1 specific tramp mutex.
> > > >
> > > > ah ok, I understand, it's to prevent the lockup but keep holding all
> > > > the trampolines locks.. the rwsem I mentioned was for the 'fix', where
> > > > we do not take all the trampolines locks
> > >
> > > I don't understand how rwsem would help.
> > > All the operations on trampoline are protected by mutex.
> > > Switching to rw makes sense only if we can designate certain
> > > operations as "read" and others as "write" and number of "reads"
> > > dominate. This won't be the case with multi-fentry.
> > > And we still need to take all of them as "write" to update trampoline.
> >
> > this applies to scenario where we do not hold all the trampoline locks,
> > in such case we could have race between single and multi attachment,
> > while single/single attachment race stays safe
> >
> > as a fix the single attach would take read lock and multi attach would
> > take write lock, so single/single race is allowed and single/multi is
> > not ... showed in the patch below
> >
> > but it might be too much.. in a sense that there's already many locks
> > involved in trampoline attach/detach, and simple global lock in multi
> > or just sorting the ids would be enough
> >
> 
> I'll just throw this idea here, but we don't have to do it right away.
> What if instead of having a per-trampoline lock, we just have a common
> relatively small pool of locks that all trampolines share based on
> some hash (i.e., we deterministically map trampoline to one of the
> locks). Then multi-attach can just go and grab all of them in
> predefined order, while singular trampoline attaches will just get
> their own one. We won't need to sort anything, we reduce the amount of
> different locks. I don't think lock contention (due to lock sharing
> for some trampolines) is a real issue to be worried about either.

nice idea, I'll check on that

thanks,
jirka
