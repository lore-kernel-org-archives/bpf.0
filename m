Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA3376A0A;
	Tue, 22 Sep 2026 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041639; cv=none; b=e0MlGclwlCcItcwA/A7GVvLruCtVI/eUXnx0YLQWUFBjIyOp7X0XZQ/yH1YotYp5dD03SD23gFL+MEx7cXYicEO3a0/rnhlf2kz/Kj9zgxefTM1OWLeuBCo9l+FjsNmeEvtSXa2qkUpLY07Ag+To8Npx3gr2L19yoeJxwBEWbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041639; c=relaxed/simple;
	bh=YFAg422pWxW7OjUvz67N2fPJFZzDc7i4ZKyEceKlyYc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SEaLQ8j3cloGobF8Dsat7DMrDEwOONPKIgUD0kF+EJGTkRVdT4Kxv1gbrtJb7wYH73BMIY404mGLV9BvxtrS2SIHfVKxp4czXYS7N7tdv1lcom++qOgUdGoPiHKkoWqD6H8ayJSc3P/2Ynw6snWVHzn9f5nG+eYFKxQ/XpZLlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET5Jz6ar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET5Jz6ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6881F000FF;
	Tue, 22 Sep 2026 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041638;
	bh=6lQ5VT382pQFa0L/ps6gHw/HtNuRKYXdDo2NozPF2rU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ET5Jz6arUfGQR6WEAxlxRECWRR5jzVATpnszyvUVC//JLq2wjtKibnawYzsGggaza
	 uyLY2w06tpz4A3NnmtpY6T8yTCcFU2E2IXdFgYCZaF6hOM2tQTnEDm7QqdgPLhNtPi
	 eGCWWcnbjhI+OLKpjmyeG8z9rifwaNPye7+19JihtH32OeBmximfYSLlmpdx/J8EBo
	 oYdXFsZFDkDx8e04H37gLXWDKZz0xq0IlYbUe0SMwqWyWhpQ5MVzSC9o+Juj6kHsNS
	 ipmZkN/lUhyX9ieh2aMjjp/IRg76YC7SmrbwGReLAMuo+wyeflFRyA+Fv6dVgvwF9a
	 XY7rfrGknZpNQ==
Content-Type: multipart/mixed; boundary="===============6710158663061288279=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e8b758af3e2561b6b9d60b87866a3545432da526326c1ba303845f9cb1188b7@mail.kernel.org>
In-Reply-To: <20260922010333.1226537-3-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 2/6] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,emil@etsalapatis.com,npc@anthropic.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 01:47:16 +0000 (UTC)

--===============6710158663061288279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
>
> bpf_user_ringbuf_drain() peeks a sample, initialises a struct
> bpf_dynptr_kern on its own stack, passes it to the callback, and calls
> __bpf_user_ringbuf_sample_release() as soon as the callback returns.
> Neither the descriptor nor the sample it describes is valid afterwards.
> set_user_ringbuf_callback_state() only gives the callback's R1 a type.
> The callback can therefore store the CONST_PTR_TO_DYNPTR register into
> callback_ctx, which points into a frame that outlives the call, and the
> program can use it after the drain returns. Three routes reach past the
> callback:
>   - the register itself, spillable since v7.3-rc1, which points at a
>     descriptor on reused kernel stack and gives the program an arbitrary
>     kernel read/write
>   - a bpf_dynptr_data() or bpf_dynptr_slice() result, which carries
>     the dynptr's id as its parent_id
>   - a bpf_dynptr_clone(), which is a by-value copy in the caller's
>     frame and can be sliced after the drain returns
> Declare R1 frame-scoped so all three are invalidated when the callback
> frame is popped.
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This isn't a bug, but should this include a Fixes: tag? The commit fixes a
security vulnerability (arbitrary kernel read/write via use-after-free).

  Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35674974944
--===============6710158663061288279==--
