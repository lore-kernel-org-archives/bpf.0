Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64E326957
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324655; cv=pass; b=TZ5UMtw7szv70jz2xcYpeq4G6OXRiqTY3W5vWvh+nkn6E0vFe5rKiLr2Cj8RT1qlNZunA8mSoU2niLP2y8daIS1/FEI14jmaCXxa/Vrmfcu7A+BVT7LhB9PPXa8EfCtJEs96KGs7Tfvf8oBBS1fi3iRaRbYYMtAiZMk/o4G1hbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324655; c=relaxed/simple;
	bh=dPjtly+ZxqrcgnTcKSIFDHsF1hA5MWE73lwPbiR8+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fsjCO/bTjm3LZvTGfvj3RKqYnrmk93+fOmtDoV5chHdOxDkU0OzIlBKc9pwtC+wzDgIEuxSxqXZ/zGT6iKpoorpe+1hm+VLco9LHFNwYSmclbKavNRccoZy1GQo63mW7fyRyb/n/Qq/1QUjbNMIYSeR//Q2nT41Ua1KYfAmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmYLmGrQ; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmYLmGrQ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3870c7479c6so25852961fa.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=PxVeeL+RFNx0LJwCT1WvlQOgAg+2Wh2qh2xltW44t+EFBtrpy2iE+yNC4Z+f6twN4y
         ZHJBEG/dwnlIzp+GT3bf4ZozWxMROKPf+ReDcQzawE/HiIGBmTKkEx/KiKnmDfsYBOUD
         aZxXu84o7bbEmsbfRR3scj8H0nImcPNaNhvMQmvKIDrSN8YtCv0f8df13q4hxhCLOQhf
         wDH9iEGdi5PjIfRQ0iYV+wILR2WjhfGs222ovtA2j4/ZJU0WKi3U/lh6y6sMHoTfygqM
         tuzMtT3CqGlu8xx+jvM8DueJGOXyIe6dhd+6zNFjXDP7fY+AoSsWDsOMgu3Wo7QxyNeI
         iowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=f42nl7U4RjOa/iP4gRMN9ztKVKaDtGsPfs7lMSVpSpo=;
        b=U8r4UQ2wlqFc0SpPLYGR+bBf3UWUZUfBKQnNq6jPN9CsrRcble0yfjfLNoxqxTd7wE
         wnI2pEqYueLDQENXAbk8z/aNYnXXsM8CeyhAmHR/k/xAkyIZyF0i8RyLCaZanU6aX1iu
         YfKjlAWbeLPmdUb1/QtBvsW2DIH36fjtPRitC5euSvJr/ZER6/FkF8/cZfaMURgxdEs7
         Wq0aA0D1EGSkdBCwOSB1OUn4Z35eOedi/6o2j2Kf0xG+8bt9rdMtfDT2xcshe1iCFmWW
         RXXfwZIsUQY5yQ9K/EpOFz5OaC67evA9y3Fbu3LuVgircCg2YZG66dp8uZ3Gn3pEoAFk
         cTRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=dmYLmGrQL6EpWGinGmazJYZO2mJYS/9YAtjKAkQYVsYcu67/5AA8mkj764LmfULiGy
         Bq1tyIlasq5pw9UoS4Sr+XCwvWTBbwX8s+hIVYntsZPYoiwNa3nVU4Db6qMzN0KObR5u
         +szP0cw+XNRlcTzTNf4B5GXh2CK1xmRAFYDmrGhbKeZ1DNZbm24/fY6wlyVWhzNOgLOX
         /tZInKxJH3v+wzSCU2v2Mk1DEhlRMMh0/0h0X+K4aDFEi0cYkMFereA5+SHXhdwt9Ejn
         m9++REQio3HlLCp4R4ZiLcPl3WV10drQ7hxCz+iw3pxBnEx/RC6cNykCWYgpsliYzvIg
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=b1LchNYwRkHuIEzU4mUlf1uytKfEorJj3eCNy0eRybuNYNL5rygxGeR/jWeBqlJWhc
         pBUtAJnKgM+0kUQ1AxAqeAJB9CHjRuD1g4coR/fzIUygAf94ZMC1olL9bf2wqma1xnU6
         TZ+2zMgwdPN5tRd6/Yv3KeZiHpjMM4fqDRoDGKg7uwZuNOYp6bUSWFGidrOJKCOWRdPU
         Qu2GSAD0mHXz4F084RVM3Cx23OJnA2ymdfnsQgo3/+Pek14kYhwluPrwYtLwzoJqZ7Mb
         /IOu7gBYHjudTIprMClHRObzQzZVbcAhEObWFn323ZMVa2ALUWuZ/FruG2Zenp91BOfy
         8XRA==
X-Forwarded-Encrypted: i=1; AJvYcCXdvdmMJ/yA3sejl+JSxE3ecv34QHN+A15jP4swu87/mmvVJma/GuGEaXwJZ4S64QVqglA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq42ldIkU3S2bfNJwMjWVyc89BJ/TMVfAXywcl/F1Zh64wF4I7
	Va5gbA/3/DtK4aMV6NeIMKvywSSO9khUBQCK2lDGSmhz8kmBQfUkAo0K/QMCi+zmpfwGR8Mvp03
	OI4zPhPrhZXaaRJUzWbDiS+3lS/Fr1ll42eqlTg0Kuw==
X-Gm-Gg: AZuq6aI1Lxlp0cpc0/cfF9b+mM5O2F8ranw8DDx8eWaPp4uk8nBGRvPhyWnn2W1n1x2
	cU6IYNUk30VcjuwnvQLxprbjV6aKpZoMVWWcTl3xaK/WuH0ardf7bsS+pkHa2WoxHsikX2Ygt0/
	FBvW+TnneHrZNRQrqpy2VZpHMcFtA+ddkpLVruBx/M8D6UXj+lzQQwyOplmoCJ7aXj2rL8KjS/C
	VFFdUZfl0OYZm28g0Mwy5QYyXTCRD89tT0rV/fj8O/NSMvZ6fe4dlM0WJHCzi8plx5oE3rNzglR
	E2B3d72Iwne/ZFacBOL1JxToFZEdAFZB+G1FgJ/HHgkDuNV0WQVqlqvYnGgu8ggXcUwL
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>
