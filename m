Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A54AFE0A;
	Thu,  3 Sep 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444665; cv=none; b=MqLcQVxCNqwRGvnBVHLoXRz4MIvKHAPqW9MSAnvDwotu4qhFYVritNQ/D8sYGL7SGDZerTDnPpRrW4bgZfYj+UgrmPkArdM6GH2O7rW90wNSYGaCYNmT8cJgV3H+NFOItBV2yYKOcQmYICCh7Ii9BvhKhA/5cRM/7JcdOujxbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444665; c=relaxed/simple;
	bh=+d+bjC4x0lbjpgAmyrHEGnjV0aNXaFhqAikeqeRAa4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N/MSE56N2zPsvWFjBH2mgvuW9XebU5rpK3r28+zAkLzWq53mPnZBsNBUOwAilmxDXcLqu/8o2n9GLFCOTTK1NXGopGrhkp4NCtKukz72qZH4lI3AGLCnixbmMSV7gDBnwj3ygA+c2QLQD1k5H8g2wAapIYhOkecxKNuHDNDn+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axPgdyqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axPgdyqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F0A1F00A3D;
	Thu,  3 Sep 2026 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444649;
	bh=ZZJEZYPm8MBCp2p89iEXjKw3ibTfDOJb3HE6/QLyx5Y=;
	h=Date:From:To:Cc:Subject;
	b=axPgdyqEKXlrfIbsBTwLS5DeTSys/z/G7RUW+k4VQuCMRKUFI697tCvglZxpE30No
	 GkpwTnkaF+XwMKsKfQV0QpOIAHe23D5QcKAc1ophLLPL9xdqY2qKDaGvYz2aJ9WmH+
	 A0DhWLLwyORZDX+M5XMDO0Q2pyEsOiG6uRy6PZ1wwKZ0vXhsKkACYp9RSTs0U16o7O
	 RV1RDdEJu6249otAzpQWJCs+s9MpesyipQJwYi5143mx2miBjI9pv8v5UCJqArhDuK
	 t/qmYyuLA/M1UMppRKtnLfX+MHhBVnKY9qNb1fCZ8+TvyL44T2YbRSBZMY/k5aiEZT
	 m3GuJM6NnPrMQ==
Date: Thu, 3 Sep 2026 15:10:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <apl_5AVsAYLjVX5C@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ei65IbMqjqK5SCjo"
Content-Disposition: inline


--Ei65IbMqjqK5SCjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/backtrack.c

between commit:

  e3e4f66cc4b72 ("bpf: backtracking shouldn't clear outer frame R1-R5 for c=
allbacks")

=66rom the bpf tree and commit:

  5bbb242c08590 ("bpf: Handle R2 as a return register in precision backtrac=
king")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I'm not entirely happy with this resolution but I think it's OK?

diff --cc kernel/bpf/backtrack.c
index 47282ffeeaf94,653db80bcc47b..0000000000000
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@@ -533,8 -538,12 +537,12 @@@ static int backtrack_insn(struct bpf_ve
  			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
  					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
 =20
 -			/* Sample the return registers before the callback
 -			 * handling below clears R1-R5.
 -			 */
  			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
+ 			r2_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
+=20
++			bt_clear_reg(bt, BPF_REG_0);
++			bt_clear_reg(bt, BPF_REG_2);
 +
  			/* Backtracking to a nested function call, 'idx' is a part of
  			 * the inner frame 'subseq_idx' is a part of the outer frame.
  			 * In case of a regular function call, instructions giving

--Ei65IbMqjqK5SCjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqZf+QACgkQJNaLcl1U
h9CnRgf+PvXoNtZE2tNRIPZoZN4iHF5zEoniJpjMEYOQ2E/xYTA+49p0bw7ucxFB
zXD8MRSgj8nvHNNaLURov3Pumj81tWNy7gZzeM47MmMdQTZCo3fkoUyuU8bKVRUo
Q3erVBrlpSrvaXv/3mQ2YqZmLklRLOLyVXSE7/cjjvfgh+fjZQpaJIDnwt6WcNd0
y7qQdqDFaT4NCzPYhjiCrH4vBoxI4jY9ybmlo3kbR0uXlQC+AiGHrIgXKKQsvww5
qrkA+pi+ATLUGy036Xg9NpoMw1nwTTUoC63AxwwHtRgoyX5che4MpV6Bv6EK/69V
gVJsf7J84IJA1sr0Xa+VS3eLBr5r8Q==
=2M/o
-----END PGP SIGNATURE-----

--Ei65IbMqjqK5SCjo--
