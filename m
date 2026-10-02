Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB276468C39;
	Fri,  2 Oct 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980762; cv=none; b=kc/a7DLhiajeWGapuR5OcATqXqzLaVyzHjCElC31d3KqRjpnan8EvtTJmISw1lYMIZ6KyziTyXRNFp5TmSRRkDyZU9B6gJkMG7k09e/5t3g6JJHFIBryLrrHtFw0Efi3c8jFnezt04LkkXHeMPWPL2Gmu7wfPKTk6ZMS9BHweBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980762; c=relaxed/simple;
	bh=aff54SkfOpRZELXWz1ZO5FT8/qsLMdKvC9ndE29XUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ryRi5Fd6mMdMydr2Y1SMRJWzQ+pyp4y34vg8uwEfTnfqmvC2lNeCUl9lFXZLAynbNfOeEaDRq1GosKx+iT06PSub1LyTYuMaZpgr3kXSHScSfJ7vrDILrbBUfKRvs5odsZPoxWEL/eBfpoPzGAeFrIPmE3uQaUA5AuYmmJHxEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJs3S7TY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJs3S7TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9FB1F000FF;
	Fri,  2 Oct 2026 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790980760;
	bh=frwuMgrYQT/Wad43kNqkfnzWIzqgZcbgyBlQiLvZscE=;
	h=Date:From:To:Cc:Subject;
	b=QJs3S7TYs/4nEtMmolfw+5/ogj+QwiScsK2aUVOG78kmqAgTwctgHZrEuUB+UtUWv
	 zSHdWUFaiRgqUKM0ruqLHnertwJ1QjVwMCXezFCHG3Wzj/hgU4dz2Rmvhh5F3P/Wbu
	 cKQZOIhUfIpsLcC42ULYudEr20aot9DrZ9d4G6o9PyJSpxYNegKjZ58apaOnKAXeTb
	 wwyaGMiQpv0i4/91HLp6z5/r6fmHjaJr6bGFBpRZAZVL/AQiaY6g7x826K18/w7Ifd
	 WiCVacJzF1xgUjSpHaX0dqy83IejYbnzfM8N+YjuefPwIhw9Ph9Xoe8Jq2Wxi24ebb
	 hdcafxHTWGddg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BDDC41AC57CE; Fri, 02 Oct 2026 23:39:17 +0100 (BST)
Date: Sat, 3 Oct 2026 00:39:17 +0200
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nikola Prica <nikola.prica@amd.com>
Subject: linux-next: manual merge of the bpf-next tree with the pci-current
 tree
Message-ID: <asAylbswc5WRADZ2@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="abGlFwzYlMGAS97a"
Content-Disposition: inline


--abGlFwzYlMGAS97a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  drivers/pci/pci.c

between commit:

  97958feb6560b ("PCI: Accept AtomicOps already enabled by the hypervisor")

=66rom the pci-current tree and commit:

  40cce45b921f7 ("PCI: Accept AtomicOps already enabled by the hypervisor")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/pci/pci.c
index 62729ade496fc,8cc6a89130b53..0000000000000
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@@ -3770,10 -3770,13 +3770,10 @@@ int pci_enable_atomic_ops_to_root(struc
 =20
  	root =3D pcie_find_root_port(dev);
  	if (!root) {
 -
  		/*
 -		 * A hypervisor may expose a topology with the root port
 -		 * not visible to the guest.  If the hypervisor has already
 -		 * set AtomicOp Requester Enable in the endpoint, we assume
 -		 * it has verified support in the root port, so it is safe
 -		 * for the driver to use AtomicOps.
 +		 * A hypervisor may expose a headless topology with no
 +		 * visible root port.  If it has already set AtomicOp
 +		 * Requester Enable, there is nothing more to do.
  		 */
  		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
  		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)

--abGlFwzYlMGAS97a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasAylQAKCRAv73Ows9A4
icFLAP9o9J9wPb3G6Un9kVVNXUsHt1DOjZR8SZivcFCSlKRtLgEApkuUtJoBhpIm
iCPg7iO+4c4mfhfSmG1TRDVitnfmsAA=
=Lr35
-----END PGP SIGNATURE-----

--abGlFwzYlMGAS97a--
