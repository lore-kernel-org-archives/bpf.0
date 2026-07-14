Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AA2BEC4E
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015601; cv=none; b=coE9SYsKtgk+Bl8hY6z/YoVgyKSvlLWCkKR5jngT5smXcXlWfXnb45wZ7XYuy3j6gd11d5VRflAJQv/SPdXqzGJxi+XK0xqFHljrO+DjHqNzSwEHrWn0nikWsfBnhe8b2OldnCYyIZp23XZq75ao2q2JrfUEm0CffcS9MFpTKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015601; c=relaxed/simple;
	bh=LNqbkMkM/jmZ2Whji/wl9ZRLbHCScrVYpxqH+YK0yBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f4ILiWuPBTp/s7dx43YdPzbYWuwh/mXfY2nt/yXDeGSPx1MFKPI+2TjFKWVO1m5gbRvbKBkiHgD4Rk8z+iBTF5LZs1n27oWHmWvFxdL/mWbHTbZI4JkpyLrBtSDWPTQs7/TpoYQncSk8egGai7a27RL0MqQ1/h1jqy0VpyAvyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7NweA16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7NweA16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF191F000E9;
	Tue, 14 Jul 2026 07:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015599;
	bh=IadD2XIXJVvwg5SKEMNGKSXvWXHkeJS4GQejRD20kaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7NweA16JovfrYPT7vohdGoJdnZ4XefiVIp7z2RUMtT5UiwGCrM6aKxYFSGexPiWw
	 Nv2jsx1ROJAD7SYeSTtemP26L+5/SBDageviD/y1IAD+C3uB21lICPXFDR6QkVMaNA
	 JqSHPXgp6Z5DXFOTsXX/jXpE8fGZAUoaqK7uAniguqF4RlcwBE94VIp62WChk2Ca9Z
	 C7yFYeeDVt44oOu7sAaZAuDM8mlM0m5CZoCzujdHtP0SqQnTUZf3lCA0D39hqDy76S
	 8dz/xJRIr33LTuFx2hnTHJUqN9JTtN2NXsYgMCUhE1S0EHGbZDkWWc2I6Ywr18S5sV
	 o48eWvBYbxWlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/15] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-7-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:53:18 +0000
Message-Id: <20260714075319.6DF191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] smp_cond_load_acquire_timeout() fails to provide LOAD->STORE ACQUI=
RE semantics when the condition is met, due to the loss of control dependen=
cy on the caller's subsequent instructions.
--

--- Patch [6]: [PATCH v14 06/15] asm-generic: barrier: Add smp_cond_load_ac=
quire_timeout() ---
commit 012b1328d58cb0c51a4024152d82f79afc2a458d
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_acquire_timeout()

This commit adds an acquire variant of smp_cond_load_relaxed_timeout(),
reusing the relaxed variant and attempting to provide acquire semantics by
re-evaluating the condition and applying smp_acquire__after_ctrl_dep().

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index ecdaddbbd7b64..ad3c73da3cb6d 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> +#ifndef smp_cond_load_acquire_timeout
> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	VAL =3D smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
> +					     time_expr_ns,		\
> +					     timeout_ns);		\

[ ... ]

> +	/*								\
> +	 * We arrive here once the loop condition is hit, on timeout,	\
> +	 * or, if we hit both the timeout and the loop condition.	\
> +	 *								\
> +	 * The last case is low probability, but possible in the last	\
> +	 * iteration, especially on architectures with waiting		\
> +	 * cpu_poll_relax() implementations (ex. arm64).		\
> +	 * Now since the loop condition is not evaluated on timeout,	\
> +	 * we have a missed control dependency.				\
> +	 *								\
> +	 * So, force a re-evaluation of the control dependency to	\
> +	 * provide an ACQUIRE ordering for that case as well.		\
> +	 */								\
> +	if (cond_expr)							\
> +		smp_acquire__after_ctrl_dep();				\

[Severity: High]
Does this standalone if block fail to extend a control dependency to the
macro caller's subsequent code?

Control dependencies apply only to the then or else clauses of an if
statement, and do not extend to code following it. Because the caller's
subsequent instructions execute unconditionally after this if block, it
appears no control dependency is established for them.

On weakly ordered architectures (like RISC-V and LoongArch) where
smp_acquire__after_ctrl_dep() defaults to a read barrier like smp_rmb(),
this relies entirely on the control dependency for load-store ordering.
Without a structural control dependency on the caller's code, could the CPU
reorder the caller's stores before the macro's condition load completes,
breaking the required acquire semantics?

> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D6
