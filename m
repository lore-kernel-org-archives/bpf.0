Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0624A4830;
	Wed,  2 Sep 2026 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361648; cv=none; b=pDCv4VtwQmEUinzPgQXFHAKGblluuO2D/k/GZhbSf4RIbTqc0ko+bvoO7iqhqksHJN2M/TAMKiAZqMjKHZWIrbCiHpLuegDCXeIQpvoadC/KLDXmB9YZmoWoNGH8/lUPtJTVXCMoDrX55xwzylqk5iLGxxZ9QbJAP1uzroCqJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361648; c=relaxed/simple;
	bh=0mnS3z5xj5j0EGixgoMG0uXz9CCR+lrRlTL95dX8Bf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DFfi0Z9/r5dRFkahYSBKHW27ZnuVKWk6HclGvF74rGdqAK7puoZ62IykZm/meXer6HcgpYpZWcTOewBDlDTDAVcv9xfGumR0oiSMuYNPG25gkmv7e9gLkpqe6f9lPs68XwHjWF3PzMsr4YRpfo/lHInzQJtIp/E9udKnkXd2frU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAquLHUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAquLHUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ECD1F000E9;
	Wed,  2 Sep 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361645;
	bh=SwUmuhkqALdk4ppVFVVa5HEC1Y6990k7pGT8GKXETOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAquLHUM/+WtsKfpzJm5P378PySxfu8Qk5fc2LzwzpbQHmBJstyIHhhhbapnPmTwm
	 9QR6WNnHWlDSGOhqcBQVuLkmyllctrNBwRrdrNOKgspAGxtZE5O928mwOsnS7mPEoF
	 CsB9ScXcNSIYVXh5EubOwXNIHdIdwMLSlkiGifOWlTVbPlhGLaweO904D5AiJYUtFV
	 kkHDINPHcJdeyydamAmQzY26oLtzMOQFTmq0kplwjpIAARolz5cdChR2Bd2w2tMCWL
	 RjAGs/k7RrXPegLKMNFt+OmFQ8qkwGYsulVNOu0ds/3cIPDtw4Z/Qqt8y2ZPFF3r+N
	 YGaQy7uPm3hjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] openrisc: pass pt_regs to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20dc1432035e116c2a0be75afc0504e4a8ac4274.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <20dc1432035e116c2a0be75afc0504e4a8ac4274.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:07:24 +0000
Message-Id: <20260902150725.70ECD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Syscall abortion via ptrace is ignored by the assembly fastpath, c=
ausing aborted syscalls to execute anyway.
- [High] Tracer-directed syscall number mutations are ignored by both the a=
udit subsystem and the execution path.
--

commit b9f4a1989ccdc62e1dafc2931825c9e52d439b17
Author: Ricardo Robaina <rrobaina@redhat.com>

openrisc: pass pt_regs to audit_syscall_entry()

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

> diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
> index 287a9718f0c60..eca613b84ff87 100644
> --- a/arch/openrisc/kernel/ptrace.c
> +++ b/arch/openrisc/kernel/ptrace.c
> @@ -301,8 +301,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs=
 *regs)
>  		 */
>  		ret =3D -1L;
> =20
> -	audit_syscall_entry(regs->gpr[11], regs->gpr[3], regs->gpr[4],
> -			    regs->gpr[5], regs->gpr[6]);
> +	audit_syscall_entry(regs->gpr[11], regs);

[Severity: High]
This is a pre-existing issue, but does hardcoding regs->gpr[11] here ignore
tracer-directed syscall number mutations?

The generic framework's syscall_set_nr() updates regs->orig_gpr11 with the =
new
syscall number. However, this code directly passes regs->gpr[11] to
audit_syscall_entry() instead of using syscall_get_nr(current, regs).

Additionally, the _syscall_call assembly fastpath appears to use the origin=
al
syscall number reloaded from PT_GPR11(r1). Since neither layer reads
orig_gpr11, standard PTRACE_SET_SYSCALL_INFO mutations seem to silently fail
to influence the kernel on OpenRISC.

> =20
>  	return ret ? : regs->gpr[11];

[Severity: High]
This is also a pre-existing issue, but does this function successfully abort
syscalls when a tracer denies them?

When a tracer denies a syscall, ptrace_report_syscall_permit_entry() causes
ret to be set to -1L, which is then returned. However, looking at the
assembly fastpath in arch/openrisc/kernel/entry.S:_syscall_trace_enter:

	l.jal	do_syscall_trace_enter
	 l.addi	r3,r1,0

	/* Restore arguments ... */
	l.lwz	r11,PT_GPR11(r1)

Doesn't this instruction blindly reload the original unmodified syscall num=
ber
from the stack into r11?

Since do_syscall_trace_enter() never writes -1L back to regs->gpr[11] in
memory, it seems the abort signal is permanently lost when the assembly
restores registers, allowing the aborted syscall to execute anyway.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D8
