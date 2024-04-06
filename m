Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3915EA2;
	Sat,  6 Apr 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712374871; cv=none; b=f3UAeJ8lzd3hZgeeWCgTUE6NDsnq8GyyCprbDE2BRYpsQlw0jlSGwag1b80zgMCDpYSkjVoy17TdPlDeIJ/4m/mVo3+5/woxmC4DrMHixBP2aQUYGW7Y2z6nzqCDvqwfPHAIYTxFT7gSDiiyNszOG9HbzS/dFJWgf+rh4VHTh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712374871; c=relaxed/simple;
	bh=KE+dNIQdAyDvLBy+9sloH0zECC5/5h5S54aNwN3B358=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q9krds4Ksc4tKkPjbARoZcTsMSyY0Ks/CHrQuYGqtE6JN4PTTMRvtREib5XmJaUz4UcxlQjGt10hA6IpjifgSfpD8V6/LAlKTefu+EsVhHD206lMszf3sUFue3ruyZyj8YiKMxu3QxEwmDEAsw8V3beyMbNTZSbaLbtKm6EIqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btgwzwNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btgwzwNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4EC433C7;
	Sat,  6 Apr 2024 03:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712374870;
	bh=KE+dNIQdAyDvLBy+9sloH0zECC5/5h5S54aNwN3B358=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btgwzwNHXz5KIlx3SZpRB6t4t1FTd8vrzeFC9dF6jND52MPySxjHDMYb1mcLdaXqd
	 j/lBhurrw7xUc63vu/Vn18TvX9JHoscS2wh7DyqXjGeZRoKKp0/aOBhYvpiJL1m5Lg
	 g7ZSAf5DzHgaQOljJA9DNxsia0PbxwFBb9xoPWYlzccWr0j6x9FBVJO2BzZQm+Fnyl
	 r4pUUhMX4+kV5a4VfZcOUz53IYCbw/6miOAksS8nKavIo9fZ3rkZQuBPeV02WW4lTD
	 V3N6CYGShjtI/r/X/2UAQMKqvq9F+2bDs9G3Dpm/X8UwdD7FiYLxM33c7/4cwXgaTW
	 IWU7j1+Yzyaog==
Date: Sat, 6 Apr 2024 12:41:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-Id: <20240406124105.5a31c488b00c36432cc81446@kernel.org>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Apr 2024 22:21:00 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Apr 2, 2024 at 9:00 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 2, 2024 at 5:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 3 Apr 2024 09:40:48 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >
> > > > OK, for me, this last sentence is preferred for the help message. That explains
> > > > what this is for.
> > > >
> > > >         All callbacks that attach to the function tracing have some sort
> > > >         of protection against recursion. This option is only to verify that
> > > >　       ftrace (and other users of ftrace_test_recursion_trylock()) are not
> > > >         called outside of RCU, as if they are, it can cause a race.
> > > >         But it also has a noticeable overhead when enabled.
> >
> > Sounds good to me, I can add this to the description of the Kconfig option.
> >
> > > >
> > > > BTW, how much overhead does this introduce? and the race case a kernel crash?
> >
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

Thanks for checking the overhead! Hmm, it is considerable.

> > > > or just messed up the ftrace buffer?
> > >
> > > There's a hypothetical race where it can cause a use after free.

Hmm, so it might not lead a kernel crash but is better to enable with
other debugging options.

> > >
> > > That is, after you shutdown ftrace, you need to call synchronize_rcu_tasks(),
> > > which requires RCU to be watching. There's a theoretical case where that
> > > task calls the trampoline and misses the synchronization. Note, these
> > > locations are with preemption disabled, as rcu is always watching when
> > > preemption is enabled. Thus it would be extremely fast where as the
> > > synchronize_rcu_tasks() is rather slow.
> > >
> > > We also have synchronize_rcu_tasks_rude() which would actually keep the
> > > trace from happening, as it would schedule on each CPU forcing all CPUs to
> > > have RCU watching.
> > >
> > > I have never heard of this race being hit. I guess it could happen on a VM
> > > where a vCPU gets preempted at the right moment for a long time and the
> > > other CPUs synchronize.
> > >
> > > But like lockdep, where deadlocks can crash the kernel, we don't enable it
> > > for production.
> > >
> > > The overhead is another function call within the function tracer. I had
> > > numbers before, but I guess I could run tests again and get new numbers.
> > >
> >
> > I just noticed another rcu_is_watching() call, in rethook_try_get(),
> > which seems to be a similar and complementary validation check to the
> > one we are putting under CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING option
> > in this patch. It feels like both of them should be controlled by the
> > same settings. WDYT? Can I add CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> > guard around rcu_is_watching() check in rethook_try_get() as well?

Hmmm, no, I think it should not change the rethook side because rethook
can be used with kprobes without ftrace. If we can detect it is used from
the ftrace, we can skip it. (From this reason, I would like to remove
return probe from kprobes...)

Thank you,

> >
> >
> > > Thanks,
> > >
> > > -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
