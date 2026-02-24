Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2234F48D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973629; cv=none; b=JY5BffDj/ZAxIbuDILg/navpmqY9SQ/V02exPAK9ArY4Q6sdNTx+ytnDDuO0z7SUH1dlwkI4BLdNmwiIxtyvl1PFrvI4d2z81TGAHnzTOoQjFEfRCnQd8x4nv8S7XDw8SW0czNMKRVxZZNVLhXFmT8eOkB0lIo/rhHJz0TSYDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973629; c=relaxed/simple;
	bh=Dyi/Hh0eonMOfEW0KVHX16tbYem11KnRuJGjC0G5Byw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOCqpOAO1zI5/Rp+NsPSNvfYF8bVCUEncUPsGxWympW3eVShzFBsFmqZTWU0jVk0psvdm/JmKImEkEohBwwzcnGXJbAkp6qlgG6IY6NB0+zMoxdHWjJhTK406DOfJjT9hpvrK6jTP7U8pgfXtJpKXJWd3GYx6HFD6CbnUv1Bcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5b1FwaZ; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5b1FwaZ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1277d379936so1116021c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973626; x=1772578426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ir8qJqT+ykNU/gLEBGXksrTkED5fD62hwnSlZc46Al8=;
        b=e5b1FwaZeSs46nnjFqpgX/Qly9V3Yl+bt8psVCKKTHF7IrQqZ3BNATYHehhkdaOAZq
         mRdmh23p3OHPy0gOjYdCrbklMU576iz94BIG0ZSnfeNXRs1sIVKgClRQalSO9EtythJS
         hJRzM1krzWXWiEfeDkby79lNOdTrcf5fWWhRMai1jOMWGowspfJBqa3l/Tzx9yna7JBE
         VTBCtxtRQv0JO74oU8XGf+GNDz/j/JpUod94ek15gcUleY62ZHKqKWPrvQDU8L8H8M0Z
         8gMCibpppQNK7vUZM1HTh3JwOm6rxgVqgS8IFzMceSTGywXeiZ+LicyYazU6Sjfs+1KC
         zKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973626; x=1772578426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir8qJqT+ykNU/gLEBGXksrTkED5fD62hwnSlZc46Al8=;
        b=IF+obaLru+3gujyUTn7f3mlwp3YehztssIlAxQfhtOg5HGBFZPIq6BP8gwTKlkUao9
         hjNBNxD8VMQ3jP3927ye84wvh+rM067t3bpUanc18bBZ0SXG4AZierUDVKLx3wDBr1m2
         0vA8aAFbqvSKqbPYq8JmoHsDEIyJKpcxlWupAEi2DWk/CV+LLMCf8JPzFzN4tZSzEcX1
         QXpwW0jcf2nC/09CfifBaTpA6+4UQue7ZVuFTZlRNTJf4Jo8T84fuqkbpZ3Fc/8MBkyf
         eHg7S8SlG1X2lj+CNrQ4cDiGCyenQ3w24rxKSQ3l22onYEuUZPULMWT4KzdEm4V0awV+
         9JDA==
X-Forwarded-Encrypted: i=1; AJvYcCWAtUSxfjYH+yQjyMUx7xrj4cmM9fqGhZIlhqzKXBJA3X+WbUOIF7SHQrLqP/00yFd/zCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MAy6pdmSmlF1npIN/nLTXFFJxv+5MeR9svaEbO6PSuATWRpF
	twn8ZXXUY1ZpibSwYquxCo8n+LGQ99J/bjw4ARU/jO2bcdpiBpwfp8DY63KXZqNX
X-Gm-Gg: AZuq6aJBb1Wlsi/qAvaIHPknYA0osLtvO879plK3HwCcySEGYiTt83KZz+mKPm/ZQpg
	8GWiToLfx2N5mQF/gaOC9L3rR5V8CAQnzicZf3kaT5gCM79FuZlIq3pzqOFYhP/aiIAxOxd+BpO
	1FItTRYB96+b87dYfFkX9b3MZNDk5WSIPViREa8JaQMIWUNRWj3NPhqlEAsyyNMD2TtUmz4YW2R
	uy6jP5s1FA75fzucWg+HmNR34cLOxqwIQ0oIRbIFCt6zxswP1N59YzWq8x6R1DVKLnfYIiAihha
	uQAhIMmzi1MOB2R/RKnvIuz1shH5BrNTNsNMndhXatSv5nnnEwdAYQuEaE1dQHYkLRPTThQWdBR
	rZOloPdohYvtrPrTbeSEVRf8b9yo+hpsRa4/9QD2ihybBWkKJ4wjrOrOCmIxhGZkGH4vW4Y6FRV
	+fycJoY3wrXuGOYEVJVd1/g2OVRDI4rMDu6kiZ/3CW77wOaNGasAW2C4UQMFCoiOam9Np8DmYkK
	lN5
X-Received: by 2002:a05:7022:6b89:b0:11b:d561:bc16 with SMTP id a92af1059eb24-12781e7f78bmr124497c88.22.1771973625646;
        Tue, 24 Feb 2026 14:53:45 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d945:dbc6:b702:5c73? ([2620:10d:c090:500::d49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8c936sm12500180c88.14.2026.02.24.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:53:45 -0800 (PST)
Message-ID: <cc08ccc2398d3110fa85b76ef0452c46132fcc98.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
 Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, Kernel Team	 <kernel-team@meta.com>
Date: Tue, 24 Feb 2026 14:53:43 -0800
In-Reply-To: <CAADnVQ+vjJf9xy6Oy5dCy_F2hvKt6TwZ1jA3Xv2PxMDpkPksXQ@mail.gmail.com>
References: <20260224212535.1165151-1-puranjay@kernel.org>
	 <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
	 <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
	 <CAADnVQ+vjJf9xy6Oy5dCy_F2hvKt6TwZ1jA3Xv2PxMDpkPksXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 14:50 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 24, 2026 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-02-24 at 13:46 -0800, Alexei Starovoitov wrote:
> > > On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> > > >=20
> > > >=20
> > > > This series adds KF_FORBID_SLEEP, a new kfunc flag that can be comb=
ined
> > > > with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID=
_SLEEP
> > >=20
> > > I don't want to introduce this new flag now only to be
> > > replaced with KF_ACQUIRE_LOCK.
> > >=20
> > > the follow up we discussed in the other email is different.
> > >=20
> > > pw-bot: cr
> >=20
> > Then the refactoring should be bundled together with this series,
> > otherwise it is very confusing to have a flag named KF_ACQUIRE_LOCK
> > and bpf_verifier_state->forbid_sleep_count, bpf_reference_state->forbid=
_sleep.
>=20
> The name shouldn't be forbid_sleep_count, obviously.
> I argue that the counter is also incorrect.
> As soon as we have two iterators that take locks in acquire.
>=20
> if (..)
>   iter_next(it1);
> else
>   iter_next(it2);
>=20
> will pass the counter compare in refsafe().
> Both states will have forbid_sleep_count =3D=3D 1, but they took
> different locks.
> So we need to compare refs in for (i =3D 0; i < old->acquired_refs)

Current series does that.

> anyway, but then why have a counter?

To avoid re-scanning refs array. Counter is an implementation detail here,
but bpf_reference_state->forbid_sleep is not.

> The bigger refactoring is to generalize all active_* counters.
> That part can wait.
