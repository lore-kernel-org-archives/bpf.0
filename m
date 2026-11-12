Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493164;
	b=DNVP6ROkqb1l4uGhIXNd99UNDJvxrX277bpCYDAqePHP6Y4adr2CBVvcUNj+CoV5WijD
	 IAaBM3HiEOphWyLZuLlxIPorStecy4U4r2Yi4tCjbFz4KjvHn2FZ2kLI9ga/izhhVcbaZ
	 z1EgbZTuLsQoyZ7g2xHoXoWuYpGF3oYFhwRhOojlgWhvx/y/JeY8Gat9wYaeFmA2oXM0d
	 74pj1VsndthVw7YV+F9zRJ2Cp/yKe02EtZQoCG+HELOKuXh6ofyDm7tj0qkWVVluYZGdg
	 kcBdnvtQ2YLlpF2nKPZkvCJQc2PQalhVZXPP2lpvOwJj2e9CMqJBEgmEIiCNnyO7tlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=pnCp5Ux0GmDJfIuw584yh8GGWEqd7YbOTNLion6nYJM=;
	b=a8scACp/OjUjJVMpl3HP+3x66VksIc2vjpxN/gB2ZKrzMudZWDxqvkT6MyVCznJE17Q1
	 hnYOmHRK9Bq+zrC+Px3+GXxcwmD2u5L1EVb5IOckgaRQg5efTrRCZcwRxVexx60Tgsc14
	 qcQYngbmSx20fHTlRwRIFHjWScmzHGPm7lqEiJAeFjxyJaXbGgzQCDWZg2R1Y/xVh9JIM
	 2QPaGP6Mrq9DWL06DXSAS8pLS9GZnG3pTY9C+CL3jfGgqsU2tYEo2LmuWX2za5cM70Xxi
	 qM2eHFUq66rtYFMkKcmvyMOPx1wj9Fup7g953L+WFyb4Z5N7HkapSvThEb/WbAil9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pmawl4IX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A6606AE02;
	Thu, 12 Nov 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pmawl4IX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B3F1F00A05;
	Thu, 12 Nov 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493164;
	bh=pnCp5Ux0GmDJfIuw584yh8GGWEqd7YbOTNLion6nYJM=;
	h=Date:From:To:Cc:Subject;
	b=Pmawl4IXvD46kT3nXUm4DQuk7jnYsH97i5h7Uj6VJpfRi8GsSik6xGrYu6Bmk9a1C
	 ncPyvbnl7A2fVEKqH2OWDVyQ+lnVDagAj8c6q7dakbzuhlsJO5DWxukleySO7eVIQY
	 C2l2eeskTBNucC7+PdJxQKo9127jx/zl9U9WtN1bIoDBmct146ZFkEcMye8S1+Cp1W
	 qlyalpQO4RLWwl/5qLlYTcxM1xLYdB1O8bfJ2EUIkH/xlGE6dK1yeVt/olgA2s+dZN
	 61R7QvnraDJ9GyFS5U4+btHBf347F4sEjD0llTqdNBYHDoiNPlQjn+JN5jetQEwgYi
	 hcq6+q8qPt/rw==
Date: Thu, 12 Nov 2026 14:19:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <kees+treewide@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the origin tree
Message-ID: <avXK527T4yDydgya@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QRzQixSA9p0gQ/D0"
Content-Disposition: inline


--QRzQixSA9p0gQ/D0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/scev.c

between commit:

  0af298e62e5cf ("treewide: refresh kmalloc_obj() conversions")

=66rom the origin tree and commits:

  e2f3d29e88d08 ("bpf: Refine registers linked by scalar evolution at condi=
tional jumps")
  aba76dc75e35f ("bpf: Construct scalar evolution expressions without alloc=
ations")
  cfef7bfa2c2a1 ("bpf: Give SSA names to the values that scalar evolution d=
oes not track")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/cfg.c
index 1b04538351a1f,bbcf42eae9d92..0000000000000
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
diff --cc kernel/bpf/scev.c
index db123ef1f0718,b413998d9cf93..0000000000000
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@@ -1260,23 -2430,13 +2430,13 @@@ static int compute_scev_for_loop(struc
  	u32 r;
 =20
  	if (log_level2)
- 		bpf_log(&env->log, "Computing SCEV for loop at %d:\n", cur_header);
+ 		bpf_log(&env->log, "Computing SCEV for %s at %d:\n",
+ 			cur_loop ? "loop" : "subprog", first);
 =20
- 	/*
- 	 * For irreducible loops, and for loops nesting a loop with a truncated
- 	 * exit list, just assume that everything is clobbered for now.
- 	 */
- 	if (!can_compute_loop_scev(cur_loop)) {
- 		header_env =3D get_loop_env(scev, cur_header, cur_header);
- 		if (!header_env)
- 			return -ENOMEM;
- 		/* The freshly allocated environment has all expressions unknown. */
- 		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
- 		header_env->empty =3D false;
+ 	if (!cur_loop && !can_compute_subprog_scev(env, sub))
  		return 0;
- 	}
 =20
 -	cur_env =3D kzalloc(sizeof(*cur_env), GFP_KERNEL_ACCOUNT);
 +	cur_env =3D kzalloc_obj(*cur_env, GFP_KERNEL_ACCOUNT);
  	if (!cur_env)
  		goto nomem;
  	if (log_level2) {
@@@ -1724,25 -3142,27 +3142,29 @@@ void bpf_free_scev(struct bpf_verifier_
  int bpf_init_scev(struct bpf_verifier_env *env)
  {
  	struct scev *scev;
+ 	u32 r;
 =20
 -	scev =3D kzalloc(sizeof(struct scev), GFP_KERNEL_ACCOUNT);
 +	scev =3D kzalloc_obj(struct scev, GFP_KERNEL_ACCOUNT);
  	if (!scev)
  		return -ENOMEM;
  	env->scev =3D scev;
  	bpf_mark_reg_known_scalar(&scev->zero_reg, 0);
- 	bpf_mark_reg_unknown_imprecise(&scev->unknown_reg);
- 	/* A power of two for hash & (exprs_ht_cnt - 1)` indexing. */
- 	scev->exprs_ht_cnt =3D roundup_pow_of_two(max(256U, DIV_ROUND_UP(env->pr=
og->len, 4)));
- 	scev->exprs_ht =3D kvzalloc_objs(*scev->exprs_ht, scev->exprs_ht_cnt,
- 				       GFP_KERNEL_ACCOUNT);
- 	if (!scev->exprs_ht)
- 		goto nomem;
- 	if (expr0(scev, UNKNOWN) < 0 || expr0(scev, OPAQUE)  < 0)
+ 	bpf_mark_reg_unknown(&scev->unknown_reg);
+ 	setup_initial_loop_env(&scev->identity_env);
+ 	if (grow_exprs(scev, roundup_pow_of_two(REG_EXPR_ID(REGS_NUM))))
  		goto nomem;
+ 	scev->exprs[UNKNOWN_EXPR_ID] =3D (struct expr){ .op =3D UNKNOWN };
+ 	scev->exprs[OPAQUE_EXPR_ID] =3D (struct expr){ .op =3D OPAQUE };
+ 	for (r =3D 0; r < REGS_NUM; r++)
+ 		scev->exprs[REG_EXPR_ID(r)] =3D (struct expr){ .op =3D REG, .is_vn =3D =
true,
+ 							     .params =3D { r, 0 } };
+ 	for (r =3D 0; r < REG_EXPR_ID(REGS_NUM); r++)
+ 		set_expr_base(scev, &scev->exprs[r], r);
+ 	scev->exprs_cnt =3D REG_EXPR_ID(REGS_NUM);
 -	scev->envs =3D kvcalloc(env->prog->len, sizeof(*scev->envs), GFP_KERNEL_=
ACCOUNT);
 -	scev->discovered =3D kvcalloc(env->prog->len, sizeof(*scev->discovered),=
 GFP_KERNEL_ACCOUNT);
 +	scev->envs =3D kvzalloc_objs(*scev->envs, env->prog->len,
 +				   GFP_KERNEL_ACCOUNT);
 +	scev->discovered =3D kvzalloc_objs(*scev->discovered, env->prog->len,
 +					 GFP_KERNEL_ACCOUNT);
  	if (!scev->envs || !scev->discovered)
  		goto nomem;
  	/*

--QRzQixSA9p0gQ/D0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1yucACgkQJNaLcl1U
h9Cszwf/QQGXNv+K8uQHamz2z0m++d+2ZMVpeQltNLm/SwHnDwLCmFBs+ksb+Evz
zKotMgOIYBwQKGpACEjS2jderRG68rNVeM56t3lXMwAXeh7noaIDCFHW0CdtvMa/
lqzDgckxEGTIKUMNz3ez3QIrv2Y1QsKl0B2j1ok2HEoHk2Db7mrrTkfb3tR5LdAM
f2qzkU+b7BKHGtxfSYQ76dwzbUUxvdxT3JJxMuVZpiaxEAX/vUDBD122urvPJ31s
4Lq1jV57NYMRwzhuqcpzkviyjyOFprtUst+LiH5JmJczizGAPLdgYrNj4jMdujgy
zjJW+HjA1wi3yyxoCBegw8paZrv6ig==
=CBu9
-----END PGP SIGNATURE-----

--QRzQixSA9p0gQ/D0--
