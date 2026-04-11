Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A971C861A
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870896; cv=pass; b=tQMgSFTdSqYOp2bpT81dmLsqpd/5dwz4DlbSTzC2Rw6zew/ZOWUSnu47HGHy/e+RK/YWGT3AcuEPTpp/phbhmS1tUsJRmJn0/LgVPwrDrJBvSHjrf1D7tS1gAlD454RQC57mBIMz5HNNdkb2pz1236ywFQluYN97q15Ef3ujTBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870896; c=relaxed/simple;
	bh=sARHTMqKvBCZQlh4hioib58ltF7mRpUhN3lu0IlCoM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KN+RwmSdawY3wb0KTM+dHG8iiQ7H1iZpzv4z6ASPWcsMJlAMtPpadcOLzDBBYP33L757tViS3v9L9HPvxAA17bKmNTECgZCTsB+6o570qDTff2PLx7RtVaJaWvMwKf9h8vbAshGI6/CmhtGiGWuBT4WJjK9qsZzpNnfxGjzGee0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOHFOsXb; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOHFOsXb"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501c9903edso3093124d50.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775870894; cv=none;
        d=google.com; s=arc-20240605;
        b=BagxvOoCFNGz6geAAiD51lLTEUpgSEmbzRu3ic9XKJM0uxioZHaCuDisn8UwgXwtfl
         ponj7s4gLuiQo7AL3+zuFALZh8hSapeftU5OJe83ETaOWNgw6/aMwrFpGKVaY7/LIrEs
         fWuEqzGeKcVC6Cl1dOPIeDC6lXYnZvXfDcvaLsH/srOPR4cZ9uhwqPb05jiPKQSvCh+f
         sO49xf97jM6AEoZv5y9kHJ2ij9MLB6p/Ho+fhgWJ5ckvUi6p8jnuFSOEUCb4Q+WxRSqI
         XMumnp4ncoEGeW/jSlko4j04FMSRPCYeKDZFnAZI+qv4X67/oIXimTb9mjqwJWTKMDxs
         LrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        fh=dqB3qfq0a/Hq3br+utT7Mkr0GTqlulvcvZTAIkmmimM=;
        b=WSvTqlMTJjMgoDvz78dopvrFdUBo4LaLyDO4UdUwSMpMFma9uO58Znh0ZTtx7EdBbq
         76AEyRcFWnIieo+HhQifuVgAQjrUjiWfEIKwqELjiCAEAWiOyb0CGLw/BoltkX8pkW15
         xdipil487Ybn+QG6t8Exko6AQPEtge5Qukia5PKa9P8kZUYxnypTbjvBeMiQHUe5bMfZ
         FsqNAvNc7flII3r7gqE9KZXqaUuyP7YcRqMl9gldys07kWz+wseOUv1VrqTg7RQAfXeY
         DtPtbYo3a1DABFknuDeNQizYnojeNvQVVlAhLeYuAEgA4YtRlF2H+E7Qw5sa97NQyZH2
         XAyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870894; x=1776475694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        b=jOHFOsXbtu+xkTIVOziqHO2CKjQ268jRahPto8NgjFW5TLp0OfAxjUqyZ3IOTOCis0
         +jrc05dOHwTlCUN3T8VXX5RqOauCEXs1A1iNuQhNOMEHhtM+RsD4kp7nq75IhVFjtASM
         CEwd4yE4dmi8uYpc06KyKf7BijdvWJqVysw5Fakp6fW+eQsV8Ebbm21Ctj/1yI5sV1JT
         rn+yQ6v06pEa44U1OWBl+R8LSTSNZgC4kLpfdkzm7/IBhhidJu3IpTeG1PNk4ZMMExTv
         vbcq+B9BqbdzZN6vMh7PDpfTUhfUT/4g1/0+mybUG+rYdknWAGnAilM7OKapt1zSH2DQ
         4Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870894; x=1776475694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        b=P/fFwAhpIi8kZp0sqoetk7HCLnePIaTlm8OlvrP6dnWbbbVw06ZFC9cTVFRBJoA/8E
         XvHW8KU1G3B6Wjjkj9PfwfjXOuTfYgDVfnfbYiBtim8jXzxSho/72rDjo7MjY+AJbXEb
         DIT0j1PJKqUQwBP92a1K8d5sDu+YNyijLPFlYoBI35AavaGARavrjSf8U3Mqzhdl6yDH
         Nqkb0V14UgWxFKi+TMs3Hfuu2G/KiZ5DbeQ1PuRaOEh1CjKoVZ39y6vmjVZaeHodBlrs
         pymQo1hzE2dEZBZliAjBFTlPxTsMqSDOQt0kFWvV3u4ITFo2AlrAQ64HMa9ycRIUlav/
         nvYA==
X-Forwarded-Encrypted: i=1; AJvYcCUok+DhWze6SZhbyn0MwJ6QIt3pQgXB5y7HcBnsp0O+lTxH2d6i4BDZ4/yttaBBpU2267k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3BQXo8MFKy/xiQrPe99V6+0A4VRhD9wAYwMZkmUICSxVxMqo
	JN09MwtICfZs5NwTC/yxhWW65tH+B66edP6yPNdiAYTNxBfA35J+mG4AqmZVm78nxVSN6MC0uJy
	RBP5FskeogMBSA9WmsfdFEWQjbg9pYEqYpZep
X-Gm-Gg: AeBDievPXJ1lF22zzdMm2zbl3pnB2+GXJOvzJ/ghKNlr2W7TdkBul4C0GP4FUwGFJoq
	doFV1JnfWvCORncQVxtGiV3TDP9krwWhyRrkG/yHgwGfnjhdVj3H9bfmFpT6PI558aVl5UDhP7T
	bAwTuXAt/DPuMBWN07R9hv1ZAvK/pMDqeqkUXrvJDoNu8Nx7WtAruo+ZSQxqi8OT3hR5Dq3O/yd
	xzdP61fVKTtDe937o84UoZgyAMbmn2yAnMBYY2OciBmNuNL0eZEWgIsvXH9qUMGBwUClyh7zCem
	NN687gw=
X-Received: by 2002:a05:690c:c147:b0:798:1219:c780 with SMTP id
 00721157ae682-7af71478e3dmr55601077b3.26.1775870894222; Fri, 10 Apr 2026
 18:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411001711.3418264-4-ameryhung@gmail.com> <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
 <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
In-Reply-To: <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 10 Apr 2026 18:28:03 -0700
X-Gm-Features: AQROBzB3Y0gFVbZ0QmWcDCTtHxj-St6CKseFfy6xjF80Iq5WC9m-ibzU1-h_apA
Message-ID: <CAMB2axPw_YQZaj3LoYVbR3Wo+RzWma32KfXzdedz9Of_nakVWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 6:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 10, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_lo=
cal_storage.h
> > > index dced54e9265f..9e4f5c45c974 100644
> > > --- a/include/linux/bpf_local_storage.h
> > > +++ b/include/linux/bpf_local_storage.h
> > > @@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_m=
ap *smap,
> > >
> > >  struct bpf_local_storage_elem *
> > >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, voi=
d *value,
> > > -             bool swap_uptrs, gfp_t gfp_flags);
> > > +             bool swap_uptrs);
> >
> > [ ... ]
> >
> > > @@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_el=
em *selem,
> > >  int
> > >  bpf_local_storage_alloc(void *owner,
> > >                       struct bpf_local_storage_map *smap,
> > > -                     struct bpf_local_storage_elem *first_selem,
> > > -                     gfp_t gfp_flags);
> > > +                     struct bpf_local_storage_elem *first_selem);
> >
> > bpf_selem_alloc() now takes 4 arguments and bpf_local_storage_alloc()
> > takes 3, but bpf_sk_storage_clone_elem() and bpf_sk_storage_clone()
> > in net/core/bpf_sk_storage.c were not updated:
> >
> > net/core/bpf_sk_storage.c:bpf_sk_storage_clone_elem() {
> >     copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC=
);
> > }
> >
> > net/core/bpf_sk_storage.c:bpf_sk_storage_clone() {
> >     ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC=
);
> > }
> >
> > Won't this break the build?
>
> Nice cleanup! Pls fix the build and respin right away.

Oh well. That's embarrassing... I made some changes to the last patch
at the last minute but didn't test it. Will respin right away.
