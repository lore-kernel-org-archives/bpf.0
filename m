Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2D2853F3
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986642; cv=pass; b=abwyjqDRD54h21ZCeakcpSzawskbMaTVi71MMd8xwh+QzgwOnTPVywy8M2X44L9vX7FdMb+AhqD06TNigw4HmKRdRs7z4MypTgVTL/caTGOw6ipuzdmiDcpYZTWWXaLnDTLLDJBaSjx2pvt5A1fx4sTU5R5VfS5rSzOvLidzIsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986642; c=relaxed/simple;
	bh=xAxfluz8P1Wu3RVbi9/uFQRJzAkjNU/g8jo9DaoZRBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5rFwcICJx17H7L6cWcPOgOw7aUHYKPc3FuC0Rni6pBfOVTz3dnRGLgT+6TqjaZjOhZTMSDQx008OznNRy1LxMS+Vmpx9BlSu5pAjqIi6yWuVDbTvnBgTFZONCS4zk8SXhgAmMIWIVoio8hcTIb40WnzA3CkqRLA1HFTdm+n3ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPRHxf2u; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPRHxf2u"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4657593f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771986639; cv=none;
        d=google.com; s=arc-20240605;
        b=Kc4VLAc5odIEP/Pw49BFJIIh5YUDN5THX7cyVE4IXVuwuLPlEr8POmuTGPQ2j9w1vE
         2QdiJJuFPBieE2kEywpcm1zRDibDUGqKs8+qjE27sI4Ks0OZKf5v1kLlZGbDL8ARiGOB
         1Dpt0S0GP19fjSbOi16KtP92SUdwKKFwREBcRIScIHCUNWA5R/9cmQpVkIpGWINJq9Y1
         SYBtThF6x8occQZXha8nU6RuWKbG9kmOgv0xe8ljQabRBGSC8XcDR5DJZbxj+0ZNhGmt
         C8tSXU6/62CnXQj6O8CcQNcCVUfeCo0batdtK6nvN9HDdIf4QcG7yWSFh4oDcPJv+thD
         aw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yhMSM/DKZOprjCT51OpUbD3tsF3spzfDUnYWeXOPLUA=;
        fh=6h+yUMlKcI52RxIQoY0eqd7BaKgqHqGuBloQhkzInXk=;
        b=HORndb2AQgSInCFJO2fyM8TOr/QCGfUUcrvNYBTb4xP6XvsDlVyT0wOiIKY82MhIvn
         luq9yd/pU6wboNjtrkKVmxrlPr/9zVqq4CZWMYYH0yNk6XBKZqJzZud2Hy7rotlYq73s
         RsZ6Wan+iUaFcAyRI3TDXU+JhXd+UsIUP1o94uOk0v4+3KBwNtQSW6Vnb4y1ujN96HME
         ie8W7LMJOpSeWGFJmCsGlLDvBL6eWd85g6gVpRPTc9b8K31KSZS0A5Fx9C2SZUMr9IUw
         oIwE88BxGflnrEplDVhb8kh1JgjWL76tdyXV5rLXfb6FqORUjBwRl8yndBrdmGH2lXlG
         pO8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771986639; x=1772591439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhMSM/DKZOprjCT51OpUbD3tsF3spzfDUnYWeXOPLUA=;
        b=UPRHxf2u8cERPwbBYKcs6U8UeaI2fgPHxi1DV0deWH7w0GnS2PeIdfAwIOZoSXw3th
         MpZQZCIT6WI0nES22ej4pJm2WDRn4OKWrUB8Ot73TC6KwlbyRO4kq1ObHyGjSj6P/H9R
         GzishX5GYy59VYq1HaiFle/1HjpPTOTcSQSdfZwTawXOqM19RJ6fVEILf2fLwMl3kICd
         RRjBMtbM2CB9Ky/3NzelEgFXnW74/aJfMCipy3i5+GgjW+YJ9wKt/ZrwsDJFfu5hVavP
         cu/QRLYctf5KLQUJTd8TZa9xkuo80Cd12tEnuFg2WU4p6+1zsbepugoiidxAvqNNFFzk
         CnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771986639; x=1772591439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhMSM/DKZOprjCT51OpUbD3tsF3spzfDUnYWeXOPLUA=;
        b=QooSXGkdOXmsxD4vtOGm2DG2UUkK2UBQWASmnsRVRvXPRYhFt8WOdebl0MPhiRKjQ9
         q1GHNHgo3LcuSF5cxFqcX3/JxMcZhxxFb38dMq2PGMcI6R1ycCMOXCzJqbZOQ0SewrOl
         3uKsr5kizl9NoNuMpYqbCxv0QcYW/ULlP6NOQlQgrkK9ZUJFoO15nKc75S9DX+XJsBb8
         NfGd+PFcu+BS3xdJjXraF/4qukYHR/P6Mv+NnA+Bym386iyYmWdwJKXmn5dpYLHWtgTN
         rbwLCp8FoEH7dZV10Xhtw3hUqgh+DBoJiN09MW4fd10KXXd1phqLTLHJhNbObzv4W/M4
         KiYg==
X-Forwarded-Encrypted: i=1; AJvYcCXv+Qs537HcRIN4BVoIBsn+Xjf9gQ5mTeIUoR8wZGkSx2Guyk9xF5QtcLI9Q4moHSVMW/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xjmKAH+EF4G4oZazj4MIJR/slsWQnpCNWwASTo3Iwq1jdkci
	6WZBtg8gttBVMu5X5xeWo0NuNcfrD8641ni/BRWWB8h7EmEDNiynzgJ7QdqrCLBz/aaVCcWLTFz
	ZAeum2CphNJaGkrHVG/Bm4rw6/KhIFaU=
X-Gm-Gg: ATEYQzy7uAy+7bb0HT+w0P3JXnmmp/ebjXgLvsbPc92qHGRKTLcAw003s3SLhACnZ4G
	uW2TjYzxe9n2L1Wd58LGqTQQ9vk55Lr7UBPrOG8M8XEPnfCOP2GvMLNTTnmip+gavKCqwDLUUgY
	YCtABYWCFt6hqXd9cCIyuCA5CzM0rQ9zqO4H0V8+lC6mu+A+0Lm4Iwc6eTjiwEfv1GoW/cCTpr1
	iUHU9KLRuVQ6Z6VMeMbBsR3FX5UrRoTpd0Gi7fOFNh7GAzLRuDjEm8itvZpZT2df0vMMAPz06xF
	UvkYNLYZm77gkXHzFajPe+crX04q7Q2ebPkoH9UcVR2szYw6ILeOUYtSFjspzLo1iXFgK/e7ZLi
	Gakil2AkvqJJOA7EPZsi+/PF4xhEQxB+QdW+V
X-Received: by 2002:a5d:5f53:0:b0:437:8fd6:d849 with SMTP id
 ffacd0b85a97d-4396f1a6693mr25550709f8f.54.1771986638947; Tue, 24 Feb 2026
 18:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224212535.1165151-1-puranjay@kernel.org> <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
 <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
 <CAADnVQ+vjJf9xy6Oy5dCy_F2hvKt6TwZ1jA3Xv2PxMDpkPksXQ@mail.gmail.com> <cc08ccc2398d3110fa85b76ef0452c46132fcc98.camel@gmail.com>
In-Reply-To: <cc08ccc2398d3110fa85b76ef0452c46132fcc98.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 18:30:27 -0800
X-Gm-Features: AaiRm51Jjbv2TT6WKCIXwfmBi0YTmGwUPWPv2KMshaTnTyyr-9o8VPPiCstdCMg
Message-ID: <CAADnVQK+otFugLAS_6BSFgXVw9CfzcrDpJWZpnsDQXyAV37R3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 2:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-02-24 at 14:50 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 24, 2026 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-02-24 at 13:46 -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> > > > >
> > > > >
> > > > > This series adds KF_FORBID_SLEEP, a new kfunc flag that can be co=
mbined
> > > > > with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORB=
ID_SLEEP
> > > >
> > > > I don't want to introduce this new flag now only to be
> > > > replaced with KF_ACQUIRE_LOCK.
> > > >
> > > > the follow up we discussed in the other email is different.
> > > >
> > > > pw-bot: cr
> > >
> > > Then the refactoring should be bundled together with this series,
> > > otherwise it is very confusing to have a flag named KF_ACQUIRE_LOCK
> > > and bpf_verifier_state->forbid_sleep_count, bpf_reference_state->forb=
id_sleep.
> >
> > The name shouldn't be forbid_sleep_count, obviously.
> > I argue that the counter is also incorrect.
> > As soon as we have two iterators that take locks in acquire.
> >
> > if (..)
> >   iter_next(it1);
> > else
> >   iter_next(it2);
> >
> > will pass the counter compare in refsafe().
> > Both states will have forbid_sleep_count =3D=3D 1, but they took
> > different locks.
> > So we need to compare refs in for (i =3D 0; i < old->acquired_refs)
>
> Current series does that.

Current set does:

  case REF_TYPE_PTR:
+ if (old->refs[i].forbid_sleep !=3D cur->refs[i].forbid_sleep)
+ return false;
+ break;

Is it enough? or unnecessary?
For REF_TYPE_LOCK* variants refsafe() checks ptr.
btf_id will be checked by regsafe(),
but two different vma_iter-s will pass regsafe() and will
pass refsafe() too without 'ptr' check,
but they locked different vma-s.
If we only care about forbid_sleep then yes they're equivalent,
but...

this forbid_sleep check for REF_TYPE_PTR is needed only
if the same iter type can be used with two kinds of iters.
Those that forbid and allow sleep.
That's not the case in this patch, so it can be dropped?

So both hunks to refsafe() in patch 4 can be removed?

and then with a bit of refactor forbid_sleep can be removed too,
since it's there only for:

+ if (state->refs[idx].forbid_sleep)
+ state->forbid_sleep_count--;

if we do it similar to release_lock_state() that decrement
of forbid_sleep_count doesn't need to rely on a flag.
Potentially...

> > anyway, but then why have a counter?
>
> To avoid re-scanning refs array. Counter is an implementation detail here=
,
> but bpf_reference_state->forbid_sleep is not.

avoid rescanning for the purpose of in_sleepable_context() ?
sure it's a useful optimization, but

if (old->forbid_sleep_count !=3D cur->forbid_sleep_count)
in refsafe() is also an optimization. It's not necessary for safety.

While if (old->active_rcu_locks !=3D cur->active_rcu_locks)
and
if (old->active_preempt_locks !=3D cur->active_preempt_locks)
*are* necessary for safety.

Yet
if (old->active_locks !=3D cur->active_locks)
is an optimization too.

The whole thing is becoming messier and harder to reason about.
I think we have to clean it up now instead of adding more debt.
