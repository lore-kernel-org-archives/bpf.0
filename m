Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA137E5F3;
	Thu, 13 Aug 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641835; cv=none; b=mrQuxz9/r+g3x1ecuDBYrUA32j2uUsry1nrTuQXlgwXbOxTa8xc5w37Kb2kuyeDA1xFXD7Vx8hqDpMy1gKJVL/CnZy6FeO3QoNl/DkfAq6azTKyaoVNtcGfN/uglrX7BM4CoWfLLaG7a9P2xHBhxCnQi1B7TF6CRXDRj7MSEdYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641835; c=relaxed/simple;
	bh=bNuBTrHWhLMwgRtmENebj1Yi5AifCDY4aksBpiApKfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aTuHzjZL0tMNKSZT0/f3mVceupj26KEGnCD7UMU2DQf3zn/JCveqosP+B5+7rjbKPam77lpZtoBpDQ+T6dVgsPx5ZtaAaoxxB5XYsrY5LxJGroipehKIFDkJfXHfXK13vsWIKHZF+lRHDVrnXnnZ7mwtLNeD3nD0xayn5n8ikuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbAnS5hB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbAnS5hB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9526E1F000E9;
	Thu, 13 Aug 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641833;
	bh=6RCArC+ecCgxAcKhfV6mvD5jmGAZeV9Mlizn/px0fhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbAnS5hBbnzneezi6Xlaw1L3W3Xo3rEpJDeydw/V0VwHVAlYQ5NLsG4ppNFfQHOcT
	 262v3OB/W+qIVM6Mikxm5XdrzDM/HtgJKmMdv+LV0McWYwL7jFlyDaEypWFOlF7GAu
	 bnXKgvwPw7orX/aUc+8uLg428on/v1UcbAurLWe7U7Cu7DIhvdElxLEwdWwnan6dgt
	 zcLxLDVa3XmXxpJRZB+Tk8JgkJiYvBgkPMVHL0RbfuaX17W3B3mk6jL0gfR7gUIOmU
	 MZqMezkh2BaWycAStE9vLI1BQp+J9mHcu1gphh8GCpeacPVB0GaKzKxxvm/+HfYw3P
	 iUkof5NxSoeKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] xtensa: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <0c7aa94c05b08d959d885b3b0434646a6b2fcfd0.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <0c7aa94c05b08d959d885b3b0434646a6b2fcfd0.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:23:53 +0000
Message-Id: <20260813172353.9526E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The core API patch in this series ('audit: log all six syscall argu=
ments in the SYSCALL record') changed the signature of `audit_syscall_entry=
()` from 5 to 7 arguments, but the PowerPC architecture was missed. This le=
aves PowerPC passing 5 arguments, resulting in a build failure.
--

--- Patch [13]: [PATCH 13/13] xtensa: pass all six syscall args to audit_sy=
scall_entry() ---
commit 7f8e4937464dcba7a1012a4d48470ce510d233d3
Author: Ricardo Robaina <rrobaina@redhat.com>

xtensa: pass all six syscall args to audit_syscall_entry()

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (areg[8], areg[9]) now that the audit core logs
all six.

> diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
> index b80d54b2ea34e..122a6ffc0757e 100644
> --- a/arch/xtensa/kernel/ptrace.c
> +++ b/arch/xtensa/kernel/ptrace.c
> @@ -564,7 +564,8 @@ int do_syscall_trace_enter(struct pt_regs *regs)
> =20
>  	audit_syscall_entry(regs->syscall, regs->areg[6],
>  			    regs->areg[3], regs->areg[4],
> -			    regs->areg[5]);
> +			    regs->areg[5], regs->areg[8],
> +			    regs->areg[9]);

[Severity: Low]
Is it possible that the powerpc architecture was missed in this series?

While xtensa is correctly updated here, it looks like do_syscall_trace_ente=
r()
in arch/powerpc/kernel/ptrace/ptrace.c still passes 5 arguments:

arch/powerpc/kernel/ptrace/ptrace.c:do_syscall_trace_enter() {
    ...
		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
				    regs->gpr[5], regs->gpr[6]);
    ...
}

Will this cause a build regression on powerpc since the new signature requi=
res
7 arguments?

>  	return 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D13
