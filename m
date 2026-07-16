Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589B3793AD
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235284; cv=none; b=kUn2r9V8+TrZlK4KW2rST6Fb18c9WsjnCoF9cDpP+tTL23Y+pHpxt1/iVyTNFFGaaY0377nnhhT8hfpfmMIOXiANvXfRLwIkaiODILmDOarOCJRWVodLAWifi7meKkKAxSiA9OUGqtiUzVtjatn7FFGKkBgeSVmajt5P9kV7LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235284; c=relaxed/simple;
	bh=OstskZNC91S+/d8lT6ZS+KM5fQoSVJ250tyiTLevjR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EMUSbZRfpBJXmGCpUrpRhj7Sd3XcTCG66qXk2VsjVakA7AlIQUxovbiC5xVb8HesG3j8SWn8RM/o6gDFA3WuS7KF6pZyXZFnfMTpbGuWWqoX9tcqGGo8YUEqv5d3wHxPeTcDZF75Ho7ELSTXF+tv2mS3uE+U9EFH21Ffm9mHcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=ru721m9v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="ru721m9v"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92f0b5ed131so344313485a.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1784235281; x=1784840081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95cbsQRMz66HA3tAaT1LO+1gPHeCIHK5SKoKPYy6pjw=;
        b=ru721m9vxfjnEsPeaL0WiOkHkdTL7LAY+ygtjG7FO/qxBj2Efl7ZBJ+wChiFg5G2sN
         5useAUBIur/n8r0lN6vz/eUXtCYZ0V/cn0OMXEcLC7aqSUSC2YjoFOysgmdDlX0IVme+
         NsQNgnW/JmjWe9zl1tm2o7i9zpZPm7qCkaU4CS/e9ktp1ONEqSRf9SyTb7vD2suSsdZ7
         aLQ+8WyqZG/CSt+p2joUVGXjWXUER6LvI/veaKrPevMrA2V44/aO+eQpexsmZdlhSd0P
         6fuvjIxFFym/3rQSv57DNR9KQ+ZqpeYRTzqaWijDnEHiiOq4RnfI0X8tQnuID2ePaAB5
         vkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784235281; x=1784840081;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95cbsQRMz66HA3tAaT1LO+1gPHeCIHK5SKoKPYy6pjw=;
        b=HEpyx20VQttSjyMhL5HrbLXq3vL+n2d4LBNA/I4ssrgK8IUd2DMACdF5skJ3NrVP9z
         8UdMCjkEf6Q233uMtyJFCKl30W+zKNaqIvA9ELuADyxdmQ9N09KiMz+dEeJErNppuNhn
         +Is5pdSJM48m8KiXRA6YBbK72XftdtgyOhoVc0yS7/RVz6TuYdy/Gm0CHYdV7nUqqkSU
         sozlwgOjOYD9YX2RmK+4nKlYBDGPf6b4bCho9p5ASYuFgwo24vliN10WkJw/P/3AiEY4
         MXKwzTMYvVBwN34DO40J/cEBJ84VBNOzn1g05rJvmazqM1u36cyEbvS9LwX/UA8GYwGx
         8C+A==
X-Forwarded-Encrypted: i=1; AHgh+RrpP4ob3fKn2VD+geoEiSEeFRp16cJMcLe/IGPtq+D31N7ULhMpTB7TFbFE3Pk+aOXth6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4hhx9rPWxuzGkZ1p+RbAfv8FzUF7l1eDmTmLZm4N76zh1ElX
	aKi8l12C4X7zszU7iMUqjyXmCAgKBQJajflMmAGVTeY1WmTKZJmr5esLc2yV+xj1Keo=
X-Gm-Gg: AfdE7cmFi2j9CIVyVC/2CkZZtBCoHiARbXx0XdJUGHXRtr9cIGevVHkbRly1hhM+je+
	oLGVOQ2YvXK067flgmI9VsJH9EbGBHzdCTDoWDJEH6INPVVHgYLsyQpOKGM6JWGO4DOwDFQYD+3
	uYKKtlLGNcl6oNupNAJbUFKJwNxEzl9aKi8xudbClIqDwSX+nOynP6KxaZAcnnwuyXM8xjGxaiM
	smlTyGbSztb6OznB3jx3LD/c7+KyB0Fg5J+MRYwGLnY4jI9jE01cDsdiG7YaQiV+hHB1F5acowH
	q0gt6ALkLzRwiwwPEj3hhQtbzwXad/N1JRoFZhuLnB+au5I661WmjNh8+4KsMlR68PIH3lKQjpm
	oFLrJqyiJuEId5bTaiy9Q5+rN+WOwe0G4Hln6NgJZMkrbBMe4p6bkQOjEssjGfO9XQThBZBcuc1
	yocEzBdgU=
X-Received: by 2002:a05:620a:6492:b0:92a:e474:92eb with SMTP id af79cd13be357-93096371496mr987518785a.55.1784235280985;
        Thu, 16 Jul 2026 13:54:40 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::c41? ([2606:6d00:15:e06b::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d69a78sm2093114085a.44.2026.07.16.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:54:39 -0700 (PDT)
Message-ID: <cd791ba9f1819528a9a964ae2ae3833c8e6c4b87.camel@ndufresne.ca>
Subject: Re: Linking Patchwork with Sashiko?
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Theodore Tso <tytso@mit.edu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Derek Barbosa
 <debarbos@redhat.com>, Matthieu Baerts	 <matttbe@kernel.org>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>,  Jason Gunthorpe	
 <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>, Stephen Finucane
 <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,  Chris Mason	
 <clm@meta.com>, Christian Brauner <brauner@kernel.org>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>
Date: Thu, 16 Jul 2026 16:54:37 -0400
In-Reply-To: <alhMB7vGodoewjcz@mit.edu>
References: <20260713094120.GD1127719@killaraus.ideasonboard.com>
	 <20260713220427.582b28bf@foz.lan> <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
	 <20260715005909.GF1656185@killaraus.ideasonboard.com>
	 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
	 <20260715163921.GH1778116@killaraus.ideasonboard.com>
	 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
	 <20260715190654.GK1778116@killaraus.ideasonboard.com>
	 <alfwOgVRgUJYOGtU@mit.edu>
	 <ef9f77c613a05c5745941587099eeb4f159d5e31.camel@ndufresne.ca>
	 <alhMB7vGodoewjcz@mit.edu>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-vNfo8YD8KuhvtCjCItm6"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-vNfo8YD8KuhvtCjCItm6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 15 juillet 2026 =C3=A0 23:53 -0400, Theodore Tso a =C3=A9crit=
=C2=A0:
> On Wed, Jul 15, 2026 at 11:00:54PM -0500, Nicolas Dufresne wrote:
> > In V4L2 m2m notably, there is a "job" in the background, which allow
> > to safely (at least this is the theory) chain up work, and
> > synchronize against pending work. But Sashiko (and other AI) seems
> > to not get it and state with confidence and long explanation that
> > the drivers are racy and should do X/Y/Z more on top (and never
> > blames the framework).
>=20
> Is there actually a race which is allowed by the framework?=C2=A0 Or is
> Sashiko's proposed race actually not possible?

Not that I'm aware of, as long as the driver follow the conventions. A typi=
cal
occurrence of this is when Sashiko suggest that you should do an extra work=
er
cancel after streamoff. The framework already ensure, through a job wait
mechanism, that there is no more active tasks. This allow chaining this wor=
k
across workers, and one really done with the task, the driver will call a
function to finish the job.

Though, AI is also fed with code using the framework, but not the jobs. Ven=
us
and Iris from Qualcomm just leave the job running, and manually tear down a=
nd
finish the job on streamoff. So when AI use that as example (or thinking mo=
del),
they conclude defensive coding is needed. I bet that if Qualcomm Iris/Venus
developer where to review other m2m they would provide similar reviews. But=
 they
will likely add words that show a certain level of uncertainty, very unlike
Sashiko today.

What happens is that developers endup producing defensive code for cases th=
at
will never occur, but it can go as far as refactoring and putting in place =
extra
mechanism that are simply duplicate of the existing framework. So we receiv=
e
more complex code, with convincing comment that does not reflect any real-l=
ife
scenarios.

Now its not a great mechanism, since its easy to "finish the job" and keep
working, which can make the driver code run concurrently with a device_run(=
)
from another thread. And for multi-core drivers, its easy to forget that th=
e
framework does not protect anything concurrent inside your driver.

Sashiko is just not doing the teaching that is needed for new contributors,=
 or
for experienced developers handling slightly different type of HW with this
"problematic" framework. So if someone up for designing something better an=
d
porting bunch of drivers, that person is very welcome!

>=20
> Or is it a case where it actually *is* racy, but it's something we
> really don't care about?=C2=A0 I've seen this happen with KCSAN where
> technically it really *is* a data race, but it's actually not
> important --- so we just have to mark it with the data_race() macro[1].
>=20
> [1] https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html
>=20
> This sort of thing can happen any time we introduce a new tool,
> whether it's KCSAN or lockdep.=C2=A0 It's not necesarily unique to AI
> reviews.=C2=A0 In both AI and non-AI tools, we can have developers who fi=
x
> the problem in the wrong way, or where the fix actually makes things
> worse than the putative "bug".
>=20
> > This is why I recommended not forwarding the reviews to the linux
> > media list just yet during the summit. Now, the tricky part will be
> > to find time to try and help narrow this down, I never checked the
> > implementation, but I suppose you can add more layers of prompts to
> > force into looking deeper ?
>=20
> Has a bug been filed with the Shashiko folks?=C2=A0 I can imagine any
> number of solutions, including adding comments in the source, or some
> kind of marker much like the data_race() macro to shut up KCSAN
> warnings, or __attribute__((unused)) to shut up gcc or Clang warnings.
> Yet another solution might be to add some kind of a AGENTS.md file in
> the explains why a particular construct is safe.=C2=A0 Personally, I
> consider it to be the less desirable solution, since having something
> inline in the sources is likely to get out of sync with future code
> changes, and having the annotation in the sources will hopefully be
> useful to humans, not just AI bots.
>=20
> But the exact solution is going to be very specific exact warning and
> why the AI bot thinks there is a problem when it really isn't.

I believe this have to start as a case by case. Perhaps if we could mark an=
d tag
these on the web UI, and once we have a good collection we might be able to=
 see
clearly. At the minute, its very all over the place, since we are getting s=
ome
patch witch don't always cross-reference the reports, or may be reviewed by
other AI. Its all very unclear and variable where and how the issue was
identified in the first place. What we get is code, and sometimes wall of t=
ext.
We need to organize ourself a bit more and have clear communication in this
regard.

For the teaching aspect, that is too complicated for AI at the moment. You =
want
this toned based on the submitter experience. There is judgment to be made.

With AI, I also keep a reserve on how much effort I put to fix things like =
that,
as the models evolve really fast, this work might not be required in the ne=
xt
update.

Nicolas

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0	=C2=A0	 - Ted
>=20
> P.S.=C2=A0 There was a recent thread[1] where using Clang's context
> analysis resulted in a false positive, and I think it's instructive to
> see how it was handled compared to false positives from Sashiko.=C2=A0 We
> had a discussion, and the result was two pull requests to LLVM to
> avoid the false positive.=C2=A0 There was no complaints about how the fal=
se
> positive somehow was demeaning to our humanity, or that we should be
> accomodate those people who want to ban the use of static analyzers.
> There is something about AI that seems to trigger a different sort of
> energy, for better or for worse.
>=20
> [1]
> https://lore.kernel.org/r/20260712165610.366474-2-timday@thelustrecollect=
ive.com

--=-vNfo8YD8KuhvtCjCItm6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCallFDgAKCRDZQZRRKWBy
9A88AQC3ulMMJRaxvdmxyfDy5ToqVD6uFVd3StbBWuI/r4n2NAD+I17SVS6qE5YN
ySeL2cDy1QgG5sGpcRS76uFEzICIzQU=
=OjMC
-----END PGP SIGNATURE-----

--=-vNfo8YD8KuhvtCjCItm6--
