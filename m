Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4E2AD3D
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549518; cv=pass; b=rWQpDlr/CugPEnDpwYa38+CXNkriThazmu8hZBYUhF7MdPQBNblyJYH30gHjJ8sxOjUbpg5XUbwZDepTCsCMEkuCSXlV4r5N50lcVSe/2LMICrTUnVrTbvgyGb0w+1MjMVLBd8ew/gtGCqlpSdzIciR5oZwkEXs1S1NDA6XeIKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549518; c=relaxed/simple;
	bh=ci1B2+01/QOmZa4ZK3Qfu+sNbioSpIOprKG2RUaAlGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXy1mTltptbNaqW5E7Eg5YqOyxaY3p8Xed+7fKL6o1FzURB7EAwhP2k9Yb35cVshWPYznZ9XeHcUfTHSNutYyXbEnxOgDKsU5SRHM3pq7EVpcvt+Z5HFDtkcYvyserDWp9LdOkIG0jBdbEYvoB+2bLweZoUTI3lHEcixlfYNKKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCUSTbXq; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCUSTbXq"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso1895642a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771549515; cv=none;
        d=google.com; s=arc-20240605;
        b=E50xgXT39KgdY7gaVz1kH/mRd9DkqVQ2bk2OZLL/Yq/+ZohiYT/okuldlXhcez/cVk
         DxSgq8fe2s1xdc+ID/gvlq0zcSNXW9VnBY02C3B2WsI0h1fhdA9dIMd6et/YQf48Qc+V
         cZnGCGCQAAh08jz3ySAdtxgbl3ntRtd4OSJ1aUaaevDvZm1biAV1fU5ckt5o06eFMLkb
         0P2BZzWT1xTNsvu/4G/yidaF0RwhVVMrcOIsfbsXoZgxR0uj6Ih71sgXecqgf0+s1E8v
         /gxQYANGl5oFx7ZqEv+IJCTsvl3arVFI+h3Q8MUkuD1htbVEZd8VdJ5HOKWb7w9xxJn+
         98lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LEH1MjHbZnxkzLPoBZlBfD3PgTYhguE+Q5oE6xBKIgM=;
        fh=cKMUHX+7uaxJJpnCJTUj05r6u3b5LIa8H8LPnjF8mDI=;
        b=VlJxxYpdgAp2WJKBhAnvl5yxqocZmHR95sNR8/33YqtCCQO1GAz1BMXPq2/QAxFKnP
         lyYnWuV8EYalc/ogOj60VI1vTtYQEYz0jnEddLP+z4UMArSVA19t3ya3d4axctuacDU9
         FmvaHi0zK9IltnYKcroOt+2JXStXPW0WBjGF5EMoymgc1ayUtW85jwlOZHRmy9mzI+X4
         X9mYPasA9bTc1rX4e7vWrHaj1VWQW6pHcjLxXAos5cBmf5csVhbfMnxYOyA+nNZTQk6N
         o1Yq0qaUnbv3JqQONPkU+ajLyFJEblZJWz/SD8L/fIYxP5u0+v+d5OCMMR0gJIxPrunY
         Ltgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771549515; x=1772154315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEH1MjHbZnxkzLPoBZlBfD3PgTYhguE+Q5oE6xBKIgM=;
        b=OCUSTbXqmxtrnWRsiNjOteUN4/RFPdD/VDxb/1E4R4NewQof/zLlzSyvt3njweBpwJ
         gPnOCRl9TJrZZjeQl+0vTsVutC4eu6s2Iq1z+nguSOdhHTu8nu5wa2lIZLEJ3GMg4zZk
         tXDAYTLtMMgChUpYuNSlyEPa537KY1kG4O4E4bSmbki0q7T/qBghiHrRhB+1040dVjHW
         tAzOP7AxoYD/2AHxgREsfFuhsBVtvOhDaP8M5BX3SiXHF/C44O4y7oJv0iJvzxW0NQBE
         H3xZkKf9VMVUz7gXqCoSjEmPjZ7sxsQkEKuttpc+L85vy1uH/pGAX9Naba9Yl3rVNxGX
         I2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771549515; x=1772154315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LEH1MjHbZnxkzLPoBZlBfD3PgTYhguE+Q5oE6xBKIgM=;
        b=eUyt7zuucK4Y0p4Hqul+3KOr/96LguydKn2xeY5aaRDbWXCwieTeyDeB3eLtcTI40t
         P/wuCait1tkKWvzjzi/SIfu6nML6/4GcNqaH29eZuyawpgnjOkTuSlfE1+SEyYWGDic9
         eWzTEHmQkonflM6pS9wEMDMzyU/hYh/Y2BwSK9rZ+oO9fEd8LUVJYsRWTVYt3+wirxD4
         tV0C1w/UAx8cPumXZ3J3i5CyBoLgVefzpTZaRjvKRAS9cRas6qSy0wC+08k9vV2UJG7G
         noIw1+v/W+jwsmgfznfjuXlCUR73UueHB0zpS/WL8GH+f9ukHnTOuETKiZju4U9uPoUx
         KI3A==
X-Gm-Message-State: AOJu0YxLw5gaTGOzHbwN4zVN+6Fko8k6jReyfSQB01s00nLfonpwicNe
	PQE9dtJhB/EBtUN2wh4wWgwmHrwWquLhtBAo1Sxbi2n6D0oIGJMYsNGVB6ZiK+Y/f0dB7FpEKGu
	AXECAYOGLWBYGerSrImilcx8RLh5AZkY=
X-Gm-Gg: AZuq6aKUaWGt5oJNfHl9xzK1h4l3vfhpWPTZiFdrPztV//bsxL5xSoWgFUcRpRiDC3R
	aEYpl6PURPGN7MqIBmIXDEx7Ugl4jJzdlgJWEO/8BQyL1OmlpWvBhRpOWnOXSLNptdQosBv7+S5
	KB+yzbovKQoYxZXaPCyGd1t8UUkWzg9da1wuk94p6LKcxhpuDIhgJws8r2uA3WcW4fpBpomHmOe
	aQDR+0D6C+ZdclCR/9P8sxYzKwbla8ZloJLhhFvyyq8i3P++Bcay/GOu2Ah2tqtXuvZZJa4yhGI
	K+bNkzfK
X-Received: by 2002:a17:907:26cd:b0:b8e:d04e:e510 with SMTP id
 a640c23a62f3a-b90731b62afmr644466b.55.1771549515004; Thu, 19 Feb 2026
 17:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218182555.1501495-1-puranjay@kernel.org> <20260218182555.1501495-2-puranjay@kernel.org>
 <b36ca4ba2eada11a9b5cd5dc1f44e9217a86add3.camel@gmail.com>
In-Reply-To: <b36ca4ba2eada11a9b5cd5dc1f44e9217a86add3.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 20 Feb 2026 01:05:03 +0000
X-Gm-Features: AaiRm505LX5GCcyZqHUE2Tla0kKGNre8Oyu_clFifaejoih0Zxr1-CV1KY_dWw0
Message-ID: <CANk7y0hiddq=eiViLF6c4kGUBNS-vdHoWXK7PEAvTyb9W5rshA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add KF_ACQUIRE and KF_RELEASE support
 for iterators
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 8:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-02-18 at 10:25 -0800, Puranjay Mohan wrote:
>
> [...]
>
> > @@ -13797,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >               }
> >       }
> >
> > -     if (is_kfunc_release(meta) && !meta->release_regno) {
> > +     if (is_kfunc_release(meta) && !meta->release_regno && !meta->has_=
iter_arg) {
>
> This makes the check too strict, right?
> E.g. for most of the release kfuncs there would be no iter arg,
> hence the check won't ever be true for those kfuncs.
> Do we have tests for this check?
> Either we don't have the tests or the check itself is redundant.

A release kfunc should either have meta->release_regno set or it
should take an __iter arg, that is what this is checking. If we leave
it like it was then every release function that take __iter would fail
her. But anyway I will be doing it the better way how Mykyta
Suggested, so this will be gone.

>
> >               verbose(env, "release kernel function %s expects refcount=
ed PTR_TO_BTF_ID\n",
> >                       func_name);
> >               return -EINVAL;
>
> [...]
>
> > @@ -14356,6 +14400,18 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >                       regs[BPF_REG_0].id =3D ++env->id_gen;
> >               }
> >               mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> > +             /* For iterators with KF_ACQUIRE, auto-release the previo=
us
> > +              * iteration's ref before acquiring a new one, and after
> > +              * acquisition track the new ref on the iter slot.
> > +              */
> > +             struct bpf_reg_state *iter_acquire_st =3D NULL;
> > +
> > +             if (is_iter_next_kfunc(&meta) && is_kfunc_acquire(&meta))=
 {
> > +                     iter_acquire_st =3D get_iter_from_state(env->cur_=
state, &meta);
> > +                     err =3D iter_release_acquired_ref(env, iter_acqui=
re_st);
> > +                     if (err)
> > +                             return err;
> > +             }
>
> I second Mykyta's points here.
>
> [...]
