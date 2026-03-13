Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340037DEB9
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434971; cv=pass; b=qz9GfaJwouoZYcHPL0OKp4rvOwFzOlBVKG/gKtobFveF542wJl6+ZPNU7iseaXUbz1gW1gxhHHkO1NUVFewDsyc711rBzFO4nGrwje9ULeRvapFFZckHHpSYYUWZeEpnCfK9gBC4IOuedSUOK2ICvix2T6TZjmZw/BMYi6O85Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434971; c=relaxed/simple;
	bh=O4wbrTj2iFx9LOPFO28szlepMww2CuIsX/kRVN1W6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfbLZoN+SDiTqWP1zbcia4Pr4zwWiI/QhZlndFxH6wnn50tTzUhnmqfnnfed96aMt7+PFGCAFr6sBLVlGTf+ijOgHwJfUCc1gdR92Cx7i4gCBsr88blbae8bYDDwDf7qRp9vUDAD4sAhZi4bNtEy7+GOsECmMqFgEO+gtveHjQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b09BfDRB; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b09BfDRB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7dfcso27998447b3.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 13:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773434969; cv=none;
        d=google.com; s=arc-20240605;
        b=Iwi9dVXNg+W31CvEN70mY1nH334VdFDIAaHKqu28BC9BW73hgpiEHYoTz8fkrFLUBR
         NfZBDYrYAlg8cxo+aC8QMgm1m+VA70lWPAJJRE3DeXZPeTSjG/5tCqi/6vSleooiS1hf
         M/5+GzvDCvvEGjd0bqCtX4Esa7wsAGlFGNLYaWCkaA3m0K9Dt/+prBpu+mNzr+kZ3ysq
         jDrq4/nxS0u5nVIW5kfzVURA1D+0pKonMuwtKc+xtZprkiAiD8SlCURX7ZtUYMFcN70b
         03BN0v8q459ASlOfwO5yBuWlA7e29/t79XbDpPUJk+JbNuVZEwuEgpUqFjeXYdGN0yp4
         zAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=apG8piXI0ZtG1MH5uw7uX0AOIWii3C0HCfZ27wjcvX4Z9MRfPl+lnYTe89HiY00Km9
         VJW2atPBmJhM1WK60HAT8YtumJ6hrpLxsvn4jbTO0mpjP3xkL1fycWkOO85FNly/GVkL
         9enSvTNpdWeW+iTheR3oKXe8gNDm2p9AhTTBbx8dtvqdaLGR4xi5L7uicDwcJjby+7MA
         /0y6pNy+/wzj28oeSQjS3JE9xZfoPmFgRWiJ/XB7uoCF0Ua4xmPKDdNk0vRkdmONa2Vl
         I07ibUHEQaLDONb6FEyYSV0ZQs1FxvhUWSeUz7VkSghCQHSOCnmTmSiwf2OYYA9lp2a1
         KjoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773434969; x=1774039769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        b=b09BfDRBn9O4CCA3xlpK44MKY+U0leb+gGBGpwYUB/JJ7wZMu8Mya+G+v54yM7AV+4
         0j4v0qtHpezXDMVA3P1R4EzyPV9iKgIz3YgXFuNQCvhRhbr9/AL1Dx6UhvQC2MnJo3+u
         XXjBhoLeXQ0LQrhMeJgNt01LNYKFI79+xvy8qafKlvcl8mQkMHCmoCRFb2QzD/NJalhX
         GfpIp5bUC2nFd8LMGccz3Ze+0kiOiFBkzefR+MLp1i9yC9sfXSBMiKW+52fSuJ5Oq1eB
         9oeW6+79Ke8fBYm4TFDFtnWcMRAr/ecooIqGW3ax3i9o+fUvAVo7AKzYmZ8b2tBod5I5
         DWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773434969; x=1774039769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXiszcF7N7frIIzHU2H1mV1fC3d+rzKovPJ6OOhwrtc=;
        b=S20tQJBcFIxzbgnKeX994FQSeWTi2XZNbJkiR8NoBaj0ALsN1lckjx9XMo2OT9U+LN
         C9Q8LsJeD1epMd564xoOfr7daMwFiWQcHvoOxbXjaGGpOAF8uvU7zV+abv6MLTV6cOnQ
         VEbIg/r0dBY8bydC4P50ulkktX59Okck9lwnND3NCmWKkElNXfOgWKGoTQJlcIsl35al
         +dWT1/JbN67uqYS/PxCP2YweY0Fu8W7ziOK4bpi0m2IlzivZ37jgzLklv11LC351IbKY
         oUHfrtVgwMo82ffHgI7e0wpR+xUcVEleINVxqlX9H4KKmoQFtTFa7nV3xrzckfi2FocA
         gvjg==
X-Gm-Message-State: AOJu0YxXcEscHs8MAVn4QChPSusfPlvcEWBEsnOCPFuqzBKx25REo0eg
	Hm9D8i8doZCW/QCKIj/1AQs5q2sq8erl4BbIiPOWV/lbOodvp7B5pD5C3rWTxM8xn+mUArE1BDH
	NCHMuyZ/CFXybqKfl5b9P8yh/jusF+EE=
X-Gm-Gg: ATEYQzxJdJuf87ykOMza5uliO+OWZu6yl+TrAA3NUIHBxgMbwngfpi/hTPtjrpAr3qo
	Ae51UrrlgcSotJl3oJGH3mAZICUHpDrioWPfdDZj4JIQVCjfLsytWzTyO8wg18QGokJ+9CdjbOC
	kSpoHa9YwLgj7OQ+PvrHVN+rZoSbT8uXzPEAo/xQyx9WOZGFA0cfLpB4w38DKFChnsXtn2d2trd
	2OavrRZIXPdMYSUFdoIf39h3b3bziGXZc35pxzphd6ljx/H3n05b/Y9la3HTBQ0FddUxNiBt2SS
	qFP1OC8=
X-Received: by 2002:a05:690c:387:b0:796:3c39:eb96 with SMTP id
 00721157ae682-79a1c08c187mr54233147b3.13.1773434969119; Fri, 13 Mar 2026
 13:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
In-Reply-To: <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 13 Mar 2026 13:49:18 -0700
X-Gm-Features: AaiRm53lfScGUwYFmbGubf9WkTuJ-eGkQhpEuLUjD_uObXyRLbmaYiwZq73tqFY
Message-ID: <CAMB2axPa=tgZm5a-2gP36VWf4Xt-ZrMDXBrTsVLYqY8UAzUnhA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] Dynptr cleanup and bugfixes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > This patchset (1) cleans up dynptr handling (2) refactors object parent=
-
> > child relationship tracking to make it more precise and (3) fixes dynpt=
r
> > UAF bug due to a missing link between dynptr and the parent referenced
> > object in the verifier.
> >
> > This patchset will make dynptr tracks its parent object. In bpf qdisc
> > programs, an skb may be freed through kfuncs. However, since dynptr
> > currently does not track the parent referenced object (e.g., skb), the
> > verifier will not invalidate the dynptr after the skb is freed,
> > resulting in use-after-free. The similar issue also affects file dynptr=
.
> > To solve the issue, we need to track the parent skb in the derived
> > dynptr and slices.
> >
> > However, we need to refactor the verifier's object tracking mechanism
> > first because id and ref_obj_id cannot easily express more than simple
> > object relationship. To illustrate this, we use an example as shown in
> > the figure below.
> >
> > Before: object (id,ref_obj_id,dynptr_id)
> >   id         =3D id of the object (used for nullness tracking)
> >   ref_obj_id =3D id of the underlying referenced object (used for lifet=
ime
> >                tracking)
> >   dynptr_id  =3D id of the parent dynptr of the slice (used for trackin=
g
> >                parent dynptr, only for PTR_TO_MEM)
> >
> >                       skb (0,1,0)
> >                              ^ (try to link dynptr to parent ref_obj_id=
)
> >                              +-------------------------------+
> >                              |           bpf_dynptr_clone    |
> >                  dynptr A (2,1,0)                dynptr C (4,1,0)
> >                            ^                               ^
> >         bpf_dynptr_slice   |                               |
> >                            |                               |
> >               slice B (3,1,2)                 slice D (5,1,4)
> >                          ^
> >     bpf_dynptr_from_mem  |
> >     (NOT allowed yet)    |
> >              dynptr E (6,1,0)
>
> Ugh... This cover letter is... intimidating. It's good to have all
> this information, but for someone who didn't whiteboard this with you,
> I think it's a bit too hard and overwhelming to comprehend. You are
> also intermingling both problem statements and possible/actual
> solution (and problems with earlier possible solutions) all in the
> same go.
>
> May I suggest a bit of restructuring? This diagram you have here is a
> great start. I'd use it to "set the scene" and explain an example we
> are going to look at first. (Keep all the IDs, but mention that they
> will be more relevant a bit later and reader shouldn't concentrate on
> them just yet), and just explain that in BPF we have this potential
> hierarchy of interdependent things that have related lifetimes. When
> skb is released, all dynptrs and slices derived from those should be
> released. But also mention that it can't be all-or-nothing, in the
> sense that if dynptr A is "released", skb and dynptr C should still be
> valid.
>
> And it's currently not the case. That's the problem we are trying to
> solve. At this point you might use those IDs to explain why we can't
> solve the release problems with the way we use id and ref_obj_id.
>
> Then explain the idea of parent_id and how it fixes this hierarchy
> reconstruction problem.
>
> But then, mention that socket casting problem which introduces shared
> lifetime while objects are actually semi-independent (from verifier
> POV) due to independent NULL-ness. Which makes parent_id not enough
> and we still need ref_obj_id (maybe we should rename it to
> lifetime_id, don't know).
>
> In short, I think there is a clear logical story here, but your cover
> letter hides it a bit behind the wall of dense text, which is hard to
> get through initially.
>

Thanks for the writing suggestions. I will try to make it easier to
follow in the next respin. Really appreciate you sharing your thoughts
on how to structure the cover letter.

> >
> > Lets first try to fix the bug by letting dynptr track the parent skb
> > using ref_obj_id and propagating the ref_obj_id to slices so that when
> > the skb goes away the derived dynptrs and slices will also be
> > invalidated. However, if dynptr A is destroyed by overwriting the stack
> > slot, release_reference(ref_obj_id=3D1) would be called and all nodes w=
ill
> > be invaldiated. The correct handling should leave skb, dynptr C, and
> > slice D intact since non-referenced dynptr clone's lifetime does not
> > need to tie to the original dynptr. This is not a problem before since
> > dynptr created from skb has ref_obj_id =3D 0. In the future if we start
> > allowing creating dynptr from slice, the current design also cannot
> > correctly handle the removal of dynptr E. All objects will be
> > incorrectly invalidated instead of only invalidating childrens of
> > dynptr E. While it is possible to solve the issue by adding more
> > specialized handling in the dynptr paths [0], it creates more complexit=
y.
> >
>
> [...]
