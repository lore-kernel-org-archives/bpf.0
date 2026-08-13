Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DF485CF2;
	Thu, 13 Aug 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641547; cv=none; b=oooPoGcWRg7NczzFi8LOBrODklXUce3ku7Uw3giuWBo7nBjMW4OnOC0iAh1HhAGvqA/wvacIB0dB2bqr1Qmmc/4g7QpRKRcIFwbmx2jyJ3VDJ0agd/ME0FilG6AGHhwR1ycYzaQXEodk0dn1arGaWPPZA9Tkyw+VJBg22cXTrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641547; c=relaxed/simple;
	bh=87wUUXftmiYbvJoJ0h5v7iqjwKBjlR4YGQxJLo4meMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVDmnFb5fvlU9vmHnJCIdJI09JcMt3fy/FvfiiAYUW94jrtFhT/auIYAQFhpIzdUY34UendNadUtolXYZXPcTRvJyBu4GE6g5BHNssvhtXV+29mNR9AlEy3LWJqgEEqnUaJbTXqASrKBDSKtPq76srf8QLxv7GckFy454q2ofiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsUgBIWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsUgBIWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770021F000E9;
	Thu, 13 Aug 2026 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641544;
	bh=ifqzkHJ/EUIj/EG8u3ZjABZHquShqZypz/LarWcc2b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dsUgBIWHXaY5kFdzutuVZt+uWI8T0GgEUqdy9EAaml9LnMT7Qiha+UJuyFcUvwjVj
	 PRz1fmnJ7RL6o34U/H+5BA3xSNDnE9xbu3HaGEOfgGdosXxUIp415tj4JlfBtCaq9q
	 Flqck3P1zFmSt+6bwxfy9cNKVnI8KdOAt1/TMCAVpOrFLRi880Ftp+UDE0WmKAuNIn
	 WLuJQd4fW1gllB/0wG7U4tSq66XIR3x6GHUccWZyNm60V/fTP62CCVp3VqIrvLZilv
	 6Nu+B/oRFyuC7YsuVZ/xuODjn4SXuvHe7QzclcVYhOBPphKdRf/TvTJoG+405SX4lx
	 D5cxbdU19POMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] um: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <c4118be04a7247aca96de49950dd5d866aa352b8.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <c4118be04a7247aca96de49950dd5d866aa352b8.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:19:04 +0000
Message-Id: <20260813171904.770021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch series changes the signature of `audit_syscall_entry()` g=
lobally but splits caller updates into separate commits and completely miss=
es updating the PowerPC and Xtensa architectures, causing a tree-wide build=
 failure.
--

--- Patch [12]: [PATCH 12/13] um: pass all six syscall args to audit_syscal=
l_entry() ---
commit 9c50f8d1e9a5a601156f9a077df794dd83a368a0
Author: Ricardo Robaina <rrobaina@redhat.com>

um: pass all six syscall args to audit_syscall_entry()

This commit updates the syscall_trace_enter function in the UML architecture
to pass the 5th and 6th syscall arguments to audit_syscall_entry. This alig=
ns
with the new audit core API which logs all six arguments.

> diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
> --- a/arch/um/kernel/ptrace.c
> +++ b/arch/um/kernel/ptrace.c
[ ... ]
> @@ -127,7 +127,9 @@ int syscall_trace_enter(struct pt_regs *regs)
>  			    UPT_SYSCALL_ARG1(&regs->regs),
>  			    UPT_SYSCALL_ARG2(&regs->regs),
>  			    UPT_SYSCALL_ARG3(&regs->regs),
> -			    UPT_SYSCALL_ARG4(&regs->regs));
> +			    UPT_SYSCALL_ARG4(&regs->regs),
> +			    UPT_SYSCALL_ARG5(&regs->regs),
> +			    UPT_SYSCALL_ARG6(&regs->regs));

[Severity: Low]
Does splitting the caller updates into separate commits from the core API
change break bisection for architectures not using the generic entry code?

If the core API was changed in a previous commit, building this intermediate
commit during git bisect will fail since architectures not yet updated will
have callers expecting the old signature.

Additionally, were the PowerPC and Xtensa architectures missed entirely in
this series? For example, do_syscall_trace_enter() in
arch/powerpc/kernel/ptrace/ptrace.c still passes 5 arguments instead of the
required 7:

		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
				    regs->gpr[5], regs->gpr[6]);

A similar issue occurs in do_syscall_trace_enter() in
arch/xtensa/kernel/ptrace.c. Will this cause an unconditional build failure
for these architectures when compiled with CONFIG_AUDITSYSCALL=3Dy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D12
