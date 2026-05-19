Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7120C461
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232630; cv=none; b=oiyyOW96FsPY7sr/omXNk294Hayx06RxM/VocoZzpYiT6TWYIz2fKil46R/OS+ikxVc4R92mTZDFkCYFQ6QmVR1PeYHPaye77/tVaK/MtbEn2A3flZuY5LFIazFW3CDi9j3DeLY601wpFI/F8zRzEHxY9s1L+Hl4ynLdU2YUyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232630; c=relaxed/simple;
	bh=Eb0mF10dPcBEAb8A+vklFm6/f/BAB5bM+kULHpJmTC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7b/AyUbO19kXn28VvgnU+Vn8MytZsY5Wc7/sRWFsFOeVZuZxgXdxCipeJbY7e0W9Ud1qh5SWawMnEMumngDkxRSJ8JAr+rgtX+KKaWpBLPueCZePRAngO9jD/56QhcroXQkFIG6ti7f48kpg7pSW7fsIjpQNVuRR+Gbx24GPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no75C2yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no75C2yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4561F000E9;
	Tue, 19 May 2026 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779232629;
	bh=6lTwbdt4erNMBMTDsdcpEHwDG7t1vTJ8YyiBoOIiq0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=no75C2yq7CHzxKpoIt/fddgZPFLeqauvV6ejRwMrHNzY8M5+eJ9SRbGaLolZ0vHyG
	 zDL+hZHecqOBT7RpAG5OHxMJH7D1Q/AvcDyAFOuWhIlbvVL4HDo8r7YmZ8AZ8Wd/pf
	 GIPQfSYys1xt3kwicDWJub7bDp9eGVub1ojBLiyky9ZkXcLrGmtxm5yPEzk3MJfDPN
	 5MIR2K+keTWT/Dl8yMYX3aiatQjZd4J+xv4vrz4oGplqDPJxrs+FBjIviJQzdkPgF1
	 lhEerB65Qwwa77SAkx7p3OhlEMKz1mqOMTqUVqK+BTkNv6vekNS9Aquz+v7BogbfUF
	 89maSXzWyw4QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, libbpf: reject non-exclusive metadata maps in the
 signed loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "KP Singh" <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215358.126364-1-kpsingh@kernel.org>
References: <20260519215358.126364-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 23:17:08 +0000
Message-Id: <20260519231709.3D4561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The generated BPF loader program uses a hardcoded 8-byte read (BPF=
_DW) to access the `excl_prog_sha` pointer field, which causes the BPF veri=
fier to reject the loader on 32-bit architectures and silently bypasses the=
 exclusivity check.
- [High] Branch target offset calculation is off-by-one, causing the jump t=
arget to land past the beginning of the cleanup block.
--

commit 51df41105aded76b418cec093cbbaaad09c03147
Author: KP Singh <kpsingh@kernel.org>

bpf, libbpf: reject non-exclusive metadata maps in the signed loader

This patch updates the BPF loader to verify that metadata maps are exclusive
while they are frozen. It places excl_prog_sha in struct bpf_map and emits a
check in gen_loader to reject the map with -EINVAL if excl_prog_sha is NULL.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d8..becfda5b90253 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -601,6 +601,23 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
>  		}
>  	}
> +
> +	/* Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE *=
 sizeof(__u64)));

[Severity: High]
Does this 8-byte read (BPF_DW) cause issues on 32-bit architectures?

Since pointers are 4 bytes long on 32-bit systems, the verifier will reject
the loader program with an access size mismatch error (-EACCES) because it
expects the memory access size to exactly match the BTF-defined pointer
size.

Also, if the verifier check were bypassed, wouldn't an 8-byte read straddle
both the 4-byte excl_prog_sha and the adjacent 4-byte ops pointer? Since
ops is always non-zero, the resulting 64-bit value would never be 0,
causing the BPF_JEQ check below to silently fall through and bypass the
exclusivity check.

> +	off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
> +	if (is_simm16(off)) {
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));

[Severity: High]
Is the branch target offset calculation off by one?

The offset off is computed based on insn_cur before emitting the
BPF_MOV64_IMM instruction. Since emitting the BPF_MOV64_IMM instruction
advances insn_cur by 8 bytes, and BPF branch offsets are evaluated relative
to the instruction immediately following the branch itself, the actual jump
target evaluates to cleanup_label + 8 bytes (1 instruction) instead of the
cleanup_label itself.

This skips the first instruction of the cleanup block. If nr_progs > 0, it
skips loading the first FD into BPF_REG_1 and calls sys_close() with an
uninitialized or stale register (e.g., a map pointer), potentially closing a
random/incorrect file descriptor in the system. If nr_progs =3D=3D 0 and
nr_maps > 0, it may jump into the middle of a 16-byte BPF_LD_IMM64
instruction, causing verifier rejection.

Does this need to be adjusted, even though it appears to be a pattern copied
from the loop above it?

> +	} else {
> +		gen->error =3D -ERANGE;
> +		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215358.1263=
64-1-kpsingh@kernel.org?part=3D1
