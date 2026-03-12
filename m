Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B951A9FA0;
	Thu, 12 Mar 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318265; cv=none; b=oXCwf9BrCkF75cpJm4kkciSA1INF2BtLe4yW5kiM2b1NAdSpuhlDLsLfAb7LorQqmMNbfJUeCmrOK1wAovYCZpPQOcq1tKqQ1eOdfzdv6TC4kp3r/rZmH1u+PFtNWrpG0kobRQRptdKi6xhfnHK7HTVQdwt6NEVUtzdAImHd9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318265; c=relaxed/simple;
	bh=q1KUgPJEYeKAA8JfCgzmG89esT5vfxHS9kM5OHhn7bA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pv8rh/ddiCbjrnVsvQKVg5ISk+nux4D28bsy7ED5U0p5L/WGC+k1o9LgfXf/enJ++9aYGLIBg12z/ZnSIUvT6Eu8jVrXUbGRw08l5mB0OUi5PCGyFTT7cANRUqftD2L9yVFL2mhmdChMVoMR5UoaRVVyRaL66fxFaHQrqxyyg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkVonRi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkVonRi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D5DC4CEF7;
	Thu, 12 Mar 2026 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773318265;
	bh=q1KUgPJEYeKAA8JfCgzmG89esT5vfxHS9kM5OHhn7bA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KkVonRi+3ushxXeWb2KBnfBbggiJZ0swPa2cda2bGlkUPGbQTRKZHM3dbT9TilKC1
	 Oll5sZ7wbinIA5HNZdcHceMJ7FcRYC7Qi1XiZzCcczYIJVzMoE8oJP8hOqNUB8o2YT
	 SQSV275Wa5hMmKpRdSswJ158JXxMx3c9mVbGg5dyL8J7idsv+nju72v0R7Om2fZeLV
	 7+kpEecZRZ10VHj0eFt0WSPs2ByUOdlqESBqvnJ4PMmYkiTwuoCJWk3JU8hXOSe5b5
	 ZWW6+3zOxG5fgYs1G9jXTlWXL0ZnaK5iOzxWM9bW5x2RcR24+SkZk//SRhc9BR9SzD
	 Bowj6nSf5ODJQ==
Content-Type: multipart/mixed; boundary="===============5131685681796718081=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab12d6dc347ea5a2ffe8705e1538043beb0f497b4a906410a10fabeceeb10e70@mail.kernel.org>
In-Reply-To: <20260312114746.122174-1-jolsa@kernel.org>
References: <20260312114746.122174-1-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] ftrace: Use hash argument for tmp_ops in update_ftrace_direct_mod
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,ast@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Mar 2026 12:24:24 +0000 (UTC)

--===============5131685681796718081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8df69e702706..71dcbfeac86c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6608,7 +6608,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
>
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
> -	tmp_ops.func_hash = ops->func_hash;
> +	tmp_ops.func_hash->filter_hash = hash;

The comment above says "Enable the tmp_ops to have the same functions
as the direct ops", but after this change tmp_ops only gets the
modified subset via the hash argument, not all of the direct ops
functions.  Should the comment be updated to reflect this?

Also, the commit message has a minor grammar issue:

> which contains only the modified sites is always a subset of the
> ops->func_hash.

Reads like it is missing an "and" between "sites" and "is".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23000924618
--===============5131685681796718081==--
