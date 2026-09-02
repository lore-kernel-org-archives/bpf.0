Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16124A49BB;
	Wed,  2 Sep 2026 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361449; cv=none; b=bOd5JWRLMfhGYR0Rp7KYVpRv8F6Tv5Q5/BU2o93pGBf2QBliYK6Ehbe25vT9wrIUG3egmSdhke4/eu/SWIhEptp1/u3BgAyCM7qjqj/xVeFMSVjM8Q8Z9ca1lnfZOoj0mvUuZEUUG1YA9N0JiR1fV7TuLU90y5mk2JYvLf0AHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361449; c=relaxed/simple;
	bh=SskhbyJENija44mYrxJV3LwTqeTYxYuFmxXAOLj7RCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5eicXB6hCANCY1ZdJ81FjRw2roLjzJWzvdvMHCIB8x7HmMW4d7sAWdPrdhj89Ke2yw5gtbPl5wA4UoWjVdIQ1X8fIxZ68I9bB/XuyBdP4VpGrwt58n1pLdln2yOhCtqln/kr2J4hJzHrDo2EC/shAj06KvQdheVZNrFcgPqc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMmYBNAT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMmYBNAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91791F00A3E;
	Wed,  2 Sep 2026 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361447;
	bh=TARhqolkPcMgr0enEm0hjClchzNjo9m5okgZLVYFNlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMmYBNATE97CL7aw7TQlIPQIi4a0P47jkALAWqRe2L78wp5jJbaGTm5vwuc3AZnah
	 n2owhWvh5hQp7cN+q2OEKt0/e7QjirwZtOeB9GNjO4yUUJcv1o7xKDOuK7XiTmymR9
	 MibGgwTtf9EaJQnf6x/tbxh2TsIiRLGyKlOCTKVhiix6YEbXiOMn91UZpV2vXJYFPQ
	 gMrQYUXStWBTK426DdJhaDAPMu0FFYwqFP12pZ6S3uqCSZT0tkeBhOHN8BC/o1nbr9
	 mvfKmEdc5uPvv0eL6xbdHYFjcF4HrVckuAP+cyezZNb1Wpb1h2DgxOe5BI+aCZ/807
	 LnTv2MxjgyX1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:04:07 +0000
Message-Id: <20260902150407.A91791F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Syscall argument filtering truncates 64-bit arguments to 32 bits, =
allowing audit filter bypass.
--

commit 32fa904a92560e78e9593b4944ee636ddfb88ea9
Author: Ricardo Robaina <rrobaina@redhat.com>

arm64: pass pt_regs to audit_syscall_entry()

This commit updates arm64 to pass a pointer to pt_regs directly to
audit_syscall_entry(), allowing the audit subsystem to extract the
syscall arguments itself.

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
[ ... ]
> @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);
> =20
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> +	audit_syscall_entry(regs->syscallno, regs);

[Severity: High]
This is a pre-existing issue, but does the underlying audit framework trunc=
ate
these 64-bit syscall arguments to 32 bits during filtering?

When the extracted 64-bit arguments are later evaluated in
kernel/auditsc.c:audit_filter_rules(), they are passed to
audit_comparator():

    result =3D audit_comparator(ctx->argv[f->type-AUDIT_ARG0], f->op, f->va=
l);

However, looking at kernel/auditfilter.c, the signature of audit_comparator=
()
implicitly truncates the 64-bit argument to a u32:

    int audit_comparator(u32 left, u32 op, u32 right)

Can this allow an unprivileged user-space process to bypass audit filtering
rules (such as !=3D or <) targeting 64-bit syscall arguments? By crafting
64-bit values whose lower 32 bits evade the 32-bit rule comparison, the full
64-bit value processed by the kernel could still execute normally while
evading audit logging.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788351089.gi=
t.rrobaina@redhat.com?part=3D4
