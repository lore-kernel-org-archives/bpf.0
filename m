Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A592931FB;
	Thu, 13 Aug 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628905; cv=none; b=n+vVfveUyM2QU42P44N7KANiYYT5nLn4fXluQq48WQ0vlRTKPYYD/hbm59ANuH7/GBbD1jeb6aSPV95Mi/IrTlwmtjAyLnNsj3hxgzGrrQZ9Y1B1ZZJHAjE8peGOYIbGgLegvzd5kcndntyjpYv3c/dXs9huzZ4ljdVOnmh6IIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628905; c=relaxed/simple;
	bh=tc+0er2U1DLU+at2eGrqYfG5BUhQlSMtehkhlcxxBzA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VcSjLPvKoPUDH7t0q7Bu2r+a0HzhJCmHH+W14guL1UyHjPw9wAuQA7y6ahTRBeJSK2Lr9/tZrB3xtBEy3rZ7M2CaaflQymthk6EbtetHiNg8JYZzKd+MBDEFLvumRDeyN/yHw2BdAbTR05ygZn8Nei7uOr3OY4NokS+UkOJlQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgoYWo/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgoYWo/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F931F000E9;
	Thu, 13 Aug 2026 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628903;
	bh=B0jeCG32tnGw9NMO5PftY637Zp6I2ih3emRAjg65r4U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SgoYWo/HXGIr7g58qxaXhUcqJT8Y4or8FZ3DYnhwoas/BEr1IR1FiFBmYcpDZKQU/
	 8sq4DnMGeDwmePz7lfWxFFLeTqi5Na/uHeGkErHXCFppZO7tEihDhy+W1eM6Y7YL3J
	 8dP3gDpekT6k+rTSW/JqNJCqwIhOHEq4lURXAlNnAJb0KyLTqp1yFZPg1G8+31nrzC
	 meTd+2cOXXubcb1DgOYExPriYMzt8YMURqeC8y7EgY/9BvBCWTX+cTqhF8UirUHa9B
	 2AzUY0/5iT8pYG6rmUni4S6XSvAre3hu8OlrgdK2XvyJKyzD+4CvYTxmhFOBI96Z0i
	 iPeSizbtmGI+Q==
Content-Type: multipart/mixed; boundary="===============1870217146028247937=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4399f187b740ad845694474891fa8063ec2fcfb4b3a6da4595e6b6dabfed5bb3@mail.kernel.org>
In-Reply-To: <20260813120250.796934-4-sh_def@163.com>
References: <20260813120250.796934-4-sh_def@163.com>
Subject: Re: [PATCH bpf] bpf: fix percpu map update indexing with sparse CPU IDs
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@google.com,haoluo@google.com,jolsa@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,sh_def@163.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 13:48:22 +0000 (UTC)

--===============1870217146028247937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 3563498ad027820b11bad3993a5c6a17d293ad23
> Author: Hui Su <sh_def@163.com>
>
>     bpf: fix percpu map update indexing with sparse CPU IDs
>
>     Per-CPU array, hash, and cgroup storage map updates without BPF_F_CPU
>     or BPF_F_ALL_CPUS use a value buffer whose per-CPU slots are packed in
>     possible-CPU order. The buffer is sized as:
>
>       round_up(value_size, 8) * num_possible_cpus()
>
>     The update paths iterate over possible CPUs, but use the logical CPU ID
>     to calculate the source offset:
>
>       value + size * cpu
>
>     This only works when possible CPU IDs are contiguous starting at zero.
>
>     For example, with a possible CPU mask of 0,2-3, the buffer contains
>     three slots corresponding to CPUs 0, 2, and 3. CPU2 is therefore
>     expected to use slot 1 and CPU3 slot 2. Instead, the current code uses
>     slots 2 and 3 respectively, causing incorrect per-CPU values and an
>     out-of-bounds read from the update buffer for CPU3.
>
>     The corresponding lookup paths already use a dense offset while
>     iterating over possible CPUs. Do the same for the array, hash, and
>     cgroup storage update paths, advancing the source offset once for each
>     possible CPU. BPF_F_ALL_CPUS continues to use the same value for every
>     CPU.
>
>     Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")

The Fixes: tag points to 8eb76cb03f0f, which introduced the 'value +
size * cpu' pattern in bpf_percpu_array_update() (kernel/bpf/arraymap.c).
That attribution is correct for the arraymap.c fix.

However, at commit 8eb76cb03f0f, kernel/bpf/hashtab.c and
kernel/bpf/local_storage.c still used the correct 'off += size' pattern
and did not have the 'size * cpu' bug yet. The hashtab.c and
local_storage.c bugs were introduced later in the same BPF_F_CPU feature
series.

Should this commit include additional Fixes: tags for the commits that
introduced the bug in hashtab.c and local_storage.c? This would ensure
that backporting tools pick up all three fixes even when the percpu_array
commit is not present in a given stable tree.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31703563365
--===============1870217146028247937==--
