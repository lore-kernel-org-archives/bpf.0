Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503735CB7F;
	Tue, 22 Sep 2026 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105874; cv=none; b=R+zQiM1OjOWVDPri9683fUn/29ChhvqKk4RRlt2KksIi/NL5J6oMqga6BhdXzgOJdllBSFkN+Sj6bANc3wBltTIJxn8zG+1GwD25JEIngO1L8FGw8D0zLcN/CnzmU8AKfQrZJCXBmKxXNljzbbKM61idMWkM2o2UFCsSeQ5wZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105874; c=relaxed/simple;
	bh=VUIGcDmsTSMnS677o7yHrfQDntelVO5GNAQd1yazxHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DCrcD19k+WzuQVTnLQk9sQJNlzrPcxPukuVPH9DqfKp27Sxh9RLIiJA5cXt3uBGjyBv1y6X7rHfej/txxOPC8eZWXsPgDxEmbepO0pcqnr3bntyqaC60Hy2PhF2Pz2PJ+KFvHvWFW5CxWZ6R6QGc3qEEhqPv6NIwxEpU9h6e5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYGgbj6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYGgbj6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087281F000FF;
	Tue, 22 Sep 2026 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105873;
	bh=hAgiDjE1WYPMNysXGOcwAut6+JxPIYekNZEg6RqaUN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYGgbj6JfOKWs7M7dSrIRvFr7CdIFTlMrIYxz120TYS/hMmJwvbEGLBW3jyMonscO
	 M0d+XPG9gjLUKVse9+wljuX+HMhWRk5k2H6rfPELcyLKMmh0hY3taTX7sCESdVX7sC
	 LgVc1H7YiWSc7sG1MNIwbv1B7RMab2mNkBXElxIcvaugwi+9vahjAk3zcrX7lGRO4q
	 EqgR4c6hQaaWONxNmGlguw09dhV853dBiSGe2s6gU0O/wJVGhHz2biHY/sWgvXeEQq
	 fXp0jNxejasniYMwXxem0I8d343uUhdm5q25ZpbGydgBYbZtZpWQEMWB2FsQv3aArf
	 jZlQghlorHX7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] audit: rename audit_syscall_entry_regs() to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:37:52 +0000
Message-Id: <20260922193753.087281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: alpha fails to compile due to unconverted audit_syscall_entr=
y()
--

commit ec0fa766c1abca8ff2e93429fedc5d6b95059a19
Author: Ricardo Robaina <rrobaina@redhat.com>

audit: rename audit_syscall_entry_regs() to audit_syscall_entry()

Now that every architecture has been converted to the pt_regs-based
audit_syscall_entry_regs(), the legacy audit_syscall_entry() and
__audit_syscall_entry() helpers that took the individual syscall
argument registers (a0-a3) no longer have any callers.

Remove those legacy helpers and rename audit_syscall_entry_regs() and
__audit_syscall_entry_regs() back to audit_syscall_entry() and
__audit_syscall_entry(), restoring the original naming.

[ ... ]

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 22ffad5b20608..9ce5962bc5370 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -374,17 +372,10 @@ static inline void audit_uring_exit(int success, lo=
ng code)
>  	if (unlikely(audit_context()))
>  		__audit_uring_exit(success, code);
>  }
> -static inline void audit_syscall_entry(int major, unsigned long a0,
> -				       unsigned long a1, unsigned long a2,
> -				       unsigned long a3)
> +static inline void audit_syscall_entry(int major, struct pt_regs *regs)
>  {

[Severity: Low]
The commit message states that every architecture has been converted, but d=
oes
this break the build for the Alpha architecture?

Looking at arch/alpha/kernel/ptrace.c:syscall_trace_enter(), there is still=
 an
unconverted caller that passes 5 arguments to audit_syscall_entry():

arch/alpha/kernel/ptrace.c:syscall_trace_enter() {
	...
#ifdef CONFIG_AUDITSYSCALL
	audit_syscall_entry(syscall_get_nr(current, regs),
		regs->r16, regs->r17, regs->r18, regs->r19);
#endif
	...
}

Since the 5-argument helper has been removed and the renamed helper now
expects exactly 2 arguments, will this cause a 'too many arguments to
function' compilation error when building for Alpha?

>  	if (unlikely(audit_context()))
> -		__audit_syscall_entry(major, a0, a1, a2, a3);
> -}
> -static inline void audit_syscall_entry_regs(int major, struct pt_regs *r=
egs)
> -{
> -	if (unlikely(audit_context()))
> -		__audit_syscall_entry_regs(major, regs);
> +		__audit_syscall_entry(major, regs);
>  }
>  static inline void audit_syscall_exit(void *pt_regs)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D14
