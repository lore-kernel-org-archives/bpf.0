Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286247;
	b=5pz7ZCgpOsA4ok4TaABQiCS4iJm/B2gT3/0Br9MxpWsrUA2VSaHhgv0eqMaGvfLtZ0z+
	 7HfEJHxyfFrNULjoel3TOB2jtAEkkKqiXmyMcQYDrw/RWew7ezUwphBIieaxZiPzIDtfX
	 b28GVbCyUmlw8VePeg4UOeCfJaCJzMFb4DM82amu4K+gmNIKShbil0mABtGYmJmW19LD6
	 IODV5hVIvZd4ZAIyPNn9ZEAFaCa9tt9Us6p8pwOQEFTDK0vFwSYI+dOQacbqTG2vayx3N
	 BPzF5GquWLPMGu/P8iXfuFJTJP8JgZ0KN/0mjBwHuN5yeDoqwJSYwxt72LVWRJntArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286247;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uUSXF++k3X6U+btA8A8mKh0hQqVFxLofdWTVQB6Gcw8=;
	b=30k6o5qYr4RqiAbn5DMbzATbauMGOXPUEGu6xoXn5BAEgoQdAdQN/BlSL/OSz3VM2dGe
	 zeifG8R3ygofQ0Tq2myEyeOz+EDg6r5UB4G5YzcBjbWly94rLRLwNNi7mSnfX/10ldM7D
	 0eNhGSCvf6OSOSCxknm7EasmMD2Y45HiUMU0P8SORQekpJCWaFNyGOSMP9elBzTZjuWXc
	 YkQbkCqV+wGcL3lR7EEJLDhEJmbLTeYm/euI739q0tExQBXR5GuJ4IaDRJrtTU2ulYS8k
	 BrR+8wOWrOJYkPCg2iM6dPCqlfYaE4wZ3mHrHtI5I6+AI6WFOpwhHdZa1GhokWiOIAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4K9s3rP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE397606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4K9s3rP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1281F0089F;
	Tue, 10 Nov 2026 04:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286246;
	bh=uUSXF++k3X6U+btA8A8mKh0hQqVFxLofdWTVQB6Gcw8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P4K9s3rPFGgj35JSIGWJoU70U15f3sFKIAUoyf8fenWoabaM1SpD+SFExOXVpMTZV
	 gbGDyhrErpoqRAkuYLawl79nV6D9B/sPFBvDjFAgOos6ercocDDGSk019waLGunvVP
	 tldWq+uHSmAzX+0NHLN8OUCB6k5HBceDZbVCA5T/RMYG7qK6xC4TbEDM/4JXTtrdYe
	 o6YL3iQH3+w8OVAwqdlLeuylxYMq6FeuVXOlgMdMKf4V793loWH7wyhIJNhS7nfHv6
	 LOlWm5R75unIOradr2SdIcOfNcBpYZ/0u4S4jY4kzV8lOhDtIS1u+ghP9O2j5pLwcP
	 ErpBpCCDvUKUg==
Content-Type: multipart/mixed; boundary="===============0309396820824063337=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b43445709e26b8edd5a243f524126de7f5a68a7969601273a78aeee02d2e4e0a@mail.kernel.org>
In-Reply-To: <5b21348bcf56086efa89aae60bd62f4966aac099.1794269506.git.memxor@gmail.com>
References: <5b21348bcf56086efa89aae60bd62f4966aac099.1794269506.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/20] bpf: Keep programs that park away from per-CPU state and tail calls
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:46 +0000 (UTC)

--===============0309396820824063337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep programs that park away from per-CPU state and tail calls

TL;DR: A program calling bpf_task_park() that also has a recursive static
function may be refused at load with a may_goto error, since the recursion
check inserts a may_goto. Commit message doesn't mention it.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -2862,6 +2862,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			u16 live = env->insn_aux_data[i].live_regs_before;
>  			int reg, save_off = 0;
>  
> +			/* The count and the time are kept per cpu, see bpf_timed_may_goto_save(). */
> +			if (prog->aux->may_migrate) {
> +				verbose(env, "may_goto cannot be used in a program that may migrate, also not in a loop that gets one\n");
> +				return -EINVAL;
> +			}
> +

Can this refusal also trigger for a program that has no may_goto and no
loop?

bpf_insert_recursion_checks() puts a may_goto at the start of every
recursive subprog:

    buf[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, n - jmp - 1, 0);

That pass runs before bpf_do_misc_fixups(), and the instruction passes
bpf_is_may_goto_insn().  On a JIT with timed may_goto (x86, arm64), a
program that calls bpf_task_park() and also has a recursive static function
would fail with:

    may_goto cannot be used in a program that may migrate, also not in a
    loop that gets one

The call path would be:

    bpf_check()
      mark_recursive_subprogs()          marks the subprog recursive
      do_check_all()
        check_kfunc_call()               sets may_migrate
      bpf_insert_recursion_checks()      adds the may_goto
      bpf_do_misc_fixups()               timed may_goto, returns -EINVAL

The commit message only mentions loops ("a loop in such a program needs a
bound of its own, as bpf_repeat() gives it"), and bpf_repeat() is not a
workaround for recursion.  Should the commit message mention that
recursion is refused as well, or should such programs get the stack-counter
may_goto instead of the timed one?

Note that bpf_task_park() becomes callable from syscall programs in
3882097246c1 ("bpf: Register bpf_task_park() for syscall programs") later
in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============0309396820824063337==--
