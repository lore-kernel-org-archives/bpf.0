Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478EB284663
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325337; cv=none; b=f25z4z6t5qk//c2I7JLcxosL+t6W+AUdgFOMrsqwsO7BPZPS2AvFEI7Tzmjb7XMe4r4tP9ITb69pWjR9K3W1znUGsJeu5NdSLTay1U8hgvqnJeOZwEp8SvaH69cNDwj5XHSQX7Kgv7oClAjEvl9bu3pJbH/peZ+Hx6ELXe8uNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325337; c=relaxed/simple;
	bh=d+v55sKR4Jhob+esMNWGCOTFzVZNaufgx2ZTqO3/dtY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KXU9N5nYs7is6z1xXqrcF9IQf5AjE41af7uLyhceWCU0RU/TeD8kS9iO5ZWiNMy8ACrP6GtUmngsBGy2aaiGhD+g2DohMamXWUUKoEZahEKT0h54resM/JjiTmwMDPcDS1IgfyGOrjJiWsgWpYnli/p11zJl7ACv1oVdy2QbAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FomtMRwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FomtMRwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78BC4CEF7;
	Thu,  5 Feb 2026 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325337;
	bh=d+v55sKR4Jhob+esMNWGCOTFzVZNaufgx2ZTqO3/dtY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FomtMRwzc/faWwFMlwjnOqo7j7cDysy1Q7aRJ9ECM1g9Trki8krxDoBuYDcXELaNr
	 DwuNvPRQ2Bkrj0jZ6J8SQnDzkC5zuRQGn5DHQFhIJPZ1Y8BEPGiPq7oMAQOruh1kFq
	 X0uTMITiicJl7Xvg4Zx2UcW4ZwnRHJyuHBiFqgtuVFZNRkv9y35d4bGDnrFd9VWlt0
	 vUi4TKpKqM8XyFGo2QHJQAxdVw+I5BMxmvvVkRD977ZEprI2NpOGnLZnPwriewFpS/
	 NBjzvDIIRiJT9wqbSpONLckBWYsk2omr98fQtGDRHcjB0B2TVO2lhb1uDHKu3DG2F6
	 GPzWit+DynzeA==
Content-Type: multipart/mixed; boundary="===============2950903815006592312=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba412e9adeb84693d7339ae98f5ca73fb8d09c4079cdc92ad9918364c4bbd950@mail.kernel.org>
In-Reply-To: <20260205-rhash-v1-3-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-3-30dd6d63c462@meta.com>
Subject: Re: [PATCH RFC bpf-next 03/12] bpf: Implement batch ops and BPF iterator for resizable hashtab
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,memxor@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 21:02:16 +0000 (UTC)

--===============2950903815006592312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 917f8f7d7..142e5cf3b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +	for (; slot < tbl->size; slot++) {
> +		u32 bucket_start = total;
> +
> +		rht_for_each_rcu(he, tbl, slot) {
> +			/*
> +			 * If buffer is full mid-bucket, undo this partial bucket
> +			 * so next call retries it. I this is the first bucket return -ENOSPC
                                            ^

This isn't a bug, but there's a typo: "I this" should be "If this".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21727734472

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel development practices with technically accurate descriptions and proper code patterns consistent with human kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: A minor typo in a comment does not affect functionality or system stability.

--===============2950903815006592312==--
