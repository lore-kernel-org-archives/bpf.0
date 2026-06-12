Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E5388E4E
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304669; cv=pass; b=S+0UooTp/dhmw4CACAtPHJj1g58x3Ke6g4zWs92LRpf9BryHQLhXP9uPEhHEXaOwU7wczNzV8vIlXG0/8P/oEpj659eeQ3iiBjlPDBpbhJC5+FWe6gri+V9+yNeBiEBqyis+R/43k3BGCBZJ3ir2wX09TZRRwvQ8X648hJ57xo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304669; c=relaxed/simple;
	bh=sFT+XzlKpv4SUnajwscPnJF8p5NOz9tEidbYoBHNmNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSgXtvKeVi8FgIiZK0pTgjoPhvb0lo2/W4fxThTCM8LbgsKfXavCUaN3CkFMyNnWX+iBe99COsoOla95zFunjIGIHClsalPjOQbgx4u3mwkTwL0t+kegkjrdid4HW051mbA4YI5wXXKL90ar0bbzsTm8aTvmqGf38To1LfhRyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=xH2cGArT; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="xH2cGArT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa69131836so1374332e87.3
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781304666; cv=none;
        d=google.com; s=arc-20240605;
        b=aVrZNPP8Ibq82HtTbtjA4Ud8jVFdw709U17kGATPof1jALWDqhz5cY7xY/M8Z3lRWe
         TdInRY9Cl8dF1oDi/0Czy9r/XAJhjlX2PjHyW8rMmV1LDOnpl5GC0HiJLEclFgixAy9m
         Ct3Cr/v66xGI/JZ8E1oV3phbv2AIKpS3m+2ooM37Gbr4Kx9N35lOanKTDb9U5e7vmKqq
         8k13YJDLgppNMJRlr4wfvxfs75iNyyka2FxsFLQkowBeeIxIDCE0nlo9Nx3c/taOhj7+
         epVQPndnm6fUVC6y6OMC89VX5fhKDiBvbovpvLrVOQ3rq70mTJnhNLVIswrh1txLD0sS
         0YjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dujGfjjYzIobRUfmhoS0JnZwiM+XACk6xmwNRmTPVO8=;
        fh=Uh50bsNPwSQ5tm7dvLiAHLE09qf69wr/Zq/mBTuR7to=;
        b=b15HmrPF8awATUGDpaJPPp3nmD/WC/L1WL15vsfLPlsxU9UKZW0sB9JrgyXgcVu+/s
         myRr6/Hwbw/9POg7Y/XpuVABjPFfkAIrzz3wKuMrjgZr41HGPq4OFOFMiwOe9gOBbREC
         8JkkePuhlwrUKIvnFRy4eXR/10QeMiuBpNsZYbFpNop/FbDS31eSObFyQsSlU8npGBhJ
         pSQ6w3WuAd0Znjf2R3aZpH6Awn05u7080E4vj2PVL1+DvnQKTmNsOTKLxo7KgOCfItyq
         r/zwE2dhA9PNdFcKC7BDTHljtgtdlcln0VcE9sZEPv6adxoEG/XGOP0VWzUMP4gklecS
         e3mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1781304666; x=1781909466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dujGfjjYzIobRUfmhoS0JnZwiM+XACk6xmwNRmTPVO8=;
        b=xH2cGArTp80e5H0iFWbigUXMNkbEA6Z+v36xmYhBDkqoyPbxBg0u5HP7aIkE/kKvT6
         rYnLhEW6lR3yFoOU4vw0hkr5WO8xNQtVdhSakYJwX90cpN+n+8zHSVbY5Q37TGSJaK5s
         gAf1qETjqcppz5KkeoZp2mfs21WBbSC0m8RQqoICymMUZAXugn7IOLUqTvaLUH1Ly/fz
         Zw4rZaGCBN5IpwGV3HmQzQ4N/fIu/6ze/ehvbr3AhNUdLKs0v0HtvursTbP2vtD8vYN7
         ABaraYgKUK3CIHNBQ9s64W0nYPfB2tIUYctsl3O2OsaYDluci5XuTvlH7F7aBLbPk9M6
         CEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304666; x=1781909466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dujGfjjYzIobRUfmhoS0JnZwiM+XACk6xmwNRmTPVO8=;
        b=CkNizKokM4rHl5GYCeoh1ZvsT6UWQ65yn8suN6iP2dY70oFPihn0oI0oQZwDNFmIvZ
         Q6X1RnyEAB+uJq7tb3aZyKlAmUOt0+P9G392H1c1qI+TNp4/jGl36XhiO632TN0+jPup
         A5KdDw5leF4IaJRltEAaVMc5h8sht761YLVZjBlhp2KmMIcdRSWnZzvL3jYAHxcniPG2
         Qq7rjG2Qtth9GZBpcS+vYvCOzETuQZ/9ZUWDLLLPbnckP+TYHzIRUEsGDQLNqF8vaVun
         vAZETUalns8VBB9208xplTo5TPillwN0bBt6NtUTmzdIqVk2KEx7B5x7BXIPQQaami9o
         /Sjg==
X-Forwarded-Encrypted: i=1; AFNElJ8ged0FduNysAa+ITws94c8FQZn4H2mxQEcuk1RtqiQ1vD9D9FmnAIQ85oRknKEaH08cbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsm8sUnwyFbDmHFOgA04DsFxszUKacFFA9fOyH9loQzzZw/1r5
	LnYdxaRv8Ts7Yptt9eV4AI1x7+2s2b4HaSke3BpTr++8o9WX3ZzWeDXSq1a3vy3FU9XLVRtgM61
	AfgtU8NKpcRAzNoUuYZE/LQodIGIo4scauWvEOiSq
X-Gm-Gg: Acq92OGGjW2Y28hy0lv9S8aIFIFYVSHhbS6KSzrI/BGpNuoyLCVg1GgtagVhq+kPPO1
	k7w4HKU7g/xhqh0GQA+X3XL7a+d1j5M8wwyHbhWzhfqfuHQO11c3eVS2qUeR2A1N7hWeq3OzX8O
	ZRDsQWpiQj78OOHCWob2ZCHe5FO+sViEnXQ14fr243zzl4WUMHJgseL7lNXcBZJVEmMtj5QoGT7
	QkgbyWvH8/4BhF32vrAK6jOPzuV++/3y23UXv/tBoOUNwsk7gZSR52gL6ycdW9fD9LRhTFdD7yu
	WUie
X-Received: by 2002:a05:6512:8053:b0:5ad:3035:9e5b with SMTP id
 2adb3069b0e04-5ad30dda3c2mr206991e87.52.1781304665912; Fri, 12 Jun 2026
 15:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
 <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com> <CAO1UbGemPgHNj1VYONQGx3HJbMMmORctF=jQbGPGUFQYGch7qw@mail.gmail.com>
In-Reply-To: <CAO1UbGemPgHNj1VYONQGx3HJbMMmORctF=jQbGPGUFQYGch7qw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 12 Jun 2026 15:50:54 -0700
X-Gm-Features: AVVi8CeSEtVZONHGCnuCD2xhJbfvrvV9WVJmuJmgnaVxQRCFw5qubUWEiH7MAAg
Message-ID: <CALCETrVSjTk975oejzBMHXZUAqRvVJpWUcHwBHrN8VCGb55HrA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: clubby789 <clubby789@gmail.com>
Cc: Will Drewry <wad@chromium.org>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:37=E2=80=AFPM clubby789 <clubby789@gmail.com> wro=
te:
>
> On Fri, Jun 12, 2026 at 8:25=E2=80=AFPM Will Drewry <wad@chromium.org> wr=
ote:
> >
> > So I have two concerns here --
> >
> > 1. By layering, STRICT becomes subject to FILTER RET behaviors.
> > 2. If we did want to layer them, it would be ideal to separate the 'upg=
rade'
> >     decision from the access checks and make the layering path explicit=
.
> >
> > If you are running a legacy binary that uses STRICT in Docker, then I
> > understand the goal, but there are userspace options.
> >
> > I think it's hard to want to open the door on changing STRICT without
> > a good reason to work through all the implications that come with it:
> > cross-checking every SECCOMP_MODE_FILTER reference, sorting
> > out thread sync interactions, ...
> >
> > That said, this change could be streamlined and look for ways
> > to minimize any potential implications.
> >
> > Am I missing something or overstating it?
> >
> > Thanks!
>
> Thanks for the review - I'm currently working on a new version which
> addresses some of the implementation
> issues. On the semantics side:
> The current version runs strict checks before filters. I think it
> makes more sense to run filters, run strict checks, then return the
> filter result (assuming strict checks were survived)
> Since the strict checks logically work as another filter layer,
> documentation says
> > Synchronization will fail if another thread in the same process is in S=
ECCOMP_MODE_STRICT
> So refusing to sync threads which are using both modes seems the most
> reasonable.


Can we take a moment to contemplate how filters compose?  The current rule =
is:

/*
 * All BPF programs must return a 32-bit value.
 * The bottom 16-bits are for optional return data.
 * The upper 16-bits are ordered from least permissive values to most,
 * as a signed value (so 0x8000000 is negative).
 *
 * The ordering ensures that a min_t() over composed return values always
 * selects the least permissive choice.
 */
#define SECCOMP_RET_KILL_PROCESS 0x80000000U /* kill the process */
#define SECCOMP_RET_KILL_THREAD  0x00000000U /* kill the thread */
#define SECCOMP_RET_KILL         SECCOMP_RET_KILL_THREAD
#define SECCOMP_RET_TRAP         0x00030000U /* disallow and force a SIGSYS=
 */
#define SECCOMP_RET_ERRNO        0x00050000U /* returns an errno */
#define SECCOMP_RET_USER_NOTIF   0x7fc00000U /* notifies userspace */
#define SECCOMP_RET_TRACE        0x7ff00000U /* pass to a tracer or disallo=
w */
#define SECCOMP_RET_LOG          0x7ffc0000U /* allow after logging */
#define SECCOMP_RET_ALLOW        0x7fff0000U /* allow */

This has always bothered me.  In the absence of USER_NOTIF and TRACE,
fine, I guess -- we're choosing the least permissive, and this doesn't
seem too crazy.

But TRACE and USER_NOTIF make this very strange, especially as people
keep wanting, quite reasonably, to make USER_NOTIF fancier.  Shouldn't
the actual behavior be that each filter, starting from the innermost,
gets to reject or transform a system call, and the outer filters
should act on the result *after transformation* of the syscall?

For example, if I run a container and set some syscall foobar() to
SECCOMP_RET_ERROR in the container's policy, and the container them
runs a tool that sets foobar() to TRACE, then I think it would make a
lot more sense for the tracer get notified if the task calls foobar().
Or if the container sets foobar() to USER_NOTIF and tries to emulate
it, then it should emulate (and not get ERRORed because no actual
foobar() syscall has been attempted now that the inner filter was
evaluated) and then run the result of USER_NOTIF emulation (assuming
it tries to do a syscall) through the outer syscall?

And, however, this gets done, presumably STRICT would be a different
variant of KILL_PROCESS that does SIGKILL.

--Andy
