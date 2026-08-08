Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC233B2AA
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786217996; cv=none; b=P+R3yTVCaRxK1+s6ZfgIZR3w3cCdTL+hjET6FJf+F77jRv+GBQHYt8l+VnA10UjmyWoO6rZgdc9n6yLwIzVTfV1sFkHycynIQWJao1SrTjCV1sbjHk0z22maNAVt0L6OVOA1GaXCQp/ePaYwlJ5Aar5KJWmKTEFzNu7DvQ0cK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786217996; c=relaxed/simple;
	bh=WHkDsABucT5yl/5TisurhtYbpJdtF3MqQmJQLcbQZvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsQwnZ+y5ZmjJY6g1Tccr9lc57ayeL983a36yZ8TejsyAt0VKtjsbAix3XGuM5qDH70aDx5yHxnLRg27a7EslTX849A+CNbck4z7hyd4qx8wpraLxJbrw/ERqSZnHg1hacaXgWOR6nhzm63Xu37Q0JZsUx0k6Qqy2EO1wxpRx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS+MNpak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS+MNpak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645B91F000E9;
	Sat,  8 Aug 2026 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786217994;
	bh=Ab2s9HG4ezmiIuGdj6emDdQAZDiOw6MsWSDHL9OFTXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZS+MNpaknsdXW4J0yyVwUopLHpP2JHJNKIRi9GkMXfHl0osBqflvktSPhZAU3OG68
	 ODXsGvBHwad8bpw/EAo12dT1sVpZn0RBIHD0Cn1ybgULkUEtGnEjTrn2WO8GRIkJ1Z
	 +5I6acAK7jKudDJSthVCtic7pRm+HgFYLOYwQl5cHdAKTp3HV3a+McpnZV4FpkY8DD
	 OQUmFyFfwBi68sEp7E0Yw4iNh3ls1Rf9MClJdB1V6UptZzlpK/XGKqiIQTsjQshkrk
	 okbgGuJOhqBDXXZk1QGgn3qWjEZ9dTwr838+8pi5plCmSvhwhbsH372STF1ocWd1wL
	 Y/O3naP/l6S7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Wire up JIT support for 16-byte
 kfunc returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808190337.1898362-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190337.1898362-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:39:53 +0000
Message-Id: <20260808193954.645B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized kernel register state can be leaked to BPF programs =
when a kfunc returns an aggregate (struct/union) between 9 and 15 bytes in =
size.
--

--- Patch [3]: [PATCH bpf-next v3 03/13] bpf: Wire up JIT support for 16-by=
te kfunc returns ---
commit f2df1b40e2f3eb74688d20cd37742fe85c667da9
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Wire up JIT support for 16-byte kfunc returns

This patch adds JIT support for returning structures up to 16 bytes from
kfuncs in the BPF R0:R2 register pair. It implements the necessary RDX to R=
SI
move for x86-64 and adds opt-in capabilities for the x86, arm64, and riscv
architectures.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8dddb5d7af21b..01c34114c8502 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -2647,6 +2647,22 @@ st:			insn_off =3D insn->off;
>  				return -EINVAL;
>  			if (priv_frame_ptr)
>  				pop_r9(&prog);
> +			if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> +				const struct btf_func_model *fm;
> +
> +				/*
> +				 * A kfunc returning a >8 byte aggregate hands the
> +				 * second half back in RDX (the native ABI's second
> +				 * return reg), but BPF expects it in R0:R2. BPF R0
> +				 * is RAX (no move needed), while BPF R2 is RSI, so
> +				 * copy RDX into RSI.
> +				 */
> +				fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
> +				if (!fm)
> +					return -EFAULT;
> +				if (fm->ret_size > 8)
> +					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);

[Severity: High]
In do_jit(), when a kfunc returns an aggregate between 9 and 15 bytes in si=
ze,
could this 64-bit move leak uninitialized kernel register state?

According to the native ABI, the upper bytes of the second return register
(RDX/BPF_REG_3) might contain padding and be uninitialized.

Since the move is a full 64-bit copy to BPF_REG_2, and the BPF verifier all=
ows
64-bit reads of BPF_REG_2 without zero-extending the padded bits, a BPF
program might save the full register to a map and leak the uninitialized by=
tes
to userspace.

Should the JIT mask out the uninitialized upper bytes of BPF_REG_2 when the
return size is between 9 and 15 bytes?

This same question applies to the arm64 and riscv capabilities enabled in t=
his
patch, where the native registers (x1 and a1) map directly to BPF_REG_2 and
could similarly leave the upper bits unmasked.

> +			}
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190322.1896=
580-1-yonghong.song@linux.dev?part=3D3
