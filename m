Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C65418A2D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142006; cv=none; b=P3iX/8FO62LPGh/jLmNRhQv9Gw+rtDFmuJEDrVqMxUk83VNFg5wyFCxV3u6RjPMl/3mwmSonnuv9FfiznBijOrl2t9qSZtJNl18w56gE8559IAk56E4KOMz+JCrmepC8uy7Ei160rBS6lERUjk8Dm/GhY/PQz4nStxYrnt1MluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142006; c=relaxed/simple;
	bh=jhXrTPU8sDLqpOo9ZKks6kO+K5x922eHHOBHVPsbQc4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AiHWRrBV4Hu6BnzBRzzUZtACZ92Cuf6c9bIZT6hHTxax8EWS+eCLWDo4uF/AjktFfguYvX7+mJYy0QwuXHti2Wt339cYBovkCgODQZnxoyoGzKOTwXM8msTXhZL31OEae4vcpIkQj/BjOlGksIClm8cHswrTGw78IvG8fpp5Gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkeJ8+SU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkeJ8+SU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB91F000FF;
	Wed, 23 Sep 2026 05:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142005;
	bh=28swQJdpehUPZUQuaGZWKbqU05q6xm2g0iBN5m3WaR4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DkeJ8+SUgz4eaW+HROAA7TjqO9RXm5TFzHI9iiK0E5uuHzSGx0ExLPhMOv5py+pIH
	 zJq3TFbrXwrv2IW9Q37E2yzdlFkXUNFQQ1AoiWfqZgCT7HI2YPhJOVPyvF9JiklDoT
	 7rVVhqVxpLepZLlf1LGmmyr1X+1dY8Ey8mFqc+MO7P7VrVrjRhwpZkprnQGHyW05K2
	 lK+Hhd9r+m2mqiEq2pBk82uKaBJyE5BTMD1p1yC2C6IXZIxQPBMEwqrJeLtmEhp46p
	 VvoWEi8FDtQm4dzKCHx2Z8eJj+isBhtIIBmIMVQBVQWK6rthrzvLChg1Aip09tGbQl
	 ybZezhkcGxeEA==
Content-Type: multipart/mixed; boundary="===============2575504848220219232=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d402f4c07248cdf4b9c2ea9878467d6084f3ecf38f022e84e6dc68ccdc38c63@mail.kernel.org>
In-Reply-To: <20260923045912.2417059-1-yonghong.song@linux.dev>
References: <20260923045912.2417059-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 05/21] bpf: Prepare for an exception cleanup table before the CFG walk
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:40:03 +0000 (UTC)

--===============2575504848220219232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Record in insn_aux_data what the later passes need from the cleanup table:
> throw_call for every bpf_throw() and resume_call for every
> bpf_unwind_resume() -- the two calls a JIT lowers its own way rather than
> as calls -- and cleanup_pad, the landing pad a frame resumes at, for every
> call within the [begin_off, end_off) range of a cleanup record. Subsequent
> commits consume all three.

This isn't a bug, but would it help to say "for every call that can
unwind -- a BPF-to-BPF call or bpf_throw()" here, so the changelog
matches the filter in mark_call_sites()? The code marks only
bpf_pseudo_call() and bpf_is_throw_kfunc() inside the range, skipping
helper and kfunc calls that cannot unwind.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 666c73308b32..e12ec91b8150 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -692,6 +692,8 @@ struct bpf_insn_aux_data {
>  	 */
>  	u64 fastcall_spills_num:3;
>  	u64 arg_prog:4;
> +	u64 throw_call:1; /* call to bpf_throw() */
> +	u64 resume_call:1; /* call to bpf_unwind_resume() */
>
>  	/* below flags are initialized once */
>  	u64 jmp_point:1;

This isn't a bug, but would these two bits sit more naturally below the
"initialized once" comment, next to cleanup_pad which the same pass
fills in? Both throw_call and resume_call are set exactly once by
bpf_prepare_cleanup_exceptions() before any verification pass.

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index e3459123803c..fed5b66ed3b7 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -256,6 +256,12 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  			data[i].non_stack_access =
>  				data[off + cnt - 1].non_stack_access;
>  			data[off + cnt - 1].non_stack_access = false;
> +			data[i].throw_call =
> +				data[off + cnt - 1].throw_call;
> +			data[off + cnt - 1].throw_call = false;
> +			data[i].resume_call =
> +				data[off + cnt - 1].resume_call;
> +			data[off + cnt - 1].resume_call = false;
>  			data[i].cleanup_pad = data[off + cnt - 1].cleanup_pad;
>  			data[off + cnt - 1].cleanup_pad = 0;
>  		} else if (bpf_is_mem_insn(insn + i)) {

This isn't a bug, but could these two assignments be single lines like
the cleanup_pad one just below them? Unwrapped, they are 76 and 78
columns including the three tabs, so they fit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============2575504848220219232==--
