Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7394A2E17;
	Thu, 13 Aug 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641455; cv=none; b=nlSoef2N65lFus5alURrnmdRf9sWhh8F+t0tivHhjeInS99Cgp6T2dZa7D5nIBUzsytWl1Slc1XdS5MfwHbeT2Hm2TeuHIzR6zBDeOHcGS1oiaF46G+dMOV0Krih6iLSQYBn6jnin3xMZdTiZ5zjWDb+W/nHXWevnoMZSrwt2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641455; c=relaxed/simple;
	bh=jQ/dW4Vhmcxo/pQQIciVUY/RP/zNy8o+EC3W0CJSXE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sp/Mn5UuumUZgpu5IOkFx0dDvV9gyK13wRgLCsTS5yjHEdJS5zkoLK/YLf+OWwejZSW/WpkebcrH2WwAiRXsGKaVFQAzFiw8/PMoeDDCtls+9yCUF2nejeGhW05kGWZWHZ1uHiu/PLAWBjNOtqVk+dLws+6SoVdyI6Cjpfid0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azaHqEmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azaHqEmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5511F00A3A;
	Thu, 13 Aug 2026 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641453;
	bh=RzppDJGB6ZCdx2OYyV1lZRNPp+9ZE+7GMmUkW1Kug2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azaHqEmxm6G1IZ5/HBcjMrVFaAp1cchh89o6D6+eTgy4aYsbozEzDIDEsaz1MwgMJ
	 +73dhSxVBsQ22VlYL30slO71tQk7Hr8jllKGXCw0+UB8yB7S5Cfzn350n+FqInUhch
	 Q0UOV3molRjYsuWVIpl+wH7OZJrPTpXbI/Mz/OmmB9aER8ATNsbHRvdRbzEKu7xLd+
	 5Lf9c6wuYBpkzzA6eegtxiEtPCZUZqoTHmTD0KvVvNZQOuXgX2JFdhQ3iGrgooL2oV
	 OophZ65KcaGSQ6lDR42av0LxloTelt30VJAQWpXAE1e2RMsRXNo4JWGhEnxSYijBOw
	 lw3QNfIjFFv0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] arm64: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <84e977166dfd72c8c5b53a54e86e149e7ed60672.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <84e977166dfd72c8c5b53a54e86e149e7ed60672.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:17:32 +0000
Message-Id: <20260813171733.1A5511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Tree-wide API change for `audit_syscall_entry()` missed several arc=
hitectures, causing build failures due to an argument count mismatch.
--

--- Patch [4]: [PATCH 04/13] arm64: pass all six syscall args to audit_sysc=
all_entry() ---
commit 5064bc40e84bac75de063321783c252440dbc0f5
Author: Ricardo Robaina <rrobaina@redhat.com>

arm64: pass all six syscall args to audit_syscall_entry()

This commit updates the arm64 syscall entry path to pass all six syscall
arguments to audit_syscall_entry(). This aligns with updates to the audit
core which now expects these additional arguments.

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 4d08598e2891d..093c20bff38a9 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2427,7 +2427,8 @@ int syscall_trace_enter(struct pt_regs *regs)
>  		trace_sys_enter(regs, regs->syscallno);
> =20
>  	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> +			    regs->regs[2], regs->regs[3],
> +			    regs->regs[4], regs->regs[5]);

[Severity: Low]
Does this change need to be applied to other architectures as well to avoid
build failures?

It looks like several other architectures were not updated to match the new
7-argument signature of audit_syscall_entry(), which will cause them to fail
to compile due to 'too few arguments to function' errors.

For example, MIPS continues to pass only 5 arguments:

arch/mips/kernel/ptrace.c:syscall_trace_enter() {
	...
	audit_syscall_entry(current_thread_info()->syscall,
			    regs->regs[4], regs->regs[5],
			    regs->regs[6], regs->regs[7]);
	...
}

Similar missing updates appear in C-Sky's syscall_trace_enter()
(arch/csky/kernel/ptrace.c), Microblaze's do_syscall_trace_enter()
(arch/microblaze/kernel/ptrace.c), and PowerPC's do_syscall_trace_enter()
(arch/powerpc/kernel/ptrace/ptrace.c).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D4
