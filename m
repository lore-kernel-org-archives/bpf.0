Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85151257ACF
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525944; cv=none; b=R3u+D5szupe07KdvSi+45bQtuQ75tKJQu3ZfHTguDDAWgOWK+q10GYceCc5obXdT2gyjb8iRRl2k0sBptmom6FHgsx0+ENgE+HIo6z+0hdzY8QPaIAaql4X2zCN0u/vcYLLy88RdBGTmBU+MPFhk6fn/Zls2CLq0CKhLRQJAy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525944; c=relaxed/simple;
	bh=d/loSqGrfoIUmuxA1mTLBpz0rRJGFZ8XGWBSR5teRDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1dLITsQHRE1V3FcLYFY95vmTEOyUvPGMZvfs8O8zDGLJnLpLdiNt+xYENeuIL3VG+NEyzQgsVQz9aCmmjNnAIzjwLkcDjKTRUFR+V9jMw2RmY8Mm96ddbj+EAR5zlmXKd/gxU1RKW7GqLit3AQTaK8d8LrP6W8uog13gMQFy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzwoGJR4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzwoGJR4"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230c2d3128so593569b3a.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771525943; x=1772130743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cV9YP510KWkL1HbmoAzcJBKIBvJE97QPOxOHgbh9NmM=;
        b=IzwoGJR4V2yNH/GKZ7+i8roxmyKeUILcKJ1ONATX3RtycvfIZS87biT8QaX8qnrjQE
         pXs62RdAWWqKxH3HduLPypgxrs9ZBFn0wwUwCH/ZRf6dIerTDTa27F1gkgj/20L8N5BO
         rbwtSOqFdgeP6206GnqJuWl3RRsb4NyIhzjkY3g1duZj9oMQY/2kqA+tOHtdRdUAsGXL
         fMhXoJsS4POymazKasrhkhclN0g5lqhnT1BbuTB/h/mY23x/aY99Z7hLo07i1dUA9LKx
         Tjr1vwjt0rBDMSGhkO84lICxNc5+nxXyXxvoe+zx5rQeVkQovbDpp0lAW61DWz8iyPdZ
         EUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525943; x=1772130743;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV9YP510KWkL1HbmoAzcJBKIBvJE97QPOxOHgbh9NmM=;
        b=ZRRM+KRaJmCRnrOToWRE9RMcoUWiioHDtZ+noEOTYV3DFFXlIIeYbQBXxxIAldQe2x
         /nfdnKqrgI4Tivd6IMSbHYVpedjDgVe+6CqWEqLSMdSxC6dDDLsTK0F2PZFzMTszxh9D
         ZzGloxw9wDaT9/8ITlrX7IVvM7z0Iov9EAE5y8cp5jEw6VNNKeIvwkF6k2TZi+O1Bx5i
         4Qasw7kgUMrX+BkUuz60RikuLq2B3rD6YvqkUzIT/jbcQ4AXZMlpgqoitqQCAKBrwtag
         r43zwvkguhaFIGV3bOdM0iyB8dvnz55/DHef4pTHXb5r/wZyfCWgJ2zdl67FyI1BJHqr
         Jyjg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpFrLOZNpYlXcj0VL05aMTYufRuPla36iGQmDy6zOJtfuMavc5i9czjDpx2kNJt8KXdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWieIPJDvE83GgoRS3lVlfWbqAmpkvUooBGUSJsMIWM73havI
	UslBDmD3alJXP1cVaBejSvWEtzi9KFqTKL2dslV9ezpafitJw1r9Tpj2
X-Gm-Gg: AZuq6aJ8pH3KxGCCKpZ+rv9z6mSQnp3YygyvP6bGfs/l8fqW+5nXAaDlEKsVOsGZtAd
	yckctO8qf69Pkj+GMMDj9SmnoHggaOM7EXwZPtVmwIMXOp77gM2hvfCymhE+nD2sLaJEwUkK29t
	uul2ha9FLpVxBceczYY20BqkLpICBeEGH0sFUG1TTSnxQdrPfaL871+9HVyfNG0zAWcsO4+DStp
	klzWj6+psosy4BJYXgJhMp0QzL9WZOjKtxmytPaS3aMqn3q7bve4gYJuK1L+RJfSYUYTS6ySi0m
	cn8G7DDT9i+ArWcCTKZjaRZjvFYcn0a7YcN7kzqK1tw1Nczs5hQ+jb45p4pkUZr4lKlLX7gTtmG
	/GViGGUa/t4x7nL2tBQBCE8FWklnxicbG4ick8LJfDj9fdE9bz8ASnlh1eTTi8ywu4m+QBr+6HZ
	DoK7NqJ+a/srbLHaeW/Q6NsKuxbZzNa9iAlQsNCe5HU6JvMC7yPlWF
X-Received: by 2002:a05:6a20:748c:b0:35f:b96d:af06 with SMTP id adf61e73a8af0-394fc201126mr7274272637.14.1771525942835;
        Thu, 19 Feb 2026 10:32:22 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e5331ba14sm16411985a12.29.2026.02.19.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:32:22 -0800 (PST)
Message-ID: <5044b1d83c3c916c0754eb5556008316c36c15ae.camel@gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 19 Feb 2026 10:32:19 -0800
In-Reply-To: <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
		 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
		 <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
		 <CAM=Ch06Vg-faG9ukU4DAsF9FRG2PeUtYHh3BkG0dOzYi=WDCyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 01:06 -0500, Harishankar Vishwanathan wrote:
> On Tue, Feb 17, 2026 at 5:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> [...]
> > > 1. The u64 range and the tnum only overlap in umin.
> > >    u64:  ---[xxxxxx]-----
> > >    tnum: --xx----------x-
> > I think this hunk should be rewritten as follows:
> >=20
> >         tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
> >         tnum_max =3D reg->var_off.value | reg->var_off.mask;
> >         tnum_min =3D reg->var_off.value;
> >         if (tnum_next > reg->umax_value) {
> >                 /* The only overlap is umin */
> >                 ___mark_reg_known(reg, tnum_min);
> >         } else if (tnum_min < reg->umin_value && tnum_next =3D=3D tnum_=
max) {
> >                 /* The only overlap is tmax */
> >                 ___mark_reg_known(reg, tnum_next);
> >         } else if (tnum_next <=3D reg->umax_value &&
> >                    tnum_step(reg->var_off, tnum_next) > reg->umax_value=
) {
> >                 ___mark_reg_known(reg, tnum_next);
> >         }
> >=20
> > - At-least to me, it easier to understand this way.
>=20
> We can also use tmin and tmax, like tnum_step from the previous commit do=
es,
> to keep things consistent.
>=20
> > - There is no need to gate the condition `tnum_next > reg->umax_value`,
> >   if next tnum overshoots the reg->umax_value then only tnum_min is lef=
t.
>=20

Hi Harishankar,

Sorry for delayed response.

> The guard helps avoid the case where u64 and tnum have no intersection:
> u64:  ---[xxxxxx]-----
> tnum: x------------x-
>=20
> The entire condition for "only overlap of tnum is with umin" needs to che=
ck both
> (1) if umin is a member of var_off
> (2) if the next member of var_off after umin > umax.

Right before the hunk there is:

  reg->umin_value =3D max(reg->umin_value, reg->var_off.value);

Which implies that:

  tnum_min <=3D reg->umin_value

My mental model for register sync functions is that all ranges are
considered valid, hence I suggested dropping the check.
If you think the check should be preserved, maybe still rewrite it like:

  tnum_min =3D=3D reg->umin_value && tnum_next > reg->umax_value

That's a bit easier to parse compared to
'(reg->umin_value & ~reg->var_off.mask) =3D=3D reg->var_off.value'.
Wdyt?

>=20
> > - Accidentally, it fixes the scx_cosmos regression
> >   (probably, because first condition is relaxed).

I double-checked scx_cosmos with current master, patch as posted and
patch with my changes, in all three cases I see:

File              Program             Verdict  Insns
----------------  ------------------  -------  -----
scx_cosmos.bpf.o  cosmos_select_cpu   success    475

So, I'm not sure why CI flagged this as +500%.
