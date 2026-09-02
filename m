Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF64A8430;
	Wed,  2 Sep 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361083; cv=none; b=ObHFtXNxSWITCC5VZz4GuTLoi0MOEjvxkhafoAQkTYYnJZ5ElaAa1dNq1eUg+X8j94R3VHCYKjFGQtY40O5zlSybi8OSmVLjMx7mIRQDy7DF5BUYIzw7hQoSsGXHcPKL3RurnM9JfetTgg+cCM0s6l8331ggzhMBqvE0yf7d8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361083; c=relaxed/simple;
	bh=X+IIwzfTzHtNg2oU7EAvFtxWsxtbKE6lQHBVjis5M9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pjBhgFjU4EXVdGjjjU0o+g0tUdgK/j5K9ymqcL7gve4W+4czEsn1C/YN0PNSDsnyX3M95R5+4i1zXzm8G69QiD0DPIIsCNoe2ip6dWMpE+/FQaClByU5ECmD2hzUB/oqOCS2pm2eHmnGJYhQmBKLRiuGPRPXijw8S9buYs0J/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGGTWrWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGGTWrWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E51F000E9;
	Wed,  2 Sep 2026 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361081;
	bh=uk62KPgbiXhasU8jQen+kLP55W7U/siJFn8xDmIK1b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OGGTWrWCCs7vu0VnnMYq/vfCpKZsHFMzwPmqDxFWFqJOAtVwsoqvCYEbBrOUZ4xMg
	 zrp3rQwyVTMbQki3BMx1p+I0AUiKKbnyg45ArtDjHmbN2z80P/lAJBsiAsgkKpz0Eb
	 nj/XRzuMuTJxVZrJnB9CFPKeJwOp0yU2foy4iAaCUDvp0Y5gRTX1I2EGB6HvSoOxuB
	 8zpWIev+IzvfSktUOdRx7DmHv6CHupSQehLl83DAvn7lWkPy0syYW4k8yrRWCjNEHR
	 Biic+/mEQOiBChlc+zREI/HKsRnPawV7zuoPKE7SiOCdy0b79Yls4ZsneJ8XQglnnW
	 RnaU9C2YVpB1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] sh: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <097bd384731da18be54fafd41f67c60e2a70e37e.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <097bd384731da18be54fafd41f67c60e2a70e37e.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:58:01 +0000
Message-Id: <20260902145801.AE8E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Syscall spoofing vulnerability: trace_sys_enter() logs the use=
r-controlled 5th argument instead of the true syscall ID.
--

commit 54980eef37cc5d7ecba9111c6a7139474010c424
Author: Ricardo Robaina <rrobaina@redhat.com>

sh: pass pt_regs to audit_syscall_entry()

audit_syscall_entry() now takes a pointer to pt_regs and extracts the sysca=
ll
arguments itself via syscall_get_arguments(). This commit drops the individ=
ual
argument registers from the call and passes regs instead.

> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 8794081483fbd..e138f529ee7ec 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -466,8 +466,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs=
 *regs)
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>  		trace_sys_enter(regs, regs->regs[0]);

[Severity: Critical]
This isn't a bug introduced by this patch, but it appears there is a
critical pre-existing issue here in do_syscall_trace_enter().

Could trace_sys_enter() be logging the wrong syscall ID?

On SH32, the actual syscall number is in regs->regs[3], while regs->regs[0]
contains the 5th argument, which is a user-controlled value.

Because do_syscall_trace_enter() passes regs->regs[0] to trace_sys_enter(),=
 a
user-space application might be able to invoke a malicious syscall (like
execve) while populating the 5th argument register with a benign syscall ID.

Does this mismatch allow attackers to execute one syscall while security
monitors log another, potentially bypassing eBPF and ftrace monitors?

> -	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
> -			    regs->regs[6], regs->regs[7]);
> +	audit_syscall_entry(regs->regs[3], regs);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D10
