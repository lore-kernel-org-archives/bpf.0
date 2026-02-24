Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24D2DAFBD
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959337; cv=none; b=NXl3pG1HBRVeFz2OSGwZSobdST8fAgt6aiRnGdQDrebrJydm2+VAedea4qBXnIo2uwhVcgOpL3d+7TIUKX2WUOXFp8gxigHc0/KjKrI+jI5DvxhBiILNqKqBbhemENcSzGGAm6Ed75pNg3g5ZLX3qbKejZDGYACJRb6eZp6Yv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959337; c=relaxed/simple;
	bh=EzqU0Smn1FAm5PjOgKnVYigAFnoTcUW16HfetNpOz4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DV7gvy/Hl+27Nr9FZ4esQzQtvY/81D97fC9Hp7y3/tMHDABzDi75I9FvCj5bvXvfGxIMUx6huWIQFs4W13mDamTRXNakQqDYpwbuT03dAHqEdBHGC7qfOWqvc3RNIIOv/1rZXsA7uibmMZAG0QQ5mocyJCAaYkHgO2A2AAYMbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf7bc3Fa; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf7bc3Fa"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so853414c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959335; x=1772564135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N7/TyEbdTq2PdagcB7ilHm5rzAyKfrkKslEbgqDuuLk=;
        b=Jf7bc3FaX/zULM/PgnHTbiQ4uNvdLy207pDvjG4HHOpUI7TFdzQeUwtoGR6qD0qZQ6
         h1HPwzuOt+ZKpxknbquohVCXDQHpgHS35tpjEvQIwZKJn/zrqH4L804Ng5XVojzeD9AX
         sXWIieAh2bIljgpvASGNLycF2Ag1VZegxK3eNyPxc+y0a4Ks3/8UOSQpoq6KpPagNHyb
         lnoI71Vf7BNLkwbCghOyIzHyihPZ1DS+uoxoSncDjdIsKE3UnEb+zjxedSqxN7TAuF5a
         hRwHoITikgPHcpqV4pfGpPhv+7B1Owhslbd/+SKNsGOWqOJQOcGvhJGheu6xRBKsqfVh
         cOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959335; x=1772564135;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7/TyEbdTq2PdagcB7ilHm5rzAyKfrkKslEbgqDuuLk=;
        b=G1cbMGAvt3xTCP5eVdTC8h104xuS1jDameLgqPBFvmbV0sP54ddgliT27sqkswT0cS
         RFblKgD4pEF2llLuXu670rTb3ofjxg4rN9B6EAT57JZBgk/MjGO9EaUlW/5pu24j6ync
         91vEdt8BO00E4fdlJWAoi/BGBsxiDJwHBLQ3ZuKf0KyM6eBFQ9eHpUni9U8aQkm/hxXG
         Ij4JaklyDNcMZQp9zoBDemxYmDuzS9LIx7xCJspRmpk6XFCszXeWjOMtWYBZ79JnPdQO
         JokOx7wbSwsRrsE3W04PL1meGGESlEEJTbj3giw9FIvRrWJ5M9zLXqFQyyWq1+QeoDyd
         Lm9Q==
X-Gm-Message-State: AOJu0YwQIaYT812dMo3IeZi+lbjSbiy+C+gYQKNhVFY3QhKoKn0RUwWD
	6kLg8pWE5+hrr25+tFg9T7Tbm0KC7WsFT62QojsQMwxSS3JFyNvGCuZR
X-Gm-Gg: AZuq6aLOOTmAeslnyIAXckDiNcpc7tcqtJsm+GskqC4KWIHVGDXcswRO9Iaq8huHU0y
	UjbVzoBwTPFIp7fJ2JC9c+8+K4H3aOawUiRbnltRjMkD7Y826ygRuevv8I+Im615RvrTN59fxzk
	EwWCsJVO9v4f2sAaCNITxqe5Wmtu08wyYeHp2RWh2+Xjdr6xrg5QpFiSnfghZoXEgvIQSqVfNAa
	Bq7d8sLiZcCaB0bHiaAJ88nET7ZhaoKL6wzs/4nXvAzT/xKXi8xzr6oABatQjfM3JQmMzc+OlKj
	Hc+C+6Ra5X0Wt92LBePTJ/urMAT29sk7GNuQp5WCep1qVRRMVaP8LnzDJtYZJF2CKploRLaOR0e
	UpBt1sImM8evdOzWJbIAIRoSUJHdxM7xmVeMAQnccpdFtdT0ff2FVje5tpfdFx1u9/lYbYjJ0a6
	kkHYX+9WvuJwU3hx8m47/YwfZG/A2cDYy+BVJ57PR7n3tTe2nADzy/0p5CsjIJ8XQDDeS0NpKO4
	gYfQA==
X-Received: by 2002:a05:7022:fa5:b0:127:37a9:f917 with SMTP id a92af1059eb24-1276acc0e14mr7291290c88.18.1771959335226;
        Tue, 24 Feb 2026 10:55:35 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af10476sm10818271c88.2.2026.02.24.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:55:34 -0800 (PST)
Message-ID: <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan
	 <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel
 Team <kernel-team@meta.com>
Date: Tue, 24 Feb 2026 10:55:33 -0800
In-Reply-To: <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
	 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
	 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >=20
> > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >=20
> > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> > > >=20
> > > >=20
> > > > Iterator KF_ACQUIRE support is not useful on its own right now, but=
 it
> > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next=
 is
> > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holdin=
g this
> > > > pointer forbids sleeping; calling _release invalidates the pointer =
and
> > > > re-enables sleeping."
> > > >=20
> > >=20
> > > The name of the flag and semantics bothers me a bit.
> > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_ACQU=
IRE.
> > > And document it like:
> > > KF_ACQUIRE -> acquires a resource via reference counting
> > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > >=20
> > > and to match it I would do:
> > > KF_RELEASE -> releases a resource by decrementing refcount
> > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > >=20
> > > When lock is taken it's typically prohibited to sleep and do
> > > other things. So I feel such flags would describe what's
> > > going on underneath more accurately.
> > >=20
> > > Thoughts?
> >=20
> > I am fine with this except, I think we should still keep the
> > KF_RELEASE a single release mechanism that releases according to how
> > the reference was taken (refcount/lock). There is nothing wrong with
> > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > KF_ACQUIRE_LOCK -> KF_RELEASE.
>=20
> yes. Is this too complex or what's the concern?
>=20
> > I am fine with both but prefer the
> > common KF_RELEASE. Let me know which one you like and I will go ahead
> > with it.
>=20
> Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> but would like to hear a 3rd opinion.

At the moment verifier tracks the following locking/non-sleepable
resources:
- active_irq_id        - nesting allowed, forbids sleep, special stack slot=
 acquire/release logic.
- active_rcu_locks     - nesting allowed, forbids sleep, used by in in_rcu_=
cs(),
                         no special acquire/release logic.
- active_preempt_locks - nesting allowed, forbids sleep, no special acquire=
/release logic.
- active_locks         - nesting disallowed, forbids sleep, no special acqu=
ire/release logic.

Currently verifier checks what kfunc/helper is called and changes
internal state accordingly. It might be possible to slice the above
into a set of "generic" flags / feats, but it requires some thought.

Maybe explore this as a separate series?

[...]
