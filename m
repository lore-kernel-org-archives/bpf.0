Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D166CDD9;
	Tue, 26 Mar 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469809; cv=none; b=qrJkzt5qZroCngKU0EcL1SPlKBoj9A4wZd1IxY/7a6UyKQwOuMa2pWPF7rUvNWVbMD2NivqFidoklk7Bq11qMqg7BhfNvg/wy2ZUOV3H+S1AbVOyb906eugE4RVxeK/PTXuWV6OrswqN2nkrcNcv5a+nJT7eb+DV52gwlRp800o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469809; c=relaxed/simple;
	bh=Hu751i6KRZc0EauBOtfdQ3K2MwbwDVkz3AtJAI1/HCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfT/QL5JfV+b3V+FTDh4Hf+dZNMHc4mS6zboTXnhPr4rink0FmvLfc4Yh9KECfXa9XUOTDjhSxri15MahYST7SNyUAQX4li/u3oXcfKOAnyXa32z2EmYXm9y58H2nrhG4yt7gjbsOaDwJmqAc0q+6W7QH6UBdWpsMo4yn2RVSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1L2huhj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1L2huhj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0b213efa3so20252935ad.0;
        Tue, 26 Mar 2024 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711469805; x=1712074605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elq26VvqKMTOYoZX8ejkefRVkYcEJb3PZ8dLMFD5KMY=;
        b=M1L2huhj2wsuRuEYbvx+ZINm4yBVbMP2xe3FtPhn78EuTEnOMFhE1HR9X00dFZJh/h
         Vs5qTLpOznGmw/ma+xYpe4ziKToWAJAUfjvJLlHPuhwllBD2XBU96vTc1ifCoXKT4xPt
         zlw72hyc6Npes83zBu7B/fZ02EUiiyWZt08zsRFfr0FmblQrNJuK9nT4NWRChK/qGL5r
         YEPg4npufRwJa+w5E8ONCPu3+QGwb8SLWPCszoRTZ16krE98OkDJyhvsxqjTN2bGLYJF
         9hFWzjRyke28NcoETiOlM3bqqm+/SFWeCoSrR5Dam3P0YBw1677WaB7L9XiicAwrJ4xK
         AnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469805; x=1712074605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elq26VvqKMTOYoZX8ejkefRVkYcEJb3PZ8dLMFD5KMY=;
        b=upSTKtGLe2Bd7onGx+JM9F5R8eVx4blx6h3rXO1ddpmz69GKq+gvHOGKRmfvtNBBbk
         jVabaXYXFOuw3okylbfmH+21UrsO/Uh9cjmcZB6RRdwru/VXdvZKMlBHi6ApobasrfyJ
         E2AU5vPmLJsMNxnK2mUKZJZp57nhXTe7p1Feklqws8JkAW2OnUvDWAhYyX6QgH90RLHE
         1WhbAm/EPWiUui9vjRoY13tabNZC1YWbyqjzQkigLYb9rew15wDUOZiL+qKPR81rICX0
         JXwwslb3kcGyB0vOu7RwHeacWtiupeAFnFYoXSaO0xXgYX87yBugXlp0/3X3QPJ6HKdz
         l2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9z0VghgL9BdtWF2E8vzGwA0mmK2tLzAjopwJgYbUkxlkD90b+5U7zUhnwAbxnn0P8uMDQjAXGOze4jwOfZPrSNe7al+dQp7DoDS9WwverfWrCsG2gl/b+C6ZWvhuSSxDSGstS0ige
X-Gm-Message-State: AOJu0YyyPpZBKMeccJrcAvyadh/vQv/WUXFsoS8xEmA+jLZMI2SgOABI
	Ww6NZm+c2efEfSHLK3VI11CIwlvSjUdG0disXGSC6OeYPjbWSCo0lGSaaqwUf5SoTHCzzjMP58+
	YOPQp4bvSgeQ3mN1Yby01v38Q3sI/4462
X-Google-Smtp-Source: AGHT+IGcGbVKO4Mp0HgLCsCrJhDWTqluZ8ZhttodhRfazx1mj/6+60HSyIhNiI2N9kw75dPF4YAjsL5DTsrId6wDmsI=
X-Received: by 2002:a17:902:e806:b0:1e0:f51b:12e2 with SMTP id
 u6-20020a170902e80600b001e0f51b12e2mr1764536plg.2.1711469805327; Tue, 26 Mar
 2024 09:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home>
In-Reply-To: <20240325181338.39376089@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Mar 2024 09:16:33 -0700
Message-ID: <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:11=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 25 Mar 2024 11:38:48 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > On Fri, 22 Mar 2024 09:03:23 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
> > > control whether ftrace low-level code performs additional
> > > rcu_is_watching()-based validation logic in an attempt to catch noins=
tr
> > > violations.
> > >
> > > This check is expected to never be true in practice and would be best
> > > controlled with extra config to let users decide if they are willing =
to
> > > pay the price.
> >
> > Hmm, for me, it sounds like "WARN_ON(something) never be true in practi=
ce
> > so disable it by default". I think CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHI=
NG
> > is OK, but tht should be set to Y by default. If you have already verif=
ied
> > that your system never make it true and you want to optimize your ftrac=
e
> > path, you can manually set it to N at your own risk.
> >
>
> Really, it's for debugging. I would argue that it should *not* be default=
 y.
> Peter added this to find all the locations that could be called where RCU
> is not watching. But the issue I have is that this is that it *does cause
> overhead* with function tracing.
>
> I believe we found pretty much all locations that were an issue, and we
> should now just make it an option for developers.
>
> It's no different than lockdep. Test boxes should have it enabled, but
> there's no reason to have this enabled in a production system.
>

I tend to agree with Steven here (which is why I sent this patch as it
is), but I'm happy to do it as an opt-out, if Masami insists. Please
do let me know if I need to send v2 or this one is actually the one
we'll end up using. Thanks!

> -- Steve
>
>
> > >
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/trace_recursion.h |  2 +-
> > >  kernel/trace/Kconfig            | 13 +++++++++++++
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/trace_recursion.h b/include/linux/trace_re=
cursion.h
> > > index d48cd92d2364..24ea8ac049b4 100644
> > > --- a/include/linux/trace_recursion.h
> > > +++ b/include/linux/trace_recursion.h
> > > @@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long=
 ip, unsigned long parent_ip);
> > >  # define do_ftrace_record_recursion(ip, pip)       do { } while (0)
> > >  #endif
> > >
> > > -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> > > +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> > >  # define trace_warn_on_no_rcu(ip)                                  \
> > >     ({                                                              \
> > >             bool __ret =3D !rcu_is_watching();                       =
 \
> >
> > BTW, maybe we can add "unlikely" in the next "if" line?
> >
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 61c541c36596..19bce4e217d6 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
> > >       This file can be reset, but the limit can not change in
> > >       size at runtime.
> > >
> > > +config FTRACE_VALIDATE_RCU_IS_WATCHING
> > > +   bool "Validate RCU is on during ftrace recursion check"
> > > +   depends on FUNCTION_TRACER
> > > +   depends on ARCH_WANTS_NO_INSTR
> >
> >       default y
> >
> > > +   help
> > > +     All callbacks that attach to the function tracing have some sor=
t
> > > +     of protection against recursion. This option performs additiona=
l
> > > +     checks to make sure RCU is on when ftrace callbacks recurse.
> > > +
> > > +     This will add more overhead to all ftrace-based invocations.
> >
> >       ... invocations, but keep it safe.
> >
> > > +
> > > +     If unsure, say N
> >
> >       If unsure, say Y
> >
> > Thank you,
> >
> > > +
> > >  config RING_BUFFER_RECORD_RECURSION
> > >     bool "Record functions that recurse in the ring buffer"
> > >     depends on FTRACE_RECORD_RECURSION
> > > --
> > > 2.43.0
> > >
> >
> >
>
