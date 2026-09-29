Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7123CB550
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644486; cv=none; b=Dk0HH+D65caGeI1HCLBO89DMKPcKV21EwAa4UU93mY18xYqAD96uEsTzLCKAxXoUF3CpgD6Kph8ptR/zawn3HHcxp9JW+sS0G+wQ7Ddm6lJtkmqp4ck2TZgA4DZRqo+5UbRo7dXmEmDmr+ia7bByBrBX7RI4g6UTndxnumJZqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644486; c=relaxed/simple;
	bh=tmJhfgin6wi3+LWghsBUaz1RkFcoYkTp7tO/vGvQbpM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hy3tiv0nZKbtGQlAm3S097yvlZ1qhvCraU/3AqhYhMy6LC5v21fBWHhiH9he6l3aBuis8IVWfdgPIcTo4iR+smcV67+8FTVUvrqeia4MlJV0cmcN7MqbOHF+UJWQMRw7IozWvk7lS5LZUCZVysDq5iT0A835UEpFO5pB9tWaDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3GRQSHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3GRQSHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9591F00893;
	Tue, 29 Sep 2026 01:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644484;
	bh=C8ag7Iahtmk69zd5ycSLRiE0GQgCgK6wWtpe9jJW69M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l3GRQSHlIY1rCPr1W6TdR72RZZCWPHxKcBzer8+CFkA0e1UfyBTa+jWtoTtT4Asp3
	 1cYbjakgLZRwUmfg4Ln3AdFJ/s2MjBcPr8SJ5kLob0Ma9Ol+8qo/2Mz5T8ZZgxeULU
	 JqGWFVA2YP23cgl4zFtTJLKJpen6+QEi1Pz+S6zyAPh+ZwKMuOPT4ytCfv7GU6Obbr
	 QEfX2g92Tu0rcmsj4YqeYeBtVuMLT6BVfOO2lZxF9gU/3K3CqwdrehjYH2oeanrg6K
	 8bG4nhrMzls/8MpAzIg0KezJIMjlXcyHo0HWcG2Y6VT92u8EijYLOlu8Nb8Ivxv+DB
	 6/ce1Q8Sif7qQ==
Content-Type: multipart/mixed; boundary="===============7917287845577210380=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97e6da4cbbd16c8938762c0c0cb2044b1ff910eb53cb6ed54864b46773c65eb7@mail.kernel.org>
In-Reply-To: <20260929001658.3251019-1-yonghong.song@linux.dev>
References: <20260929001658.3251019-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 11/22] bpf: Dispatch cleanup pads by rewriting return addresses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 01:14:44 +0000 (UTC)

--===============7917287845577210380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5b7fe4ba610b..bff9d2539371 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <linux/bitmap.h>

This isn't a bug, but is <linux/bitmap.h> needed? No bitmap API appears
in the file.

[ ... ]

> @@ -1286,6 +1309,61 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
>  	return 0;
>  }
>
> +static int exc_info_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
> +				u32 subprog, u32 start, u32 end)
> +{
> +	struct bpf_cleanup_info *recs;
> +	u32 i, cnt = 0;
> +	int err;
> +
> +	if (!env->cleanup_info_cnt)
> +		return 0;
> +
> +	err = bpf_exc_alloc_info(sub->aux);
> +	if (err)
> +		return err;
> +
> +	for (i = start; i < end; i++) {
> +		if (env->insn_aux_data[i].cleanup_pad)
> +			cnt++;
> +	}
> +	if (!cnt)
> +		return 0;
> +
> +	recs = kvmalloc_array(cnt, sizeof(*recs), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	if (!recs)
> +		return -ENOMEM;
> +
> +	for (i = start, cnt = 0; i < end; i++) {
> +		u32 pad = env->insn_aux_data[i].cleanup_pad;
> +
> +		if (!pad)
> +			continue;
> +		pad--;
> +		if (verifier_bug_if(pad < start || pad >= end, env,
> +				    "insn %u is covered by a landing pad at %u outside its subprog [%u, %u)",
> +				    i, pad, start, end)) {
> +			kvfree(recs);
> +			return -EFAULT;
> +		}
> +		recs[cnt].begin_off = i - start;
> +		recs[cnt].end_off = i - start + 1;
> +		recs[cnt].landing_pad_off = pad - start;
> +		cnt++;
> +	}
> +	err = bpf_exc_attach_info(sub->aux, recs, cnt);
> +	if (err)
> +		return err;
> +	return 0;
> +}

This isn't a bug, but is the subprog parameter meant to be used? The
function body uses only start and end, yet both callers pass a value for
it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============7917287845577210380==--
