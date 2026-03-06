Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59402BF00A
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765720; cv=pass; b=Gbd0XEx9NvAS0Dt5Ll1yPn6EgqN0OVEM5Bo2TS3MGICSGvGKbXxG2YK9f4QfR+4WAfjHTXM/DWVQl+JSzLbCgOLHOcSUmaGrKRi0JZcFVLyxu7fldbfGOtZEamiOa6MzM1NbkgBPQhlgPq2I0JjKCv2WzMOTZ/DTZdTgitW+2Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765720; c=relaxed/simple;
	bh=/NtCZWUeebN/TRxaCIQutZGmCkfLlW6C7neCEIHydyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGR5fty52j+XuJX/J1n6U6/WUGxqsrdHLKdN++Xh5DPiAMaXqYY6Wr0S7rcOJ/UjaFyS6SBmJKaeiAVTK7bKaft01wxzwK9unxrjAnJAzmNJTUfOWgh1Vjc4UT8TnXnplzDPr8W/XfdExUish7oQonoRLFSd62JhFn9l2kiVroo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExoT+xjV; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExoT+xjV"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so1517946e87.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772765717; cv=none;
        d=google.com; s=arc-20240605;
        b=aa97/aAMiNw6FiGF85nM0XWB2uET3qCxi1NgXwx4Rdv3YBdeTsFkb+nJsMxFDSF3bP
         N4ria1Tzh6Ox+6zYo3kVztT1lAhxtJAFM8MRnZh+EVEUsZdpX1Dvsgw8Fd5QneuiXkU2
         jOPcx9M9Z0kCR8y9+RIAeDKSbIfwG3DV7o9fpvD9EDqyFl8fHEy5f6Q/TvS+l05gPob1
         5c1SsvcjHZkSCu5fi4hTUb/nP1y3yTt1Xls58SZm0LnDUq4DNcbvm6uTrQD4ddCS/q15
         9vh54EKtbgeBs6LGxFANqLkib7EaWxUVKExVtmiqRBBBmqeZmDWhRZfigpcQtyymuV+3
         n8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k2e6YbnRNOVTLYRZK3+DWwMObfk0GozLNph8q8/iMpY=;
        fh=E937xQ/Iaohrgq5qd6gBmxFqzwnHjCUxphQrWPZ1h54=;
        b=juMPl2Pn3JbzW3wXA3vXLbXrHvRKaJdOSio+h/UkFa/ny8C/DX80omFclmLIxyV06S
         tnn+FGwdrDwHNY3b3YY2EqH3kanMEe83MbvI3SZ2/ZKbYRQcAnCo2GpjoiE5BEDVLqCR
         dLlK6kBggMFvtW4Hx3TF1IXFFL8kjXzuDu0NRx/dGB7f6tA4y3lOby1ev0FDhqNKU7J1
         +hAXk+YWv8xe/cbVOEMM6G1ER7cqt8GMMtJEHIjS0YOpBPW64xB+o3wDlmnN9mIDacBk
         eAhC/gbThCPXe9+oLoHXYRAjOqzcpq+m89Mzbsz8viVPYPjMg4jA2gHO9iEBXoWKbr8D
         GJUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765717; x=1773370517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2e6YbnRNOVTLYRZK3+DWwMObfk0GozLNph8q8/iMpY=;
        b=ExoT+xjVkOh58dRHfeutyBAb/DjjMOMxDSzVEXhzVL2U6NoxE9uxxeUBKSm1ROC43X
         +kO3wJw6HPPz3ZKO8QKsXVqOwCnKlDiw3pwccWwqtNLmX700cwygophgVZ36wlvENo/u
         uHnSaY2OAVGeJkIjAdLPehfEpmCq2ybcnmxEW9FklBZGY81acDtaZAyHZYJlLxCOxqfa
         2/uGB4md5cCKdTpH3M0myc+pnTp2I1iQODV2LM/SxkdTFF+HfFfkyq1N4KhyDzjoXJmB
         38iFEgADk6/6y2TcuFSVuOPthgkhM03quFS+6pcXxfzvh4JMhEE7lsBbMOfGvgBSWP0I
         f/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765717; x=1773370517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2e6YbnRNOVTLYRZK3+DWwMObfk0GozLNph8q8/iMpY=;
        b=FXjwe8LHeV1E2SQpFL4Pg8sCI7AwF+2Q/1cH7r4NCYgdWni6QuqWvpKoujn3/66Os6
         wawfdmFBggKwppRbYu81PmjwhDtB4+z1zRyoqMOwAK/Zxwpw+VKS919KtIz8go08O9Dd
         lbf5IKn/PKUvU4oJqNTJkQ9+uUsHy6BNtUDHZARJv83JTkxp2PnzeaNLfGXNJP4C6Gs6
         TKVadmO7OHizeAtUWzOKYOQ+Fec/2o68vKUBSDD+hOEQC0PQuQsDS8u3m6Vg4gTnVu89
         QYrSI31cpjP5XLpu4imeryHMDeBGm4bBaow1w0Nv8dVoQVeRoxRs6deNiqLPs7C72JA5
         JYig==
X-Gm-Message-State: AOJu0Yw/jpFQ089nj0CBhekAqvPaD4Qnb4EtlSbjN6f83sRB3AYmnWjt
	WBX5fKKjnAsKaPpZieZd0JCNHDseIdSH1BSa5mz1T3jE/NFxZf6qvt/2hG+Nsl3r9wjD02o5GDU
	INoXCocPOW5VqHgmGWpWGljKgYVinmBE=
X-Gm-Gg: ATEYQzyB4ki2JPVDGolJSsxMU4wJ+o7ruukmtf6C81JqczZRj0x9Wpc793OU2IOZ+/G
	OGl8dmP/G0R2pzNgQmU/dard85zlGAJr2s5ykQyvZ/C1ViPRnkIxthDlwyq9QywBjjQeTC9efwS
	HbvNYUkUqFOsbK9ocLIN6TY7Xik/ZTAuWmFR1SBKuEu5zvlXTq0MYz0s7zOUJgbbDRh6VfgEWgs
	XefuOv8DhjfpxqzZbcapwPWJP/tKwK6nxdvAV1l7AKEdG2KA1jeZJtQk0sRm3adn47zcMFmdjrI
	004Y7HX4fla1S5/RxPNuqUOnD6H6BWSMSGeWypfEDyuns3y4fWg=
X-Received: by 2002:a05:6512:618c:b0:59e:465c:3b1e with SMTP id
 2adb3069b0e04-5a13cd5e330mr94790e87.41.1772765716831; Thu, 05 Mar 2026
 18:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org> <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
 <aamX8uw8UN23rkc_@redhat.com> <aanBUeT2kQKpDWxZ@redhat.com>
In-Reply-To: <aanBUeT2kQKpDWxZ@redhat.com>
From: Max Ver <dudududumaxver@gmail.com>
Date: Fri, 6 Mar 2026 10:55:05 +0800
X-Gm-Features: AaiRm52ttWHd5rGFEOZNWLFuSpVm47-TyXQ7hK7vuisnlMyDJgQNo35upqKyEV0
Message-ID: <CABjJbF+vEwEr4fQo7zZwFtgPSJGM1veFnaaLrupOzaVDoi3hJg@mail.gmail.com>
Subject: Re: Process killed by seccomp looks live by tracer
To: Oleg Nesterov <oleg@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the `WIFSIGNALED` check, it does work at the fifth loop.

>Why do you think this is wrong? (and I don't think this has something to
do with seccomp, btw).

I suppose it's more reasonable for kernel to give a hint just after
the syscall killed by seccomp at the fourth loop. So that we can know
the syscall is rollbacked, or else we can only assume the syscall may
succeed.

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=94 01:46=E5=86=99=E9=81=93=EF=BC=9A
>
> That said...
>
> __seccomp_filter() does
>
>         case SECCOMP_RET_KILL_PROCESS:
>         ...
>                 /* Show the original registers in the dump. */
>                 syscall_rollback(current, current_pt_regs());
>
>                 /* Trigger a coredump with SIGSYS */
>                 force_sig_seccomp(this_syscall, data, true);
>
> This means that after syscall_rollback() regs->ax =3D=3D orig_ax, so
> ptrace_get_syscall_info_exit() will always report .is_error =3D=3D 0.
>
> And since force_sig_seccomp() uses force_coredump =3D=3D true, SIGSYS
> won't be reported (see the SA_IMMUTABLE check in get_signal()).
>
> Again, it is not that I think this wrong. But perhaps Kees and Andy
> can take a look and confirm that this is what we actually want.
>
> Oleg.
>
> On 03/05, Oleg Nesterov wrote:
> >
> > Hi Max,
> >
> > On 03/05, Max Ver wrote:
> > >
> > > >This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before=
 seccomp filtering has run.
> > >
> > > It also happens at the syscall exit. Take a look at the result, it
> > > shows 'exit ok' twice.
> >
> > Why do you think this is wrong? (and I don't think this has something t=
o
> > do with seccomp, btw).
> >
> > > If we can agree on this is a bug, I suggest the kernel give a hint
> > > about tracee exit in waitpid return value, what do you think?
> >
> > But the kernel already gives you a hint, no?
> >
> > Perhaps I missed your point, but see the change of your test-case below=
.
> >
> > Oleg.
> >
> >
> > --- /tmp/PT.c~        2026-03-05 15:18:18.397319905 +0100
> > +++ /tmp/PT.c 2026-03-05 15:40:11.044415647 +0100
> > @@ -15,6 +15,8 @@
> >  #include <sys/wait.h>
> >  #include <threads.h>
> >  #include <unistd.h>
> > +#include <assert.h>
> > +#include <errno.h>
> >
> >  void
> >  child ()
> > @@ -57,6 +59,14 @@
> >        puts ("child exit");
> >        exit (1);
> >      }
> > +
> > +     if (WIFSIGNALED(status)) {
> > +             printf("signalled pid=3D%d sig=3D%d\n", pid, WTERMSIG(sta=
tus));
> > +             assert(kill(pid, 0) =3D=3D -1 && errno =3D=3D ESRCH);
> > +             exit(0);
> > +     }
> > +
> > +
> >    if (ptrace (PTRACE_GET_SYSCALL_INFO, pid,
> >                sizeof (struct ptrace_syscall_info), &info)
> >        =3D=3D -1)
>
