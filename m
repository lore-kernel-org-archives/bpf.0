Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211487;
	b=HjiBWAu1wl69UCy9RSr/zepVgYyh2dzE09sELL+kp0kC4NOgtUriOmygM4zq0vbVKZGL
	 igw7X360zZiyFVdp97z5hm+dZVdwmXsp+tZqGguNkzi74QbFh8/ZDfsWGJnbu1tFcKJNv
	 xuhCbksry4zPxqbYhn/TwctUi9Cf5NiXOUXvTRROQmAFLC5SHCY+/VClDhtNIcRQSZm5k
	 UpuACCnghBZeWVDGLvPO4LXoPvvsFDQREYzel4HehIIfdXb42cfsUrwgLuMlz+r28Thxo
	 NsZM+/av6O+MElvR+IT5iV+BlQYEWnsHTW6rqea/fwpGQtD7bW/2G0cuVYc6B/W131A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211487;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/sksnM+kt5JOdochY/Feo3vR8xDRZTG0l68VjuOArAs=;
	b=q4MJQpcZTWyyBcSvfadDoO/l9TGlONUe/O3TfvcCxk4pqsLrm9MtTcVTbnAMYgmILoYW
	 eP4/zQZ1+Fa722EVkEnUjzsBQ4Ih/Elabj+Ei6XqR5dYiCzSgzuWQ6hgCVJxgWrbl6dn3
	 wibvE6f+7tol4GJ68fgDB61eIPjeybyywlPyV2xsLIkZThyl2bt921Tn6jTBE5Lq2eDlG
	 I6HTRj1Qxyz98Hk4N3wCM2xxO0xtRMMpkSZRBm9h7kbO6YvPd11HdGDC+ip/7HyRDcbDP
	 3Jerx5Gio+pzk7rgCAESNHa7IqwGDPCSBIgJ9cMe5HuPDNjMXybZpvNb+i5Rj8Ei3iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0FUNRBa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E615606A686
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0FUNRBa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A01F000D3;
	Fri, 20 Nov 2026 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211486;
	bh=/sksnM+kt5JOdochY/Feo3vR8xDRZTG0l68VjuOArAs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I0FUNRBaNB3NGVv4pt7Br2oJnAnOSPYOQt1HVFqM3CRfhwFoEsi3WK2kZ9AcQJI6Y
	 OYtCHxqVLYPbgiiRzsHjYvDRSyojG+VsQ3SFvGjd6w7InLQ9dlDCQKPn94dksPQ4K+
	 C04NIndAjF3mxwF88bWOgnj+8XFdJ+Un3r4LRLbz4lDKGO+lkD3N1h2kDESERHm8OT
	 h+jo9CiG176yrxCG79NpM8h04pftwFDLhCT0QeQ9w/aADs3pmrDXIkGYro2FqVGwZn
	 LERAkT5Dc7sLdBTVchThYnrV7CRMbibN8XiCMGTuV+cYxgYPen7qcSpKAmTe3n7jAG
	 rDh4OizflbVgQ==
Content-Type: multipart/mixed; boundary="===============4334217473762922311=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <df1841012fe23fe7dce140514da33011112569e63c784b725d77c73a160f3214@mail.kernel.org>
In-Reply-To: <20261120204959.614908-40-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-40-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 39/49] bpf: Keep two states apart if a live xreg has two types
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:25 +0000 (UTC)

--===============4334217473762922311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep two states apart if a live xreg has two types

TL;DR: live_types_mem budget is computed before max_mem is clamped, so with
CAP_BPF it may allow about 7-8 times the stated 1/64 memory before joining
states again.

> diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
> --- a/kernel/bpf/precision.c
> +++ b/kernel/bpf/precision.c

[ ... ]

> @@ -1625,6 +1681,10 @@ int bpf_precision_init(struct bpf_verifier_env *env)
>  	prec->this_pass.unproven_funcs = bits + 16 * words;
>  	prec->last_pass.unproven_funcs = bits + 17 * words;
>  	prec->pass_cost = env->cost;
> +	prec->live_types_cost = env->max_cost / LIVE_TYPES_PART;
> +	prec->live_types_mem = env->max_mem / LIVE_TYPES_PART;

The commit message says the budget is "1/64 of the limits on cost and
memory".  Is live_types_mem computed from the right value?

bpf_precision_init() runs before do_check_all() clamps env->max_mem:

	initial = save_snapshot(env, NULL);
	if (!initial || bpf_precision_init(env)) {
		...
	}
	env->max_mem = min(env->max_mem, env->mem + BPF_PASS_MEM_BASE +
			   (u64)BPF_PASS_MEM_PER_INSN * env->prog->len);

With CAP_BPF, env->max_mem is still BPF_MAX_MEM (2 GiB) at that point, so
live_types_mem is 32 MiB for every program.

For a program of about 1000 insns the enforced limit is the clamped
value, roughly 256 MiB plus 31 MiB plus the per-insn tables, and 1/64 of
that is about 4.5 MiB.  The check in bpf_hash_live_types():

	env->mem > prec->start_mem + prec->live_types_mem

then allows about 7-8 times the stated 1/64 before falling back to
joining.

Without CAP_BPF the clamp does not bite (64 MiB), so the ratio there is
1/64, and the budget scales differently for privileged and unprivileged
loads.  The cost budget is not affected, since env->max_cost is not
changed between bpf_check() and bpf_precision_init().

Should live_types_mem be computed from the clamped env->max_mem, for
example after the clamp in do_check_all()?

>  	/* the replay for the driver has to join where the good pass did */
>  	prec->join_live_types = bpf_prog_is_offloaded(env->prog->aux);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============4334217473762922311==--
