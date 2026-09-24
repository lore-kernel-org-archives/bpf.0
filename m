Received: from mail-pz2-f16.google.com (mail-pz2-f16.google.com [74.125.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E14AF690
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278440; cv=pass; b=TgcPnEHLUJzBP1Lcm6I6QxuTnQD5QXT64WMHCWq6zieCVIwEKgT9ViD42Na6TclYX+6XsqmZQ45xHFkWpB430so35nbBR9mPH63OXhBbom+IbtaQZLYaBIYYN2YwZsGqLkoOU+/uSkpOOaxQArbXjAjQiUJtkEWMuLOfLFiep54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278440; c=relaxed/simple;
	bh=t/N4X0XnQ9obqaKHrk7vetf+dDL6VPJaFNb/XYutegc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp/KY54zDOAO81bP/IV5at/C/Ki+b+Wuh9MXdiiG98yEbht0XQI/1JFMK/bRar3AYt2JHR61Pa98LqDM0m/ZrMF89qPM+Pbl9dS9O/rt/eTu9mSQ1D5AA9uw7PJH2vmOWtRcANk7pOz8zdpPwyq+UzfkVW5/44RK5Az4JQpkMqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GeD5PrGf; arc=pass smtp.client-ip=74.125.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GeD5PrGf"
Received: by mail-pz2-f16.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so40766a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790278438; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2yvd3PJwegnTriFLf5LD1sEX+RIehj06uwlf2PFVwOu953dJ7c6yxJr4fSg/BFhEx
         K61XfucztQy/rojqPmhvqLuzZwE0Ok3uMoF4S3V5WH/DGywEn6TbE96EJVY+PIa1OVwm
         3pHCmeI1fI/4igIrmpRPXINiQZE+4yWxQgfFFLF1Nu/+ZZiam/gjpDgUVpNAUxz7E2Yj
         80VFt5UiUJPR95yl4Lv+6NZJNvZChEUslbZ5nP0UaNEMxFzetZXGAOYzqEzg5H4JHbfp
         5uk+hPXCBbyKozjM+SrGpem4iFoPDj8EFNrqreKpfSci7584iQfUo8dV+w9sZkb6fi7m
         mLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        fh=eMZf64/3mRYE56GfGfA7qqOaKYgSmjQqSwNu/E2vruU=;
        b=s5B81IThvdUD1yEba9L2nDKVto4TJlPch4yN0lDGW0S2mlfF4NcmYjguAcKPgLNH65
         JMtTOahWlA7mjWy9zYwTaCXzFdyAI8Tpe2DGWsIIYGlnWEpV6QVE3qRkxNpRVBOk7N4P
         mAjBSe3e4gnyJ3f4zVn5YZEzx+EsekRzoAiMOk36K1S9xHzlUhldc8/e8K90HZ1yrjVd
         FaXo9cvHLrS7pAnywt/kifFKh0srE5+OXk0xsHdzimrX5b0xHM3xq7An69C2s8iNXu+z
         Vk2+hM9SmjTMNLfwkD7G5F3PgAoAlFM7xPcRjvcDGt6IhoJYNL/PjWVKhl+TbqVXNPME
         yYzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790278438; x=1790883238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        b=GeD5PrGfMnjZPhdCBFwzGInNpnt3BxrGUjomNh4N1K3ZP9F1k0lDJezDWB5DQhPTJZ
         0p58BADZ/12tdMpaevVRhR1H/JHnK3TS1Tpw3rFFAE/mWivIHgWUUI9Sdd/MAETsSiRA
         L5uWDVMTZDJocm2plpS4mzt/o0nTa98GymvR7SsQf6qUzOZmTHxOW6cmqIYNRh5cnvuX
         G5adkdOY9W3MLY3FeFDEEayolvPNPxqnlkDuuJI3dF9nnyAHmCQMX7vNZZ7aIc5UEg7f
         3b8xoKP5Wo6Ro3d98cJtXF7LGj310r7tDb9CWDqy1UIGlmE7e7JjB+yeq/bAEcsLatJY
         kPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278438; x=1790883238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Er0wNZ7ei/sffJZBS6vip8iLxFYHICi+dbdHiy3n2DU=;
        b=FrM2Pdvd4OAFengOpf/m5p0m44GN8z7HjXQAu/3eIEoaTyqktOknlm79E+VcVsi3JG
         CAnp4BTIMBs/fw84SQNvL+fghpPVNYbt4uV1+oj1vWH6DJfhYS8MaChzegl1J6XxvgFc
         EK+4o9/n+jSD4O6jevExUPfK+mNyhTStAzAYnfy78yU2UsEbcQRi4jD4/0+FZKNwA5UD
         eLazghwwitqLFjfNr+BYi4II+2zhURrsE817baEPg97bcXBykL1g3eKsfNBYHtVO5SAc
         +Y+qkkiCGSyxs9Uv5lC0zOfOns7ZFGorEdBSm8Ev/RRQQ7R/eL7eH0Fh7CUwM7YGd0fr
         ZWeA==
X-Forwarded-Encrypted: i=1; AKwUvBzpJBv7q/GTLF/1vbG+aJ2SxDHZbhVyMB+2hg8KMxLXDqzeP/2xnexd/fs+HXggoE6Z5Ks=@vger.kernel.org
X-Gm-Message-State: AFuF++kRSn91gFNnzOuCAQsmDtsO6qHNr8LY+vDJSKVhRvYVFhOSHBWA
	vztCytCmroCT/98HYpeHxU7RZ9WDroQTXmNc7WUE2D8ESuJmnx5tQcL8TCod9r2BqI9ORQUI5xE
	EeID1D1PsaFWRphex+vYRyHdJg5w/vj3ctDY6iL578gwXh3qGCdSeCqMF
X-Gm-Gg: AYBFou34tb5Yn+59k1EbrNtSFMIebFfM/ktmBRIDgMvH/B5/GPb6Xoae64TRZ1NDuiq
	UXCcRMxbgH8aTpnpr+8aMhOcQfvbg8F/wfBWxlt1PNUsqOlQ4MM5SIikxW8X9+upwqpWPUmwUfD
	Exj/EmoPNt6ZwDDpVrCsdKwcZ1TFZseqLxB3rSu2Ov9jzRv4VIqPuFF8NRb6GclBnz6uOZrwcP0
	PLmQQdrxbHrHLEIsy9oxCBybFzSx/cJbXJ0fTqEzVNFfBjv8WwujS0KRxDTvQh5Y1L/AnjTxVcf
	i8/kQ/jXBeCe26mxaPX5s9LEWh6Y2HFnPNR2TfRDBZT4Y13aNtZaI8xlWC7LE7SclAKHpH6BRRC
	GztNgzRhE5z4=
X-Received: by 2002:a17:90b:380a:b0:39e:6c69:f481 with SMTP id
 98e67ed59e1d1-3a098d56a2cmr3187553a91.64.1790278438044; Thu, 24 Sep 2026
 12:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
 <arVKSpezisxe3pkr@suesslenovo> <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
 <arVkWs7tG3ayGxyX@suesslenovo>
In-Reply-To: <arVkWs7tG3ayGxyX@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 15:33:45 -0400
X-Gm-Features: AclHuK8Djm6kng1KVJoAo1IKBHaXUoPUqY4SRBxOWSBr835p7OAm38aVvkcIm4U
Message-ID: <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:38=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
> On Thu, Sep 24, 2026 at 12:23:13PM -0400, Paul Moore wrote:
> > On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@gm=
ail.com> wrote:
> > > On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > > > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > @David, simply for my own understanding, did you ask Daniel to do
> > > > > this, or was Daniel operating on his own with this patchset?
> > > > >
> > > >
> > > > Daniel and I work together and both have things written on top of t=
his
> > > > kfunc. He reached out to collaborate, I agreed. We're also going to
> > > > send bpf_set_file_xattr shortly.
> > > >
> > > > This implementation was chosen due to its immediate mergeability (i=
t
> > > > only touches security/bpf), but was actually suggested by Kumar in =
v1
> > > > or so of my original series.
> > > >
> > > > That said, sorry for any confusion about this appearing as a new
> > > > series rather than as v7 of my previous one.
> > >
> > > Howdy all,
> > >
> > > Hope you all are doing well and having a good Thursday.
> > >
> > > These patches are excellent and useful, and have been in the pipeline
> > > for a while.
> > >
> > > In the interest of moving forward:
> > >
> > > Would you both be able to live with the following: provide a security=
 hook
> > > for lsm_get_xattr_slot or another proper interface with the necessary
> > > abstraction, and keep the kfunc where it is in fs/?
> >
> > That still doesn't change the fundamentals around the kfunc: it is
> > really only a valid to call it from within the LSM inode_init_security
> > callback, it populates a LSM framework managed buffer, and that buffer
> > is then used to by the LSM framework code in
> > security_inode_init_security() to do the xattr initialization using
> > the values from the BPF LSM as well as all of the other configured
> > LSMs.  It's very hard to see this as anything other than an LSM kfunc.
> > I worked with David over several revisions of his patchset to review
> > the code and get it in a good place, I'm supportive of the basic
> > ideas, but this really needs to be located in
> > security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
> > is precedence for subsystem specific kfuncs located in the associated
> > subsystem's directory, things should be no different here.
> >
> Hello,
>
> I'm less arguing for any particular placement:
>
> More so that the concrete security interest of just getting the kfunc
> *somewhere* is much more important. I have no doubt that the function
> would be equally well stewarded in either directory.
>
> The xattr kfunc in security/ question can be fought best in a different
> venue where it's not holding back good contributions.

This (the mailing list) is *the* venue, and sorting out
cross-subsystem issues isn't a foundational thing, not something that
can be cast aside because it is inconvenient.  In this particular
case, resolving this before it lands in Linus' tree is that much more
important since cooperation has been "strained" to put it mildly.

--=20
paul-moore.com
