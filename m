Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C132A3DA
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786540; cv=none; b=KubTpmXK3GRapKpox6ARHVZ6zwzau0MXzGIhx30kzfUa2DS1lj0oXSVPaeSRs1S9Kz0aKDeqrlgVPQ8U2yF1OzWepv8os3FnrL3rsxdTQor2LNBRcAvKZ4qeBxNO3nOhEqI07SCrN+yZ5RqhttND/pAd6N/12NHs9HDhN+e7q0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786540; c=relaxed/simple;
	bh=3YIfA7y/8AgpQEDAS/YRM2dyoT6ZiyrHyNOsYPlhYc8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Iqsvr64xPgU5qLQjz+9780SjDaYzq2VjdOaRU4XQEsB/SgNQD0AlsYtjDPBjNsUKHoTx9OGXcB0jg5B5yL3Fh2SNtLE98ieJfBGneJwRW4wboVrvhiLEDN+1NuxAtq62z5Prv/eqNo6ry1tpXY//H54OYzZeHRHbabLQ5LyeHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT34Wqsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT34Wqsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1813C4CEF7;
	Fri, 10 Apr 2026 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775786540;
	bh=3YIfA7y/8AgpQEDAS/YRM2dyoT6ZiyrHyNOsYPlhYc8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pT34Wqsken01+AyK5wO2EwLKVE5xd4IlqIL8f0vhlmhA8KJUWl9W33FLiDbd4ETox
	 1V0N3BeBWx84bRN/mCQmeG9+GmdzqZrqaoXxTB6FxJ9WYXhaouPlFAP84gtPZPcEEs
	 XtEG4oCKw6b8K18mmIETn4XC/oME7dWtns9EEnqYrBRmw9takGlm6xPH86x4pch3Ra
	 xYa7MJ0y0OdHGgR/4aNArLq0G4wfGSvFU18Y6ANYbhRcztnML2nsIBNvM0C9RDSttm
	 rh50WiObtSK+XAk9q8w8jlSY3elzjU56EAOv3Q8hFVuqKcJgvCE2T+MxYdmaueG4FE
	 MhuqHDLMokkvA==
Content-Type: multipart/mixed; boundary="===============7731345893683715066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae3905f1e84c416687ced8fb9db48af481b77a68915805e80e4be42147699821@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-9-651804512349@gmail.com>
References: <20260409-patch-set-v2-9-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/13] bpf: change logging scheme for live stack analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 02:02:19 +0000 (UTC)

--===============7731345893683715066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index c13f57ddf582..f296c3304752 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static void print_instance(struct bpf_verifier_env *env, struct func_instance *instance)
> +{
> +	int start = env->subprog_info[instance->subprog].start;
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	struct per_frame_masks *masks;
> +	int insn_idx, frame, pos, insn_pos, i;

Should pos and insn_pos be u64 here?  They store env->log.end_pos
which is u64, and are later passed to bpf_vlog_reset() which takes a
u64 new_pos parameter:

> +	int len = instance->insn_cnt;
> +	bool has_use, has_def;
> +
> +	if (!(env->log.level & BPF_LOG_LEVEL2))
> +		return;
> +
> +	verbose(env, "stack use/def %s ", fmt_subprog(env, instance->subprog));
> +	verbose(env, "%s:\n", fmt_instance(env, instance));
> +	for (i = 0; i < len; i++) {
> +		insn_idx = start + i;
> +		has_use = false;
> +		has_def = false;
> +		pos = env->log.end_pos;

Here end_pos (u64) is truncated to int.

> +		verbose(env, "%3d: ", insn_idx);
> +		bpf_verbose_insn(env, &insns[insn_idx]);
> +		bpf_vlog_reset(&env->log, env->log.end_pos - 1); /* remove \n */
> +		insn_pos = env->log.end_pos;

Same truncation for insn_pos.

> +		verbose(env, "%*c;", bpf_vlog_alignment(insn_pos - pos), ' ');
> +		pos = env->log.end_pos;
> +		verbose(env, " use: ");

[ ... ]

> +		if (!has_use)
> +			bpf_vlog_reset(&env->log, pos);

When end_pos has exceeded INT_MAX, the truncated pos is promoted back
to u64 via sign extension, producing an incorrect position.  For
example, if end_pos was 0x100000005 at the time pos was saved, pos
holds 5, and bpf_vlog_reset() receives 5 instead of 0x100000005,
rewinding the log to the wrong position.

With BPF_LOG_LEVEL2 the verifier can produce large volumes of output
(per-state info at every prune point), so end_pos can realistically
grow past INT_MAX for complex programs.  The existing convention in
bpf_verifier_env uses u64 for prev_log_pos, and
print_subprog_arg_access() in this same file avoids storing end_pos
in a local variable, passing end_pos - 1 directly to bpf_vlog_reset().

> +		pos = env->log.end_pos;
> +		verbose(env, " def: ");

[ ... ]

> +		if (!has_def)
> +			bpf_vlog_reset(&env->log, has_use ? pos : insn_pos);

Same issue here with both pos and insn_pos.

> +		verbose(env, "\n");
> +		if (bpf_is_ldimm64(&insns[insn_idx]))
> +			i++;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============7731345893683715066==--
