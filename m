Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A272BEC2E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232015; cv=pass; b=K3abgItMWUOK6MPvlimAEN6EmfimmBDzDsZXGKlhAqG1X38DWoc0VdYpnexuL7fvGHKUUoj0+FtRTf+coBIzAitxHb+vSgz6DopTy8uTupDzvD2YVNePEqP2bDpanHX6KQbxPJWkXHxMX6dDzVQBUEF/AF8LaUODCru6rRG1zjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232015; c=relaxed/simple;
	bh=WJBHb1BA1nWdgxLYz6uErVgOyr1mAiktkIdKahI3c+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAd53k17WrKaUboARuNYNxAfLLMHApp59CKfCgvRJRyml3ytC5+F6BeBIuEvKe0q6mRmRhUKuT/dMpGd+NVW3CnKVXHGVGWMyian5zL4xt8bYcL9tnYWQ2YBBRFJs8ZG0oiCz6BPsapJMoImiv3xzkDxBH4zFluNmmarDJ7LtIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyEOoYx8; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyEOoYx8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so44239545e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776232013; cv=none;
        d=google.com; s=arc-20240605;
        b=EoZar+blmEoZ/75t7xsg4U/+bCxdmbleNBfChjssZEI+Ixpw4eTCE+oUr8zVNw5xLf
         QEJXVMI9uuLCd/lDol6gGHCoCFVu94cGJqBGswtC/ZBniGGxJddYXCDkZaxOus2FHA7U
         j/uoFDYO5PkfPPaN9LpXwalqSW/3ejs+JgstB5hKBWUrw4t0ufWht315i8NGOOwNO7D1
         nwVG6LThxK7GE1wS4zANiMOP/c207Md9o7VvpyWBiVUJtdd9hF2InGcIWx5gD1WopXxA
         qI8GUQhoXbd0nYiB0MHlCZ2hg5XBWZOaUf+PXkfIrBJT+nMk+hMcEBCHgZdkI6/vze8K
         2tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJBHb1BA1nWdgxLYz6uErVgOyr1mAiktkIdKahI3c+A=;
        fh=4ro9sdLedkGYGIwAuWbd9YaK6HOgFl56xFPsmGO2tqQ=;
        b=OxUGbNZVPq/erwxgiVlK6s+o47m1ty0RR06Q8Tb7b1Jb07q0cQo1fS7ov3exdFY/lY
         0aHQvieIfrAqMgxXJD0XCtSza2NVQu5/D6PNl64Ix5S3yDvL3mbJifdfMF9mvZI3oViQ
         oFMNPfTq3KkosKNWQCg4kRGOUM19i1ewkkrvfHAVmK8FiDY06QMAmOKL98pw/WUAc8lP
         0s3WWFCX4CSLOKL42nZjrVZw/8hOJ/uPwOfOc1Qlk5jn3F0EA8fvqg5qN2YQ+yQDLPaB
         Fpfzqf3FRphurFFEygXl51kidbQ4m3vQOBM8Q1NE/8HudkdVm4MfcBaOxx2MkRWwGwd2
         28Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776232013; x=1776836813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJBHb1BA1nWdgxLYz6uErVgOyr1mAiktkIdKahI3c+A=;
        b=FyEOoYx8IbIW1CNf+OAv1Lie4poaPo1m8DSREuZ7fuNZT9x+vHhrY6wBVjjD6HHiuY
         dPfnig9oGWrfe5molK3XHL2TLVyaBso6nlBJdRYluvM91QA6eqWgiyFJsGye/wIPK1BH
         sWHrN9JGh2Tnb1/LCwJipUDbaFHdJ/R+FCvPo8jf5ZeKD3j4TTDTZwWQKgk6gDmdiA0Y
         InvwWAqnXDHlVU4V3fYUdtHD8I/rjS+I+TC1s0t56CkgTmVHOYZnxGCqaRXuuX1i91so
         gzhRBQHug9Dq5Sw/IxTviDsUePzG1p4yRrpjc/VD+xbPn19Uy6tZ+71HLvZl5SuL+njd
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232013; x=1776836813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJBHb1BA1nWdgxLYz6uErVgOyr1mAiktkIdKahI3c+A=;
        b=sK3BGaTXekJO2a0zVqtSdNBaBRrM8xOMPgOMDNv5IVcag4S4rGQvQMxUtCHUT6BMLq
         /TZmlcaaG+GBng0ZMsYoA4IpwJkZgfHA1aDsV6uOxP7WEcX6CW9Nwv5Mt5+KvI7ZPLWe
         RLiUIiF0hCKx9hw6pH7OpZmg+j0UcWhliSUkw+E1z8IqVWu69zrTUohiBYMwJvC5oJpy
         cvuRRrSfJDvIIrT3asxl57OAV/52SvKQfSwsuAHkDyZYQZ9PjZyHW5K13TEc0U5Dd6vG
         T1LEnA8qDqV3URynyxfl4vkfRhgKug2TbQDB3QQri7KTWEWziV2owUbBDgjRxumckTny
         Kw/g==
X-Forwarded-Encrypted: i=1; AFNElJ/ZMFhIAJTQWqoTbhFkeQaVgS8kyX+sskU9yW8OpriOsv9ok3eFn17JTfMp2L6QT5OswG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCBQsfGhGjPqzSkHyPqxLZ3xsrXmjNPuif3pIYToJrUIV92wG
	WQ4NfXs5Hv7AuOKGd9lgNoye3E4Pe0j/dBiE4V//SDl/89XfDpikSLNFWBEqiaV4kn/RVSovF/2
	C7Z22MyPHEN9adeJ65x9CaJLbFJOttf8=
X-Gm-Gg: AeBDieuFLfydpWeAXiNBvG9QPscyCeu7mVdy4xVEWvoRtUMmHOQrcijTDlmTj9WtLHU
	T7fO4ZwOj34QpoFnOddOLablaW5Dqhx1al72Kly9YDTNWwGZZtDPEUlH6wnPATVGLzlAMlfmnl9
	E/ys/csWHqh/72bOYtexReKFX0fC+B4EcAK6i4c+d7lfr9zBchFgUk4lmJJTspDTVHFThYLzcjz
	xFCggP88D8ChydV/V7qHXmJGTlqsMmkrdhoI/5+/7D23kfpYUsGPqEeXR4KjQp0J+snH8YzUnVI
	Ha0eZh1NR7WTYuO2S3rRqdP4DEE1pncpHwREKLbaEblGzqnuMKPDBSi4v4wj5kgdIXBTzPNhZW4
	DBEXgU8LCDe2IRfHSZDwYZ3EdgKN6QfXS5hGR
X-Received: by 2002:a05:600c:c088:b0:486:f4d2:eac6 with SMTP id
 5b1f17b1804b1-488d67e6776mr196208735e9.13.1776232012538; Tue, 14 Apr 2026
 22:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
 <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
 <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com> <CAHk-=wj-bwQkr9To3Z_fRTYF8tZK+WMVWJ8k=ACZVenZbQfUuw@mail.gmail.com>
In-Reply-To: <CAHk-=wj-bwQkr9To3Z_fRTYF8tZK+WMVWJ8k=ACZVenZbQfUuw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 22:46:41 -0700
X-Gm-Features: AQROBzD8qOIssG1V4ZOk1rBMbAl-eJOkP8S_cEiyCm-9folMW4OHCpGldpLh2ac
Message-ID: <CAADnVQLbxLmr43kgQ-KP7QAhyOoE5Abcj3tCOu4KS-c2CJ_ZKA@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 10:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It would be lovely if you can still verify that yes, this version also
> fixes things for you?

Yep. Works.
Tested-by: Alexei Starovoitov <ast@kernel.org>
