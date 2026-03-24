Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8166230D0F
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380529; cv=pass; b=beaUHH9eM33yJTI/CCCkd8Ga8jHz9vb77xBAyY9Dn/yu8b8D6dB+TAEtjx6A/+x3/gB5Q1skWil+l/Hcyt4Z9bRZY0yDY3dK9tyCOZnPni1h9uDyr6SeZxPC1VDJJU3PyQd74NUPPlRecFFcTrOTlIMr7x3+Up+4HDDHMne/ZjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380529; c=relaxed/simple;
	bh=SzRsQL6s9vDOPV9KKfudgOcFkR1r2XjWU+9u+P+mUaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Hkx3s1KNpk1pKVmWk1G2iCKBEV2IKUFt6zZI/asiHSW6SN3C0+JHdscZTxObHiTWUZcem8oEO9l2gmU0uXLVw5CHHIMyO1uAq7KChlqmVZS7OC0qvBmdaFH9p6igObgR2GQ5Q0ORaR+Xb//4F7L+2BcGd8bk6F93z5qHgq+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuZ5shqQ; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuZ5shqQ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so566762241.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380527; cv=none;
        d=google.com; s=arc-20240605;
        b=UiogGeY1aSThNtNcqmkqs4URZkzTjVTZXgA8yYOXPVHKLpXcy2FwzyIOveetrDiVYV
         aQWvbFppcy7lVPcOp8v6djhTWM282HTM0S9ybdsXaepDVVSXJmsQW7FrEBEY2XaQFuHr
         yCIyWvrV6/YmM0OGSSCWPpVVT2xOdGCL6kZF9eN3TNKtqLtCLgQjmdZWeKOtDtROoU/c
         y4Pg3zyLgWLVJZ6VlrGvzAa80LXxOIWh6I0ps+r3R43XASMwNZPVshr/8BPM7edHXcAK
         FqAjCQ12YnTqK+emzXwKDXVU7iXpvXLBwB9JfwvTzw55EKpgysvmTgrJQB5aP7yXVUgd
         eilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9qekRnH4M5qRxElSGcIRfywPIc+vbg88XVBEG/30Vr8=;
        fh=THN4m4bPaZiRH604stb6aWpLFrhuxbu5LL0PRgY1FuE=;
        b=ElY2MHr02AyxyJo+GzLk/eTsrpEzLxweHC/h5jjCufFzSHOAD6AI/G08dPtyELamfb
         Ag0Jxjb1NEDCUdUn0dTEK8CXsE2ajwZRqJeovyUJHYVc/kRJqcJ93f2ooICmUIQru57D
         QfrMaTGyTOtIozx9Mauod4nmuQmO3UJHYQx7SGIMEtqB4bUwPdYCvpQ3aTl0SkYuHl9V
         Y5RA/Dg/fLupCT4kwh5gcHY96tqKi0jgGm+5Ab8Etyn1NKoHTmchIo2q83LGPc/P3ES0
         tvAAvoX1pgoJI2lvFXwQJbE7szwmqjFp/bV4bzM02jD+HIKt8wSk+dYcERVLCAwZk2Yv
         KRvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380527; x=1774985327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qekRnH4M5qRxElSGcIRfywPIc+vbg88XVBEG/30Vr8=;
        b=JuZ5shqQC+y7ACV3XaD9Gypm5tR7cToYOc6+kkmBxZaMULdbyLxTj6lhsLoYp/bz9T
         r0hSG3pYY2LEZxvB49eJ8c6oCUzq/6PiFMV6Kuyw+1GKpzqt6Dc40+esRrS0iLXdcM4m
         KCjN50BmVuHeZe29dYUrPNm6yyE0LGWnGy4f62NgLzttrhlFNLWEe3DJ6aICtTGuGBiu
         9On9dRuWCf8Ae6wyEY3SxaqgLShgU27yNMNA6/4pW9pn70BXrcRkDBwKoCzRRmOZB4Li
         Kkc6pkNldauPXJ7TjaCiwNWr2O7q/DJTg9MHW0gSfVLAJtyHm8WMSplcjyElPPavLxQK
         EytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380527; x=1774985327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qekRnH4M5qRxElSGcIRfywPIc+vbg88XVBEG/30Vr8=;
        b=GZRYLZ0iJcdKKVz88eLh6p2YnydUL/Qo5qZV3XarkSeTtU3iH8bnpTVJ7iIWz0OGLF
         4oz/fIckHVjGWZhUbJHc54l9r7wUrk9arxcIfRxsaiyCMPhSqVqkbL4qtj7zltUNHBj1
         HXeqe0apXTstVCVwjngzkVfCmureea9HeC7TgwsbSYobt1K9Ld5N/G0wmwngfqK1lbWi
         APNeZMK8eMKJRiX1dGlaKW35sXPWyalt+DyI5HHGKvYsQ9paTbV2rvncytLN3WV2xKMK
         XhYSnXRNcLuSdIi3Uzg25rgWgxY/oJJl391R61+Mom2PTLlhJscIkR2lC4D/2dGotNR/
         TtVw==
X-Forwarded-Encrypted: i=1; AJvYcCWgi6cADTnZVBQP7gYcEbADFvoHWKGzPn4X5Of+br4IHX7JmpkjnMjxdrOAquwYFhqA9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItuuRxgIGkVc519a7BdEJCeRtknzk9qKJoUs6hUOFzAXJFYhp
	YHb4dtmwA3xHJsaRLM1FlxcKy4/TPr2espW9QsIgQnlIscc+mAXhWun7rkHSxjJKSVhpqFzJxbQ
	oSou5759RaovrLtwWlE+xKSxjnHRwrfo=
X-Gm-Gg: ATEYQzyAUyPEuRu/XBKNvojGK2Uf+7xhJO1Lh/J+XKotZdex42AlN7s3PpQ1hw/5Sg6
	sLB2Auoakk7Wy9qED8PW7/jegAhOpZnK2JqUHtOXfXioH4qgS5NT+0bJuGoD3GGoqyzv5vqA7SN
	99eXEZW1kgVPmf/zTuSAFrJKyV2XByJPQi89oNN2H7Zvir23LL/tiIoxttwH4HTtckhWa0bLXC8
	ldbozT2rgiqsC8zBoZJhQm9EtvKXnXHjlhoMUv+B6NsTYXCf87YpoXHQf9PN5GtzwvGK0UKOoUK
	Cb6cT/HwvhMlouN1LVvDq6duLTDqkcZmIrDpoDsseQ==
X-Received: by 2002:a05:6102:3e8f:b0:602:7339:fcb9 with SMTP id
 ada2fe7eead31-60387268e3amr500772137.18.1774380526845; Tue, 24 Mar 2026
 12:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
 <ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com>
In-Reply-To: <ed85ac25cd315ac4273de335943f9f3a2c1f36e8.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 15:28:30 -0400
X-Gm-Features: AQROBzDs8tuYr7zenREXeWmjSZKWdlrMyDekrKuy2DLDrS0xRdwk_pSsddXr3bQ
Message-ID: <CAM=Ch053GkzkXGxNbfE6Xo=bcR0di_DraDPLP-6y+YJ2rQ3DDg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
>
> [...]
>
> > @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_st=
ate *reg)
> >       reg->var_off =3D tnum_or(tnum_clear_subreg(var64_off), var32_off)=
;
> >  }
> >
> > +static bool range_bounds_violation(struct bpf_reg_state *reg);
> > +
> >  static void reg_bounds_sync(struct bpf_reg_state *reg)
> >  {
> > +     /* If the input reg_state is invalid, we can exit early */
> > +     if (range_bounds_violation(reg))
> > +             return;
> >       /* We might have learned new bounds from the var_off. */
> >       __update_reg_bounds(reg);
> >       /* We might have learned something about the sign bit. */
>
> Is it possible for the invariants violation to manifest after
> __update_reg{32,64}_bounds() calls, once cross domain boundaries are
> propagated?

The short answer is yes.

The sub-sync functions, i.e. __update_reg_bounds, __reg_deduce_bounds,
__reg_bound_offset are individually sound (checked by Agni).
This means that they preserve any concrete value x that is contained in all
the range bounds and tnum inputs, after refinement.

But if in the input, there is no concrete value x that is contained in
ALL the range bounds and tnum, then an invariant violation can
manifest. Note that this can happen in the presence
of the current early exit commit, i.e., even if
range_bounds_violation(reg) is false.

For example,

before reg_bounds_sync: s64=3D[1, 1], tnum=3D0
after reg_bounds_sync: s64=3D[1, 0] tnum=3D0

Could you elaborate on your concern? Did you perhaps imply that we should
be checking for reg_bounds_violation in
simulate_both_branches_taken after each sub-sync function?
