Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5988242D88
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588337; cv=none; b=kj3MFcYSswI0gF+0/diBGVC/cbOSzSB6CzuztrB7GIuSj0W/mf98DcyiXApCHMYCEhpTMwn4jURF5PoBu1u+8HHBS/+Zio1xylL8xzmNMowe19uQyFnkRb5/gmFWFoco/fqVeLsLkjR2TN9kWCV9U66zqyuuiiiDkN5V2LMOX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588337; c=relaxed/simple;
	bh=3NznmWAIP/h/S3Hwneo6QSwDphHy2AWJmo03DNAXZtE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H2w4NcioAUI7hkevYgf7u03U3GoWJHlP3uZ7nxG/pFvDhc2Ez1dGEnxzs5qVa86xSOlXEKgf6Pp6hIeqWqRRWNOHLnUMrdYKeAAwQFPOMetUbeJV2XSarz/256Y9tPhdJRdeNrZTs++60pD4tGdjHcNgfveU60M9qE2FuoGuotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZE9e5bL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZE9e5bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63271F00A3D;
	Sat,  5 Sep 2026 06:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788588336;
	bh=yeQz3rDDIrjvldzTnM9zWTml2flrm61t033YbSGgKwE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mZE9e5bLWXfyvPbszoxiVvTRd3H3aDh4ECzy0jj5/oEgZd0g3LMokq2ktsgIcFu47
	 GJOGfRK7DDrTldeypA9jtvi5vwFnH13xWrFuYrQhJJ+N4vRDRiZ0EvVwptT6HU/P+h
	 H5OLoy/hfOWG8xgBADaIQm6XQzVfBMAOl2JuEMGe1e+Nu3eYrUJPZA+G36Mb5c6tJJ
	 BFyqdt3jzMnazY3B/SOPyzdo4yDeFm0VDTJcRVG+SdG/Pt6BcFMkn3IxSkacOE0qMn
	 05g1IS3Agd9ZoFW4tJ82Xj7gMXSmxa1/dI4B0u29CrDZheYwsLF1Iw9nmeyIpiv2P5
	 K/h5MBiOTeiWA==
Content-Type: multipart/mixed; boundary="===============7608499846173838796=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca61e14795fa8c6d9346ecda25d4ab7fb994a6071284b3ab51b85e47d21a7f04@mail.kernel.org>
In-Reply-To: <20260905051224.2325381-3-memxor@gmail.com>
References: <20260905051224.2325381-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test global subprog callback contexts
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 06:05:35 +0000 (UTC)

--===============7608499846173838796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> index 6bf95550a024..987ca9dec6b7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c

[ ... ]

> +__noinline int wq_global_acquire(void)
> +{
> +	struct task_struct *task, *acquired;
> +	struct wq_elem *val;
> +	int key = 0;
> +
> +	val = bpf_map_lookup_elem(&wq_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	task = val->task;
> +	if (!task)
> +		return 0;
> +
> +	acquired = bpf_task_acquire(task);
> +	if (acquired)
> +		bpf_task_release(acquired);
> +	return 0;
> +}

[ ... ]

> +/* Task work tests */

[ ... ]

> +static int task_work_global_rcu_cb(struct bpf_map *map, void *key, void *value)
> +{
> +	return wq_global_acquire();
> +}
                  ^^^

This isn't a bug, but since wq_global_acquire() is now shared between
the workqueue and task-work test sections, would a neutral name like
global_acquire() read better than the wq_ prefix here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33947189666
--===============7608499846173838796==--
