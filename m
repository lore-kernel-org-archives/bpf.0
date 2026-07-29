Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C2396D09
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360774; cv=none; b=cIxNdd8+ST0lyMkzM3SJRiVvjtd+tBRLGr9DxT2BGWPtiEGqLU2XX1M21aezTnCwVnoJ1/EhWyNOw0ms+Yvszf6oQx5LrlGbXkDbsEtxwlj9sHkAFF4cEaSqfoz3bdXEBrPfRvtI0E3jdlRJ2NEF6N5aMpDo/Cbo/ve4xj4vfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360774; c=relaxed/simple;
	bh=IxtD7ymO5tEAWU6dIA6Y9MvnE1CHBrUlK5vl9VV1Zas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fTh7UltfHu6wcaivC4s7/Sy7zk28Et3xehm0By7PHAMkxn1kZ4u5UIz/qhJ9/MoQ1QBpJX0+tpFzFrUDIM77jwL3ugYpCcERLGvON7GvOJNC/OZNdQL0DK/WTuEzUTc3qJu+DAAC7rulzqPsCIXe7whCyHv3LD+XHYxjqiCfqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpOsYJWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpOsYJWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0B21F000E9;
	Wed, 29 Jul 2026 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360767;
	bh=KlnDbO92qOCe2XbqSQMW6Dp87uAV0EdcWfM5NTpnLIk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TpOsYJWOuSlEZCDDzeMzxsYfTDCECU4K6MSfHbF7oR4KK33AhAK2j/nNmEJ4G3v57
	 V2zAiAhJKoE/ndXKexzH1RIq/0ZqTV3HhvZ2AOESEjPPhll+Vlt2cX+c7qCxUORcA2
	 x0QyiC9jwfVma642o7KwtT5DteJaU/NucJDjLJCW/F3W8dXwFidqBSPX98dNcqRNwx
	 FEGKMrpjECTU1mQ9SHQcEZ1F6vkOueakgiZXLObyoTWXQ4qhFJog8bqwi8LKH73ncy
	 3QzyE/Q/jP8DtRnOrliejeRj7d1Czvd3acJdD00DMGcQ4PuPbg7F6Tg0Pzf2gGLa2x
	 /3HgTk7piWfVw==
Content-Type: multipart/mixed; boundary="===============2869136105008744688=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1e00928e88dbed4351a92d557de4c85f8a6cb870abc5c4d0b97a08377ccc734@mail.kernel.org>
In-Reply-To: <20260729203633.213973-2-puranjay@kernel.org>
References: <20260729203633.213973-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Correct the overflow check comment in bpf_iter_num_next()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 21:32:46 +0000 (UTC)

--===============2869136105008744688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f5eaeb2493d4..f190f2b25004 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -802,12 +802,14 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
>  {
>  	struct bpf_iter_num_kern *s = (void *)it;
>
> -	/* check failed initialization or if we are done (same behavior);
> -	 * need to be careful about overflow, so convert to s64 for checks,
> -	 * e.g., if s->cur == s->end == INT_MAX, we can't just do
> -	 * s->cur + 1 >= s->end
> +	/* Detect the end of the range, or a failed/empty iterator: all of these
> +	 * leave s->cur + 1 >= s->end. bpf_iter_num_new() set s->cur to start - 1
> +	 * (which wraps to INT_MAX when start == INT_MIN), so the s->cur + 1 below
> +	 * is a deliberate 32-bit wraparound that recovers start. As s->cur and
> +	 * s->end are int, this is an ordinary signed 32-bit compare, exactly what
> +	 * the inlined bpf_iter_num_next() emits.
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Does this comment reference code that does not exist yet? Grepping the tree
at de0af07e8966 for 'inline_bpf_iter_num' returns nothing, and
kernel/bpf/verifier.c only references bpf_iter_num_next via BTF_ID and
is_bpf_iter_num_api_kfunc - bookkeeping for the KF_ITER_NEXT kfunc, not an
open-coded instruction sequence.

The inlining is added three commits later in this series:
4bb5d9c0aa96 ("bpf: Inline bpf_iter_num_next() kfunc"), which introduces
inline_bpf_iter_num_next() in kernel/bpf/verifier.c. So the comment added by
this patch is a forward reference to code that does not exist yet, in a patch
whose entire stated purpose is to make the comment "describe what actually
happens".

Could the patch either drop that clause, or be reordered after 4bb5d9c0aa96
so the reference resolves?

>  	 */
> -	if ((s64)(s->cur + 1) >= s->end) {
> +	if (s->cur + 1 >= s->end) {
>  		s->cur = s->end = 0;
>  		return NULL;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30490674177
--===============2869136105008744688==--
