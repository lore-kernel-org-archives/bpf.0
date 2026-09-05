Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E1362157
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583159; cv=none; b=lG2enlHH74R+KXz4mfpmycXY2vhh0dZBoArvPIDWGPF/KTKbln/Ne7GtXIWTr22E9Keuf8fu0e6IM8iInrmImnlDR8rDmigH3bepb01DmZGlYWZ+nqzV2ZGrhHbgcMseREn/DnK2J8jJR5Hc1Qcj9YQUcBtlp3KqFTUGgbfNiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583159; c=relaxed/simple;
	bh=xW7dGqKAjv8kAL1Lcv77eyLBp/A/imvQO3HC+MHkEhA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eWYGeVtd+hUjjqnp4/R5lLQPRXoVpTIEBAA0VhmElNdAam9srywyCsVmn2C4QQb76t52L/FpXAy7G/z0Nx4YncScFt+PhQI29Hr3c3MWBYl9A2eEegAVaQiuRoZ74GU6G3jCFP38MUxoDqdENZSwO5HDIkQ7JFUJNZzySxoSOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEorMRO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEorMRO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC831F00A3E;
	Sat,  5 Sep 2026 04:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788583157;
	bh=NPViYBKzLKqz5m7kmxMz692+3N0rYHei3C1vjDWJpA8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZEorMRO6STOW5kmOrck2kX0wUnHP74w/KFMwp8oX3I0SB5XpPpilp21WH4Ktrw8PT
	 FsDcobBRu6QJjqvpEylenQbAnfpobuuQ5QysdvqCMi0Gcr66VU+7pdbh50Gi0vo7Vp
	 4ZeGPH8OOh9oIahHYahLt0xIb+1toxozBC6hbFiXi6ZgQlV7C+3NtbSsg+PZSTXyin
	 8/HW6odPUTnpEbubJbemypdb2EtnXaQxJzsSrnkBmcgxbOBqjQwvWuEPbHvbKN0Q9g
	 j0Qj1Yyo0eDQgJHMp9NRTp4yD2HKUHfVoRvjHABQ1ogju5rkw8FpH/14w+WfeuyG22
	 A7FSG2ZwC9o6A==
Content-Type: multipart/mixed; boundary="===============5239765020229161787=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45ecf4b5ee0a1132da10518ce3812772327cd2e69219c4a14787762833654334@mail.kernel.org>
In-Reply-To: <20260905034018.2095649-2-memxor@gmail.com>
References: <20260905034018.2095649-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Verify global subprogs in each sleepability context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 04:39:17 +0000 (UTC)

--===============5239765020229161787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a7eb2185c35..66d04244c737 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1650,8 +1650,9 @@ static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags
>  struct bpf_func_info_aux {
>  	u16 linkage;
>  	bool unreliable;
> -	bool called : 1;
> -	bool verified : 1;
> +	/* Indexed by in_sleepable. */
> +	bool called[2];
> +	bool verified[2];
>  };

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b51e7ee1a3f..4b9aa0f168bb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19560,13 +19565,14 @@ static void free_states(struct bpf_verifier_env *env)
>  	}
>  }
>
> -static int do_check_common(struct bpf_verifier_env *env, int subprog)
> +static int do_check_common(struct bpf_verifier_env *env, int subprog, bool in_sleepable)
>  {

This isn't a bug, but would it be worth naming this parameter is_sleepable
instead? There's a file-scope helper in_sleepable() at kernel/bpf/verifier.c
and the parameter now shadows it within this function, so any future code
added here cannot call the helper without renaming. The sibling function that
seeds the same field for async callbacks, push_async_cb(), uses the name
is_sleepable for its equivalent parameter.

>  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>  	struct bpf_subprog_info *sub = subprog_info(env, subprog);
>  	struct bpf_prog_aux *aux = env->prog->aux;
>  	struct bpf_verifier_state *state;
>  	struct bpf_reg_state *regs;
> +	u32 old_insns_total = sub->insns_total;
>  	u32 insn_processed = env->insn_processed;

This isn't a bug, but could the commit message add a sentence about the
insns_total accounting change here? A global subprog verified in both
contexts now reports the sum of both passes in subprog_info[].insns_total,
which affects BPF_LOG_STATS output and veristat per-subprog instruction
counts. The code is correct but the behavioral change isn't mentioned in
the changelog.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33943332260
--===============5239765020229161787==--
