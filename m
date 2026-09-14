Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F847CC75
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395357; cv=none; b=FLxCARZeosSAwdla94/K71mG1f7bGW8WJzZoFAR1FcwTD/J46kPoaXrx6LFvx1Flwy0W1DRKhDETFy/u3rI57sCacK1mNwToF6G7a2xBON2XpDglgf2QuxlEC1dlz2kkngz25Od5gTS8Ja8EAs+0US8xH+SuNHiEjA9RWSC4ytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395357; c=relaxed/simple;
	bh=29WG/dDEAp7YBs1oF/uh9i6/uMvC/LlQED7HsAjuhqI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iv5fRMcxuy+O1m3n8+fMQclYsRnYXPZkC/x4vofG4uLhFo8BeAMFTwwtN8shU5O43kj62L2WL7kM64UlWd0/8OExMlFnRxqs+Dj5BKtdR7nl1rbTW9hMDhtjO5MOM+QbacE3EWKFetotRY6TPkMhPkBqaZJ7lYkFZfrHIYOf0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IExlmsUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IExlmsUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A41F00898;
	Mon, 14 Sep 2026 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395355;
	bh=OTi4noIVxdVluqQgGMQtHVPuYFOjF/WubTdIvvK7ZmU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IExlmsUS4LiGJIQvCHGvGwMXFdaf39z71Aa8i0KPMqbcnLCOgJJhspzn9duXa0eX/
	 O0zCvgXVsKSCRSHAU8u4dTj+79zhwZQ9McBgXJYba/X+hh1ejTOR+jsvvnCVb6GIxb
	 zejdUDh3DlOEmy9kxn1Ojr062hUBrrZHKJRht9b/AMUiNMEf05+Kd/sJrnq/Yo7L6a
	 rqWtY5vZTB8dVkDy8VGWJSbaC5uj7rEEJsQMJ+AnVOdJ6+z0Bz2/4ksYCAGRf7mdY+
	 JpnuV4Pmc2oNDQEcAKr/XU2NPX0r82/eyae/CWsOfjKTBVWmfKjdjernG2NYDbGvfl
	 /xbdTD5AYsKRQ==
Content-Type: multipart/mixed; boundary="===============1683806218629715175=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5f571dcc350b1f28f4058988abe4a0b8d90efc1eeb6e83100f34a21953cbdfa@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-5-memxor@gmail.com>
References: <20260914131701.2529725-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable instructions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:15:55 +0000 (UTC)

--===============1683806218629715175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 8ad2715721cfd..a884bc2bff198 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1047,17 +1047,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>
>  	class = BPF_CLASS(insn->code);
>
> -	if (res->poison) {
> -poison:
> -		/* poison second part of ldimm64 to avoid confusing error from
> -		 * verifier about "unknown opcode 00"
> -		 */
> -		if (is_ldimm64_insn(insn))
> -			bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
> -		bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
> -		return 0;
> -	}
> -
>  	orig_val = res->orig_val;
>  	new_val = res->new_val;
>
> @@ -1066,6 +1055,8 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>  	case BPF_ALU64:
>  		if (BPF_SRC(insn->code) != BPF_K)
>  			return -EINVAL;
> +		if (res->poison)
> +			goto poison;

Moving the poison handling after the class/operand-form checks makes the
silent return -EINVAL reachable for unresolved relocations. Would adding a
pr_warn() on this path help with debugging?

Before this change, relocations with res->poison set jumped to the poison
label at the top of the function and always returned 0 without reaching
the BPF_SRC check. Now an unresolved relocation targeting a register-source
ALU or ALU64 instruction (BPF_MOV32_REG, BPF_MOV64_REG, or
BPF_ALU|BPF_END|BPF_TO_BE which encodes BPF_SRC == BPF_X) fails program
load with -EINVAL and nothing in the verifier or libbpf log explaining why.

The other rejection paths in this function do log diagnostics. The LDIMM64
form check at line 1129 does pr_warn("... (LDIMM64) has unexpected form"),
and the default: case at line 1155 does pr_warn("... trying to relocate
unrecognized insn #%d, code:0x%x ..."). This newly-reachable path is the
only one that returns -EINVAL silently.

The new selftest at f4f5a2c61d21 shows the gap. For poison_exit it can
assert ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2"),
but for poison_alu_reg and poison_alu64_reg it can only assert prog_fd < 0
and that "substituting insn" is absent, because no message is produced.

>  		if (res->validate && insn->imm != orig_val) {
>  			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
>  				prog_name, relo_idx,

[ ... ]

> @@ -1164,6 +1160,16 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>  	}
>
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
>
>  /* Output spec definition in the format:


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============1683806218629715175==--
