Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3214A49BF;
	Wed,  2 Sep 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361119; cv=none; b=dMor4ddl6AdR4er+FasYHW8rJltrBwluicTPuN736WTJWkBVt0jwjXWW4EqXrsVxcyqz1qW6PvAvzNCrBETf34zXp9etZ490TFFGBvmINZUGDcW+a99/Cm92GZAKaI7ag3/zs4LOFun7i7D4qHkAeXq6GCqG4DTqf02uSD2nLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361119; c=relaxed/simple;
	bh=oneO2iXbN7Xf+1E6gIblHvLu6qyv5j8qx0ghPvxyWwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YBNxKl2jOSBz4niOhb1m9Zny+dRxIOtN0ubqSgcv9k/1pniZ6XZKunfnd066QTwz/bV7XLxwvJA4eK2cRcrMb9VIpP83z8aOlf0tRRssjxUQgqxHNdpll5Hu2TT0W6LfM+ticpvhHUJsedOxwbtdmJoY5sYuRnxhKkjG9Re1MFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0FVULeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0FVULeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A671F000E9;
	Wed,  2 Sep 2026 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361113;
	bh=srQXjSuYcY6jiB1RBHtTGlzsOfxGErP7FvzngYpm6Xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0FVULeCbBvmq+igY4f7xsitvK5aYpY4HXg/2TPbbvPVn1226U0JyeWqkWkfMkVz7
	 vAInEZGfUw2mDYafQhkR/J3dSPzg5PI4we4VPkHXUz6L8LHBxJTYTv0ehXjG/u566l
	 tJN4f+Oxyp5jYfRMzgOuC7ohrL8vqPi/xmg+sqpfcmh98dMnk0lWtA9DbyseEGkgZJ
	 juUOPda9bVwGVPmRc9juL2CTCaj5AmHROwOEAcZvbBuETSOsbZ6RhK13Lzknmgvj1x
	 VmpPhioEAEalFn63kys79OU+gqx06vYS81Z4s5M7wNts4M4h01F+yUdvsnM0V1aLJV
	 m0gqUUZHo3rBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] arm: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <cae4a0a79178cf7d1b661c10ee2fa038fc6ebdea.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <cae4a0a79178cf7d1b661c10ee2fa038fc6ebdea.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:58:32 +0000
Message-Id: <20260902145833.47A671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The transition to using `syscall_get_arguments()` for audit loggin=
g causes the first syscall argument to be read from `regs->ARM_ORIG_r0` ins=
tead of `regs->ARM_r0`. This allows tracers to bypass audit logging by spoo=
fing arguments, as the audit subsystem logs the unmodified argument while t=
he kernel executes the modified one.
--

commit 2a794057248ff5b9ad0444e2a1b1392a156db536
Author: Ricardo Robaina <rrobaina@redhat.com>

arm: pass pt_regs to audit_syscall_entry()

This commit updates syscall_trace_enter() on ARM to pass the pt_regs
structure directly to audit_syscall_entry() instead of individual arguments.
The audit logging subsystem now extracts the arguments itself via
syscall_get_arguments().

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ed7a2a87a6707..e103ec2661cd4 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -868,8 +868,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *re=
gs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, scno);
> =20
> -	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
> -			    regs->ARM_r3);
> +	audit_syscall_entry(scno, regs);

[Severity: High]
Does this change allow tracers to bypass audit logging by spoofing syscall
arguments?

By delegating argument extraction to the helper, the first syscall argument
is now extracted via syscall_get_arguments(), which reads from
regs->ARM_ORIG_r0. The previous code directly passed regs->ARM_r0.

If a user-space process intercepts the syscall at PTRACE_SYSCALL_ENTER and
modifies the first argument via PTRACE_POKEUSR to write to regs->ARM_r0,
the audit subsystem will log the unmodified argument from regs->ARM_ORIG_r0.
However, the syscall dispatcher will subsequently reload r0 from
regs->ARM_r0, causing the kernel to execute the modified argument while the
benign one is logged.

Can we ensure the audit subsystem logs the active argument that will
actually be executed?

> =20
>  	return scno;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D3
