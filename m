Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABD317177;
	Tue,  7 Jul 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420234; cv=none; b=qXAMr5gAoL8mW33skW6rKN0kLcK6tQYRMnEd3oHF97Q+wTe7m2CdYq/pl9SDSLRkxvQP5IZHDV1Cn/NQAhIvmhSbKOmP4InwG7lpNDm5PCG7se+XAwxzr4nN8iI13TSqvvQyGYJXPicEccdU8Cf6lJBsCTAUZV++IGfV9YDrp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420234; c=relaxed/simple;
	bh=P1LPUyfTT6UNum5H1lPiHnGnvr9XA7zAn97Ggh5udtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X70dvFV7CSDX59JrQfEkNYIaX+SOSHX8sc7zKwbQIXZ05NtbPJToKTLHwHDUXRKm5NMypJOe7/EZ4rBzFvKpmHLw8MVzxyoMXYAoHufM4cm0Spzu8zAT/yec9EnsN4SO/9LI4q1zB5bO80MjXrJuxkauEVX+ddRrrGnF78A2U+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG7eHL4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG7eHL4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ACB1F000E9;
	Tue,  7 Jul 2026 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420233;
	bh=V27VjV4O2guipQj7TJBil7hD2n4t6eT/HIHVLroM7DI=;
	h=Date:From:To:Cc:Subject;
	b=fG7eHL4wb5Owayi0Cvoua3RnstPq3sZeo/FUyxWFjV/YgUgZZSakL0Nz9hbV61BAN
	 NQwREMGsOFA5XXGvXXFKnmms+6lgk51XOsA9xtP7cS+kPzhjG+VhksHtxCaZRI+9HX
	 XEC98Dt0afBO593we0EniHIDr24XJL2mpJYif5doMg6k1aU7HQPlAqaWm890JU0hcy
	 aefQJdk29gFbSBzyNHmC8OboBt/CUgdYZDeh0aRYKtT2sN3maowMr+fdziSMfvFW10
	 adb0Wpv4m7G7BQAqs1A87E2gC21GqWAhm2xJVzQWU1WXG8UBjlAo7xS321VBDv3yjT
	 n7eTfSAxgwXOw==
Date: Tue, 7 Jul 2026 11:30:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the bpf-next tree
Message-ID: <akzVRW-FyZ8HCDdx@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8+9Np68LcNTiq9c"
Content-Disposition: inline


--e8+9Np68LcNTiq9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  83a93e3b80bd3 ("selftests/bpf: libarena: Replace leftover st_ prefix with test_")

is missing a Signed-off-by from its author

--e8+9Np68LcNTiq9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpM1UQACgkQJNaLcl1U
h9ALQgf/foItRvZA/3Ri6vG1+O/n1a71wTFxutjBdm8YxgWjCXWDi2u5MTlKxRh9
4h5nslBeD2UQ4gHy0gM0MFHbZR7lQ3UyERXVRiXacLJyXjBhC4BxpY4BLeAqy7+f
UbC4HQ0kQS+ylxKLEILBFdSwrUvWK74f7mEyeYiBjL+6SFofqwBxuwaV6TZsAfEd
xjlRCDd/7TM9v8GKaapz8besB7g5VkFeIGgJPfCnPMDbf3p9EG4yoCH7FtOeF8Ia
jKuNxiPZ8M31lIyWb29HMvQFpOxsYmAuVr5xY15mXg9odIsREnmCgCeSgKnxKzia
s7vQHZBwMPfd0QGWgE3Uv0cYkd6OZA==
=8LRB
-----END PGP SIGNATURE-----

--e8+9Np68LcNTiq9c--
