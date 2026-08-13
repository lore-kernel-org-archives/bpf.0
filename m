Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1A48D874;
	Thu, 13 Aug 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641397; cv=none; b=alg27eNMUUs/pJ05thMzJp7R7uhSUGjp9QPWk+F2Uq/mWzliePeG7mkXGnkAurJdaCfaL9YKyXlQJYeVxqnwtoxtEg00OF8jFdBXdf1o8OD19N8madhrqlgsoawkNYq/gMjcBkdSTbXg/FP0kCgwA3KLEwyDv4RAodmqStC283E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641397; c=relaxed/simple;
	bh=h4V18G1IGMluUDpGrYb0L5vfGcwL279BSqJc0Lxvn8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jals6CYmu4LBuKxnuRU2YTr3GoLQAFhtn0T79h8145a9Ey04ObUF8qOa/Jbn7da2LASI7cuJSLURzZURPoTK5Xqxqb29gqMY3kwyUBemIiYaec4cxIK7f9irUd6Vpr0OyaGd8DGcZAsI+JhSGyHzXD0Z3PlqxxNrgOZZM2qUt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo2StqAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo2StqAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1471F000E9;
	Thu, 13 Aug 2026 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641395;
	bh=DP/pkqUUqjCbjJSAYJqSSJGEYL3fyr5nTie6andI3Is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vo2StqAd9Sl5GV+5sQy97NHBlsSYBYDswk2ReMgNqWrrBoTzEcjZinP1GDFiyOYDI
	 RjWe7iltd4hTfeT5U3WMWDy2q83NAdJW8+SS7tbAajdqWGa51s4TyVYA2IjWYH7HQD
	 FE56/AFg6sTEnHcoLGjFS5nqBIyRzCB32t9628N54+dh+XddKQpd78cq3nPqPbMjy7
	 vyUV7QMmmj0vXHn372DDFRjiUuCi8cDUIa/ApS8cHHO0bCDKJqOppMo91uqhGGzgup
	 DoVnr4WkxJdsTS7JdOG422Iz1rTdmmCpxdVBQX6sEy+oLvNefJ3RKlSqvwhFiYnyFk
	 igY98d4ov+ibQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] csky: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <0b18395deee1e30aaa53e4cc402f93e6e273a9ad.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <0b18395deee1e30aaa53e4cc402f93e6e273a9ad.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:16:35 +0000
Message-Id: <20260813171635.7E1471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compile error by accessing `a4` and `a5` mem=
bers of `struct pt_regs`, which do not exist on the csky architecture.
--

--- Patch [5]: [PATCH 05/13] csky: pass all six syscall args to audit_sysca=
ll_entry() ---
commit 048151cce10f914f8f5068a59ec81b9462f22b0f
Author: Ricardo Robaina <rrobaina@redhat.com>

csky: pass all six syscall args to audit_syscall_entry()

This commit updates the audit_syscall_entry() call in the csky architecture=
 to
pass the 5th and 6th syscall arguments. It attempts to access these argumen=
ts
via the pt_regs structure.

> diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
> index 6bb685a2646b5..562eaf23be82d 100644
> --- a/arch/csky/kernel/ptrace.c
> +++ b/arch/csky/kernel/ptrace.c
> @@ -329,7 +329,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *re=
gs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, syscall_get_nr(current, regs));
> =20
> -	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2,=
 regs->a3);
> +	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1,
> +			    regs->a2, regs->a3, regs->a4, regs->a5);

[Severity: Low]
Will this cause a build failure? Looking at struct pt_regs for csky, it
appears the a4 and a5 members do not exist. Accessing regs->a4 and regs->a5
here in syscall_trace_enter() seems like it will prevent the csky
architecture from compiling.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D5
