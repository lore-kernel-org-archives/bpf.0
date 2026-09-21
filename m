Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBF45D912;
	Mon, 21 Sep 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984170; cv=none; b=WBzTLMrtJTOqnTi0h+16lnDARG+UpA+twCQl/5UZsyw7QpjPHajsMbpzTBvQ1O6UbfvC3suDfSSxyIxLsO932pvQhmuOK0ViIFX9b2z4/vFr74s9+Z2CRDAMNEsyFiIGA65pA0u/FIZiqIkNZCTYloWicyTpFOnvQA0o7kc7kKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984170; c=relaxed/simple;
	bh=HBsA9PM43GuWZO+qfQBfYt0z5BjFpNX/qpgO9J2YFuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WRaWCqZcPh9D1C8LQckas5b3lwxSCoZ9Jc6k+68L+1oTuUh32im4gBKfXVao536oLlyF4FgwHH97fSvEqkHwetzGG5vKpX7pKvI+JHIH6z85yBroH+BYM8LprczYROa4mDmTyRRyOM2rZo4qy/TszrAwQ/CEDPFkR82CaN1Jfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Nq7CGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Nq7CGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED91F000FF;
	Mon, 21 Sep 2026 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984168;
	bh=L7Oq+XJqX0LzSIGBwuR1yRjmlCpODghQmCE1YBpzvP8=;
	h=Date:From:To:Cc:Subject;
	b=L4Nq7CGWPnWEOIe3JljlO3NzmADToiH7NKA2Jv6c484u4F1wVvbxE5ydcsqZrTsA9
	 EfLhu2LBAYz7Pcxiq3LZOqKwDJSsMfLbNfNlI+VgRshwd0fdJ3Vrld7yfqosbNtbPG
	 jH8KOHoFrNxKndeaotAAbjSQ0M1gOs+KzsUgES35k/Ba93uSOhhj1Hs4CPCP30CTn/
	 sEfZfoCtElv5g2ZeuqVYSPFhpHgtPfNAsXbnzoyMLbbxv9BbaMlQqX/QAA5D13bo1f
	 kQLUt4q+bGtK6NgNTVyrvCjlqvvMNRLNNFZRNnzRk85i5/foDhzttvOwk468YTqMBB
	 GxJmwfbe6lqfA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BE60D1AC52F5; Mon, 21 Sep 2026 10:49:25 +0100 (BST)
Date: Mon, 21 Sep 2026 11:49:25 +0200
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <arD9pUBavrJQ8TRT@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gZN7iER2B7tM4djM"
Content-Disposition: inline


--gZN7iER2B7tM4djM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/helpers.c

between commit:

  81c975aae375d ("bpf: Require CAP_PERFMON for kfuncs reading memory")

=66rom the bpf tree and commit:

  3f9d98dfed79f ("bpf: Add user memory access kfuncs for mm_struct")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/helpers.c
index 712dca5a2c5bd,82402d97ce67c..0000000000000
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@@ -4920,12 -5049,14 +5049,14 @@@ BTF_ID_FLAGS(func, bpf_wq_set_callback
  BTF_ID_FLAGS(func, bpf_wq_start)
  BTF_ID_FLAGS(func, bpf_preempt_disable)
  BTF_ID_FLAGS(func, bpf_preempt_enable)
 -BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW | KF_PERFMON)
  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 -BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 -BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE)
 -BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
 -BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
 -BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE | KF_PERFMON)
++BTF_ID_FLAGS(func, bpf_copy_from_user_mm, KF_SLEEPABLE | KF_PERFMON)
++BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE | KF_PERFMON)
 +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE | KF_PERFMON)
 +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_PERFMON)
  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL |=
 KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEE=
PABLE)

--gZN7iER2B7tM4djM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw/aQACgkQJNaLcl1U
h9AFSggAhb2Dk0lPYAKdAuGHjD6ShmhpnW2H8vySrTKhDQJBgSfB2XTc04WiPifh
o2m/zgOtn1Or26x4Tunfhn36vTga+TlrcK+ZqsWRJ6bHUmX9lSauVaDsa+CZDFe+
NpcBuXapYDue3rR3B4Obz4vJHSSJA+1skaTPFDIT2Xc8h4QNUdXQeGjcwpz3CYa5
XImS6fQKnLAbDDMDC8+eppTc3s0j0tjl1FHSNkA8rsnTvhul3Mz0hlicgD2yCmkp
e6Ei8WQd/Uu34+0tK44SV9pO43yHNzJwJa6xvtpunn8juCc+NVzhzgFygckpWk1I
fKXiIAGYXiakQHxLBvQD/O+SQX5kHA==
=acpp
-----END PGP SIGNATURE-----

--gZN7iER2B7tM4djM--
