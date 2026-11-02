Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628520;
	b=uev5ROoWPnYSwaVqUanWyIbic0i0x/BkC68clgXy7z+8FN8ySbROI47b/eDnX9QWQnt7
	 2p79W/5oZJle3yHfyNgyYa5usqJm2Ja2GmfjITgjMO2Nrojn1pQYf3pUsCrkNlm6vep7a
	 NuTbuDp1sJ89Uc+4sZrUPBJtpZJnQHQG0BX7R6kunFNd0nnP33hTEEyv1aEFxTpdbuzXq
	 /uAIrFfRbrFg6O8Qt61S+vTXygGL6WT9F0YUFtiNguN5WLXQiwrdgTf5YEH27vb8rBw6T
	 CggmtnKA1uBXmoEcptao62gKTDn+oJqQFAvcjsWgivVdve7feL0vHu7iYNs3xuezrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=+aBypL6dTRQngXP8lrpR9n29mZ+faRZiRjbSPzxb8tI=;
	b=S1sczNdI78qe3ZpAgqdvBwAZNA5hzciZPVOj8NFpcuDJZjdtrbQfgATglqnNXQeMr2f2
	 bjCbFA6atjN5u3TRiuwJiYQYHeXcoeV6E3x7XokSqo5gFBqfJUZb6PbGAT9XZGLgGs2SZ
	 DTOnKzNKyEwQ6NgfBMFtuBuhzwTuSSifSO8V2EV8RmawD/TRDO7Cuo6UkeVoSCSg1BWXG
	 dEF/es8syIxz+BVwzTU/Chelrs+VK+P3c3jhaFj6emIb82i1diHb3IHr75WUyoRozm0bS
	 7LCOVfvJ0a2qakabe8qB1NufdMz4rhXA+P1HW9fGIJrp0saJwa/79tUKrHgI5GaMExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbHYCId8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB649606A326;
	Mon,  2 Nov 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbHYCId8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3781F00A17;
	Mon,  2 Nov 2026 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628519;
	bh=+aBypL6dTRQngXP8lrpR9n29mZ+faRZiRjbSPzxb8tI=;
	h=Date:From:To:Cc:Subject;
	b=LbHYCId87toupimJ8yFIvEarDNau0+Wm1mF6kFtse0IbY3lxPpHd/yI9g2T31jDqt
	 ITaRT481SJ9gF+PlnDxcyatjcUmOikTato42J5c2hfSi5qeha1GB/2Smm015D3OjVn
	 oAVQFNdjdaj+j9Thr5erVAE51vLHHmL2w5R07TdyA91Tt+cSKi0ubQ2Aihsgg6kbel
	 xhPtX4G8faR5EXc153I7NNQ0OxHNqiEk8/l0wlCOME3MAri8TIeBnHc4XsFSLZkH0Z
	 m1fVAidGovsR/yPO89Iy4Afw5m1gwBjGCl3kG3tsBrBF6ItpvSzJHEjnelGluCq7eD
	 vFREkqqHXPJ9A==
Date: Mon, 2 Nov 2026 14:08:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the bpf-next tree
Message-ID: <auiZYnNYLEgcR6TT@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkwjSDYh2aF5NlZk"
Content-Disposition: inline


--wkwjSDYh2aF5NlZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  b73855c31c7be ("libbpf: Enforce program limit only for loaded programs")

Fixes tag

  Fixes: c9b2a0975c39 ("libbpf: Reject excessive program counts in generated loaders")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--wkwjSDYh2aF5NlZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmromWIACgkQJNaLcl1U
h9BxSwf7BzEHGD35ZV1PCUyFainmKf9svpXDsXx+SaiU8mYWORbWGurMf6iRWMQI
5LTkwFrl9/mRoKBxcZTo8qJtEmt7xyIFEHcooQoQaDc2M6sYgR2Alja+0l7n2nT4
HFJgL4ANd23gRf5qoDugHxNxcc6K4GOKiKnprqX1sVhR7NcDGY9N1ldVrBNviyuE
M8VOZ0A1o3sxwDWpIH4r5X57lJIjm0wCMbw7iNlgzA7q8PlGr6w6QFReYCo9yhmN
kTtdNXJmmtGTzwVLpV86Q4KxOq7qiDaZ7XiOm3agNeqZIuqQO/Ljcc9AuR/8TnuR
XaRIC4KVRzfryR7yH/lgNjgl7H7ciA==
=3PmE
-----END PGP SIGNATURE-----

--wkwjSDYh2aF5NlZk--
