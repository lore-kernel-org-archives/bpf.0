Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21C2DEA61
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962459; cv=pass; b=HS/fTqCfPpW5y5P71JLciVYJjNxyOYUnSDmmjqoDiJxqdtwaMOXVeFJsVYNNKxlR/qRkRHZyw5MUiHN4xIR52ZCHskSLaBIiWnLZ5ngX/PoCYWoaqDsmK3GpxikU9t+d58aUnOEA4O6C2IoZ5J9ZKxqEB9d6jDNIMd9FJ2AuhaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962459; c=relaxed/simple;
	bh=Pe8hPjrABZiLebwv22zM+qpu10Ni/VZ3Bzz8Juytj+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0s9P4oOKAzLTiDQadWge2WObJeeVar3Yh8D+OpPkd+m/OpRCkjprvBaIAAc1cVugJOyBmZbOVnAAuB7dRYzZ63kG1Am7DpMkerNWmDYHm2feC5xtIuHdM64sdFH+9aTyISMglFw7LkX85+/n7tuIGFhP9fSfgwjXVmiLJSSTFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za1ByGih; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za1ByGih"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c01595276so9070513a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771962456; cv=none;
        d=google.com; s=arc-20240605;
        b=FTV7IwshgMxAf8o+Z3wOmqCAYOntusVxwzqEXmBtk8Ky7jLIrtmL/EYWIZGcRrTJ9C
         KgkCjSq5h+mRRwPijEz8ulF5O2kNwoy/B26Xqmoe7wzi83u3vSZl88mt+KxziClz5Vc5
         6VKJ2efGJVRkOTlcEQLsZzedqed+wukYwbqJBitvHXv9XL+L/pPSZI1J1Qh7ZmEmgYcn
         JDtHnfQ3minIbkJzSn/Q9lFmB3/bo0V+vgYFPYzx3P7J4Lknmq+n2DPtJJl+mbM/YR8a
         Crh+qBy2b6e/qPFS/jal8ezZ/0y6A94snkOhdh3knaHf9pSmj9grunSWLre8gbpnaxof
         r+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/k8GaEiaXjkxqI4W3eEwy7CYvssj8PlipZigrcxTOw=;
        fh=dsuHgycUYwf62H4ZRa6XK2GSqOyBvE/QMeUO5ECtrqs=;
        b=DvNeHppLqZMf4inZyeJ6lLb0g0TMYBPw4nLIniHGp7SGjav4OlUvtCCnOhxPpyV9zE
         4vPLTclO53qBP/7IS9OD93F1dlmhQN0dQyf5+5uxgDs8az0YPa65qSEeisZ1bPmjSkkJ
         +2atJah4zUagO9iZGYo5N5HghWDuAW6jBVA3lyqsox7sgzFDPgxiuyVi321jsxp4Gn8I
         aEo8rhECNq5kbODIyycx99fEXvdEjfFJY+LNdv96PtCgA8w/YTzOqimBr31g8LthmUk9
         1g7/6jvQ5QZL2QFm7On7sOkwvR/zOqqWv3nYNEThgRefFd9UwOwdyPLfk3c6w03Js9Z+
         00TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771962456; x=1772567256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/k8GaEiaXjkxqI4W3eEwy7CYvssj8PlipZigrcxTOw=;
        b=Za1ByGihrETK8RafKF0yMGvcUwJDLOVKEBEkU7urXRQk2hajHpf5jZp9Yc9+IuSS96
         JbrxufKRbbdzYxMyhyf7UJftC+LTl3HcPf0aNKu5V8i1CdUAtP9avQE89hIhTEL7SORR
         0LNJLDsBnHxY+MBcyoxZg2N2BQ9K3iWEJIDf2CWgQJLfX081YksX3n63wy7jNdeW6MDk
         FYj+c+J0cWpSvXIi3BjtnQ+af8JNw/1qoPK5SkXXOMgK8Y0LoaD2T+2IVQpLjwPiOmdT
         cL/FUgEHiHETBJlW/HfK7HT8cQqKq2lWzJ5h9ZKsBlDDdadd98VRsGL2G8Lc6b/wmxdX
         dzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962456; x=1772567256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/k8GaEiaXjkxqI4W3eEwy7CYvssj8PlipZigrcxTOw=;
        b=kF6fdlxTnA+z2TrX3z5vhQyN9c0ZfLbHxkf8Jx5/mXTnh4VaLajZYuBzn83QvkChIn
         nj2Ckj5u/6bFoR0u7hNIHG+AlO/EjTpLr5k++vM4gzK9tz3ZbIgjsO0IoEQdkdVXm4in
         j5KH90tnFywyL9isaHCdB2mUPhjOfyka56trtUx9ZxgumaPToHFemE+iMBcZvG9a1VUO
         9OKOK4jKlwwWv5Dcn+1K8WvyMsgluIuaCjkGsWsj+kQsJl9RgUSCsl9d65Y5cn03WxzU
         CGBMm2sQP31y7qmVIpOFk/lMKaFRTMVbVwiZIosDlVdada4H7/ywkX/+wt6zNJANupuq
         bxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5DhOmeKpECGwN7NNz9NL/yHbULUcOnSVyqAr8NsvCVikoTLM8nABt0OBotRh5W1q+CoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFac/xaV0uerkaQBypTkP1auGhvQLAOGsNjQYL9CzJw26bAGIJ
	U/gverOt9pqfgKltRCgY+sMFydiioqEwxMt1yAuMzCb0sgrh/yvCrYgLc47OYS/4xzmVHWJFVnw
	YBj+L/48npqp1F3XNTRwOYUwqn8JXz1k=
X-Gm-Gg: ATEYQzx9HC4C6UF2ZGYSs9hfhwm1baO0Wk/NVVmh1HuVBERim7pbAYWwf3fJtJTO/Ao
	yX4jeHzhaNtjz4QGdaQNJEEfJbb2aaEo6NCRj8TxQ5zPc86gOtmBiVfyavfQsPbXBlDRj0xppPz
	zn7TXTOWuwaTHphCP/n/2AMu3cT/oYJhqkiNp/ETyKFE6DBIYOB4IDn5Iu1hqaI3s5ejdg6LJmv
	HmDvn762F99UKtNyAa0gPMQ9gA7qGWJ7KkKoOcwa4g7ZzLgUr9klLCXYrnS1icDte3fSDqwCo3p
	rkh+4w1H
X-Received: by 2002:a05:6402:4445:b0:65a:3655:9a05 with SMTP id
 4fb4d7f45d1cf-65ea4ebf33amr5533782a12.7.1771962455820; Tue, 24 Feb 2026
 11:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223174659.2749964-1-puranjay@kernel.org> <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
 <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com> <CAADnVQKpRu8=F4vhOgiaOriuecYG5HOk5pUMT8W9CqQSjdkLNQ@mail.gmail.com>
In-Reply-To: <CAADnVQKpRu8=F4vhOgiaOriuecYG5HOk5pUMT8W9CqQSjdkLNQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Feb 2026 19:47:24 +0000
X-Gm-Features: AaiRm52GN2lBtpvUpQ2cP734lIA6uiNCXkn0r9sLv7X8b5sHushaI85iHlVYjH0
Message-ID: <CANk7y0iR5sJkP99ztihrT6DDAp-DA4nZ2heR2kNXgUnKVURWAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 7:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 24, 2026 at 10:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@=
kernel.org> wrote:
> > > > > >
> > > > > >
> > > > > > Iterator KF_ACQUIRE support is not useful on its own right now,=
 but it
> > > > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _=
next is
> > > > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "ho=
lding this
> > > > > > pointer forbids sleeping; calling _release invalidates the poin=
ter and
> > > > > > re-enables sleeping."
> > > > > >
> > > > >
> > > > > The name of the flag and semantics bothers me a bit.
> > > > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_=
ACQUIRE.
> > > > > And document it like:
> > > > > KF_ACQUIRE -> acquires a resource via reference counting
> > > > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > > > >
> > > > > and to match it I would do:
> > > > > KF_RELEASE -> releases a resource by decrementing refcount
> > > > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > > > >
> > > > > When lock is taken it's typically prohibited to sleep and do
> > > > > other things. So I feel such flags would describe what's
> > > > > going on underneath more accurately.
> > > > >
> > > > > Thoughts?
> > > >
> > > > I am fine with this except, I think we should still keep the
> > > > KF_RELEASE a single release mechanism that releases according to ho=
w
> > > > the reference was taken (refcount/lock). There is nothing wrong wit=
h
> > > > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > > > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > > > KF_ACQUIRE_LOCK -> KF_RELEASE.
> > >
> > > yes. Is this too complex or what's the concern?
> > >
> > > > I am fine with both but prefer the
> > > > common KF_RELEASE. Let me know which one you like and I will go ahe=
ad
> > > > with it.
> > >
> > > Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> > > but would like to hear a 3rd opinion.
> >
> > At the moment verifier tracks the following locking/non-sleepable
> > resources:
> > - active_irq_id        - nesting allowed, forbids sleep, special stack =
slot acquire/release logic.
> > - active_rcu_locks     - nesting allowed, forbids sleep, used by in in_=
rcu_cs(),
> >                          no special acquire/release logic.
> > - active_preempt_locks - nesting allowed, forbids sleep, no special acq=
uire/release logic.
> > - active_locks         - nesting disallowed, forbids sleep, no special =
acquire/release logic.
> >
> > Currently verifier checks what kfunc/helper is called and changes
> > internal state accordingly. It might be possible to slice the above
> > into a set of "generic" flags / feats, but it requires some thought.
> >
> > Maybe explore this as a separate series?
>
> That's exactly what I was asking earlier.
> Yet another active_* counter adds more tech debt that we would
> need to clean up later.
> Adding a new one is easy. It fits. It's not obvious how
> to generalize them. One needs to think hard to come up with a solution.
> I'm ok to defer the work to later, but at some point
> we'd have to make a hard stand that another active_* is no go.

I will do that next after this work lands.
