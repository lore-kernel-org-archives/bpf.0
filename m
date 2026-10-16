Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640436F8EB
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135273; cv=none; b=BUyOVlF2EbjcaN77h8+UcNgY+fRHHfnQZW5TU+7C361W2EyBeTAnE0Hcmdeu3USXTErcV6J4etrDGERU0ZqBpczwT/Sa5fwpLQwhlUBhgg8xyS+QkXm52crcfSW41ZszaSFs3kwuJc4eViCUaoNZGm4zZI1IUMQMogwB7kgjCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135273; c=relaxed/simple;
	bh=F4mB44wKNNfgZy85RyFtxNidcrEi7CvsqEQAqFZvZ+I=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=NRzSe178JHPCIWa4Yj1f3t3zucA6dj8w8TmffC2UQy+tskVOYMbql4U98MSTxPSuxpBYGU4wXvlm+22puZWfXIBspt6B9olPGW28D0QRC8wNUvIK7rgHrQA/Dqv5Hp6E683CCw3hud1gys/08KhIzAl8yyPVOOlBpTBtpOZjCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpgmU15C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpgmU15C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747FA1F000C4;
	Fri, 16 Oct 2026 07:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135271;
	bh=Zpi6lf7tZEna30RVzZ0MthyP9mMzNzP3beeiLAtLwZk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jpgmU15CQ8YcmuObDhY6NF9VBtQM14RiRyVve2gyWehasKMCXNSex3H6BPOSc1iax
	 Pm8SeA5bYGI+g0t9DH3CwZ9Rh7IM+/3sAkbku+Y8x9Wem47Oy++mcoQe7dF+lST5Z4
	 fm23xyqVlqMQDewd2LAms3ObYYgNijAcxVfrtRvH/EJeZW1gS/YQcbqMXc6hGm2ycw
	 HD8QrFrrKP+otKCRgQNephr2x2r8U/jCu6Lsqo48S0H7TQAu0R1w2NQtpOIt67a20V
	 gdcOUD1J5vPIbW6WJqe9v99s2JlaeR6moQESBSFl0MYXKb6brqiTGWwmnxqAg5fAv4
	 fHpWFblB9tf3Q==
Message-ID: <sashiko-outbox-173918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/16] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-7-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:21:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] barrier: smp_cond_load_acquire_timeout() lacks ACQUIRE ordering on=
 timeout
- [Medium] barrier: __smp_cond_load_relaxed_timeout() blocks for 1us on fir=
st iteration
--

commit 8af3000143cb6b1410d5362105d417992cfb019c
Author: Ankur Arora <ankur.a.arora@oracle.com>

asm-generic: barrier: Add smp_cond_load_acquire_timeout()

This commit adds smp_cond_load_acquire_timeout(), which serves as the acqui=
re
variant of smp_cond_load_relaxed_timeout(). It performs its own error check=
ing
and reuses the relaxed logic for the wait, relying on a control dependency
followed by an acquire barrier to provide LOAD->STORE ordering.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index ac0a8b5e0ffe7..fc244dbd040b0 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
[ ... ]
> @@ -383,6 +383,53 @@ do {									\
[ ... ]
> +	VAL =3D __smp_cond_load_relaxed_timeout(ptr,			\
> +					      cond_expr,		\
> +					      time_expr_ns,		\
> +					      __scl_timeout_ns);	\

[Severity: Medium]
Will this macro block for 1us on the first iteration even if the caller
requests a very short or zero timeout?

Looking at __smp_cond_load_relaxed_timeout(), it initializes
__scl_timeout to NSEC_PER_USEC and unconditionally calls cpu_poll_relax()
before checking the actual timeout_ns:

    u64 __scl_timeout =3D NSEC_PER_USEC, __scl_time_end =3D 0;
    ...
    for (;;) {
        VAL =3D READ_ONCE(*__PTR);
        if (cond_expr || __scl_timed_out)
            break;
        cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);

If an architecture implements cpu_poll_relax() with a precise timeout, could
this penalize callers who requested a minimum wait with an unnecessary 1000=
ns
delay?

> +	/*								\
> +	 * We return having waited on the control dependency,		\
> +	 * (cond_expr || __scl_timed_out). Since we break out only	\
> +	 * after either of these conditions are true, the conditional	\
> +	 * separates the execution stream into two happened-before	\
> +	 * and happened-after sequences. And since STOREs are not	\
> +	 * speculated, this takes cares of the LOAD->STORE ordering.	\
> +	 *								\
> +	 * Provide the remaining LOAD->LOAD ordering.			\
> +	 */								\
> +	smp_acquire__after_ctrl_dep();					\

[Severity: High]
Does this code actually provide ACQUIRE ordering on the timeout path?

Inside __smp_cond_load_relaxed_timeout(), the loop exits via:

    if (cond_expr || __scl_timed_out)
        break;

When a timeout occurs, __scl_timed_out is set to true, and the loop continu=
es
to the next iteration. On this final iteration, the compiler statically kno=
ws
that __scl_timed_out is true.

Could it optimize the branch into an unconditional jump to break, destroying
the control dependency?

Without a control dependency, smp_acquire__after_ctrl_dep() only provides
LOAD->LOAD ordering, and the LOAD->STORE ordering required by ACQUIRE
semantics is lost on weakly-ordered CPUs. Can this lead to data corruption?

> +__scl_out:								\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D6
