Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E138C2D4;
	Mon,  6 Apr 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497599; cv=none; b=MWfC5X4NfnKmaoxyO7ECjrNHu8eL4j90uKaM0gAtrd1dbY+VJqMcSYoGK7tatX57sgkRTD/kN4OwrBEjbrINdaANoLwHYbLiA0uRLJ8s/aPLmvwgiaf+BIRszOP4y5hFvhp9YIU93mJIW4oKY+3i4FBYRe6V3FthEUtrIA5wNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497599; c=relaxed/simple;
	bh=2nT4mGzN7n3Nf4h56Eeem75Ob+ND2GSUH/4J4K7fD4A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LOY1P0NJpiEzTVZuiPehi8UqYa/4fxfnVfFCv4ezn+5FQiCOJuH1lq/FdDE21FetJBsj+DlhUdOvGpcHpekLXQ3xMJNWKOO4MnFpYn8RpUjV7hrjgCl1hscnvAdUI5/uo+lFJfndXYilNihfeZo/ckKb/gYk6OHPSTPTYvxon4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU0hei6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU0hei6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015A8C4AF09;
	Mon,  6 Apr 2026 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497599;
	bh=2nT4mGzN7n3Nf4h56Eeem75Ob+ND2GSUH/4J4K7fD4A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nU0hei6Aq9b1KCJCrslxeuW8O3ly3yQTvbVQozgHtRIjN6mk4SrKNSr0Yus+QdC6P
	 9hPVq8Yna4J55TvHFpUzufX98SmqhFPmY4/Y6xv5cqNowVNPiUWNUD2k3jufMp9h/f
	 EqlePVTK/oIC4RfzwtqirhG3ISUgNapgqDxX5hw/Gmg+cI1UvXActxwjW8xM5tis19
	 jBDA8t8B09mNbefpTmnL+PLcowT2rjw1mf0WeL7hKoVhCqPS3JR2AAbPYI2nzLlYKD
	 V7YU2RPjnwhVLWPVudLPzrQkjxod9ARWP77BxklhVJF6deYm5LTF6ywoAdJzPq4koS
	 lGlB4rXzmXWtQ==
Content-Type: multipart/mixed; boundary="===============3510127449096227261=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <66afc2dda110c4c9b33fc99696e36b67db15793eb77290c85d860abf5f2ea455@mail.kernel.org>
In-Reply-To: <20260406171226.13325-1-adithalex29@gmail.com>
References: <20260406171226.13325-1-adithalex29@gmail.com>
Subject: Re: [PATCH] [RFC PATCH] bpf/xdp: propagate queue_index via xdp_frame for cpumap
From: bot+bpf-ci@kernel.org
To: adithalex29@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,linux-kernel@vger.kernel.org,adithalex29@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Apr 2026 17:46:38 +0000 (UTC)

--===============3510127449096227261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..11aecf84a896 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> @@ -392,6 +394,7 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>  	xdp->data = frame->data;
>  	xdp->data_end = frame->data + frame->len;
>  	xdp->data_meta = frame->data - frame->metasize;
> +	xdp->rxq->queue_index = frame->queue_index;
>  	xdp->frame_sz = frame->frame_sz;
>  	xdp->flags = frame->flags;
>  }

This new line dereferences xdp->rxq, but several callers of
xdp_convert_frame_to_buff() do not set xdp->rxq before calling it.

In veth_xdp_rcv_one():

    struct veth_xdp_buff vxbuf;
    struct xdp_buff *xdp = &vxbuf.xdp;

    xdp_convert_frame_to_buff(frame, xdp);   /* rxq is garbage here */
    xdp->rxq = &rq->xdp_rxq;                /* set too late */

In dev_map_bpf_prog_run():

    struct xdp_buff xdp;

    xdp_convert_frame_to_buff(xdpf, &xdp);   /* rxq is garbage here */
    xdp.txq = &txq;
    xdp.rxq = &rxq;                          /* set too late */

In bond_xdp_xmit():

    struct xdp_buff xdp;

    xdp_convert_frame_to_buff(frame, &xdp);   /* rxq is garbage here */
    /* rxq is never set */

In all three cases, xdp_buff is stack-allocated without initialization,
so xdp->rxq contains whatever was on the stack.  Writing to
xdp->rxq->queue_index then corrupts an arbitrary kernel address.

Would it be better to move the queue_index restore out of
xdp_convert_frame_to_buff() and into the callers that actually need it
(i.e. cpu_map_bpf_prog_run_xdp), or alternatively update all callers
to set xdp->rxq before calling this function?

> @@ -419,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  	xdp_frame->len  = xdp->data_end - xdp->data;
>  	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>  	xdp_frame->metasize = metasize;
> +	xdp_frame->queue_index = xdp->rxq->queue_index;
>  	xdp_frame->frame_sz = xdp->frame_sz;
>  	xdp_frame->flags = xdp->flags;

Same concern here: xdp_update_frame_from_buff() now also dereferences
xdp->rxq.  While callers that reach this point after surviving the
xdp_convert_frame_to_buff() crash would have rxq set by then, this
creates a hidden precondition that xdp->rxq must be valid, which was
not previously required by either function.

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f05..448da572de9a 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = xdpf->queue_index;
>
>  		xdp_convert_frame_to_buff(xdpf, &xdp);

This is the one caller where xdp.rxq is set before calling
xdp_convert_frame_to_buff(), so it works correctly here.  However, the
explicit rxq.queue_index assignment above is now redundant with the
assignment inside xdp_convert_frame_to_buff().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84699a428077..83566d2f446e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19098,12 +19098,16 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>  	int i;
>
>  	for (i = 0; i < env->insn_array_map_cnt; i++) {
> -		/*
> -		 * TODO (when needed): collect only jump tables, not static keys
> -		 * or maps for indirect calls
> -		 */
>  		map = env->insn_array_maps[i];
>
> +		/* Only consider instruction array maps with multiple entries.
> +		 * These correspond to jump tables. Skip others (e.g. static keys,
> +		 * indirect call maps).
> +		 */
> +		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY ||
> +		    map->max_entries <= 1)
> +			continue;
> +

This change to jt_from_subprog() appears unrelated to the xdp
queue_index propagation described in the commit message.  Was this
intended to be part of this patch, or should it be a separate commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24042390210
--===============3510127449096227261==--
