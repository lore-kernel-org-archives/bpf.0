Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC28247280
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540611; cv=none; b=AQ8LDap/bOH0ysmi2Ku0rkHJhGTvcUQdFmE4YEcfxnfFP+EdK2zOxoGRtN+BLVRJbee/M2c3U7jCrsjvmB/iRaOSxTKPsdcerE919SXA0+OTcbsRTJ64z8ODGL4pU7+BSlKJS7gmz82TD/vM1ooJb/Ii5Kx4+sZ8QCxVr8JjUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540611; c=relaxed/simple;
	bh=05kuviT+lJFZYag8lRzhlb8aqh3nwSdHaEF8QGVq4lg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PZP1aJo54nJiCp/UgwTimhhjHoe4ugNIZtUEIBXJIYqcNUP/t2QeuhSWPSrR6fCxpsDVks/xSo5V56KzoivQXHk15wGKE7ulryactoh1OOJ5FKjAkc33Rxv6cEzvnDk8N8VHQ1B0rzkn9P/yqachmL+vqG1Bj0V8ojORfAiqD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1BH4tPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1BH4tPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F0AC19424;
	Tue,  7 Apr 2026 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775540610;
	bh=05kuviT+lJFZYag8lRzhlb8aqh3nwSdHaEF8QGVq4lg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=A1BH4tPVu/L3gdQkvd4QgQ8IX79UZDcxiIc+ZACDCCpL63dke8KHV3E7rlmyC5O9r
	 DCfI9Q8ARG71QNuoyf0BFYhFhwRJFQLbkLG/KrNppsW9jGe2wtPozv4EoIAp734JRD
	 cf/ymuVy8xPjH5oX069x/srpJ1ZehPUXAcfAhWq6kN4jO5kt9o/2d6iIo03fslfzW0
	 3Nm5x0Lmuuawd31bdhMBQdvm1pMbwJjW7nSEU1aGtK5fqNSQW5wHRs4TKjwfEc9upg
	 NtUc0ZYoIrfq+Cif5xf+4gXszBR8Km6NO1S61pKPhxcVTCZOPoeSalqkRz8vhRq3nF
	 8JSO6uTBlGqlQ==
Content-Type: multipart/mixed; boundary="===============1318582547150768617=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e46d2a1725f6f6788184b9305c9026006945d5e2f760c38b715e34e5c42204f@mail.kernel.org>
In-Reply-To: <20260407045730.13359-2-emil@etsalapatis.com>
References: <20260407045730.13359-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  7 Apr 2026 05:43:30 +0000 (UTC)

--===============1318582547150768617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1bebbdb3b693..6370290e72fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16619,11 +16619,34 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,

[ ... ]

> +		if (dst_reg->type != PTR_TO_ARENA) {
> +			/* Can't do arena arithmetic with non-scalars. */
> +			if (dst_reg->type != SCALAR_VALUE) {
> +				verbose(env, "R%d pointer %s arena prohibited\n",
> +					insn->dst_reg,
> +					bpf_alu_string[opcode >> 4]);
> +				return -EACCES;
> +			}
> +
> +			/* We have a SCALAR_PTR_TO_ARENA operation,
> +			 * propagate the info to dst_reg. */
> +			*dst_reg = *src_reg;
> +		}

Should subreg_def be updated after the struct copy here?

Before adjust_reg_min_max_vals() is called, check_alu_op() calls
check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK) which sets
dst_reg->subreg_def for the current instruction. The struct copy
overwrites this with src_reg's subreg_def, which points to the
instruction that originally created the PTR_TO_ARENA (e.g. the
addr_space_cast).

Elsewhere in check_alu_op(), every MOV path that uses
copy_register_state() explicitly resets subreg_def afterwards:

check_alu_op():
    copy_register_state(dst_reg, src_reg);
    dst_reg->subreg_def = env->insn_idx + 1;

For ALU64 operations this is benign, because mark_insn_zext() clears
src_reg->subreg_def to DEF_NOT_SUBREG during the preceding SRC_OP
check. But for ALU32 operations (where rw64 is false and
mark_insn_zext is not called), the stale subreg_def propagates into
the destination register.

On architectures where bpf_jit_needs_zext() returns true,
opt_subreg_zext_lo32_rnd_hi32() relies on zext_dst (set via
mark_insn_zext using subreg_def) to insert explicit zero-extension.
With a stale subreg_def, the current ALU instruction would not get
zext_dst set, potentially leaving upper 32 bits uninitialized.

When dst_reg is already PTR_TO_ARENA (the pre-existing path), the
subreg_def from check_reg_arg is preserved. Adding something like:

    *dst_reg = *src_reg;
    dst_reg->subreg_def = env->insn_idx + 1;

would keep the new path consistent with both the old path and the
MOV handling convention.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24065579421
--===============1318582547150768617==--
