Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37572FD665
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078647; cv=none; b=rMFBp/rbl9EV8K1owM9c3C7KnkmrN8rLI0ht9wwi3pRrv2mILcF7CcI0JZcYS8jqu7/9HkEoHNnk/luftRL5rQ1uDMbS0h5ino79GLrycE6F/mD5+Q3ynvdQaOchbYZxKOscZmiu8lxDDK4GrQsi2H34MO1HfFbCH6qwIe7t+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078647; c=relaxed/simple;
	bh=VshT7Vq3c5zGynCinrsS3vb7XLVkUIJLBqUJR7attjc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=meEYvkCTArlRDVKIIK8XfSSyWKT7mupdmyTekQFWWxcKrv9olGxMIim5wCMXj8RsaC344pPWFqPjkZ6hvdogF7vKV++OR/xv+NAmv2wdvtXZ0EWERV+qTSMPPPfB/ktLZgWovx5zv+qto2O7ysz1FHO0xScsFgWPf1/xFUX3nqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=c5jLyZz7; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="c5jLyZz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1773078635; x=1773337835;
	bh=9griTMnJyaBpxwmATvAiBepoJAgeJ3ngdZVcHM4W3fA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c5jLyZz7GkFMnnlYFTYt+f+nFXDjVf/cFr4YCSWmFh903CvXPjmaNeW9wtsmFeHSZ
	 ER6RWNVbJZeo3Cp/jZ5jMT12PBUXpBCPk0L2/ZXJLwsifKdqcpC6/hlZzfuSKM9eY2
	 tzfbeZREpxVHB3xDpIJctP8AisYUr3CWUGkTTMLYGribo0cZTadaON2it79zVxPnse
	 uo3SAsJVYBC14awpkUegfxxtWz5/z2cXeQhicadOnyaZT2Kf0z3/LQah+DcqW32QOu
	 Ua8jYqsZypu/QIsN+QuCny7UnMgP8p+M42H9B1YtOaT6Qpkid//kdPehibUoH16ThL
	 G9P8nCjhz1G0A==
Date: Mon, 09 Mar 2026 17:50:31 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Sachin Kumar <xcyfun@protonmail.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "haoluo@google.com" <haoluo@google.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, "puranjay@kernel.org" <puranjay@kernel.org>, "emil@etsalapatis.com" <emil@etsalapatis.com>
Subject: [PATCH bpf v3] bpf: fix constant blinding bypass for PROBE_MEM32 stores
Message-ID: <S17sb-p71I59mreLZe4X_OOMw-HYrBr5vgnqwkKot5DN69iGriLx77wet16-_Hy7FHXKoCPwjc0zAy3G7o1C0A3amEpSPwVStZOF7x9qaig=@protonmail.com>
Feedback-ID: 42070492:user:proton
X-Pm-Message-ID: 194f8e61108226c429f71594d66a8adb7671cdbc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a
Content-Type: multipart/mixed;boundary=---------------------c6870ddadfc9ab00f0b0b3e6ffacd203

-----------------------c6870ddadfc9ab00f0b0b3e6ffacd203
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
v3: Use legal name in Signed-off-by per DCO requirement.
    Fix block comment style (trailing */ on separate line).
    Added Reviewed-by tags. CC all maintainers.
v2: Rebased onto current bpf tree (commit 56145d237385).
    v1 had a malformed diff header that caused CI to reject it.
---
 kernel/bpf/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55..bb2fa75de 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1422,6 +1422,25 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
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
+		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX,
+				      imm_rnd ^ from->imm);
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
-----------------------c6870ddadfc9ab00f0b0b3e6ffacd203--

--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wroEARYKAG0FgmmvCFgJEDdFhOkF7h23RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmedqL3CgZ4ZUEXfoY6eDqehB1/GCnBVpLeLq1mU
zoJMBhYhBDNZauekw/1HTib39jdFhOkF7h23AAD1KAD/RDgb+FMiAUZ5/pwF
fjmEBBAzTfGjYBUg6ro2yAYXjQwA+NjoGO2hYnjb9nk/DX1g/5Jg9nzCFiKK
Upy67eJAmws=
=XdT+
-----END PGP SIGNATURE-----


--------a5267023e7a579fcb78ee15134eb3219a56b5c271ca989a81a542099508d204a--

