Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926C3AEF4A
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907269; cv=none; b=ce2/qjoZstl/eFpCoKXsoe5onoC1v6QYRVvBCT2f0FRhVcX5sTD4RpWneIroyuPYxbPQ27K679LkMtJleYe+wUGxwBUMzvNUFNil9yoAug74EzQRGLWR8a44Pqf7fJI31hdX118LpEOYRsElz4ImdUdxCZ8v/nU5sr8eqEhbopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907269; c=relaxed/simple;
	bh=S4bBjnCGjsC2BWuLIr5I83iVS2dQJBmuksSVJLQ/ReQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=StqhFqu8vqHEsId1/ONemclrfTmJODi7s701oBgyHJunS7XRx3ax8pldZvPhZ3soBgZjb/EbyeuA1IZQH1IfZmyxJvc3WfhbBNnLRrzLwdDR/fgSn3ui137JWoj7ROTm40ZWo2g5KZMzozBtqkxEfe4ab4fQZoOkT99fo07VF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRUG0WG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRUG0WG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399BB1F00898;
	Mon,  8 Jun 2026 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907266;
	bh=UNFVl6CGRdqx2ftUWo01UqUsIxDmH6U37EdYcgfHkfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRUG0WG9x1ywOrzNf79zJ0GOUZdAjQZZn11koR/LUcXWPBPEnFIRuB93Lc83+Laz/
	 QGmmWjETb+h3hTpFgxDoLWzPK2bP3U1mcWA+Y0DMtq3/gSua/nmJs6EgssTYRtC17J
	 vVmBTTFP8ZIQwwxLS8+MTZkgjK03FMBCaZhfdQIwd2/pPAsdOD7XDv/GKtAKIrL1HY
	 /eOOIN5RBk4kidWMoAAPHn1GSwFnycmaVKXvAWenh1RrjCoqTsxlVAOG06zDgCflUc
	 tKIiwp6hQcemX49vH0GfXCrJT1x7t3WIq2/3vqy5ejiMwKKy74iMJBYX0gGSdmkio2
	 OzHhf+02QzRzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/15] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-7-ankur.a.arora@oracle.com>
References: <20260608080440.127491-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:27:45 +0000
Message-Id: <20260608082746.399BB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ACQUIRE semantics violation in `smp_cond_load_acquire_timeout()` o=
n weakly-ordered architectures.
--

commit 0c67207964772b92d28f5af7e4a97ea44a103e9b
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_acquire_timeout()

This commit adds the acquire variant of smp_cond_load_relaxed_timeout().
It attempts to provide acquire ordering by reusing the relaxed variant and
adding a control dependency combined with smp_acquire__after_ctrl_dep().

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index c56df9513a084..0ab26e98842c0 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> +/**
> + * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE o=
rdering
> + * until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond_expr: boolean expression to wait for.
> + * @time_expr_ns: monotonic expression that evaluates to time in ns or,
> + *  on failure, returns a negative value.
> + * @timeout_ns: timeout value in ns
> + * (Both of the above are assumed to be compatible with s64.)
> + *
> + * Equivalent to using smp_cond_load_acquire() on the condition variable=
 with
> + * a timeout.
> + */
> +#ifndef smp_cond_load_acquire_timeout
> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	VAL =3D smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
> +					     time_expr_ns,		\
> +					     timeout_ns);		\
> +	if (cond_expr)							\
> +		barrier();						\
> +	smp_acquire__after_ctrl_dep();					\

[Severity: High]
Does this sequence correctly establish a control dependency for the caller's
subsequent instructions?

According to Documentation/memory-barriers.txt, control dependencies only
apply to stores executed strictly within the conditional clauses (the true
or false branches), not to code following the if statement. Since the
caller's subsequent stores reside outside this conditional block, they
appear unconditional to the CPU.

Furthermore, smp_acquire__after_ctrl_dep() typically falls back to
smp_rmb(). On weakly-ordered architectures like RISC-V, where smp_rmb() is
implemented as "fence r, r" and only enforces load-to-load ordering, could
the CPU speculatively execute subsequent stores before the final load of VAL
completes?

Could this violate the expected acquire semantics if the caller relies on
the barrier in the timeout or failure path?

> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D6
