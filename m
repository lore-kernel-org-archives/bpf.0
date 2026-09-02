Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9D4A499F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362085; cv=none; b=Pw83ac9PLrQk1d6gATwwspY8uwIn8+suiqBnmgeGup3FS5ba7zirLI3L1Q7SNML3oZ5UA2841SJeqXXJn1l/pyrO/MMeRlxdEqCoRh7v5bzvgfr10plysxzdepuil5eVBanetz/NboWlbypU5Ct8qBtHfV32CLV7iGR9yLwm05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362085; c=relaxed/simple;
	bh=YPbUKIjFtB/EzsS0YUJXjt/4qoJ3D3xM3kgBBudFK9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afBBfMuszJe/fqbnpAyEIlh/6a+9O50W1qHfO82pNstfe5GOLV8OuEcYeANsTZDuUo+XEeldd4+tplRgj6JQIvzkhdkLZqolQflo97o1WLpruieP6lruCqDGcyU/c21eZamPzNlBEAyjZRiwFA8WMyZLz5uixEdkz7iOzx5Rbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JljTy/X1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JljTy/X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE91F000E9;
	Wed,  2 Sep 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362083;
	bh=mMmvLLzvvEzft/7lgXaiNL7/+LhE7P9tX647IqVzt1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JljTy/X1Z6kbuFXMfeNILCAqZ0Wt4V4J9rUph6EkpUOqFZ1J6KRNc5fBYWCZnzDFc
	 E9/UNzA2FGTydMpMAGyKjSXLPeKS4mYPSp/nw+lMsHUX5Mq9ck04LVedfFaLnsV5xL
	 m7tVq/dHuPft3sp8eop2gCNEsXyHRhHgozepiXXjz+6TQdBPS2ckJSyHz3NN0Hmx4w
	 jwqPFjOXurgirPs97BMLEunUpFahtulMyMzTU8QJWcZ/FUiDn0DO+ioraskLmGlAAQ
	 cQZl27UZX7AY4yKNWaAWKB5AVurjBq/QkRfjUp5UHUROVwVZ0+QTm21cxIDKS/5zHl
	 P7TnowUZRt4PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Only check nmi_uaccess_okay() when
 signalling current
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Sharma" <adi.sharma@zohomail.in>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902150439.692725-1-adi.sharma@zohomail.in>
References: <20260902150439.692725-1-adi.sharma@zohomail.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:14:42 +0000
Message-Id: <20260902151443.14BE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comment does not follow BPF subsystem standards.

Pre-existing issues:
- [High] A TOCTOU data race on the per-CPU `send_signal_work` structure all=
ows NMI reentrancy to corrupt irq_work data and leak a task_struct referenc=
e.
--

commit b0fb28992ab88d35a628c6d9650cd4ab7e67c397
Author: Aditya Sharma <adi.sharma@zohomail.in>

bpf: Only check nmi_uaccess_okay() when signalling current

nmi_uaccess_okay() takes no task argument and is a statement about current.
This commit restricts the check to only apply when signalling the current
task, fixing a bug where bpf_send_signal_task() returned -EPERM for kernel
threads.

Link: https://lore.kernel.org/bpf/20260819124324.43162-1-adi.sharma@zohomai=
l.in/T/#u

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..f7a41f2225999 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -871,7 +871,10 @@ static int bpf_send_signal_common(u32 sig, enum pid_=
type type, struct task_struc
>  	 */
>  	if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
>  		return -EPERM;
> -	if (unlikely(!nmi_uaccess_okay()))
> +	/* Since nmi_uaccess_okay() is only for the current
> +	 * task, check if task is current.
> +	 */

[Severity: Low]
This isn't a bug, but does this newly added comment violate the BPF subsyst=
em
multi-line comment style?

The BPF subsystem strictly requires multi-line comments to have the opening
/* on its own line, with the text starting on the next line.

> +	if (task =3D=3D current && unlikely(!nmi_uaccess_okay()))
>  		return -EPERM;
>  	/* Task should not be pid=3D1 to avoid kernel panic. */
>  	if (unlikely(is_global_init(task)))

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU data race on the per-CPU
send_signal_work structure later in bpf_send_signal_common()?

If a BPF program executing in a context with IRQs disabled calls
bpf_send_signal(), it evaluates irq_work_is_busy() as false. Before it
queues the work, an NMI could fire on the same CPU and also call
bpf_send_signal():

kernel/trace/bpf_trace.c:bpf_send_signal_common() {
        ...
	if (preempt_count() !=3D 0 || irqs_disabled()) {
                ...
		work =3D this_cpu_ptr(&send_signal_work);
		if (irq_work_is_busy(&work->irq_work))
			return -EBUSY;

                /* NMI fires here, calls bpf_send_signal_common(), evaluati=
ng
                 * irq_work_is_busy() as false since it's not queued yet.
                 * NMI writes its data and queues the work.
                 */

		work->task =3D get_task_struct(task);
		work->has_siginfo =3D siginfo =3D=3D &info;
		if (work->has_siginfo)
			copy_siginfo(&work->info, &info);
		work->sig =3D sig;
		work->type =3D type;
		irq_work_queue(&work->irq_work);
		return 0;
	}
        ...
}

Upon return from the NMI, the interrupted context resumes, overwrites
work->task with a new get_task_struct(), and fails to queue the work since
the NMI already queued it.

Could this allow NMI reentrancy to corrupt irq_work data and permanently le=
ak
a task_struct reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902150439.6927=
25-1-adi.sharma@zohomail.in?part=3D1
