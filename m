Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794917;
	b=E+gQC7vaydTV1UTXeDo3xHmgmURLyHYbP5f0XOeZ3TqVreNRXcpOOEGSipGj8GeaNtvu
	 3A6jggaDEModaaCToWmKdjnw6CJ6bCSZ/0AyHkDUYDCa0Je8zangtyeQq93V7a4YJPYMp
	 VbSBopkjz5T/BpTHY+hixeNqL3uzRsMUM3Qpc/huEQVgk9PfTvcJwMpeYLFRV+n+HwPwd
	 RbUGdnr2UOh+KzefpbP8lcoT0REOZqAtkwit9Kaa9TJI1gzXI+3SoAhqyT/AxDwSt1rMK
	 5E3n+fw+xeGAX2opMHdXlXfwy2WDJuv5nXZQrtJWdcAqvXCz9Dv+SRDEhpvp9ebk9sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794917;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=Wi3kzpbgKBsJchefNvbmN+6y+8qa0DUlqe2Frtdyp4o=;
	b=jXhj7cM1qSE7WknU1tB0fLc7yaRef5BtldVq3L5Vjc5FfmG9GTF9PWlBMueOFNSsXB/b
	 fQp7oqS7O4JFpcueHs8X5tA/XzVxbotRhqE4idBh0h0/uXlSVr8uj6IZH2AKFJ93h1Aal
	 yQWEG4fVufu9oD5AwOA3YcpdleMlw9Azeda5Mg6dHM8+6mNIjNFlBAFl7dugQ5NctYLrU
	 qorEggGeOygDuO0w+KM61mE5GEL8175xaCFx2tc2HZpVe46mnahvB6/A/QmWjGrFy3LYq
	 scNNKoz8P3NKHXhVcklCyTiS4SRERSan6zfCULnsum3VeQS05l8kOM1nxG3Pcn7IZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyTIkzZC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49397606A31C;
	Fri, 27 Nov 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyTIkzZC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A631F000C1;
	Fri, 27 Nov 2026 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794917;
	bh=Wi3kzpbgKBsJchefNvbmN+6y+8qa0DUlqe2Frtdyp4o=;
	h=Date:From:To:Cc:Subject;
	b=MyTIkzZCbFvX9fO0CRwdXI3fw2iMr7ZBM5u6HOsNqCSZPd5OdTLPzv45eHj0XDrRa
	 BYsuAI3D4ba1lppGKnDN66fT2/DtjL+mslGMrPvmoJZz6fgORUGDt6gN9qy26nzI1/
	 8q0Q8W0T9d7t0J+IgmnZeTRWjirAhSDG3nuS8XdyjFQI59Vs8oA0ObDLEFLr5EG68a
	 oFhYtL5P5mMxPsxWsfyxEcuje/Z7ouaQDAzNrBw/j0zdFGfL7Pdw1VDEtvhHUsPeW/
	 gqPV+j2XvoBKSCjnxV7RGTqAdueZ23pm3+q/X8+PJRggs7yb6LfDWCBVtXHkQUmcgg
	 iDNmYtCkmGtow==
Date: Fri, 27 Nov 2026 15:55:12 +0000
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
Message-ID: <awmn4OTEiDdqyi6t@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="Pa5uPlxAM9VD/AVg"
Content-Disposition: inline


--Pa5uPlxAM9VD/AVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/fixups.c

between commit:

  1879b5e505de9 ("bpf: Emit nospec after calls and atomics that write to th=
e stack")

=66rom the bpf tree and commit:

  57fae4059380a ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/b=
pf 7.4-rc1")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/fixups.c
index 8c3a17a05a4e1,7af8cb886f7d4..0000000000000
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@@ -907,14 -1261,11 +1261,12 @@@ int bpf_convert_ctx_accesses(struct bpf
  {
  	struct bpf_subprog_info *subprogs =3D env->subprog_info;
  	const struct bpf_verifier_ops *ops =3D env->ops;
- 	int i, cnt, size, ctx_field_size, ret, delta =3D 0, epilogue_cnt =3D 0;
- 	const int insn_cnt =3D env->prog->len;
+ 	int i, cnt, size, ctx_field_size, ret, epilogue_cnt =3D 0, first =3D 0;
  	struct bpf_insn *epilogue_buf =3D env->epilogue_buf;
  	struct bpf_insn *insn_buf =3D env->insn_buf;
 +	bool nospec, nospec_next =3D false;
  	struct bpf_insn *insn;
  	u32 target_size, size_default, off;
- 	struct bpf_prog *new_prog;
  	enum bpf_access_type type;
  	bool is_narrower_load;
  	int epilogue_idx =3D 0;
@@@ -995,13 -1336,10 +1337,15 @@@
  		enum bpf_reg_type ptr_type;
  		u8 mode;
 =20
+ 		insn =3D &env->prog->insnsi[i];
+=20
 -		if (env->insn_aux_data[i].nospec) {
 -			WARN_ON_ONCE(env->insn_aux_data[i].alu_state);
 +		/* A call or an atomic gets its nospec in front of the next insn */
- 		nospec =3D env->insn_aux_data[i + delta].nospec;
- 		WARN_ON_ONCE(nospec && env->insn_aux_data[i + delta].alu_state);
++		nospec =3D env->insn_aux_data[i].nospec;
++		WARN_ON_ONCE(nospec && env->insn_aux_data[i].alu_state);
 +		nospec |=3D nospec_next;
- 		nospec_next =3D env->insn_aux_data[i + delta].nospec_result;
++		nospec_next =3D env->insn_aux_data[i].nospec_result;
 +
 +		if (nospec) {
  			struct bpf_insn *patch =3D insn_buf;
 =20
  			*patch++ =3D BPF_ST_NOSPEC();
@@@ -1101,14 -1423,9 +1429,10 @@@
  			*patch++ =3D *insn;
  			*patch++ =3D BPF_ST_NOSPEC();
  			cnt =3D patch - insn_buf;
- 			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
- 			if (!new_prog)
- 				return -ENOMEM;
-=20
- 			delta    +=3D cnt - 1;
- 			env->prog =3D new_prog;
- 			insn      =3D new_prog->insnsi + i + delta;
+ 			insn =3D bpf_patch_list_add(env, i, insn_buf, cnt);
+ 			if (IS_ERR(insn))
+ 				return PTR_ERR(insn);
 +			nospec_next =3D false;
  			continue;
  		}
 =20

--Pa5uPlxAM9VD/AVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsJp98ACgkQJNaLcl1U
h9AGVgf9FXfiw6bENsBziiPehzm8ZRaG/+PetmJ73yAjIJ6LDVDHDoNtcWO7Rjog
vCDHI/Uo33ZJv+dcMRkfmP5FYgzgdR01LZX3gisvRRwCDwd58x+5h4vuQZ88ARM0
k1HBSHiEaGyNrLzuN1cXe6osTIyiIO4HR+7T8G4iOvhsVC8Q9AfHaLUAR1eQ4/QJ
mNEtQ1ADyHHxUIhfkLKhK4l8/BtHOoR9l5Z/gWBpXHg5occRC8wsXi9P6hrQArtZ
3ZxPi4XIqEw2KT8tbWLNyLMND8C6U95/8YFF0Up2hcv7S9enw2gdUq19Aae/rrOH
NX/D39qZ3husYQbVkZHIgW/OCiQ5Jg==
=Kkib
-----END PGP SIGNATURE-----

--Pa5uPlxAM9VD/AVg--
