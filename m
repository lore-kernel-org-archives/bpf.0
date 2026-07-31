Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BF35C6A3
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532524; cv=none; b=Nd+Fle2mcxUpYuJ07on/P4/QBndSLzjwPLwEfVhrjhjaJr6SL3EYaqyfkUHVSkNheMmTbAl2HNkZ+EGFzaSwLeBs8IsUaTXHfcYFRlv/X0XkBiRX+QwW/3hgOaGOY1OtKeZbEkzB1IuuBYa0M/XXusc7yrjHgimrZcRwDf2SZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532524; c=relaxed/simple;
	bh=tfway8HYZ5WCOmU94tVvG9Ex6N9dUtJeCUSDptLPmwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agExVqbssHMTBHw05jhk0Ue30CfbtpAeKZQbFJ+TNbtiq9sTXjPIxJFcel2nhgcrHNB3lh6iSDYxN6ip6j1UcnF1TPTmJDoI9Tw76SDLKYrhq2UYqvyJctOFK5v2arzNFmt83QD6HDWOSYhKuM0CZEW8yasxC0mzsZhGFZ6Jyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgX2YXeT; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgX2YXeT"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664db84f074so2069603d50.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785532522; x=1786137322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elDw9oiQreFLpRRXW9sbDNq6XC8CGaBRYJ4NHBLdM0s=;
        b=LgX2YXeTw5Np7xRY2LuuBLMaG5+btS6Wj/e3o7RsGxtcO/C/84tSS+Cra2yF7JWRev
         fQJd4jarbWUo+tETAl67lWTWYo2eRJ+sMN1j5TVGRw3/luGgYJthTk8hw/xt5+6aYw4N
         XrlI9zZYiQFM1KEO0Jsv0vWl3k//9ITqkDUDdIRaeLMIcHz9qB8UxwRwBe+bfWva3PBt
         at5G/mfTVlwnPw89f3lCe1Kl259Ob1atBWsQSZ3Q78aQjyNrRdd6mUTGUN4GMwB5eFkk
         Bt0mg12Yly/5fo/gZbMqJpIbphCELiZ9oje/dATKfjFCUWyMK1sm+/QgTgDtqJnqJWrx
         HorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532522; x=1786137322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=elDw9oiQreFLpRRXW9sbDNq6XC8CGaBRYJ4NHBLdM0s=;
        b=Jm48l7ZEk6bcfihgmqVB+uazxXOl3Zl3b8SrswTZb0uKUL4mdqOiOnZpKOT7g13Bxd
         MhcwMMAjKsK2SyDc6KnBpO/Wxvep2N32pykx4bW+Zbcg3rH+IL/QT76t6CR6qz2kRMyE
         61D7ybqkQho1LciNrCzlr6LajovVRnj1doO8CSlsYUy7tu4lVbXp/PkmqgMwfX1ncqbH
         aBTYDv+PT2xIwv7enxeIgF4GKKC/O2UR9l08oXZonWb2HL9Ll1H6d1cW0wM699u12QJ2
         ICBXA1yNNM+Nq0cGfu4XGoWjFYeBRDgEJen6g+hpIp+qQyTKXoksd+7TthyMYLTpvGUN
         gXjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoObUG8uLMPKS41Kwtrswq5QHJpiqQ/YVvh+Q5w7fP6aWCQ8NscJayT6YWfZ5Ul++3LM2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibUNbn5IJDC0VyT+g7fATe1EMJjCtrdP4Z7tciKwgWEIyUyaH
	e5Y+yy9X1vEtqv2Ro+oMdsYIy1oam2ykuc0FafTkpvJzk659IzB1gTgQPqTlu+JE
X-Gm-Gg: AR+sD11gRZHJrqj/9aN4lZXx/ZEchFsQ5eQrkDcB8s5i7HAcRleBrUFEVMR38Nnxss/
	TkWP8mcCGrzcnV+y82BiYLnTUiMQz6tHYOayNdlUf/cGQntGalCfOb0j37RuzccOl/iW/kKq5nt
	3jLAVBDia3WxsVm/vA6M5trSdP4sux4BIg+cBokO54eylyyEw3Tg95SxryDt9lNVnLKLHQHsyf6
	EOnGip5nlhEhEjeeeIN00rrgTIh6xdjgs3nFP/aHjxbLkLyrLLwzWBtBip3E6NRMPtNqr7lJlLa
	3ZPPXb5l6W0pe7EurmoOmL2SAxNYIBNxKbkcu3PJNd1sIG4BhnEnWVSQ34r5EeRhxorXggabNNo
	/gW1G33HYlzxn8+RNHL+BOkBwU6kG0xAbnZvXjzXIBsjaIxEV//ZTcFBwYPObftBSIRxJm/hbQt
	N69nK8zRWFBpayXdc3u2+2thNSYqf+XzhxPKTEJkPBj5uh3lu3HoLiqClsFGFmQYlkWhY6stM1c
	Vvo/21qrcneFx/tmWk/mfKoiGCnPWkKZsSdlOmf2RG6
X-Received: by 2002:a05:690c:604:b0:7fd:4ef9:e5a4 with SMTP id 00721157ae682-81fd4bd6688mr20512397b3.29.1785532521535;
        Fri, 31 Jul 2026 14:15:21 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d52:64e9:32ac:b832])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd124e8bsm15083237b3.41.2026.07.31.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:15:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:15:20 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <am0JT2UJQgl0ogwy@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>

On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Howdy,
> >
> > This series lets BPF programs apply an existing, userspace-created
> > Landlock ruleset to a program during exec.  The goal is unchanged from
> > the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
> > it only decides whether a ruleset that was already created and
> > validated through Landlock's existing userspace API should be applied,
> > based on runtime exec context.
> >
> > Motivation
> > ---
> > Deploying Landlock today requires the sandboxed program's
> > cooperation.  A process can only restrict itself, so applying a
> > policy system-wide means wrapping every launch path with a helper
> > that calls landlock_restrict_self(2) before exec, and anything
> > spawned outside those wrappers runs unconfined.  Supervising exec
> > from userspace instead (ptrace, seccomp user notifications) is racy
> > and slow.  Meanwhile, the tools that do enforce system-wide policy
> > with BPF LSM programs today (container security agents such as
> > KubeArmor and Tetragon) end up reimplementing path-based access
> > control in BPF, fraught with horrors of path reconstruction, bind
> > mounts, rename races, and worse, which is exactly the problem Landlock
> > already solves in the kernel, with maintained and versioned semantics.
> >
> > This series composes BPF and Landlock along their natural grain.  The
> > intended deployment: a supervisor creates one ruleset per policy
> > class through the existing syscalls, a syscall BPF program parks
> > them in map kptr fields, and an LSM BPF program picks which (if
> > any) to apply to an execution based on its runtime context.  The
> > policy semantics stay Landlock's; BPF contributes only the
> > programmable decision of when and to whom.  Deciding inside the
> > exec path closes the race a userspace supervisor cannot: the
> > policy is in place before the first instruction of the new program
> > runs.
> 
> Discretionary models are fun, and useful in certain situations, but
> they do have their limitations ;)  To be fair, mandatory models have
> their limitations too :)
> 

This series does kind of blur the lines between DAC and MAC
a little... interesting thought.

> I've only just barely skimmed some of the patches in this patchset,
> and I didn't have a chance to fully read your reply in the previous
> revision yet, so I wanted to get you a quick response here ... as
> incomplete as it may be.
> 
> As you may, or may not have seen, there is currently an ongoing debate
> regarding the location of LSM kfuncs that will impact this patchset.
> Sadly, we don't appear to be approaching an agreement on this issue
> which introduces some additional risk to this patchset.  We'll have to
> see how that ends up, but I just wanted you to be aware of the
> situation.
>

I'll hold off on further iterations until that's resolved.

Moving these kfuncs anywhere fortunately amounts to a trivial
cut/paste on end anyway.

> I need to look closer at both the LSM hooks and the BPF kfuncs before
> I can really definitively comment on them.  It looks like there has
> been some progress towards an LSM agnostic interface, but I'm
> concerned more work might be needed.  However, as I said earlier, a
> closer examination is needed and perhaps that will reveal something
> different.
> 
> It's also worth mentioning that this functionality looks an awful lot
> like a call to lsm_set_self_attr(LSM_ATTR_EXEC,
> <lsm_ctx:LSM_ID_LANDLOCK>, size, 0) with a lsm_ctx::ctx set to a
> policy fd.  Once again, perhaps a closer inspection will reveal that
> it is nothing like that, but it kept popping into my head while
> reading things so I wanted to mention it, especially as it a lot of
> the framework infrastructure already exists.

They were the direct inspiration for the hooks (and set/getprocattr).

Main difference being the object in the hook is a trusted kernel pointer
rather than a lsm_ctx blob or fd. We can't use an fd here since the
sandboxed task and supervisor don't share an fd table.

I'll wait for your full review, no rush.

Justin
> 
> -- 
> paul-moore.com
