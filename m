Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43F2F24;
	Wed,  3 Apr 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116833; cv=none; b=LN5PfYCtjOYbR4dgIBPWFFxpxQlHqaDmLvln2UEtYatnGAvpYCSU/5xXC7zioOxLTQtxCOeehAucz9CpE9jTyZiQVI1KLpb9gVAgRRkVIT1oPoK2O+EsGNcm59a8LaiZambiUMHJfAKl0XcvLBNTYOUJ5eEKSKHToi3ZaTDd2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116833; c=relaxed/simple;
	bh=LTUZz+D5/JTV6pG16XzjSYofsaQ8i6U0m9/Lg6KUPcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMs5izMmUxfAT0u7EKT55KH4EZA7GMxhAJg5uSI6XkeJl3d5FnKuc6gd/kEILShK+hguEgdKvgEEGgm6+pZesb1qUXoPJDLfLX8O/3fla/SxGSQzqwZ7UnGU05elmSCO4XX0oA1FpHwaJy3EAIiWpE2nFsiTeU5IKWSNrRgXivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8P20mHg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8P20mHg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4628989a12.0;
        Tue, 02 Apr 2024 21:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712116831; x=1712721631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViRR7Pspb50mOxXm1sIKfzjFhEGldeN4t8fEXfZuz2s=;
        b=Z8P20mHgFQ75nxG02JcsgwpSPjiJTYQ3LISPVs4s4mFxtmlg6uMfQ1I3ClZnC+DTVs
         vT73x0ChxPkguPGS5RNzqoA7LC/acEmXn+aCsqmOZcMsZuLOFQ8NV5b6mUqM+tSSnPvD
         +r0YcZ7FGR53xoGlVXWsDfeLiXVQwqDgNxhzgOFesv+dt6wS/t0zk0DYjUxmKRE9WejD
         Ovft1hZTaqjmqRTaRetN3MiiGl6wOv6wMgOS4LRqoxXaqoeLr0y0mSBy/G/exrDCxXDh
         XxTDS7nbpPCRlMthH9Y3goDmCEz6t3u70tVm+R00mxqDqEG9y89T942jJq9dG+K/GpOP
         QRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712116831; x=1712721631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViRR7Pspb50mOxXm1sIKfzjFhEGldeN4t8fEXfZuz2s=;
        b=kKJC04OSA/dwOqURl2f03rlQdDAz/SXwl4cakZwoW5k7YJx1Hbf2fzlz2BU/B9t1/v
         gDEJw/Sc1TMpjEhLMFOa1CF+Wgw0g6RlqqKZDSjI4/Pm/ZGrKq3jqHSeH4x4wO+4eMnX
         pELKM1nwpYk4Ot415SZIdaDarLuN872TkxTKUVwFpbBbqj6QT6/+/GFc98ls+zp7pHS4
         0huCY5xWquS9O0JlZAMeeUXnv9n5jdDQbJHPPZtI2ON8fERqBr6aWUsFThKZgLF43FWq
         iGluxEfexKg4CbJ0QUVUITALHENu2K3jrQ736etsU6SSX+VDKCF+UC6zRfqLs72qhtu2
         Lp4g==
X-Forwarded-Encrypted: i=1; AJvYcCU3bnGoXUcNNOmHYeIAXGwT0af5Da2EGP2K04g+IPeWQqdBd8M9wzPEgbpPnzOSE0VRdWA1/qoV7bPoKFFpUit7jW2tRrbWKjsI2Z+qqazo6Vk0DXZt6KRlS7VjZKDJ4tOaYSJOsjHm
X-Gm-Message-State: AOJu0Yz0USb2zwwRZ1koiIbJpY6mwAPS730Q5TE/23YY6WAPlcu3DwWo
	K1WeEUJrbV98kXSJn3lVQbwzH9rtPnAA7fs+4DkO9rwDUDoymHFQC9jhgbEWt2vTNlS4zpmFg8X
	QzDQMy0QTDqRS8Xx3ET913FhPmbs=
X-Google-Smtp-Source: AGHT+IFRsJRdfA6rMVHDcIWMdVF7SBTsB8YzdSQryfE+uABcoF0bkSYiHC6ldfTN6GLCizDHtvdNNH0I+v7V7i0vUiE=
X-Received: by 2002:a05:6a20:3ca8:b0:1a3:3fbd:f859 with SMTP id
 b40-20020a056a203ca800b001a33fbdf859mr19759408pzj.2.1712116831548; Tue, 02
 Apr 2024 21:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home> <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
 <20240326150121.68e9db8a@gandalf.local.home> <20240401202552.470d845bd79c841b9158fb56@kernel.org>
 <20240401120918.67cc3191@gandalf.local.home> <20240402093839.7de89341138748f743ae896d@kernel.org>
 <CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
 <20240401224733.7a9bcbb6@gandalf.local.home> <20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
 <20240402205459.297c4206@gandalf.local.home>
In-Reply-To: <20240402205459.297c4206@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 21:00:19 -0700
Message-ID: <CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 Apr 2024 09:40:48 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > OK, for me, this last sentence is preferred for the help message. That =
explains
> > what this is for.
> >
> >         All callbacks that attach to the function tracing have some sor=
t
> >         of protection against recursion. This option is only to verify =
that
> >=E3=80=80       ftrace (and other users of ftrace_test_recursion_trylock=
()) are not
> >         called outside of RCU, as if they are, it can cause a race.
> >         But it also has a noticeable overhead when enabled.

Sounds good to me, I can add this to the description of the Kconfig option.

> >
> > BTW, how much overhead does this introduce? and the race case a kernel =
crash?

I just checked our fleet-wide production data for the last 24 hours.
Within the kprobe/kretprobe code path (ftrace_trampoline and
everything called from it), rcu_is_watching (both calls, see below)
cause 0.484% CPU cycles usage, which isn't nothing. So definitely we'd
prefer to be able to avoid that in production use cases.

> > or just messed up the ftrace buffer?
>
> There's a hypothetical race where it can cause a use after free.
>
> That is, after you shutdown ftrace, you need to call synchronize_rcu_task=
s(),
> which requires RCU to be watching. There's a theoretical case where that
> task calls the trampoline and misses the synchronization. Note, these
> locations are with preemption disabled, as rcu is always watching when
> preemption is enabled. Thus it would be extremely fast where as the
> synchronize_rcu_tasks() is rather slow.
>
> We also have synchronize_rcu_tasks_rude() which would actually keep the
> trace from happening, as it would schedule on each CPU forcing all CPUs t=
o
> have RCU watching.
>
> I have never heard of this race being hit. I guess it could happen on a V=
M
> where a vCPU gets preempted at the right moment for a long time and the
> other CPUs synchronize.
>
> But like lockdep, where deadlocks can crash the kernel, we don't enable i=
t
> for production.
>
> The overhead is another function call within the function tracer. I had
> numbers before, but I guess I could run tests again and get new numbers.
>

I just noticed another rcu_is_watching() call, in rethook_try_get(),
which seems to be a similar and complementary validation check to the
one we are putting under CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING option
in this patch. It feels like both of them should be controlled by the
same settings. WDYT? Can I add CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
guard around rcu_is_watching() check in rethook_try_get() as well?


> Thanks,
>
> -- Steve
