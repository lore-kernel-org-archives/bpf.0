Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1E3168EF
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788600336; cv=none; b=IHZWUNQeFa6Z9I+zxdlmxXjemMN3Xt80sSJKzOfOtMPMUpH3MHMfVe0NHDPHCPovfGmkuuBe+pHnIXgjatJ+C3Z0+3lTSqpfNxpa9KL7Aon/qMk8T2scn+7QhFZCSqfWh/yKsvevukad7gHPBcMCYMIlKjbXvdebBLrsWMdDBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788600336; c=relaxed/simple;
	bh=M379bcCpdgMYpzllGxRiFnKcdBOPvAeMaDtNnKRn1so=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uypTrG2go2biukocG5fpC+2yLSOWX0RVIGZ/GpKJ3gekcoHLUV3ghYgdlffGt1/NF4G1IMHgvCf6GZjcj4z+dwSliMtk9citOGE+TqEBMouohljjoy36zH8bvl6RpdB4GDKduwlg3guSsqVMK1ZXq4FwLjG0GQOMKd9SH3SMHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXFCj6Hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXFCj6Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDF71F00A3D;
	Sat,  5 Sep 2026 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788600335;
	bh=ep1sUy2Owl0C8NETh2uqYoR2bMcUBgqiNbkIZqsxcNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WXFCj6Hs1sgp3eksRSYPTz63vD+Li9jGVyi4mWwsmb0V1F5wzX6N0vMiew41ZnhGv
	 /mS9oictQFsEfJN8fFcEWhWijocf+gKS3AWZ29qXsXDYGa3D3b+1R/sbveUdf2pySR
	 TqHW4NQPOlD2n58tu2RkoGzvWwcGhNapvLB8GKdoMRT07SVbvfWyHHGnB4NMiHzJud
	 cynME7h7tlvgOX4x+wlNPApSz+ftx5c49nFPi1CF2DnxsghlpBeo//A5tYyB5dQ5Im
	 c+pNiyQUmx4h0HHi6ehvyvTp5huj3AZJMVek5aLDgMkgp4DhQQZcpL80mUww41svEq
	 Br7d2jwt6vbFw==
Content-Type: multipart/mixed; boundary="===============0258887377356042763=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e939a19812107980e78e817ac3be8485a956d5f568fded29db2b512a847f497@mail.kernel.org>
In-Reply-To: <20260905083418.3723623-7-memxor@gmail.com>
References: <20260905083418.3723623-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 6/7] bpf: Assign lock identity to callback map values
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 09:25:34 +0000 (UTC)

--===============0258887377356042763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c797cc3df40..ad14a7fbed72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10036,6 +10050,9 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
>  	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
> +		callee->regs[BPF_REG_3].id = ++env->id_gen;
>
>  	/* pointer to stack or null */
>  	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
> @@ -10132,6 +10149,9 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr = map_ptr;
>  	callee->regs[BPF_REG_3].map_uid = map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
> +		callee->regs[BPF_REG_3].id = ++env->id_gen;
>
>  	/* unused */
>  	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> @@ -10250,6 +10270,9 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr = map_ptr;
>  	callee->regs[BPF_REG_3].map_uid = map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
> +		callee->regs[BPF_REG_3].id = ++env->id_gen;
>
>  	/* unused */
>  	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);

This isn't a bug, but the identical three-line block appears in all
three callback-frame constructors (map_set_for_each_callback_args,
set_timer_callback_state, and set_task_work_schedule_callback_state).

Since the security property depends on every PTR_TO_MAP_VALUE callback
argument getting an identity, would it make sense to fold this logic
into a small helper function? Something like mark_callback_map_value(env,
reg, map_ptr, map_uid) that handles the type/map_ptr/map_uid assignment
together with the conditional ID generation would make the invariant
enforced by construction, so a future callback constructor couldn't
accidentally omit the check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33955969043
--===============0258887377356042763==--
