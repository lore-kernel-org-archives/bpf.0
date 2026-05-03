Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910B3D16F1
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827674; cv=none; b=QGJs54lI3iBsg43Dfzs5oZMYe6O3t3nLlDtIk0Ev401yz+HGs7I4XxNydBtnN1Cy4FaxbieQZOXOsGK5ahGPlynMoE0eIFxBZmE+XYyC98zQHpzZR6BE7bBmFflc/nq+ntZRtvmQq+A7tjUsDUc3dN3OgP+gYRXc4Xt0UyWQHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827674; c=relaxed/simple;
	bh=xcismaF+50EUVwBdvTSHVQ3O45RhQiaHzhsBFqxZFoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIhRBNV2q2uWvnded8pOti0ksjpyiDlh241RQdUXS3oCev2rhWL7YPl5Q6nmGV0uoX/g3XvSbvUuHbD0E53XG10oRCzxLHYR1KINJ3B4f1ToZ8so3SpXQXslrdgJGGIfgncc6h/G8smazFlj8b52BC21H4p/8zqpRhzqH6Pk+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df9RzoNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df9RzoNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6786C2BCB4;
	Sun,  3 May 2026 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777827674;
	bh=xcismaF+50EUVwBdvTSHVQ3O45RhQiaHzhsBFqxZFoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=df9RzoNqg+dDIb6Q6hMIwIdAgNMLrIuc9/WPogwNOpicKGN9AWb8Fli7wjvnhx000
	 cxKqMyC6GbTgGIHcO4jAY1MsQZFQwXy14epHUa1WrLijEB/dI3Qo6g5W3sEVZppY7F
	 Jm+1YdZTD/x62qAvZe32fxmnsT7qUSJ7XPUFIbTRsAAcuN4YYVLolZHScQMnnD36fz
	 piGC7Mdt7K+D2YpNLrIFf3D3Vzbu+XEgNXgZblyr9oXH8/dgQwVWowW6sFvkP9DypM
	 BjD+To+sSmkDFawGLT9ey+VdOxJM0XrobP9DxUjPthMx//6RHp3dlJ04xcTHzQyQ97
	 tm0rHf0GiX6JA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503164700.548164-1-atomlin@atomlin.com>
References: <20260503164700.548164-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 17:01:13 +0000
Message-Id: <20260503170113.D6786C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature kernel tainting in bpf_prog_load() before the program =
is fully loaded and exposed.
--

commit b04c8335f7a6d97d5ae1eb32256b36d77ac00d40
Author: Aaron Tomlin <atomlin@atomlin.com>

bpf: introduce TAINT_UNSAFE_BPF for mutating helpers

This patch introduces a new kernel taint flag (TAINT_UNSAFE_BPF / "V") to
indicate when an eBPF program utilizing destructive or mutating helpers is
loaded.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -3083,6 +3083,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
>  	if (err < 0)
>  		goto free_used_maps;
> =20
> +	/*
> +	 * The program has passed the verifier. If it utilises unsafe
> +	 * helpers, formally taint the kernel now.
> +	 */
> +	if (prog->aux->taints_kernel)
> +		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +
>  	err =3D bpf_prog_mark_insn_arrays_ready(prog);
>  	if (err < 0)
>  		goto free_used_maps;

Is it possible for the kernel to be tainted prematurely here?

If bpf_prog_mark_insn_arrays_ready() or bpf_prog_alloc_id() fail, the BPF
program load is aborted, the program is freed, and it is never exposed to
user space or executed. Consequently, the kernel's execution flow and memory
could not have been compromised by the program.

Should the add_taint() call be deferred until after bpf_prog_alloc_id()
completes successfully, which is the point where the program is actually
exposed and cannot be gone underneath us?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503164700.5481=
64-1-atomlin@atomlin.com?part=3D1
