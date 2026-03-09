Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE01231A3B
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080757; cv=none; b=R30RL75f7ttt1P4XR7S/7xlOW+L7r4Kj0A9gVqSUdTWAJwV1FtwSQdqhA6ngmJr9fu3yQ7mz+vWe1PZjdqDqmX3rNbiVGJxJ4toxc7ZNsW1vgtsTxpdN1kuqzQgDmNrI+Pkqn3jbTf1TLLAknG5jsFGnx/89uaCPiF1CFSJqCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080757; c=relaxed/simple;
	bh=rtaa9Pw/ipeGcjCveC8txRD/ASBzZ/9qA4qRZppjnTA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FZtJ0/O9HPxO2q9jt7uFoMr9Uysl2SM3ia0mIAGUC3pBl7j1z6sAnZSSY8Jjjvje3SjAUh1tf4CyBS/hU+GT1IeenIdzggsCpP0IcSiz56nEzTZ2tDVnfkMtSK8jPG8OPtgCu2P+0YzgpJKF/74jkSxxP487x1hCa1OnJdmCmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AEyFs6ax; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AEyFs6ax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1773080747; x=1773339947;
	bh=4dGQfBo+mU/7UVGIh+C+JvKrUFRKJHrerYkdrntinME=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AEyFs6axN0cggIbYcSn0+JeU7WrDvEB55WQKc/GM3/y9hMUJ1uZHGX0Ok6dHDp/KF
	 UURGBhQ6fnKXXvCbzA8FfETaCRmcuk72AYgpXlBdeOfTiFi65euDGuCRsdwtU4PQt0
	 7k2jS0e6sCn66XDNjTDZ+C0Yn2AyfCtjregOH8H6TL26OHO6ZCkxvJwtmhD3c6kexw
	 w0M0MJnw6vICb4c0Uqaw9vI0ppiEnUq16YvZHTZmkRostlBLIwEr1o+CZwtU+Bw5eW
	 wI3vAwzojY7YggQVHnSrUfP0egcdK2aMV65Uz6t2ZGsKi52KtudssALAq9b/1GsFOk
	 NleoMV4BduIlg==
Date: Mon, 09 Mar 2026 18:25:42 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Sachin Kumar <xcyfun@protonmail.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "haoluo@google.com" <haoluo@google.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, "puranjay@kernel.org" <puranjay@kernel.org>, "emil@etsalapatis.com" <emil@etsalapatis.com>
Subject: [PATCH bpf v4] bpf: fix constant blinding bypass for PROBE_MEM32 stores
Message-ID: <Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com>
Feedback-ID: 42070492:user:proton
X-Pm-Message-ID: 379a9aeaaeba00ce3c5e7a6ed09e4a50c07ee533
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------8e1ef8504ee45c35c7941f4dbdbb323dec6839844634cbb4d6f3ef89d5514be4"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------8e1ef8504ee45c35c7941f4dbdbb323dec6839844634cbb4d6f3ef89d5514be4
Content-Type: multipart/mixed;boundary=---------------------81832b4062254b605a50b68c2fbbdd90

-----------------------81832b4062254b605a50b68c2fbbdd90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
survive unblinded into JIT-compiled native code when bpf_jit_harden >=3D 1=
.

The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
before bpf_jit_blind_constants() runs during JIT compilation. The
blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
unblinded.

Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
load the blinded immediate into BPF_REG_AX via mov+xor, then convert
the immediate store to a register store (BPF_STX).

The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
the architecture JIT emits the correct arena addressing (R12-based on
x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
BPF_MEM mode; construct the instruction directly instead.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the ve=
rifier.")
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Sachin Kumar <xcyfun@protonmail.com>
---
v4: Rebased onto current bpf tree (1f318b96cc84).
    Fix block comment style, line length. No code change.
v3: Use legal name in Signed-off-by per DCO requirement.
    Added Reviewed-by tags. CC all maintainers.
v2: Rebased onto current bpf tree (commit 56145d237385).
    v1 had a malformed diff header that caused CI to reject it.
---
 kernel/bpf/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da556..9e126be337 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1422,6 +1422,27 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off)=
;
 		break;
+
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
+				      from->imm);
+		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		/*
+		 * Cannot use BPF_STX_MEM() macro here as it
+		 * hardcodes BPF_MEM mode, losing PROBE_MEM32
+		 * and breaking arena addressing in the JIT.
+		 */
+		*to++ =3D (struct bpf_insn) {
+			.code  =3D BPF_STX | BPF_PROBE_MEM32 |
+				 BPF_SIZE(from->code),
+			.dst_reg =3D from->dst_reg,
+			.src_reg =3D BPF_REG_AX,
+			.off   =3D from->off,
+		};
+		break;
 	}
 out:
 	return to - to_buff;
--
2.53.0
-----------------------81832b4062254b605a50b68c2fbbdd90
Content-Type: application/pgp-keys; filename="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"; name="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"; name="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWTdKN3JoWUpLd1lCQkFI
YVJ3OEJBUWRBTkVzQVFrd2E0bU1TZlFIU0l2bXFZQjdIQTQvQVFabVoKcVpjOTlUZk9TRTNOTFho
amVXWjFia0J3Y205MGIyNXRZV2xzTG1OdmJTQThlR041Wm5WdVFIQnliM1J2CmJtMWhhV3d1WTI5
dFBzS01CQkFXQ2dBK0JRSmpzbnV1QkFzSkJ3Z0pFRGRGaE9rRjdoMjNBeFVJQ2dRVwpBQUlCQWhr
QkFoc0RBaDRCRmlFRU0xbHE1NlREL1VkT0p2ZjJOMFdFNlFYdUhiY0FBRTFuQVFDSjVZMUoKcU8z
SjkzTWRXbnJOMzRDYTNlaGRKVEVscTNkSFFPV04wcTIwRVFFQTZsV3JCakZ5aDE1cnNtMlJ5TlFO
Ckh5ZDlTNm5heG5mbE03WnJDRVVldndYT09BUmpzbnV1RWdvckJnRUVBWmRWQVFVQkFRZEFVMk9P
WTBHQwo2Q3pBQWJOQ2p4K05rc3AySlgzMHByWEpnWjZ4eFJHcXRIY0RBUWdId25nRUdCWUlBQ29G
QW1PeWU2NEoKRURkRmhPa0Y3aDIzQWhzTUZpRUVNMWxxNTZURC9VZE9KdmYyTjBXRTZRWHVIYmNB
QUdGM0FRRFJYSnd3ClZDbjAyRlhCWEhnRWZDNHV2Q09YTDUzVmRmMENaY210bFJFd3BnRCtOS2Jv
TWRrU2RlNHY2UVJXeldidAo4MmRmTzFBTHBuMnhscnQ0RkZvbjJBaz0KPWwxanYKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------81832b4062254b605a50b68c2fbbdd90--

--------8e1ef8504ee45c35c7941f4dbdbb323dec6839844634cbb4d6f3ef89d5514be4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmmvEJUJEDdFhOkF7h23RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmchV6NNotsjmfJ9bw4jWc0AzATvizGgY07pC5+v
t3UUMBYhBDNZauekw/1HTib39jdFhOkF7h23AAA15AD/bxFHl5jlyKwwUx4Z
ntfOsj682JVuhmllNNlzANMPY+QA/iwszmH6HfRLo4clcfgOztqDYnfKdsgc
N4N+3KY+VcsD
=xwtr
-----END PGP SIGNATURE-----


--------8e1ef8504ee45c35c7941f4dbdbb323dec6839844634cbb4d6f3ef89d5514be4--

