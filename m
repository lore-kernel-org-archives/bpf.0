Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF24570D4;
	Tue, 22 Sep 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071510; cv=none; b=X/wy20/fGFCnmUIwKGlIapoGUXjQjQfaaLivYJ3HQlloJ8w+mvjdIvQt1kYZ2NhdqyXSXmz/ByipikGUbrD+kvR8vuhShDouZIdKljJOFLgYpuVFxUL2yLKlTYCh0QdYx5ZXt60QueRtvcDFLy4Sr9tyQgHrpZviYwUWroVKXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071510; c=relaxed/simple;
	bh=e1OPguSznv0oaoWEQ835BMLZphcamQK6RYvbQxI3zms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U9wnvJn2/Klu7++xRgRZJKpYA+gpgMzcx7yTlyFk8P5IXM3zzhrcZeE4ecx6clrRRbZGAxO0lHT4s21hcBUsfay0AXxKrGCIbfDP5V+ZJya3z8IPZN2si0g5c289Ws9eNR6fatLv8l2gsJHh6MNFwdpvz3gExrYyaQhklC+iWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKE6s0xy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKE6s0xy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D95E1F000FF;
	Tue, 22 Sep 2026 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071508;
	bh=w2sZxf+PXOvNNTzDd/9WHwR+bGg7r6uPFpZLwJ0woQc=;
	h=Date:From:To:Cc:Subject;
	b=TKE6s0xyO5zpNxZoQf3uHhv9ip5+KCBng83OcGHn3+tREzOEhut9Hl+xkeeVvNVUH
	 dfxSX9qwyAHQwXxFBRiTcNabV3FIQEdYbaSLCIEA43wiR2f5SslQ6UuuKJGQ92+qiT
	 55NYXQ4Yhy4QKTw0RGt6ZUF3PuMTbSCrwGVVTey53KBpRH8nMR70GRiwHNwIXqkwVK
	 Axt9vijRZK5ovkmoGiVwigZi4G3IsIpjNwYFvbgzgiGfZLzE319dDNR2JfRpJqrBLm
	 Z8ZIuRnNQUGRZ42SzrZ0QTBi8Dg9J0EirYjyyqf9ZSBUlNGrctLGszbMXJ1yCT/oYh
	 ublzq4ZqjGfPg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DA04F1AC56BF; Tue, 22 Sep 2026 11:05:02 +0100 (BST)
Date: Tue, 22 Sep 2026 12:05:02 +0200
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <arJSzo-jhnM-Tkvm@sirena.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyZ6XOk+o1SSkcvv"
Content-Disposition: inline


--pyZ6XOk+o1SSkcvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/verifier.c

between commit:

  a903f145a8914 ("selftests/bpf: Add tests for the KF_PERFMON gates")

=66rom the bpf tree and commit:

  a8bbd9ee1bbc7 ("selftests/bpf: Cover generic __uninit output initializati=
on")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/helpers.c
index 712dca5a2c5bd,501c7ce35cba9..0000000000000
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
diff --cc mm/internal.h
index 0434dfcfc36f1,9e3be236f18c0..0000000000000
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
diff --cc tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 490e15e7126d9,c32c6dab49bce..0000000000000
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@@ -11,9 -11,9 +11,9 @@@ struct=20
  	const char *prog_name;
  	const char *err_msg;
  } cb_refs_tests[] =3D {
- 	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects r=
eferenced PTR_TO_BTF_ID passed to R1" },
- 	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
+ 	{ "underflow_prog", "R1 type=3Dscalar expected=3Dptr_, trusted_ptr_, rcu=
_ptr_" },
+ 	{ "leak_prog", "Unreleased reference id=3D4 alloc_insn=3D3" }, /* alloc_=
insn=3D3{2,3} */
 -	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* alloc_=
insn=3D2{4,5} */
 +	{ "nested_cb", "Unreleased reference id=3D5 alloc_insn=3D2" }, /* alloc_=
insn=3D2{4,5} */
  	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" },=
 /* alloc_insn=3D1{1,2} */
  };
 =20
diff --cc tools/testing/selftests/bpf/prog_tests/verifier.c
index 8b439e194bcc5,4f1e1c1cd5ab3..0000000000000
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@@ -54,7 -55,9 +56,10 @@@
  #include "verifier_iterating_callbacks.skel.h"
  #include "verifier_jeq_infer_not_null.skel.h"
  #include "verifier_jit_convergence.skel.h"
+ #include "verifier_kfunc_packet_access.skel.h"
 +#include "verifier_kfunc_perfmon.skel.h"
+ #include "verifier_kfunc_uninit.skel.h"
+ #include "verifier_kfunc_uninit_multi.skel.h"
  #include "verifier_ld_ind.skel.h"
  #include "verifier_ldsx.skel.h"
  #include "verifier_leak_ptr.skel.h"
@@@ -219,7 -224,9 +227,10 @@@ void test_verifier_int_ptr(void
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
+ void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_=
uninit); }
+ void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_=
uninit_multi); }
  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire=
); }
  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }

--pyZ6XOk+o1SSkcvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqyUssACgkQJNaLcl1U
h9AJLgf/b204gVZX/IeKYjNsCB9oiOd1gN6gDrO/ftoVIVnn1GXoRKJqyV7RC60s
PewUH50nX3R5Ttqo+hS1upltjwYW0azQ69Z+F2VAOZ+eDpTZTeDbdP0P+DwQqWqg
OuvRZXgaqFTmuC/cw6GlDJImOwWKFNR67KYU0596NVx690UOBR6X2+oB8luyTu/y
QTMOT6ThGrqIFTKw/LKUqRDJaCIt8e+CT6ZbAPWSM5HrEfWL6qG8PSnkcC3LcazC
umNCvfubGCzXxYDwi8U8Qr2dJWWp7EoUD6E7L8RAB6MA6oqOuNpQ4jDrOPJFJx0B
1ZUUGgeRTDKC3JdAFDpsp+uak+L7RQ==
=qm5D
-----END PGP SIGNATURE-----

--pyZ6XOk+o1SSkcvv--
