Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2B1519B4
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835917; cv=none; b=ZnEHVUiEnSHMm6MK5x/ccK3wIF/Z6U3iRgNFZaCNadOlRjGk3ANfA+y311bzJGIkBsMFdZKpJpHPDDtyn3q7e0lJKtKpFIRRMu21fR7Tku9Og3/+3VT8nRjOcPNWNtmdW/lnUKJfUeofpAbMM9TaAUW0vGM3f9tU8QvZYLmHQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835917; c=relaxed/simple;
	bh=nQXYWW6jqJYNU5c5mX+Qas2E3FG5VMLRqpso9F5c648=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SVfUu3srHfXdNupXivPd3ro/ic2KsXcZbKv0EZzEq5xOUuF9WrH6rhYMUp5u3bIplr0fBHdxmCA9MYnNw7SiK1IOOdlbifru7qbHnBSC+1atWLhISlemscv5zyTlyS1DtrH1nFMaZh97VQqJ21hhsSf/+qvWYclJB+LG5Yh1Npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Q6OKrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Q6OKrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70727C2BCB4;
	Sun,  3 May 2026 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777835917;
	bh=nQXYWW6jqJYNU5c5mX+Qas2E3FG5VMLRqpso9F5c648=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=P1Q6OKrhhZMOoJlHJiMt7KsJ9eLwiq2nm+WdELBt/SaskGXkyIdU8+IrWi16+u1M0
	 ZHlrBZeBMzkHxxKWTJvSoduw1LQaRfLskLh04omD0vd81RfOEDulj10+T2mScL+DZ5
	 x3FTy5l7Ja+UYlyX+Dw5Bt/+oBNstvACdS2jrpEC1neBxunJhNcanB/LV7OhT5+Iv0
	 WQwLvEVLqGdJkh17m9AGLh4Dcwq7AFlKrEo8l2qKizyE4zDHXmDgKx1LU8tMcYKKLc
	 wpcnylRArKbZ7PoEUpzDkd6SH5oj0Lgv8ArS48rg2UvRU1FRB9fJLDCP5GrbYcN1o9
	 EITt491NkKFww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503190119.559696-1-atomlin@atomlin.com>
References: <20260503190119.559696-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 19:18:36 +0000
Message-Id: <20260503191837.70727C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition allows an unsafe BPF program to execute and poten=
tially crash the kernel before the taint is applied.
--

commit e1d80dc0708bef39b15f2ef93cbdb5c71cbc352e
Author: Aaron Tomlin <atomlin@atomlin.com>
bpf: introduce TAINT_UNSAFE_BPF for mutating helpers

This patch introduces a new kernel taint flag, TAINT_UNSAFE_BPF, which is
set when an eBPF program utilizing destructive or mutating helpers is loade=
d.
This provides an auditable indicator that the kernel's execution flow or
memory may have been compromised by eBPF.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3109,6 +3109,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
>  	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
>  	bpf_audit_prog(prog, BPF_AUDIT_LOAD);
> =20
> +	/*
> +	 * The program has passed the verifier and is now publicly exposed.
> +	 * If it utilises unsafe helpers, formally taint the kernel now.
> +	 */
> +	if (prog->aux->taints_kernel)
> +		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);

Could this leave a small race window where an unsafe program executes before
the taint is applied?

Looking earlier in bpf_prog_load(), the program is added to the IDR via
bpf_prog_alloc_id(prog). If a concurrent thread polls for this new ID using
bpf_prog_get_fd_by_id(), could it attach and execute the program before this
thread reaches add_taint()?

If the unsafe program causes a crash during this window, the resulting dump
might not have the TAINT_UNSAFE_BPF flag set. Should the taint be applied
before the program is placed in the IDR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503190119.5596=
96-1-atomlin@atomlin.com?part=3D1
