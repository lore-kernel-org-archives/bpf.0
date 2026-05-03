Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00543612E9;
	Sun,  3 May 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777824784; cv=none; b=j/ALa9eX+tPUFFrytxTiv93ykEGqAgP4TDMQHKRSVhKTCiL9FReuuJkyclcEp4ZjAVKDMWNKKHEG8F1+b8WbXVqcrS4/MTAqHykSVv/5Vq6bxIDLDl/cPd+/puZCAn93qH4Vy3cra3h+btZ373kmG7XaNIflbomhxKn4vfAjJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777824784; c=relaxed/simple;
	bh=D0VcYAuXT+AOZnk3q71i9amgUZ/twFulvgs67pCg2hI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J9kBhvpbREPWkvOc1XppXwcqigAJxPucCROnyfp7CaVeUyj2nxpOEVKgLsxw3kd2dWr0gcVs4DG3MlPJu+LtxCgTsGs3BCzMqlXLBtiDWTYIfuKFsEPGizL4GndpCM5lmEDL6h/gZHiIoryaP7MzuUVFC51BSCNqjBAyL9ZpUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBqI1NJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBqI1NJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA249C2BCB4;
	Sun,  3 May 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777824784;
	bh=D0VcYAuXT+AOZnk3q71i9amgUZ/twFulvgs67pCg2hI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hBqI1NJDwEzZyLzHlfaqe+DmrHGUCM77Sox5Z6PCsVDTvWiOXyjLV+0XIGRglxuph
	 owIWaQAwcxNPXp91ASwbybVH8Ih/t1j5wfzhOx5y51UPiaPv1olilRseAupV1EhBO/
	 T+U5zYM3HuS0H+95850UZogL3pZAi0dvXg9DGG/Kd7nKkKCMItP+i8Hi1IbMohk1yn
	 VouQz7zvXzqanef384ec0BPywRfZdBsmS30mmikJ2UrQDODeVGu9mNLBxD651LK+kQ
	 KsxPoNDUeM/ZqHpcLad0bSwu1L1KKDDs6zWwJd7rypJWzQCb4RyAgIIFup7DiRzghU
	 973BHZZRczkRQ==
Content-Type: multipart/mixed; boundary="===============1075603499589538813=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43650b10f9e10b3ced4dbd4d99ae3c7e6119faf0edb8dd99b2e99721e52b23dd@mail.kernel.org>
In-Reply-To: <20260503153730.541685-1-atomlin@atomlin.com>
References: <20260503153730.541685-1-atomlin@atomlin.com>
Subject: Re: [RFC PATCH v2] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
From: bot+bpf-ci@kernel.org
To: atomlin@atomlin.com,corbet@lwn.net,song@kernel.org,kpsingh@kernel.org,mattbobrowski@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,rostedt@goodmis.org,mhiramat@kernel.org
Cc: skhan@linuxfoundation.org,jolsa@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,mathieu.desnoyers@efficios.com,rdunlap@infradead.org,atomlin@atomlin.com,neelx@suse.com,sean@ashe.io,chjohnst@gmail.com,steve@abita.co,mproche@gmail.com,nick.lange@gmail.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 16:13:01 +0000 (UTC)

--===============1075603499589538813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14..e2060c6f3e13 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9906,6 +9906,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return err;
>  	}
>
> +	/*
> +	 * Taint the kernel if the program attempts to use mutating
> +	 * helpers.
> +	 */
> +	if (func_id == BPF_FUNC_probe_write_user ||
> +	    func_id == BPF_FUNC_override_return)
> +		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +

Is it possible for the kernel to be tainted here even if the program is
ultimately rejected by the verifier? check_helper_call() is executed during
the verifier's static analysis phase. If the program fails verification later
(for example, failing the GPL-compatibility check immediately following this
code, or encountering an invalid memory access), the program is safely
rejected and never loaded.

Because add_taint() synchronously modifies global state, wouldn't the kernel
remain permanently tainted in this scenario, falsely indicating a compromised
state?

Furthermore, if panic_on_taint is enabled, could a user trigger a panic merely
by attempting to load a malformed program that contains these helpers?

Could this be addressed by recording the intent to taint within the program's
auxiliary data during verification, and only invoking add_taint() once the
program has successfully passed all checks and is definitively loaded?

>  	/* eBPF programs must be GPL compatible to use GPL-ed functions */
>  	if (!env->prog->gpl_compatible && fn->gpl_only) {
>  		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25283723455
--===============1075603499589538813==--
