Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567D31197B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842493; cv=none; b=GG6Cq3yGJ4e/zon83ZLCMNC4/luDwZdcxRMcUMPde40PwXBSWxYoBLig5tMGkxtaxW6Nhs/iJMkeww0G7jWmLdc8c3WOvlOaZ/L3j8YFsWH0Qs71+nfE/ONY78aPCf+WO4KLl4puRgQdYYn2488CxUpXiGbIOq7V+ZmDZSTkVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842493; c=relaxed/simple;
	bh=IkXE16MLbje5cN5w+Ma7EXGGZhi9mZF15Fq9WoYgrIg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ioNzlGGqMsGM+UdahPka2jsqqz3B/tDjpcKIi8r73bL+vVP+EHzFq7cn/P0THBkOuShylzvwDAGKuCOsYGMShddZRZMbdpaOn3eSzMkyxUfFE8RAqCwbfrJ+ys9Tp1afM6olW+R9GA8ffSXC8v/QlDon5U+s9/YINT676rfm7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1DWGwQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1DWGwQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A3CC19421;
	Fri, 10 Apr 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775842493;
	bh=IkXE16MLbje5cN5w+Ma7EXGGZhi9mZF15Fq9WoYgrIg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R1DWGwQCM08gTs4UazBW+vcWIScxduACbMTlUd0Rf/WG2vVe0kDHIzjALZTqN1bXM
	 rcjZ/ITIjkvmDOgjapP9sqpT7jxOl986nLczcCGgXCKqlmzjT2p7gk20R2tSsCKWK/
	 8UVxg6d/6ZeIRr2DeIDVAJ4mise//+nS9M9vACUMsW/FY9RTnOZoh5kkninUYhpKLK
	 CqxcMJCSfNiq3qAcd3L0d5QA9N4Ywd4YkAKVO3QiiUA+tA+4YSBFVxlL2WZOPnOG2A
	 2QBgqECkABZEMdGhcf0mivQpnc0Em1Ia2qUOOOGqY4S4scTaWDEedcW+C61cvpwxPj
	 BaldtN0nOvEgQ==
Content-Type: multipart/mixed; boundary="===============5168956027760962986=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44b371bad4d974ab7a780fde68c937820201144e17e2b5a26e908dbffae19f4e@mail.kernel.org>
In-Reply-To: <20260410163041.8063-2-emil@etsalapatis.com>
References: <20260410163041.8063-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 17:34:53 +0000 (UTC)

--===============5168956027760962986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1135d373e24..6c5721434bc4b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16655,11 +16655,32 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,

[ ... ]

> +		if (dst_reg->type != PTR_TO_ARENA) {
> +			/* Can't do arena arithmetic with non-scalars. */
> +			if (dst_reg->type != SCALAR_VALUE) {
> +				verbose(env, "R%d %s R%d: Invalid operation between "
> +						"bpf_reg_state types %s and %s\n",
> +					insn->dst_reg,
> +					bpf_alu_string[opcode >> 4],
> +					insn->src_reg,
> +					reg_type_str(env, dst_reg->type),
> +					reg_type_str(env, src_reg->type));

reg_type_str() returns a pointer to the shared buffer env->tmp_str_buf.
Its own comment in log.c says:

    Note that reg_type_str() can not appear more than once in a
    single verbose() statement.

Calling it twice in the same verbose() here means both %s arguments
point to the same buffer, so the error message will display one of the
two type names twice and the other not at all.

Would it work to split this into two verbose() calls, or save one
result to a local buffer before printing?

> +				return -EACCES;
> +			}
> +
> +			*dst_reg = *src_reg;
> +			dst_reg->subreg_def = env->insn_idx + 1;
> +		}

[ ... ]

This commit fixes a bug where the verifier rejects valid BPF programs
when the compiler places the result of a PTR_TO_ARENA + SCALAR addition
into the scalar register. The bug was introduced by commit 6082b6c328b5
("bpf: Recognize addr_space_cast instruction in the verifier.") which
added the original PTR_TO_ARENA handling in the verifier.

This was also noted during review of the v3 series on lore, and the
Fixes: tag was acknowledged but appears to be missing from the final
version. Should this carry:

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24254055723
--===============5168956027760962986==--
