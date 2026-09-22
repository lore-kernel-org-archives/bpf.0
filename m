Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11484A499F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109437; cv=none; b=bGVHfFqXRDKahJ0dArj5c6AajuueNJdcRedmvarzRQ4a7010qqwOz0kFAXqE3kFo9eW7CLzVegGCnLVrWYrP51lLQfjxSNIYzpGo2CtNYvMqO3Rf1/i8+WQwzAP7wKO19uDtQbi3mxU7S00VYMTlFBqF1/1+XnbDdBTltwk9wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109437; c=relaxed/simple;
	bh=20ce1/CUhbkitTu5qo/P6EY1ORWu+aWrQeJa526N8HY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPBi3ChDAYFbtEM3r0laJzV/yALoQIf1ORv3XJpENAQ8M/VZ6tj27vJBJBOp0W6Velfh/c5k2xLa1nWRrU8KzsREx5Qd5ltK3HvAFbw7XtgVG/ajX+esrFuD66htZeF+sHqvzr8zUCvSJzN1mHZX8MmHhY7Zyj5pFS2SrcDoego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSp+HgE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSp+HgE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE921F0089E;
	Tue, 22 Sep 2026 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109422;
	bh=CcAYbTlOTQ15ZHJYwAQOLikE+/1YplNAelW0QXHCHWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSp+HgE/Oghha5Vn4ofT4ojR8NQVSLxGunVtVFjnyBAPZXVY3zFZuJlUOju/BymYf
	 bzQLgcXARJT7ywKkcZoFl5RDbjPkRM4NdR2dper0LN+pPu+OnhM1JPKgQZ9+WLaNFT
	 g+v+RwDX9AHEvuP6mO1iH01Qh49IFW1FaTBooJw8yGQJsJJ0hRRYInI0B9Ot4XesTH
	 IuKFN9UqAS/HVvNFu2MyDbm9T20DJqIS3L3T6RZBX3n/WrmEPhO0Bhoi0G38ojwO7g
	 HOzCjJD1J0YJCWCen4utWwOpLB652MqjXWkh2qbibFIt8rqmGWkRNbe4oZ2trlpiDU
	 /7JG5T5G78vog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/4] bpf: Add bpf_call_rcu_tasks_trace()
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922200208.3203834-4-puranjay@kernel.org>
References: <20260922200208.3203834-1-puranjay@kernel.org>
 <20260922200208.3203834-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:37:02 +0000
Message-Id: <20260922203702.BAE921F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_call_rcu_tasks_trace() deadlock from NMI context
--

commit 47fa2f5e11782172e769349f78bd62857f9572eb
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu_tasks_trace() kfunc

This commit introduces the bpf_call_rcu_tasks_trace() kfunc to allow
sleepable BPF programs to safely defer reclaim using a tasks trace RCU
grace period. It shares verifier plumbing and struct bpf_rcu_head with
bpf_call_rcu(), differing only in the queueing call.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head =
*rh, void *map__const_map,
[ ... ]
> -	rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> +	rhk->callback_fn =3D (bpf_callback_t)callback;
>  	rhk->map =3D map;
>  	rhk->prog =3D prog;
> -	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> +	if (trace)
> +		call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);
> +	else
> +		call_rcu(&rhk->rcu, bpf_rcu_run_callback);
>  	return 0;
>  }

[Severity: High]
Can this sequence lead to a kernel deadlock if called from NMI context?

If a BPF tracing program executing in NMI context (or with IRQs disabled)
calls the bpf_call_rcu_tasks_trace() kfunc, it will unconditionally invoke
call_rcu_tasks_trace(), which is a wrapper for call_srcu().

Since call_srcu() requires acquiring a raw_spinlock_t (sdp->lock), if the
NMI interrupted a task on the same CPU that was already holding this
spinlock, the NMI handler will spin indefinitely attempting to acquire it.

Should this code defer call_rcu_tasks_trace() via irq_work_queue if
irqs_disabled() is true, similar to how it is handled in
bpf_async_refcount_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922200208.3203=
834-1-puranjay@kernel.org?part=3D3
