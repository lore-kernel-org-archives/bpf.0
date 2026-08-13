Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2828315D;
	Thu, 13 Aug 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641646; cv=none; b=Cy8LAeC+R/w76JX78DuhNXjL4E+LuV2iGIBT+MRMwWTFMcUNa9bs8oJ/PBfWs1+GN8xUlE7PLta+/8bXJd2J8Hpnasb2gVO5hH9C8tveZJbmSw98FCmbV2vFC2aW1EYJEo2hYhR7VE2tUqLIP0BOe48aMfEfB/oLrVN4PHsJX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641646; c=relaxed/simple;
	bh=ma69b+aEaUj7BVaPkjMa/qMGfwITL3yFjvbQfoaGWiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qeq5q6UKqmRSTTM84Ltmvvo1qyUzfTVVhpuloGbT3g4tiGOvee0AEaaanRWCL5h+d6fkfKV+E3t/WtPKKl2QxLVyZYjFCoAPk31M+KZrrKURvxP/zog48gvKg8y5PXCW2rhqNfhcPkfR3JmBSckjV2bKTfpAevSQ1PsnXUlrYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOX9fWAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOX9fWAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A671F00A3A;
	Thu, 13 Aug 2026 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641643;
	bh=uAO+Z6qTUsCJ5uWbICTxHhcSMnCFo3BAVpLsSvcXSsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOX9fWAvcQbk2hVlJsmgKijEuNOOzkYWc77ZeMpe3nkSbHWUkRuLOfhsA1znSSIb6
	 8XQUXfTz4O5yK0KQEMxfDzZEuFSaNiAQc4pN2QCSGTVRYZRaJLe1KRTywsN/bqtRta
	 N05mf5KA4dLjfhjsE6X+lZMwU8tk7GHbnNiwyWqb7bjgVV1Hv1RgFsVUE2RF/hHCbD
	 s6Xpecjs+08HZQhCEHozcMtlduK2TSHlyWEkDMiVmsP3WP0ueBTsSYHzL0eDlwZKhj
	 NNPiz6Ykt0KqzLUA2gGJRzshrwgu91lnFtcnrlrq15z2m9SA+N+73q2FHjWITCIFPa
	 jASji1wTWXxTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] openrisc: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <1616198d0cfa9434b36fc1ac6055064ae8c08057.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <1616198d0cfa9434b36fc1ac6055064ae8c08057.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:20:42 +0000
Message-Id: <20260813172043.37A671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch series breaks git bisectability by changing a core functi=
on signature before updating all architecture callers.

Pre-existing issues:
- [High] The return value of `do_syscall_trace_enter()` is ignored, breakin=
g ptrace syscall abortion (e.g., PTRACE_SYSEMU).
--

--- Patch [8]: [PATCH 08/13] openrisc: pass all six syscall args to audit_s=
yscall_entry() ---
commit 9ca4bd79e1e00767e994486accfe2484de6f3a04
Author: Ricardo Robaina <rrobaina@redhat.com>

openrisc: pass all six syscall args to audit_syscall_entry()

Update the audit_syscall_entry() call to forward the 5th and 6th syscall
arguments (gpr[7], gpr[8]) now that the audit core logs all six.

> diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
> index 552489b24855c..197a616d6c65c 100644
> --- a/arch/openrisc/kernel/ptrace.c
> +++ b/arch/openrisc/kernel/ptrace.c
> @@ -302,7 +302,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs=
 *regs)
>  		ret =3D -1L;
> =20
>  	audit_syscall_entry(regs->gpr[11], regs->gpr[3], regs->gpr[4],
> -			    regs->gpr[5], regs->gpr[6]);
> +			    regs->gpr[5], regs->gpr[6],
> +			    regs->gpr[7], regs->gpr[8]);

[Severity: Low]
Will this change cause a git bisectability regression if architecture
callers are updated in subsequent commits?

If the core function signature of audit_syscall_entry() was changed in a
previous commit, intermediate commits checked out between the core change
and this architecture update will fail to compile on OpenRISC with a
"too few arguments to function" error.

> =20
>  	return ret ? : regs->gpr[11];
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is the return value ignored
by the assembly caller, potentially breaking ptrace syscall abortion?

If tracing decides a syscall should not happen (e.g., via PTRACE_SYSEMU)
and ptrace_report_syscall_entry() returns non-zero, this function attempts
to abort the syscall by returning -1L in r11.

However, the caller in arch/openrisc/kernel/entry.S unconditionally
reloads the original syscall number into r11, discarding the return value:

arch/openrisc/kernel/entry.S:_syscall_trace_enter()
    ...
    l.jal   do_syscall_trace_enter
     l.addi r3,r1,0

    /* Restore arguments ... */
    l.lwz   r11,PT_GPR11(r1)
    ...

Can this allow the original syscall to execute regardless of the tracer's
abort request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D8
