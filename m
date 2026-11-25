Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628978;
	b=nq9hTtcKb8N1eVcPntlqKItqmZfodbXWzHWxYOsh1XdSNQLNRXchYVxvGS0jmNFVcNNp
	 OE5c15gsDpwpcDNWVAGLKf6aC2yVznmt8G/4HVFE84MqeGq3iQuSEi+o9wIC1tO0Us0jk
	 RKdU8hKfAfsGa7O7Xz2l9ygkhDsrY7eg4MVJ4jrmdJQ/xjEH6Oy7gM/iubiwWAJ3v9uee
	 mG4iTlDhsXWE1plXvmGO3B1VfePgjec5MqHLS8y7qddAmf6wkZkypIERgGntpXrOmPKvv
	 CoK1nhn+JcAy66Ca3931Tq/lcn5ox9eYa9oK/WDaqWHsBzPkeZUtJHSzfYp5Lq4CV7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628978;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=PnmfVuZ9RIAvAwIMLsmZaJYpk+cKqStzd8zRvUTyZ28=;
	b=QX6EfzihcG+LTuxAWQ7mHUJDC32S3FGjQjIvG6hA9zgtLithUZttBGkKbPtpo2AO/U05
	 2XI3NjqQkirbOEUQ+LmeVHFG74yHfcSrRg8uXPWP7y5reNB0Q3kqDLhRO+vV9cR6PNQaR
	 JmWB+LJNEKi6IJGHKyPyAnnrnKGlSD/gjUo4GKZh8qVMafJRT1YwpHNVKPWoI//GsKlXv
	 xyUQdfnqT9hdkP/lO6wQpRYNwtV+xY4AmOHvVTze05zqZTCfoMqGp/au5RUoKrJxOqLQx
	 cj33UuweiriFONAaAXmRwJpehpbwbJwn9zUNTf/KcN+iLU/RC8u3lX7EY3rmRZ60B7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1aUQrQH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42241606A33A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1aUQrQH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE81F000C4;
	Wed, 25 Nov 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628977;
	bh=PnmfVuZ9RIAvAwIMLsmZaJYpk+cKqStzd8zRvUTyZ28=;
	h=Date:From:To:Cc:Subject;
	b=S1aUQrQHu1XZ5GYG1rXrQgCvFyJ/kAX07gkVgDMwhFDTIGnwO7Kzkg5DC24b6jJq+
	 ATJhAH6xmIivqabbKcoXrNWa32cnaMXZpGJ/eBQwgFZvehp9ZP9MljDUWWme/A0Ies
	 iM9ADkR47KONUs6j0vqP6WXPAE39E9nPEtgFdCSpCT0MgfJXvqR575JApmcd1Jnyzi
	 Yy4Vv1H7GWl1PdmAiQ9JpUSmSmRFTs/s8OXy3joBbQ4QKl//mrqt5Mx4NHnB/NPmQM
	 mkjCwNFU75bfErTy2o3Yp06I/af7N53cV6mFLyZS8X2HvpYKEW5ipJo5ZBKwWO/h5B
	 ZCdwNwilR/Whg==
Date: Wed, 25 Nov 2026 18:49:33 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH] bpf: Add missing const
Message-ID: <d2339f5ddaa65ea2e711bc063f53c6359d470370.1795628913.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	protocol="application/pgp-signature"; boundary="xvsehvgghenbbdyo"
Content-Disposition: inline


--xvsehvgghenbbdyo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH] bpf: Add missing const
Message-ID: <d2339f5ddaa65ea2e711bc063f53c6359d470370.1795628913.git.alx@kernel.org>
MIME-Version: 1.0

This pointer is derived from other const pointers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

This was found by changing some <linux/string.h> APIs to preserve the
const qualifier in the return type if present in the input.


Have a lovely night!
Alex

 kernel/bpf/helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 58e357302850..f988dbead587 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -857,7 +857,8 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, =
const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
 	bool get_buffers =3D (data->get_bin_args && num_args) || data->get_buf;
-	char *unsafe_ptr =3D NULL, *tmp_buf =3D NULL, *tmp_buf_end, *fmt_end;
+	char *unsafe_ptr =3D NULL, *tmp_buf =3D NULL, *tmp_buf_end;
+	const char *fmt_end;
 	struct bpf_bprintf_buffers *buffers =3D NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec =3D 0;
--=20
2.55.0


--xvsehvgghenbbdyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHH60ACgkQ64mZXMKQ
wqmq9w/8DR/hCQ2yFhWoq6oRlVVuAlQjI8VC8X75boylt7tPWNmq91onavi1k7vO
FUVFDajTsFioq2yu0+EusdxohVyC3a36R+47SQ0aokPIJTYi0sto+k0JkRt+1+fZ
PgkGQQKFUdC+0tPMw37toJR3qfaiR/5BD8DiCLh3JksCaEUwK5JL9067zIqJW1Q0
IvMpsXZQUS3qfjm/EbMvm/ZZpnzzHEiG9cvj6SMxgR7c2+39ebz2oT/kdmPNmrn1
Axf/JLhCGS0GXwHh2pNFVqKSwrBM776zb0psSxPcz4Jqeqty0X6S7QcWcA4bi4Px
diia+i7O4qTjz0cIpaABQO3myjUZ/JQKIHPYwxI35Vs2GNPAtyZR0VJEsdXQeHJj
FwdlW0Fcy7/ODF84ji9fgg2xv1eWG29yLX7bqbcmH2b/3yI8to/9UHck9CiPe+T8
J63q+iCyvDTXpeVWVdoNbqascSFsz0kBlBb5oLfoToW31nYVG5pEx83vM9UJlxwC
C7IMFgS4C7i6x3GVKIWXzUziLHF4axOl88lViB51BXG/CKSMYb0L9lCSnvt47s8d
cq/oY8TAfTWDUY+E9xGoOT+WdkMaJUKd+J4QcHXdpqnp3WfnT7UjtU1x7em0PJRc
dOGCrMLdz0qUMifTwUFEAxXcfL0nBnJVCRbD1wvxJk7iyY58edg=
=lAsw
-----END PGP SIGNATURE-----

--xvsehvgghenbbdyo--
