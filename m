Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486547F2F9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905655; cv=none; b=nT0X0JqArZ5AqcJsPWJbT/iUlt6EIlh/lh02Gl9HA2VN1qsX8vRZZuwjWhm1G/6hXUdCcbXve5QmuESywmjJIv+fgw7DM3dplmT7jAalhP1/ww62JiGxKV+nCK2a73t3ttBJidH6523vIOxjey7l5xFsgF30iYV1XFkAn//ZX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905655; c=relaxed/simple;
	bh=nqBiTM4PH3sdLpXt2WGKtE5y9C3AF8oVbzARWp28LZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NywFRluU/kNsdyrj7rUhkR3sEHrn5KCMZIJIvKKGz3DOiWDJoBVbPoIG29J39VC16hb2dW7kKfvxNDx+9g0O8agsaxzNS7uEFKU96UUI/tZbktiKqEfMPZzxmsTnPSqA4ycEyO1fJ4iL2N6I9uXBdZk+GiKcHpj92HOkGWlBcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhtol6yQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhtol6yQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8372D1F000E9;
	Wed,  1 Jul 2026 11:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905653;
	bh=yq2bQJbNDiOUnzueYqK+tAZTxt7xi6z+jahkrQ/uF50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhtol6yQ/xiUJyu8BAVZDv4weC+rQDWGoZPW1dSBOmWnRVRmaXCbsh0j489JFnoyb
	 gy8iWq9qkbPMJODF30jEtn6vspZxW7XWmtTr7g8w1YTfmkQrvKC0+E77e8ga2iNhG6
	 U/qax83QeWbPCuhDsB2ZKkD41YxhtNt0bQ44b09PvghVD5PnjjFenSQIs+7PItvdNH
	 FlUx8MOtZdPgyvRlZ9D042r/kfnjTqAA3TT0fFI8pzv5b3nh9BzaJfvj2UG8fZG3Hc
	 9gZV1PNSgHN79p4+q18sXwZsu1rP2Tfk3dWyl2wODDjbJNrW4vGNtiVUUw1efHig6C
	 ZTOLwMDSNXaOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701111337.53943-7-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <20260701111337.53943-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:34:13 +0000
Message-Id: <20260701113413.8372D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch breaks USDT optimization selftests and functionally fail=
s to enable the optimization because the kernel does not support optimizing=
 10-byte NOPs.
--

commit 7b26e4395329f0d2e4ebce57947c8615c8552ea2
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Change has_nop_combo to work on top of nop10

This commit modifies libbpf's USDT parsing to check for an 11-byte NOP
combination (nop + nop10) instead of the previous 6-byte combination
(nop + nop5). The intent is to leverage faster uprobe handling.

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 57fb82bb81b58..d2ecd3daab961 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
[ ... ]
> @@ -604,14 +604,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] =3D {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] =3D {
> +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	unsigned char buf[6];
> +	unsigned char buf[11];
> =20
> -	if (pread(fd, buf, 6, off) !=3D 6)
> +	if (pread(fd, buf, 11, off) !=3D 11)
>  		return false;
> -	return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +	return memcmp(buf, nop_combo, 11) =3D=3D 0;
>  }

[Severity: High]
Will this modification break the USDT optimization selftests and prevent up=
robes
from being optimized?

The BPF selftests still emit a 6-byte NOP combo:

tools/testing/selftests/bpf/usdt.h:
    #define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x=
00, 0x0 /* nop, nop5 */

Because libbpf now strictly requires an 11-byte sequence, it skips the
optimization for existing tests. This causes subtest_optimized_attach() in
tools/testing/selftests/bpf/prog_tests/usdt.c to fail its assertion:

    ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");

The assertion fails because the uprobe falls back to an unoptimized 1-byte =
INT3
(0xcc) instead of the optimized 5-byte call (0xe8) at addr_2 + 1.

Furthermore, if user-space were to emit the 10-byte NOP, is the kernel curr=
ently
capable of optimizing it? Looking at arch/x86/kernel/uprobes.c:

arch/x86/kernel/uprobes.c:can_optimize() {
    ...
    if (!insn->x86_64 || insn->length !=3D 5)
        return false;
    ...
}

Because the kernel strictly requires the instruction length to be exactly 5=
 bytes,
a 10-byte NOP will be rejected for optimization. The kernel will fall back =
to an
INT3 uprobe, meaning the intended uprobe syscall optimization is not achiev=
ed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701111337.5394=
3-7-jolsa@kernel.org?part=3D1
