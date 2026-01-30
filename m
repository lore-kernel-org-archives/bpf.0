Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203130B536
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803500; cv=pass; b=j+x8ML+CVUhdel6AzsNYCjTBXJdU8QbEDxkTmA0z4rKZQyjOfl6cef7JqWPyHa+uI0sHwuTAz1TZRoJJV8gO8iXJOWDtOex53btmCK4ceD2Jb9wbgZ8L3ZrGwAciGpiR/Sz4S2ZArw9Jf2ANHsuoSvA+z3QEQSDvnke2599QYmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803500; c=relaxed/simple;
	bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhemEOIoy2fZUNcy2ol4aCtRtszvfIp1A5PPbCyCVDbU/YzF+xK4FROhGb4RfixuChi+6F+SJvPpk4odmSOWh+E11GjUzGklsm5UCPSw4kwQGC8z5duQewYYIQTlNm2o13tpdfwfnPMw2Hh/1kSZLdnM+gPjyAUpPwkrkT6biwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae/z5pIP; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae/z5pIP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c47ee987401so1054450a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803498; cv=none;
        d=google.com; s=arc-20240605;
        b=Tdg727Q9RQB5DRMM+hTf4yXVoECDmYl4HqUjeqqUuwWFOHPGCj4Z2gwqTPnxpYC5b0
         NpPFmXXakIl74Ae5GCvtWXY3G3b56qIN/SvfDb59OozIKk5HWOR8Wdk8/gkwNfYTORqK
         BNcUIBKS37VBGjlT7vXRzTa6ihyKy8cGWCaO8tM9zvwKbnMMU8SqLUAdASEk9xaTCJc6
         Acd4V/i1iZsokRJikvSF2FJdOtc7c2JcHYl+/zvigzjs1+KjC/0btfPeuA4/XpL3GOTZ
         ZPTMO9mf599x0CxJQL+IbbRCKjTefZz/T7ngmBt2hdrRn7tQqNWd0HcGDWaKVJRDzwcu
         syag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        fh=X2V7HkvyMlL85Fo8zncZMX7wuauc3N33RFlu/RTDIf0=;
        b=aWxSJK7F0qXMUIh3NHF5p2CFfLzVUNHZbaxVW3eu4a7XzsX3QoxFCOY0O7PrHOEeav
         NooMNPxeJ7OMJrkz+wgmdBx70SvR9naA/ybyxbjOSGc48Akt+4tekakrKeJ3XsCsqLbS
         sU9fD30RPS+TAbAVhPvlyKtwB2y5Ktiq8IlMIUEO975tfL/Rgc7ah9KNfuaPhnHMdJS4
         botlw9TuqhLEPx4z1oou82/mCThqAEtDFsA2nPoHr5SyFMXmD4FfBPufXfzJdjJFo0Ts
         WjDVb/is7/y+C2tq58jEnzROHOKQeAARsE8wevPsjYnHu9CJ5TlDxARAs8+45JRKRBbd
         zp+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769803498; x=1770408298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        b=Ae/z5pIP8sEBMWpbOlwKHH+5+N5k/NNnDlBqvP6ETtUWkt9EDy9ht4MsSeVU06H/0O
         4V6JkS4El4UvLaRK22Eeir1bamXb2qs4i6a3SreZlOelJezCpReBokkKdVWxLr/bcEV1
         RLKIgRpGc7o5ltcFV4aN9U0V/E1PHleEtBug1chB25yXLV7Tl1ZbTTBlbqVj2iza2fFG
         AOaQQG8jVWSus7xfFfPlJ39aIpItYJcRwAgjBxlQ0IHnOqHFDAUdvCc9u1mtQi5rGtnG
         NHP5/gZjvKtLN8Lo1DhJ463DAmF+wlQqmlgkOnMcdBg1npQ33+FA1bw0ZzcVrmcASgCC
         wWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803498; x=1770408298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        b=SIPP++Anw4XW7D1xA9KJA1XxA03hohleG62aZS24s13EFgmz8DF4/WHavg6bAGcyAF
         /F1Uqo9/IWGnUKNXbUdEzWzqCMp9fCU3KJVaUnGHV4c0ZzOCpP4CslSYvU+yF9R5uPam
         C1CY5xWVY0qn1vNcuS7g5nP2Vtz/U8vb196qLWoxgqgwFOGHUdfKeikTVY5fi/9UTMHX
         Fn88Z56vKWRU6OifZm0cluUMXPjzhvpVRXnuTOc5tiJ9/HnIdQgzXH3ke/2d/nXKH06d
         Smcal26STKf/C3eWPDOwuUMpOMXK+JXD5AEylq2sBPoTqO7rn3SimqPCaj4k/DtOXGaM
         rhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLu8VBxpYwUlce6bEOTOw6UOmKSaA/7NPWRwD9IUgJK4qMPow15EzxKZ4QJR783OgvN+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzvw73v2Lq3OP0fFf4H1Sh967GeXd0teVM6Bqf4H+8VKJADP6e
	gy4STdCed4xl6KqI4nZTXe2HL2tTQ+17khXMiQsWOrrGxAk5Ag7MPIP2ZLMHLn0Z45uPgyolYDF
	m3o9nNCRuC+dKxjsr2s18nDb9KZ5suTI=
X-Gm-Gg: AZuq6aJJwR5puC2Qz8doy4+u/ViH4ymmAeHmDhhElecDYEiiE/SK97OkK1yoRR0p+9V
	EEV9QWci3UZEELOMfj1jAxe6q1wP0Hv6VvRzj+eAyLLOUdpxVwHdTy9WL0Yk9/HrIAKAlPoN/94
	5j0jVkt1lz6D5HqkUpoyVzyrxoqNEXpHuqrsxLQQCgbroh+qP/TXfCKlpCILgBhoGXJECSsbq8b
	Dh1wq2t5m8z93doQyfp+WeyNQfxG6yP6h64ql4rclZaWjJ1Gor2Hhst7VYqgS+3IkrIPhuRgtBA
	Z2p8884FPRs=
X-Received: by 2002:a17:90b:35d2:b0:352:dbcc:d74c with SMTP id
 98e67ed59e1d1-3543c504f9bmr3899719a91.15.1769803497900; Fri, 30 Jan 2026
 12:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com> <20260130113150.GB166857@noisy.programming.kicks-ass.net>
In-Reply-To: <20260130113150.GB166857@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:04:45 -0800
X-Gm-Features: AZwV_QgnGlAMMCWYO2hOpTAbHl4pZuXMosvtjB3dgI88kFwaBbShTBvig50tbQ4
Message-ID: <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:31=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jan 28, 2026 at 11:12:09AM -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 28, 2026 at 1:10=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> > > > From BPF stack map, we want to ensure that the callchain buffer
> > > > will not be overwritten by other preemptive tasks and we also aim
> > > > to reduce the preempt disable interval, Based on the suggestions fr=
om Peter
> > > > and Andrrii, export new API __get_perf_callchain and the usage scen=
arios
> > > > are as follows from BPF side:
> > > >
> > > > preempt_disable()
> > > > entry =3D get_callchain_entry()
> > > > preempt_enable()
> > > > __get_perf_callchain(entry)
> > > > put_callchain_entry(entry)
> > >
> > > That makes no sense, this means any other task on that CPU is getting
> > > screwed over.
> >
> > Yes, unfortunately, but unless we dynamically allocate new entry each
> > time and/or keep per-current entry cached there isn't much choice we
> > have here, no?
> >
> > Maybe that's what we have to do, honestly, because
> > get_perf_callchain() usage we have right now from sleepable BPF isn't
> > great no matter with or without changes in this patch set.
>
> All of the perf stuff is based on the fact that if we do it from IRQ/NMI
> context, we can certainly do it with preemption disabled.
>
> Bending the interface this way is just horrible.

Sure, but I'm just trying to help mitigate the issue at hand (way too
long preemption disabled region). I agree that we should do something
better in terms of perf_callchain_entry retrieval and reuse, but maybe
one thing at a time?

>
> > > Why are you worried about the preempt_disable() here? If this were an
> > > interrupt context we'd still do that unwind -- but then with IRQs
> > > disabled.
> >
> > Because __bpf_get_stack() from kernel/bpf/stackmap.c can be called
> > from sleepable/faultable context and also we can do a rather expensive
> > build ID resolution (either in sleepable or not, which only changes if
> > build ID parsing logic waits for file backed pages to be paged in or
> > not).
>
> <rant>
> So stack_map_get_build_id_offset() is a piece of crap -- and I've always
> said it was. And I hate that any of that ever got merged -- its the
> pinnacle of bad engineering and simply refusing to do the right thing in
> the interest of hack now, fix never :/
> </rant>

<hug><nod></hug>

>
> Anyway, as you well know, we now *do* have lockless vma lookups and
> should be able to do this buildid thing much saner.

Yes, probably, and I am aware of a mmap_lock use inside
stack_map_get_build_id_offset() being problematic, we'll need to fix
this as well. One step at a time.

>
> Also, there appears to be no buildid caching what so ever, surely that
> would help some.

Jiri Olsa proposed caching build id per file or per inode some time
back, there was vehement opposition to it. And doing some locked
global resizable hash that might need to be used from NMI sounds
horrible, tbh. So we have what we have today.

>
> (and I'm not sure I've ever understood why the buildid crap needs to be
> in this path in any case)

Yeah, perhaps, I haven't dealt with stack_map_get_build_id_offset()
much, so will need to go a bit deeper and analyze. As I said we have
mmap_lock problem there, so we need to address that. I'll think if/how
we can improve this.

Do I understand correctly that you'd rather just not touch all this
for now and we should just drop this patch set?
