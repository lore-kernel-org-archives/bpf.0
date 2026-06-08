Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0933F8A1;
	Mon,  8 Jun 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917938; cv=none; b=b8lb3LkNY5S9zTnMNSKqXcbZT3/6gOFVl00FIO3y2Uwh3rFmi1WleV93UDywQ0njBH0sqnsQLmTQRcMbbTedyRwOhGA4A3qWKCcruaND0rrXRzFodFoPuM1Yz7xqOXeOVgmTBqSxUPBry/tcjC5wUa3QPtqtdRRybJO5o/maBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917938; c=relaxed/simple;
	bh=PHibVA1aPvMnORnxEAGJ6ydDAckRXbBK3UWzckNiOAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cBTSPQGZanMyYBDhYALIOuiGoZDAxFCTMNgbaomxjnurFALPT2R4HMzIKEVqqlq27q+7sV2wxc7LLAdNBnQpsaoSeIaNnvvtEXrY5zVae0Pj5LB0qx5MkPZAG1ZElryINxOr1eIRT0h/vuZX+46wTKNCT1Xt2vAHEW14BBIO8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSSyv8Zj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSSyv8Zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE1A1F00893;
	Mon,  8 Jun 2026 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917937;
	bh=6ihWQBDOdxIWtuk8UtQnP1iFWb3LBQj5tMEOdhOkxoc=;
	h=Date:From:To:Cc:Subject;
	b=QSSyv8Zj4DcRVgToGVHTvWQ9VJZbHZ4SWvU3zWMKgwp8/3YMD8JJBt0w0Fx7VWaCX
	 JSHtmFqYuXGgHwxvMAhqjjNbiRoPL98jXZ2hwjCNA0N/ElJzb0mH+/itM2HOE6UPfP
	 YSSetYviYBHu+Hn9hXBLEomBbYbKTlMtfMZ0lCQowELAYbx7lVxEcjscW7m2jhKi6i
	 azd/QGr3YJY6FMRPi3cbvXwIxUw3GyJF4ANUa576rzy3ejPFJYz6VSYYnDr6QfbINu
	 RmE3Rdw7hUkELLO1TvMrVV7AdoyUy8vdzLC2phnt++Uj+hZei5zCePn+n4bQnjxNSx
	 71orIm3ykVlkQ==
Date: Mon, 8 Jun 2026 12:25:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <aiamrLm8DnCP6dbw@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a+dpSAI2pYQl/UBx"
Content-Disposition: inline


--a+dpSAI2pYQl/UBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  include/linux/bpf.h

between commit:

  9722955b54307 ("bpf: Add simple xattr support to bpffs")

=66rom the vfs-brauner tree and commits:

  aef4dfa790b22 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
  63a673e8a4112 ("bpf: Expose signature verdict via bpf_prog_aux")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/bpf.h
index 64efc3fdb7163,62bba7a4876f5..0000000000000
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@@ -31,7 -32,8 +32,9 @@@
  #include <linux/static_call.h>
  #include <linux/memcontrol.h>
  #include <linux/cfi.h>
+ #include <linux/key.h>
+ #include <linux/ftrace.h>
 +#include <linux/xattr.h>
  #include <asm/rqspinlock.h>
 =20
  struct bpf_verifier_env;

--a+dpSAI2pYQl/UBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmompqwACgkQJNaLcl1U
h9CaPAf/UCSD/dt0ICDkhOZOJItL8b3D20yPyhyRL5EyaGPc5PXUfrpHnFL3zfIL
keo709bRtrS6CXu0r+KyXVwKkmO5AYMczQPOcE3IcSM3WHkRkIn7J8mEYRI+wsdu
2FqmHuZr5INxWHhlT/+LXXLNS/PUKqB7bUXa5Pu1c1M8IAdm5dQ3b8bS2cavgXCd
660w5Oi0hXiYwoTueHe75eHX4FGm4AhJrWvMKu2ZklGZ2wnEokQvx+87KinO6SBv
IMaUwMxqWeSj5BKGlu+hEdNV2VVmqt4CnYBDdGyczsH05bXlIGrbLB/GhM6h5aMI
wxQjJfXnd6rSwtWDcNU5Gwtmphrusg==
=e7Yv
-----END PGP SIGNATURE-----

--a+dpSAI2pYQl/UBx--
