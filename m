Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609EF258CCC
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074866; cv=none; b=C44/PngjhJaq+JPd1KnemcD9JHYo2IkgOH4jWmUXFq9m9cVkOPt+6snzUUNXauAqXk+xDMgEs2rXh5ShyJRStQJVK07KvztgwuoqSlUYVJ5kKBK8Mx3AirNIGZTvwedi42epCrFAKK8BAynthrTFukrIPqOp5dsYB/4lcV5MJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074866; c=relaxed/simple;
	bh=dXePsgt3I84BTIZVuWaWr+rCHIWzcf1icC2KnE7CsFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UK+krFujCfrshV46Ccjw4ExypbPf19PoRZPEGbWjfJ0jnNjAB0DF1FEe6qa5jkB0/tBJDI1bh9e84znH9nc4PtwtLWxmDgiqD96WlzbW/5qdbJVNb7PmdMWh0lp+wpUReOmDfWZHKvdHBZxgybdAPEBbHeE/79j5PpU0H3MSXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVWTf4wZ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVWTf4wZ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso347543c88.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775074864; x=1775679664; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0z9rScOSZuhMaGGxz02o1IoKtcga7FBCQq7jPU0rHs=;
        b=qVWTf4wZD0hPyDaMzcAREH/Oe57g4fLHth/MGUawZFnOc59BhpNZxNvHbOM1esKQR3
         IN/dqmSQ6SqqHxgilY6FvLiSLE3e9i4HNkk1R4jJTXxkuSGlAsTTYkF64jfS6OFVviSO
         j3sLONsWV/0Xi6g/Ed6kct0ppogqxCkHGxEiMoe199Cz23Cz3dB1T1WQIu49Aw/AsDbM
         GA5PJwG6ZT7sVlzG15zORoQolNlFIC1OyxaFBSIFzdqMPwOFzev6IbgMNusUzB1AGDz+
         mKfcZDnEmFtU5ql8g/ibIJqN1Dtngjlbe0WgCfzb3mwcrGq09q0fes2zs7np+IQCx5bj
         4I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074864; x=1775679664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0z9rScOSZuhMaGGxz02o1IoKtcga7FBCQq7jPU0rHs=;
        b=GCP9Xh/rE9ABUXcWIWwvd/oFFsx0u/oh+uVJe6J/BlW1JwlmKN3V1yfYIfkTXkgczr
         5h8XPxh2RgAH7FzRRjnYVkR60RKJOmdTxFK8wvO99ah1F+hcqKaeTu7INv9Niofjn3jK
         7islhpEWK1CqjEDdqb79Q3e5LJLF5GEHt/JDKj7cFdYVGiJMdLx/kHrIOwgr/nyqn3OD
         l5X/Voa3vMFyi+I0cIFoBcsP7fmpX93InoSZX58R4oADnemAONLvL9hU9+b47gNBKsrH
         aWuAPb2o5AP6JCwq9YdJcS+3KRCwmuKeBvETebWQsrRK/HuEU/vSYYCtY0rWQ8dSOBcZ
         el0g==
X-Forwarded-Encrypted: i=1; AJvYcCXRwblhH04Hm5rQSdFhKqLB3JHareq/ET7qC3dizOSu12rVON80OBcAtWz1PPodoKA1niI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI06FblkGPdq5YnzuoeVmTuUaQnX9FfMgpk4uhytnMLppMuWJs
	GMYSs1Muh4m05Gdgx4kt0qVlsUFF2gidp0CQHFrM0TkdflAn4Y9fc5Ip
X-Gm-Gg: ATEYQzxQ7C7ywmwpdijTNmk0aPSiS/1F3uXzv5WePmXhNf+bon9eKOt2vsqOlgSN6oG
	GfRJ+MKEwvEifaImH62dITE6Pn9OHADvkFv+Sy7jiwaOi3vpcSPw+6fEFWCvw324RBTDxiyEjJ4
	I/gutgTlEphQNiTKGz+8iIFHIUwU62kUDuYe7/pVq6bFt25lV4LZjbW8BPjHAsITrH1IXxvjbAn
	vLHfVZEST74MkSHsrjKWI5KGWOahVAWg1F7SkEfbDLLAIoRC6E8llBGn+TPJlTYLJdjcddeAA5W
	jLB0l3FPA020HJQgqSPy2dIewhjYCnRfj+mXS2U5jRdvhABHBy3St2V14S/7DfiP/Xtc0JFfSN7
	AM4QBPeg81GGKEzA6+LMIoUaFn3hb2er1spuTNuzjib+VhyWSAA5WlIW4CRDDDznoek/zxOz3Lr
	aXn4Tz4UbL+MP6oukwIwhg0k29n3d6lS7lUXwqMeYOLq5QhfRRcP52YEK5SqyXE20VqDWEOJ/eC
	3pGzy+Y
X-Received: by 2002:a05:7022:922:b0:11b:82b8:40ae with SMTP id a92af1059eb24-12bee6d3612mr456083c88.18.1775074864271;
        Wed, 01 Apr 2026 13:21:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd920b9sm586652c88.8.2026.04.01.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:21:03 -0700 (PDT)
Message-ID: <4343ab08efc55d52b95f1618dbd367952f8e6a1b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	paul.chaignon@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	santosh.nagarakatte@rutgers.edu,
 shung-hsi.yu@suse.com, 	srinivas.narayana@rutgers.edu
Date: Wed, 01 Apr 2026 13:21:02 -0700
In-Reply-To: <20260401193637.14694-1-harishankar.vishwanathan@gmail.com>
References: <ac0NvOIc7AhifyNM@mail.gmail.com>
	 <20260401193637.14694-1-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 15:36 -0400, Harishankar Vishwanathan wrote:
> On Wed, Apr 1, 2026 at 8:21=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
> > On Tue, Mar 24, 2026 at 12:33:51PM -0700, Eduard Zingerman wrote:
> > > On Tue, 2026-03-24 at 15:28 -0400, Harishankar Vishwanathan wrote:
> > > > On Mon, Mar 23, 2026 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >=20
> > > > > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bp=
f_reg_state *reg)
> > > > > >       reg->var_off =3D tnum_or(tnum_clear_subreg(var64_off), va=
r32_off);
> > > > > >  }
> > > > > >=20
> > > > > > +static bool range_bounds_violation(struct bpf_reg_state *reg);
> > > > > > +
> > > > > >  static void reg_bounds_sync(struct bpf_reg_state *reg)
> > > > > >  {
> > > > > > +     /* If the input reg_state is invalid, we can exit early *=
/
> > > > > > +     if (range_bounds_violation(reg))
> > > > > > +             return;
> > > > > >       /* We might have learned new bounds from the var_off. */
> > > > > >       __update_reg_bounds(reg);
> > > > > >       /* We might have learned something about the sign bit. */
> > > > >=20
> > > > > Is it possible for the invariants violation to manifest after
> > > > > __update_reg{32,64}_bounds() calls, once cross domain boundaries =
are
> > > > > propagated?
> > > >=20
> > > > The short answer is yes.
> > > >=20
> > > > The sub-sync functions, i.e. __update_reg_bounds, __reg_deduce_boun=
ds,
> > > > __reg_bound_offset are individually sound (checked by Agni).
> > > > This means that they preserve any concrete value x that is containe=
d in all
> > > > the range bounds and tnum inputs, after refinement.
> > > >=20
> > > > But if in the input, there is no concrete value x that is contained=
 in
> > > > ALL the range bounds and tnum, then an invariant violation can
> > > > manifest. Note that this can happen in the presence
> > > > of the current early exit commit, i.e., even if
> > > > range_bounds_violation(reg) is false.
> > > >=20
> > > > For example,
> > > >=20
> > > > before reg_bounds_sync: s64=3D[1, 1], tnum=3D0
> > > > after reg_bounds_sync: s64=3D[1, 0] tnum=3D0
> > > >=20
> > > > Could you elaborate on your concern? Did you perhaps imply that we =
should
> > > > be checking for reg_bounds_violation in
> > > > simulate_both_branches_taken after each sub-sync function?
> > >=20
> > > My main concern is that we might loose useful signal.
> > > It would be nice to adjust reg_bounds_sync() such
> > > that it would stop (e.g. return false, as you suggested previously)
> > > if it hits invariant violation mid-step.
> >=20
> > We discussed this with Hari and agree it would be good to use
> > transient/mid-step invariant violations as a signal to improve
> > precision. I'd however prefer to implement that as a follow-up, to keep
> > the current patchset small and focused on fixing the invariant
> > violations that cause kernel warnings and program rejections. It sounds
> > like we may want to backport this at some point, so it's easier if it
> > keeps a restrained scope.
> >=20
> > The "transient" invariant violations already exist today and using them
> > will only improve precision (potentially allow the verifier to accept
> > more program than it does today). I would see that as an improvement
> > rather than a fix we'd want to backport.
> >=20
> > Hari thinks we can also use the empty intersection checks he mentioned
> > in the other thread [1] to avoid/use these transient invariant
> > violations. It would allow us to use this as a signal to improve
> > precision without making reg_bounds_sync more complex (and harder for
> > Agni to verify). I'll let him explain, but as mentioned in the other
> > thread, it still needs a bit of benchmarking.
>=20
> The idea is that since reg_bounds_sync() and its sub-functions are sound,
> invariant violations (I'll call these range_bound_violations) can occur o=
nly
> when the *inputs* to these functions themselves have (i) range_bounds_vio=
lations
> (ii) an empty intersection, i.e. there does not exist a concrete value x =
that is
> contained in all the 5 abstract values. Let's say we have a way to detect=
 empty
> intersections (as discussed in the other thread). We early return on empt=
y
> intersections in reg_bounds_sync():
>=20
> reg_bounds_sync(reg) {
>     if (empty_intersection(reg) || range_bounds_violation(reg))
>         return;
>=20
>     __update_reg_bounds(reg);
>     // ...
> }
>=20
> That way reg_bounds_sync() preserves empty intersections and
> range_bounds_violations, rather than allowing the intermediate sub-sync
> functions to "fix" them. It's equivalent to the idea of returning every t=
ime we
> hit an invariant violation midstep, without the extensive code changes

This makes sense.

>=20
> As Paul mentioned we were discussing empty intersection checks in the oth=
er
> thread, and I agree the two ideas are probably better combined in a follo=
w
> up that:=20
> (1) Introduces empty intersection checks=20
> (2) Uses them in simulate_branches in addition to range_bounds_violation,=
 as
> discussed in the other thread=20
> (3) Uses them to exit early in reg_bounds_sync()
>=20
> That way we can keep this patchset focused on fixing the invariant violat=
ions.

Ok, we can go with a follow-up.
What are remaining steps for this patch-set?
Here are outstanding comments:
1. https://lore.kernel.org/bpf/33c006d7275cb443b5750f062cb78c38449a7537.cam=
el@gmail.com/
   resolved as noop
2. https://lore.kernel.org/bpf/ed85ac25cd315ac4273de335943f9f3a2c1f36e8.cam=
el@gmail.com/
   resolved, only if inputs are in bogus state, will be handled by a follow=
-up.
3. https://lore.kernel.org/bpf/7vwyzvy7cwy2n4c52fcurg4dnv4bqijtovmkeh3zgu6e=
y266vc@dtt3r5usvev5/
   Some wording nits, do you intend to fix those?
4. https://lore.kernel.org/bpf/847173114a13630e1512ad05375c6b407720a916.cam=
el@gmail.com/
   Will be resolved as a follow-up.
5. https://lore.kernel.org/bpf/87ikamjv5q.fsf@gmail.com/
   resolved as noop.

Is the above assessment correct?
Beside (3) is there anything you'd like to change or should we go with v2?
