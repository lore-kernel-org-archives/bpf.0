Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395F42EEA3
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344129; cv=none; b=gbg8TX4xeaGecJg1FDeiX/j+BHIcD6l0S5oZCCatRYQawBqrdNLAqzn3XEp6JsaTS7IUydYoU/d+EuuxIzJKN+Mu25evzeKRbNcT3W5YDZCKXrA+geiY4oyjBbO7DyF+th/SRu/5qxPPh6HJmilI8tSGho+AP+mOJAqbiie6654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344129; c=relaxed/simple;
	bh=04L/X7xS4hxtsBnAxJ/MGousDzROfCvyRKvzwSCrUzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SO5KubNT76qNgRcfDJqkXl7FAFU5tPXEl2f7pTDQ/GhYWPC+WcWyvrP9Cb6jXZbcUJ9WA5uc+fDd6mMC7FvvP13EONAEmAnb/MmVNDiGrTUwY7uXDEhahNxEGKr8K8vPyIMIcKSuAVOYmwOzBtJiURPcVxWzJEx967Vs4xXLjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7Odf6lN; arc=none smtp.client-ip=95.215.58.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7Odf6lN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=04L/X7xS4hxtsBnAxJ/MGousDzROfCvyRKvzwSCrUzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788344123; v=1; x=1788948923;
 b=n7Odf6lN+pLW4bWmX+QfS5XE0Em4JEKePDEyZZkBH7F1dhO0oPXFjGIViqdVrgaaomgFBOIt
 +rr53Yt8aC1EWXhFztF6JC4Bqtu9mU1gLjJbP6Awq1Ubn/sqNIL0jKt8Z6S2T2LBw5CBCcJrMzZ
 ioQhh/iS3XGqXePkZdtbPDqE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cec16e1254e83e61;
	Wed, 02 Sep 2026 10:15:20 +0000
X-Mizu-Trace-ID: cec16e1254e83e61
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 10:15:19 +0000
Message-Id: <DL4R2YXF9J8G.203VBANYFFSET@linux.dev>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Jose Fernandez" <jose.fernandez@linux.dev>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
 <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com>
 <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
In-Reply-To: <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>

On Wed Sep 2, 2026 at 5:57 AM UTC, Alexei Starovoitov wrote:
> On Mon, Aug 31, 2026 at 1:58=E2=80=AFPM Florent Revest <florent.revest@li=
nux.dev> wrote:
> >
> > On Mon Aug 31, 2026 at 2:43 AM UTC, Kumar Kartikeya Dwivedi wrote:
> > > On Sun Aug 30, 2026 at 3:21 PM CEST, Alexei Starovoitov wrote:
> > > > On Sun, Aug 30, 2026 at 3:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > >>
> > > >> Overall, looks good to me. Thanks for the fix!
> > > >>
> > > >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > >>
> > > >> Note for whoever applies this: please add Reported-by: tag for Sec=
hang as well.
> > > >> Optionally, wordsmith the commit log with the suggestion above.
> > > >
> > > > Hold on. I don't think we can proceed with this fix.
> > > > It defeats the point of fexit jmp patching and keeps progs
> > > > pinned until a sleepable kernel function that were attached to
> > > > will return. Which means that the tracing prog attached to "unlucky=
" kernel
> > > > function that sleeps for an hour will stay pinned for an hour.
> > > > Let's think of a different way of fixing the race.
> > >
> > > I don't have background on the original commit being fixed, but is th=
at really
> > > realistic? Or worrisome even if it happens in practice, since worst c=
ase the
> > > program refcounts remains raised for that duration?
> > >
> > > We have similar worst case for programs too (e.g. using bpf_copy_from=
_user on
> > > user controlled buffer in, say, LSM progs). At least here we won't be=
 extending
> > > any RCU flavored GP.
> > >
> > > That said I will think about alternative fixes in the meantime, if we=
 accept the
> > > premise that we don't want to pin program references in the image and=
 keep their
> > > lifetimes decoupled.
> >
> > How about having old trampolines skip freed programs instead of keeping
> > them alive ?
>
> Isn't it doing it now?
> That was the whole point of patching nop to jmp in a trampoline.

Just to be sure we're talking about the same thing, you're referring to the
"ip_after_call" patching done in bpf_tramp_image_put, right ?=20

My understanding is that this only helps in the case where a task is in the
traced function while a prog is detached. It'd make it skip all fexit progs=
.

But if a task is sleeping in a fexit.s prog for example, it is already past
ip_after_call, so this patching would not prevent it from calling a second,
freed, fexit prog lined up after it in the trampoline, no ? The same situat=
ion
should happen with a sleeping fentry.s prog followed by a fentry prog.

I have a reproducer for those scenarios that crashes bpf-next. I will make =
it a
selftest in v2 like Jiri suggested.
