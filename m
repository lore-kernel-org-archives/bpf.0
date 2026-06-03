Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F2D0625;
	Wed,  3 Jun 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490561; cv=none; b=iHq1TAVvTztI4C1BGf74LmXepCaBnPFvOSjUWXXn4ym3GD8ss3DdkL9isnlZ0vINWUg4o0AccmJHa0C+q04UVcKmd8GIQvayLM2ExmP1PKzy7aVhNzwUBuhADhfpdPqYHXujqr8nR3NA8GogA38DtdG7nCTDNNZLw4ctsD9O2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490561; c=relaxed/simple;
	bh=BqqbVz39eZcGieDH4S9GcWuFlvyiwFN5lfWUHYEmdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsLKqUCcVWXbPwqDPJokszFdVeHfPHoQEon82SzEf8D6PT43ObwE/RtFr9EYma/q9pwUrQNqTGOC/4ETQXrDyz3jBIKwOvHhxTJGw8AK37DLh1BI60NR11zGIAjXNjmRPwZwFlnxU3weZvLazNsF53f2c+/zCRjbzWwPZj5i5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEBwaoEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEBwaoEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45451F00893;
	Wed,  3 Jun 2026 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780490560;
	bh=BqqbVz39eZcGieDH4S9GcWuFlvyiwFN5lfWUHYEmdEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEBwaoEZsTb5MZH1vuW+kAdocIAVYIjbNZgcutswOTN4EcvEClG214+XjFo0q3wa9
	 WIv4DqL+k/7EmI4Ff5jmIscIFWfCWxKhEImcvlCzdDIJKRwbhMsee9As7truZAqmLg
	 Qag8mHYP6UCWuwAtoJdTPyZI4UJGPvwP2Eq7w35dx8SKgjQG4zBw1D+BY3tBonzs8w
	 zzpMTJuC2lY/Tdj5s3Rfr6YFUJtEDBdlnsQPhgwpFZEYyhKTgmrZ/dM58MIhDEzFoa
	 cm/hookOcu5EH1WuQLIQt98sH91Wv9WHwfCEyR2o7WAPMp9kbl+XxDWmx/iVaIf+jy
	 AtHAtaLt6yoeg==
Date: Wed, 3 Jun 2026 13:42:34 +0100
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
Message-ID: <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
References: <ah8BzqSmZO40xYhS@sirena.org.uk>
 <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
 <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
 <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nGNcFUm9tdwcZ7nJ"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
X-Cookie: micro:


--nGNcFUm9tdwcZ7nJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 05:45:04PM -0400, Paul Moore wrote:
> On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > Can you ping me when that goes in (or things are otherwise resolved)
> > please so I know to drop the revert from -next?

> You shouldn't see a conflict with lsm/next now, but if you do let me know.

It's still there today, but seeing Linus' comment about not merging
hornet I marked it as BROKEN instead.

--nGNcFUm9tdwcZ7nJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmogITkACgkQJNaLcl1U
h9DVGwf+NVc0XMabqCVzDIqGd1+DP3DzTxEm+ofenacTy8/+If3rEcR2qZtfmzWW
rcTGpT61iaArHexoWu0FmI9qJ6ValIZwwC9ZCGQJg4VtwKnwSqHejO2zFQbkXR4C
dRX2j1opZD6otwv5LT6t1ePqr9c+/wXW2U/5DjuQKZyKNG8wfUBIO0zkzTRFbNwp
vvMCeF7GinBvONyTuqPNun4N1czjHY3n8q4vGvfeA7BR7D5uqRjO9n86aS96Tkb5
i9olAglQdKrGVOUUc82ibYxYOs2xSP2f2nZR3i7X2ccuf6hmp80Gyd9VYKKlqOao
LvXaqDQ4Rx2ujXnE8bnyohG8zk8UJQ==
=AYFE
-----END PGP SIGNATURE-----

--nGNcFUm9tdwcZ7nJ--
