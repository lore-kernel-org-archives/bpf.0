Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFB4A3841;
	Wed,  2 Sep 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361295; cv=none; b=lTYlJrt8MS0S7pzi2u0rJjxF37Y0E7Cxq+/VXTR/Ub9FJrozblLfu/ntH98BWV4pYUuLlvrUH4ondnUOwKaep79YUL+qJvWqLj8IMHOqlfd7h19eQyG6/NpN/cbnkDKUXxpL9eRa/zhy8Wq4RLeuxQcC8e1WzR1DXqIWrxLPEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361295; c=relaxed/simple;
	bh=PdRUPgSmrJwqRJQac2lrmeUORSsVyRwXdt8wGhDcHW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GeWL5PTKuBEYSQcebyjzMpDyHYXuQS+Iz3416r29jxU8U18b3lma/RwAnzZyCbN9T5ngbMZTCNMFpzYW3Eoi26CmOpAHjexeME87feiKtFPhJSd2KuzH12bNSoxiT3qhoMubdnrs8lRI+7K1E5TjJt+en1e/VAQJhyhUHFHUATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ3mcs2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ3mcs2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B981F00ADB;
	Wed,  2 Sep 2026 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361290;
	bh=9s2vojWJtLbhfmOLS5zWNM3UwyiUyE5a8nrQtLniIOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJ3mcs2IK0pkb68W2M+cYHwAQ6b9apgeIIt5mLbZGuZMuZ8IhstDZiMcb81UXW6VF
	 1lBRsKSqGpN4im8E+16WPo/Mv5X4n+cszbbg+Xw1d3JDCoVPL/1zMXs0fwADvcimWf
	 /b+YlBFK4Z0ZeooZ0pf1hRKpZNdtPZpOL+WbObYif/VSdP31n9aYb1mx+CuCf+76IO
	 sxZObb+N6jKaPw+xWpZaOi1ZHaIUs8lBu2ZqXVponcpBNaOGJMtyiRCWTBdhX38Cs/
	 OsWyxUFT8/LlbmHRcx+jwFHzb5ip+hLxzjJpjyIih/b8yfEPRP1SXvKs5ubMM8WuX6
	 4638gP4X6yy2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] parisc: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <83d9a03e1fa526aef9f2ecac704c118a156401d7.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <83d9a03e1fa526aef9f2ecac704c118a156401d7.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:01:29 +0000
Message-Id: <20260902150130.56B981F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Removal of explicit 32-bit masking for compat syscall arguments al=
lows a ptracer to bypass audit filters and leaks upper 32 bits into audit l=
ogs.

Pre-existing issues:
- [High] Seccomp evaluates unmasked 64-bit register values for 32-bit compa=
t tasks, allowing bypass of reject filters.
--

commit 78cafbbd76943b4c2f06e1817363e637bd633afe
Author: Ricardo Robaina <rrobaina@redhat.com>

parisc: pass pt_regs to audit_syscall_entry()

This commit changes audit_syscall_entry() to take a pointer to pt_regs
and extract the syscall arguments itself via syscall_get_arguments(). The
individual argument registers are dropped from the call.

> diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
> index 1d9e210702e1f..948e0cf29ba47 100644
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c

[ ... ]

> @@ -359,15 +359,10 @@ long do_syscall_trace_enter(struct pt_regs *regs)
> =20
>  #ifdef CONFIG_64BIT
>  	if (!is_compat_task())
> -		audit_syscall_entry(regs->gr[20], regs->gr[26], regs->gr[25],
> -				    regs->gr[24], regs->gr[23]);
> +		audit_syscall_entry(regs->gr[20], regs);
>  	else
>  #endif
> -		audit_syscall_entry(regs->gr[20] & 0xffffffff,
> -			regs->gr[26] & 0xffffffff,
> -			regs->gr[25] & 0xffffffff,
> -			regs->gr[24] & 0xffffffff,
> -			regs->gr[23] & 0xffffffff);
> +		audit_syscall_entry(regs->gr[20] & 0xffffffff, regs);

[Severity: High]
Does removing the explicit 32-bit masking for compat syscall arguments allow
a ptracer to bypass audit filters?

Since audit_syscall_entry() now uses syscall_get_arguments() internally to
extract the registers, and syscall_get_arguments() does not truncate the
arguments to 32 bits on PARISC:

arch/parisc/include/asm/syscall.h:syscall_get_arguments() {
	args[5] =3D regs->gr[21];
	args[4] =3D regs->gr[22];
	args[3] =3D regs->gr[23];
	args[2] =3D regs->gr[24];
	args[1] =3D regs->gr[25];
	args[0] =3D regs->gr[26];
}

An attacker in a 32-bit compat task could manipulate the upper 32 bits of
syscall argument registers via ptrace. Audit would evaluate the unmasked
64-bit values, while the syscall wrapper would truncate them to 32 bits,
potentially leading to an evasion of security audit logging.

[Severity: High]
This is a pre-existing issue, but does Seccomp also evaluate unmasked 64-bit
register values for 32-bit compat tasks on PARISC?

Seccomp relies on syscall_get_arguments() in populate_seccomp_data():

kernel/seccomp.c:populate_seccomp_data() {
	...
	syscall_get_arguments(task, regs, args);
	sd->args[0] =3D args[0];
	sd->args[1] =3D args[1];
	...
}

Because syscall_get_arguments() does not mask the upper 32 bits for compat
tasks, could an attacker bypass Seccomp reject filters by injecting 64-bit
values with garbage in the upper 32 bits before Seccomp evaluates them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D9
