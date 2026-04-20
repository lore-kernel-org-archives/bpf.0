Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6045453486;
	Mon, 20 Apr 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691826; cv=none; b=CzFPy2fd3x4oi7qPrUuPDZdCtIi746MDlpEdNLh8tbJA+rfzlPWBVTLpjozIKpbw7keSkHGdR2vESd/NDKu91W5dXVwIgq5N/a6i4I8+YykXWRgugx/L9L4k6aCs4wGZFDBZ3aYMwgaBIOouJcCVKExGFEcDKNzOUANYKZgjISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691826; c=relaxed/simple;
	bh=L/58En988QmmCaBLCZRvmbPjePNZOnui5+m9HBfS7gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSJK9oTdxY0E709oqEsMzfuaWPdgG1VVBDzGIXrcZBJsdYlXSQVkj2U5hFjNFjHmkhqzvsh/AgGe2//YZdhuCboJpJFmmLjhNOonioDK1reEmw36C4L52zVRShLyDkuHAVoQHZV6a5NlSim37GwF3qpZy3DkYP8Fv131a33oD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcguvl/A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcguvl/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4AEC2BCB9;
	Mon, 20 Apr 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691826;
	bh=L/58En988QmmCaBLCZRvmbPjePNZOnui5+m9HBfS7gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcguvl/AarLM2AHKJ3iyxX88ZyvlRafcBxfVLtq6cXmLwfPc+4pVJzhhFL8Uk2ytS
	 NJhXBFVi9VuR+f9e0cTnCQzD4kXyhyJjc5m41s8yk5bYXBDmMPkSrgEh9dkbKHC5yP
	 YKbSPElvDplcd42TrjmBlyjsuxmbF2h0NUDGaQDacldJzh56sYFRe+NspgNQ5pADru
	 hH7xa2vkG/JAywciALI4vl/IJnSPije7/CXv4q0g7pCVDQxIBugo3oGkStCf1eXLGA
	 cxgTDl1edq65I9szNte+ttK91Kyd/FzstOf2djQ1EkpCiBrQKEhoh4wNQBE/zo8wdW
	 ENzaWEe9G6DtA==
Date: Mon, 20 Apr 2026 14:30:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
Message-ID: <e7533bfa-4b37-4167-8819-5ce1208c3756@sirena.org.uk>
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13>
 <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
 <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
 <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
 <CAHk-=wipMj+0_Wr+LTqYcZ2jzpxTDSMa9Y2HsMp0V22C6jx0hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0jrk+CT10LC6BZVA"
Content-Disposition: inline
In-Reply-To: <CAHk-=wipMj+0_Wr+LTqYcZ2jzpxTDSMa9Y2HsMp0V22C6jx0hQ@mail.gmail.com>
X-Cookie: Please take note:


--0jrk+CT10LC6BZVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 10:16:29PM -0700, Linus Torvalds wrote:

> Apparently nobody actually runs linux-next. I knew it didn't get a lot
> of testing, but apparently it's more like "no testing at all" than
> "not a lot".

Looking at my own results this doesn't seem to have caused obvious
explosions in my test lab for whatever reason, and the KUnit tests that
run as part of the -next merge didn't notice anything here.

It does look like this will have overlapped with the kselftest issues
which have been messing up a bunch of the CI systems in ways that fell
between the cracks of build and runtime testing:

   https://lore.kernel.org/linux-kselftest/20260320-selftests-fixes-v1-0-79144f76be01@suse.com/T/#mecec7793b0e4c8f316a32600f48835479cf056f3

which severely impacted the coverage from several of the CI systems and
took an unfortunately long time to get addressed as a result - runtime
people were seeing it as a build or infra issue, but build people
weren't noticing since anyone specifically build testing the selftests
would've set things up so they wouldn't have seen the issue.

--0jrk+CT10LC6BZVA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnmKm0ACgkQJNaLcl1U
h9BqmQf/ebeAmtKfa73Z5gIktl6qYnX1N40T6uedwDLT9Mn8O9Ivsn2sUIeRl8nx
VRg7YLqct4sBHMke6/GIn1UYXyhRrl+zUArq0KkJUsBQmIThtYwo+6SwJpCJYeyM
W1EAQvvUBIWHJoW5Qrqe8/bmf+uWSNBQgzEo+RmagIGURpVpm93dhMiMwp+WJ31+
7KtmdHjgHqy9g3E0XScJwGvQ4ip/nfF5XX1Nv/6BoA4EzqOKGNXde9ZVkXfR4wGN
h2HdAUU0DTegYgVxr6goPhmgoMCVjjSmict9mamYQMultr2Cs84DgGMhw0PLPCDy
a9nO8R2I5Fgv9zqggYbP6OaK20BhbA==
=/TdP
-----END PGP SIGNATURE-----

--0jrk+CT10LC6BZVA--
