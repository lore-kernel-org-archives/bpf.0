Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267721CA02
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188638; cv=pass; b=oE1mE9fySSrn8BEUNyCPuU6LNwI9OkoOlLdKQKLOKVAQhYX8fra0UKwJUjc3F20FxcekrLGuoEn6O2g6GJshYbXm2+ulTcAlS4Uaz+GDt5adlZfhmKPOsmuBHvuPX/bhY4HxJmuwvfNTc2ZabzvBq4GG+vmEVuMvrtw+3GSO3CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188638; c=relaxed/simple;
	bh=GUfPw0/G6pQWfTSI9R84KO2+W4W38UOyhgIGCzhyi3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvKP/lh9tu0nwtpcyRBOnuPLrGOUAIZImTuKcDXsfdA84fOr7TfEQkokEQnchayUE5NkDKtGDavXA/rkc/Rk8ywWz76nKWz1r+9kEEHbS/INGQ+QWMLKIT3zTWwGXT+DVQRc0RxkIPa2DRfzEZ8FIn4gNou5acwK3c1a1s+Uz3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTN+fDX+; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTN+fDX+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc305914so2149184f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769188635; cv=none;
        d=google.com; s=arc-20240605;
        b=dEqEKgdHw0vOhuSHKTvro2nX+7wH8RwdcUTuuiEmclnw4jNdahrZMMThy8NraGx+Nx
         3C63UlY7XRBZ9lUT79GfgAcn6OzJWA99yELscXnL403yOv8AwWg05cA3dZSvFZC0fFVD
         mn0nAJjHNr5bXGivtjQEo0U0mhLsiUiQ70W4drpbjsA6l6tWc1HsVYTFEbPhWZgQBUsU
         Pe3D9mHOM10E95BLzwDqK7lV5oSU/8In2CXw6ewSH/0IOJ/gsEY2xX8se0kb60xyoqYY
         pzVJyrLsMW7vUfr/KddmuRvReTEpIcvpCwSCvN4OJHzNbCJHaUjTDavJbB7w5Alwa5tE
         +a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQHgTSmXZEpEo4KSjZOkONOD8L2OoZKjMxGcQiGdB9o=;
        fh=fgKuWAwrPA93AAgmAid+ntX61zo5emBWKaUHorOCgYM=;
        b=A13anhxS1hFeS4O7PiaqylStlIqbk/ULaGIAjuKsLGyduvAqFwqr7vcbqPx87HjZCk
         8kAPV7JPRFZfxxHZv+b21CwAGdnJCjgJuynOu8UbPtsHHR7XS6f8nzcJQKBD5WFGVKfK
         xeu7Apn+4zO9om++1sDTMyWzRBZLDEfXqyUcvwxW1G5zEG2dMzarH1hMHX4s5LSeQ/pK
         YAwChIvi8v9sLdoedYaNWPuttx5dfiewnF2+GgdkzTT4+TRoQ8X9XnN6C41ClVDhVE3q
         uE317JKHVXEH2mf/KDba661T0qe2jFhc6uGsDrsT/Yqk4vq/MHyK+3lRCsCGgU7h8r5q
         YOKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769188635; x=1769793435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQHgTSmXZEpEo4KSjZOkONOD8L2OoZKjMxGcQiGdB9o=;
        b=RTN+fDX+BSmd/DCMekZwWzvFJHD8P5ChyMHT+hqYZV3GRVfW/6L0PRjOAKwet+NPj/
         f8r9Eqt83iJ7OFHJBWOqAap81Q1pVSCT3gL69H/GyYNbgyH7zTPm2FHCl2QH0tbJsSia
         +BZf8xGX0aDjQNUjogChiWQ6JlyFgAx9t87iBppO5Zvjux7lHglIRV6g05rBGGEhi2oy
         wHCLPHZ2M9jme2i5ApHiPK19SQAB5be/g69gwZRzv0rN19N17+7LV7fNRt3ukxy9B8F+
         DVxDILgX/DzV9nYq4QrGDYc9gEo/4Oub5pk3wsLXB19DkfA+p3YqWnZDZVzArQ77bkxH
         5dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188635; x=1769793435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQHgTSmXZEpEo4KSjZOkONOD8L2OoZKjMxGcQiGdB9o=;
        b=ipIWnVmnNXqcp06kxyVT2c558W1sp7K9PrmLUwsaGEVSYt7gGCxC/xrc77TcrwDwcW
         +gm36CUEcGXXA5moethDQ9WhVP1cv0PzgoZWcUDZ+/n3Tc/szo+Yz9gqXqHaJukMaPpN
         ZzHMYhbwIdjXbQdJIWoWZRoE1lcy0qTh8yWxViyo0E2OmogSmFdaFcCXeHnueXL1/4aJ
         Nb8L6EZJ7zmCHmtw+0mLCS0FQbR4s/JF/T7h58eFc0gRKqxoP6876EhFDrk05pe2RyXk
         RuTpiiO36bCL/c/JnLVoZ+xZqBKhOesMPmncUF3xqEv5M7duypChiNNDUTjA2VqRc+I8
         0+wg==
X-Gm-Message-State: AOJu0Ywn6rjHP412h3X9GNADnjOA6jEIjfBDAnnsV7fRGUtWyTmChx9Z
	pKcjYaa0SkB1IFVHwymWLc+gjJlBki8/6UlD8hBsw7ohoNFQqbqmZZqqsj0KrOun1yI3HBhlQV7
	BIbkOMJfOrMRVQ0q0NMV12wgkHNTiCHk=
X-Gm-Gg: AZuq6aISxF2C7BgdIOzvU7h8gGJMesj+AyDxIWqZ+D1eIjPQwakYYOlR//yrGCrZGlu
	mJcwDrPrVqD/zi9eSjhSbAmQ7kBjT/MRG8kyaleFuFim21LqLLImxPLHkUugnCoB1ikl4AeSEmP
	cXv9GPOC1bhGVsUyPc7G6Ia0A7nnK7FBUHdG7sEw2e0XH8iZ6fXQ8ppapzZ3QscI/CIEW55HWR7
	c1g9mbcOM3hsDR4dUDk4Kvl0GNL6biWecUAe/f8JiiG8/cikHfL4PWIkTmRIhP65YzgyDzUj+j3
	GoMQeD2hz6BA+3GGcx6Zdu0GpT4VJCAGXSWH1YkNRAZelFrM/G7l2WvNhsnv49C7JK9M5kB7
X-Received: by 2002:a5d:588b:0:b0:432:dfea:1fa8 with SMTP id
 ffacd0b85a97d-435b1606153mr6161699f8f.45.1769188634754; Fri, 23 Jan 2026
 09:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com> <aXNWLU7ay1HHmg6S@google.com>
In-Reply-To: <aXNWLU7ay1HHmg6S@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 09:17:03 -0800
X-Gm-Features: AZwV_QjBUT_iFI1GwK4tezVV7xOTQDKRIPJyVhhxT05BIbzO6eNIW7bDinwyFmY
Message-ID: <CAADnVQKHuj1snSOBh+VEJrcW82OW2zNOEd1=Dqe-m+kuOV7MWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 3:06=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> On Thu, Jan 22, 2026 at 08:26:49PM -0800, Alexei Starovoitov wrote:
> > On Wed, Jan 21, 2026 at 5:54=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> > >
> > >                 break;
> > > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > > +               kit->pos =3D css_next_child(kit->pos, kit->start);
> > > +               break;
> >
> > There are no users of css_next_child() outside of cgroup
> > internals. It's a red flag for me.
>
> Hm, I can see the slight hesitation here. However, until somewhat
> recently, the same argument could have been applied to functions like
> css_next_descendant_post(), right?
>
> css_next_descendant_post() has rather recently started seeing usage in
> other subsystems (block/, kernel/sched/, kernel/bpf), despite
> remaining internal-only since its inception over a decade ago. Given
> that css_next_descendant_post() continues to remain unexported, in all
> fairness, I don't see css_next_child() being all that different in
> this context.
>
> Would your stance change if Tejun agreed to mark css_next_child() as
> exportable, or simply agreed to it being used from BPF cgroup
> iterators?
>
> Both css_next_child() and css_for_each_child() have remained virtually
> unchanged - and therefore inherently stable - since their
> introduction. I should also mention that functions like
> css_next_child() and css_next_descendant_post() were originally marked
> as exported, and only later unmarked. This presumably was done as part
> of a symbol cleanup, not because the functions were unstable
> primitives.
>
> > I feel there is something wrong with the use case. It should have
> > been handled by the primitives we have.
>
> Right, arguably it could be handled with the current set of
> primitives, but it isn't nice and certainly not as efficient as I'd
> like.

Why is it? Just descdant_pre and break out of the loop if not immediate.
The thought process should be to use what's available as much as possible.
Adding UAPI for specific use cases isn't great.
If it was a new kfunc that's one thing, but here you're touching uapi/bpf.h
So acceptance bar is much much higher.
