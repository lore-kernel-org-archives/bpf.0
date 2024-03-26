Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8113C69D;
	Tue, 26 Mar 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479523; cv=none; b=Mf6fu8G8KDYsQycXsNx7VWKM4TjHgQl9zeFPWrlSsVTwVbqK4kRmmQjnXq1p7hr3Ij9MXq1abqiHFeM1NeNRrPIYVC66fzphqwlOGh8fZzxhk0kqebyobi1VdfxFYuKnnCcIb6L3HIRoMJEac/d0swjJVm/GUOrgBNvJix16J9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479523; c=relaxed/simple;
	bh=Z6put3ozQKzBb6IVG6osIr8cUR3+OEjGyp2LWbqB8zY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDGnFnnDX5Us/uKXNji3DJ/i7ms33xEjg8SfdtXrPVG+yK5YPz7Dt2R2A/Re5B2XjF4zEE//HlsQeTxrdtfMakxqERBqe+FwqoJBJHtj71IPCsD4ddAIKjLBtKx/f5yJb09f0T6Nfe9zJR1L0yQ0HQEHBWUHcCCCNWUTGRK39j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D63C433F1;
	Tue, 26 Mar 2024 18:58:42 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:01:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240326150121.68e9db8a@gandalf.local.home>
In-Reply-To: <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 09:16:33 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > It's no different than lockdep. Test boxes should have it enabled, but
> > there's no reason to have this enabled in a production system.
> >  
> 
> I tend to agree with Steven here (which is why I sent this patch as it
> is), but I'm happy to do it as an opt-out, if Masami insists. Please
> do let me know if I need to send v2 or this one is actually the one
> we'll end up using. Thanks!

Masami,

Are you OK with just keeping it set to N.

We could have other options like PROVE_LOCKING enable it.

-- Steve
