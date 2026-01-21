Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8D3B95FE
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981907; cv=pass; b=st/Y4l35pMkl6RBkFwD1h3IUybXAjEVe5Up1Nfdv+rBx+wfH/4TnRPoeMzA6rWitVYFCmqc9MZqcyzBaVm1EwddlifSnBnoGzFUfcv1f6RaMdTLg5H7Qk3jlC5LhdpFszfcjjepgyEVaskjKPB34y4rzgJapke8RcSrzLm2N2PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981907; c=relaxed/simple;
	bh=g545c90pA/SgKq4I+maJZfPTDyv1W31Ap78iXGj/7Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn7jjn7HdOmCQJj+LZL9sIb+X6cP5x4YryrhdZFY9nxlL5AizEcW7f9QFmjdVF9xlsYVY5NxlubYVay/CgbfdGpGLLcaKSqZR7BakoNb3GBFn/Jf33LW3eAf+UU4Czlk4DpagpHkHLGKzHE+WBplFwsCFaiqu+viZKuJ0Kp+NmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqdUiR0R; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqdUiR0R"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042f55de3aso426185fac.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 23:51:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768981904; cv=none;
        d=google.com; s=arc-20240605;
        b=bbfaA2c1bAYfvNDmSkJRkcsgEG4OGAgVtOv1H8fxlee9BoAKvW0laKWJP0sbdIc4un
         tl/f0stthEUMF3zbK5m4WoZVi0a6ruuDF8rJJ7vFUrO6qu+MqBRSc+SmAus+xaNFCmoQ
         hs5lu9sE86Te+JQtQ4eEWzaCK/Q+iKniFp68DEzKAvG6/CxaQmPYNK6vTeXCFQzthRjq
         FXUYgJKVYptrTOu5ths/7qyrj4/66+vwvELfnPJJN7YTZhRB5p3mtu6g3d4AmAbnJvcz
         LTTUuVMCyA2E0M92tyfTsd6j5YtL9ICgpDSyzmGwzR1CWtYwBmY0CATDICBXBeAPIw4Z
         SPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g545c90pA/SgKq4I+maJZfPTDyv1W31Ap78iXGj/7Dg=;
        fh=bxUTzCElXqFQdQBG9OhikwXjoT9e/APTDYmn6ZYqG70=;
        b=QvfNZCevj3fvgVDWxEJeCLmNH+2LCLwWrL40JbVM5uU3Ac0GQdmoLw2S2AQso/dxt4
         B/Wsp0XPvX6UF4x4BOuUjW+d+OT7EnEJPbBfBq9N0+EtCBFUDxh3ep9oeeq4n/zhXJSk
         8eLbkij1W2NS/wwkci+6Za0QPfcCPJwybz2HQZ8c3d1mw8tsTRkBP9tioGKWSKH2Ykn8
         WSl7I+RtNSzyNCB1q8FOxzDI1UuSH9rTsQdI0CJ3dwZUHtlKdw2tdpK5Mz5dp4PnyQ46
         GbzE4v0Aw1Uu2F8OsvMoUEeAyNj4I1EkTq2fKpGv1BUFNep3wBS5xnT+nnnAtrHM35Rt
         Mumw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768981904; x=1769586704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g545c90pA/SgKq4I+maJZfPTDyv1W31Ap78iXGj/7Dg=;
        b=aqdUiR0RMrceucKIo0Bj71sYHd/BEKRGCRb2ej01y3IhdUPZhcMg4yEPBF4hC7vbby
         8xOsHBebwXCrb4DVCv18E6fzS/H1D4Z+0X9pk3NQcS8IAeNCBje+2ZUu077aTqFTKd2W
         sCOkAOoTTP14LBK7ZB5QnwjgdykWibj/Tbm6P/udoCohGUz5OucfAtsoRVFQAz1rL1hQ
         YWUGezZjJJw/PnOmxMB0mw3BWYfFUMXfMVrCcBIB/6wxrIf2LPVovPFvstKDW2UyGg+L
         AVp828JQBriWKgRdcW3x9Wl3USiH6ZiGO9j2hroWnyQeFWAZndTcdfto0tyfi08D05Di
         d6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768981904; x=1769586704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g545c90pA/SgKq4I+maJZfPTDyv1W31Ap78iXGj/7Dg=;
        b=DV4t1QPAIUYHgf+grPHpnYYVUBi4j5Dh55vQ+icikdEek+ZA0c83R0ELvfbTUQbvfs
         RIP+aCvM1IHH1GsTVqx20x65eypL/ULwpJQlnqco7kh95xGX0YtHu8G9V/5/HQbiuIvE
         Imud/eEdZerWrSO6SgPH0u2qZCrFvP0BO1HyuYjxX2shiAilNVSFttlgroe1znfF/qOC
         dBpKcaY+hYFaOeTnz6/IFNaefIRTpjIhm/8aLDFFQfWqvGO4H1dtWT6BOnIAlzaYsIe0
         LqdwKG6wHCq+Wra+SxcwSoHF7auBY0X+5kYWS9YKEeHsT/AlLib/YTuP8SBSzbOeRves
         CxGw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZP75k7EEBbLi/wPmfyFl1Ft8EY9SbIFPcY+GOIgUB0zvOn4TujCF2E2I3dV5v6BIUQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAhAOdzj7P/OebZrI5pObsGONjIFdNFw3UJhiAP9QrAxRyRgO
	QJEiQ8tdtY9ui4voFR3fy9jVx7r8ijRRoqqA6jAViaHC8fmB3N6sSU0gMOgGoBxejfVpbpbodfL
	p/y0A5s75VorqhtqMkp7P6CLyi0vO4XI=
X-Gm-Gg: AZuq6aKofrbPXwSf0+gLM3LqnsppQjt4Z3FAaSxf7rXfsSvik47s7yzPcBWPGMcScTl
	e7hRl4Qr5gsC0ihgzKXYgywmq8B1WICfAb8v1zW4owP9x5m9mZR6aWHGfL4o4fZ6iKRaouYj+CK
	pykh6KwfvuAQxl3LquOHJxcC64uyrX1413AiGlqLn+vKU+APme78q2hYXcuzid5pttXQUsiHqNH
	6OfEPNrFYxaO/OHVI5L+9tkfyzRrQOBdoWMw8g8yf23WpR7CKlqOup77iaxomZ60b3gz3E=
X-Received: by 2002:a05:6870:e182:b0:3e0:aec2:8b50 with SMTP id
 586e51a60fabf-4044bcd1781mr9036507fac.22.1768981904378; Tue, 20 Jan 2026
 23:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com> <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 20 Jan 2026 23:51:32 -0800
X-Gm-Features: AZwV_QjOdqFT6ZDYYNe_D6EoD2DA9benRzTy_FihVDg6ZezW7yV43xAXiOZaKlk
Message-ID: <CANaxB-z8+UhZ+smuocN8h+YZY9tdKobhAu3H6fmzq+WzFmMrjg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Now everything is ready to get rid of "only one listener per tree"
> limitation.
>
> Let's introduce a new uAPI flag
> SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explicitly
> allow nested listeners when installing a listener.

I am not sure we really need SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS.
If nested listeners are completely functional, why would we want to
implicitly allow or disallow someone from using them?

Actually, even the current behavior of SECCOMP_RET_USER_NOTIF looks a
bit illogical. I think the following behavior would be more expected:
instead of running all filters and picking the most restrictive result,
the kernel should execute them one by one (most recent fist). If a filter
returns USER_NOTIF, the kernel pauses immediately to let the listener
handle the call. If that listener then issues "CONTINUE", the kernel
resumes by running the remaining older filters in the chain.

Thanks,
Andrei
