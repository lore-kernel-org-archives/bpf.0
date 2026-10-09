Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88947255E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546615; cv=none; b=cvl93mlmNENErGzej3kUpO7CJ0qMwnCv+Ie6a5WeCbHbRjni7boVumle1QDI1Nrwfp4BLWnB3QM+W8PqpFbCoAhytFpVh29BhsnUGuif+MVbXQ7gvS3SA5HnLS/Wd7+/9lSZsy43EIfM/YhcHBpWIthvHODRry5VUf+vKnPkGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546615; c=relaxed/simple;
	bh=amYucAcDmPCkcehcLPn9PrDcY0auZTNKBGoJiNjUlK8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nbw79GGlbQyrKzJvPPcTp0JLSUdmDRRqHfRjsoRB9+bWOlHRlHH2o6dgULwDVZKwa9c9mB/T9TjYiPft+oTRjDnWnax3YZbPgY4ezuW+JBqrulRK46kbEIRd/Eyfc03D9esOqfSbAzXjBZGm3eT7VEi143t01CbxsnKtP/DUDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctOCWIJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctOCWIJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03211F00893;
	Fri,  9 Oct 2026 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546606;
	bh=yVyPF873XWpQxHotEmxo4fXBocBrCvo+iv9dWoB7q3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctOCWIJAxcqMZJBGGdoFvbXqsLNE84IQZgBSe3wqh4Y5P+3yStu9aVmITsoagWDIg
	 Gw0e84iXqn0Y2vRc5nZi6AO0/njEMNPr/ze4GlkgQeJyv79ghf61gCF7zOhL+YhFyZ
	 U+TygWHyqTnm8IseI9LH2j6E3kWjecbsoIBE15rRmZG2SvMn6aDhgWqdlvKCCfev5T
	 T5SD3E4VTQB/cXlf3QDxj6zRcDR7U23DvvoPl87k3cWDQuUKWa4srC7DGL5eDl/kE1
	 9sQdpIiyucY2CRqtYRNd1rvwhP+UZnFgz90XWWap2s/ZksgjVfI85yMaHXyHD0j2ea
	 aqOTg2dD1n4fw==
Message-ID: <sashiko-outbox-165429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net-next 13/14] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008114909.734364-14-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-14-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:50:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: drv-net: xsk.py crashes due to missing test_xsk_case_def=
s.h dependency
--

commit e8144917db97e8dcd48aff778b6c6ea34e332b01
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: drv-net: test AF_XDP zero-copy with an SKB peer

This commit introduces xsk.py to test hardware AF_XDP cases using a
device under test and a remote xskxceiver pair. It adds the script to the
drivers/net/hw selftests and utilizes Python networking helpers for remote
execution. The runner dynamically parses test cases from the C header
definitions in the net/lib subsystem.

> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/test=
ing/selftests/drivers/net/hw/Makefile
> index 18ce235a77f84..02e48e74f6c6c 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -52,6 +52,7 @@ TEST_PROGS =3D \
>  	uso.py \
>  	vlan.py \
>  	xdp_metadata.py \
> +	xsk.py \
>  	xsk_reconfig.py \
>  	#

[Severity: Low]
Does xsk.py rely on any external test files that need to be explicitly
copied during out-of-tree builds?

Because the required data file ../../../net/lib/xsk/test_xsk_case_defs.h
is missing from TEST_INCLUDES in this Makefile, it appears this causes a
regression where the file won't be copied during out-of-tree run_tests
for this subsystem.

> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testin=
g/selftests/drivers/net/hw/xsk.py
> new file mode 100755
> index 0000000000000..a33d4af869c7a
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
[ ... ]
> +SKIP_CODE =3D 4
> +XSK_BIN =3D (Path(__file__).parent / "../../../net/lib/xskxceiver").reso=
lve()
> +XSK_CASES =3D XSK_BIN.parent / "xsk/test_xsk_case_defs.h"
> +
> +
> +def _hardware_cases():
> +    defs =3D XSK_CASES.read_text()

[Severity: Low]
Could this cause a regression where it unconditionally throws a
FileNotFoundError and crashes the script if the file was not deployed?

When running an out-of-tree build where the header is omitted from
TEST_INCLUDES (or if xskxceiver is legitimately not built), this
read_text() call in _hardware_cases() will crash before the
XSK_BIN.exists() graceful skip check can execute.

Would it be safer to verify XSK_CASES exists before reading it, or handle
the exception gracefully?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008114909.7343=
64-1-maciej.fijalkowski@intel.com?part=3D13
