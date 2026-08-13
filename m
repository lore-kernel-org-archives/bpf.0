Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5594ADD8D;
	Thu, 13 Aug 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641661; cv=none; b=NVS7ipCDA0EXDVLSjLyz23TGvBFUPRIyPCZg6KvUGy6wn6rYGuahTPhJdymCgTzcFx8/TSu5mNGI0hEDaYwzuV4yhbe4YZ1i3+saiNXdNoRUgEzymbMqnP+binNv/kvn0VVeudJfIvnkeZAPDLJzJsHhJI1UhKmBMj5MgZJ9pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641661; c=relaxed/simple;
	bh=+rNPzFCtvy0QTn2OIrQRcW0IPld72hZc/rYjes1jUIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tSzlsxzKpbWwsp1eT+2n9Rp3wJTUfT2o/IbbkjRlNLs3I/5GGHHu11DOiubNA7xNuzItKvOXUuL85Q3kG0Zvl1WP3khh3RXevGc7rr1CLccatBi7jQikYLnpgqdF02MQG7pivTlqbSKIbvfQBZ+pj7K+Hv8EU6IkfvQ+WZkPilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaqTliV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaqTliV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BC1F00A3A;
	Thu, 13 Aug 2026 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641657;
	bh=FBC9AyJT8d6DENUBqbnfjRiibVpAOo+YbnSxmFvFwUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FaqTliV655Ucs3H1E4deKfq21/+lfptdSleuc8aaqFUZSJ0fpR0rgRlSRvYkiS5fA
	 RkEB5MGbpMLIxpdo7rr+d4QuYifN559oFFcFDmqDJ/HYf6w4bvcYqwxPl9LRdGp85d
	 RxkTCrJ6s5j50yOfG4mUPlx0CRcBOzrkqbUVQyjOc80tJxpUtKI7Pg0GpZgL89+wHv
	 qPUykZWYBIsO7n8awlXQDaqNxic2Xt/JYcuEwldCyO29qy8i9jDUPaHmAVxcf4sd6y
	 ICgVEL+TkdEe4+65LkUqksQIRgUab9L8dNvY8oElglGwFVkfI5vojZH2hPi+cmR0Qf
	 Qzd3efDl5XZ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] arm: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <4f787a0c2a27eb919c481875b61a7467ef8ce547.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <4f787a0c2a27eb919c481875b61a7467ef8ce547.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:20:57 +0000
Message-Id: <20260813172057.A97BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch series changes the signature of `audit_syscall_entry()` =
globally but fails to update numerous architectures, breaking their builds.

Pre-existing issues:
- [High] A tracer can bypass seccomp filters on ARM by modifying `ARM_r0` v=
ia ptrace, as seccomp incorrectly evaluates the unmodified `ARM_ORIG_r0`.
--

--- Patch [3]: [PATCH 03/13] arm: pass all six syscall args to audit_syscal=
l_entry() ---
commit 5e37711667e9af11aeb7334ef9ee7ed66cadd89d
Author: Ricardo Robaina <rrobaina@redhat.com>

arm: pass all six syscall args to audit_syscall_entry()
   =20
Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (ARM_r4, ARM_r5) now that the audit core logs
all six.

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 7951b2c06fec6..ace74207738d0 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -869,7 +869,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *re=
gs)

[Severity: High]
This is a pre-existing issue, but can a tracer bypass seccomp filters here?

The ptrace intercept occurs before seccomp:

arch/arm/kernel/ptrace.c:syscall_trace_enter() {
    ...
    if (test_thread_flag(TIF_SYSCALL_TRACE))
        report_syscall(regs, PTRACE_SYSCALL_ENTER);

#ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
    if (secure_computing() =3D=3D -1)
        return -1;
    ...
}

If the tracer modifies the tracee's first syscall argument (ARM_r0) via
ptrace, does seccomp evaluate the unmodified ARM_ORIG_r0 instead?

arch/arm/include/asm/syscall.h:syscall_get_arguments() {
    ...
    args[0] =3D regs->ARM_ORIG_r0;
    ...
}

Could this allow restricted system calls to be executed with arbitrary first
arguments?

>  		trace_sys_enter(regs, scno);
> =20
>  	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
> -			    regs->ARM_r3);
> +			    regs->ARM_r3, regs->ARM_r4, regs->ARM_r5);

[Severity: High]
Does this patch series break the build for other architectures?

The series changes the signature of audit_syscall_entry() globally to requi=
re
7 arguments instead of 5:

include/linux/audit.h:
static inline void audit_syscall_entry(int major, unsigned long a0,
                                       unsigned long a1, unsigned long a2,
                                       unsigned long a3, unsigned long a4,
                                       unsigned long a5)

Are other architectures like arm64 still calling it with 5 arguments?

arch/arm64/kernel/ptrace.c:syscall_trace_enter() {
    ...
    audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
                        regs->regs[2], regs->regs[3]);
    ...
}

Will this result in too few arguments to function compiler errors for
architectures that do not use generic entry?

> =20
>  	return scno;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D3
