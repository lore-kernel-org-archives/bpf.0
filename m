Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A448C418;
	Tue,  9 Jun 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019779; cv=none; b=Q5JPbnpxtFBKVDuCdMIwDKGD4suEBbGetb34NLIQjy9X/OS37hv8ZICFl/0VaOG0p4PF2OSRsqeCnNuv+DUx5sQ6QDlTIAtQRA73VUMFQ+alXdKSb78lOQYSaqjg4ga5oVFD7nMu3ID3dDK3+lcLDfmgG6GrpKizn3LasUFJ7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019779; c=relaxed/simple;
	bh=DC/Oh9g7g6yNkRtxABzOIsaF0OUdbLWnISkWuLMmnz8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AxvQrHrbcItNZW5fGkqIB3Ngjf3PScD1oZasnSUr59oipvPY4soMlaoy2Z7KD04KX4GUwj7bSH+YhE0jpV7/eowBs4bM09e85DFBkj38BQuDdLQuoB5Nol3dniAXtbs7hNJj0Mhdo+tIMhcnExPiXUQ/3dhv+OhPDdB79J8n6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbBxhCey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbBxhCey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4C01F00898;
	Tue,  9 Jun 2026 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019778;
	bh=apID2qM7uHzXx8KSCa0dv61i3wb+0bcboRzEZeQ7HS0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jbBxhCey3ScA+bP3rvIKM9cDB/oFmAaIDsDHUAwwp6Vj46CuwW3SniXwnqLF3+Tcn
	 IKjlK+ii8odxxmUFATD7SdimMS0Il1r8i3ZPdXywW8GfGhZU2i69Ksc81DMzzH9ulX
	 25Ik7MmDqIPdIZQQn3u4k8AMWZWqeRXZXGCvFXA9rGcvRjaxBPlCnFOSWKRY532VHX
	 Jl3BJUrCuF4UmROyzqz2Onvsnh+7QqFiDFDVS72uTI6VDrmbF48UyW132/+RHs0A2l
	 pAB2/0Mx0fj0FWGr+4xNv0UTYyp457DqX4kobsGQ88nR7o9AhfJEfGj35TAhJnjtcN
	 7T87GC3HF7tsA==
Content-Type: multipart/mixed; boundary="===============5047575541896268026=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7ec49cbf243822be83aa8d47da10b3d8a739952e544fcd86aeab6b1ccd447d90@mail.kernel.org>
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix gotox target validation against CFG
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,a.s.protopopov@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 15:42:57 +0000 (UTC)

--===============5047575541896268026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..25fa90e731e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17124,6 +17124,23 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +static bool is_cfg_indirect_jump_target(struct bpf_verifier_env *env,
> +					u32 target)
> +{
> +	struct bpf_iarray *jt = env->insn_aux_data[env->insn_idx].jt;
> +	int i;
> +
> +	if (!jt)
> +		return false;
> +
> +	for (i = 0; i < jt->cnt; i++) {
> +		if (jt->items[i] == target)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* gotox *dst_reg */
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {

[ ... ]

> @@ -17171,6 +17188,15 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>
> +	for (i = 0; i < n; i++) {
> +		if (!is_cfg_indirect_jump_target(env, env->gotox_tmp_buf->items[i])) {
> +			verbose(env,
> +				"gotox target %u from map id=%d is not in the CFG jump table\n",
> +				env->gotox_tmp_buf->items[i], map->id);
> +			return -EINVAL;
> +		}
> +	}
> +

Could this nested loop create an O(N * M) algorithmic complexity that
bypasses verifier complexity limits?

The outer loop iterates n times, and is_cfg_indirect_jump_target()
performs a linear scan over jt->cnt items. Both n and jt->cnt are bounded
by the map's max_entries, which can be very large.

Since there is no cond_resched() here, this creates a synchronous
iteration sequence that could trigger the kernel watchdog panic or lead to
CPU soft lockup.

Given that both gotox_tmp_buf->items and jt->items are strictly sorted
arrays, could this be optimized to O(N + M) using a two-pointer merge
approach or O(N log M) using binary search?

Raised by sashiko-bot@kernel.org in v1:
https://lore.kernel.org/bpf/20260609151359.3C6F51F00893@smtp.kernel.org/

>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27216356316
--===============5047575541896268026==--
