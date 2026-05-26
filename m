Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5913DE452;
	Tue, 26 May 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797594; cv=none; b=CyRAzO1KbtS+pTgamjZpOPNV2sAX+iOhiZbAV8nNpfxtoVysKdoxnLQRSPswh6fpLwVx3KbEtBddCjprAZBp2x6S+If823v4z49WLyRQYJ6N5OmPdyp3mWLyvEI4sGroK71jDdaX4qkSY5a8DTqhUXrK4GehLycHblni8kGHWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797594; c=relaxed/simple;
	bh=xdZ95vC7Fq+5QOpWFwACtL945TcKENWkRlGQAi3Pqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c07BkhLhVjplTx60So/KqxmqU+7ptx5D645viAf06q9mQPC0YQi/jTG2ra5AiboIjmfdMmPpA+lDvTqMYaX7gE0IFyKiudGVmI69lKL6e4snrGjv0LPjT5r+DKdvh9rUDgC80U9kN8UatFZiGHBwYuNfPQ4zNe17Hw7v/cOmcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBN1jLKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBN1jLKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D71F000E9;
	Tue, 26 May 2026 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779797592;
	bh=/PlMCsG58Og/BWJOZjzosw89h+7oCgPRyFVhhD89mOI=;
	h=Date:From:To:Cc:Subject;
	b=MBN1jLKQCBE6osvlhdtm2gMvYGTR31Mgw0Yp7GGqU+Zs/I1YW0R+dAl3oP1a2XowY
	 fSPytVz0WjsDArx/y0bM6y+Jqv4gYgpAy6kShRwXt8E9xsXGUieeyPdYgDmN/sJBWb
	 ioGcCp+AsU0gCgxHUg2ZgYLe0ZjiCJlRa/OtnCxjeDpqFWsAF8f4+tYMnKYEOW5ngi
	 RjkEt4srnx4jzatcU6VXLp+HQxB51mhwcO8jmVsF0AseQt980u3nOiciAtlfnsl8J9
	 gGQhG+K57EFQUMeCM2Bn35K95HQsB9RghNlKXTNKNgtxyAAhbgQGvsG7l5/Au8OqA4
	 GJG4D6RswMEiQ==
Date: Tue, 26 May 2026 13:13:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ahWOVFZZScPjm2Ow@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9IyIlIE3sgCOvARk"
Content-Disposition: inline


--9IyIlIE3sgCOvARk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the bpf-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

/tmp/next/build/kernel/bpf/core.c:3379:13: error: redefinition of
'bpf_arena_handle_page_fault'
 3379 | __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/next/build/include/linux/bpf.h:9,
                 from /tmp/next/build/include/linux/filter.h:9,
                 from /tmp/next/build/kernel/bpf/core.c:21:
/tmp/next/build/include/linux/bpf_defs.h:12:20: note: previous definition
of 'bpf_arena_handle_page_fault' with type 'bool(long unsigned int,
bool, long unsigned int)' {aka '_Bool(long unsigned int, _Bool, long
unsigned int)'}
   12 | static inline bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  dc11a4dba2464 (bpf: Recover arena kernel faults with scratch page)

I have used the version from next-20260525 instead.

--9IyIlIE3sgCOvARk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoVjlMACgkQJNaLcl1U
h9DQlgf/Qig5mKcOhHHXLfl4Pmy3pnzesly2426k2yGQRac+Onu751S42w8jdSYd
dx4sT0+FWhIxFt8sHJILnqOxyfgZDT3RTJmOYahCRU8Gbns5sycCl77uAE6EWhUP
Kw3QFrNORAuMfqkrYy7JrblJwK2MDL1X9yzMXmUMaWUFWCclf7UqeWk5PL5c608N
wrV1wvEyaLVf+bJx0PS+gHj4rsxc77bXjJT2D5+AxnadOK17ZE0OdpW2zOkMw9v+
6xXd0ADyikNOuwhst/kQsmbSMrsS8Vd6fYSk9CaGfvZ6Py4OB/wRnK3jdE9FHKe+
I+9uonfnxb+PEv6fKWEl3DCGae+aOw==
=QxUj
-----END PGP SIGNATURE-----

--9IyIlIE3sgCOvARk--
