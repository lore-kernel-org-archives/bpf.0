Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF658259CB9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914569; cv=none; b=aeunzQeb6ZBiykMU7FWd/106Iw4JD63YeP3aPPoPJkFqIGp4hDAk3rkcfUA69eYEiRZvVd/YPF5RsPsL0/pwVF4nj/Vt8BjjoorDvzR4+D05/7jiqKh0zvA4VnOajynJx3TnpQWdZbVaHvvyg1+0KP2yFGiS4MhFjY5+w0iFfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914569; c=relaxed/simple;
	bh=J5Re0LiF9cij2rcrq9hryp+Qxw50gk/9yg4EquyWgnk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hjMMWJDLsXNc+O0WksbpfI+om3HkmPVJLO2i/11XlUqJoQzDFRtmljhzhxqj4lbH1FxvR3tcomzuJ7aNrSHjerGSY5KChzlNLcbYSxrMa0OAtIrf5fNwla9zZd22UGJgE1ZLJ5IwNYfNM+4L2vl73p0u8CjHG0N9Y1c0UscTcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwaH7LBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwaH7LBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB4A1F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914568;
	bh=TF07GjuT8e/LwPn9WZEwlI9YhgFdqva56PlHvTZBcQc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SwaH7LBk6O/j65BRkxWJVjr1bsHGncsc3eve7GdCGlOLpARLKTlEZwqwJ6RVI+c7R
	 NUsAe2Cd7EohjVNhn9mvflNdTTDY5XVnaxBHOIHj9jrz/byTOTmD/AcNFyosyOlYTo
	 FgWla/RSkRltE0oc1KFCT4HWDPDpSk+Ap7CAELyeAlW37fhajJ3lSra0D4+tOvcgvS
	 fob1xuAOFg/0COLN/EyTzJrD8455//MMg7Pc+4EhMMzTFnigFKES6jL+WEmPyCd4+e
	 KJuJckAb+CRXGHkgMYQHRGkXomsezDhhcHLo2+KmUgPr670hC06swGgqvzzSJba27M
	 C/X3TNeeU4vqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] tracing: Add disable_bpf trace option to ignore
 eBPF for fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <178291355107.1566898.16400808380207816368.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291355107.1566898.16400808380207816368.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:02:47 +0000
Message-Id: <20260701140248.5EB4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The `disable_bpf` trace option is improperly exposed to instance=
 directories and non-BPF builds, creating a dead configuration knob that si=
lently ignores user input.

Pre-existing issues:
- [High] The `IS_ERR()` check on the return value of `bpf_prog_select_runti=
me()` is broken, leading to a silent failure and an uninitialized memory le=
ak to user-space.
- [High] An early `BPF_EXIT_INSN()` generated for memory fetch failures abo=
rts the entire probe fetch program, leaking uninitialized memory for all su=
bsequent arguments.
--

commit 87050ba78ea1f240fee455c53d7eb225ed51e533
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: Add disable_bpf trace option to ignore eBPF for fetchargs
   =20
Add a trace option "disable_bpf" to disable BPF execution for fetchargs,
forcing the execution to fallback to the interpreter loop. This is useful
for evaluating BPF compilation performance impact.

> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 80fe152af1dd8..bf83680e0ba70 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1503,6 +1503,7 @@ extern int trace_get_user(struct trace_parser *pars=
er, const char __user *ubuf,
>  		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
>  		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
>  		C(BITMASK_LIST,		"bitmask-list"),	\
> +		C(DISABLE_BPF,		"disable_bpf"),		\

[Severity: Medium]
Does this option need an #ifdef CONFIG_BPF_SYSCALL wrapper? It appears this
unconditionally adds the flag, making it visible even on kernels built with=
out
BPF support.

Additionally, since trace_probe_bpf_disabled() strictly checks
global_trace.trace_flags, toggling this option inside a local trace instance
directory won't have any effect. Should this be added to
TOP_LEVEL_TRACE_FLAGS in kernel/trace/trace.c to restrict it to the global
instance?

>  		FUNCTION_FLAGS					\
>  		FGRAPH_FLAGS					\
>  		STACK_FLAGS					\

[ ... ]


This isn't a bug introduced by this patch, but I noticed a couple of proble=
ms
in the previous patch of this series in kernel/trace/trace_probe.c.

[Severity: High]
This is a pre-existing issue, but in trace_probe_compile_bpf(),
bpf_prog_select_runtime() returns errors via its err pointer argument and
always returns a valid program pointer (or the original one), not an ERR_PT=
R:

    prog =3D bpf_prog_select_runtime(prog, &err);
    if (IS_ERR(prog))
        goto out;

Because IS_ERR(prog) is always false, won't this silently attach a dummy
program (__bpf_prog_ret0_warn) to the trace probe on JIT failure? This dummy
program immediately returns 0 without fetching arguments. Since
trace_event_buffer_reserve() doesn't zero-initialize the raw ring buffer sp=
ace,
does this result in leaking uninitialized memory to user-space?


[Severity: High]
This isn't a bug introduced by this patch, but also in
trace_probe_compile_bpf(), when compiling memory fetch instructions:

    insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
    insns[i++] =3D BPF_EXIT_INSN();

If copy_from_kernel_nofault() returns a negative error (e.g., from an inval=
id
pointer), doesn't this early exit terminate the entire BPF fetch program? S=
ince
it stops processing any subsequent arguments, and trace_event_buffer_reserv=
e()
doesn't zero-initialize the buffer, could this leak stale kernel ring buffer
memory to user space for all subsequent un-fetched arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178291352217.156689=
8.14481561093843379745.stgit@devnote2?part=3D3
