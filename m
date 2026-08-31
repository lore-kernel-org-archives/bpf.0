Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C73BF689
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216144; cv=pass; b=jRdbQnsaDVl5ooPDsrsCmJV766eAcyn46DcOBGp20MqYoYsf9anNivWOO/fddENJsn32zhdG5McX3IrRhrxJS0GbQ9sPAHZw5C7+Aep74n2SfhBjr3S2tuMNmWGTqe/I3BfsjZhoLVh5SgAqF9bSD3vopocQVkpb53zVnVR4n68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216144; c=relaxed/simple;
	bh=u2srwtIURoWJNKL9GOJUQTifUvW2ecbh8OdnwhyADKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPWWDFvZMi05eOUvZIxR20qcne63Tc+Zr9jMmXbNMrRTuhaPC8ogVDrBVjM/wjsgfxbdf6mwAg/x+3CtJg6ucYTJvYquURk2Ik+s1gljNldQt/BJadEjVKFRJcaCJ8XWVOmljRoFihKgYBFYEIgNTq4OVvTqxb6KR3mdUjXitXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c1CQdwvh; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c1CQdwvh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so4424019a12.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788216141; cv=none;
        d=google.com; s=arc-20260327;
        b=a4C6DPbwv4sC+7VXO2BvmLXlQd11Qcd9AxJqT11YyqzAdbPjEXkMSArY2cRmr5GBPt
         Go1Ygmlv9LE3JAIKB+G+xPKsTLsO7iRtMLYL0XEdnd+EHFhpyGzlepQdytA/ktSychAG
         kqcTtd4j8+3BZ4CYvT1+16X4sNyfaOpmcPD6Km1HteWeOySpgrhOr4uzBguAYf9i0vud
         mH+nWZ19EAjjMZZRDibTGdJyocHA58+u2uhcHoUGs9R9n45PKrcWpXLmYgzc6joP5Xow
         7TjFQniPPIzA1dVcUKGC2CgZrsr532Di0YJpTlq3qC4kwUc7NJS83Mx5gN3AK34rNEb8
         IxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        fh=zZgm+55jvLHwN908yMwEUUGRupBb+3+nawYljEcwKVk=;
        b=LqoT8tNtgAhWj1qJrEQTP3TbHEo+U/v0u/3yQ0hSh3gM/aNCeHLMYBf+6dZKZcffLS
         RF4XuQUqvVzudQqxmjU+HZafomcz6KX9lPBNtQZHNFJeIv3yf8Xg5QMAh22xyaHCxk4v
         +IYUKbM8p5AAohCq43JmrvlOub16S0kSr8IJoZyGwzzRiBtCtVQkSEYwyZ+UiYo4ib3o
         7QtdDBjNNUtTllgdR0XDWvFEi88HD6lJQihoIV8xL6t3zTiFyNn/VdL5QKGTDwox1KSG
         VJ1r6tqPuZjWlGG3PjL7wWeABB1CB1BwTo3rg+O1lHCGxwcjD1cZeb25g8JUZQ2Kg1gO
         +FLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788216141; x=1788820941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=c1CQdwvhuHPaR1kj1yJsymkZHoVBtWUGSZL+YH9WDrc2IVZfW8BJuViw1xfnlVvCxZ
         8Sp2/tgSgJKD4+qnEJwFUiTjXekz0h0Fxir8zOvhxXbuRgz70hHOTXEvyqR94GdhQJdq
         a71sWc4v+5a8MKIcxhLvD2RkO+bGv6GWolo5QCfiPAOBTNkJAxh6i6lIdqhjbupwPl8s
         IaCew54tSThOP6a+lc+rUnN136LTCX8KoFxnDLVaiYqgBgo+OWLMVIlOATJlu6k2a93N
         WuqnjN6BDi7LT4ldz6e42P1AVAB5al3vwNm3sED8y1pXw86cfYWwVkkFNOf9MIkZLkEY
         dK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788216141; x=1788820941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=YD1THMnY2uehe7imsS1fhQAAhpiV4u0tBVPGwLPclLKCh5C3RWgCS26CpqWOpqHdtR
         Z8GLNvMYIIGHYxYVYo2Kw6dh/IgQXpC+1YmxgzF0zfOoDnzDejZRqWSZTC3jw+ypvLWk
         uy6U50cgjOKAWA2+//a9GdvO6qrQFdqDuIk9qBgBzVgIuREAS/TOMR3fJdlMbt+3V+2X
         6au/WevUrtprIicBZoFzvKdML+P9/H9aIeimPUge6a6RqqkHkhtklW95Opk84tXSkPx8
         nE4p6XW85zhRKA+3cT785W0EhjrjK2dUpblAyS187BLG0RoylSAPHZWkBafIdd/86mZc
         0VNg==
X-Gm-Message-State: AFuF++nHYyd0b05Acrs0f+dXOcAih86wtMKxQxh+BSNOGC3t5g8VP4L0
	WMIlxnRao5NDwhulAxoiGnGJjNQPqGq7zUNSJnhYnZSw/dckJBy+1HT1Zvo21uorSfrAFc2hMh+
	7GAuXu7RXTD4wpNdChthDOZ4OTLhzEhW61E3PRl+q
X-Gm-Gg: AYBFou3BeTtmqCft5bkO2GjgX3lMuL9Azy0IDp+xXbfZZ6xvJJPhwiBRRMEyWoZydtl
	a2FgkjAIwzMXbXoEP68IM9/JTDmgIlWJl5C9d6o4zGVXAH83sFPefxLOP8hGkl0izLMPMP9Y2W5
	8dCJekorhe5QMKNjjQ13K3W/Zizn7utQeHEM6ZqenwBYklIUWrICp5r7LdVeLFcsYD1tFNogZ1J
	VIC0Bv8t8u3pT+g7QJ1hwFcVTSXGup7h+i6t+uCJeWK7P5Z79jS/Ef00dr28LnWBy6ftsLS0NEN
	KmncEwKHUhIQicab99YOf7L85vG4HK7oRd/i7uZXqPva
X-Received: by 2002:a17:90a:2ca2:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-398bee5663dmr14737593a91.24.1788216140807; Mon, 31 Aug 2026
 15:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <20260831110934.241898-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260831110934.241898-2-a.s.protopopov@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 18:42:08 -0400
X-Gm-Features: AcwNN1UCNECLFYeBCknRn3HYL6duonlMTll2FvhXvryaFxITMxED4MtxRIMPUxE
Message-ID: <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:59=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The BPF LSM programs are allowed to attach to LSM hooks, all of which
> are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> of view the set of attachment points is defined in the bpf_lsm_hooks
> BTF set. By analogy with existing code, add a new header file
> <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
> BTF set.
>
> This change allows attaching BPF LSM programs to more functions.
> The actual hooks are added in subsequent commits.
>
> Each BPF hook calls a [__weak] noinline function each time a hook is
> reached. This may be too expensive for hot paths if a BPF program is
> not attached. A future commit will optimize this by adding a per-hook
> static key and inc/dec it on attach/detach. This way disabled hooks
> will be bypassed efficiently.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/linux/bpf_lsm.h           | 12 ++++++++++++
>  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
>  kernel/bpf/bpf_lsm.c              |  2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 include/linux/bpf_lsm_hook_defs.h

Adding new BPF hooks in the kernel is one thing, but adding new BPF
LSM hooks outside of the LSM framework is likely to be problematic as
these new hooks operate disconnected from the LSM framework (callback
and LSM kernel object state management).  We've seen bugs in the past
caused by the BPF LSM trying to operate independently of the LSM
framework, something like this will only make that worse.

--=20
paul-moore.com
