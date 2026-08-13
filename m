Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8A4A2E00;
	Thu, 13 Aug 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641539; cv=none; b=hWy6mY+dESTlIImg0p14hmijZIolwmLI7OzBt9RZCIaSo9vUWh4auQg4dPvEloSbuyNFbapSshdUBLKuKut+Lzb9ktaTJJlYfBVSz7yLuz3NTYfZ+E1k++N/TuBuOaRxW1IIsYzyqKGFBNxHitV23auWx/TF3R5PB4Pfovv+JrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641539; c=relaxed/simple;
	bh=v/ue70/FSZFaIQeua/1hAuL9GUw0Dtmd5j0KNdgSm9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b4gyt4D6V8JvIJTemrZMXtdKrAUHQZiKcJNQ2mTYzsnf85o0YjG5vOzlsQQj+OzFbuFyuHpvbEHIB+PJ7HOl2+a74mVNCFjEqNFedL/F52DlMUVY6tvQF09Gp+m7nGlT5YXkyfsdmMYRFjLIX2zvdUU7Q2XEM/qidhvHddwpTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqcqqKty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqcqqKty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E591F000E9;
	Thu, 13 Aug 2026 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641536;
	bh=7YfHeS9sPLK1Lhe6B/cprlk6Tdxtdx92WvKqR+YhQVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqcqqKtyx/WEIgwveiSclPdXlrJorUuOOWdBr7OVjAV/bSpRCmX+CdQz4eCS+LoRv
	 GpDl7/xnLYmcbBqDoeuXnJ02bw2t3int1dzS04m3+i92ku+VHIq7sy737lOwg7vQUr
	 EJqC25oMoPbP/jOQKpy8CFXlTFUnXHeB5lf6Sct/bFSLurK2K1SYH49EWHA9S4RmDO
	 syIgYiMTOcmkx9na+JWeVzwODjrCIEFUazK+Ux4+A4WLRWmguFyJJd2ArZASRUtIYb
	 s7HUtV6Lsd4bi0Fz77VGXxSo8+2DrtikWavVL2d0JasFmFJU3zqufKTqOBnykcIhOX
	 vjfs7adr1d3LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] alpha: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <7dec380a50e3db536bdec61a33b8f3b2e2e7ec65.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <7dec380a50e3db536bdec61a33b8f3b2e2e7ec65.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:18:56 +0000
Message-Id: <20260813171856.B0E591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When a syscall is skipped by seccomp or ptrace, the kernel fails t=
o set the return value to -ENOSYS, allowing unprivileged userspace to spoof=
 successful syscall returns.
--

--- Patch [2]: [PATCH 02/13] alpha: pass all six syscall args to audit_sysc=
all_entry() ---
commit 34becaec07c6a7a08cc6bd923c1a39f3ee655963
Author: Ricardo Robaina <rrobaina@redhat.com>
Subject: alpha: pass all six syscall args to audit_syscall_entry()

Update the audit_syscall_entry() call to forward the 5th and 6th syscall
arguments. This ensures the audit core logs all six arguments on alpha.

> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index 0687760ea4669..d90e2194b5284 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -396,7 +396,8 @@ asmlinkage unsigned long syscall_trace_enter(void)

[Severity: High]
This is a pre-existing issue, but does the -ENOSYS fixup in
syscall_trace_enter() get skipped incorrectly when a syscall is filtered by
seccomp or ptrace?

Earlier in this function, the fixup condition is:

    if (secure_computing() =3D=3D -1) {
        if (regs->r19 =3D=3D 0 && regs->r0 =3D=3D (unsigned long)-1)
            syscall_set_return_value(current, regs, -ENOSYS, 0);
        syscall_set_nr(current, regs, -1);
        return -1UL;
    }

If secure_computing() returns -1 to skip the syscall execution,
syscall_set_nr() sets r1 to -1. However, it seems r0 still contains the
original syscall number instead of -1. Doesn't this cause the fallback
condition to evaluate to false and skip setting -ENOSYS?

If so, a seccomp filter that skips a syscall without explicitly setting a
return value (such as SECCOMP_RET_USER_NOTIF) might leak the syscall number
back to user space as a successful return value instead of returning an err=
or.

It looks like this same logic is mirrored in arch/alpha/kernel/entry.S in
SYSCALL_SKIP_RETURN_RESTART_GATE:

    ldq     $20, 0($sp)             /* r0 */
    lda     $21, -1($31)
    cmpeq   $20, $21, $22
    beq     $22, 1f                 /* r0 !=3D -1 =3D> skip fixup */

Does this also bypass the fixup for the same reason?

> =20
>  #ifdef CONFIG_AUDITSYSCALL
>  	audit_syscall_entry(syscall_get_nr(current, regs),
> -		regs->r16, regs->r17, regs->r18, regs->r19);
> +		regs->r16, regs->r17, regs->r18, regs->r19,
> +		regs->r20, regs->r21);
>  #endif
>  	return syscall_get_nr(current, regs);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D2
