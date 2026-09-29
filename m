Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6551D501;
	Tue, 29 Sep 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684157; cv=none; b=tMojy4UrSxDlcn5gjsHdnBNfELlIKv3LjPJjlIOFpvHFuIm0Bh1WQLIay1r4y2TgiG8T+4xJTaGh4knAJOT2/6M9sr32Rj6A0k2+fe80cYueNutBBSDyv2cjdq9BMXYzB921R5VUhFHwiXoEk5QoxEFhQ+0ahiQP375iFEpyDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684157; c=relaxed/simple;
	bh=heCEvOKUdCX3/sEVSdUD1e5vx1fwNmCVIFqVXPFDvKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QX0+zA7wq/j+cUK0HRNRuZWDQRJtPRrossonWdm0cJydcak7JqSLFdX0VFjMQCqfAuz+14JXjd+/oEQIu4bqHeOXeIshrZSYc6ASBTKhmcJ5P7Wo+yuZ5hTl7AT74FU7IPRfGKXQ7VvsOMfpiLtzlgMXT2V9f2NUYgAUbDHMcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luzhOpha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luzhOpha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF251F000FF;
	Tue, 29 Sep 2026 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684151;
	bh=6QVnGnnzjb9cWbtInuifpwwmFbwdcbFh11DioSaXTFI=;
	h=Date:From:To:Cc:Subject;
	b=luzhOphaO3iug2mOB64ipdwYS8qub/HjVwT/iWxaUXOhzcNznxKsVNlY7hA6iDgSz
	 pZszStbt5s5ngeOMn3VEvvCMZOqHPNP35bbk7x88EyC3YbjvPlX86hD5W03WQMxMy1
	 rX9Y9FnEjl4dlTeAyTHw4rKJhlcziWRDLr0CqkwyhZ7sxwOtcYHosLFGsBeHlP829m
	 5UKpGBDw/gH6lsVqwNIYXvZui7jknxEtt4vt/U/73bDCsrDwqgMcVIHMUX8oiEfP/k
	 G05keLRUu5Hysjc/YlR2v55HgQxvUAarhVb79SAiyiXyRrM39kDZQDOZs15QjQ4Hl1
	 7UkSAaeTk3zTA==
Date: Tue, 29 Sep 2026 13:15:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Florent Revest <florent.revest@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <arur8pZBspVcQK5I@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sas/joUr6P4OkPnn"
Content-Disposition: inline


--Sas/joUr6P4OkPnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  arch/arm64/net/bpf_jit_comp.c

between commit:

  17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are st=
ill in use")

=66rom the bpf tree and commits:

  1d5306c11da2d ("bpf, arm64: Allow programs 2 KiB of stack")
  11a516144d9a8 ("bpf, arm64: Add JIT support for callx")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/net/bpf_jit_comp.c
index 8108012cd7e4a,475e706534543..0000000000000
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@@ -2413,11 -2498,20 +2493,21 @@@ bool bpf_jit_supports_subprog_tailcalls
  	return true;
  }
 =20
+ bool bpf_jit_supports_callx(void)
+ {
+ 	return true;
+ }
+=20
+ bool bpf_jit_supports_large_stack(void)
+ {
+ 	return true;
+ }
+=20
 -static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n=
ode,
 -			    int bargs_off, int retval_off, int run_ctx_off,
 -			    bool save_ret)
 +static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *=
im,
 +			    struct bpf_tramp_node *node, int bargs_off,
 +			    int retval_off, int run_ctx_off, bool save_ret)
  {
 +	void *skip;
  	__le32 *branch;
  	u64 enter_prog;
  	u64 exit_prog;

--Sas/joUr6P4OkPnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq7q/EACgkQJNaLcl1U
h9BPFQf6A4Sld1BcWUFGI023KrA4xWYCY47Sq35MNNmn9ea67ZwWkQrXvg8H2cju
cjqSUttSwtS5uJhuNinaOxjhjQW51SJSC+FogzHaEOd7rKp6wIzVXr/smhYnM0vo
UMQ5vXM0vSajWHG9PJcKV1tNpH2yLeuGndHtK38pTbAmALZOqyIjHjxfdaSFLKdB
i0fGZo8vF+w4VgV6HY8ce3QmNKm+o/n5T0RQ+LHbhb+0lXBoV6YlrTNH03ii40dr
sKnel4LrZULVCULkXfsdzHDUY3IdQRCvbzDiO4bDbADhOFmPfh3ynp9Dn15xFkdN
faEdaQiFkriqIBAfa16dr50VeS0ofw==
=71J/
-----END PGP SIGNATURE-----

--Sas/joUr6P4OkPnn--
