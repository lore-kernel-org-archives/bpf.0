Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405872;
	b=ZhY8/vgDWEg9ZbOfotliu5YVgO2nHxJwWL1AfFX/YUQdKmWjuEYcCdjOgv8lRs0khtOd
	 gThtoAUBl5Dx3UhH7/BE17ktnlx8zG/0SrPa7hoGkUwi6VFrEdYhiGFSWpvKckV1qLKmR
	 3HmrTv0ay7aAhG3Lc/Ie1ih3ViUkZG2fYzOO7hQSHdKP6FxRB/MsEdWjx/gA/NDT7N6QY
	 dJ1BVo4tj/rmXXm9JzzlVPnFa09xaLs2uAetxRpbXKC+jBM6Cn+Al0mlVYivq0YJTbM+V
	 CLGP1GhhxLPrkWf55FRflF9XjFZ5IKx5dJ9Fj4/OmzIVzDCsLGfWBFsbZ43lHl9WaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405872;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=n4Wfp0vkxckNyYWRJ5Ps60ZfoU1fg0Bu+EAZW7zpy3U=;
	b=S1g43tfKvCDDh7PSUBpPJCUmxXK/gxfzdIExpO+datNJWRR7QV0muUqBkFJMxCsBXAyi
	 AHHeyrDwcDSwlLYwyqUNfZ9ciDdD4K3wXBTwC3nC5EV2KiATt+5p3tv2gj73ALUrU3i/o
	 0BoojJQIrYi9tBtqolikAiXlAcPcXzwu/AcS9A4+ZK/dVKifo8yCmZnSyw4P4rdVYTM6e
	 N92CRPOPxWiU+MkvlTarfpcYKnjnBNeZ7KogP1lje64zEI2glVQHay51ZZRmRRjuoJd7q
	 QMEW9HCoNwzJaEnFAaymSZtpS6Um6teur+0TidZ9eeDLg4OWbhYC8Kpx8xkpY8Dh27w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWZc0OJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F6606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWZc0OJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023EB1F00A05;
	Wed, 11 Nov 2026 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405871;
	bh=n4Wfp0vkxckNyYWRJ5Ps60ZfoU1fg0Bu+EAZW7zpy3U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DWZc0OJ9e65Miren1Rg5lb0NbPwoXv2hSItMxv7j1pxbiclGA/MAKVgg9eBpmVfPe
	 cAY64ZqDJyeYo9IeUO44buoNu36BOFJUMzgFK4fbEG7Q3IPV5jCTlh9BiFcbUjX4J/
	 hFA2r3GCzN4UO1qWrPHRUlbE+7wSznc6aww2AkYQLK97M5RM5+2/2r33iIRH3pzvK/
	 NJ02YyxZxokrwVLemyns4FsSiY1pjJSGV34qJtgbxu8LZErbQeVISE/V0x2+BQ/fW3
	 r/+ZliYZw34Sf7xc1BUfz2yeqT4j4Ph6pOunbJF3skCXOCiqNysa449ky2rz+zVJZO
	 jZtrLTr9CnCDg==
Content-Type: multipart/mixed; boundary="===============3258431509059997710=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <814f5f6551e7b5860adfc34176256bbd8ca6b31b79cf564027613b9a886e7a1e@mail.kernel.org>
In-Reply-To: <0847523e18df54ccf22c46885001d309841a60c2.1794399387.git.memxor@gmail.com>
References: <0847523e18df54ccf22c46885001d309841a60c2.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 21/29] bpf: Support callx when a callee releases resources
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:30 +0000 (UTC)

--===============3258431509059997710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Support callx when a callee releases resources

TL;DR: Comment and commit message only: the stated reason a subprog releasing
nothing of its callers' leaves everything with the caller (not verified in
their context) looks inaccurate; the code itself seems correct.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +/*
> + * The callx at insn @callsite of the current frame calls @subprog, one of the
> + * subprogs it may call. What the frame puts in front of the callx runs
> + * whichever it calls: the insns that take what it hands over out of its slot,
> + * and the one that empties the slot of what a callee releases without being
> + * handed it, see foreign_cleared(). So note what this subprog leaves with the
> + * frame:
> + *
> + *  - What the frame holds and passes it in an argument that it does not
> + *    release through. Another subprog may be handed it in that argument, and
> + *    the slot would be emptied for this one as well, see slot_can_be_kept().
> + *  - All that the frame holds, when the subprog releases nothing of its
> + *    callers'. It is not verified in their context then, so its return has
> + *    no frame to say so, see bpf_frame_desc_record_exit().
> + */

This isn't a bug, but is the reason given for the second item accurate?  The
comment above, and the commit message ("Such a subprog is not verified in
the context of its callers, so its return does not report that the caller
still holds the resource"), say a subprog that releases nothing of its
callers' is not verified in their context.

func_is_on_its_own() only looks at sub->releases_inherited to send such a
subprog to the caller's context.  It still returns false, and
check_static_func_call() goes through setup_func_entry() and verifies the
callee in the caller's context, for several cases: changes_pkt_data,
has_tail_call, has_ld_abs, is_cb, speculative state,
in_rbtree_lock_required_cb(), more than BPF_ID_MAP_SIZE/2 refs, a live
PTR_TO_STACK or CONST_PTR_TO_DYNPTR argument, and arg_needs_caller().

The real reason its return reports nothing seems to be the early return in
bpf_frame_desc_record_exit():

    if (!st->curframe || !env->subprog_info[frame->subprogno].releases_inherited)
            return 0;

The code looks correct, since bpf_frame_desc_record_callx() sets held_after
whenever !sub->releases_inherited however the subprog is verified.  Could the
comment and the commit message say something like "its return does not say
so, since bpf_frame_desc_record_exit() looks only at subprogs that release
their callers' resources"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============3258431509059997710==--
