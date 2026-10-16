Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAD3BB57
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114784; cv=pass; b=uu5efUv5faFy96Srq8ZqiqbyR4CRAe3dWVWdSWBBPeUSVs81YkXYVOCu0b0sUm4EKEIE6YSWQHoa4f4i/ABX2QxROiruCDsNCEStLXXQJbLhJEkGwc34l80nT3b6bD/mgbG+ghY6mfDmAL5qPnPsRe0+58rlvtqu7nQCjXfoKrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114784; c=relaxed/simple;
	bh=cjNQcfCHiAljEu/nBB01FciGuvTkCxc8ec/l5HIAeQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArK0Hgrm8nfkeSc0GB6JhuRCE5xKQamIbzmI0jy2wMhmnYzmIdo24cSfEnUWkzOavOEfV3Qdw1l5HsDLjXrpCSIGXbBzVoMAbRtTEil5lG0YJwZ9lRQVCTAZyN81F7SYmi+e3PiPmmTYKCNtCvbrfcdKh3g5BwAHOxAvDABtO6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmH6H6mO; arc=pass smtp.client-ip=74.125.225.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmH6H6mO"
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48af3d6f47fso1877799f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792114781; cv=none;
        d=google.com; s=arc-20260327;
        b=gmULZsxcmYjcUKKoc0t41NThGb2LWmUlQ8utR7hBCTdUi8uRHqC54FZgyWFrNkF/MQ
         LukgYZlF0ZID8SG3l4pdAkGAJNtTBUzsSVuR2CS1bUerrku+EOoSJ0wWxAfX57PonbaK
         xjIfAtxq80s5MYNRUH7TLKlzzjSqPo1qe33ujOtXxkdBTFJafZ8zBNVTxVf0Iahc8Zqm
         MPjei7ES52V6V/kWMFpT4X+cyMo/xAQYIgPiMdJJOCi2Q1Lg4qyzX0rEK+HEw2O10wY8
         M5TBPRSV8cqSNww7X96ux3S+LimV+prKb0P0QPnDIBXKlRtVOTTGEin0MehbSMtBQMdD
         9i2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cjNQcfCHiAljEu/nBB01FciGuvTkCxc8ec/l5HIAeQ4=;
        fh=XRb9Qb+KyVvM3PB+53gjUzCWf1FO/OLJrYfCzoUflUM=;
        b=cPKUiyCvnJKqdpcyVXOitgCbdG6LY8zGxHSqARj1lMTRT/k/LraEvWP2qeMTq09uap
         BlDs8MLa9ftIqqkfkWtAj5o7MZyXcAKLmc3unLwXJP463HtJXaRTQSJuxWG9k4xmxv8A
         sVsAhYHyH/mtfsOs12UVv3M8yCPXJnUheojTZt5riG9a3iiC7ANm+51f10PV62QLpjet
         p8h4MRFe2s6Sp82OY7kMtGNf8FOCjbjsxclhCiJsPI6MlYWFDp8qaFr9AweFL1fytPGu
         7fQew8YMgXSv6PDpBunli49empeLAUyaxaKB4VTbanESTNzpArmtiR6unXUoNvF4s+6N
         Vf7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792114781; x=1792719581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjNQcfCHiAljEu/nBB01FciGuvTkCxc8ec/l5HIAeQ4=;
        b=jmH6H6mO1LO9gVRlX0zRBQhDi10jJU3eou7NmAMk9rQ+AClpLyr0qIxdVrd3/zUQRI
         QUJwVfHGV7yRqkoEp+oFf0D4IJN/lCXzqq1WzwIvgJj1zDt8Am6bC2VGZLHt1JKG1WDU
         xf3H6a0bkFyOZgJuWKxw4uQHRe7716mf0HyY6Zv9NTx+nOPabBpGsJxACroHMipHeIWE
         CS/CnCS1WrzGj5u9o8B45uL89Ve+DDm13YnDlgL0pjMvjgaT76uHPIQOR4EHRcqK/sfC
         WGGjFxUmO3mIG/Zm7toT9AeUU74gj1HsPJsDSbwCNzkF+fn3l+5lzo43zOPLxQJO6uop
         OQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114781; x=1792719581;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cjNQcfCHiAljEu/nBB01FciGuvTkCxc8ec/l5HIAeQ4=;
        b=nQU0ZxxNLVt2QzhmygaLO7VkiqHdwWLVtWuCk+0gov/vsIJDDUNg0KQUD0zxm50NI/
         b7lcbLE/GO1IYdGRadjBbE5KesBjaUC573PoyCzhIffluXb4FuAXYFyVLoQK7NKohhiU
         b5DRxOds9DK7EZKXm/S/peg+ALEZiNkHduPvge5BvZNOUGDgf7CzGBn+gK4pcz9n2kDh
         lLxSwFjMOeYtJ5a84qSJSBy+D2ai5hCR7Be6Yc2mbw5ZOjm6z0qSNCEw7fwyy48VFxjF
         4K2kbBbYu9QkaOPp0pAFFkUMgvkveSIt+sFSCkLZXU0y2XrxiS8Tgr+GgVxsCg1fyVSv
         /0qQ==
X-Gm-Message-State: AFq9FYIdOlAh+2amymQRUyWyNnAgBzT0pGUnqS7gAG+OSikqYmwpduDN
	XisG1ogFeAUbfUe4ZzQwVrUOw0OU9UPb7anHLojz1cmKUO49tse0MrxcROuoH+HD43mfUjA24iR
	1g8B7Y2iEx6bb4EyDfTcsS3Vi0YdM3ZQ=
X-Gm-Gg: AYBFou0qkhf8sSRQhQAhFK0McvCh1BnAY+nxulqjxPSi4icJR9zzTrycWo3KrvyJB5P
	xDkIZdHPhZ8Jd1F75sNt54I/g9sSm/Q990++z0iLUTYxMF9njLnpQ9EWQ7kKQSxZ9YTM3tPtMjZ
	RN+SC8PgiVxBTEQm8hmgPxVmrwPEmBWSGnokGjBQ8LoMEqd1nJ5Lq0C2yGX1acm2BdrUWgg8V1g
	ZvG+BhsrYd4tp36z2K5jtNu6CQ/dYn1ZXJr+9USp+Zr2rgKAdAKLt3AmawhdKHzB/Vs+7tDzqPQ
	VDSCdjUJbiSOJ6ozXkXPm5jXDXLWg51BDFvSC4s4n+xNhTxAT36mLf6OL4cl6Yg+1PuF2edJK2z
	UmIiwgm2UFCJu86kBm4kWCdgWBuAHvd4mRdlTrd8Iw5wBYkx+jLVJ0kJeg2WOnQQ6wz1GN08TZC
	Drw5xkaaNy0iYmaWZNwBGI5CRN8mjcvpo=
X-Received: by 2002:a5d:6f0c:0:b0:48d:f491:3517 with SMTP id
 ffacd0b85a97d-48df49135b7mr8419855f8f.52.1792114781184; Thu, 15 Oct 2026
 18:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-7-memxor@gmail.com>
 <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com> <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>
 <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com>
In-Reply-To: <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Oct 2026 03:39:01 +0200
X-Gm-Features: AclHuK9W0AveCd2Th7mZ_yOffM1I5lJAzsIhUBIW6bd9qnMu_cTu0O8exyuf9vY
Message-ID: <CAP01T77q9Q-kj1gjsm1U2Nd7QaqjjSrNhF232-dt7cehrWw+uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 03:31, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Oct 16, 2026 at 1:24 AM UTC, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 16 Oct 2026 at 03:10, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Fri, Oct 16, 2026 at 01:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >> > it on, as the tag says. A tagged member of an existing struct thus asks
> >> > every program that reads it for a check, including one that reads it
> >> > through a probed pointer and relied on a NULL dereference reading as
> >> > zero.
> >>
> >> Commit log reads like BTF_TYPE_SAFE_*() can go away one day,
> >> but with this change adding __nullable to a member of task_struct
> >> breaks every tracing prog that walks through it without a check.
> >> So the tag cannot be added to existing structs and
> >> BTF_TYPE_SAFE_*_OR_NULL lists are here to stay, right?
> >>
> >
> > Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not clear
> > to me how using the annotation over that will break a program (see
> > type_is_trusted_or_null() usage). The only difference is that this
> > annotation works with type tags applied directly on the struct.
> >
> > The only reason I did not drop those macros yet is because our
> > baseline GCC version does not support type tags, once we move to that
> > point we can drop both the macros, rework kfunc suffixes, etc.
> > sched_ext is fine taking that dependency. The tag when specified on a
> > struct member directly will do the right thing, just like
> > BTF_TYPE_SAFE_*_OR_NULL does.
>
> Got it.
> Can we start moving into this direction?
> At least for clang compiled kernels we can drop BTF_TYPE_SAFE_*_OR_NULL ?

Yeah, makes sense, I will send a set doing the conversion.
