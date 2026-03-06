Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8B2FD1B6
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763770; cv=pass; b=G0kU1bTYzUnEZhX1jEooWh0Y2IXAm7yO/HUnlhaes1ibzb8f5BPdZ/Yb+fEnfloiISxvWOcCC2wpdgMRVqBsEcMv51XA94Jrrw43a2Ky45Z8PcFgo8McjxYopabATKku/Ab+M+WHOS0ugdwyBNb6hV/ihPj8e2v6RKRNYJ1FYRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763770; c=relaxed/simple;
	bh=36+GLnvjJ5wULuhs0ecsYidI2Ew/OmF323KJtini3BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRdW7fI/Thv1yaJwB3S3W+GJJL526lUhFABuGHkYV29cDSTJs99OyLVE7N34stm8y/OslZOxuo1WAwCRlGqUmSaQ5+GStuGDntvBSWp8lG/HF7xxmC+0EsviEvVVNsGXqbqUgwYw4UDPKqkA18T7gHX6CqLp98UMyeDlWr1Ubik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsBz9o/D; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsBz9o/D"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad9238d8fso8588144d50.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763768; cv=none;
        d=google.com; s=arc-20240605;
        b=EBQGemb/Yz64hiGf+8VV/VTvbdxxWjOomAV8lirNwoh37Y7eR1AXgt3Kl1BRicZbCv
         4BLJR7Hp2W34Uc7TofguDC4anJGfiY0SDJIB3WPpeDldAZUSWSqPXqSJSO2WjCReLObn
         OUighrRHU8PVyay0T7G7fMPFNYT1Yp38dy8uex1cvarzI1vxh0TE4ZiO47dvTuCIyCat
         KTYzTG6JMPP4+QLaJ1eu46otILy8ZNr4pssl45ylCumNh/YdfX408ADO6wesluD5HnB1
         fmzguBr3NLA29PZYEOYAJkq4fvuWQhd5zZ6cCROZ2d71gPRSU54NBji2G5RiCKOS/hr7
         5G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        fh=YTOuKpzNF9RswRzbsU+Tfb8f/TjyE5IMUookbT78JFs=;
        b=fBN/69aNieQHfYNtjgcwpXdMsX/Rd25disDvHTSUWc7X4AyHlC0qaDoyVFOfUjmILW
         tWWbM4JLGNOvUpDZYwWbaTTrGD7rNy0Nk5YiPKWHtaWVRthuRtZpVgAIISWyCERITE5n
         XqlQpEnXlyhOa2ujfqrL3vPCAwuoH5e/J5AkpFtnnLYv65lcvb5IUaTrkJ/RdsNdxmY/
         OtuUSNe63M7z0alpPyznlhxKCqbsxZnZwu95ocPietm16YY7lGNP91eFVwOJy6B/o/N9
         5tRTJjRoHSkbfBGPUmvNSm55Yr9IfBvk3oy03AnrgCxVYqlhNYH0RnmBcVH1B3l/Qgl/
         4huw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763768; x=1773368568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        b=AsBz9o/D/N1VRciB7rbTzhjDzZxBQJUALB/iL1fOPqg14gW+3mCX/p2hboxnk9NxOZ
         PhRqz4Oh2zRV7oiWlk2rbRGjbHxvJc/X72hT2L1YvXhJ15gx+0VAvS2Sx4jWcQmNIrq4
         tjJhCXo69E/NE5yUlmavMkhXknLVsdrxJaXIvwuSlbY+SOXgo13oGcSYYS06VNFI2ylU
         RSPu1cTeXe0n07kv+Wi6QoxFz9XdK2AWxe8MPcVuJfjKokEtl4S4hNJ/M0saL40Ngxeu
         GrCquRFI+2SPQPg0ysVDsMLusSRK5dHJMwXOeh7mTKz5nfunpEkim8HyqGwVRIlt6KQv
         lfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763768; x=1773368568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHdMl5tYDFkNxQ4eILyiDJo4EMXxr2+MOhG9NLvsPsU=;
        b=xLJRXwo58UBVXA/62QAWMDarJ338aqOOLzqfUFDsHLEaoRWB0yGHk5QQ3dKStzSZNN
         qxG5G+XWCgWH8LwdzlIUEkIxKz7NMw5EVc6+dh/D95ghsagbLJA0d+xgXrDU+rVB/18r
         Ez8hWmrLoxEm2re7daPiA2EYw/w/tMQ3NHOEWg39Yn8Zr+qm7v+JJDZR+sYx0PI7FRFd
         aiGXTNMdHHkNCqICdF82eMThzg02cyd6Wy9yHAm9BOBj/VuGyZBFyfQtRd0HptCyP8J8
         0Bh9B9W4vjTgIcz0QluIRJgFu7/MQ+gbPXUQpnZG2aVNvtSxMa5Atwd2ZHGyRF+2L7mA
         S86w==
X-Forwarded-Encrypted: i=1; AJvYcCW55aA/U6ujJJW3YZuM+APL1QdGsWubGu9hKIuyop3URK4X1DJF8P6TG2Np+M3KKk8g6Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Je29yJ1ndnh04mu42y5CHcEHQH5oxPpT52W+ron6Z6kzRF5k
	6LFNodu4Bdu1jYCnLtL6LjFUrtgBv4NJltHf+c8seqmdxe0Oz6UHuf2dr4KEqNc5Qw8fFd89Gyq
	tu0a1MDvl6LNHP9U+1/Fdpu4crHOOD3Y=
X-Gm-Gg: ATEYQzz99bUqS/J0SJLZI7LB52UkBGK7bTDGtjAGSULk4RadceAnhnUy7CW673GPBJs
	RhzXbZLA5QfsxLRE2UefcM+MghMLOV2WLqqSJs0+FKG1+29eeB40xVd5berFaT0U++QskqQ0S4p
	JsY43GvOLruvR8QML/NHRRSWo/DNuP1/cdoR0OvaaZ8SqRFWuQTFU7q2elPMnYsdDDA4ABGzNz3
	rXii9QgQKBSWABwbI2SISTIQjKwf55nhXWkIoLCYu0Np4laNOWqWD4IVFg812ZJ5H1OrZwFaynl
	Dha5GpjgrEucOGKa9Iw=
X-Received: by 2002:a53:ecda:0:b0:64a:efa9:8e35 with SMTP id
 956f58d0204a3-64d142c713bmr469298d50.45.1772763768097; Thu, 05 Mar 2026
 18:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin> <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com> <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
 <20260305082125.35d8539c@gandalf.local.home>
In-Reply-To: <20260305082125.35d8539c@gandalf.local.home>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 10:22:11 +0800
X-Gm-Features: AaiRm52hsuVqK9SgiYx4LF12Aqa_dGGhajOTkecgH3f554WneFjWnbX_KDwr0fM
Message-ID: <CALOAHbA9u2sHSYRF_kDKpf2d_UADQFu-1BMWFhBTo3mvgf6kFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <longman@redhat.com>, David Laight <david.laight.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 9:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 5 Mar 2026 13:40:27 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Exactly. ftrace is intended for debugging and should not significantly
> > impact real workloads. Therefore, it's reasonable to make it sleep if
> > it cannot acquire the lock immediately, rather than spinning and
> > consuming CPU cycles.
>
> Actually, ftrace is more than just debugging. It is the infrastructure fo=
r
> live kernel patching as well.

good to know.

>
> >
> > >
> > > BTW, you should expand the commit log of patch 1 to include the
> > > rationale of why we should add this feature to mutex as the informati=
on
> > > in the cover letter won't get included in the git log if this patch
> > > series is merged. You should also elaborate in comment on under what
> > > conditions should this this new mutex API be used.
> >
> > Sure.  I will update it.
> >
> > BTW, these issues are notably hard to find. I suspect there are other
> > locks out there with the same problem.
>
> As I mentioned, I'm not against the change. I just want to make sure the
> rationale is strong enough to make the change.
>
> One thing that should be modified with your patch is the name. "nospin"
> references the implementation of the mutex. Instead it should be called
> something like: "noncritical" or "slowpath" stating that the grabbing of
> this mutex is not of a critical section.
>
> Maybe an entirely new interface should be defined:
>
>
> struct slow_mutex;

Is it necessary to define a new structure for this slow mutex? We
could simply reuse the existing struct mutex instead. Alternatively,
should we add some new flags to this slow_mutex for debugging
purposes?

>
> slow_mutex_lock()
> slow_mutex_unlock()

These two APIs appear sufficient to handle this use case.

>
> etc,
>
> that makes it obvious that this mutex may be held for long periods of tim=
e.
> In fact, this would be useful for RT workloads, as these mutexes could be
> flagged to warn RT critical tasks if those tasks were to take one of them=
.
>
> There has been some talk to mark paths in the kernel that RT tasks would
> get a SIGKILL if they were to hit a path that is known to be non
> deterministic.

Thanks for your information.

--=20
Regards
Yafang
