Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CE477E48
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905193; cv=none; b=PIOWd7MBfJQ9Y3kzOZ3/yYgux//y1mRsXo7Q1KTQxZhRrX6PnWDXHKOjnYwg8GZxWUx74NpyVanlCViOooOji/jvFa9KAeMc9LOvLrwlPuR1L1aeKbYttgVjBZxPjBQUlfhAhC4yC78dWMos2o5lLKCqTyOYwwUjLCL2HXnEaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905193; c=relaxed/simple;
	bh=QQ0h8tHZCN95thSrFIvN0UO3SbViqfAUA3A6R/BSXcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FuzKMBtfk0bhSefNuT/TWEz8qaI1PiH1E0A+MMCigT0wF/4gSmW0yLGy9sTY5EVbZVLlh9KxZDExNrfKClfb3aWk48H8Tf4uL0hJfmKqaQ4JFbcqHGRQMCSpWIj0xc+POfg+yy6JIU9Hd8M7loVoWE+70g/p6+h2O7Q7FeCwg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbwffGUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbwffGUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB3C1F000E9;
	Wed,  1 Jul 2026 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905190;
	bh=tFC6AcKg6+NqF4EeLbDq1Lr9QTZ/Mn1gEiJJIW0h1fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbwffGUMy7QNVspYindmtoJlnFrxYbwn01JDnbbEY3qgEsrXQ5ALfhaw2ldztWxBD
	 PmnqFOgn9DZyL9+ikU/FbedYAK4LvaF2rjBk0husr9llNmx8qR6QLPH9Mspe0hXSqP
	 Om4WdyJTyLAP6IW/Q4F1iQvmgOv3j5JNwnmzgIZvzDK6cEA7oEAu8rJkKaIf00IeTf
	 1/4lzDuCtTV7w343za0HT72Z5YfHQX5GB+eloxx1V05FC3qvmJyGCgO6hpMPru+7EK
	 NJRwL6lWi4Epo27ZuuUiB3I841+R11nAeLsDlWbWFmP2fNnrdYrmib+ID+2MDDZYut
	 4JJd+UkeCj0EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 08/13] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701111337.53943-9-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <20260701111337.53943-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:26:29 +0000
Message-Id: <20260701112630.6AB3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The change to default `USDT_NOP` breaks `prog_tests/usdt.c` and fa=
ils to achieve the intended optimization because `libbpf` is not updated.
--

commit 94041e33868287f19cab80050a0ae7ab5dca238b
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch

This commit synchronizes the latest usdt.h changes. It updates the x86_64
USDT_NOP macro to emit a nop,nop10 instruction combination to utilize the
new nop10 optimization support in the kernel.

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> index c71e21df38b32..75687f50f4e21 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1=
f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */

[Severity: High]
Will this change cause the usdt selftest to fail?

Looking at tools/testing/selftests/bpf/prog_tests/usdt.c,
subtest_optimized_attach() hardcodes a check for the 6-byte combo:

tools/testing/selftests/bpf/prog_tests/usdt.c:subtest_optimized_attach() {
    ...
    /* usdt_2 USDT probe has nop,nop5 instructions combo */
    addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
    if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
        return;
    ...
}

Since USDT_NOP now emits an 11-byte combo, find_instr() will return NULL
and fail the assertion.

Additionally, will this break the intended uprobe optimization in libbpf?

In tools/lib/bpf/usdt.c, has_nop_combo() only checks for the 6-byte
combination:

tools/lib/bpf/usdt.c:has_nop_combo() {
    unsigned char nop_combo[6] =3D {
        0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
    };
    ...
    if (pread(fd, buf, 6, off) !=3D 6)
        return false;
    return memcmp(buf, nop_combo, 6) =3D=3D 0;
}

When libbpf encounters the new nop10 bytes, it will return false, skip the
optimization, and attach the uprobe at the first nop byte. Should libbpf and
the selftest be updated to recognize the new 11-byte nop10 sequence?

>  #else
>  #define USDT_NOP			nop
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701111337.5394=
3-9-jolsa@kernel.org?part=3D1
