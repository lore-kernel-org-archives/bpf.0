Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAB6FE11;
	Mon, 25 Mar 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385827; cv=none; b=ofCEDAoEApG4hWeJ+DsKEjYKc9HqHdAAC5YGwCNNtjpSejhhxqMm+9uJlZ+tYnpFNBbMJz2K2eT7ntaGpFyRONdFh8emckMNi7WSeAlFIizgcFXuFEafGF1XaxgAVPeJdhfTeuGfNRjZnjOfh/4EWB/do2kLGMjom+jAuyi9S8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385827; c=relaxed/simple;
	bh=EVDVyOqr2DLEVDtzz7CgKt2GBEat8en1knqFC1OKUt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBSYyAEogUdJ/RHBw+HHjuUtDAi2nUkBxzuj4S29HSdJk48KGSH5BrD23F6IP2CmdZQBLctOzH3An3b3h+Ru0M2TLKDExj7d5/vCnjx7lOaFYtM13fmcOQVH9JZLS48r/49b5p2vJNfT32pRGYdhrA6kEmuOXqIJ8BBqRUCH1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvtzkROL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvtzkROL"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3312327a12.3;
        Mon, 25 Mar 2024 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711385825; x=1711990625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUqqahf28bbTEGZZKtIOzFKvLcrkCKlJact4g1Q6s4M=;
        b=SvtzkROLmNtSYdtU/nmw6TCPBVIkZlBxDYXjNZlCtr78GeqmIcxsbYMwHJOV3Qy3zN
         qWesk4aMBevFVbXVa1w+Ilvk+175r0kdZEvyRbpSXD4e8Y1ijZhR7boxx5GFpFpYjyxL
         ADggygDC+8VGgS6KwzrUmZLXn1KqZyMuLrBJd8pQjcJK2gKLii7fCORvgx06oltawYpR
         f9X+/d0CZACN5gH+m/nqadJlOt5z/FPV+W9hWL7/ayN+HExEHChzw5huOBHpBfIceDBB
         4TkW8H+dQw4sV4uskE+x5tHNEHaUCnqzSXyc6vHY8glWBvouuMFN/vOhQASEPXJH06LI
         USMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385825; x=1711990625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUqqahf28bbTEGZZKtIOzFKvLcrkCKlJact4g1Q6s4M=;
        b=Ie1CueMHMMgD3zkacbN00RpTxPJ9Y+A17uviV8LLyqAbZfUf0JikX9AumXhioJmxhx
         GArgoGk3T4xMNwyX+/O+yuX/nkp7OIh5uUkCIMHsEnGnhKeVbuM5wk91rgPE5vF6e0ua
         WDzJaXx4UiYh7/sJPWPomm84dcTI+KQOTTr5UdoQT4yJhBs98nzVqv3V+oFdd7dEc1/d
         TlawRIw6z3d9UwfCU0NayMIJU4/GTPJ9izDaBgHzan2x695buV3HvANn7gMuaTSwh9US
         hWaNNSaGbWbfnmkTKGJIgGGswQwrc+R5kdfmjI1gbz9f8pUkMTSH+vuQ0M8OU5MhxPYj
         HL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXDM05xfdfYA57XZolCTT0JoNrnX4voy/x3UyxXUGSvGosfUemXq+aGjQZ11qr+7USPQ+MbOkr2m48vOwSxRNSOuKDQOJwpk+msk3s5YsCbS4EitIU6MOHCrCT+ptMe/8OGdrHMaNLn
X-Gm-Message-State: AOJu0Yxo16C0/PQJuz2eHJmPv/HLcArMA+h+a8eHdWKjDXBqLtSi4fuA
	6ozesNTRR+Nf0fSM+EX5C3myax1huJ021m2L4dDDIdQwMkAtTn4qqZT0rbjBSAV3XVfJh0CncjH
	2JwQoWVf7BJfvKdSRwLdyPLQllU0BRg/uU9w=
X-Google-Smtp-Source: AGHT+IHA7hRUVeBmvkDkk96ufAeo3G6gC/pxyYLkZNsqYLX68E/52XyyAIibmAxYK2hu0eI32fyooPbqUfarAAS4C/w=
X-Received: by 2002:a17:902:7447:b0:1dd:7485:b4c9 with SMTP id
 e7-20020a170902744700b001dd7485b4c9mr7155281plt.22.1711385824953; Mon, 25 Mar
 2024 09:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
In-Reply-To: <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 09:56:52 -0700
Message-ID: <CAEf4BzZy86EJ8kdxxp1srnpOzLTW6ZqaL3f+eJxFA_qSgGWqVQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 7:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 22 Mar 2024 09:03:23 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
> > control whether ftrace low-level code performs additional
> > rcu_is_watching()-based validation logic in an attempt to catch noinstr
> > violations.
> >
> > This check is expected to never be true in practice and would be best
> > controlled with extra config to let users decide if they are willing to
> > pay the price.
>
> Hmm, for me, it sounds like "WARN_ON(something) never be true in practice
> so disable it by default". I think CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> is OK, but tht should be set to Y by default. If you have already verifie=
d
> that your system never make it true and you want to optimize your ftrace
> path, you can manually set it to N at your own risk.

Yeah, I don't think we ever see this warning across our machines. And
sure, I can default it to Y, no problem.

>
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/trace_recursion.h |  2 +-
> >  kernel/trace/Kconfig            | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recu=
rsion.h
> > index d48cd92d2364..24ea8ac049b4 100644
> > --- a/include/linux/trace_recursion.h
> > +++ b/include/linux/trace_recursion.h
> > @@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long i=
p, unsigned long parent_ip);
> >  # define do_ftrace_record_recursion(ip, pip) do { } while (0)
> >  #endif
> >
> > -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> > +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> >  # define trace_warn_on_no_rcu(ip)                                    \
> >       ({                                                              \
> >               bool __ret =3D !rcu_is_watching();                       =
 \
>
> BTW, maybe we can add "unlikely" in the next "if" line?

sure, can add that as well

>
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 61c541c36596..19bce4e217d6 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
> >         This file can be reset, but the limit can not change in
> >         size at runtime.
> >
> > +config FTRACE_VALIDATE_RCU_IS_WATCHING
> > +     bool "Validate RCU is on during ftrace recursion check"
> > +     depends on FUNCTION_TRACER
> > +     depends on ARCH_WANTS_NO_INSTR
>
>         default y
>

ok

> > +     help
> > +       All callbacks that attach to the function tracing have some sor=
t
> > +       of protection against recursion. This option performs additiona=
l
> > +       checks to make sure RCU is on when ftrace callbacks recurse.
> > +
> > +       This will add more overhead to all ftrace-based invocations.
>
>         ... invocations, but keep it safe.
>
> > +
> > +       If unsure, say N
>
>         If unsure, say Y
>

yep, will do, thanks!

> Thank you,
>
> > +
> >  config RING_BUFFER_RECORD_RECURSION
> >       bool "Record functions that recurse in the ring buffer"
> >       depends on FTRACE_RECORD_RECURSION
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
