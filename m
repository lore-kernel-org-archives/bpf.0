Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F23E7BA6
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690461; cv=none; b=cDBdyRNvvQgWs/FlgThFbpOURQs8tH9a3Yy20vhll98kwgqnImbxVKPJRxRzWBio9MVC8tegWpXirEtBKaHGYtfZsddfWxm4m+MfVMbjnKuDbVFYuQtqum4iysiPi5HF5NP0Pv4ByzQzi/62Qy3ygQeUukf4m8VQu9q1fEscBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690461; c=relaxed/simple;
	bh=Nf9DUsSDVSU+v/gh4OEuI+yyHtVMaQXWZnGpgSPT0iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOBLaq1CGUEpKOYoxEJTomxAJPU5vlmAUpBO489RfOjqlnr5hPIo9tXgr2dzousROuo9W08d5eCmKe5YvFOXGRE8SRHacDfaqnxuMJKhI3vmP+3CK7s5RaWc4AoENLuUPHgpTUJ152LEm4Lj201nSSdeZTZ+J5G9Q7tPr/sqzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFm1eMDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFm1eMDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66521F00893;
	Fri,  5 Jun 2026 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780690459;
	bh=IG1/Zt44c84hmUiu60tci4C5SDA7s4PtXPLjX9EsPss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFm1eMDSkrG4fxzGu3ox30RBTIs5dX06PXU3fzKU1drr9tRbwZKFpcpXYm9udA6bE
	 0vy90ComitVLzK/6vufm5DFaV4WOyKcNkJqcyAPSys4PowPLX6Jj21e5sL3AoMJJXj
	 k7ekLORTwdlfS6Q5vSjYuup6YErGEcNqrbTP6/GXwlNREqgSotiXfNFBwty1BHpoIw
	 oR2TskxGfs5SYLgeOjtUam6wlhwPGjTeDhQAo9QfUjkDHIQUC5rA2dbB7whZlaOWha
	 vpQdtDEAU9eYYGM4Ig7kjonaMGIhE1tGRx1vaiDjiNp1EmpmEt8ytYgSoKG5Fcx8L8
	 K2Ulallrgu/ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
References: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:14:19 +0000
Message-Id: <20260605201419.A66521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix and functional regression using deprecated API in `=
bpf_task_from_vpid()`
--

commit 0e07d8082fa185913ccf64e5ced29e9a7fa63669
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: fix NULL pointer dereference in bpf_task_from_vpid()

This commit attempts to fix a NULL pointer dereference in
bpf_task_from_vpid() when the current task is in the late stages of
do_exit(). It adds an in_interrupt() check to return NULL before calling
find_task_by_vpid() in order to prevent crashes from cgroup_skb programs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3cf..890202361b533 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,6 +2912,9 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(=
s32 vpid)
>  {
>  	struct task_struct *p;
> =20
> +	if (in_interrupt())
> +		return NULL;

[Severity: High]
Does this check fully prevent the crash during task exit?

While this prevents the crash when an interrupt preempts an exiting task,
it appears it might not protect synchronous BPF tracing programs (like
kprobes or sched_switch tracepoints) executing in task context during
do_exit().=20

Once __unhash_process() has cleared thread_pid, in_interrupt() is false
in task context, but the namespace is still NULL. Wouldn't the crash=20
still occur in find_task_by_vpid()?

kernel/pid.c:find_task_by_vpid() {
	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
}

Additionally, in_interrupt() is known to return true in normal task context
whenever bottom-halves are disabled, such as inside a spin_lock_bh() region.

Will this cause bpf_task_from_vpid() to unexpectedly fail for valid
tracing programs attached to living tasks that just happen to be holding
a BH-disabled lock?=20

Could we verify the namespace directly instead to avoid these issues,
perhaps by checking if task_active_pid_ns(current) is NULL?

> +
>  	rcu_read_lock();
>  	p =3D find_task_by_vpid(vpid);
>  	if (p)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605200501.1619=
406-1-rhkrqnwk98@gmail.com?part=3D1
