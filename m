Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044A285CB9
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193804; cv=pass; b=BIA6BBZFbZwskq1Q6gDmTQQoJanT8+w1ct1F9TWTkTMJ8dydxk6UA4bsx30uOTDVN4o53Rc7cAhoWyqZbGIn0MY3cHY9/lPfPshNf8pv4C78rxYvmNQv2LeSemke4T/kxneBBzDHCf6BCcmlvlsVJcZJFNkH2TpAse0s7ZJv7ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193804; c=relaxed/simple;
	bh=J43mBV0ldP+9tAKtYP6opL+oCOolAXGommPsCXcYceI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB6G+9wDnGRc0mENn0PLHAdEyPTINJVErZDvZm/l4e9x5Rq33ekvgNZUQLNH/4PDTnhlAhWvKKkRjD2nsvs55YAqhcTGwCIo3ZC+bTIu/YQ0/bfJO5+BFqZkOFkvAC/6aeNSpKRs0CNdnKRc0uGmSzmSQDoZKc7V4M7BpLnKoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LmWTpN0P; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LmWTpN0P"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so5245113a91.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 12:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776193802; cv=none;
        d=google.com; s=arc-20240605;
        b=Nt90nPJt8BTKnwec50yum5kjMinyBC6CEt/6gsxzVofIsk1hPVOnJIIZh/9YzfwV5b
         0uwC0LubYC8evUBX/VkeYD/DJoJBaKF6OwhUtB88RHot3Lf0RY6jIdKITGJpR1fw1aUh
         riBKoeTw9BUtoFXYA+nDJ+ZaYlyEmO49DDY0o6wrDfA9eRN7UPpa897JmM/EcOUphbHd
         9b2MWi1LKeAL3bqdsm76yWD1ubC1+0+vG5EZStkARHMs0DJTBAFIWUM4Y3tkTE+GKunU
         BR7U1XY36N5CHgKHhe+3oB2xYyql8WlHCXCg1Zz3rnoiEBe29/nEZvO7Mja+WbmXNmPR
         BCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        fh=hpwdmOtxXrw16LIKjtnzLK9qg5iOS84ql4EsPX2JBeA=;
        b=J2gSgjVECBeQSUtjFw/JOYZsIlqv1xdtrXlmkOjFew55k4HDX4JsZ8TEbgT+wY+R5W
         yMvRL/Unh75LIw+ApycpIziRSe9XxkxFAZNsYvRjDQ/LhWhxgqhx+J7g0oJIaAgeusu+
         JWbJzCZ0DYPLwR/6TUcfhUnAWgvzhQx+6b+FTHD2WbyJ702eRPULo/enQ6L/C9siEv6q
         vH4wxef3wumwsyV63cp+eTwDjjY7L8L4npSsXiqhjPYSCDSW0J/IlHUBzDVKwCNtm1Xa
         o4FKNu702Rt5yZ7Yhh+KeJ4/UgLlulJy212WtS5he2mK3mxHDIoQmpKdXfrC867rlZnF
         lXTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776193802; x=1776798602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=LmWTpN0Peh4h00Aj7+bjDQkB7mVZgsUpV/11IhN9zk9dsuu7Y56tIKhTPFZliTs3AH
         XlrrGQYdCcZ8Nk/22Fb3ZU92zk07+PJQbZBqQh1LjAzBv0c6Nr+64Jlekwu/cMlSNScd
         0tx2dt3Qz7qemANtJ8V1vrw51Am5uEIBjOtF9ZXEDa8aYjSIEvp2cdQ82OVfJ5xtlYbm
         AtbAShiEatIageBKyTH4Sxz3IkTHU9iqqq+IoCYyK6sxUecnn9dTTSIWr+S6/snArMbK
         Sho0PBUg3b09QGVLBKo9I521x9umTuhl+N1JMI6fH9F54PmWNt0KiSiXv5eKCtqmMyZ5
         qrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193802; x=1776798602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMeIDL2hZeivdhvp3qRRH2W8sXvQUhY/bjEclVKtEJU=;
        b=UgGgA7A+9AYwzgQ/IjzBExJY23szDoEZk6rQolM23DfKjOM/ov8QqktJPf9aDMgeiJ
         dqNb8YeYGpgeWbC4lJpa74AJ7zOENBg+lUnnsUkjIdjV9v2Q8Hz/99ftpI1XH7DVfrgF
         UsuWKXF7c+wPdqRGP/PbCmzre5oqB9wK6uksv5/nD3c2hB07BehWATbLlaC4G2O0TfOZ
         V9tvcLELPMABGapUBMtI+FNpq+MSJSGTiYLOjFhjU3KyBkqI9vRG8PX/UYaUKDynpxml
         vUTYNPffivu88HanNWpiA47MS+W3I1ypOrAwfpwRuvoN5WHAJxIfkOcbch+mjSCLOYhs
         dCLg==
X-Forwarded-Encrypted: i=1; AFNElJ8uZ1vbisC3xlNfpKuxrlQmgx/tbSzLbJVyqSd4e5/w3418oIcjuTCKJ0rgD8PZ0X4NFDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlU+EBTdm1VL9SofOLvWTbujdXo9DPa0JjEDS0whKMrhI1c/48
	65JCTq8HzAudLrylJCHp6Aijuhyt08ykppjwTKaJd2mSB+jRBTt8BO8FF3ZRrtJLBxsOX9ixUk/
	eX+eepRgika4CE2x+Ff7ojlm7Dv7tl8XTR7ce76fg
X-Gm-Gg: AeBDievNAc4mxultkQtFdGhsvKRmnHrC3Tt66USFHdZGPltdqA9sjbqOER4ggx9V2ml
	SLyxH+q4e/SLRVS9cfjBL1NEqLYPfgBmAluJt2UUcJ7BOfGJfoGeHa+hWhSV/JoeAuUZ+bY+I0u
	Qr5FxCEWEUzVnMNqf7MGNoG7pHSh7XqASm6kkMwNBTBViK9JqSIWTRcMbzuSk4mGgy4NCvGdtzX
	o2YSsjUvvjAiC7JqMrmoDh3NCbs405xDcg4RTQ8QIEiqZgheyzSJ+etSqGqQYJh8chkPmWeuftr
	S06Konk=
X-Received: by 2002:a05:6300:615:20b0:3a0:cd5:82b7 with SMTP id
 adf61e73a8af0-3a00cd5a76bmr10180913637.55.1776193802297; Tue, 14 Apr 2026
 12:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
In-Reply-To: <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 15:09:49 -0400
X-Gm-Features: AQROBzAOdBY4w7LZBBBsHqiX9-ECTPgm0KJFmDB-WN8NELm_4E3dGLmVNUhIl-4
Message-ID: <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Netlabel has a similar issue to secmarks with its use of secids, and
> currently supports only a single CIPSO tag in the IP header, making
> multiple concurrent LSM support impossible.

That's not correct.

We've talked about this multiple times Casey.  The short version is
that while NetLabel doesn't support multiple simultaneous LSMs at the
moment (mostly due to an issue with outbound traffic), this is not due
to some inherent limitation, it is due to the fact that it wasn't
needed when NetLabel was created, and no one has done the (relatively
minor) work to add support since then.

For those of you who are interested in a more detailed explanation,
here ya go ...

NetLabel passes security attributes between itself and various LSMs
through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
is an abstraction not only for the underlying labeling protocols, e.g.
CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
then translate the attributes into their own label representation.

Outbound traffic is a bit more complicated as it involves changing the
state of either a sock, via netlbl_sock_setattr(), or a packet, via
netlbl_skbuff_setattr(), but in both cases we are once again dealing
with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
underlying labeling protocol is configured within the NetLabel
subsystem and outside the individual LSMs, there is no worry about
different LSMs requesting different protocol configurations (that is a
separate system/network management issue). The only concern is that
the on-the-wire representation is the same for each LSM that is using
NetLabel based labeling.  While some additional work would be
required, it shouldn't be that hard to add NetLabel/protocol code to
ensure the protocol specific labels are the same, and reject/drop the
packet if not.

Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
require some additional work to convert over to a lsm_prop instead of
a u32/secid, but if you look at the caching code that should be
trivial.  It might be as simple as adding a lsm_prop to the
netlbl_lsm_secattr::attr struct since the cache stores a full secattr
and not just a u32/secid.

--=20
paul-moore.com
