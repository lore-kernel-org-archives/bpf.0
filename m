Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AE37FF60
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533299; cv=pass; b=D+Sh1nd93DAjG6UJ/gyUu3gn1YdzZ86bNGWL+QG2IzJQcCrV+bcBUQ9Q/cBM7tBjYgnPXKO7ILhB40hAYlB8RupwQu8KHi8bYOlfme6b5uleWcFSOEJEqDkAlX4/GdAsximT9vjZ7nDCk6w+D7l0jUUIJxYSpf7dNL/9xRO7F3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533299; c=relaxed/simple;
	bh=F4F1eQivkcTHEyVnKH9/YEnj3GfxU1bVW4td4NV93ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJV+o3v0gPPYoQK3RD2dhCOj08G4iwYqeh7Qp+gEeU4snhzfJETtHkIZnXOzhxvrIK63OHvkvYF6bXCbo6f/xGyy8/K1ZhwotXkv6xeWDG0P9Z2GcvLiOyIcrZtwO/b13EHlZoaFy5hpUdBLA+9GYExqrXgUPYukoteNEv9LCXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EOXyQXAj; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EOXyQXAj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a652535dcso1161889b3a.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785533297; cv=none;
        d=google.com; s=arc-20260327;
        b=VCAx1nS5mw39cHl9JMVXpTc9/GQQKPxYmselhc6veFc4FqVD9dP/dEWY2qf7w2mMpJ
         9F1wyNI9tDoZC/DBZ/+78Cpb4LJbwTFXgSWKbfWOJZMKORQsGnxVpRsOb4R/mwRtWUTn
         xnUhFcN1di00EYxy4BMXYKimRibaubEQvUKWk6Ac0C4ocXlZjlKacFphEJecAV/a1UsR
         PY+Nqg8lvkLT9nmMV/eygMlGf1jTTI2JU/u4jxUpxH6rOtXcRoAWXAM70qiVEkhePxu4
         T9XzDXRJ1lnz62ExaJlTztnZsaIFA/Q95BrFdFOs1yM9GTwo2SWduJeq0jabfjAAsljz
         Ro3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        fh=7E2TeHkQX/1DdoD2NQHq0ikVP98/kHuirM8Eb45HCTQ=;
        b=F4FbOeOqX5sjsKDw/MGXQ+BuPbuQrEa8WeY2wkwPOjH6cHpm46QTAkcn4/4ipklTva
         e6yikyRYu0U7imdVzCEdK3d6SUP9YbCsjYW4E8/HD2dLdN+i+KvvSLvzBa0rYWr936W2
         7UGW/5SiMxQ11YYxLBniHByQS8i7GaDYArW+j+qH+1E9M5hUUAU9B1bJpfB/TqYOGsiE
         Df0oPo9JgMpgv/gVVWY+IHtdgCvsjXpaVhh5cY8l+XjOKpkVhswje0insH4zMnpRxyde
         RAIxSIe8Rwp99faxH2eCOZaGz7UAuTxsQUJGo4VsrhtNojF8MywJ+eZmKQZzw53b09WX
         ulAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785533297; x=1786138097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        b=EOXyQXAjXYiXTg7a2h2FOgpYSIZfFtPnRTJU7rOTwUgHNhvSzGQ7JD4siSHxKnV+Gr
         /8h2foihrL3GlqjP6xLeNOxBknhTYVcmPsd1MY5YUzJaIktLaGz1rAmub6+z6LJNymMj
         zVunaNtyosr6LzxDx47rTlwKnwFwIFTu7BZjxaNJhkLUzxAchS5DNej5JXX1wGlhmri+
         BqvQPKcqCQf/SNzvp5nkeZvcXlp07lJICgxVpPvDtOMTYV1Rse2xjsQHq6MOo9WJFf9a
         EP1GuM4Jw4UdNa+VZkcBjuksXxSR74cKj4cCYmKDjwW7vk8VZ8m6LwUyteSjYLsvNT17
         RM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785533297; x=1786138097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wq25m4uPekD2ZOm9+5jKXB7P9bW7fvfxXLKPmMhnQp4=;
        b=kwultKqG0Rc0Yla94Xje5Nys+RssZDtBGE9UC+nokJIbSGsPbQ9l7vns75cEEsUOG+
         toaJ3coRh8GPXPVBqg63IouEFIcEqFGENZAqZG/XnA3uPrQDGB5ZHQQR5RH1eXF2piti
         9czl5m3t9/c86AYzrqOu3zq2VOdOVvIkY57iS+RunKh/E43V7uCvRhHmNvuTQ3RHF1Lf
         De01qf2wyFvjs/iawoHXUIOjZY//q6qDMVhrSUn2XGYbyJ/NqM3ahRFy3hBmG+xY6vI2
         PXRmxvDPg2CH1zJ75WdNCxpDxJNxyqa1pJerm4Uq0xxWFiIy3vSZoVYhmKiF73axon1d
         3jyw==
X-Forwarded-Encrypted: i=1; AHgh+RohHhnJoKCTpDOEE2cFy40+UUjf4ZtYD2bXQMD0DrqcqH7wh1jnyxQVwm8iN9C0zhI88zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1KwWaQvOwc6C5Fkx31PgKasdpfclPKMsVu7zGrZOzNLvQ5Aa
	Vj/w1CkmRkUr/FPBXSYPIEbiK1aL9/F2DsF8LngdeR0/+cg46FkeYvEgoeej3n+Gm6gBdCasS/E
	8YBZBLoO6ZB60GvqgfYAGcYXybTSH0yk5zio5tdv4
X-Gm-Gg: AR+sD10j231b3FaASQIC2hBoB+ilrSqtqxb9kj9AMTE+oRT5/MBhFFeDSI7yDrok17n
	YaKUhXXy5qtKFbvgtm+av0f9PS4tb6Ya+JsUcUDFYkTcVrJJA2SHrDhxYJmNkZZjAHrSRFQ3WZz
	IByX8Pv4DTeM//JALC67DoLTrGxlunCjSUUaNBCWYIlvpb73q/j9XQ8L3rKgReDia72geYMgIUh
	hU8FUW4hO31P97VgveArA8Z6YUmbdCS8EOmYPlg5Ww7ZNOS0UIEIwjs8SE4rQLMBJJwu2nIokDE
	6MOV6UZE8Iio9yOHDwZfczLYh7OkEciBN1UTtkMyG5bN
X-Received: by 2002:a05:6a00:2d25:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84ee4881d3emr990432b3a.29.1785533297083; Fri, 31 Jul 2026
 14:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com> <am0JT2UJQgl0ogwy@zenbox>
In-Reply-To: <am0JT2UJQgl0ogwy@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 17:28:05 -0400
X-Gm-Features: AUfX_mxWu6YlU6MDspjIcmKDeXRNWi9hfBWLIXfPQTq-XlrvMUKPDsGtSdKCHvg
Message-ID: <CAHC9VhS-nPeu3Y-cBAmnNyO5Ju8irKm4W9A-Nxu04cRXJrairQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 5:15=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
> On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > >
> > > Howdy,
> > >
> > > This series lets BPF programs apply an existing, userspace-created
> > > Landlock ruleset to a program during exec.  The goal is unchanged fro=
m
> > > the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
> > > it only decides whether a ruleset that was already created and
> > > validated through Landlock's existing userspace API should be applied=
,
> > > based on runtime exec context.
> > >
> > > Motivation
> > > ---
> > > Deploying Landlock today requires the sandboxed program's
> > > cooperation.  A process can only restrict itself, so applying a
> > > policy system-wide means wrapping every launch path with a helper
> > > that calls landlock_restrict_self(2) before exec, and anything
> > > spawned outside those wrappers runs unconfined.  Supervising exec
> > > from userspace instead (ptrace, seccomp user notifications) is racy
> > > and slow.  Meanwhile, the tools that do enforce system-wide policy
> > > with BPF LSM programs today (container security agents such as
> > > KubeArmor and Tetragon) end up reimplementing path-based access
> > > control in BPF, fraught with horrors of path reconstruction, bind
> > > mounts, rename races, and worse, which is exactly the problem Landloc=
k
> > > already solves in the kernel, with maintained and versioned semantics=
.
> > >
> > > This series composes BPF and Landlock along their natural grain.  The
> > > intended deployment: a supervisor creates one ruleset per policy
> > > class through the existing syscalls, a syscall BPF program parks
> > > them in map kptr fields, and an LSM BPF program picks which (if
> > > any) to apply to an execution based on its runtime context.  The
> > > policy semantics stay Landlock's; BPF contributes only the
> > > programmable decision of when and to whom.  Deciding inside the
> > > exec path closes the race a userspace supervisor cannot: the
> > > policy is in place before the first instruction of the new program
> > > runs.
> >
> > Discretionary models are fun, and useful in certain situations, but
> > they do have their limitations ;)  To be fair, mandatory models have
> > their limitations too :)
> >
>
> This series does kind of blur the lines between DAC and MAC
> a little... interesting thought.
>
> > I've only just barely skimmed some of the patches in this patchset,
> > and I didn't have a chance to fully read your reply in the previous
> > revision yet, so I wanted to get you a quick response here ... as
> > incomplete as it may be.
> >
> > As you may, or may not have seen, there is currently an ongoing debate
> > regarding the location of LSM kfuncs that will impact this patchset.
> > Sadly, we don't appear to be approaching an agreement on this issue
> > which introduces some additional risk to this patchset.  We'll have to
> > see how that ends up, but I just wanted you to be aware of the
> > situation.
> >
>
> I'll hold off on further iterations until that's resolved.
>
> Moving these kfuncs anywhere fortunately amounts to a trivial
> cut/paste on end anyway.
>
> > I need to look closer at both the LSM hooks and the BPF kfuncs before
> > I can really definitively comment on them.  It looks like there has
> > been some progress towards an LSM agnostic interface, but I'm
> > concerned more work might be needed.  However, as I said earlier, a
> > closer examination is needed and perhaps that will reveal something
> > different.
> >
> > It's also worth mentioning that this functionality looks an awful lot
> > like a call to lsm_set_self_attr(LSM_ATTR_EXEC,
> > <lsm_ctx:LSM_ID_LANDLOCK>, size, 0) with a lsm_ctx::ctx set to a
> > policy fd.  Once again, perhaps a closer inspection will reveal that
> > it is nothing like that, but it kept popping into my head while
> > reading things so I wanted to mention it, especially as it a lot of
> > the framework infrastructure already exists.
>
> They were the direct inspiration for the hooks (and set/getprocattr).
>
> Main difference being the object in the hook is a trusted kernel pointer
> rather than a lsm_ctx blob or fd. We can't use an fd here since the
> sandboxed task and supervisor don't share an fd table.
>
> I'll wait for your full review, no rush.

I appreciate your patience, thanks.

--=20
paul-moore.com
