Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891F3B895D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936170; cv=pass; b=NGELmwizgjg8aBRhZA0duvl8qUrNj0c1hRHkO8LvW91OcxSF3+nJp0JIAf2CL0mtWcAXMlFO6gN7/DHJyevEdU70K8PWPeFpjj2LahcgEnfnNzjGf/vui3aaTSdNx9rqPe0TmnfZdR9asFwIJInHA4yYYD5cL137fj1Kr8B/fMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936170; c=relaxed/simple;
	bh=iVfuNUZDpw/Gom5uOVQvX6ChqXT9RekAmG+OEs7xoRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMGDUYOEUnN0VqdHtnnN1U5gjESWBPM78zhen5rFOTaOUSgvslEwcHhPSKp5nn+I84LNUdGfhjsV4ONy10QBGouL0TNBjR/qzNCCqKkYfU/8CyvphH3yOSQJVWaeV6zHYchPT55iT3XF6NAxFCD+z9dmA32OS4mAhEZLlpJWRro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TKyRUaxX; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TKyRUaxX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso9516435ad.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 13:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782936168; cv=none;
        d=google.com; s=arc-20260327;
        b=qP2O1EAYeFcBq9IOldUVAKd4VcI4lA/zN0oVMJGMwmp8ZPmOlNgtI+9JqxyZCNEYBP
         88PTbNnjZlfhc2uCV3pzmJEYaZxvLymYcuppUQ4nT0CQWrxEslFmsW0YlPaslEp87Cz3
         XS4D71EjN/ijZYFvayFhaR/WcGnhr1Q5aFo/otMymJ8xOqBoIi2R7yIhT+DHJpd76oMJ
         65eWCPINCe+c0XT7XfQUsXLnvk7IqWxRWXbcMTIRWuCMleBAOvJehxxB6GU3Y/7op8sL
         GYMdgZ0M0ATWTsN59I5sLY3r4kBt11yZXSNM4MVHVNQs0+FHU+zd7rOvFHqTcYkFms0P
         zFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        fh=6loJgZ70ENqjEPdwPDNJhjOaz1nJQzcCNbe/GnVWTLc=;
        b=aC1bMB3Tba1LmQJkloueKM5P32+8p9TcZOgZgZDAu9uAR+Yci3V4SYp5m6DaEQq4Iy
         llD0bH4H7fZ3S9D8kksTSGh7C36tsuJdB15z/um0c7G7warCK+mo+lHvWwdYPJRTC0s4
         uK21+JRiG/YU7SuPdaL2GL9DO1iCFXYFO33tmMYL9rbYsxEbWHC2SDUK7y72gjMIjHyC
         MH8YmA7LAWWwKXlVfnSWhtWYqsvdOgimZ3OiJVKBKyXR3gpJ7lRxk2TjZbZMybgnfzcD
         fLjkePuwLJbIUkzhaDo7Cn0GdFKihu2q41kkF+kY0I9kP3sLXOeCHro1rxUh3OVCwQgq
         TL6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782936168; x=1783540968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=TKyRUaxXoeNxg6Avs0Fx7V6UYAYcR+7CGd6XAfTq3C9dUpuDZ2RUUl7We1M4tO0OaP
         /zKZBgFuOOQoedvDaM7ViqZpijeoi5X0OwnYrWjXfxZeHZYEtovi9XcAuEmHKly4nxjZ
         rdFXfFdZN2enuO6coyFzc5lvbSLcq3Swfl2zvIizXb5zTBWXMQ1yI0nSfvAysKIi7M+u
         e08777MfNMhTw680Fk9PNQL9yx6+mqpz/9WJMt/eK+w9ENAYQw9U66IUZt9OaKjNQDyL
         lomawKfn/ue/jdvLbSiQ8zzBe2A11Osjon6Ih+8Vt/eYfx7IEs8m4bp7Ps6OEsgBhQ0i
         zHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936168; x=1783540968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=Tp3VjLytQmQgmOIgN5L2kDkCm2aINYtbWTA3Zqn4G7BBiOpuNGqZYZY0R34xBAepVf
         jtOyBpDXSEd6DEYQqOO1P+pWzvGApeppgWTov0SsM2QqUq2D+iTFq8SCoxeDBLunE7jv
         rGknmzoVlnxVgpsGlirMRDEaskRNX2h52GwXAFt5Vt1CfBAsIbrA9ttmjMlpSRQsYFvI
         sJ4le0BHbd2MWIUpGevGj2Z3rG9DCGHVePyd5PpAt7A+hRcrHffcbY62T6EzDTu6LjMX
         Sx58yf7L8Pxhwmc7JYrJN4IrlA1KyviSG91a6blz7JPS7QmVQbdH9BZ92JloR8bLpLjc
         pNAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCcYYnQl1Ye1hHwHFiJlmpL3yfq7OQdvzgTOeFiuQOu/h1VeOfe/bwn0poZO37AXTGzPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyjXYxPKX8bGQ6y6hHmxxh0GSPw/sUikQN8CMz69rURe83WRB
	l9NSF0BX/Cn7yBqzzyAD6sX5VaSXpSfUaWXTcbF495QsD5OHC8YMVlZEiLovHEmUNGnFw/vFVER
	p0I7pU9aIbBQNJRWjJSgWe8Z1DAW9UebN9SAKAaL3
X-Gm-Gg: AfdE7clyuLMwlD3HfYyrlpzj7/PRWxrGUdnxnyjYhk/6h4d7jOJdbUoRq7z6NbGDzwQ
	yl1Xw3dtik/5FtXFUSP6ogWtYHhtE6PoiiKIwSrrAg6OyAAdpoDFlsjrkUznMjl1Cohu2M9jfKa
	1j8+//qQGpqcB9Le/XvVfrkM3Fo8JU/B9yu9UOz42JYo3Lo7HrftJiijpoQUDcmelypTpFxzvMI
	QG4MBSaJuxl2NJwfcoCPzoJsgmdZ3rjn702DbnJI8Yr5UjLhD0GusqGpOqqdUXxjd9DFKGF
X-Received: by 2002:a17:902:e743:b0:2ca:304:f93e with SMTP id
 d9443c01a7336-2ca7e7579dbmr35871365ad.22.1782936167815; Wed, 01 Jul 2026
 13:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
In-Reply-To: <akVvkA3kmlv_POsF@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 16:02:36 -0400
X-Gm-Features: AVVi8Cdkaysddhch2qqzWj5e0tZs2D9PIXTSkNjNLTTiuJP0QwrJjf46eYSL4uc
Message-ID: <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com, 
	andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:55=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 09:49:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal7=
7@gmail.com> wrote:
> > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrot=
e:
> > > > > > > > > Create 2 kfuncs exposing control over Landlock functional=
ity to BPF
> > > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset pre=
venting callers
> > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > >
> > > > > > > Generally speaking we don't want to provide APIs, either in-k=
ernel or
> > > > > > > at the userspace/kernel boundary, that are specific to a sing=
le LSM,
> > > > > > > see the LSM syscalls or the security_current_getlsmprop_subj(=
)
> > > > > > > function as examples.
> > > >
> > > > This patch series is not about the LSM framework, only about Landlo=
ck
> > > > and its specific model and use case.  Landlock using some of the LS=
M API
> > > > is not relevant here.
> > >
> > > Based on a quick look the patchset enables BPF programs to call
> > > directly into Landlock.  For the same reason we discourage other part=
s
> > > of the kernel to call directly into individual LSMs, we want to
> > > discourage BPF programs from calling directly into individual LSMs.
> >
> > We're OK for a dedicated kfunc to call directly into Landlock (with a
> > tailored interface).  Landlock is designed around its syscall interface=
s
> > (well documented, tailored, tested), and this would be a new user of
> > almost the same UAPI.
>
> Paul, Micka=C3=ABl,
>
> I think there's a cleaner way to resolve this.
>
> First, walking back my earlier email: I was wrong saying that we need to =
call
> into security/security.c to check whether Landlock is enabled. Landlock's
> init only runs when it's in the active lsm=3D list, so I can just test
> landlock_initialized directly. There's no per-invocation reason to route
> through the LSM framework for that.

The landlock_initialized flag is not really a LSM framework API, that
is still Landlock specific which is something we try hard to avoid.

> Rather than routing each kfunc *invocation* through a security/security.c
> wrapper, I think the right place for the framework to be involved is
> *registration*: have the LSM framework own registration of an LSM's
> kfunc sets, e.g.
>
>     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_type ty=
pe,
>                                         const struct btf_kfunc_id_set *ks=
et);

That implies a set of LSM kfunc APIs which Alexei has been deadset
against (see other ongoing threads).

> Each LSM calls this once to register its sets. Because registration goes
> through the framework, the framework gets to decide whether to actually
> register them so you could, for example, run an LSM while explicitly
> opting its BPF kfuncs out. (something that should be done at the LSM
> framework level).

I'm not opposed to the LSM supporting a set of kfuncs, see my comments
in other threads, but we should treat these kfuncs just as we treat
other LSM hooks today because that is what they are: LSM hooks that
happened to be called from within a BPF program.

--=20
paul-moore.com
