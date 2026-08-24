Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25737DE9F;
	Mon, 24 Aug 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593683; cv=none; b=W3zOoYa/n7IammoawvCscJtJ7jwMHNLYtnQkZwTAi7J/fnPZhgOAIc99bE8Q+BKitN6b9At7H5C3SWmAPlf3exJ8nDmDDqh3O2lGGqeOydG+BU/TNFmFguw/dNyX6nUpd2P/3NqBgWLevvyaAfQc1JoeuuhdlzI5mc/wpWbUsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593683; c=relaxed/simple;
	bh=MA2iCFEyPkdh+yzaBvC6zwbFy81sydJkr6qA3u+YZe4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OiKKRAYhEXXQ85KbOVBgp451Vi4BVse6KlJ0iqR9zSiMASgVw3oDdIJSRp0AJYJ5kXo6/KrrgXtqr1Ci2nJKblohLGnDvXcsRar0YEIpxD7eszZCz7gV7dKnZwFWRCNi/zfYSGiqQnrc74Ra0TCwcpKPCub43LV88UfiyL5W5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4ZT1B0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4ZT1B0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C441D1F000E9;
	Mon, 24 Aug 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787593682;
	bh=b/xdr/qme74FpvcM1g3FfvJ3E8QcYucU34yMxF+3Jaw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f4ZT1B0OXHMs1pQ5+isFBAE0XfjlZBWwtphCq/TFupvThafF/ntVG65II+q1cQ/Ak
	 ecZMEuJ/KCBQ7kYwTd2Tal7r8HJXWq6JZzc9LRvjqgZEZJq5K6vefKBc4ddVJtTQrl
	 +FyI/cpWPwYRPQIHDyONCFVy8u/rt21KrUqHoaLt7LxGgbuL+w4XH/AsZuU308kW2t
	 26Ca1NZl/u7PuygT1k3wtF6w3SCp58yPsR7CAYGKT6/nhE/YFtNZ+0AnGvRpvY0w+Y
	 t+5Nl19dXiQB6TzicNewdgSgH/9AfRBYDfSXAQCWx9eFkVwWUiRU10Oy3yK1nP9mLP
	 CNOw3pjm/PZtA==
Content-Type: multipart/mixed; boundary="===============5444775642773542466=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <812c7dce29c7faba7596961a4db56703bbb8ecf1ca5b05b30bfeda0f3ca15de0@mail.kernel.org>
In-Reply-To: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
References: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
Subject: Re: [PATCH] bpf: arena: reschedule while freeing the arena pages
From: bot+bpf-ci@kernel.org
To: leitao@debian.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,brho@google.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,leitao@debian.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 17:48:01 +0000 (UTC)

--===============5444775642773542466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: arena: reschedule while freeing the arena pages
>
> On non-preemptible kernels that is long enough to trip both the RCU
> stall detector and the softlockup watchdog. Observed on production arm64
> hosts at Meta:
>
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu:     37-....: (20999 ticks this GP) idle=3834/1/0x4000000000000000
>   Workqueue: events_unbound bpf_map_free_deferred
>   Call trace:
>    __apply_to_page_range+0x404/0x518
>    apply_to_existing_page_range+0x18/0x28
>    arena_map_free+0x54/0x98
>    bpf_map_free_deferred+0x70/0xf8
>    process_scheduled_works+0x17c/0x400
>    worker_thread+0x198/0x498
>   [...]
>   watchdog: BUG: soft lockup - CPU#37 stuck for 44s! [kworker/u288:15]
>   Kernel panic - not syncing: softlockup: hung tasks
>
> arena_map_free() sweeps the whole 4GiB arena address range in a single
> apply_to_existing_page_range() call and drops every populated page from
> the walk callback.
>
> Give up the CPU after releasing each page, using cond_resched().

This isn't a bug, but the opening sentence "On non-preemptible kernels
that is long enough ..." uses "that" without an antecedent.  The phrase
that explains what takes long enough (the 4GiB arena sweep) appears two
paragraphs later, after the stall trace.

Would moving the arena_map_free() description ahead of the stall trace
make the flow clearer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32755827346
--===============5444775642773542466==--
