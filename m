Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56315AA67D;
	Thu, 17 Sep 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657435; cv=none; b=lVPzlwn0mGNGd3xbrQ/M7tdjRmilqcZYv/CRsEs1M8HmyRowLOE/G2qvqWY15tYUdpjpZCgHNbPFnJNKLJXFvSeyLK+Wye+4628m6mtbGR1Effncdy8WDslTiPlOS7Y/VurRhPdyzHkoc0VsgoiyIDInnLUdliyPR4CgM+/F6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657435; c=relaxed/simple;
	bh=Uc5weSts25nZNlldM7KpaVaUrcWLaJtcP6qB/u8woO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLngoxwz4Fn2qIJdG38gShMzuyePfLd9gZ1hNWPv6RRsTBzBm9BjVUoXSSxjpyUbh2V7x+lf+gOgveKx+hehk1C1GUJ1ifSP/RM8uQjB90ZIBjapeKA9mQOnPrzl/cfbs1TqD78WexQiXsAo40WEz4pFokfjEgrd1yaUQdtDNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hti4jig/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hti4jig/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A71F000FF;
	Thu, 17 Sep 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657420;
	bh=Uc5weSts25nZNlldM7KpaVaUrcWLaJtcP6qB/u8woO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hti4jig/GfSMiiM5Hzk+SBZFZJ9qSsa3bdtQfEwTccZLUh4zx0pPulx2cHqfC1s6X
	 0N8vtJ1IVS3LsdEJjarF9fg+Tl59zIJzb7eIcqiHqmkdYRkyOBDlbSmO8w30CP0KSu
	 wp+7bynbmiwuoZNyjKtxD6xrrb7WUobs3txe3ncBaMa7bGc07kzgUst3884ffUvXoc
	 r0mzrSWIhsLUGsp8FjvXYIEKGsR1obmd4IZqaNuYPsVb5RVfXCfqVkrxJJgLcgRUgu
	 3sRG78G1h8QWuVUNqHk8IO67cxprIFvqp+9kx3zhSQPuemP04sAzLdu/z1pnCFEljq
	 MKhea3bxzpF7Q==
Date: Thu, 17 Sep 2026 16:03:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: Missing signoff in the bpf tree
Message-ID: <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
 <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GY2RYStuRZFknsXy"
Content-Disposition: inline
In-Reply-To: <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
X-Cookie: Whip it, whip it good!


--GY2RYStuRZFknsXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:

> > Do you have a full list of the current committers, I guess there's been
> > more bitrot than just this?

> It's me and Eduard, apart from Alexei, Daniel, and Andrii.

I've added you and Eduard.

--GY2RYStuRZFknsXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsAUcACgkQJNaLcl1U
h9AtEAf+Onfe6gqwWMdwGPXS9W/qmMlQ1qDQKmuYCcDu5RvFasCkyZd2NFxMRHoM
pljbsN/XQNcgvqTAqz8uukxJ4s7snSqyPuS8G3Yx7GzMM7gkTkpsws4gXQt6Cp0p
MXRQuBOAonYRDZms3YpNPfaIMOOQPxEIam1oZPbfkt/VeLiHAYG7JPtv9sF7eKG+
vec1aqjAepZEMqZKEUVUXNQHJi4q4qSIUoP+xm81xkztRDNDH3khJNzWG/JHxbra
l4jfPXbuMtm4k6hUUcfKvIOTaqUIewSr7PIFfRa4qlNKRKW1a5BYGFxtABNPd31u
JOj+tfTLcZ+dm96sEOeJFsG0NQ8vJg==
=ltKS
-----END PGP SIGNATURE-----

--GY2RYStuRZFknsXy--
