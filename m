Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC836C582
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654184; cv=none; b=U/bCD0cqSnq4FF1p4kIQD5MrE33B2rIFRN1/upsEpjIbDz7AXyVbfzlvoxPLE5F0SA7Dos5Vli/hN0oWPqBmDJ8sy/5QJyHcT1lFk+tkVzl8hf058zICiNuUBcUHebNGKmamngUl+nOLG22bqq1t9QyYq0fq8mqH1X4+CSMmNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654184; c=relaxed/simple;
	bh=5A96z7IyDLoVX8UzDiNMSXIsFBxN0D9oXn++sYR/5Fg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fPjbFfykPPcDfSUgy3lFThGVaN6B7fjOC5Lvi7+zDnKfFGMv7S48r6HwzBuRsry51ObJan0GX2r3HNc+N8rWzurqHMMh9du5H9FTtmjfkYAVAKg1/4bSz1ohOnkAyPIGJzVRSLhzippfJLydDpGsiyyaDBA2Xp4YOJXzGXPyG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqnYEeEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqnYEeEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B71F00A3E;
	Thu, 13 Aug 2026 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786654182;
	bh=yoRxWCnU2EFl6uBXpkgAucPKctO54ZVhOICTi+3yG/M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UqnYEeELXiDfYntiLEfrxVjH2J1gs2WGdAxfyjyLkp18vJsq6UGXxA7vvradkMKHC
	 GmCm31vEjwV5DhfiJ6saYcsdsLZSzplGxSSkmA1f76ChwpeWN0cFYRs5WikXi2Z2WP
	 cxsbr1bhuM2qZds0wLX7ma4q8gaWCwiGsd82bjT8FUq92BC6jaxAdGaANoc4Venc0t
	 a6esjMtgSs/h6UdxKR/25t3QUYdShTwoCBJ70yKaAc0KLbxc6qjfNO4bouPYZBIdIg
	 nybYUUocxM3tTVcmarPxkC4rRhEIjK95GIKvjpDE0e6pN57gT9jPZd9OW9ugkMYfQ3
	 ESmVWe4V7h/xA==
Content-Type: multipart/mixed; boundary="===============1118018191073038897=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e43d273b5933f72fb0d45f3dcd67c149a371860391837680739df6555477e77@mail.kernel.org>
In-Reply-To: <20260813200230.1995389-1-yonghong.song@linux.dev>
References: <20260813200230.1995389-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Track R2 of register-pair returns in precision backtracking
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 20:49:41 +0000 (UTC)

--===============1118018191073038897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index a2b18a9f1694..0c8e05a7e175 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -423,6 +423,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  				 */
>  				verifier_bug_if(idx + 1 != subseq_idx, env,
>  						"extra insn from subprog");
> +				/* a global subprog returning more than 8 bytes
> +				 * sets R2 as well. R2 is part of the args mask
> +				 * checked just below, so clear it here rather
> +				 * than next to R0. Only a subprog that does
> +				 * return a pair defines R2, so leave the mask
> +				 * alone otherwise and let the check below catch
> +				 * an R2 that has no business being set.
> +				 */
> +				if (bpf_ret_reg_pair(env, subprog))
> +					bt_clear_reg(bt, BPF_REG_2);

[ ... ]

> @@ -506,6 +516,17 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  				return -ENOTSUPP;
>  			/* regular helper call sets R0 */
>  			bt_clear_reg(bt, BPF_REG_0);
> +			/* a kfunc returning more than 8 bytes also sets R2.
> +			 * R2 is part of the args mask checked just below, so
> +			 * clear it here rather than next to R0. The prototype
> +			 * lookup is only worth doing when R2 is requested at
> +			 * all; any other call leaves R2 uninitialized, so a
> +			 * request for it is caught by the check below.
> +			 */
> +			if (bt_is_reg_set(bt, BPF_REG_2) &&
> +			    insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +			    bpf_kfunc_ret_reg_pair(env, insn))
> +				bt_clear_reg(bt, BPF_REG_2);

[ ... ]

> @@ -520,7 +541,41 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>  		} else if (opcode == BPF_EXIT) {

[ ... ]

> +			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> +			r2_precise = false;
> +			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
> +				call = &env->prog->insnsi[subseq_idx - 1];
> +				subprog = bpf_find_subprog(env, subseq_idx + call->imm);
> +				if (subprog < 0)
> +					return -EFAULT;
> +				/* Only a callee that does return a pair defines
> +				 * R2. Leave the mask alone otherwise, so that
> +				 * the check below still catches an R2 that has
> +				 * no business being set.
> +				 */
> +				r2_precise = bpf_ret_reg_pair(env, subprog);
> +			}

[ ... ]

> @@ -533,30 +588,27 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  			if (subseq_idx >= 0 && bpf_calls_callback(env, subseq_idx))
>  				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>  					bt_clear_reg(bt, i);
> +
> +			/* a callee returning more than 8 bytes sets R2 as well;
> +			 * R2 is part of the args mask checked just below, so
> +			 * clear it here rather than next to R0.
> +			 */
> +			if (r2_precise)
> +				bt_clear_reg(bt, BPF_REG_2);

This isn't a bug, but the "R2 is part of the args mask checked just
below, so clear it here rather than next to R0" rationale appears at
each of the three call boundaries (global subprog, kfunc, and BPF_EXIT).
Would stating it once - say at the first site, or in a note above the
BPF_EXIT block - and keeping the other two to a one-liner read more
easily?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277
--===============1118018191073038897==--
