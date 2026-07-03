Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BF3CC315
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080194; cv=none; b=ZesGaQCewYNq3jFcXoGf2snOg0XEfeYinX6a+AqTSd8OF0Z9MVJWQO15GrwQ3FsUH8WXjK6IWGnqMWSkY1iLimg8sPvmQG+L3CMV24mH6hYVcKbBrZh8AjhFuCUjeUfvJwClm5GfKADS76hcfj34vsVh2pxHjzA+/R1vX+85g2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080194; c=relaxed/simple;
	bh=nLSQhKnsUKfopwdwB5pflgZdjNo79miPQwnsVq6o+7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJ+3sVNpOVNDRScsRh5YwJePlO5X6gn0OHZ8E4DHzQTEnpUvkIydHiOLdWUD90nEg0vgSh+5UH7mtz8//LU3KXKk57sL4sdOat2+jedffBbhOXMQAk7QJ87XcKtAnCx+6H4YxmXTaPlNFtwRnW/0Y820eW5m8m03aYzeKWkqziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/bZwdPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/bZwdPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D671F000E9;
	Fri,  3 Jul 2026 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080192;
	bh=v9SwGqlrvqmj46UZJ7mcortrHWAZ5QuNcxDAeg6RtXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/bZwdPIP3d5i13aPwzDaNg05azP6iLZjGpICQZMNeMMX6iLPYP7C7AkPNJXey0Cy
	 d7WbMQ5gXqSJlilNQ0IlBXJG1tFDaNr8RwQ0AU1SUyE9hsH3cJwafvBNJs7f3QFGF3
	 dLoU/V8NEoD3ph+/6H5vdwDh0P/yRAXqRrRV9n2xIxt6ncHZv/KkjCKU5qdI6Y5D5/
	 /SY8/eeDELeWv5Iz2V81liDlOnCE0yScAB6e4JeGVy95VQ+gRW2hLH6dQ0YnzEXcsc
	 uqLoG7t6hRnc09ZK6wGyj85CRoDNHIWIxJV/y/mhugBPlkiT2+0v6wE93SO7zwWF/r
	 fQ5hhfldX5ubw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 08/13] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260703114917.238144-9-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:03:12 +0000
Message-Id: <20260703120312.98D671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete update of USDT_NOP causes selftest failures and silent =
loss of libbpf uprobe optimization.
- [Medium] The x86 uprobes subsystem does not support optimizing `nop10` in=
structions, contradicting the commit message's claim.
--

commit 0e159bff3c4759d25ce27fa625273c5dc59c418b
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch

This commit updates the USDT_NOP macro for x86_64 to emit a nop,nop10
instruction sequence instead of nop,nop5. This syncs the latest changes
from libbpf usdt.h, leaving it up to the library to use the desirable
nop instruction.

Link: https://github.com/libbpf/usdt/commit/9018f82577d1dad7ed628d9efdaffc0=
9f8f2241b

> Now that we have nop10 optimization support in kernel, let's emit
> nop,nop10 for usdt probe.

[Severity: Medium]
Is this description accurate regarding kernel support for nop10 optimizatio=
n?

Looking at x86 uprobes in arch/x86/kernel/uprobes.c:can_optimize(), the ker=
nel
explicitly restricts optimizations to 5-byte instructions:

    if (!insn->x86_64 || insn->length !=3D 5)
        return false;

Does the current kernel actually support optimizing a 10-byte nop, or will
this fail the instruction length check and refuse to optimize?

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> index c71e21df38b32..75687f50f4e21 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
[ ... ]
> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1=
f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */

[Severity: High]
Will this incomplete update cause selftest failures and a silent loss of
uprobe optimization in libbpf?

The selftest suite in tools/testing/selftests/bpf/prog_tests/usdt.c expects
the old 6-byte sequence and will fail an assertion when it cannot find it
in subtest_optimized_attach():

    addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
    if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))

Additionally, libbpf hardcodes the old 6-byte sequence in
tools/lib/bpf/usdt.c:has_nop_combo():

    unsigned char nop_combo[6] =3D {
        0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
    };

Without updating these locations, won't libbpf fail to detect the new
11-byte sequence, causing it to fall back to the 1-byte nop which cannot
be optimized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703114917.2381=
44-9-jolsa@kernel.org?part=3D1
