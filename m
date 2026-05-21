Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B813CB8E6
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369683; cv=none; b=MIhopZzTWAiwsgPEuRp2iZCn0OGzyChcEfRlXDO6GoYbySdWni46m7jmL0BsD+ydBGti87TeEEv/zBKkOjVtOrirx8GQoNdsg3qLLPEqEiSu9PRfkvfEp6TwNPffF0PqcDTwf9/wIhQMDI7Bthmzee6kr/U+kedHHqxTU9CBI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369683; c=relaxed/simple;
	bh=/KxY14YEYRjc4HzFMWiE15gGMXdFnnqluz/OXKFdIB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uPVxkw2yEsOEuV0POe6Pk83CHAeqIQ9w1TBp0OMqXfLE8t9kWz1+vxkYGHHC3DX5YWcDBiyNssvQNSnanyeyGeHHP+pT1xP0ROQ8s8tpnnNI9FUIcQczjczwyClX1JTo1Ti5k/Pou0H7oaH0TX7rcdxe2Xfqjw3TKwJ+3gjcSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0rkyi0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0rkyi0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB4E1F000E9;
	Thu, 21 May 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369682;
	bh=MIl0ZSZQXuPSuF0oi1Wq3pspuYqRJroLcSQNmSnqhd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0rkyi0fCwUcjKaRct6KbEDQRyo5J8tp8PHfdyBMCwrB7Js1yL1IPLfB8at9AutMa
	 znaAz+lPKxhIyCSd7iIEQZTaIg5f5xU62ZaV1mBgsi9Ti5zrzvQ/QmYGBJVGF/sTby
	 Um6xFfokl+3/+xLpCJqeKZ2DvYFaWMz01IkxR/Dscf7bjEpaK+vGV9jFUG2Axa6UJP
	 UUkKDwOivRIR5oWgvHdqHlKVrSPmUeZSnR2I7mrR7UgPn3MezIs8uXFX8tRE8p5LWD
	 iKZd4iJcSKnOEGaQd16Ptk+4ypU559Kc3qsIy3EzK19DrxBjy7Oj0hNFzcDa+Oarl/
	 HauVWEdccmQ2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521124411.31133-8-jolsa@kernel.org>
References: <20260521124411.31133-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:21:21 +0000
Message-Id: <20260521132121.EEB4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Changing the USDT_NOP macro to emit a 10-byte NOP breaks libbpf =
discovery, disables kernel uprobe optimizations, and relies on an architect=
urally unsafe patching concept.
--

commit 963f950434fd00b2b52a00da58d5968fea9d4ebc
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch

This commit updates the USDT_NOP macro for x86_64 to emit a 1-byte nop
followed by a 10-byte nop. This is intended to test new uprobe
optimization support in the kernel.

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
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

[Severity: Medium]
Does this change to a 10-byte nop break the libbpf discovery logic?

Looking at has_nop_combo() in tools/lib/bpf/usdt.c, it seems to
explicitly check for the 6-byte sequence (0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0=
0).

If has_nop_combo() returns false, the target IP won't advance to the
multi-byte nop, leaving the probe at the 1-byte instruction.

Since the kernel's can_optimize() in arch/x86/kernel/uprobes.c requires
an instruction length of 5, does this cause the selftest to silently
degrade to the slower int3 breakpoint path rather than testing the
intended optimization?

Additionally, is it safe to replace a 10-byte nop with a 5-byte call on
x86_64?

The 5-byte call pushes IP + 5 to the stack. When the uprobe trampoline
returns, execution would resume at IP + 5, which lands exactly in the
middle of the 10-byte nop sequence.

Could those remaining 5 bytes (0x00, 0x00, 0x00, 0x00, 0x00) be
incorrectly decoded, leading to unexpected behavior like memory
corruption or application crashes?

Would using two consecutive 5-byte nops instead of a single 10-byte
nop safely provide the padding needed for a 5-byte patch?

>  #else
>  #define USDT_NOP			nop
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521124411.3113=
3-8-jolsa@kernel.org?part=3D1
