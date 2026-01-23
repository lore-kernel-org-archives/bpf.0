Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186C39F8C9
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149637; cv=pass; b=TyEs6GTkTpStiuebV+2dnAi55hclkUswbzC8NhFMKbuSEiPruTEYL33uRztZBGQQEIYdFv+TTewtrOrEyFMFyJ2KodA2CLU7JmYciifBG6Nx5/b2k7ur72HrZr5n5ZHlBUV7deysRDc0ARDDSfECGBYSNhm60au6X1a/LE0j/ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149637; c=relaxed/simple;
	bh=/g24220hfxR8g/nmEXjyW2cLh6pnmqTheHHJrLvBJaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JocK4U3VhJMBHUMTAQ/yF5LoZPMXH4m7fPCW6aM/VeDK7SO4abTKI+pwWjXREtTHRN9nzhqEq1A5KYuOdeUZsAmjxs0s+h037koDO42HIOKcv60VjrvwA9eIO8/BTVBYXPu8PmnkhxqMBj6jixN/dVtvXHe+PzbBnk+9+o/0joc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcELQWXS; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcELQWXS"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45c7d812567so621989b6e.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 22:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769149627; cv=none;
        d=google.com; s=arc-20240605;
        b=M1vd5Q2WQF+nifvJsfk38+ZCb9SQN+M3F2i8YgW7sw7SoHglddVJAmpIlJaYhHDg8l
         1ckfERDGiJRnhGTboFYI9Oe/nRjIrzx2YNcGxWdgJqYSx7WAkVUXTF8d2//2oBe39hWK
         ZtqcFeRBslOMpSU/GCEpc1RGjy/Gxj7VlVfGllCmyoFC81yqDzYOxjYCufmRAMTCpIEO
         /QXEYWmlifGSov/4MCJdjEOREfue+a7vPDnxm4jrtzySO7Ytk8/6JD6KeQF3qgE1sBDw
         4bZMTPikb93OmgCibj6aucTZW3opBLA7ATq93917D14SR15lQ2B4n8mwzMXIsOvqCVAI
         B28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xLh76lI9xc8rufp/ig7bo8lHgIrl5DJsWJuCgT4OsJE=;
        fh=AEaAB49+4zO86fQWYPmftE/9zdjpwvwhGSnwvkdVTsc=;
        b=jWMzDf0USl0gpGruDNvl8SgEBmBnlobrVEpC0KnplTavVlxNdcdirfuUXsjCsn1+go
         htfaEIlAAo1b6AAlld5NE5f+29CRHy7vc8mESsw087g1vPGroTblA8jq988KOsZzSy9H
         VAnE5FbLEghDpkzRv0AULskzALtCxIWE4u1nz4Y3kH25KHFkJ4uJ6+8BWts3mWg5fPBM
         Y5j0pzlAoBviqqL1jqFzCsA63VDkcT5GgvgC01PFgJsan/F10en0fAx0pbBxnIV6COAV
         4+shZsDS4OMJGxuW87VWln5W4F3QD4oXe2X9NisRt2di2UHVCKVkc7/7eHTW6iCenoBR
         b3bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769149627; x=1769754427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLh76lI9xc8rufp/ig7bo8lHgIrl5DJsWJuCgT4OsJE=;
        b=KcELQWXSQkotfogKWp1BAgg+T2wWaTSaTp6605PCFLmhm22e3nxcP80l7VlHVOpKcO
         zpm+9iKgkes79aG63YGWTQID55hzmrUWYv9oiTvYsPXovaBwIcBCXEsBHqIJouHv6QTy
         RM4bq9uR3EEVsvntm71ELQqOVNgZiLJ+iH9SFvV+y3K7cngnL2pewuIOv/DSzo6dTtg7
         AgvYRV802ht5yHo+v/SA1veGZM5RiHuaI+DKMh41OyZ/ktlTrOBajxKen3oHXjRMyke2
         6YIkPaRyHqNElay/hFPrKPLVOxFV+M6OZXt59SwVq3aqBfUQM0526p22YdAuOh7nVUdd
         2SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769149627; x=1769754427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLh76lI9xc8rufp/ig7bo8lHgIrl5DJsWJuCgT4OsJE=;
        b=o21ttK17qcNA6BgC4y01zjsUz/v9Ccgx5MckJxAQZj5/YDNu3F71R+RYfltlx+781w
         USr9DVDqLGKCoeGkaD9MS6/hlKVUdWjEj7l3oByegU3H55q7WgBFe48Jqziseg5Q0lhS
         nXgioFS82Jx7WTt2QtK7sUzOTgabGqKHfvw8WNLtTkq4diBZ7vj8VjtJoGtsw4dBlIg3
         3knBgJjghQcYYy8ZbY+dsALLZVauRaKfTpeiVl7nxac8OKwHoTweOG2ZMtUtBz9iiolP
         w3eHmDhUGDV8Rk+AldU4vxAn1mMrhr9xE5op2GT+cbfSLg86Vid7PzigbIXpsc5vExoi
         3XOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiNmCoqyhaeGLqsm5caB+SAfZdKFIk1nykxQr/3TxR0+XOhw/5g061iR9xbbVV8/UpFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHXYNYaWSQH3fVZedcFCvaOVCzXKf8tctPdi0MW34wFa95OlM
	NbgsLFZbVEVeorKPRAHtOvM8Vq/0XWIVjcp+0hzcTplMK7Rel9QKKSR+z/zoKHPQl7MDtJZ7+Pp
	pzvRGYozng+m86R3T0Gw5Pzq4yk7aJmk=
X-Gm-Gg: AZuq6aK+AnKG1bPmywUOrVc2LPypW7N+l8nqYb8/UFTmG5wxnSrNT2GJqpmS3zOLeXm
	ndDgRfECJoJwRZ7gzYFP9ib6QhXpfRiWK999rUeHUn3T/rZHMUpAmbv8c918DjIiJVddvszY7ut
	HgBN+DQ3gTPGo9MpdNbSjmxx2cMpJ0Ug/vq9a8vSjai8spkTLycP+fZC/o/LOOHSVc8aooRXbIL
	1/0rebqDMJc6wzxG5Oi5srDAt99dyC+6HEb8EvggwPOfc3d4ZooAlTX9fTtZ2AKVHcthPI=
X-Received: by 2002:a05:6808:4f66:b0:45c:8a1c:8912 with SMTP id
 5614622812f47-45eb1d246bfmr1027876b6e.41.1769149626937; Thu, 22 Jan 2026
 22:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
 <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
 <CANaxB-z8+UhZ+smuocN8h+YZY9tdKobhAu3H6fmzq+WzFmMrjg@mail.gmail.com>
 <2026-01-21-tame-yapping-name-paste-hnBZQp@cyphar.com> <CALCETrXbTjD4ChWnhH8tRZ8MSGQqfueQPwv9EvT_aQ8gnnfaEw@mail.gmail.com>
In-Reply-To: <CALCETrXbTjD4ChWnhH8tRZ8MSGQqfueQPwv9EvT_aQ8gnnfaEw@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 22 Jan 2026 22:26:55 -0800
X-Gm-Features: AZwV_QjolQPlnm8945yQvy89Hfv-TQEfT1zp81y68B95Qi1yXjIueT-IBgv1NeI
Message-ID: <CANaxB-yqvHx7rWK4Efq8869ai6TEd3SCLDCLrHq5rhXGPNV-1g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, kees@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 9:59=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Wed, Jan 21, 2026 at 7:43=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2026-01-20, Andrei Vagin <avagin@gmail.com> wrote:
> > > On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > Now everything is ready to get rid of "only one listener per tree"
> > > > limitation.
> > > >
> > > > Let's introduce a new uAPI flag
> > > > SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explic=
itly
> > > > allow nested listeners when installing a listener.
> > >
> > > I am not sure we really need SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENE=
RS.
> > > If nested listeners are completely functional, why would we want to
> > > implicitly allow or disallow someone from using them?
> >
> > It can be quite easy to deadlock a process using seccomp-notify (even
> > in the single-notifier case) so especially in the case of container
> > managers I can see the argument for wanting this to be an opt-in thing
> > once container runtimes have verified their notifier won't break
> > nesting.
>
> Is the deadlock such that a process and its manager can deadlock in a
> way that's hard to kill?  Or is there some problem that could
> adversely affect an outer manager?  It would be nice for these
> features to be automatic instead of opt in.

Both a process and its manager can always be killed with SIGKILL.
I=E2=80=99m not sure I follow the specific deadlock Aleksa is referring to =
here.
In my view, an outer manager should not care about any syscalls that
processes are calling and intercepting. The outer manager must be
triggered only when a syscall is going to be executed "natively".
This kind of overlaps with the second part...

BTW: If a user wants to prevent the usage of seccomp notify, they can
always install a seccomp filter that rejects the seccomp syscall called
with SECCOMP_FILTER_FLAG_NEW_LISTENER.

>
> (I just wasted half an hour yesterday removing use of
> unshare(CLONE_FILES) from a program that didn't run under a container
> manager that, for some reason, thought that was a sensitive syscall.)
>
> --Andy
>
> >
> > > Actually, even the current behavior of SECCOMP_RET_USER_NOTIF looks a
> > > bit illogical. I think the following behavior would be more expected:
> > > instead of running all filters and picking the most restrictive resul=
t,
> > > the kernel should execute them one by one (most recent fist). If a fi=
lter
> > > returns USER_NOTIF, the kernel pauses immediately to let the listener
> > > handle the call. If that listener then issues "CONTINUE", the kernel
> > > resumes by running the remaining older filters in the chain.
> >
> > I guess there is a philosophical argument that earlier filters are "mor=
e
> > trusted" but the seccomp security model has always been that the
> > strictest filter return wins and I don't really see a strong argument
> > for deviating from that for USER_NOTIF.
> >
>
> I don't know if I agree with that philosophy.  I would think the best
> philosophy is that, when filters are nested, the innermost filter +
> filtered task combination acts as a unit that is filtered by the outer
> filter.
>
> Without notifiers and without filters that overwrite errno, I think
> strictest-wins is a decent approximation -- the choices are kill or
> allow, although one might quibble about the various forms of "kill".
>
> With SECCOMP_RET_ERRNO, I would argue that the behavior would be
> superior if we just stopped processing filters after an inner filter
> returned SECCOMP_RET_ERROR.  After all, the effect is to do no syscall
> at all, and having a process that didn't do a syscall get killed
> because it tried a bad syscall is kind of weird.
>
> With notifiers, this is all rather more complex.  Notifiers can
> emulate syscalls, and having an outer notifier somehow process the
> syscall that was replaced by an inner notifier seems rather weird.  Or
> suppose that an outer filter wants to prevent some operation, but an
> inner system wants to emulate it in a way that doesn't do the
> offending syscall, why not allow it?
>
> So I'd argue for considering changing the behavior for everything,
> maybe optionally?  I'm not really sure where TRACE fits in.
>

gVisor (a user-mode kernel similar to User-Mode Linux) is a real-world
example that is impacted by the current seccomp behavior. The gVisor
systrap platform uses seccomp to intercept guest syscalls so they can
be handled by the Sentry (the gVisor kernel). All guest syscalls are
managed by the Sentry and are never executed natively.

Thanks,
Andrei
