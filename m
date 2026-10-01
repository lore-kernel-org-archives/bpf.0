Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D451616F
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862828; cv=none; b=g5R7J5zFoNAoGW4UdaL2QKEqRzIUaPEVwWqzncpeJayGv82g8fwDeEfvt6J/YojMeQmLTmoF5ANyLST+VL3c38nCsV8A6DtoHhuNmQtuzIFtRA+ghTsTCUMfUvkI7FEOrknGBuhZx25HrqRQflS+3AOWWpkIwYDqffV5FgJKKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862828; c=relaxed/simple;
	bh=fB2RKo/w0lRhnpQBIu/fYXOtHhJLlEuIt3ZbtRK3Q2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kv+cLH0R9hm9BatZ6UFuFru4FTJxxlI9+7OD5w0F7nk8pc8DaWp4zoSzAZSwOLPhc9XWWadLywjzevImZnc/ko8N0DqN9bsKafttpbVRvyDCOPLcAhV97hA/Rw3j2yKV15wXrotTyMtGHLjXz6chxNu+I4w/YZcABqw8xEsG/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu9rg7dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu9rg7dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE3F1F000FF;
	Thu,  1 Oct 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862821;
	bh=3j8Ji/cJFkMpexvYV6YtrLDT5NVYbbXwcmB4rF1DmqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fu9rg7dwwcVwDtPPecTGU5yHNhcVSy3hMYNOzKK024oCNTb2vnYE4zJvbGf/G15yQ
	 8V0E2ef/yu0hlN6FF7D5va7fZFWwLRflntvyZrMbWg3VV9EKY8VNW0X+BL3BaDcrQ4
	 ovQuDexfLJ6NVjwIKgnOssydXE1IXZSUDaVBJZ19l9EJknoVXrdth15X4lI/vBABFI
	 jgaqK5yO8GnT+U5T096t6XEWdI1ygENGPthISQVLw3zNQdjxsUhfvpAzi4S8AW++3T
	 jeNxOxzvHdW9Q4THR6mVcg1QfpquA0B55om3Y7XFVKPg5+iOV2/enlXRxZN7seRqLL
	 gXT3Mxmx4sBNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 10/22] bpf: Do not use a private stack for a
 program that can unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001133058.1340406-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133058.1340406-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:53:40 +0000
Message-Id: <20261001135340.CAE3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: callee-saved register corruption via bpf_throw without cleanup
--

commit 9d2c0e8faeb024a4647980c48ca2caa933b90b1c
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Do not use a private stack for a program that can unwind

This commit disables private stacks for BPF programs that can unwind
because an unwind skips the pop instruction corresponding to the push r9
emitted around calls. This forces NO_PRIV_STACK in check_max_stack_depth()
for programs with cleanup records or that may unwind.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f3ed68960d70d..488ceb9dae1b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5769,6 +5769,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
>  		}
>  	}
> =20
> +	/*
> +	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
> +	 * by a pop after the call that an unwind skips. A frame resumed at a
> +	 * pad then addresses its stack through a stale pointer, and a frame
> +	 * sent to its epilogue instead pops its callee-saved registers one
> +	 * slot off. Refuse a private stack for any program that can unwind,
> +	 * on every arch for now.
> +	 */
> +	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
> +		priv_stack_mode =3D NO_PRIV_STACK;

[Severity: High]
Does this logic miss programs that call bpf_throw() without any cleanup
records?

If a privileged program uses private stacks and calls bpf_throw() without
acquiring any resources requiring cleanup, cleanup_info_cnt will be 0.

Looking at bpf_prog_may_unwind() in kernel/bpf/exception.c, it only checks
might_unwind:

kernel/bpf/exception.c:bpf_prog_may_unwind() {
	u32 i;

	for (i =3D 0; i < env->subprog_cnt; i++)
		if (env->subprog_info[i].might_unwind)
			return true;
	return false;
}

Since bpf_throw() only sets might_throw, not might_unwind, it appears
bpf_prog_may_unwind() will return false.

Could this bypass the NO_PRIV_STACK enforcement and lead to the exception
callback epilogue popping the misaligned stack (shifted by the skipped
push r9) into the kernel's callee-saved registers?

> +
>  	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
>  		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133006.1335=
369-1-yonghong.song@linux.dev?part=3D10
