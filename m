Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C791C5D57;
	Sun, 12 Oct 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760242176; cv=none; b=MgtdhRr4soJtA0l0eFiF0MRWrLDCd2epmjg7ANa2soNqTgiDVjWlDCB50EhDZwOHfvoRpJcYtENcGpYy1BWPA+qW/+wZoWPC+pBvN2qHASFosSMvlaHjNc96xR8zNZLb29jLr0PpRvREToJvn+n85lPORzHYsJrWtRN3yOgjZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760242176; c=relaxed/simple;
	bh=qMWOaQe4/4/LEPtsJwW9gN/vP+01yBs3M8Uq3QtcBJg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jD+yyiuPxMSxwiJiTvRmygLsbx2ttHzvP4TJoILfd0lhVr3ZZxMYfz13+pz5+12DgiCSpaJ7hOPaHq90FLfXqt2GtVnylfYwOQ66oFwTWihnOZkOOGZi14GG2LUIpWb9h9+dm/8yg7wsDvgZ6QZfcpFuHdDUXM+nH6qiUbJVv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzRFlosH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzRFlosH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A38C4CEE7;
	Sun, 12 Oct 2025 04:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760242175;
	bh=qMWOaQe4/4/LEPtsJwW9gN/vP+01yBs3M8Uq3QtcBJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzRFlosHj+vIoqrTgrsWSukmWlJYPUrE9jEy0bJHBV11N3x9euqPr/znG85p/BsU7
	 yPrfhgIaFsVHQlakgg/WE68eQQ0VLcenlwiP8TdEAJycrnwnRUn9vsOslWkUo1qo+7
	 E+3BIF0KDcxG8q6X/UmPco7wH0uhx6WsTbPcmcW9hJGistaF2bZtQrzHqoNxY7bz9Q
	 Ifb69bvErc00nFEcHNBsbV+MpZGLtEepfdrcqftcOX6mMSgarACZfQVORWZVK30hPl
	 W04hMCmguLfFilAoNu9fH0AxvijMKV1At8lBIWEjKm7SZjqyxZTNa1dQbc/jeFbJ8V
	 RhnmOJbZzM9WQ==
Date: Sun, 12 Oct 2025 13:09:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrii
 Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-Id: <20251012130931.f2ffee08b23b6c1b17dc7af5@kernel.org>
In-Reply-To: <aObSyt3qOnS_BMcy@krava>
References: <aObSyt3qOnS_BMcy@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 23:08:26 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
> (which means on top of return fprobe) on x86.
> 
> I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
> stops on return_to_handler, because the stack and the function itself are not
> adjusted for unwind_recover_ret_addr call
> 
> If it's any help I pushed the bpf/selftest for that in here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=stacktrace_test
> 
> just execute:
>   # test_progs -t stacktrace_map/kretprobe_multi

Hmm, curious. as far as we are using fgraph, stacktrace should work.
May this happen if function-graph tracer is enabled too?

Thank you,

> 
> thanks,
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
