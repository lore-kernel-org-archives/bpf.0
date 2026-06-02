Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405553A759D;
	Tue,  2 Jun 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427794; cv=none; b=VXL5HIqA9upNOvY+yU3kMT/bHF/ACkN/PD+oZCf63XXLXvGxR3PMAeQiczCQmCQ4uM3qUTyS5Bq4A4yPwfmDLMnrUnOiSfMH4BFkTRC57wzFDbeS+IAq6bp3EbuoVmBMkHMYbDmi7Utw6Rek1KMT2GseQlazAonExXDr4+W4p9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427794; c=relaxed/simple;
	bh=RK4f6BtjDzKYLFDOPP5GGz38kUK7c2d/+K3M9nfEZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8gkB2h9zueMKVQ7k63cbiOK0HMv9EV2X7ZbBb2AVWAeLADjHwVgT+17y5MBtOABgDWTjiUqCJVvK2tayX8JPhJatfOHnpXm9p212/Ze7sY98KXfRxPrUac+rUD0KK4vF0hlkOadeZAXvO8lkalouoIEcCf3x4hEYfC8cAdguFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwTmjx4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwTmjx4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BE01F00893;
	Tue,  2 Jun 2026 19:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427792;
	bh=RK4f6BtjDzKYLFDOPP5GGz38kUK7c2d/+K3M9nfEZmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FwTmjx4a7p0hG9bM7SRWuxMui/8/RECpaUiuNSLV1wcYg5PHmXm5LhEvlA5hmCzrH
	 8joRF42jLONmi/PAD6VtcP3+IfQLtsuSDUUgjh630DJa9sz7KznKPLNDc8LzvNWBwi
	 39AdFFJvxy2TVxYbuPvD/AL1i08CWFv1FeI8oTeB4VbD7oVO1XpzljdGtGsNeSVenY
	 3XpsCUy0m7qVcgjxqB6K3602LJZK/AjSmgVSdKxcQpVrJSnt7ukK1VgSGQUxgrU+NZ
	 ZL+JAGm2XikJuLsVxmM6ZuHQK1jcjbQm1gl2hYrqPH+EcF8y7CI27Om1uxXa9jB/MB
	 78K15XxKUMhCQ==
Date: Tue, 2 Jun 2026 20:16:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the security tree
Message-ID: <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
References: <ah8BzqSmZO40xYhS@sirena.org.uk>
 <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gJBBxMN1qR4w9eUu"
Content-Disposition: inline
In-Reply-To: <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
X-Cookie: The wages of sin are unreported.


--gJBBxMN1qR4w9eUu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 02:40:12PM -0400, Paul Moore wrote:
> On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:

> > Thanks Mark, we're taking a look at it now and should have a
> > fix/answer later today.

> Proposed update to Hornet, assuming this looks okay to Blaise I'll
> merge it into the LSM tree (and either pull in Daniel's patch or base
> off bpf-next so everything builds correctly).

> https://lore.kernel.org/linux-security-module/20260602183658.161744-2-pau=
l@paul-moore.com/

Can you ping me when that goes in (or things are otherwise resolved)
please so I know to drop the revert from -next?

--gJBBxMN1qR4w9eUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmofLAsACgkQJNaLcl1U
h9CXcAf+KmrjLQrivnIBphNnwxv3wp2CKbU4uR0fVcfqzGVuft0nqrY5q608mv10
4bfwx+FKHKuEG3gvaf+bE9TjbCKeazSo5poZGhX9EZ9d6UNhqrzJqK2bn1egi0Vs
7wb4nQW54X12NfwNbDYY57liRU0mn2qx6k+KgmVaEqjDucqCUHPNx3XdmNb/sIn9
Bvdw8kFlf24o0YOl+caL0zpNcg3B4rNPm7lUQ9Fgkq9qZOOX9qY8GWo3NtlfiM0V
spi2hPz5YK4m+dVYayqwRAI+05LoId65K8qXwJ2d4ZbPHv3MppmpQCXgKsM4XiQw
50YHcX4RdSHAsg0KVMyu0YNzNPqCrQ==
=ZWeW
-----END PGP SIGNATURE-----

--gJBBxMN1qR4w9eUu--
