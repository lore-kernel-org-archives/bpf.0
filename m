Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57013033FC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822909; cv=none; b=H6BKBAyPtLw+5l/D2cBk6IMNj7dujE6boLgvud8nyu8gWTVb1eWnTeqkE4rCJFLUEdZUX3ZtOlAn0k2FQnINayfKuioZvZhvVenajcFSvZAPwAOK8OAAw/CkbTlT/Ev2A47mTh7beqWr9n4KjQ9sWX5InQ+LU4FH3Kesx3ZzfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822909; c=relaxed/simple;
	bh=jc2M/kNmHhkEOdhdByfQkHAm2wr/hKlpTp1Hmgx6KKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bE3jPy+++iWOYadesBz1QvP6QvMPDtUFiURvsZpy71m7dcodu8kVFC75F5GCWHHafFhshoQIlvN2edz3eEv87dFWh8U7P1FTlWEpATrnZzpAfig89dZGTdkwrL8wawjs8f7BTuznTY6RTtL7ffvFaApXHvGS5BKWJVnDoMV4mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akVfgQIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akVfgQIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C0C2BCB0;
	Fri, 15 May 2026 05:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778822908;
	bh=jc2M/kNmHhkEOdhdByfQkHAm2wr/hKlpTp1Hmgx6KKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=akVfgQIAvfiaJu5zNlDe4G76CSW9j0DBc8RDqQcjyPvEb3YwfgKUltVNRTmeT0IzK
	 bykeskYbN4JtqXolrKvMzj76EapYBhafgjq8KHAajgKHSc21B/47KGbZO8C0vYFaFC
	 IYZFxyEDxBDBFsWqK6g1X0ivoffU16DiYrzbXyKNWhpNVYtkfcgW13SQ8dV+01PPFn
	 kSgy+ms5YG1mnqM6PbgGT8+GVUDlXP0WZN/dDCfurtVWiSMjewrJtKhEQyraKf9UBD
	 cgJoG0LuOi9yfbhbZQkZOKY54MR6LoTFfgzs3/C8cbDXQErFN0RDr4sGz4/vhYDLOL
	 aHYKUNqAk0LbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 16/25] bpf: Disable private stack for x86_64
 if stack arguments used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045114.2392291-1-yonghong.song@linux.dev>
References: <20260513045114.2392291-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 05:28:28 +0000
Message-Id: <20260515052828.B53C0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Hardcoding architecture-specific JIT register limitations into the =
generic BPF verifier.
--

commit d388190c12c82279caa212e6edeefb82d873dd00
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Disable private stack for x86_64 if stack arguments used

This commit disables private stack support on x86_64 when stack arguments
are used, because x86-64 uses R9 for both the private stack frame pointer
and arg6. Other architectures have enough registers to support both.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 47df3f40a71cf..745e13cfb54d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5163,7 +5163,10 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  	}
> =20
>  	subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_depth);
> -	if (priv_stack_supported) {
> +	if (IS_ENABLED(CONFIG_X86_64) && subprog[idx].stack_arg_cnt) {

Is it appropriate to hardcode host architecture macros like
IS_ENABLED(CONFIG_X86_64) directly into the core verifier logic?

This isn't a bug, but it introduces architecture-specific constraints into =
the
generic BPF verifier. Would it be better to handle this by querying JIT bac=
kend
capabilities via a generic API (e.g., passing stack argument requirements t=
o a
JIT capability checker) so the verifier remains architecture-agnostic?

> +		/* x86-64 uses R9 for both private stack frame pointer and arg6. */
> +		subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
> +	} else if (priv_stack_supported) {
>  		/* Request private stack support only if the subprog stack
>  		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
>  		 * avoid jit penalty if the stack usage is small.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D16
