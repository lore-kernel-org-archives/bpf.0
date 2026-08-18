Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B693357D13
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085228; cv=pass; b=pNKY8XFeERRBADKuqPgzJUsDB8Xvi4hAS3L5vymrUw8HYtiH2dNbqTK9jSOQzqr2xPseNZsTHen2U5LJmoTdOUWvJAXHW1mFX4Qp76poQf3MOUEfA6CuX2Ii0TiS0pdnYglnBzKi/1Dx6XQRrwCJUGxjf8JToGMs4yb10SrQ3EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085228; c=relaxed/simple;
	bh=ahO/hxkyhcx9MbLYLXI4ZZtDhucoaenUkK08RmlXrNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuemsA1Irc+42Qw+5vUqUQM9liMOsVhMMM5HubuwPke/oYRdVzyRk/lYlFyVJvPJc+ljI3DzjDO4BzKm2K9SVDZooFaa/17owVQOccZqwfCBmKIOYjra2PSRh3n14hC/pPOFhcn4Oz2QG2xMgVzC+hN8BijIyKNPUf+IVt6xxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ypi481rs; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ypi481rs"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cca0c5799eso2373015ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787085227; cv=none;
        d=google.com; s=arc-20260327;
        b=UjBZgquVMLMq8RVExNp8W/0pEhFfWT6a7y11o/G5mhChvbOzoy+BYssfkpKxND0BCI
         kfe8904YVvaGxH6MtZKFGMEPCasyleGEvjailWn8Na/9mw+ej/mMwBCl7f20dLSQcOLw
         +yAkjT34gxnahpnTRaP2tSLvUXXcoRMLFY2vvhwKGCE+npm6hvUnJdJDmc1NowZ9/Nct
         GpwT5Gm2WJDYFJq+6GnPfm1LGd0r8lHpY7Mkz84NCfS2277tc8vie4PaoE+mPJ5yV+Kt
         bIrmVSyQKsoq+u8+XAVUWKiM63KK1zKauPagT4xFKRsr1EWpv/krYtmb1hAS4WDGCOAm
         MMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        fh=5GS8YikecPfw8PDBEeqtXFO92oaTBO56lcxvPkL8qjs=;
        b=poAmQDaNdS5Lhkly6IwUmSa2YVgAePXv2gKh4Xu7afO1Nw+Injzox+8vqbud7L7WVy
         sY7B4RSUbeUgjPV8V1Mfg4KIeQwA10e1M4God0WIQTQ1VSR6v9Z8v8+pOVwZOQtCF4Q4
         dU84n5vI33mEL8lzxqOjNVyz1nEkXQb54Y7eK9UKaGFeL5c6ZylhThZNcduJIowg3JTo
         0/oQqGibQT0X4FZEPNb+KzJWAbqd6yzZSd3wd+79pX+bBaHY8ppHda9qPxdsU5vQYFsC
         Do/dLyUGVI1EAYYrP9XO7rhiucUYSY5gd6Fb0enNMoqTLQ4sRZhL/aHcWAcnNLuiVbzg
         aEyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787085226; x=1787690026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        b=Ypi481rsn8BXNpkf8nExmkxN7BZuty/sAWSAXLuNjknGkaPD9JEmlrWcQTN1O5v2Y/
         mF1p7dPf+5t0UhrDQ6xPyPN+bghe87PdmhmwstpBJGRon3NovbGqoqTlyJ88zLBroY+i
         clkdxTlsFOD8bXGbigawU/aE13x8GfMuZ9ULAYVqlT2XDIZeDUm2PpoIaVQ/yz7ks7K7
         zMLkDRWzNDGslOvrFWS73/Z24xZX73/Nj7DawwKy+KkyFJ0hnxp4RaQSwB4HtoYTiUNa
         aNgENfUyJAfnEndPPf+5aKbWS7M622SBO4i4z2S+JBC/Kp7cohIhk+l9ZmeNzSneAkEI
         qxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085227; x=1787690027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        b=H8gvX8hEjW5TMIXHtQo7kzxIXkr6nSsPckH6WqIItycr+plvJAMX3y3viN/5xLy3nv
         SGIo7qKNr12k7+ayP1Tdic4J18WbzHdym21C4ZhwwE01X5CAH+W8wq4ZSQuV60xMBJdY
         vWEWdYb7FhVj813QciyJjhNvsZAHGFEzbo7iQsFpNgfBbE2wLCv+0bCg9BjggO/KQUnn
         dUhgfrh1qhTRpI2JcP+ZkDbxzye2SlMJVds7UxAG9Js/ZY0/FN/mqsfXT91K9NJDu3TE
         SeGGNItmA4J8iiqq/1MyCEv7YDDdxR01XKUzQ62/PftIRL9ROlC0bRAqhgEqss15B4df
         aq0w==
X-Forwarded-Encrypted: i=1; AHgh+Rqvrc5JA3ryNZUf79hpWOFBY0+E3zcZD/rjgjv/nWouBiTZqieAGXNCD7H4mbU/AdwiRjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYv0Zo2RgBZD96yidBcAMuOV7H4usUkonxLv4/MQ+Q3VGMq5mw
	vdCG6K/kw4oM32fEmsyv0f6n+pTFknir2ttHDhjEKsN3H6pDknLRNZrGtNpSoXGESkr+TvIFICW
	Z/e2/Ctjh9k4v/jElwOEcsaE5I8AR3SAizXIY0wC+
X-Gm-Gg: AR+sD11iCtUErDdv95zzatLwvMWWU30n/i7dtQZ9AbMCx8Nue6k9RL/rIwHLtgTFmWq
	jURGxrNJ0EHUxXupSaLqMkKK5CGwUvePu22NV80BzsOz0slgpRC305U2QQiLa+Te2GlwDcBy1+T
	0WgyJ7L1X5RKWFi9T0jIraPLOihHJJDWyQlCs6UyV4TfAvi44tVwuAQwH7IZKCNlsO9L0QkKrEK
	k9ATVGovkPbcxXjCXYn6udHSEGbaL1HjqHMPKVVQL+hiiFKvsOCWKfM+eBAoQVeqYRkxHD2N+/x
	mOgAHuGZ16fbvFjbj+LPVbNq6gfUKC4P0pxD33+exU1J
X-Received: by 2002:a17:902:fc8f:b0:2ca:1b97:70c5 with SMTP id
 d9443c01a7336-2d5f6a6eb9fmr7767355ad.4.1787085226630; Tue, 18 Aug 2026
 13:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com> <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
In-Reply-To: <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Aug 2026 16:33:34 -0400
X-Gm-Features: AcwNN1UQuVCsOkhNWUx-tlb4xHAlv8wA6C_NfoDY1rkpQ9dCBetDreSKXv9N6C0
Message-ID: <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:16=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.c=
om> wrote:
> > > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > >
> > > > Lastly, given the difficulties we've faced from the LSM maintainers=
, I'm not
> > > > inclined to waste more time in explaining again why this cannot go =
under
> > > > security/.
> > > >
> > >
> > > I'm still going to send v7 of bpf_init_inode_xattr series, even thoug=
h
> > > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > > inclined to leave it where it was (in fs/) since one side will NAK it
> > > wherever it lives. We can record NAKs and take it from there.
> >
> > As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> > in security/bpf_lsm_kfuncs.c.
>
> Hmm, even if it lands in security/ you'd not ACK it?

Bah, a typo on my part, my apologies!  What I had meant to say was
that I'm not going to ACK any of the LSM changes with the kfunc *not*
in security/bpf_lsm_kfuncs.c.  Sorry for the confusion.

--=20
paul-moore.com
