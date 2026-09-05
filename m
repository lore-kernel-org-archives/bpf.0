Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278927144B
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586328; cv=none; b=f6/2FfFpQ8OLJzWLfUPRhv/gF48aDWJigzxBS72TqFakHakE7IVy8Chufibdy3vpxedSKScDfMqJVQsmXWjEzExg8OlqI+JhEcu9/9eNqHss9fCQ/lqXun/JaD5mNI93IIP5MZrdxWPQ+qXNeNXSoclDMERkQMGKiQV4Cd53EwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586328; c=relaxed/simple;
	bh=X5yFZnPrJV88hVCMx0d+0oNHfaWKlgvR/rLaSARBzHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iX4FcBnvlI3w7qM/mRoDXT0sUr/uMlO4F6YKj8+WZYXedP3JfmKWQ00W7TYqpCxjFfk0s187h69SQTXIvUmSx0wtHIExGSPl5EIRoV5hmmILKTWFVV6pJGo06WLn1yJJiK1NEZEowsXTi1gWBdgqoBpqGNEB/z0nLSLJUO+/tNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc9qr2nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc9qr2nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C6E1F00A3D;
	Sat,  5 Sep 2026 05:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788586326;
	bh=SL3AK5jlAiGiVs/7/zqs1aaN4oQqDLh3Bd4ioidItoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc9qr2nBMskT6wMkEOTFo7Q7jG9Q4HhC9pV/pmi073PyPISR0RnITXvkVGdzT+E6N
	 HokAyao9WYjK1MZnbtKjR3Iv6f740dJngijByc4dmlK6rvmJPCxY96eDH1KX1TKTR/
	 w28jj9MZE3G5SOE6anQRWYPZoouOictgcqcWZQl9EtPNYNQsXJuk+s3PpBP8MLtgBO
	 yMcjYiECgng+wr/H3VpSnP9xqAGfLHfnuH3jJi4Ra8jw9kSAp1hWPLI2doVSPZs3XD
	 xmd16TySBJ58fn+Kj/+DmRnvxukPrjWXGPtF15BaOfruxVDtjASyQ0ROA5LvL/lsKu
	 T4nPiboRaSQsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each
 sleepability context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905051224.2325381-2-memxor@gmail.com>
References: <20260905051224.2325381-1-memxor@gmail.com>
 <20260905051224.2325381-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 05:32:06 +0000
Message-Id: <20260905053206.87C6E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global subprograms can bypass caller lock and reference balancing =
by using bpf_tail_call(), leading to permanent resource leaks.
--

commit abbef478df8567a76eb64989bbf7f08c717afd13
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Verify global subprogs in each sleepability context

This commit updates global subprogram verification to independently verify
each context (sleepable and non-sleepable) that calls it. This prevents
non-sleepable callbacks from incorrectly treating the context as sleepable
and allowing RCU-protected pointer misuse.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b51e7ee1a3f9..f759a020c8a5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9988,11 +9989,10 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>  		if (env->log.level & BPF_LOG_LEVEL)
>  			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
>  				subprog, sub_name);
> +		sub_aux->called[in_sleepable_context(env)] =3D true;

[Severity: High]
This is a pre-existing issue, but while reviewing the global subprogram
execution context changes here, I noticed a potential resource leak
related to tail calls.

When a global subprogram is verified independently with a fresh verifier
root in do_check_common():

kernel/bpf/verifier.c:do_check_common() {
        ...
        state =3D kzalloc_obj(struct bpf_verifier_state, GFP_KERNEL_ACCOUNT=
);
        ...
}

The new state starts with zero locks and references. If the global
subprogram executes a bpf_tail_call(), check_resource_leak() inside the
subprogram's verification will succeed.

However, back in the caller's context in check_func_call(), the verifier
seems to evaluate the call assuming it will return normally:

kernel/bpf/verifier.c:check_func_call() {
        if (bpf_subprog_is_global(env, subprog)) {
                ...
                if (env->subprog_info[subprog].might_throw) {
                        branch =3D push_stack(...);
                        return process_bpf_exit_full(env, NULL, true);
                }
                /* continue with next insn after call */
                return 0;
        }
}

The caller check correctly handles divergence for might_throw, but
appears to silently ignore has_tail_call for global subprograms. If a
user program acquires a resource (e.g. bpf_rcu_read_lock) and then
calls a global subprogram that performs a tail call, does this bypass
the caller's resource cleanup and validations, permanently leaking the
resource?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905051224.2325=
381-1-memxor@gmail.com?part=3D1
