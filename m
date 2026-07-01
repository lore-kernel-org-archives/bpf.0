Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C0397E75
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935755; cv=none; b=SzjiRgBsaLo7YIEz+f0oaU6hW8U05XeLvTqr0uD7b5KgEhKjjnUiN95FzkEgEk5DlFGegmeQupw2MBoOlImjXzrzpHiZbXK/x8xzoSFKW7xSjlYS0mauOIFsVKXjyu7SCVSY6R2i32ItmPgXRH+Crru6kO4iTl1R+0LZYjyVut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935755; c=relaxed/simple;
	bh=e+jY8OPZKhW8wOdZcHv7MgD10zF+/5j6JKDF4NN+FF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5eZwsencHHyI2pZjOOgPBg+xZVPe/1gl2vnFN5pWhnGL+LLUOR584rrIbJvNOgkL4fCCJTzAT4lFvflZ0jNyQfvCM2dgcot+KLGZ7g4imbZNqcXpm4XEgjpzR2UK24xJtc47vkb0XGEyQS+kLECiSOxghmI6ylNPivEZvL+jRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knuE1tUS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knuE1tUS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8000e21f014so15889307b3.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935753; x=1783540553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dfbXm74vNv/5/jQlBdPc5onHba5XFMzYFAIUmnzBYfs=;
        b=knuE1tUSB+Zu/uFk/VSE+MkqAiUtLsK1RwEWtmYnl1OVaYgEKW++57FSJHYFeHFHw2
         SJb8pP+WACrf0s//+mUlYwjtDNt8KCy+lSEpSMwxKSNMzyL54pqgrPLqYOXlzmmC5kFm
         CXq/VDQwX80dSYbygZaauFdtCtLJB4laSO1UtOFYvMPuCK5+qicbvNMRlY9SwvWNwuuv
         uMzySHXcc1k2YLrbl8unGGvLzWzo9+u5bKGUD/KAjw1gu1QsSYxR6tGsJYz3MuaQQVVh
         0gceanmVrRJWyjjCXb+TPfG9mZjhMEM+PFd4iEFFCHmnnh8SkM+NxEQMt2i1l4/0v/SL
         FspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935753; x=1783540553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfbXm74vNv/5/jQlBdPc5onHba5XFMzYFAIUmnzBYfs=;
        b=DnQHVkscqziEg9BwKjw1V7uuZDfIKo4JrKTJuQYqQv7hmGvQJ3ppwifsm9CqMn7NR+
         Qy89lEHtt4Zemtbs7yrboTF2EBLWV9N4q2w3gnxtP7oHyvQfrzdKoLadKbYTH1C9+ycY
         AVFfH8+4eVEB2JYilBPCqEExGcBMvEZllnJkfdRKwizJ5I0YxhYJtD3l9pBc30vT1Tcn
         o2twqQoWzfrbSo48RsPkF9mlUcvgMXeljTrgb6NDdPOT7ehdBXR1GWkNe+Zb7gGvhoYG
         17OfXMUQ6byg5vNPE5o5IkKQ3Ezxdfy3HhuIFmJcaHbFLSfL9i82RQK/2Pl7t+akEjGy
         cZBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjD4/Q1U3vto+zJRBXvEtdjNakRNy8k/d8CgrddyvCRCGy4NeKL7dd2XS5FzAuNUEsPIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6j19UXgObDLPZ8w2ZlM/D+WBsqV6KBlyukhXXWGZ3fo7CPMAY
	XBZOQSO9gL4xNcLXQiV5DnDen0+piGWszP3ApOIMVNA4QrLakKTIctNrQmXK64Ekk30=
X-Gm-Gg: AfdE7cnD1lWEoBHGfm6cQuSyA+3BrXE/BTeLbGMtfMemf0I/ZLrUxrrJL68+huoNcul
	8Tw3Me4ao6jVw2PaUPKoB8t/+Rk85gEYVra0StFI170ZjvgADNR0NC2iz3IDSUXaqM0KON2oJXL
	eNkgNiXw5PqKRYMMtuaTYCK9yw5goHlJHtT99qYYC3wyKAHFxS+dqVHvXCckpYSrcqzEhvxSjh2
	c7h1rn9iVIoZEFeaCbkEIVonJVgGY/UNz6aaAP08ns1U7PQT8uY9DLy1imCsByYgDSME4ypkbQh
	L2J3PxHvjvqOlJZSiq44GKPa6RexuSqdJRUjGuTqo74VAK5VbVOTQ1JOoCNVEqELDH6dOrVJI9V
	NMVr9xfNnGJKOC6yy27X8U9LgFCX4eTKsiOVqHW7RhNlPINqN06deZvw9u9Apj9EiHcbGqq3b6Q
	E7+w0di6Oes5yw/fysDTU4QGjErQhRH5j0llj2haZSnKg1EDQ=
X-Received: by 2002:a05:690c:3706:b0:80b:9114:3b9b with SMTP id 00721157ae682-812e8bf2243mr33046517b3.14.1782935752735;
        Wed, 01 Jul 2026 12:55:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:9147:b599:e89f:2b31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448cd06a1sm4163057b3.21.2026.07.01.12.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:55:52 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:55:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net, 
	kpsingh@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, gnoack@google.com, 
	jack@suse.cz, jmorris@namei.org, serge@hallyn.com, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <akVvkA3kmlv_POsF@zenbox>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
 <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701.oTeikequi3ee@digikod.net>

On Wed, Jul 01, 2026 at 09:49:07PM +0200, Mickaël Salaün wrote:
> On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 2:34 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > > > > > > from accessing unstable internal Landlock fields.
> > > > > >
> > > > > > Generally speaking we don't want to provide APIs, either in-kernel or
> > > > > > at the userspace/kernel boundary, that are specific to a single LSM,
> > > > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > > > function as examples.
> > >
> > > This patch series is not about the LSM framework, only about Landlock
> > > and its specific model and use case.  Landlock using some of the LSM API
> > > is not relevant here.
> > 
> > Based on a quick look the patchset enables BPF programs to call
> > directly into Landlock.  For the same reason we discourage other parts
> > of the kernel to call directly into individual LSMs, we want to
> > discourage BPF programs from calling directly into individual LSMs.
> 
> We're OK for a dedicated kfunc to call directly into Landlock (with a
> tailored interface).  Landlock is designed around its syscall interfaces
> (well documented, tailored, tested), and this would be a new user of
> almost the same UAPI.

Paul, Mickaël,

I think there's a cleaner way to resolve this.

First, walking back my earlier email: I was wrong saying that we need to call
into security/security.c to check whether Landlock is enabled. Landlock's
init only runs when it's in the active lsm= list, so I can just test
landlock_initialized directly. There's no per-invocation reason to route
through the LSM framework for that.

Rather than routing each kfunc *invocation* through a security/security.c
wrapper, I think the right place for the framework to be involved is
*registration*: have the LSM framework own registration of an LSM's
kfunc sets, e.g.

    int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_type type,
                                        const struct btf_kfunc_id_set *kset);

Each LSM calls this once to register its sets. Because registration goes
through the framework, the framework gets to decide whether to actually
register them so you could, for example, run an LSM while explicitly
opting its BPF kfuncs out. (something that should be done at the LSM
framework level).

This gives the framework control over kfunc enablement without an
pointless indirection on every call, and without making the kfunc
interface any more complex.

So this satisfies both sides of this argument:

Mickaël, this fits your suggestion to move them to security/landlock/bpf.c 
and call directly into a Landlock function without needless abstraction.
We just register the landlock kfunc set with
security_register_lsm_kfunc_set, and that's it.

Paul, this way the LSM framework would have visibility into the
registration and enablement of the kfuncs that concern it.

Does this strike a reasonable balance?

Justin
