Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C946AEC2
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644183; cv=none; b=Hc4fyUsJmHa69VL2jA7nG6JFdBcOGl25l5dq9SwLBX+Ov14QoUEei38KAxbZ9SUip2+vytZi++6Uu0D8wHCBEWfmAps6mJhTHBswuDdinIQpEBNOnJLoN5EyaAVP3567KsLuwbGWte7nrngJKhtZZlAuEORitFnaoBn3Isq0Se4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644183; c=relaxed/simple;
	bh=t8h7dhxWMOX3rf/2RmgWVgHYfsNDgzIq56263qvzDSY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RCUp4y54wgBGfx1Drqg2P/3vMp814jNPm2kG88LPkWffD+aeAJSellAc64bbwR/b8NQAIZQHX0W8C7m6n/bTYld+/o/cYYsVcOzHYHN5fQqBnGaV5CT+7IaG+Ak77OADlHQRNjvQ9HOKHpvNvzqo7Qd2QKmnfG/9LMptu5zz5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0darrzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0darrzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B621F00893;
	Fri,  5 Jun 2026 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644181;
	bh=K1I0WIISL7dRw18HkVv8brj2+4gmABG0ydWgiSHNIm0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T0darrzSQ6u/fuEPChZPrpF4Ja6mEDQPaT4ymQFbFHPA9zvpjvU1plvm9WeZmpUwG
	 ZdzksfVZA30Kix/iaGYvm5iAqRA9NEY0Rv/ZgCdLh+6vip7yYw6glOJGZk9PO26fqA
	 if5j1talMlxNyIoVbaJIxkD2xZTZEX0oWe8R2Mt+KIUT8wEdaKCJFmAXmJ+KpM015m
	 NaYimh2WcJJAqFJwq4jwky2cTKRyEpc1gVjTB+t3z0ZwzQtMVyBLhbKs5X1joAclUq
	 Y84on25EcCyYHfs8Bu9taEXNUXyDiHKGuhFuzb9odB0Zo1VE8LnjjL72PK58mF2zMB
	 MIBaP5EgV+caw==
Content-Type: multipart/mixed; boundary="===============3467542896055820669=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8797b887ba1e6ede346dedde5e4872df286e09321c5a9017aa307c942b5e6a03@mail.kernel.org>
In-Reply-To: <20260605063412.974640-13-memxor@gmail.com>
References: <20260605063412.974640-13-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/17] bpf: Report Execution Context Safety errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:23:01 +0000 (UTC)

--===============3467542896055820669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d2a776d2059c..e30d79149cc7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13533,6 +13612,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	} else if (rcu_unlock) {
>  		if (env->cur_state->active_rcu_locks == 0) {
>  			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
> +			bpf_diag_report_context_underflow(env, insn_idx,
> +							  func_name,
> +							  BPF_DIAG_CONTEXT_RCU,
> +							  "Remove the extra bpf_rcu_read_unlock() call, or ensure this path first enters an RCU read lock region.");
>  			return -EINVAL;
>  		}

The commit message says this patch covers "unmatched context exits", and
the unmatched bpf_rcu_read_unlock() path here gains a
bpf_diag_report_context_underflow() call.

The analogous unmatched bpf_preempt_enable() path in the same
check_kfunc_call() does not appear to get the same treatment:

kernel/bpf/verifier.c:check_kfunc_call() {
	...
	} else if (preempt_enable) {
		if (env->cur_state->active_preempt_locks == 0) {
			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
			return -EINVAL;
		}
	...
}

Should this path also call bpf_diag_report_context_underflow() so the
preempt-enable underflow is reported consistently with the rcu-unlock
underflow?

This was raised in review of v1 but does not appear to have been addressed:

  https://lore.kernel.org/bpf/20260605064655.16DE71F00893@smtp.kernel.org


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============3467542896055820669==--
