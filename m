Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D545FFB1;
	Mon, 21 Sep 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984165; cv=none; b=AqH/zTy7nHxGBI0yvYSI9/EV64xopSJdcJYRamXyBNJTmKDoMdjQyydjSgPWbHrY3/e0Yc/ilKB8k4jBsTYsKuT+HVKnR87aRC/srQQJYuexdvnMiJNW9LpM/v1/Zt1QPMORgcTDGCvQsQMvzC/jvFxrQBLaZxZZPKOQ9UDBmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984165; c=relaxed/simple;
	bh=Plj3ubrbq80/5zTNv+zIFt0JV/f2PwbaT0asYbrROl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qW2aVTpoW7TznEIImb2bKK2QCjbRqyMaM2ERWdhHyq9c2vPPO/n4OBdK+Cbk5WurIUWfg5mFakQuD4Buc8uVCkiTX3i8vsh6BxGFqgEGoF7lxmWv4gR7SoduFeZ19yHYZ0whXGgAGdl3L4EmZg9pUJrRbt8ZlVx49PT/07CW5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGe7oLVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGe7oLVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01951F000FF;
	Mon, 21 Sep 2026 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984163;
	bh=qOAymg80ms4ZcX4uHWsep3q5H6ndyNtx30yc62/Ry7w=;
	h=Date:From:To:Cc:Subject;
	b=CGe7oLVlH1/fCp1r6p9wD89LXvRSUqwa47aZjeBub18Qt84rVaFEzl5zOF9oDDAZk
	 /L6uDDVnNmnYkpKD0HQ4w05QYXDvthBamn1RNEDOD2v/XcQNqHANKVO4JX6e2l++NH
	 FkvRstQgk6LLCTXUEQNvGtaQwUUHVKTKxGL/Iocxhi9mNn2ZFNd3Ufkun/0rgYeNdH
	 YWXqSVl+thO6PARVeMK13IaYlDzMejQslweamHi7GnmcEPr6zQuXDqUr/5vWOXqPxT
	 78me/gX9OO11VjIFBy9LsT4ibLkE/ER9lJ3gs//LqhOEwWs4LHJynkeUjNSJsVo4wv
	 l3Wnn92FDsnMA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 99EAE1AC52F6; Mon, 21 Sep 2026 10:49:12 +0100 (BST)
Date: Mon, 21 Sep 2026 11:49:12 +0200
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <arD9mGTj9upScb9t@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9yycvWMy1Ul2gL/7"
Content-Disposition: inline


--9yycvWMy1Ul2gL/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  mm/internal.h

between commit:

  c1b742df568b9 ("mm/hugetlb: localize struct huge_bootmem_page")

=66rom the mm tree and commit:

  69d38c792c53a ("mm: Add copy_remote_mm_str()")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc mm/internal.h
index 3b9fdb826162d,9e3be236f18c0..0000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -24,7 -23,17 +24,10 @@@
  #include "vma.h"
 =20
  struct folio_batch;
 -struct hstate;
 =20
+ int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
+ 		void *buf, int len, unsigned int gup_flags);
+=20
 -struct huge_bootmem_page {
 -	struct list_head list;
 -	struct hstate *hstate;
 -	unsigned long flags;
 -};
 -
  /* mm/workingset.c */
  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
  			    bool flush);

--9yycvWMy1Ul2gL/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw/ZcACgkQJNaLcl1U
h9DCRgf/S6rSqkJe9utzdVZ2ExVllxwc3pAqiY69HWpOGZMGfga4mBanMb8AY+nJ
voVK0FtScwTS3ANByQZkrYs5kDgBNdnWwVvNoYSm/CQmg4kyYzIYDjXAIdLU+LeG
GHO7V2VPf4De6Qk5L5HriEjJRoEgVapdmyhiqxVzu2qLVlzJB8SD/FCXYd7E4BOV
Tem1436FxxrRtA7bAB6a99GORCzN7tWPGao6qIpEDRD3PPtzLARXi7ne5h5AyTxx
OejUCwrDDMN1Fo+Q934+m/hH5sR0Ny1BzTHWIr9RuYxpQdphTmYCfb1CXQ6zkztX
fV2KilrGFx2T9Y3UWHEvvmyRMBtAJw==
=IlkG
-----END PGP SIGNATURE-----

--9yycvWMy1Ul2gL/7--
