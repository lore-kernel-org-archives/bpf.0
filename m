Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0B499F2A;
	Thu, 13 Aug 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641889; cv=none; b=sAIVbtHNmGsj1kAxZ2t/kXruAiqBw22M8kcTMERX+wtXHQOjPkKQTjZ9NmEV+K3Z09bXdncmJhwPNuvNgJbdPBS1cKhbDTmAxaRJlSiE/oypOVcXOeAyhBKFUmeNe0rcL0R/DpVhReOGBtT39FcW4CLMu5lGjs/ttNSOxhfXO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641889; c=relaxed/simple;
	bh=SLUrrdRZStoe1H0hc82ZU0sc2sdtzlVK3w4k8EKbzo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLK+2CkoNaYWrFpWywvocoKuSjrH7nRUO2m5x7HIHdRmwqspJ76g9y0efPswvRlrNxt/ZGMZ5r2FwyzJ22lac0BenkXcHPKdWkhu4oBXivxyb+Bsa6fhCXB25CIcpp6kQJnezJpLd5xfYkGWz5HytgI36jgPorYptX+l9SsNkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLwLOWNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLwLOWNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5EE1F000E9;
	Thu, 13 Aug 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641887;
	bh=O2fN6c8CSW49PmntNyUiBO0QdMGM5GvkgZBSpMXWH1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLwLOWNyM95QM/Q5ZN9JMlrw3NM3Pe1NZ6WgVq+WpItN5Tbb7cCOa8KL7KOkK8LKw
	 m2zikwTgxhRjsd1yi46IMaZvORgx3/3ijw+hTEGTi8NqNea9B9bIhGn9FTJcwo6nSU
	 cimYjNRXxzCRAgrLQpRip1yPcrs18EsDSUaOlfaiEXxny01emdVFfR/3Fj2UM76ek2
	 FrojQH4TJ94YnMNWVBKbIV7YhPcEquRmDcu40u4XPUD93hgBrZgLW/YFB/HxCPdXVD
	 Q1okLYL3jsI+DBDFdhI6f2BpYC2agVq/oLM1/1EGujTmANhZ6s3QxQK3zjLDJo2pYE
	 2hG7G5FV6xRLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] sh: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <be964ca4e6854db2a66cbba4af1ff2fdd769e752.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <be964ca4e6854db2a66cbba4af1ff2fdd769e752.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:24:47 +0000
Message-Id: <20260813172447.AA5EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `sys_enter` =
tracepoint is incorrectly invoked with the 5th syscall argument (`regs->reg=
s[0]`) instead of the system call number, allowing userspace to spoof sysca=
ll trace events.
--

--- Patch [10]: [PATCH 10/13] sh: pass all six syscall args to audit_syscal=
l_entry() ---
commit 3f32d157a274ce4c78e2758720926d9048ca177a
Author: Ricardo Robaina <rrobaina@redhat.com>

sh: pass all six syscall args to audit_syscall_entry()

This commit updates the audit_syscall_entry() call to forward the 5th
and 6th syscall arguments. This aligns with the audit core which now
logs all six arguments.

> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 06f765d71a295..3efefd67b457c 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -467,7 +467,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs=
 *regs)
>  		trace_sys_enter(regs, regs->regs[0]);

[Severity: High]
This is a pre-existing issue in do_syscall_trace_enter(), but is
trace_sys_enter() receiving the correct system call number here?

Since regs->regs[0] holds the 5th syscall argument on SuperH, passing it
here means security monitoring tools attached to the sys_enter tracepoint
might receive an incorrect, user-controlled syscall number. Could a local
unprivileged attacker exploit this by placing a sensitive syscall number
in the actual syscall register and a benign one in r0 to bypass security
auditing?

> =20
>  	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
> -			    regs->regs[6], regs->regs[7]);
> +			    regs->regs[6], regs->regs[7],
> +			    regs->regs[0], regs->regs[1]);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D10
