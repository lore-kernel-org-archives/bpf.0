Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7F3164D8
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786897; cv=none; b=EOUAORGpIzyIXmt2Tl/A1WH+UbTK+QiA+8TBrhEJWjzVbTi87d+g9TdN3S5NKaf75EKHAfz4eESb9keMBD2kRCN+vkFnVFup1qCUfpf1Gs9lB1cRiW927lAqy/Jh5qLJMqrfs/QnCwcXX2IChqumGLjDnWCFousNrwSl8xPvqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786897; c=relaxed/simple;
	bh=SOLnaibhFt+NPOFoZU2G4t4xoMwbc/ktmzn+/mQaTM8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jTuscnmno/SI2+ypf64lSP3A0xwvi30nbhjBkmuHm1c5N4U9GQwCDeYnZZufid9O1AULk6T05DFmgtx+0iV9AZq++8PTGmH9m3nFcNa0ehOjdcCJqGC01JphyRqXzu7ULcjdS93lO5HDzePuYQ4/bCYe8Hj27s5sGSnywz/Mgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWxeiVK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWxeiVK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EE31F0089B;
	Mon, 12 Oct 2026 06:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791786895;
	bh=RTNS6wbNNvrbk/prn/Om3d8EmS8Lk8YEdQhB5wqlIH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWxeiVK9EKTJr6c3YyXoi2QEjSE0GbRlce0fsa7dnkOth93uXWznEPZXkCPB8SxYB
	 qSaOwNHlHNkPV+n7npl27mUBdY0Wo60ttHazH0spJ6Knc8X+gI/qjg6KCPI2+jaEln
	 cPOBm9o6lDEBdTl8E8ttO5SpqtCBCRogXMEJ001+xEcrtoxdvPRpAQJeHCC7zjHB69
	 PvOEGnS2qFPtqQHnyaK604QlCjnTIznjtZ5bHezmeMEMerIBkJUKvigD/gx0OPmSVm
	 fjv1Winn8B+/SHdx6P4RiEhUdgcW3gzUhkuyPBTUnC/9gbHWEBfoHWvDTAkCjYFTix
	 uIU/PsWmK880w==
Message-ID: <sashiko-outbox-167741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Prevent task work context reuse
 while irq_work is busy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012061915.231254-4-luyun_611@163.com>
References: <20261012061915.231254-1-luyun_611@163.com>
 <20261012061915.231254-4-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 06:34:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: UAF in task_work/timer callbacks due to async context re-init=
 on deleted map elements
--

commit 580f53f590a0a7077f231292b13de90213f646c5
Author: Yun Lu <luyun@kylinos.cn>

bpf: Prevent task work context reuse while irq_work is busy

This commit fixes a race condition where a task work context could return to
standby before its scheduling irq_work handler completes. It initializes the
irq_work during context creation and checks for the BUSY state before reusi=
ng
it to prevent overlapping invocations.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 028fc6796b597..350269b8646e4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4553,6 +4553,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetc=
h_ctx(struct bpf_task_work *t
>  	memset(ctx, 0, sizeof(*ctx));
>  	refcount_set(&ctx->refcnt, 1); /* map's own ref */
>  	ctx->state =3D BPF_TW_STANDBY;
> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> =20
>  	old_ctx =3D cmpxchg(&twk->ctx, NULL, ctx);

[Severity: High]
Can a newly allocated context be installed on a deleted map element here?

If a concurrent map deletion calls bpf_task_work_cancel_and_free(), it
synchronously clears the context:

bpf_task_work_cancel_and_free(struct bpf_task_work *tw) {
    ...
    ctx =3D xchg(&twk->ctx, NULL);
    ...
}

Since it doesn't leave a poison value, a concurrent BPF program running und=
er
RCU read lock that calls bpf_task_work_schedule() would see twk->ctx as NULL
and successfully cmpxchg the newly allocated context into the deleted eleme=
nt.

[ ... ]

> @@ -4644,7 +4657,6 @@ static int bpf_task_work_schedule(struct task_struc=
t *task, struct bpf_task_work
>  	ctx->map =3D map;
>  	ctx->map_val =3D (void *)tw - map->record->task_work_off;
>  	init_task_work(&ctx->work, bpf_task_work_callback);
> -	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
> =20
>  	irq_work_queue(&ctx->irq_work);
>  	return 0;

[Severity: High]
Could this lead to a use-after-free if the element was concurrently deleted?

If bpf_task_work_fetch_ctx() re-initializes a context on a deleted element =
as
described above, ctx->map_val captures a pointer to the element's memory:

bpf_task_work_schedule(...) {
    ...
    ctx->map_val =3D (void *)tw - map->record->task_work_off;
    ...
    irq_work_queue(&ctx->irq_work);
}

Since the deleted map element will be freed after the RCU grace period, but
the newly initialized asynchronous irq_work remains armed, could the later
execution of this callback access the freed element memory through
ctx->map_val?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012061915.2312=
54-1-luyun_611@163.com?part=3D3
