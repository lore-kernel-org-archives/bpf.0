Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89D32AAA7
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905614; cv=none; b=ZgmAwUZ/j6xhOwJnKyu3q2DKgxV3TDqu+DUXm+CMUD1ZF63fvYBbgyPG8f3VdF8QkjVj4146J6UlEidJD5zj6wrkg91Vf/ApJSOTWpm9WFTEUGxr/u1a2u4MQOmxD0DAuEbKZ2l1L6u5YwvPO3SECNqt8fXvi147YxniMGmYugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905614; c=relaxed/simple;
	bh=YNxXQM7wpjHIdbfODNRm/ePjk9HhWavkVg4guS8uZyU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l7gHYvJ4DUXh+3GOFSX1t1Q1x9FPfSLLBLhflk25r9YGhHYdONj2DNVcZLl/6JZgkht/paUXY/YPrpgK8OpUEWDReITHb5CckxEAZiVEaIjxK5PWMzPxnktcv9WmBKAh534uE2y3Vd7Ut4IuKmp1UQKLoEZ3nHi2syDq5SiI4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTbVVLH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTbVVLH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9931F00A3A;
	Fri, 19 Jun 2026 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905613;
	bh=GhaP5xxC2g+CJU2dyLWdDWG7arQLUlLaP20xEdj2V40=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RTbVVLH/mC75YKJp7/yBBskCtP0XlWwPBq+IQrTCgKWKZ+QalW0vADKWKib0gfIKb
	 dH4xgHYoOD0/crsWeXPS3qvcWPkzDMxaRLtKZ1hzvQxbzzSDEKAIa58xYbfYDGOsQz
	 pOyDkm/8jXDyFOTT4utdQ86lZZXmFrMikeFAw/pa3NR8YB+DFwB7eI93irFW0BvWVh
	 gG61amtWYsLhTgtm8/M3I2EIQv+Y7TNFH7amvdLf6QEqAmy5KYp8K8FTOGrdLjCyLn
	 fvLnaARZVU5v/USPjmRhdLKUtDaAvT2gsSBvkIMkdp06mPpc4qyfXL3PTYCpX7M+Ip
	 gcqGauSFuM3QQ==
Content-Type: multipart/mixed; boundary="===============6692357636624655733=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6cad0507c3c56f520455175d7cc979dd6c2a7ddd26ec6a0f93e5aa729b09dc0f@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-4-memxor@gmail.com>
References: <20260619205934.1312876-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/17] bpf: Add verifier diagnostic event log
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:46:52 +0000 (UTC)

--===============6692357636624655733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 534a7bc58781..fa5a25b314a0 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -704,3 +782,53 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
>  out_free_msg:
>  	kfree(msg);
>  }
> +
> +void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
> +			    bool cond_true)
> +{
> +	struct bpf_diag_history_event event = {
> +		.insn_idx = insn_idx,
> +		.kind = BPF_DIAG_HISTORY_BRANCH,
> +		.branch.cond_true = cond_true,
> +	};
> +
> +	bpf_diag_append_history(env, &event);
> +}

A review comment on an earlier posting noted that this recorded branch
event can be recovered from the regular jump history, and asked whether a
dedicated branch event is needed at all.

This version still adds the dedicated bpf_diag_record_branch() event and
the branch renderer in bpf_diag_print_history() below.

Could the existing jump history be reused here instead of recording a
separate branch event, or is there something the jump history does not
capture that this needs?

> +
> +void bpf_diag_print_history(struct bpf_verifier_env *env)
> +{
> +	const struct bpf_diag_history_event *event;
> +	const struct bpf_diag_log *log;
> +	bool printed = false;
> +	u32 i;
> +
> +	bpf_diag_report_section(env, "Causal path");
> +
> +	if (!env->diag) {
> +		bpf_diag_write(env, "  no recorded diagnostic events on this path\n");
> +		return;
> +	}
> +	log = &env->diag->log;
> +
> +	for (i = 0; i < log->cnt; i++) {
> +		event = bpf_diag_history_event(log, i);
> +
> +		switch (event->kind) {
> +		case BPF_DIAG_HISTORY_BRANCH:
> +			bpf_diag_report_source(env, event->insn_idx, "branch",
> +					       "explored as %s, goto %s",
> +					       event->branch.cond_true ? "true" :
> +					       "false",
> +					       event->branch.cond_true ? "followed" :
> +					       "not followed");
> +			printed = true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!printed)
> +		bpf_diag_write(env,
> +			       "  no retained diagnostic events on this path\n");
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============6692357636624655733==--
