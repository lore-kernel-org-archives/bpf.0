Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F1146D65;
	Wed,  3 Apr 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152364; cv=none; b=pTu402+XKkUd8fkiystqX0vQqDKsw0PrwncwpTGCVQHNyrFMpDH/VOzovtsTBs7vjFcP47Yh5Swfsiik7AD/4PRrnqe4I4s/UnZXgHPt9QY5VUSnaXMVOBLXOxDQiR33Pc7eCu/yxU8DTLrhRDsMZGs1wtXLpCeret+cyhF4gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152364; c=relaxed/simple;
	bh=mWBQPwG/E/872K2TDojgKs320pnEhF3QCpFeen/aKYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck8WduJtEWlJLwLO63PpNnry0OHTsklr7OOKP/6OgJILoshzjXjkMA36XLErO64nYp5u8soFtMVGVz4JkSTKduAHOvFqM+DR/v5PqjbFt48zM8pqy080HUJvtBFNdt5uDRp/2f7pWr6XM53iiUbWMudQ+LwU0Mh+/mWQZzMqu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C85C433C7;
	Wed,  3 Apr 2024 13:52:42 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:55:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240403095502.664e5ef9@gandalf.local.home>
In-Reply-To: <CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
	<20240326150121.68e9db8a@gandalf.local.home>
	<20240401202552.470d845bd79c841b9158fb56@kernel.org>
	<20240401120918.67cc3191@gandalf.local.home>
	<20240402093839.7de89341138748f743ae896d@kernel.org>
	<CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
	<20240401224733.7a9bcbb6@gandalf.local.home>
	<20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
	<20240402205459.297c4206@gandalf.local.home>
	<CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
	<CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 22:21:00 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > I just checked our fleet-wide production data for the last 24 hours.
> > Within the kprobe/kretprobe code path (ftrace_trampoline and
> > everything called from it), rcu_is_watching (both calls, see below)
> > cause 0.484% CPU cycles usage, which isn't nothing. So definitely we'd
> > prefer to be able to avoid that in production use cases.
> >  
> 
> I just ran synthetic microbenchmark testing multi-kretprobe
> throughput. We get (in millions of BPF kretprobe-multi program
> invocations per second):
>   - 5.568M/s as baseline;
>   - 5.679M/s with changes in this patch (+2% throughput improvement);
>   - 5.808M/s with disabling rcu_is_watching in rethook_try_get()
> (+2.3% more vs just one of rcu_is_watching, and +4.3% vs baseline).
> 
> It's definitely noticeable.

Ah, thanks for verifying (I should have read the thread before replying to
the previous email).

-- Steve
