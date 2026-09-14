Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB544477E8;
	Mon, 14 Sep 2026 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385526; cv=none; b=u0K4vKS6z0n7tZpfYpMidLJ3FIeuS7v+EuzP+S5RXGghzmpp1yJBsPtw2bkh/FPCzBiwoyV/vkWycQZZpEuqJ9XbeD4N/pxaOwMZngn6pRGFKM5krQC8AWZB9WhOouJDZ2Khu4RQePpd6YwSgonsRkToBdLpVCjcOoQbDkgQRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385526; c=relaxed/simple;
	bh=wcz4EoFg6anJY+chBtPUv+qluIFYpj35dIqx0OAkqjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kE5Ar3ezw5jl05K0MwXKXfvuU6GHqYo3UBvS/xZGT3avj6Ms5Egg8LJsGHMK8AAY1q5tQrNnG38MkRS5LHiU9N1pgIFiuxm5kiHL7+cThIFVg4zy5KE+sve5gtFIOiUaa0ebkgfS4qPk4eLXHIh6xad4THyx+cR22fzw/fZKeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izF2ow35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izF2ow35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A6F1F000FF;
	Mon, 14 Sep 2026 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385520;
	bh=wGCNQ5TRYNwxrWgNIzn556odUHcZv2XISspLFAklmA8=;
	h=Date:From:To:Cc:Subject;
	b=izF2ow35yavjfkcZWXZOx37OtKkvnTCxPin4X4dN5Izzs8SbQZ3wS02w30NXPXPjI
	 XKQboyKDjMSkndACvEKdyMJZwgU6nWovoa6+cyfgUl5UxuDFqnuaawT3wKmiPe+AFm
	 HPMn6wB9LYVKLZGCi8j1FZxj08xC5Jhp76n5f7OQZSnLBZq5ihFz/hSr5swTFTRNb7
	 b470s+qb166vLMRlAh/iBnWe/OVRh/BQSkUvlskG8t5cYE6OiaFTtr7+Ej4NjiKpPb
	 JCi8XLNu7JLb9wgoXqsSG05Q89YlbaE3ZyUFHFcPUXsO9fxKzO91GxZqxCAG31GSW3
	 GDo9/Ez9e7+1Q==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4F0431AC52F1; Mon, 14 Sep 2026 12:31:58 +0100 (BST)
Date: Mon, 14 Sep 2026 12:31:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <aqfbLhfgFBNbluZe@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7k/+dl7AKPfJtAmp"
Content-Disposition: inline


--7k/+dl7AKPfJtAmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/verifier.c

between commit:

  a903f145a8914 ("selftests/bpf: Add tests for the KF_PERFMON gates")

=66rom the bpf tree and commit:

  5647b77587ce1 ("selftests/bpf: Test kfunc packet memory direct writes")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/bpf/prog_tests/verifier.c
index 8b439e194bcc5,7732df9bc8701..0000000000000
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@@ -54,7 -55,7 +56,8 @@@
  #include "verifier_iterating_callbacks.skel.h"
  #include "verifier_jeq_infer_not_null.skel.h"
  #include "verifier_jit_convergence.skel.h"
+ #include "verifier_kfunc_packet_access.skel.h"
 +#include "verifier_kfunc_perfmon.skel.h"
  #include "verifier_ld_ind.skel.h"
  #include "verifier_ldsx.skel.h"
  #include "verifier_leak_ptr.skel.h"
@@@ -219,7 -221,7 +224,8 @@@ void test_verifier_int_ptr(void
  void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_ca=
llbacks); }
  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_no=
t_null); }
  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_converge=
nce); }
+ void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_=
packet_access); }
 +void test_verifier_kfunc_perfmon(void)        { RUN(verifier_kfunc_perfmo=
n); }
  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire=
); }
  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }

--7k/+dl7AKPfJtAmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqn2y0ACgkQJNaLcl1U
h9A7+Qf8CY7AWnCCBngVdRhvTHKTuXQ4XvzzahF/DmZjVeJFuMQlOQEBvAKCObmi
fT9T+t4N4dNo1sJl6jLvPsusxrT0EbyZ02cc1QotXqMQuPIaS7YSE9DvF4SrxJRx
g41tymgWquUO1q0CK0ae99mqQN9qsdbsn5qKTaNpJCu9CspHSZf1HqCO5+CwemcM
31OaeQajjpGGg3NiiSD4hm1sOaQ25aTiWHfXJuJQvqdNQe8xg+AI2ZFgSFZjjm+S
9f2M/b5hlqLoJHgm9SH8kLaivF77uYDu2o4N5cQR2TfxM2rK41g4WDDYLyEjZ73Z
nh6v84eVM1eQt6zXmDf9gC6eKf6Pow==
=K4W4
-----END PGP SIGNATURE-----

--7k/+dl7AKPfJtAmp--
