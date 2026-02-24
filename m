Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E90279DB6
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961590; cv=pass; b=WU8Tl92df1XkgZLr3OJJBXQxoH3oo+syMf6619zQsU9Tsi1H77ixyl5U8Q5XTWRybQSms1rI4HHZcjTYKyl5h1b7lwMedNoiI50AK1Isf36nUNnS8l7ltHaZT9YGjqVffvGHMChW0gsW9yXyMUmmwIwosdjkya2u0okrKZXinyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961590; c=relaxed/simple;
	bh=Ujr1dzx9TAdmcGPjNq36xOxvbmaICZC0rLNXt8cnDvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGntxYkwkuRVDKloDfA19fYlvgdrfT280EeYT2D+El/7D43knOVRNIr/6MEh6MIqikizzI+5ZsKUR192a6HjJeFCQa9lTXGNKEg67BdmXWFLtWdRNUf1y3Kgh10cuahy8Nc1xQ2egAXSYJbQCyxhEghVswGatKMlyIynT+PjKIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLidXaPW; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLidXaPW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837634de51so26723485e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961587; cv=none;
        d=google.com; s=arc-20240605;
        b=KZIwC3ZL0z4ZZDTbQ799uDUTwg8cW543+OETpQsxmEBumd3GAKdeXwSBbTohtJTQ2e
         BP7gjNBddyWEFrRk1u7g+3PzVlK11RZBpOxtojVLD/J+nrYlmSuAQ9V8jl5rj2Oqh6P8
         aTP/krWiCuhtmvQoPkmXhwuuklDa79GpTtlLevuVtXh2rq6IIt4LqnABZV6S9XB1iAzc
         CxfYgd1RFfLigtIKakByNKUYq0hn+8bFQURtdtrYWJCMzYAofbdd+y9MnCHNteUzlqhi
         0iSF41oLXj2ZcUwT4v0/KWf2jjt718OfW8/rWopYpnINaRUbIWTOfIcaEM1C6WQQIj8z
         +o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QakJzgCSrORHiOiFJrSY68Gz9YDDWOspIrAVH93YnUk=;
        fh=aE6LWjvutyBwxi+ygQ8nMXWYnQpfJZLc8mobcap58bg=;
        b=jOoTcIPJAoDsdi8OWiR7jh6lh2udtEwa/kez7pix/dE7e/lhPqLBvcCO6mtHExJkLR
         +udFPVsLhI4Ng/MzJS+DYuhfdl98IfSpEp9D0B8uXiVp0+yblWjevjU1ypxbjVm/MPbQ
         rXkt3V6p/cMX6vxSYNNOVdpk3e6Le1f4cUuq8sB2NX6Gd+XQ/jV/4Wt79kkaimqMDiXK
         uA5VU0BgO29S5YhzJUrs1zaHWybk8umE0eQRU+hV3QGFzw/sqGa+R+4A91wn1AxVcxSz
         gJuczwZlbK3MnbNn2Ql77oYe/pVyewn/dWzJ/q6Xv9OyZSnyMv7sW4+Ln/XN8sYTvdRq
         uNCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961587; x=1772566387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QakJzgCSrORHiOiFJrSY68Gz9YDDWOspIrAVH93YnUk=;
        b=kLidXaPWstWUzDOgMVfng7IR/4dbIJpICA2b39ArG26Ng/HeHAMohxTcyxrPazkB7w
         YHih/4ntm6nTamk+WY961jai8OKkQ4KIniZbao7sU7+EbO1wXftjtEZLSPPGVDBMTRh7
         ch42oredvvCiCmSxqA7z9bCbxssk44Z50oUjQw8Si5fUARghuHtmeBHTTO+I49ZXFsuc
         xKDLCkSASGCNhwLCvdlQ2KF4kUSPhyb9W6C+mHsOTbSlpXqi7hI7KNr0RPPtnLbpZUpp
         mybUQ3WIsNt+EyPi5noiQwdnx9QqMnl2zVJtCdA1LbTT1aWd27+XH2ZQtmxyUqiUn357
         rvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961587; x=1772566387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QakJzgCSrORHiOiFJrSY68Gz9YDDWOspIrAVH93YnUk=;
        b=sCDBVmfcKkwSv5xmxi/hHldmI+EEKXxOs2MjkCato9zUa+65UmnVsCSAllwsjnpsgz
         hLbGIB9ZFumKwNM7EVv+T2RNvFiAltbfztLM4oEJpOOAqoGbTzSwklEqpcAEyW4hqd1m
         BqD2pjFG0glidAm/z7OvUfK3lEm2hkWOIhbV7ROF7DAMdyw5TIJTwJN6Su3DE8neqSoq
         NDYzefUeQ2vWcjLSvV5V1/TcGTO7xGySjU5/X/qDYnJvg+VIvDssJKMkoVPu/mKyz83Y
         ElneacIO8Znv/I3LD+HC6hl5LxGbSaLdczQThQFf1L7cw5kcEwQtZVfdoIbIK+cTv0eg
         zKIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/2antsNV7nqMxf5Uq0aPJL8ddpit7eS7Dnm0eGYLC5C/MeNPsSGQ4pdmGdEVSTHKsf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKri33cd1M9nfjnI9chRBYzHVTrFWJioq9i+71INXdIB/xJ3C
	NeFiqFrwjVRdLns15DLXQqseWQN+wnpFgm2UhElum6xZEITOQgrwn9zKqmUoyFyWUAOwm5WrMdk
	6erwr3alVI/gPYp7sBbGlDI3uG1ECh2g=
X-Gm-Gg: AZuq6aJWPL9oKC10rwEnt/pBQZ3ZK1TNYjw6taG0u1sS554IqL5xe9HoeyEbtFySKOx
	xqJPOq83fcw2mgc16tarTTgWAxCn4xIg05/fGa48UpWqRph7fauEYOssAM6Viub7MxjXAmx/EFj
	qViFaQ/f5fKs8zdS6TREKPXQs4fIX07oFmGUEbAnFfxsoVgLSlaGTIfnjI7xuVHwF6TFj4bmgWE
	+P06XrQL9gKkGNVNJIeiO8Wqj0AZI507/1JdaixG7vGS2Z1Q07y1S9OaCZDx5OTyMWu2mrpz8HF
	3Eyz0NMIb1h6vDjKkiAQiL6fjNcBY5ppqg+w+e2Lq7I4YiM3d2uc0t6AUVRwq0t20jOnfJ4CFhE
	vTx7nL9KP
X-Received: by 2002:a05:600c:4fd3:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-483a95fb0a0mr194477415e9.8.1771961586742; Tue, 24 Feb 2026
 11:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com> <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
In-Reply-To: <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 11:32:55 -0800
X-Gm-Features: AaiRm51Lt-KE6yc2USF7YdRY1AhIsd_iwbngIA95nTneQK1gxKqPQWn0LLURtVs
Message-ID: <CAADnVQKpRu8=F4vhOgiaOriuecYG5HOk5pUMT8W9CqQSjdkLNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 10:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> > > > >
> > > > >
> > > > > Iterator KF_ACQUIRE support is not useful on its own right now, b=
ut it
> > > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _ne=
xt is
> > > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "hold=
ing this
> > > > > pointer forbids sleeping; calling _release invalidates the pointe=
r and
> > > > > re-enables sleeping."
> > > > >
> > > >
> > > > The name of the flag and semantics bothers me a bit.
> > > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_AC=
QUIRE.
> > > > And document it like:
> > > > KF_ACQUIRE -> acquires a resource via reference counting
> > > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > > >
> > > > and to match it I would do:
> > > > KF_RELEASE -> releases a resource by decrementing refcount
> > > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > > >
> > > > When lock is taken it's typically prohibited to sleep and do
> > > > other things. So I feel such flags would describe what's
> > > > going on underneath more accurately.
> > > >
> > > > Thoughts?
> > >
> > > I am fine with this except, I think we should still keep the
> > > KF_RELEASE a single release mechanism that releases according to how
> > > the reference was taken (refcount/lock). There is nothing wrong with
> > > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > > KF_ACQUIRE_LOCK -> KF_RELEASE.
> >
> > yes. Is this too complex or what's the concern?
> >
> > > I am fine with both but prefer the
> > > common KF_RELEASE. Let me know which one you like and I will go ahead
> > > with it.
> >
> > Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> > but would like to hear a 3rd opinion.
>
> At the moment verifier tracks the following locking/non-sleepable
> resources:
> - active_irq_id        - nesting allowed, forbids sleep, special stack sl=
ot acquire/release logic.
> - active_rcu_locks     - nesting allowed, forbids sleep, used by in in_rc=
u_cs(),
>                          no special acquire/release logic.
> - active_preempt_locks - nesting allowed, forbids sleep, no special acqui=
re/release logic.
> - active_locks         - nesting disallowed, forbids sleep, no special ac=
quire/release logic.
>
> Currently verifier checks what kfunc/helper is called and changes
> internal state accordingly. It might be possible to slice the above
> into a set of "generic" flags / feats, but it requires some thought.
>
> Maybe explore this as a separate series?

That's exactly what I was asking earlier.
Yet another active_* counter adds more tech debt that we would
need to clean up later.
Adding a new one is easy. It fits. It's not obvious how
to generalize them. One needs to think hard to come up with a solution.
I'm ok to defer the work to later, but at some point
we'd have to make a hard stand that another active_* is no go.
