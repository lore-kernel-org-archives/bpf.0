Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B847F3A6
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396238; cv=none; b=LXBuljYe61DSSSlgNgitPW1X5Ol/qRXlckFFwuAOk7586XuVj/UJLxtx8b+A0L+3rW4I5VNkdz/UouR9HhWohd7mb6LX6hRXmwt0bQTnK0+69ZDFx7q8C6ibzq4f+xCQ4jTxXzRMQByUBnVK+1t61wT7Pr/VQ5JdPY2kqhj5Vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396238; c=relaxed/simple;
	bh=+Qr22QshpPMqheUU+9Qa/+FDWHA9qnnm/6Y9GD/MCas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MV9QWWNk2B4vSJoKBq+msNDWwEGRIzJ0rmhMnrJN0Ggx+nq8Xz+P4fSVP1rIEJtiVujjx23b+7c6wS8l9qzNF80K4XKNO1tB4LZ7TVQ5SV+UHygck9fJhfMEySDS334bH+Ce/SJTqpkviWe75qgLrBZqfgzGYGKzghHOhozfVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ9ol/lv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ9ol/lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85091F00893;
	Mon, 14 Sep 2026 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396236;
	bh=ATZj7qLamBjfSoaumEPnR+wMp8zHfW37yE8CXYrzeg8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bJ9ol/lvLsDQIECHjIyi/3dn8NCKylvyBVqv2wT2U79nLP1M3JEZZxDnaZVMakxA9
	 iEFqS9PprDbg/hH9614msKVXOVsThVHGpEML3+QWY2vPNCODp7PMWrMLKw125+oigy
	 357JrtP7AzP0UQX6uT45fGEny+taWjFsga8VSUPD0AvZBIDwMDcZhFeDBGXKgRRIlJ
	 HTyQybtxD3TJJeCgLVANyhh2A+/87FUD5IdjrwAJimuq7TIpR1VGeuGjDgaMFXHZli
	 sKrHMqQU6gPo1Aria02waWXf0OpWiEYcNqHcVbEmj1N+CMy9npxD1qioDjoYL/Z7TT
	 Pu44rzgGyzZXw==
Content-Type: multipart/mixed; boundary="===============2497597855303307172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a1f20d987f1dc6320237d1a5ee3923f854ca8bf9f79649703e85379e832f998@mail.kernel.org>
In-Reply-To: <20260914131701.2529725-2-memxor@gmail.com>
References: <20260914131701.2529725-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v3 1/7] bpf: Make post-verification instruction rewrites killable
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 14:30:35 +0000 (UTC)

--===============2497597855303307172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8b294dfc1ad4d..df1eb43d19336 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 52d3cec336727..d6f83521fc78e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -8,6 +8,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
>  #include <linux/perf_event.h>
> +#include <linux/sched/signal.h>
>  #include <net/xdp.h>
>  #include "disasm.h"
>
> @@ -306,12 +307,28 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
>  	}
>  }
>
> +/*
> + * Some post-verification instruction rewriting passes require an
> + * O(prog->len) operation per instruction. Keep their shared primitives
> + * killable and preemptible.
> + */
> +static bool bpf_rewrite_must_abort(void)
> +{
> +	if (fatal_signal_pending(current))
> +		return true;
> +	cond_resched();
> +	return false;
> +}

This isn't a bug, but would it read more clearly to keep the cond_resched()
visible at the two call sites, or to name this so the reschedule side effect
is apparent?

The function currently sounds like a pure query ("must abort?"), but it also
performs a cond_resched() as a side effect when returning false. Compare
with jit_subprogs() in this same file, which spells its two reschedule
points out as bare cond_resched() statements, making the preemption visible
where it happens.

> +
>  struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
>  				     const struct bpf_insn *patch, u32 len)
>  {
>  	struct bpf_prog *new_prog;
>  	struct bpf_insn_aux_data *new_data = NULL;
>
> +	if (bpf_rewrite_must_abort())
> +		return NULL;
> +

[ ... ]

> @@ -523,6 +540,9 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  	unsigned int orig_prog_len = env->prog->len;
>  	int err;
>
> +	if (bpf_rewrite_must_abort())
> +		return -EINTR;
> +
>  	if (bpf_prog_is_offloaded(env->prog->aux))
>  		bpf_prog_offload_remove_insns(env, off, cnt);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34849913056
--===============2497597855303307172==--
