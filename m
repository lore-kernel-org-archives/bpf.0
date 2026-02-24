Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23826AC3
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964123; cv=none; b=JQQLbQ8MlIg3WvATY186ajPrwkjnjHTaG6GI4+CL9GjMpLlsub7vsQPi/QkG+XZk2NqdX+yzTv/UvG3b5dhqiiOSpOEf5I5454b0nJ8HjOKmbJTK43GxLie+8IxEBhGsCPcOCauyHnJkNb3gaYf+51T1+SUfPg3yGFtZeQze+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964123; c=relaxed/simple;
	bh=KgXxzTNjX+1E/ShvD5eaxLLGppS8wyxaEFh2E4+FryQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbXS43wAu94oAEo5Z+EXLN6BIOiu7I+0Qw8S5ke1bRZvHx+ReRDEnfSEUQY6A8ypXlMF4Qcd2UYjRPcOHB3+6cvgpo4v+ftXV7mIeYK5fGIUhCUDiLsDzl/9hSD7KgXH0rXtKmtxa9iBCCG0ZV3c1j5jvWJmekRJKPSKfzIKZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqpcxjcT; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqpcxjcT"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdac83a6a1so1292338eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771964121; x=1772568921; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rayyOxYfGICJXwQGuxUowbiTaZIYRJ/FNfis7O+dXpA=;
        b=BqpcxjcTWbQMg8w38gBNNFWiwixLeRhH3iwOtAUaRSfHRcNt9BtlmZADqGXsRwusfT
         dJ+F540f7xutS+pjBKlm9CIJU9uypiiTngwFwZRCCkI5JgUk8CsT+ZP849BADIb5qTly
         vV9JbVnv9CUEPMZDJ/aczndjbDHWTLg5v+iZau4Y7Bxk84kc5TP+ZFhT9CR0H8bc/ofu
         ThXjq5+iZUuNrjfQhUNzb/sHMDtTsCA6moJovbElW1vRfh8u3Og+qfOgMvi+sa7P9jm/
         H5+xDwdkU1QUqDZ2j+dTHG+4ui/1Vy9nbGFcmZX2wIcp1Ft1etOgqwAO2yEupX02DQzF
         9JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771964121; x=1772568921;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rayyOxYfGICJXwQGuxUowbiTaZIYRJ/FNfis7O+dXpA=;
        b=EIY3dmvLE+n5g8Xg8MwU4+bH+LY6FOx1e4/YZvvXVq/xdgfbuWKqTTXaf3FDNYdLmW
         CoDYS0iDpR4fU9cvjHr0svxAbYcflmOpTflY+DG99sTj7tN0ijh4MC8SFAkUpCjwFDtm
         WknEPd0bp/jNLNjMBO37m0SP8Dw/so3NgYfDSsuG/EJW065zsrUnB6ZzXHP3jkm04KSF
         8Gq3Ov6RXJPQ3PcHhEdNb1KEsgfmvfUxFe9BXDn82OBu4f4mCeZ7pUn/T7DwA1A9pzz6
         guWJ6CzY0Zev7Hgo/9/nhpkEk7v32MaMyw9EzSCfBUxEOp2wYQs6Dlffep54TD4LFkah
         kvVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSAbjiPRD5WegGKrh9Fo46d/2fGL2myRkqeyfRwMCEHN0XXSotEuL5VIQqDjUih+7VNqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgGu2vf3AUx3iMlL9EuWvaqzMcxQ5yVSZzcBAiUkXs4ysxppA
	GrPYi+4HHx0m8ijhWfikwyzArduzdA/Irlpb/Em1MLCLVvo0YI2Kflbx
X-Gm-Gg: ATEYQzzS9g8xyccyQhF4aNfOrAyJctXJdEVPNE8HVIZr4/tMFrnc0pIquaEJLlafGUO
	XKHyyqczomVLw8pZvGk4sj4sMGN33c5PPwFTVGJyyTRPhS5X+4AyOu3nhHJ2rofDbHx1FUk2d8d
	Wl8BBGD2FaNq2x4D6dA8HAMvF4jHmMyRAcXajHbrVFJB+1CMnwFFWCz9EZNwP6xbuciGkIsxiT8
	hmrXnl1IWBw259XBAOl5a/q8RhQxM01tiKlRMg+mQo1VC5aHmH1L8QPJ40QpakrvOQE8E7rlX1n
	ymVWxh5g9MSmyifpbPwaAHP9W1UlV8YS5p/eRBcuKGGeP+VBmY8ZSpmUrMYMJIe1tOTrT+FOhfY
	9OP9n9wzEe47Mrx65NY0TMAKGaiaPW5bEVN8tmu4/fz8EivWS4bKAIjZEEgBLeyKS4b4jro+wEy
	ULSq9Xhq6dFYMWclFHxAyygyFycGZCGOXAgJDDxTACLHNgcKDUFKRvyNzir8oIP+wb/lCOkU66s
	Nxtog==
X-Received: by 2002:a05:7301:9e44:b0:2ba:a623:c323 with SMTP id 5a478bee46e88-2bd7b9e7084mr4509511eec.10.1771964120336;
        Tue, 24 Feb 2026 12:15:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc37858sm7578708eec.31.2026.02.24.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 12:15:19 -0800 (PST)
Message-ID: <f3dec7da331d618df266383fd3f67832397464ac.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel
 Team	 <kernel-team@meta.com>
Date: Tue, 24 Feb 2026 12:15:18 -0800
In-Reply-To: <CANk7y0hv7TsJD5Ne_LaHpLiHNfMDJV+SUyXqnNftmC03fMTUBg@mail.gmail.com>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <CAADnVQ+aobVwR1m-v2w_RWFxG_9TwkYQ-K8KtC6D18HrYe8Dig@mail.gmail.com>
	 <CANk7y0hLknrHo+UB2HDPeen6nLxRaBdLNKiMBiMBv7Hh-QzPEw@mail.gmail.com>
	 <CAADnVQJ_xG+QAUzPHm1FZGpcz45X3k_cG3ThQ0da3kFa0ppLmA@mail.gmail.com>
	 <a8fbc7a3669ad1014b2623c42219d3d074dfbc8f.camel@gmail.com>
	 <CANk7y0hv7TsJD5Ne_LaHpLiHNfMDJV+SUyXqnNftmC03fMTUBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 19:51 +0000, Puranjay Mohan wrote:
> On Tue, Feb 24, 2026 at 6:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-02-24 at 10:00 -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 24, 2026 at 3:24=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >=20
> > > > On Tue, Feb 24, 2026 at 1:49=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >=20
> > > > > On Mon, Feb 23, 2026 at 9:48=E2=80=AFAM Puranjay Mohan <puranjay@=
kernel.org> wrote:
> > > > > >=20
> > > > > >=20
> > > > > > Iterator KF_ACQUIRE support is not useful on its own right now,=
 but it
> > > > > > becomes the foundation for KF_FORBID_SLEEP: an iterator whose _=
next is
> > > > > > annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "ho=
lding this
> > > > > > pointer forbids sleeping; calling _release invalidates the poin=
ter and
> > > > > > re-enables sleeping."
> > > > > >=20
> > > > >=20
> > > > > The name of the flag and semantics bothers me a bit.
> > > > > How about we call it KF_ACQUIRE_LOCK and make it exclusive vs KF_=
ACQUIRE.
> > > > > And document it like:
> > > > > KF_ACQUIRE -> acquires a resource via reference counting
> > > > > KF_ACQUIRE_LOCK -> acquires a resource by locking it
> > > > >=20
> > > > > and to match it I would do:
> > > > > KF_RELEASE -> releases a resource by decrementing refcount
> > > > > KF_RELEASE_LOCK -> releases a resource by unlocking it.
> > > > >=20
> > > > > When lock is taken it's typically prohibited to sleep and do
> > > > > other things. So I feel such flags would describe what's
> > > > > going on underneath more accurately.
> > > > >=20
> > > > > Thoughts?
> > > >=20
> > > > I am fine with this except, I think we should still keep the
> > > > KF_RELEASE a single release mechanism that releases according to ho=
w
> > > > the reference was taken (refcount/lock). There is nothing wrong wit=
h
> > > > separate KF_RELEASE and KF_RELEASE_LOCK, except we would have to
> > > > reject all wrong usages like KF_ACQUIRE -> KF_RELEASE_LOCK,
> > > > KF_ACQUIRE_LOCK -> KF_RELEASE.
> > >=20
> > > yes. Is this too complex or what's the concern?
> > >=20
> > > > I am fine with both but prefer the
> > > > common KF_RELEASE. Let me know which one you like and I will go ahe=
ad
> > > > with it.
> > >=20
> > > Magic KF_RELEASE simplifies things a bit. I don't mind, I guess,
> > > but would like to hear a 3rd opinion.
> >=20
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
> >=20
> > Currently verifier checks what kfunc/helper is called and changes
> > internal state accordingly. It might be possible to slice the above
> > into a set of "generic" flags / feats, but it requires some thought.
> >=20
> > Maybe explore this as a separate series?
>=20
> Eduard,
>=20
> Are you fine with making KF_ACQUIRE | KF_FORBIDS_SLEEP as a new flag
> called KF_ACQUIRE_LOCK
> and then keeping the common KF_RELEASE that will release according to
> how it was acquired?

Idk, I'd keep it KF_FORBIDS_SLEEP for now and rename later.
W/o the discussed refactoring ACQUIRE_LOCK is a bit confusing, imo.
