Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5948A8D3
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108048; cv=none; b=F2kuyvJugmMtffb2gdMjCDKo3NAGtz2Y59MGTaqjya4a5d/Z9mX7wSpDcEZ+Fg7sgXN39flM6hrmVw5qVWW+oFzCrCc2y4ufVvCdvlXsN8AG3xJi0PUPGbCebubw2krdG61C0kTH3WVqgWAiw4RD08Hhyd7YfaE3AVv5VTXvxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108048; c=relaxed/simple;
	bh=Bqkmn4aCSE2wRtBr9XJRJWfaJx/nJB68P+OhRW6iSMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hC4UyQhi15b0Men4g77s0JfRgOcmLTuET8YdfpNFK+17tJmpuUrZ2+GUYojggnDn5psVZqVpXgB/yqF0Xu7NSv/9e6XgYztsY1o8RNRMo1ch+lXVoHQKi1O0/JZ/MOOYo8W6gtMTQNQSWs5nsRI5cLvecH3/ZUIawBqwgyN/MoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDusRyik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDusRyik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFE51F000E9;
	Fri,  7 Aug 2026 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108041;
	bh=kdP0Kcs8+qiQu00y+JcByKsd8A1eSUkpqnj9wNIRBTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDusRyikyPsaprDLKyTJoUWbt6qOXvURMyR0nbcmwIp0emqHGj3I6vmdTcgkhe5FF
	 KG71iipaOYRy2gffMNXNKC1DMYUbotKc1UJ/DiTLBAAx5LxgpzIrNxUrbOGvU5n18v
	 HSCMfGvzciDSixlYOnQqx7F+JVCfHombkcRJ6gkPnsg3Cv6BP8EVaQRa42z/xDxg7Z
	 f3Q+DXupzGgo11bIbvUQCZjinN7twyIWF4GrlzvZalWp+4NfI3A98WMxTEH8DTguiZ
	 BKyLbSsT4yFJOcoxbEC0GYizuYGE/xkAyyMCPfVtKatAT/nrtdbJVJnB6Iskyvk74J
	 jPUo8H2Vw4YmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y v2] selftests/bpf: Add tests for sleepable
 tracepoint programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>
References: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:07:20 +0000
Message-Id: <20260807130721.8DFE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Test codifies a critical kernel crash bug due to incomplete ba=
ckport of sleepable tracepoint support
--

--- Patch [1]: [PATCH 7.1.y v2] selftests/bpf: Add tests for sleepable trac=
epoint programs ---
commit d01560ee1bdaeec333977b1890fc06598668aa9f
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add tests for sleepable tracepoint programs

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd.

Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-9900=
5dff21ef@meta.com

> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/tes=
ting/selftests/bpf/verifier/sleepable.c
> index c2b7f5ebf168c..6dabc55229455 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,20 @@
>  	.runs =3D -1,
>  },
>  {
> -	"sleepable raw tracepoint reject",
> +	"sleepable raw tracepoint accept",
> +	.insns =3D {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type =3D BPF_PROG_TYPE_TRACING,
> +	.expected_attach_type =3D BPF_TRACE_RAW_TP,
> +	.kfunc =3D "sys_enter",
> +	.result =3D ACCEPT,
> +	.flags =3D BPF_F_SLEEPABLE,
> +	.runs =3D -1,
> +},

[Severity: Critical]
This is a pre-existing issue, but does this test codify a kernel crash bug
in the baseline tree?

The commit message notes that kernel-side sleepable tracepoint runtime supp=
ort
was not backported here. Because of an earlier backport, the verifier
currently accepts sleepable raw tracepoints if tracepoint_is_faultable() is
true (like sys_enter), which makes this verifier test pass.

However, without the runtime support, the execution happens unconditionally
under atomic contexts. For example, in __bpf_trace_run():

kernel/trace/bpf_trace.c:__bpf_trace_run() {
    ...
    rcu_read_lock_dont_migrate();
    ...
}

Or via the tracepoint wrapper:

include/trace/bpf_probe.h:__BPF_DECLARE_TRACE_SYSCALL() {
    ...
    preempt_disable_notrace();
    ...
}

If a sleepable program is attached to this tracepoint and actually sleeps, =
it
will trigger a scheduling while atomic panic.

Should this test be removed or adjusted until the runtime support is fully
backported to prevent asserting this unsafe verifier state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-selftests-=
bpf-sleepable-v2-1-f7e6566f36a1@marliere.net?part=3D1
