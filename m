Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13327B357;
	Thu, 29 Jan 2026 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647790; cv=none; b=WssJE/n0RZaYpLOxauwtKyAuaWu0DPjtY43xpyWshFD3OjMeqxWfnTmJJqaNtGo+GKdXn/syYsOjey6IhKACpx3DolFOY8cJxz+Cs1N3+cI2yWWSKqm62zSDQURbOwWBOHhYSbr6hgjx2nyeYvs7a133fKF0oG6yWE9k24JExgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647790; c=relaxed/simple;
	bh=WN/4Wr9P50tM0mA4R7iX2P5i86rDQL/HPokHp26+QV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQszZlAzmIXAIJc2UIHfTMbJ5AkrEa6jT4tPG8toJECTMGhJ/dyZfQC0fOaHJHWm2LXOU/Uiw9sIDobq8Gex3h+Rm/XbZSCRYUf+dq74bPMcvNlzYz4qT1TuYvNt+Ldou4+swUN+iTEqjJg4Ru1azSM6GrdytwVOLcSHIXyOumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 16836BA3C3;
	Thu, 29 Jan 2026 00:49:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B919F60009;
	Thu, 29 Jan 2026 00:49:44 +0000 (UTC)
Date: Wed, 28 Jan 2026 19:49:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii
 Nakryiko <andrii@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/6] x86/fgraph: Fix return_to_handler
 regs.rsp value
Message-ID: <20260128194954.571477b6@gandalf.local.home>
In-Reply-To: <20260126211837.472802-2-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
	<20260126211837.472802-2-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ehhni4b8powk3mispn1qnzkascgcg98y
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B919F60009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183/qJHRN/3JOF+vtZyDebdKCU4LRVxQ0A=
X-HE-Tag: 1769647784-824431
X-HE-Meta: U2FsdGVkX187lKsxZMMKDpJXkv/fDgl8jQIzSQmMoUMTRuX4/A4u7nj8OIi5tA4Y9oWx2xxzQFkYEJY2UvvMhfiN3cnOLmjctMeSBSLlByxahVdZ/m80cDVU1w7SiQjPkT/+DgsHHbS+TQK60JTiMY17qMBGMK2vLfd5uZwp2OoEIzvx/Gub7f54pBKes6C2D3kUTLvXJoGZ9qWGb+ozqL3f0HDVd7V5DFEdWrgAp/4tW6BpsUP2OuI8NVbN4gEx9HMWW+017cvnFOLc5r8G/hFUCRSwOToZGY8Q/XO74r8nPL8uVVOIvRx/d+oXZWSckcY1ub2fFBrCC8y64cp+XczqWUOgU6GyJICea8pT9Y4ExxTmyY1HP4Vy12TbEbMaRayc4kMAb24zCqX/wMbkWg==

On Mon, 26 Jan 2026 22:18:32 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> The previous change (Fixes commit) messed up the rsp register value,
> which is wrong because it's already adjusted with FRAME_SIZE, we need
> the original rsp value.
> 
> This change does not affect fprobe current kernel unwind, the !perf_hw_regs
> path perf_callchain_kernel:
> 
>         if (perf_hw_regs(regs)) {
>                 if (perf_callchain_store(entry, regs->ip))
>                         return;
>                 unwind_start(&state, current, regs, NULL);
>         } else {
>                 unwind_start(&state, current, NULL, (void *)regs->sp);
>         }
> 
> which uses pt_regs.sp as first_frame boundary (FRAME_SIZE shift makes
> no difference, unwind stil stops at the right frame).
> 
> This change fixes the other path when we want to unwind directly from
> pt_regs sp/fp/ip state, which is coming in following change.
> 
> Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

(it passed all my tests too)

-- Steve
