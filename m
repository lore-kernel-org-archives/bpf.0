Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250362;
	b=ckhQam9jMpQS1BBR89e6PWS8nbFm9kT0320SE8a7BK+nr/Owz6Vnb6s/XybKwhhQNAq8
	 K3pSRTFVvRZGcXdtIc1HaoVJcFPr9DgGKrkvxO8gWFfG+MPHZB8ldeRR7z8bjYPEgvmqe
	 jWHLGO7cbf43QWMdCBhaMG21ujuKu5bJrAR6bqaTcllGyLcjlcAiT3/C+Uhda+Dd0kv+8
	 Hq1TgcaQS75sTTGh520kMt4k7VXpfF+6FG29SGZMmHNG5Cphgbl5VmFjWu0MmitF+Z+Kd
	 h3x0BkdPh+q7+g4UrJRJXw+RXqEc8jBm5qQoFfi7AVCPyFLGlaUUvEf4OW3jiygQtvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zvftnLkucFAnzvIDT3HdE2CERRj2yNZE7jBvd5JT/GY=;
	b=ySw2Hav3eXWryMaejKuSJcUlgchoqw3r5ekkdaMAppwUvq3MA8m8z8m36YW+1RJd51FC
	 258xni85vQ1lq4FSebKdo6/LZkYqy6kTxytkATIJISDz7hSIX/TRN/5dpVr8MX6180uVI
	 sG5bMGGxKVgZ8iLb2zWBc3uzjBxQhide9RYQlf36D/tnqLMG61wr4+hY33pcITnelpR0d
	 CBYX5pzyLg/dM2KkTMBd/MWWID+QZHzc3rkWQ8U1nD+YysOI6MYFP9yk1heZmijPMTxaY
	 3JvyOnHAej4JLixJLGHeFHeHgSBw0sNa63c3Xnb4HRR6aIMaBBiQWSAj6nP1AqXdOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSOuzIRF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB4606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSOuzIRF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953411F008A1;
	Mon,  9 Nov 2026 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250361;
	bh=zvftnLkucFAnzvIDT3HdE2CERRj2yNZE7jBvd5JT/GY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSOuzIRFRaw97/TEK/MLPrGKl4a46RPK2amy3Es1DhdxbM5psFv+uBObc7db+dG+c
	 HCdehMRlrejjzSoBc+brnDstbXFGd3yX86bK3A2TtuI87AH6DsnJWj5TQh9+YsiULZ
	 iCj5KO5bvJokdrGyjuvLrzVT6B/BAg0lp8pOSIRmHL6DJNfDf7aaqQUEv0VR1SoDq+
	 bW8tRNsd1Fqwzxez5Ep81tR07g24vnf68ph3tIF1G05GCYVk/Tj7TKg/PRieGM1tNR
	 n1lbCUVmTFwp3EaG/melvmdY46I6iPudXsGSdfs3XfOZnl6HitEbOXrehZaTQzoOlD
	 yagaJeT8hAYgg==
Message-ID: <sashiko-outbox-205446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] x86/shstk: support via prctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109182758.252223-5-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
 <20261109182758.252223-5-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:52:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] x86/shstk: missing 32-bit check in prctl status helpers
  corrupts user stack
- [Medium] x86/shstk: missing X86_FEATURE_USER_SHSTK check in shadow
  stack prctl helpers
- [Low] x86/shstk: unreachable rollback path in
  arch_set_shadow_stack_status()
--

commit 9a3ff7cedb6830c75ef0c0aa6dd108c66cfde589
Author: Bill Roberts <bill.roberts@arm.com>

x86/shstk: support via prctl

This commit implements the generic PR_SET_SHADOW_STACK_STATUS,
PR_GET_SHADOW_STACK_STATUS, and PR_LOCK_SHADOW_STACK_STATUS prctl()
operations on x86 using the existing shadow stack helpers.

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index eb690ba90180c..6dfe310634b02 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c

[ ... ]

> @@ -630,3 +631,82 @@ bool shstk_is_enabled(void)
>  {
>  	return features_enabled(ARCH_SHSTK_SHSTK);
>  }
> +
> +/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS an=
d its feature bits */
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +	int rc;
> +	bool shstk_was_enabled =3D features_enabled(ARCH_SHSTK_SHSTK);
> +
> +	/*
> +	 * Enable/disable the full feature set and preserve the original state =
for rollback.
> +	 * Only act on changed features, since shstk_prctl() checks locked bits=
 before checking
> +	 * feature status.
> +	 */
> +	switch (status) {
> +	case 0:
> +		/*
> +		 * Do not explicitly disable WRSS. Disabling shadow stack also
> +		 * disables WRSS, and a locked WRSS must not prevent this.
> +		 */
> +		return shstk_was_enabled ?
> +			shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK) : 0;

[Severity: Medium]
Does returning 0 here when shstk_was_enabled is false, and delegating
arch_lock_shadow_stack_status() and arch_get_shadow_stack_status() to
shstk_prctl() without checking cpu_feature_enabled(X86_FEATURE_USER_SHSTK),
cause these prctl() calls to succeed on CPUs without shadow stack support?

shstk_disable(), shstk_setup(), and wrss_control() all check
!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) and return -EOPNOTSUPP, but
ARCH_SHSTK_STATUS and ARCH_SHSTK_LOCK in shstk_prctl() do not, and case 0
here bypasses shstk_disable() when shadow stack is not enabled.  On systems
without X86_FEATURE_USER_SHSTK (or booted with nousershstk),
PR_GET_SHADOW_STACK_STATUS, PR_LOCK_SHADOW_STACK_STATUS, and
PR_SET_SHADOW_STACK_STATUS(0) return 0 instead of an error, misleading
userspace probing for shadow stack support.

> +
> +	case PR_SHADOW_STACK_ENABLE:
> +		if (!shstk_was_enabled) {
> +			rc =3D shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		if (features_enabled(ARCH_SHSTK_WRSS)) {
> +			rc =3D shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
> +			if (rc && !shstk_was_enabled)
> +				shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +			return rc;
> +		}

[Severity: Low]
Can the rollback check (if (rc && !shstk_was_enabled)) ever be reached?

wrss_control(true) requires ARCH_SHSTK_SHSTK to be enabled, shstk_disable()
clears both ARCH_SHSTK_SHSTK and ARCH_SHSTK_WRSS, and shstk_setup() only
enables ARCH_SHSTK_SHSTK.  Whenever features_enabled(ARCH_SHSTK_WRSS) is
true here, shstk_was_enabled is already true.

[ ... ]

> +/* Handles the generic prctl interface for PR_LOCK_SHADOW_STACK_STATUS a=
nd its feature bits */
> +int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long s=
tatus)
> +{
> +	return shstk_prctl(t, ARCH_SHSTK_LOCK, status);
> +}
> +
> +/*
> + * We assume the prctl() feature bits line up with the arch_prctl() spec=
ific ones. If not,
> + * the flags returned via arch_get_shadow_stack_status will be mapped wr=
ong.
> + */
> +static_assert(PR_SHADOW_STACK_ENABLE =3D=3D ARCH_SHSTK_SHSTK);
> +static_assert(PR_SHADOW_STACK_WRITE  =3D=3D ARCH_SHSTK_WRSS);
> +int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __=
user *status)
> +{
> +	return shstk_prctl(t, ARCH_SHSTK_STATUS, (unsigned long)status);
> +}

[Severity: High]
Can a 32-bit compat or x32 caller corrupt 4 bytes past its status variable
via PR_GET_SHADOW_STACK_STATUS?

Previously, shstk_prctl() was only reachable from sys_arch_prctl(), which
rejects in_ia32_syscall() upfront, so shstk_prctl() only checks
in_ia32_syscall() inside shstk_setup().  Because sys_prctl() is wired to
32-bit and x32 syscalls, calling prctl(PR_GET_SHADOW_STACK_STATUS, &status,
0, 0, 0) from 32-bit or x32 userspace reaches shstk_prctl(ARCH_SHSTK_STATUS)
and executes an 8-byte put_user() into a 4-byte userspace unsigned long:

arch/x86/kernel/shstk.c:shstk_prctl() {
	if (option =3D=3D ARCH_SHSTK_STATUS) {
		return put_user(task->thread.features, (unsigned long __user *)arg2);
	}
    ...
}

32-bit IA32 callers can also lock features via
arch_lock_shadow_stack_status() and call arch_set_shadow_stack_status() to
disable shadow stack, toggle WRSS, or get 0 back for status =3D=3D 0 instea=
d of
-EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182758.2522=
23-1-bill.roberts@arm.com?part=3D4
