Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726833B96A
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018390; cv=pass; b=NpB5GFaHmUvkNBE3J6fL7QrHIPjtcvRUSBlo1ScygXhHf1QDQZ6Xb7115cLzKZxPIGrDgos41Se1MQmJpbtutw8UTugX2vUlbJrHWijc0lfMxVYhNm54pFNUDoEQ/1z6wcygKZdYWPC3Bg5piYwk4/iEYFfGePVvuxBrZT1Na/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018390; c=relaxed/simple;
	bh=5wJnFw3PWGsP/L9WwaFzD4wkm2L2MyUZx6M0XU5KnCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCegVG39BxFzOZ1xKvkOWjrvm6vJO26Esp4g4z0WalT4s8dMrfZkdsGsbN5+MShmFZtLvplQk42ACIih+kcN8hLRScVIuuFc4/Eyej7lMGhDZWowVWUTklMObZJ3HmsQOTCUPM31L0Tp2vR4xd0FihS7m3fzc10EJKSHm+Z8BF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=o2aEcdR8; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="o2aEcdR8"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59a10df8027so54084e87.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018384; cv=none;
        d=google.com; s=arc-20240605;
        b=PQU2CDtQpO8iZdFNqiFy/YsgjHE8tOr+nFkEci0SMcW7D4+N5kYqJX73Sx3FF2QReT
         QSynzZ6YmduFA9rSznFhhxTsY17bPFiSSs2mKNE4WMJ0eMEtoZyVhmsy8cZImLMssTh7
         sGKBfn5VpwuxAy/YiHOtkfG/9o5K7Y2sZOXWEnAxJ0FgSuNvDGM70TDjSS9XTqpbW0aL
         D67PKneJue4RRBPFWkCWzhKPKoEFBi6EJ086n3GVTOR/QYSVp0vavHTW0bBn/bRApF2h
         F7TH0np8Nc5r6NmVPC6dn41xxmBGxBRSOMiqnnnN6T1or/IWZl+XCX5mGq6nhwsFvtAp
         3jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vRpYn7EoZezAdH9Q0rbsZMXmV5i0aMEWNxHIvE4S8M=;
        fh=fOQ2uSDaP5B+A8HdCc4KHZzLdsqcSjdCm5lwInzP9ZU=;
        b=hOgil9hI6j1HFQ0fxf4plGOAac/Dq7zcSFGU8s0iaA4TRuxty946+XPZGvKWD5Qd9+
         KAmDdWStSL4P+XFaTC3VWuiDBRHNbq28d6Y/hZGRmDbcqBnoRV1hPbDnIRNuzQgCUeXI
         SpeF3fFqByQTTEMFNYpxWB2w5AU4P7G/GX9b0NJs19Ffaaug8zaOd5D13s8npXsDo65N
         UJ281qevYXwLQush73CzqRMMPswrKedA/P8JRxNbo7oaQAIEvuy5Qh42K2VuqlXsv2GE
         46hkWwjgWBjMmwaobhhUYFUZh5hZeG0FBidIc6MEjZUchUd5ufKScl3TaBgUt5Uz8sZS
         fC8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1769018384; x=1769623184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vRpYn7EoZezAdH9Q0rbsZMXmV5i0aMEWNxHIvE4S8M=;
        b=o2aEcdR8CzgprfIED4g0hKu8p1nFURaS2aKz9DqXjnhgAOywomyvRXLEDZBCci5QN9
         S3uFDPcXPJddnSKOO5uZzkmPxsbYmVuXF5uZ5hLtfnmsoeQTpNu4ZphpPoerXWx8+FWz
         0AY3ac7EXf8cM5RhhPAHKWM8mXfXzUdxPdRE8XE7k1PfLQq1V4RKjP1VpV5tlPwIImRU
         qk6fUDdga+scTvVKd6ry2mRBi2eBnAqdfmGZqpv1dZ19485ayEI85zKI9+fwTic4B8Zh
         ofgBlOGdIO/3B9u858jBcNoQd83x3FEF7tbYLDlYyu2BqI+VDI92Sw9irlHN174jzzeh
         SGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018384; x=1769623184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+vRpYn7EoZezAdH9Q0rbsZMXmV5i0aMEWNxHIvE4S8M=;
        b=COC9h2LGdXxhB8NkMzrPBNVLX7isUfdkWyxa1Eg4db8YW+X1zGGZj4dIsURVC0Z96k
         f+rx6q/ah3dQ+2+xFXE0E1Bc1tvJqH87ZAiPm3+xsIAoTVb1HwNiIm/+UaBZV0+dkdTW
         bdtAlEGWxhfNG2QF+0d0i5MkTWo71o2sOnAgh2WsvahX05M9dWXEqkc+yerc7DztLeZn
         xvhMnbXzYG3V2JY6pUqZTtoHLO37gv6xp/ieKrXkt/u/FHSV+eaT/W5bgnp3VeGk1ysi
         JOFgdEFJvXVXSarzS3SbnarpWdvU2JwYR0zD65RTEoVVPXgggWRDZJzOEpjYvMm/Hs5Z
         kKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVUcElebpGKEYQ51PR37A8qa4Cp0uOA6Psncc27USJlJ5HGO2KVALa2xNUjSTodw0Ih7F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD888xiUsQLj1S8zzLj4/go+T59TwCnNlKhdVtjgfgoBMDUsZ2
	E9tB0aXAMoXiPSYsrl6F+RNF2fP8OtJ5BaFpPW0/u2rsoBc+Ar+/qpVrOVpFXXLC7HbBYQMSySZ
	upip4GKRKjkTWc4gK86/Q/6pxfD8jxWsHLSXkwwNn
X-Gm-Gg: AZuq6aKHzhHVu/YwbmOnumYx3R3zB1dSaVP/15DqaWi3ieaQN5WcL8xADvL+Y+7Q7ro
	qJNOEXNapcNOu6rR+3yV9AwWkpfAGBnuN4a2ATiH/uv5POXWuucn/AlBQZun0qsppGUbgqCEsw8
	KxPhz/b2ExpiZxvVZ8g4M9mcK2Fxc44sYYwW6denHBO1dOVBTUE8KUFK5WF+mVubIPjWZBqraux
	3n57AmY4KM0kDvUwEQIPPc+4DeLxcXTpTXJSUiuPD1bBGteEuG+IRaTMRX4wnPUtfCujwQQRaK6
	lZI=
X-Received: by 2002:a05:6512:12c5:b0:59b:70ff:200b with SMTP id
 2adb3069b0e04-59baeef1846mr5712407e87.53.1769018383603; Wed, 21 Jan 2026
 09:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
 <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
 <CANaxB-z8+UhZ+smuocN8h+YZY9tdKobhAu3H6fmzq+WzFmMrjg@mail.gmail.com> <2026-01-21-tame-yapping-name-paste-hnBZQp@cyphar.com>
In-Reply-To: <2026-01-21-tame-yapping-name-paste-hnBZQp@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 21 Jan 2026 09:59:32 -0800
X-Gm-Features: AZwV_Qixaq2tKaBHL4PHonGnZsPxxYvp8csVlFiB7Zqqz-exNx5TDrfDXNalgoU
Message-ID: <CALCETrXbTjD4ChWnhH8tRZ8MSGQqfueQPwv9EvT_aQ8gnnfaEw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrei Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, kees@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 7:43=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-01-20, Andrei Vagin <avagin@gmail.com> wrote:
> > On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > Now everything is ready to get rid of "only one listener per tree"
> > > limitation.
> > >
> > > Let's introduce a new uAPI flag
> > > SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explicit=
ly
> > > allow nested listeners when installing a listener.
> >
> > I am not sure we really need SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS=
.
> > If nested listeners are completely functional, why would we want to
> > implicitly allow or disallow someone from using them?
>
> It can be quite easy to deadlock a process using seccomp-notify (even
> in the single-notifier case) so especially in the case of container
> managers I can see the argument for wanting this to be an opt-in thing
> once container runtimes have verified their notifier won't break
> nesting.

Is the deadlock such that a process and its manager can deadlock in a
way that's hard to kill?  Or is there some problem that could
adversely affect an outer manager?  It would be nice for these
features to be automatic instead of opt in.

(I just wasted half an hour yesterday removing use of
unshare(CLONE_FILES) from a program that didn't run under a container
manager that, for some reason, thought that was a sensitive syscall.)

--Andy

>
> > Actually, even the current behavior of SECCOMP_RET_USER_NOTIF looks a
> > bit illogical. I think the following behavior would be more expected:
> > instead of running all filters and picking the most restrictive result,
> > the kernel should execute them one by one (most recent fist). If a filt=
er
> > returns USER_NOTIF, the kernel pauses immediately to let the listener
> > handle the call. If that listener then issues "CONTINUE", the kernel
> > resumes by running the remaining older filters in the chain.
>
> I guess there is a philosophical argument that earlier filters are "more
> trusted" but the seccomp security model has always been that the
> strictest filter return wins and I don't really see a strong argument
> for deviating from that for USER_NOTIF.
>

I don't know if I agree with that philosophy.  I would think the best
philosophy is that, when filters are nested, the innermost filter +
filtered task combination acts as a unit that is filtered by the outer
filter.

Without notifiers and without filters that overwrite errno, I think
strictest-wins is a decent approximation -- the choices are kill or
allow, although one might quibble about the various forms of "kill".

With SECCOMP_RET_ERRNO, I would argue that the behavior would be
superior if we just stopped processing filters after an inner filter
returned SECCOMP_RET_ERROR.  After all, the effect is to do no syscall
at all, and having a process that didn't do a syscall get killed
because it tried a bad syscall is kind of weird.

With notifiers, this is all rather more complex.  Notifiers can
emulate syscalls, and having an outer notifier somehow process the
syscall that was replaced by an inner notifier seems rather weird.  Or
suppose that an outer filter wants to prevent some operation, but an
inner system wants to emulate it in a way that doesn't do the
offending syscall, why not allow it?

So I'd argue for considering changing the behavior for everything,
maybe optionally?  I'm not really sure where TRACE fits in.

--Andy

--=20
Andy Lutomirski
AMA Capital Management, LLC
