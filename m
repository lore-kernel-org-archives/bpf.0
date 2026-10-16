Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABE296BB5
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113376; cv=pass; b=nZRFmSpa6WMThgSFvCQI1NdnIkPCutIVETTrDjI6bE6Iy659ZdrhP2PHydhJfCeXR2fUELDw4zsNRL/4Pen2GK8XRZm/jblzdFBwJWy0cVdl1pfTFqzH/BR1Fg/D1oUFQX9F1qpeAEvS918ngno2Q8yykPch/WlEK8Z/jvi7I2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113376; c=relaxed/simple;
	bh=ephQpXnZgt5z4Aqgb5jvFmMyut/96bDAzqzE6lEMNtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwbqziDhfRLWDtn99YZaCElJ12nEEx0cG19zO5bT5mwc6GO6D/8kZ+R70EBsZb/s2iVVq/aokSXB25tmcWfNsM8jCUU/yjwp3d0iiZ3uCqP96G4cCpfcjg6jOIEPawXwSmVds0Wrg7OTAtHdVWMR7DYww3nBIlUy1veDcmAJ1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWBNa3dm; arc=pass smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWBNa3dm"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so501335e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792113373; cv=none;
        d=google.com; s=arc-20260327;
        b=oxJmqUIbt1i8qwA8zmsTqORARMnrTubkZk4jzJ9tf1KzXmIwXJFTN8G75xcBZow3X4
         /VPhuw5EQFf5vOQoM01AuwrN69H7qZk35CQwHOKpp7uXXpUWqWO2LFtmaD4asKSrT0gv
         wN1zT7KAromwB/XRR5k95B3OGLXXQRi0xfYSuwWoqKrxkcba3CPJFjdGsWOCtMb1dOnP
         FseO0qNFu6lwDmHMi1PHD3J2EZeOfYYugeX2OzYuhAd9nexqp3qq9sSnMYCRscoE4wir
         iAGgCVK/+U8FMLzWMK0q6XOPoVcgA/V7RCxwElds9sOEL8qQeIi73+nbfVT4ea4gienE
         dBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fsgpFqDZeOJJcgsf0NDGgBED0LAdDL0ProvU8TGTHgA=;
        fh=6MmNJ7261zx6aUJ566Ib3yRASEsEr6k2BPd96ksxlJE=;
        b=keRsdh+ptMkGrm6rPlZnmiAb0YrpPH7tTp7cb+U5Al0grR2MU7rLrueC+MlwUpHsET
         4qfVIkaywRFVupMdjZgBsMr+V29a79rkVONX9r8qrCtI9EiUdJTSvZXCQueahOGSD2Mh
         nI7yb/1dHH7TjO7z4jmidfzWr/jEKHWwgSCPhicm7mfcz1FFxTDxztpQDuXRlFUi2sSs
         Werg65PCmfK/J0opqYDM17K3Og/MCHLNhLm1xLIGzfo7tDG1thqpWwZ84dSHVe8vZcwQ
         bEVhp7WL8sMy64ihlDX0Jc3NURAvDZkorDcaQBG9wK5I8zm3NovnOdstu8QPLEfyyjQc
         dMmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113373; x=1792718173; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsgpFqDZeOJJcgsf0NDGgBED0LAdDL0ProvU8TGTHgA=;
        b=EWBNa3dm5kdIoUTTB97xfj2VEqHbmacbQwDnm3+y+iXOwNIuhJBrR+k2mezNN/Ye0F
         pXAZGDdrYXzO+IM+sZw/XCbxZ0vV1BlSofBBFE5vNOlFEnoNVT9jz9kzvMxMgiSMjeB4
         ZjmJpEcj/mFsWt2NekGCcl/n9DMmeLwQnVOeQk8Gix5QAf4DDQfaR4l2YyCHpwmxoYxI
         uN0S6HoIdyMjDWZ13kd2dKu4gxE8IVH8jv/UxQGs2/OUmwKUcCroH3Njdzl+PfGGx6A8
         BBuf/cJQqqgRglMK8zofqONn6IIe3PO/4wYm2OI8iVMGl9oyI65OepNqCQ4pOVoGJJIf
         JMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113373; x=1792718173;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fsgpFqDZeOJJcgsf0NDGgBED0LAdDL0ProvU8TGTHgA=;
        b=hBl462MCY11e4RDVZzkNlji/FUNEKm1u4XYmB73pBgbnWWsr4TV+95aUO0gGjI7tYo
         OAfEbpwR5Wc24+glKHdDheSBlN0wI5pF9qrZD0JyCNbhuuICR3tHiBG4enTch1+Dslws
         sMjmWrR+MPM1XK7fQ5nnxGoRP7+R/DIn8zzjiIpFxZ3iGefCuupj5Iqy9l0CamhsWCtT
         Bdl2Mj4qol2WuqIdRs8+BoINHnPuDo8uxJMeB019CjPlAm4aFPhsn5g3J5UvgzRl/vcU
         lcJhzjgYeAAyqNK9sfbXLOEIdeWOqI9fLu2wMYScbH/xSyMM0hGvo8SJz1myurSA4BW9
         gfsw==
X-Gm-Message-State: AFq9FYL125t0iO/wpP0RXu/JHa0TcgHorhN+qSMoLZ7rFzszY93YqubH
	LkBC4HCtBE9vJFfR1TgJPjNg6/ikdKxOcnzbeFDxqeQMKt+B0qKD/6UOsaFuFCG8z8zW/RKyCOe
	Zw2LPYbG6klyFEALO8SjYJYA7f76bJlk=
X-Gm-Gg: AYBFou2SJc4wJWC/5e+zor2tYQXOBA/0cQFHGnP1S/noTVofwB25GdsPsAFBTVMTEoh
	x89Wy+PhnjQnIm+GqmfJxFtkarf6HTQ5mjtEB/Y1EWjDl4QQBZwyC6n+GRIQsXRSBjIO1WeXyhi
	jnYU8obfHNPhXwsUidJidrYPsFXFfCi5tSz2xLxMuhmxQVLjQ2gCnq6JyAp4RiS913BKT99ilRQ
	fCYqNca0lFt36zE7xo8duQmbEtGPIeVn4vtYNZ70IBhPtwX2VzoBKHGUXAU4b3wKpzS9/VkFz1O
	eoz32cExkYA/U5vi+tshT0WAg5ri0lWU9rGNBxpU7+HaByTpsWuVWExXYCR+7QXqefdiyFOSmrZ
	M7QJVD6nMOaKiiQF88ZY4cvq5HCt9FnsPUPWGkkkwMYmJB5QffNjZzZj67ZAE+gCEOygG6Fh1uy
	+jzj0w8bPCRYm32yhr+I77SRrVg92IVvQ=
X-Received: by 2002:a05:600c:820c:b0:49c:fa21:1c81 with SMTP id
 5b1f17b1804b1-4a18e4d5563mr408263095e9.22.1792113373035; Thu, 15 Oct 2026
 18:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-6-memxor@gmail.com>
 <DM5V06J7GLXR.2BJ4ZJ3IN5TT@gmail.com>
In-Reply-To: <DM5V06J7GLXR.2BJ4ZJ3IN5TT@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Oct 2026 03:15:35 +0200
X-Gm-Features: AclHuK8fO6Y2mxnEoXTC7U41CDfg54fqUPxaS6jpvWMPQCKCmZLq1kF9v2GxRJ4
Message-ID: <CAP01T75d1bSF5Nc0MvdS=n7MrER+2JZzXm4=7DELKN2yT_iiiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/15] compiler_types: Add __arena and
 __nullable BTF type tag qualifiers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 03:08, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Oct 15, 2026 at 11:41 PM UTC, Kumar Kartikeya Dwivedi wrote:
> > Kernel structures increasingly want to publish pointers into a BPF arena
> > to the BPF programs they are shared with, and some pointer members that
> > reach programs as trusted are legitimately NULL at times. Neither can be
> > expressed today: a pointer member reaches the program as an ordinary
> > kernel pointer, and sched_ext resorts to a plain u64 holding a
> > pre-translated arena address that programs cast before use.
> >
> > Define __arena and __nullable as BTF type tags, the way __user, __rcu
> > and __percpu already are, so that tagged members survive into vmlinux
> > and module BTF and the verifier can act on them. To kernel code and to
> > sparse the qualifiers are empty: the pointers are ordinary kernel
> > pointers. The verifier side follows in the next patches.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/compiler_types.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index c5921f139007..e97ee2d4d1df 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -51,6 +51,8 @@
> >  # define __iomem     __attribute__((noderef, address_space(__iomem)))
> >  # define __percpu    __attribute__((noderef, address_space(__percpu)))
> >  # define __rcu               __attribute__((noderef, address_space(__rcu)))
> > +# define __arena
> > +# define __nullable
> >  static inline void __chk_user_ptr(const volatile void __user *ptr) { }
> >  static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
> >  /* other */
> > @@ -70,6 +72,14 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
> >  # define __iomem
> >  # define __percpu    __percpu_qual BTF_TYPE_TAG(percpu)
> >  # define __rcu               BTF_TYPE_TAG(rcu)
> > +/*
> > + * Qualifiers for the BPF verifier rather than address spaces: __arena marks
> > + * a pointer into a BPF arena, __nullable a pointer that may be NULL. They
> > + * reach BPF programs as BTF type tags on kernel struct members; to kernel
> > + * code the pointers are ordinary.
> > + */
> > +# define __arena     BTF_TYPE_TAG(arena)
> > +# define __nullable  BTF_TYPE_TAG(nullable)
>
> I feel this is too early to put this for the whole kernel to use.
> Only couple fields in sched-ext need it, right?
> So sched-ext can define them locally.
>

Ack, will move them in the next version.
