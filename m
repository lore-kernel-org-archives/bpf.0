Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6751D7E41
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615683; cv=pass; b=N3A7lvly4ZM9KRmrKq6jSsZt+NLwoqi0ffkG6j31pgV8q9bvTQOKqMZ3E8JvA4UPdvG2Qh4lN0uwY1TZAFuWUPtK74GmM+NZWkpAaFAtU+NfqRVi5wGydGq7Fs3vJvzw4J66+cM2lJKQl/6otRoUMDjk26QQHx30PgO/PeUikoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615683; c=relaxed/simple;
	bh=0wvm306Vn7codzwbmQbdXFGfp57Ka7LuwQS0c2K9C44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJNWCuVSXPDQbF5taDctgYXahZ6L30mGSGceEEZvQ0Cy/dgjdM7RFwmS5cqqZzejIvlN2c5E9DDxBy3laH1hkIy8Iy3VfJftMqnIBvIK5UK/lbP5QYqLcLy2kDe6AQIPdccfhmI003qLkBlkZaEUfrToXMeto5Rk8Z5W3yitckY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZqCdzqf; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZqCdzqf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e0aa486af8so18271657b3.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780615681; cv=none;
        d=google.com; s=arc-20240605;
        b=bwBNWaz4Yqw7fH6Tv4vLnDLoian/Yoo8pYs2LKUA4dHJ2KB4mWhdIjMBJVfrm8TzFk
         LKpf/FVLhJDs1Cbi4xJjBiWrwge1VfNgvYzixDXQVGIGzsdjUrQyvQHWw4FqoBQUDvOy
         6t7aCz898QyWjaw3nJ0KWI1pw1fIgRHeRa6MtyZiBuH1O8vAN5C98wIT8yB4GmAO32+d
         CxXgU+6KtJsmUigIsqQurezcwpRu5exBhRHXh5n2MZ06MkE1eKyJK+Qwi2F3g7QIXh5y
         pQ78ZGBgIgK+LafI0l61G4esZAXVMtx7BQz2Q76MDeMvRYpbfOhPsS6zBfo3LooW2zLa
         XNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        fh=vmM5wuVk7j9YK3fefwlRh8TbHHA7YsqZ/rVpPu1y3YY=;
        b=MbcuAKIi2ks02WQ+TSvkdXPCxtp/Ntl4mpSBzoOqrNaoijoUZfIH/fLp/DYoLusO0u
         DE/d6yLuHreD3/V0MVvH+W98HILe2q/cUU05zFOncIwHFHGHN5uOwaeptj3Np9mTwzQE
         x+yZ6FDV3+SQiHvR9E7OXJ8ABgmrZ+iOnmcqZ1FdkJQrgoEnt0o8RPOlsfuBX9xmvHp1
         7orZeXQbLXuoePi2bkTQXMszrsxQ1uqUGx8cN3dQi4UUyRcX+zhiejv7cAWQJVeYMGGb
         h4SUFt63perupGhwNrM60qHnTsDxJd3g3Ed5Cyo6YFljVuwTzx3SMaHJP7ewzGtVV9w1
         RIdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615681; x=1781220481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        b=nZqCdzqf/2VoDdTzJbey+Hgznh0gerd+ouE1RKw/vq0v26eTjrYjL8p8Igrxct8GEl
         5kNyk0KAK163+juVjh68ZrZXKRhwwewUsP94u2zo9XqlHEhUV+AVl9qnMM5A15Eqe+YY
         NBEQz5T+NZQGwnAyA+rsfbTj/rriTVevenQuELoF0ZkodwrzjvOUV0JE1s/7Yqn4kXdl
         cxvmx+4WzA436gAwh3uuUiGP0VCHuBk1scLwRzPF2NrmD3PI/n2BZMsGdr6oHc7Fou0e
         9+XESp06S69W7KjRex2s97tT4Y7lfyvNglKJLklLEuUmoSJfxJNtkrjbpNCh27YPJe9X
         wDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615681; x=1781220481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tr814ukOJvlcYzx1VITy464T91Mqo8/bGv9DViNTSUs=;
        b=M6vwu4xWclfSUrrDD6fe4m3dsVEJUPy97cwDqoKUSr4FUIT6aDCdRJov3eA8BgdS82
         UroULURF+AKhNqyd49DmlCDlM72KV1SviWyKELqIR18tLapPVXHJ3rd43zO1sSg0wY4C
         iZI9MnM5Ppl74ACSSvifaacKQ9SxhgzTuRmkgRn6GwXkFRPg67Rev77MjnNdpVW8QuM5
         HIIWZD99Hjp27BFjUMaEJgiWKydIRM0VG/qnUIQc6bZJhGi3lSA3T9Pzm5Gw1TFj1fGb
         VQTHQtCQPPM5XEphwSxn07mOqq3ChouyaZe2OD01VnFcUdRGIY/Ime/iuxEHMSWqLvQv
         J4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+nB3WiPsB2ZYMHxDVpa19/D7LlUOojmEZfdzP2DzQVYrMVZZSkMlBOVycicbIBtuAGzr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHf/v8dWTkV7pNYWU53djzDX2M0A8vQZOgemywM1uez46/yvcq
	u+K/5RhSs6nmmK5fvsGsRfbT+g2e8r4zH9FpB/8/wiL+6SitmGEHRwjqIznSZefC2MP9lK0kSmG
	snpu1sZujSBF6eWywPWt6GGTP79mWYYw=
X-Gm-Gg: Acq92OFB3cEFDonOwLfZ81T/fsU1zZJ2KofuTpoMkrvKTBjhV/ugM+2oxAP8LBvKPfF
	Fmp5/TpKGPD6vBIOC7HzxK2FrSne01ZLCmFUol8H9kHjvH1ACatdJzEq779epBYL0VL+x9tR6/u
	r6K6RWrusdS9ix4BbKSK8AY8O0Yf1pMo091kkCb5BM1E6F2LPibmQV90JmtgxSiD0CWY3CfvlfF
	nyi6tEehc/GF4ALXTj0xqHgxRyBDYm/W1K9CtbgoUJwmO2kozPNcFX3IuEy/9UmvGyKZjM0tIEB
	fWuVhGpyi7LYNiIxYA==
X-Received: by 2002:a05:690c:4d8a:b0:7bd:a94b:5df5 with SMTP id
 00721157ae682-7ed5097a77dmr1068907b3.8.1780615680908; Thu, 04 Jun 2026
 16:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
In-Reply-To: <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Jun 2026 16:27:50 -0700
X-Gm-Features: AVHnY4Ja5FO0GpDTrS7Dkk4N34t-5_mq2ZDIPbAIwsfjitIIRfX7_LFokMAE9hY
Message-ID: <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > > Author: Amery Hung <ameryhung@gmail.com>
> > > Date:   Thu Jun 4 15:09:03 2026 -0700
> > >
> > >     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> > >
> > >     refsafe() compared each reference's id and type but not its paren=
t_id,
> > >     so two states whose PTR references differ only in the parent obje=
ct they
> > >     were derived from could be wrongly treated as equivalent and prun=
ed. Fix
> > >     it by checking parent_id too.
> > >
> > >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
> >
> > This looks like a bug fix for parent_id tracking support. Should this
> > include:
> >
> >   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and =
fix dynptr UAF bug")
> >
> > When commit 308c7a0ae885 added parent_id tracking, it updated several
> > safety-checking functions to compare parent_id but missed adding the
> > parent_id check in refsafe() for the REF_TYPE_PTR case. This caused sta=
tes
> > with different parent objects to be incorrectly treated as equivalent
> > during state pruning.
> >
> > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > index 5945956a7573..06d9ae24f006 100644
> > > --- a/kernel/bpf/states.c
> > > +++ b/kernel/bpf/states.c
> > > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *ol=
d, struct bpf_verifier_state *c
> > >                     return false;
> > >             switch (old->refs[i].type) {
> > >             case REF_TYPE_PTR:
> > > +                   if (!check_ids(old->refs[i].parent_id, cur->refs[=
i].parent_id, idmap))
> > > +                           return false;
> > > +                   break;
> > >             case REF_TYPE_IRQ:
> > >                     break;
> > >             case REF_TYPE_LOCK:
> >
> > This adds an extra check_ids() call for parent_id. Could this make it
> > easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SIZE
> > exhaustion?
>
> I think the bot has the point here. Let's switch to reallocating idmap
> or failing check_ids() if there are to many ids (probably an
> unrealistic scenario).

Make sense. I will switch to failing check_ids() first since it is
unlikely for sane programs.

I will also change bpf_insn_access_aux::ref_id to int as pointed out by sas=
hiko.
