Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955003;
	b=5EVTh+hqLQt6WmYygJhS4WhRtnfUp749lhNkr8PB+bh9/mFSmKCgTLc59V+8gsbDEkAB
	 39N0q5/v7D5fzxr9rUR/bF30qVaMA7SHdBSDM+2mG7u3xEknKQbZ1vYC+u9tOnGECAk5j
	 /QOSm6z/4uMMhxajyhK8FyroFonPBJuhZGtHK6cZHQNN4kIqinMffeH9KeQZvXmibENKV
	 p7kbteOGnDMcV69rOtN9kw4e+rPSI3cgrrnwFfIiifoG0CTCf26uZBx8lLRsrJeK5E5vV
	 jZzNlJ7mNgCVPsu4kToGd083RShYBj8eqt4qF5QN+31aUXwTIhnh7hwyIRa24Z39EuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955003;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=SdF3Rp3aXseTSt7FOhdZEwPXaenKJclgaNBdiWfNt5U=;
	b=qvrJzTZZTGSynD0/9eDesFyV3+XirR38DSmMh9NhZenWFD+NYvbi6CW5/haLGsCdggrV
	 2DDn1Ky5EuL3BPQqrMqPwPWrmhv/e+V/MD9cnVFyDNZV6De4HKQVMaFmlqiVGgqFEVC+h
	 BBu3AnIILQWRYmS005kXbNlRjV7FqE4IbZEpfNnIhlzfXkZFWx1zeID70dtxyG5K6WM/n
	 eGUAAoOtgypVl6fxrwnnCuBuEUiJf0NvF6UlH6EDeirQmCVfZaKmbQWhKUAFBnA1wxeay
	 HqMyFY4ZG90UJSYlg/gEEFyQfunIdhwKvOPJguRkauyix+LT+np9uqr9V69AhgMJ9dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv1daKAp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1B606A32E;
	Fri,  6 Nov 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv1daKAp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C18A1F0089F;
	Fri,  6 Nov 2026 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955003;
	bh=SdF3Rp3aXseTSt7FOhdZEwPXaenKJclgaNBdiWfNt5U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Rv1daKApPZsdy9p1MlRmXzwhKibB2xD8VaT/OpYZnlacG+jl0nEQ0gEmN+zeytTcG
	 CD/KxGsG2A4chKOxahUbbr1vQwpvOf7OJo2L6Ig3JVTtWqkufmJNb6X8NxqF2ERut7
	 N95K0Rju33TmZZ51i2IXNDJXZHsLvRG1FJ0lfZOTlqKj3fKKWdAMveS2GbLQqvfZPD
	 3zE63W5EZmFkOJns0gdqXyu+Se/qis+aOLsBvdhB4J/ULoSCpmU3tRU+2/RUcDCMjQ
	 zLat+wKlQjj+33KDQjdNfMq6BeY+Qsd5+T/nzoc7N8Ok9+ZN839+nGFubyeNv9oAEX
	 BtCZVQtsOXcEQ==
Content-Type: multipart/mixed; boundary="===============0514556948363618847=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b7b3f0926c35e8192180326438de9b6c119125a50ffb23b8d5754f31f47a999c@mail.kernel.org>
In-Reply-To: <20261106080746.661431-1-yangfeng59949@163.com>
References: <20261106080746.661431-1-yangfeng59949@163.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add sleepable version of bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 08:50:02 +0000 (UTC)

--===============0514556948363618847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add sleepable version of bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto

TL;DR: Marking the new sleepable bpf_get_stack prototypes might_sleep may make
the verifier reject sleepable programs that load today, e.g. calls inside
rcu_read_lock regions, even without BPF_F_USER_BUILD_ID.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -1725,7 +1774,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_get_stackid:
>  		return &bpf_get_stackid_proto_raw_tp;
>  	case BPF_FUNC_get_stack:
> -		return &bpf_get_stack_proto_raw_tp;
> +		return prog->sleepable ? &bpf_get_stack_proto_raw_tp_sleepable
> +				       : &bpf_get_stack_proto_raw_tp;
>  	case BPF_FUNC_get_attach_cookie:
>  		return &bpf_get_attach_cookie_proto_tracing;
>  	default:

Can this make sleepable programs that load today fail to load?

The new prototypes set .might_sleep = true, and check_helper_call() rejects
such a helper whenever in_sleepable_context() is false:

    if (fn->might_sleep && !in_sleepable_context(env)) {
            verbose(env, "sleepable helper %s#%d in %s\n", ...);
            ...
            return -EINVAL;
    }

in_sleepable_context() is false inside bpf_rcu_read_lock(),
bpf_preempt_disable(), bpf_local_irq_save() and lock regions, and inside
rcu callbacks such as bpf_for_each_map_elem() on hash maps and
bpf_find_vma().

Before this patch the same call resolved to bpf_get_stack_proto_raw_tp or
bpf_get_stack_proto_tp, which do not set might_sleep and never fault.  For
example:

    SEC("lsm.s/file_open")
    int prog(void *ctx) {
            bpf_rcu_read_lock();
            bpf_get_stack(ctx, buf, sizeof(buf), 0);
            bpf_rcu_read_unlock();
            return 0;
    }

loads today and would be rejected with "sleepable helper bpf_get_stack#67 in
rcu_read_lock region".

The call chain is bpf_lsm_func_proto() -> tracing_prog_func_proto() ->
raw_tp_prog_func_proto().  The same applies to sleepable raw_tp,
tracepoint, fentry/fexit/fmod_ret, fsession and iter programs.  It also
applies to every BPF_PROG_TYPE_SYSCALL program, since check_attach_btf_id()
forces those to be sleepable.

The rejection happens even when BPF_F_USER_BUILD_ID is not passed, so the
helper could not sleep in those calls.

The commit message acknowledges this ("such programs load today") and cites
commit 9d02927fdf4e as precedent.  That commit fixed prototypes that could
actually sleep in non-sleepable regions, whereas here the old prototypes
were correct.

The verifier already records per-insn non-sleepable call sites in
env->insn_aux_data[insn_idx].non_sleepable, and specialize_kfunc() uses
that to pick bpf_arena_alloc_pages_non_sleepable().  Could the non-faulting
implementation be selected the same way at fixup time for call sites that
are not always sleepable, instead of rejecting them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42188184517
--===============0514556948363618847==--
