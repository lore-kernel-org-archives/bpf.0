Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1A4AFE27
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443146; cv=none; b=lQPEy4+MahirHK6HizCZ0NudShhd0WzpwTQH1YO3s8lMsiEAsUNNiUMQhpW+RiQMKOCA/d9NRiPpvtMZeQvsHNT0MIU0eAx1fZD4J/LYW+X0sI334fkWVFEex2YRJ7DHq3LQ19E4Z1Gp0TBDgh0xAm2pF9GKtUVw69ibsDkuDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443146; c=relaxed/simple;
	bh=LI6L7Q7hBMemqMQ7Iub0WhzMoX/7Eb04AV8cLdnYDkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVPdJX1JgaRV7dCbsqGfIvm/m6zco9r1UW4hTQoCzWQU6aDnsBMvp3THoR373N3EbTCV6vuIvrOS0SJJehHE83g4iJJxjEftspQhftDVjW1m2RnQgiktK50VovmTJnUaGm6lcMJX9AbKu83c0IJhuqqjCA/nm/LQI9PTCDl8cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C03erxpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C03erxpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6D71F00AC4;
	Thu,  3 Sep 2026 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443114;
	bh=VST5z8Ch4ySGW0QUGX7i9MPXPBksEKt7gG2lXHIJN7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C03erxpYrL35ObODWyVCViFb2LzpQWUU4OJf0lAtcrENlmtpBBOuoBTnM+d7zACYg
	 x1f0aspsj90PZnlUUgxJ2jJ6GgUsIpU1i0kSalYOi6zRxF3cGscHwXEaFMJrfWLnhK
	 Nz0BSy5LmSj0Q8t/ikW7z1ghNnKuYNb+VKu/sBIkfEjV5WzHF0cSIkGuj0FOlVEIh/
	 VEHZ97jogMlFdadTw6shP1n8wRJI+gd5A7EzNZdS+8Lqlw9ZYMmqp7VxTYEDq0ak+X
	 zFIcfkkXYwP51p8673POo9X94+lWq9YcJIHDOXxCQrp23VZGHT8rSMBlrVb2mdUVpB
	 imkvZgaiBsEGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: disasm: guard print_bpf_insn against BPF_MEMSX |
 BPF_DW
Reply-To: sashiko-reviews@lists.linux.dev
To: "Utku Erol" <utkuerol71@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903133434.17860-1-utkuerol71@gmail.com>
References: <20260903133434.17860-1-utkuerol71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:45:14 +0000
Message-Id: <20260903134514.AA6D71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds a redundant check for `BPF_MEMSX` with `BPF_DW` s=
ize that is unreachable dead code, because the preceding `if` statement alr=
eady checks the exact same condition and returns.
--

commit ae7a2255ead6c3e59e5776083e563c01d78b10e7
Author: Utku Erol <utkuerol71@gmail.com>

bpf: disasm: guard print_bpf_insn against BPF_MEMSX | BPF_DW

This patch adds a check in print_bpf_insn() to reject BPF_MEMSX instructions
with BPF_DW size. It intends to prevent an out-of-bounds array access that
occurs on unvalidated instructions during disassembly.

[ ... ]

> The LDX branch checks only that the mode is
> BPF_MEM or BPF_MEMSX; it never rejects BPF_MEMSX | BPF_DW. For that opcode

[Severity: Medium]
Is this description accurate?

Looking at print_bpf_insn(), the preceding check in the baseline code alrea=
dy
explicitly evaluates and rejects the (BPF_MEMSX | BPF_DW) condition.

[ ... ]

> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index b1a3fbe3fda53..7c24136268026 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -300,6 +300,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
>  			return;
>  		}
> +		if (BPF_MODE(insn->code) =3D=3D BPF_MEMSX && BPF_SIZE(insn->code) =3D=
=3D BPF_DW) {

[Severity: Medium]
Does this code ever execute?

The immediately preceding if statement checks the exact same condition:

	} else if (class =3D=3D BPF_LDX) {
		if ((BPF_MODE(insn->code) !=3D BPF_MEM && BPF_MODE(insn->code) !=3D BPF_M=
EMSX) ||
		    (BPF_MODE(insn->code) =3D=3D BPF_MEMSX && BPF_SIZE(insn->code) =3D=3D=
 BPF_DW)) {
			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
			return;
		}

Since the previous check unconditionally returns, won't this newly added bl=
ock
be completely unreachable dead code?

> +			verbose(cbs->private_data, "BUG_ldsx_%02x", insn->code);
> +			return;
> +		}
>  		verbose(cbs->private_data, "(%02x) r%d =3D *(%s *)(r%d %+d)",
>  			insn->code, insn->dst_reg,
>  			BPF_MODE(insn->code) =3D=3D BPF_MEM ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903133434.1786=
0-1-utkuerol71@gmail.com?part=3D1
