Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4B49E5C3;
	Tue, 22 Sep 2026 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105956; cv=none; b=Gi5HoJG78GIqg/XwR8sH8V0JJW9NE3I1pxBRbqtwFoCe+2IaYnpwL/9fsFLTqOWLfRrIaDzheV14p1yC1Ss1QjNpxjsuG+xh4N6e4L5xDOjIeXImsasZnV4ooBdfrB3+0QF3rGmYP6KcsDhUoSiXRAiT1H+3sIY7BVZmpiNsZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105956; c=relaxed/simple;
	bh=ZxQDDbM9rx752MoiKsSLhZ1SJZNCLWjj95KYAxf5rp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OuIFXA5B1Ea4PSnb1r15C9YIgwqkLwXNWSGF6Msa3rmxud/jyJf2o74ANj/GixiEjgd7O6YYt1u0gsnBGip3IRMeyS6BibgwA6Tg/HaL4wgF3lAJ69NuEih/a8eIUmogUhw72QWG7XqjbocFcWBmPxBhAWe4Y+1xorNZpQoshK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMDCDV7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMDCDV7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2931F00893;
	Tue, 22 Sep 2026 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105954;
	bh=oNZF0Not5P8zTa9qXtvA8nL+DkAMiRVOqd5+yyGEY1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMDCDV7VzQFDg3+X3Osl+dgUyorBXfqFefH/xZMGDLpCY56pRrZWc4DancARUB9jn
	 ObyN2G7WLaeFicvLoi1l9xwbt80IRibgykPr9nP88zOtQioKvUlOPyOQppP8snDVQk
	 jWjpMpzIDtTmeWCTQXfDTWvOvmIKSU5v03YJ9piWnz7EWLHZCCDLtKcvDClkmhhcXf
	 Y27i+8HKzoQ3pujrl7gVLwnuYjfXtFby+sSUz+hqsNAlE0xxnIR7JRh1mFXDbGZ7VT
	 CUCpsW08LDQs+LAeapqFd5Ag3BxSKDx2W8V5pQIT645P3H4e/l9TQMwmMidOHR1a48
	 2EZxZJif0QIAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] arm: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <619ddff49b82e8e494c96dc749c8c5114d6df07f.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <619ddff49b82e8e494c96dc749c8c5114d6df07f.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:39:14 +0000
Message-Id: <20260922193914.8B2931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm/audit: audit bypass via ptrace syscall argument spoofing
--

commit 28f5bb87ea29cfbc21629b2a96c32dff55652268
Author: Ricardo Robaina <rrobaina@redhat.com>

arm: pass pt_regs to audit_syscall_entry()

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ed7a2a87a6707..3c5d7fd733ec1 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -868,8 +868,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *re=
gs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, scno);
> =20
> -	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
> -			    regs->ARM_r3);
> +	audit_syscall_entry_regs(scno, regs);

[Severity: High]
Does this change introduce an audit bypass via ptrace syscall argument spoo=
fing?

By switching to audit_syscall_entry_regs(), argument extraction is now
delegated to syscall_get_arguments(), which reads the first syscall argument
from regs->ARM_ORIG_r0:

arch/arm/include/asm/syscall.h:syscall_get_arguments() {
    ...
    args[0] =3D regs->ARM_ORIG_r0;
    ...
}

If a tracer intercepts execution using PTRACE_SYSCALL_ENTER and modifies
the first syscall argument via PTRACE_POKEUSER on ARM_r0, regs->ARM_r0 gets
updated but regs->ARM_ORIG_r0 remains unchanged.

Because of this change, audit will now log the original argument from
ARM_ORIG_r0. However, when execution resumes, the system call will execute
using the modified argument from ARM_r0.=20

Could this allow a tracer to execute a modified payload while the audit
subsystem logs a different, benign one?

> =20
>  	return scno;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D2
