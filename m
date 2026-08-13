Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DC48B361;
	Thu, 13 Aug 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641661; cv=none; b=m1HEPznLYgiVaj2HJqZTqjtt/pigi8R4oZ+4ol9vBAKhgDr5LB/QHnd1oYyCv1xS6Tzu3vblpk8QcF1hjxIK04EzO1EKeYW5lq0XG5UQjhLmkXNLRuJkhYIu17SsHgMq6W5ctGs3K0qn3lTmdrvXlqFY5Dzk3npbHuO0aC+0nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641661; c=relaxed/simple;
	bh=SvKPNP59iHfpx3AWELSEgC5w+DwIBIFkZEMhsOd76xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Voyf/wPLu4KciBBDtj93wVqAZ7e8ua6YbmUlGKwpPU/PYk+6eUsnPzjKRF3b/sW+WXYYV60GW2FFB7u3GXnTL/Dk4epo88+nGaWTuVJDsoBltDGh8cJ2oH9FTmdinYjVP0sSRFd/yFYCN4K9iSGEV1UtMOA8+PTf4i8aVA0sYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUyOLLfq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUyOLLfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E715F1F000E9;
	Thu, 13 Aug 2026 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641657;
	bh=KIU0nMLtOalPn1Z5Wt/u+8JYIfCBDkCth4hUBbvtSa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUyOLLfqupyiOnJizwXz3+XQEQDIPFtq15BWkxxwzrqLmpFv2CgbosAzSshdHFfHc
	 sQqmwtzs+6huMpsYadlltnPP1cGbAi8M0D4Qs6AUhe1wREitLyW0Dk9t9hTsqCDKA8
	 KluoLnK6l2zoIhEQZC02LAgObW5pw8mhpH4spEJDGJ98aM+R58NZvLoWB+8Qow4JhG
	 EqFDxlw6205tan2CiqRHdVGnwOchjPvyIqhGnPqbE2shvkHnZZehgkiQS83xtxPRup
	 yHqyDW+6Lrt+6//gNfWmlXWJVE2wzofCNZVoSgdDelajVdeGRvAcLJpfDuwbmmXV53
	 7bGRBaSdPUu3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] audit: log all six syscall arguments in the
 SYSCALL record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <e869742712017760dec79f20748370a4ac8bfea2.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <e869742712017760dec79f20748370a4ac8bfea2.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:20:56 +0000
Message-Id: <20260813172056.E715F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch changes the signature of `audit_syscall_entry()` and `__a=
udit_syscall_entry()` to require 7 arguments instead of 5, but fails to upd=
ate direct callers in architectures not using the generic entry code (e.g.,=
 ARM, ARM64, MIPS, PowerPC). This mismatch results in widespread "too few a=
rguments to function" compilation errors.
--

--- Patch [1]: [PATCH 01/13] audit: log all six syscall arguments in the SY=
SCALL record ---
commit 078f116f3b4c24869c2f9f6df42833c2c348b962
Author: Ricardo Robaina <rrobaina@redhat.com>

audit: log all six syscall arguments in the SYSCALL record

This patch extends the SYSCALL audit record to log all six syscall argument=
s,
adding arguments a4 and a5 inline within the existing record. It updates the
audit_syscall_entry() function signature to accommodate these new parameter=
s.

Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=3Dgqy7dX=
4Ah11RVhdyCBUQ@mail.gmail.com/T/#t

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 803b0183d98dd..5c3486dd691f6 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
[ ... ]
> @@ -375,10 +376,11 @@ static inline void audit_uring_exit(int success, lo=
ng code)
>  }
>  static inline void audit_syscall_entry(int major, unsigned long a0,
>  				       unsigned long a1, unsigned long a2,
> -				       unsigned long a3)
> +				       unsigned long a3, unsigned long a4,
> +				       unsigned long a5)

[Severity: Low]
Will this break the build for architectures that do not use the generic ent=
ry
code?

For example, looking at arch/arm/kernel/ptrace.c:syscall_trace_enter(), it
still calls this function with only five arguments:

	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
			    regs->ARM_r3);

Similarly, arch/arm64/kernel/ptrace.c:syscall_trace_enter() and
arch/powerpc/kernel/ptrace/ptrace.c:do_syscall_trace_enter() also appear
to call audit_syscall_entry() without the newly required arguments.

Should these architecture-specific callers be updated as well to prevent
"too few arguments to function" compilation errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D1
