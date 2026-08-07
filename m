Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35B455186
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140015; cv=none; b=tFBp14jWMH3Mq9DIkJLy6gwFQSO1FX4gDfs38rapZM0a+cKlY0X1ZTJ9bR72V7age9OA9VrJ91/cXNacb0d2/YgrSjlMP999OansiKsnt6bxHS2zmhIdYrRA+TDA7H4U0jNJomxZjTTb5GN2bgzXsyF6oKy9qx0V+pn9tp3YcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140015; c=relaxed/simple;
	bh=nU54FZpSFFu4P2NKSM0v6X4FpyUhXD5t5Vyi5Gc8bR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiCeBpCqqeseoF2Yhyc9Us732U0ly3/+BnHdtrLPCatvPNI7REycS19eawYfMxy+6C0koAeAVv/rzvs6X6XFEcYdTumM8ANOeCeAiZP6SU0Vgybt8ZW+lsnvcCDnEjHKdWH0rJikcLOyAwsM0rSp2vkDwtXii9BVpfataJqpSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6K4QxPa; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6K4QxPa"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80bb41f7f3cso43992517b3.2
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140012; x=1786744812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/SAijTGHhHzvlBvPCx6AlmHoiuAwRn2jXN8unnNebg=;
        b=e6K4QxPaPL7ddQfOdqkiVqnY2amb//lhs92Dm1xvhj6krBkHfsOnuc/eIP4UvijX6c
         xckK9f/7tXOYzufaKcQXS0p5NR1JCSIC6x4D6nx7iQTGbMkk6NsA8R4R/6NqHc3EuNVY
         kcOLCyikGMiKC5u1iInrygqxbKZJQ5tO9QtE1r67fjFCFuQ84AgFu7yuaCiJi8nJrrVk
         rxjhmo2B4p8CsxnCvBIdDSIpUHkRRrmAz9q5DpIC0ZloP2394Fa8Bb7XrGbgdMTK8I7V
         0OuW+SB0e2gaTfA1iTteMwzqsIOXYqzrUTbzaonMAxebZ2yb794a8itm+FdbDyw9DuAy
         wgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140012; x=1786744812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n/SAijTGHhHzvlBvPCx6AlmHoiuAwRn2jXN8unnNebg=;
        b=B1OzkSo1nTIuFItm6rihMkdAP8x6kI6t3OrFHqb71BJ55qct1gi8llRIOuRuo5RkbB
         fBpeeZajCHhY/TPH40os8EaxHE+WFMcOpzL/XVuSLeeDLPg81ewSePaQnUrm49NqIYyI
         3TUz8b0YuvTWTVGMNBXLaptSX0ZucO6hqBRq6PiVjx8GMlx1oPiH8nwCoP92t/lXvVzE
         tyvAdso0WZIreAIMr+MLeg37p6fTvnUSA/PPSNbpLQkaJUaeo56jerYxN+frHjTKDVDS
         vJO/OaYwHjoUERCjxTlXgCX/OEeoK7HA8xkfo3M73OIPczn8XEy5MReKLp8SDyBuhMg2
         IO7w==
X-Forwarded-Encrypted: i=1; AHgh+RoVQcD2TiyammVdAUICBIDrWHUmBK1AqKwufpj+OR0u2avz4JeYRWGm6jiWEKda9BfJSqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHWQvO/Gx7RXWBQ8uQ5ixqiJcpC5Jnp57Qt+Q2CFXOj4altsI
	RS8xJihyaCa6+XYNePB3ZXIez5fKuFh8wQoJ/zQFhpnJTQEZMyrU1zrO
X-Gm-Gg: AR+sD10MwxH5BqtuL+HttQ+0AT+QJyHK/TRU3TBNr8AuWiSzMAdZDeAg3dNoWIb3vKN
	iEHy1ardxqRW3TUCTuVCZLT2w8ijGGJ04dMgjG4t89bDUkfsk+kMM3xTuZHBD8lsNVH+10lyPiQ
	6HKioxY8N7WQzRdSafjfHv4fGbSCW4+ZAEg0pxQEoyVoTTPeC8XM71M8dRxYPSPVVgI9CwUo0fZ
	oJYKV/PWwSITtkYG2Zhgu19YbUNZY4IcUOQGZmjt+CR+Qsepzjvpn4eIMU7f9tFxLLJVdelBYSi
	k95UhhIV/rEBr51OnuIN6LJpDoWb6QugU3XXH/Ok0wVjiDt/7ITg44BjCqyuJ3TYgC9HmLitARx
	IzaCrumW4wFSQ83Ln85mWTCeRPhWNlsgUuGNRwb0l7ekddMfR5s2phdEDZkUxZBKYWnvFZ4U1em
	JcBrc3QmaoFD79Gk1BJoG3SAl0kDDkwigRlCzYfZ+D20UdV6HA/FZTW0+1CpCAKVmm9gIp1LPip
	VGfX6NMuvKl5mi2snoRMkk=
X-Received: by 2002:a05:690c:9689:b0:80c:3848:bde5 with SMTP id 00721157ae682-82258a8f2dbmr74464677b3.13.1786140012233;
        Fri, 07 Aug 2026 15:00:12 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:30b1:d824:50d0:7b8b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f07a3246sm16925817b3.17.2026.08.07.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:00:11 -0700 (PDT)
Date: Fri, 7 Aug 2026 18:00:10 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anZIGtlHvTaidOEC@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox>
 <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
 <anPAbFzuLOizAhm-@zenbox>
 <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>

On Fri, Aug 07, 2026 at 04:36:20PM -0400, Paul Moore wrote:
> On Wed, Aug 5, 2026 at 8:32 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> > > On Wed, Aug 5, 2026 at 5:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > > > On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > [...]
> > > > > As you may, or may not have seen, there is currently an ongoing debate
> > > > > regarding the location of LSM kfuncs that will impact this patchset.
> > > > > Sadly, we don't appear to be approaching an agreement on this issue
> > > > > which introduces some additional risk to this patchset.  We'll have to
> > > > > see how that ends up, but I just wanted you to be aware of the
> > > > > situation.
> > > >
> > > > Quick aside question: Would security/bpf/ be a better place for these
> > > > type of kfuncs?
> > > >
> > > > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > > > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > > > for kfuncs dealing with lsm-specific types.
> > >
> > > This gets back to the other issue in the patchset that we've
> > > discussed: general LSM interfaces vs Landlock specific interfaces.
> > > There are plenty of reasons why we don't support the kernel calling
> > > directly into individual LSMs, and from my perspective this is another
> >
> > I'm 100% on board with the no calling directly into individual LSMs part.
> >
> > > instance of that.  Here it just happens to be that the kernel caller
> > > was written in BPF and not C (or Rust for that matter).
> >
> > The intention is the opposite. The point of the separate directory is
> > that the kfuncs can never call into an individual LSM, they only get
> > the LSM framework API in <linux/security.h>.
> >
> > Every kfunc is a thin wrapper over the generic policy kptr hooks:
> >
> >     bpf_landlock_get_ruleset_from_fd()
> >       -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
> >         -> Landlock's hook implementation
> >
> > So kfunc -> generic lsm hook -> individual LSM, same as any other
> > caller in the kernel.
> 
> Not exactly.  That "bpf_*landlock*_XXX" kfuncs are a move away from an
> LSM agnostic API and not something we currently do in the kernel.
> Some will, and have, argued that this is more akin to the Landlock
> syscalls, but I see (at least) two problems with that comparison: the
> kfuncs being presented aren't syscalls, they are cross-subsystem
> kernel function calls; the Landlock syscalls were created in a
I see the argument for normal in-tree kernel interfaces.

Unlike normal kernel interfaces, kfuncs:

1. Can exist without in-tree callers.
2. Are explicitly allowed to change or be removed at any time [1].
3. Can't break builds or other in-tree subsystems when they do.

This isn't hypothetical: the entire KF_KPTR_GET class
(bpf_task_kptr_get(), bpf_cgroup_kptr_get(), the flag itself) was
removed and replaced with a better abstraction within about a year
of introduction.

If Landlock (or any LSM) dies, there's zero uapi/in-tree cost to
removing the kfuncs, unlike syscalls which are burned into the uapi
forever, or ones with in-tree callers where we can break builds.

I argue that the transient, low-commitment nature of kfuncs mitigates
maintainability issues that arise from lsm-specific interfaces with
in-tree callers. (which we are both opposed to).

> different time, today these would need to be reframed as LSM
> syscalls*.
>
LSM-specific interfaces exist both in the LSM syscalls and in my design.

The only disagreement we have is the abstraction layer that the
"LSM-specific" part comes into effect.

1) In the lsm syscalls, it's inside of the lsm_ctx and the LSM_ID.

2) In my design for kfuncs, it's in the function signature and the kptr
types.

It's fine to have binary blobs like lsm_ctx where we always assume
userspace is untrusted. They can pass garbage through the syscall that
we have to handle, which is expected.

BPF and kfuncs are a ring-0, kernel internal interface, trusted after
verification. You can't cast pointers, or deserialize them from binary blobs
like lsm_ctx in BPF. The ownership and types of pointers must be verified at
load time. kfuncs, their annotations, (KF_ACQUIRE/KF_RELEASE) and kptrs are the
primary interface by which BPF checks correctness.

An LSM-agnostic bpf_lsm_policy_from_fd(lsm_id, fd) multiplexer would
lock every current and future LSM's policy object into a single set of
lifetime and context rules, and would move type errors from load time
to runtime.

This would prove to be less maintainable, because the main way of
ensuring correctness (kfunc signatures + kptr types) would be taken
away.

To avoid strawman style arguments, I ask what you would see as
an alternative interface?

Justin

[1] https://docs.kernel.org/bpf/kfuncs.html

> (* To be clear, we're not going to remove the Landlock syscalls for
> all the obvious reasons, but we're also not going to support APIs like
> that unless we have throughly exhausted all other options.)
>

> -- 
> paul-moore.com
