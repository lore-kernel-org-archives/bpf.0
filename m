Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC7359A91
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661247; cv=none; b=T9AAgRsRM+rjHrepRAZe97ySslF4XfaAQUzUEb4EspU6GFMmfKZbBbGAE7ZzCJKMzC9LjKCueIFKvBfRQHbGTLQ4D5LAHdWSyX5/Xu8lcdJIVjuppe08RW6RvtjsfkY53frvUHaFN6Rv81Zez76dGbZ3rxQkEVIArNXfyAVho00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661247; c=relaxed/simple;
	bh=vD2ihCB3IXJIBefEbaymWsOxu1Q/Ry1ZC0VVdwEYEWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FhEa98LyZvY5/h3vJlmZTfGMComxPYQLBZ5oZZNE/jdPzx7eMKzEzGvHKEOwUmMI2Eq/rN1g/qr7TkON6YY/tXKlXx74pyasv8GinZHdl92/1xYTb56QlW+tu3Y7XxoPWljMs5uZd0MdUhv6swtQymZ3cr5Bpt+6jjzc/aQ+yIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjaaYJrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjaaYJrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C101F000E9;
	Thu, 13 Aug 2026 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786661245;
	bh=V8Xdg6EzrhrCSmrmwmGGHq3AHO78IpuratX1SUg6M9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LjaaYJrJLYR0JpQlegEUHSth6sq7116FswiCPizGv+Fr0ap8SacAqd6WGDvb3KBWj
	 d1W43EcKIdFAdG4ni5zSqh/CMS2sGhbehi2OIogRnKaqdyC8q23wSkD5wWNCQogLAM
	 i85PC6/SRnADX5RbJGyMTlvuFAgN3TB3dr4/LhOeynLn6ZjLRBHzM6qEDqyX4VO3Kd
	 3FACXrr97ZW6Hz1/KzIF4voxMaQzbXsQE0UeMsYR4gRbcHXAgmD3iWwxam1H+h8aaw
	 tlhb3Mwqg38wiO0UHapMoR4KmHdUcDPXXvNmrXdNBtmFicfTBtx6CFiSUfj5UaDQRf
	 s/NHDEjnNTs/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260324-sleepable_tracepoints-v6-4-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-4-81bab3a43f25@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:47:24 +0000
Message-Id: <20260813224725.71C101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Sleepable BPF_PROG_TYPE_RAW_TRACEPOINT programs cause a 'schedulin=
g while atomic' kernel panic when executed via BPF_PROG_TEST_RUN.
--

--- Patch [4]: [PATCH bpf-next v6 4/6] bpf: Verifier support for sleepable =
tracepoint programs ---
commit 0adc028b1ba3ebb449f79abbe66b1d15d4ba5578
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Verifier support for sleepable tracepoint programs

This commit allows BPF_PROG_TYPE_RAW_TRACEPOINT, BPF_PROG_TYPE_TRACEPOINT, =
and
BPF_TRACE_RAW_TP programs to be sleepable. It also adds checks to ensure
these sleepable programs are only attached to faultable tracepoints.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268deb..a4836f564cb12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -25478,7 +25485,9 @@ static bool can_be_sleepable(struct bpf_prog *pro=
g)
>  	}
>  	return prog->type =3D=3D BPF_PROG_TYPE_LSM ||
>  	       prog->type =3D=3D BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
> -	       prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS;
> +	       prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS ||
> +	       prog->type =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT ||
> +	       prog->type =3D=3D BPF_PROG_TYPE_TRACEPOINT;
>  }

[Severity: High]
Can this change introduce a 'scheduling while atomic' kernel panic when a
sleepable BPF_PROG_TYPE_RAW_TRACEPOINT program is executed via
BPF_PROG_TEST_RUN?

Looking at net/bpf/test_run.c, bpf_prog_test_run_raw_tp() disables preempti=
on
via get_cpu() or smp_call_function_single() before running the program:

net/bpf/test_run.c:bpf_prog_test_run_raw_tp() {
	current_cpu =3D get_cpu();
	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) =3D=3D 0 ||
	    cpu =3D=3D current_cpu) {
		__bpf_prog_test_run_raw_tp(&info);
	} else if (cpu >=3D nr_cpu_ids || !cpu_online(cpu)) {
		err =3D -ENXIO;
	} else {
		err =3D smp_call_function_single(cpu, __bpf_prog_test_run_raw_tp,
					       &info, 1);
	}
	put_cpu();
}

And __bpf_prog_test_run_raw_tp() then executes the program under
rcu_read_lock():

net/bpf/test_run.c:__bpf_prog_test_run_raw_tp() {
	rcu_read_lock();
	info->retval =3D bpf_prog_run(info->prog, info->ctx);
	rcu_read_unlock();
}

If a user with CAP_BPF loads a sleepable raw tracepoint program and execute=
s it
via the BPF_PROG_TEST_RUN syscall, wouldn't invoking sleepable helpers in t=
his
context trigger a 'BUG: scheduling while atomic' panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324-sleepable_=
tracepoints-v6-0-81bab3a43f25@meta.com?part=3D4
