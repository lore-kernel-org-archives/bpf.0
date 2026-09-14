Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5E47A0C0
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394934; cv=none; b=a1jwDDMr0CJcNCt8D4b0HpA17aUO+e7IcPhTUOkl1GiaAZVtVMy8i2qLaOP5fRg4x/p0l6x6rWN1B/T4CST6fFgdVdqiTbtjkNpuKP3NlLExaR07zTq8oftvjmRmTGe1RWkEuMrbizZreO4hIQed4orCDusJZN78FSn1oUW+QDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394934; c=relaxed/simple;
	bh=lq9fId4vO2F7o+pTOkEfb6g5tEsyvT15Owfa5/yevX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OT+A5aUjsdBpFarv+YRrRHAeQhgcvX/6dTR0+O9WasFWI4ONIAVQ8GPHOArxS2CRnyFYferxCRgqASV5x8+UyhBRtkQVAfGK2asM6XXfzOCw33kCWp1IH6Dc6X7H7ojGmx3L2Kbbh7XVNFbLvw6Ad3Q+/DVF5nG7NsmIoBS+7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX4n6xcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX4n6xcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA21F0089B;
	Mon, 14 Sep 2026 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394932;
	bh=ibEOzuZWegw+SEdTUiZbG5RYlkU53GC3c/1eKpkzDuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KX4n6xcuslrrAQzRDGba0tbqy2esKHubDfuwWqJ9j1mw6wdJBGhJOpCUFchFTf9Kg
	 5n0hS8RPQO3W8owr6NxbivFyYNEcWJlImQZCInTRkXZCGlvA30zRPyrpKI5U6lGAT5
	 TUMUzAEmRCJ3uNSJhEXKRbgiFjOToOP7FIUt1z77EpfEjKcU3NRgKtaLXvXvWP4tK/
	 1tM3EQuvtSFZpx5v+h1gV75+CBi9i8/oOsr/IePF6AhZM1T80OIOb4Yy+BOwAo4/36
	 /lVREoDnllHsybwHcGW2xlgoPeQ3ffmP/GYYy1GfEYahT6nUpQLUtQIdyth5e6I8wl
	 J/fwelrnm/lHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260914131701.2529725-5-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
 <20260914131701.2529725-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:08:51 +0000
Message-Id: <20260914140852.03DA21F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap out-of-bounds read and write in libbpf when processing CO-RE =
relocations targeting a truncated ldimm64 instruction at the end of an ELF =
section.
--

commit cabdc155b3a9211d8b18a8961e8dcf7e4bc6ae61
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Restrict CO-RE poisoning to relocatable instructions

This patch restricts CO-RE poisoning to relocatable instructions. It handles
instruction poisoning after the instruction has passed the class and operand
checks, preventing unresolved relocations from altering the control flow by
poisoning instructions like exits or jumps.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 8ad2715721cfd..a884bc2bff198 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[ ... ]

> @@ -1140,6 +1133,9 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
>  			return -EINVAL;
>  		}
> =20
> +		if (res->poison)
> +			goto poison;
> +
>  		imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);

[Severity: High]
This isn't a bug introduced by this patch, but can this code cause an
out-of-bounds read?

Just before the new poison check in bpf_core_patch_insn(), the code validat=
es
the BPF_LD instruction:

	case BPF_LD: {
		__u64 imm;

		if (!is_ldimm64_insn(insn) ||
		    insn[0].src_reg !=3D 0 || insn[0].off !=3D 0 ||
		    insn[1].code !=3D 0 || insn[1].dst_reg !=3D 0 ||
		    insn[1].src_reg !=3D 0 || insn[1].off !=3D 0) {

If an attacker crafts a malicious BPF ELF file where the final 8 bytes of an
ELF section form the first half of a BPF_LD instruction, prog->insns will be
allocated to end exactly at this half-instruction.

When processing a CO-RE relocation targeting this final instruction, would
evaluating insn[1] lead to a heap out-of-bounds read?

[ ... ]

> @@ -1164,6 +1160,16 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
>  	}
> =20
>  	return 0;
> +
> +poison:
> +	/*
> +	 * Only relocatable instructions reach here. Poison both halves of
> +	 * ldimm64 so the verifier reports the bad relocation, not opcode 00.
> +	 */
> +	if (is_ldimm64_insn(insn))
> +		bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
> +	bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but could this poison logic cause an
out-of-bounds write?

If a relocation targeting a truncated ldimm64 instruction is unresolvable a=
nd
marked for poisoning, execution reaches this poison block. Since
is_ldimm64_insn(insn) only checks the opcode of insn[0], it will evaluate to
true.=20

Could bpf_core_poison_insn() then overwrite insn + 1 with a BPF_CALL
instruction past the end of the prog->insns array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914131701.2529=
725-1-memxor@gmail.com?part=3D4
