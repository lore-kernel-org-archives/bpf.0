Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EF4ADD91;
	Thu, 13 Aug 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642011; cv=none; b=mKG+izfhU4/46Ot66PUT0bKpVaPekjXXVRQUg0TxSjyx0zQa+f4zLWmZlW3KP1rXyuOpavyeKWK3eu1DmHQqg1JnX47WAQbQZC30RW+zFQNQwyH2YkE0mC265/UlYls/YVRWV+m61b2gAfqU7HWve/SQ2iSLTu79nELpzkg75Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642011; c=relaxed/simple;
	bh=IFnZi3g8BMI0vxyWIK2VtTAeelD3MMtSt71w8dZGZp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k662hgpcu5AYo2VNqUGJvJvgI53kP7R7yF+amByv1PRsSPEIu2rmte92O1+Ew/ylLHqhsH7+O4iYinqH6Gh+KU5/YUAJoJ6jJhGrwN5UOUnVGl9GurXlODogAc7NAfzfJtE/KfGaxjPIsij9+GKg0FiS/F5CLe64XSNxW8FAkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AosNgLk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AosNgLk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476F1F00A3A;
	Thu, 13 Aug 2026 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642006;
	bh=haMCmZyb05K8mwuVv41pjeqoLQGPRwynnCkuEihX5yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AosNgLk76jpjvZ8DCWBbiBPXvFPc/wGBpunJdwRYUCpnU6ZSO4GA5qA7/MdERIwEz
	 OybX4uPQf5wRhLvlFnH8/NMJIUNu0SSkOKSm46MynsKW+Du3ohf4jeKJRN4SBPvKVB
	 ZJ9Oudiv+Z2Gnrt/Rd4bQvjAPl6VIgpqUokuGtUW8zA7WdLG9hHLzJAfKesRgZBvbr
	 XfT/qQGyag8n+m8ajHv0f2WhQn6mZDhi1ISfkEw0BFBtISEnPIMu5J503fVAAngc9f
	 YNJTYWbb+LhzhA6ovFWG+6ViF49nBaMAZ3n8Gi+axThGwOL9/Ig1TanTBY85rUf/1F
	 e/j4rwj12quuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] sparc64: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <fc2810a850a8bf343b7ad7ae9caf3da57e1f41ec.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <fc2810a850a8bf343b7ad7ae9caf3da57e1f41ec.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:26:45 +0000
Message-Id: <20260813172646.1476F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit compat syscall arguments are not zero-extended before being=
 passed to audit_syscall_entry(), leading to a high-severity audit evasion =
vulnerability for socketcall multiplexed syscalls.
--

--- Patch [11]: [PATCH 11/13] sparc64: pass all six syscall args to audit_s=
yscall_entry() ---
commit 5c60aff4dd1af29adf66c85f200b0a80fe2238fb
Author: Ricardo Robaina <rrobaina@redhat.com>

sparc64: pass all six syscall args to audit_syscall_entry()

This commit updates syscall_trace_enter() to forward the 5th and 6th syscall
arguments (UREG_I4, UREG_I5) to audit_syscall_entry(). This change ensures
all six arguments are passed, aligning with the audit core's expectations.

> diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
> index 9fc67fa9336fe..d0ad3200d789c 100644
> --- a/arch/sparc/kernel/ptrace_64.c
> +++ b/arch/sparc/kernel/ptrace_64.c
> @@ -1100,7 +1100,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *=
regs)
> =20
>  	audit_syscall_entry(regs->u_regs[UREG_G1], regs->u_regs[UREG_I0],
>  			    regs->u_regs[UREG_I1], regs->u_regs[UREG_I2],
> -			    regs->u_regs[UREG_I3]);
> +			    regs->u_regs[UREG_I3], regs->u_regs[UREG_I4],
> +			    regs->u_regs[UREG_I5]);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a 32-bit
compat process to evade audit rules because these arguments are not
zero-extended?

For a 32-bit process executing a multiplexed system call like socketcall,
an attacker could intentionally leave non-zero garbage in the upper 32 bits=
 of
the registers.=20

Because syscall_trace_enter() passes the raw 64-bit values directly from
regs->u_regs without zero-extending them, the audit subsystem stores the fu=
ll
64-bit value. When the audit core later evaluates rules (e.g., checking
ctx->argv[0] =3D=3D SYS_BIND), the comparison fails due to the upper 32-bit
garbage, bypassing the rule.

Since the SPARC64 assembly later zero-extends the arguments before invoking=
 the
actual compat syscall handler, the syscall succeeds without being properly
audited.

Could we zero-extend these register values for 32-bit compat tasks before
passing them to audit_syscall_entry() to prevent this bypass?

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D11
