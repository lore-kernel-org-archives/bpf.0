Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A727603C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849552; cv=none; b=tFrYjvM9pDnAPLHnA6dQmIcXSRgPyetq6nDAjZhvksGNYiIPa8h7XVutjdivEIrTEyySJRBTvtc+03bzF/QT+5UgHAvfPraQnX7UnJ30sENl4KC/yei6kbEXZvrBb0RGRO6QmbEMiAUPtCrpJqchU4dMRAryf9eZW62Lnxhzg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849552; c=relaxed/simple;
	bh=SZQTPuz1Gm/CeA7gjXbUYcyAcfeIXZEM775gkE5V58w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sz0F2y53Agnd87GYFN7RnhIp/SZO1qDJKTsY7Sv8IHDzLVXtr1+VAGIE9++PHjT8UWQzg/7pjVBmFYMzEBrDRN6JxgvCLGgW/TO3IX3qP7g78pbPP4YZOY3WT/7j1GhphI11fzTOTff88cT4RU0r8wcGydcUDlAH+5GyGIqWVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Zcz0wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Zcz0wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD66FC2BCB0;
	Fri, 15 May 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778849552;
	bh=SZQTPuz1Gm/CeA7gjXbUYcyAcfeIXZEM775gkE5V58w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n4Zcz0wfpRVhE9fZ+zCP1ZjHrYNeuEY1zbHPEJVsGzbKkg0b6JwiFe9rfpHPyKJvR
	 Tej9oxgCEADGAJQVb2COwC7HHbmpluQGWEtc8Nzu9P6YVxP9tOt9ilTGKBhQXygHPc
	 fj0yX5mDlOnlx0XOxv5UGp5hJCSIE8LVdfIyeFDXW8wARQYN5bULTgabYUTsXWmmll
	 AtEcOh1fw7c2qO1//IX2dN/XtvfgmCUgoQAYFVEaNGIYmw82GXtUmkZctFmpuNr1rv
	 bkydA9VrTGpuioXwEZMt8Lo9HXAvAL7cOgSQ0a56r7MkCwmsDrIzeMKR0kT8rskOYe
	 5wOcSJPGX7NyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cgroup/rstat: validate cpu before css_rstat_cpu()
 access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qing Ming" <a0yami@mailbox.org>
Cc: tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com, hannes@cmpxchg.org
In-Reply-To: <20260515122952.59209-1-a0yami@mailbox.org>
References: <20260515122952.59209-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 12:52:31 +0000
Message-Id: <20260515125231.BD66FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `css_rstat_updated` kfunc is vulnerable to a kernel panic if a=
 BPF tracing program passes a `css` pointer where `css->rstat_cpu` is unini=
tialized (NULL).
--

commit e8d546639085dcc3eee578c0dace07ba513cb482
Author: Qing Ming <a0yami@mailbox.org>

cgroup/rstat: validate cpu before css_rstat_cpu() access

This commit adds a bounds and validity check for the cpu parameter in
css_rstat_updated() to prevent an out-of-bounds array access when called
from a BPF program.

> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
[ ... ]
> @@ -90,6 +91,9 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys=
_state *css, int cpu)
>  	     !IS_ENABLED(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS)) && in_nmi())
>  		return;
> =20
> +	if (unlikely(cpu < 0 || cpu >=3D nr_cpu_ids || !cpu_possible(cpu)))
> +		return;
> +
>  	rstatc =3D css_rstat_cpu(css, cpu);

Could this still lead to a panic if css->rstat_cpu is uninitialized?

The existing check at the top of this function:

    if (!css_uses_rstat(css))
        return;

only verifies that css->ss->css_rstat_flush is defined. It doesn't appear
to check if the per-cpu memory css->rstat_cpu has actually been allocated.

If a BPF program intercepts a css object during allocation (for example, by
tracing init_and_link_css before css_rstat_init completes), or if an
untrusted pointer is passed because the kfunc lacks KF_TRUSTED_ARGS,
css->rstat_cpu could be NULL.

In that scenario, css_rstat_cpu() would compute per_cpu_ptr(NULL, cpu),
which returns an offset from NULL rather than a valid memory address. The
subsequent call to llist_on_list() would then dereference this invalid
address.

Should there be an explicit check for !css->rstat_cpu to safely handle
uninitialized rstat state from BPF callers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515122952.5920=
9-1-a0yami@mailbox.org?part=3D1
