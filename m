Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0E2E6CB8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027799; cv=none; b=Y2u/OG+5SUa5swJvh0O4pgHVUZfJjXCXINBDCPHUiF7NZCAGAgqC8SlhojHLepdGeEsuf8sTGP1wsq50CA7w6rB9gNsGWbYlMKmTX0BY0jp7QEMgcdDWL12A/Nw0hJV6W7DZpc8NiOr+C13/24KL6F2cnRqDbTU/E86iEqyVLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027799; c=relaxed/simple;
	bh=ue2ZojBbn2J3Ro8klEBAF4hW8qsaHkMMVo53ZWzrfDI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HH7m7GwqrpgswYIqV4m3fp/4ssjYP0XQViKsxgi6kmnGnIY1wkW0y/fPBaHQB+P0PMV+4TA9I90imD2POC0NjEgOG0IDJAHpWjHEUONy2cefnuzNAMz8n1MjSv7QXBnd+/pvYFw9FrkpZuUBxbAFRWiD/Zle/EkLGDZRTed5t0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB85wcaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB85wcaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DAE1F000FF;
	Mon, 21 Sep 2026 21:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027797;
	bh=+PFGDL5YOECwniarv6dZ9FJcAX0XyqiY0tYbCVAuBHs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NB85wcaKj/Abl7HRpqSLh9ZhA2euvkuJ2pG/b/vVrQ6Np7jm6vuQ+0nmof1Yp+mU/
	 5Y+AUoqbpvwArvaEKATUtQw6jQIk+/OC7erGUYvqeRShCa7D+ShO2nlR2SmGoBwUrX
	 FFW53g/jXzwKO3EHFiWOkN57UoRJle6t+NMtrVU+PZAJAhqlPCX96Ug9cUm23TsaaV
	 cJU4ptDU01UCIj9hETk06PNEtTmPXqyVPfwtch7RqDvE+6+0IrXOsHv0Vvj79L7G/j
	 8HSe8yYRdlM/tpwWSZU5WU3d+IcYT1QzwZ++BORTnvABlyt2MLClAsYgzUxZ9VZk+z
	 4s8O49P8NEP6Q==
Content-Type: multipart/mixed; boundary="===============1368667284345487656=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a3a8b5ec143ca475962d1842d00ec33e41910f570925704d202f50bd375113e@mail.kernel.org>
In-Reply-To: <20260921210043.1715958-1-yonghong.song@linux.dev>
References: <20260921210043.1715958-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 02/20] bpf: Add the bpf_unwind_resume() kfunc
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 21:56:35 +0000 (UTC)

--===============1368667284345487656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 501c7ce35cba..55c59f8b4c43 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3445,6 +3445,19 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>
> +/*
> + * Terminator of a compiler-emitted cleanup landing pad. The compiler names
> + * this _Unwind_Resume, the base unwind ABI's entry point for carrying an
> + * unwind on once a frame's cleanups have run. To match kernel kfunc
> + * convention, the kernel calls it bpf_unwind_resume and libbpf maps the
> + * compiler's name onto it.
> + */
> +__bpf_kfunc void bpf_unwind_resume(void)
> +{
> +	/* Never reached: a JIT emits the way out of a landing pad instead. */
> +	WARN_ONCE(1, "A JIT should have replaced the exception cleanup resume\n");
> +}
> +

Does this WARN become reachable at this commit?

The kfunc is registered for BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_SCHED_CLS,
BPF_PROG_TYPE_XDP, BPF_PROG_TYPE_STRUCT_OPS, BPF_PROG_TYPE_SYSCALL and
BPF_PROG_TYPE_CGROUP_SKB via generic_kfunc_set in kfunc_init().

A program of any of those types can emit a plain call to bpf_unwind_resume
and load, since there appears to be no verifier handling for the kfunc at
this commit. Searching for 'unwind_resume' at 53430aa9b73a in kernel/bpf/
and include/linux/ returns only the two lines this patch adds.
bpf_is_unwind_resume_kfunc(), kernel/bpf/exception.c, and
process_cleanup_resume() do not exist yet.

No JIT lowers the call at this commit either. bpf_jit_supports_cleanup_pads()
and the x86/arm64 dispatch land later in the series (eeb1e94ae895,
3240611f5542). So the call really does reach the C function.

Running such a program, for example a BPF_PROG_TYPE_SYSCALL program via
BPF_PROG_TEST_RUN (which needs only CAP_BPF), would produce a WARN splat
and panic the box on panic_on_warn=1.

Contrast this with the neighbouring bpf_throw(), whose WARNs are
unreachable because check_kfunc_call() gates it in kernel/bpf/verifier.c:

	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
		if (!bpf_jit_supports_exceptions()) {
			verbose(env, "JIT does not support calling kfunc %s#%d\n", ...);
			return -ENOTSUPP;
		}
		env->seen_exception = true;
		...
	}

The rest of the series does eventually add the equivalent gates.
cleanup_check_resumes() rejects "bpf_unwind_resume() at insn %u is not
in an exception cleanup landing pad" and process_cleanup_resume() rejects
"bpf_unwind_resume() at insn %d reached without an exception in flight,"
but they are not in this commit. For the 17 commits between this one and
the end of the series, the WARN is reachable.

Since the gating mechanism is known and exists later, should the kfunc
registration be deferred until the verifier check is in place? Or should
this commit carry a minimal check_kfunc_call() rejection of the call
(as bpf_throw does) rather than relying on a JIT that does not exist yet?

> @@ -4981,6 +4994,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
> +BTF_ID_FLAGS(func, bpf_unwind_resume)
>  #ifdef CONFIG_BPF_EVENTS
>  BTF_ID_FLAGS(func, bpf_send_signal_task)
>  #endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472
--===============1368667284345487656==--
