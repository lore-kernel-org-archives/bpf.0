Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415690;
	b=l8h87DgILhlpssEv1jDVjMUX7HXfZM1nn1R81T3IcfAmCUxBACCDtY8Apr6T3kIJT+hU
	 L4+CRd/XKkiwJllI/YkCv/vE1VgYx1wj4VknQaF+tRkZv9gs/eyGAWXvPzrUoN2SAExnk
	 r7DxgOE8tJ6gQ/2NQQys/8uXT49ucqq+2/fVZCzzMyvo6okPhVuh8oOHXPbT0VWNprtq6
	 54AIwwrm+5BOxZhg4vEk3imBRiOAbTq9FuY6S4OCf7wx+0VrMtTnGOVHR5UHhvHi3zTQF
	 2JAuGaKeywXQFevZQdJ+WCO66PKArNOGDy5zV8kDZfIOZ/SCSdOOYl8OADMx3cRi6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415690;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2f3UL0Ja+IDq+cHIWiSmCXBcKzbiYJ80rzLJ6FYTnTk=;
	b=TlFMiHtsUY/nNyVDcmxe2Fprqy3kY45slWRIlO9KDDHiW51yrl/TeIlwKIzO/OD+qFGe
	 mJCTRB1KETqRRhAerxoTEeaqzkQnjxRYbTEICzHT5LBZzLbsE8MplqsNTtGeSVayxsg6s
	 dHEUI+US81rTLfCW3geki/QsOn2kAUGEJc/77TKHd90YTyTv5dZAgFkD589DyhdtHrwUR
	 tR+6UHES7IOpNI0Ifhiv0LJ2hfr7SMdfyypTIMUQWtCo838xOFTBodTWvn1MPHschK5M+
	 T8CPA6lAfqDXunOty20YaROIXOBeEnFLIsZObX0SRpK4NvWN5HUJmui8Sw3yJJXG6EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omUlc6I1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE9606A327
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omUlc6I1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6BA1F000C4;
	Mon, 23 Nov 2026 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415690;
	bh=2f3UL0Ja+IDq+cHIWiSmCXBcKzbiYJ80rzLJ6FYTnTk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=omUlc6I1QmrAUQ3G1YWiqT1f+ocGx53UI/dPemBkyVPNes4EUxcqCEPZ9JBffXm2F
	 u4BhkDUSBvjC4015ZHg0Z9z8EsvsIPIMGU9B5Teya7h9XIPlXZ5UxL42/aWGYX5Kk6
	 2P44dHCXPqZFCUlzwtOWHPJUiuXgbsRTBq+C9729hPc53TZFyuCjIrQhiLjVUEGsOS
	 o0m/fJ4zVbWjMtO+qJVW7ZdGzVnnBjhvstINYGZFoTEbIWjh2AE4uNzPrzGwuYx6d8
	 0885VcwwBKwPq6QOts/9z8uTgYacEOhwCY/TQF/ayGpGijQNxsCRTlVFXd6fV43n/k
	 aLIH5zYGIP5FQ==
Content-Type: multipart/mixed; boundary="===============5471762475927380820=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bf813db7405513afd9cf236bc2b001d7e72f579169ece6ce45369c31f5023388@mail.kernel.org>
In-Reply-To: <20261123055708.684107-2-chenyuan_fl@163.com>
References: <20261123055708.684107-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,ihor.solodrai@linux.dev,memxor@gmail.com,nirmoyd@nvidia.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 06:34:48 +0000 (UTC)

--===============5471762475927380820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref

TL;DR: Commit message only: the changelog includes a full crash dump
(kexec/oops frames, registers); the review asks to trim it to the relevant
call chain. No code issues raised.

> bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
>
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
> Root Cause
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base BTF
> deduplication for modules to fail.  As a result, the module retained its
> own copy of struct bpf_prog_aux with a different BTF ID than vmlinux's
> definition.  While pahole 1.31 fixed the BTF generation issue, the kernel
> must be robust against such inconsistencies: a BTF mismatch should result
> in a clean rejection, not a kernel crash or information disclosure.
> When the distilled base dedup fails and btf_types_are_same() cannot match
> the module's bpf_prog_aux type against vmlinux's, is_kfunc_arg_prog_aux()
> returned false and the code fell through silently without setting
> arg_prog.  The kfunc then received whatever value was in the argument
> register and dereferenced it as a bpf_prog_aux pointer, leading to:
>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>   RDI: 0x000000000000046d (stale register value)
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able to
> control the register value -- for example by writing a BPF program that
> explicitly sets the argument register before calling a KF_IMPLICIT_ARGS
> kfunc -- could redirect the dereference to arbitrary kernel memory,
> turning this into an information disclosure.  The fix ensures the
> verifier either validates and injects the correct bpf_prog_aux pointer,
> or rejects the program outright -- no silent fallthrough that could be
> exploited.
> Crash Stack Trace
>   PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>    #0 machine_kexec at ffffffff812f6e26
>    #1 __crash_kexec at ffffffff8145a788
>    #2 crash_kexec at ffffffff8145ac24
>    #3 oops_end at ffffffff812bb67c
>    #4 page_fault_oops at ffffffff813053a1
>    #5 exc_page_fault at ffffffff828e60a1
>    #6 asm_exc_page_fault at ffffffff810012a6
>       [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>       RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>       RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>       RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>    #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
>    #8 bpf_trace_run2 at ffffffff814f8332
>    #9 __traceiter_sys_enter at ffffffff81415f45
>   #10 trace_syscall_enter at ffffffff81416735
>   #11 do_syscall_64 at ffffffff828e06a1
> Fix
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit() check
> in get_kfunc_arg_type() so that an implicit argument that was not
> recognized by is_kfunc_arg_prog_aux() is rejected with -EFAULT instead of
> silently skipped.  The non-bpf_prog_aux implicit arguments handled by
> bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
> percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are explicitly
> allowed.
> All other KF_IMPLICIT_ARGS kfuncs take a struct bpf_prog_aux * argument,
> which is matched by the preceding is_kfunc_arg_prog_aux() check and
> injected through insn_aux_data.arg_prog, so they never reach the new
> rejection path.
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This isn't a bug, but the changelog includes the full crash-utility dump:
kexec and page-fault handling frames #0-#6, raw addresses and a register
dump.

Most of the useful part (the BUG line, RIP bpf_prog_get_assoc_struct_ops+0xa
and RDI holding a stale value) is already quoted a few lines earlier.
Documentation/process/submitting-patches.rst asks for backtraces reduced to
the relevant call chain, without register and stack dumps.

Could the crash dump be cut down to the faulting function and the few
call-chain frames that matter:

  bpf_prog_get_assoc_struct_ops
  <- bpf_kfunc_multi_st_ops_test_1_assoc
  <- bpf_trace_run2

with the kexec/oops frames and register lines dropped, since the RIP and RDI
value are already quoted above?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45121885313
--===============5471762475927380820==--
