Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844A10A1E;
	Wed,  3 Apr 2024 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105562; cv=none; b=V7YMJ93Su067Ak2bdixPpw/UKje1SBjPmSNxlBgaIdkKH1kBcKwwM599pIfXCZthX1Ml8J/dUUmjBFPAfSLoYsZsrtvUkJRspLqtrbUv2R/nl0zgDnkg4HbzOIi3ykux7gQC6cQhxF4/lsUfk1lCjOGuzYt7bmWjqq2spE4bRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105562; c=relaxed/simple;
	bh=8M6L6hcpWLSzyiiIUmAkI6djRWlQL2uf6SPBgFwotws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTIqEAaEHDUNGN/11VQNeiI4w3A+Ln+n532sA0KlntV7nFWDDK+3zyk1kMYSKRoZlVZ+xxlAheO/XrUE82+W/pRRTR7ML9lpBfIunD6lLE5DkYn4zId/TgYKKo9yFRAEjYxms9pwGnbHGby7NcYnwgcr/pHKClclPXUsaSh47LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC3CC43399;
	Wed,  3 Apr 2024 00:52:40 +0000 (UTC)
Date: Tue, 2 Apr 2024 20:54:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240402205459.297c4206@gandalf.local.home>
In-Reply-To: <20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
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
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024 09:40:48 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> OK, for me, this last sentence is preferred for the help message. That ex=
plains
> what this is for.=20
>=20
> 	  All callbacks that attach to the function tracing have some sort
> 	  of protection against recursion. This option is only to verify that
> 	=E3=80=80ftrace (and other users of ftrace_test_recursion_trylock()) are=
 not
> 	  called outside of RCU, as if they are, it can cause a race.
> 	  But it also has a noticeable overhead when enabled.
>=20
> BTW, how much overhead does this introduce? and the race case a kernel cr=
ash?
> or just messed up the ftrace buffer?

There's a hypothetical race where it can cause a use after free.

That is, after you shutdown ftrace, you need to call synchronize_rcu_tasks(=
),
which requires RCU to be watching. There's a theoretical case where that
task calls the trampoline and misses the synchronization. Note, these
locations are with preemption disabled, as rcu is always watching when
preemption is enabled. Thus it would be extremely fast where as the
synchronize_rcu_tasks() is rather slow.

We also have synchronize_rcu_tasks_rude() which would actually keep the
trace from happening, as it would schedule on each CPU forcing all CPUs to
have RCU watching.

I have never heard of this race being hit. I guess it could happen on a VM
where a vCPU gets preempted at the right moment for a long time and the
other CPUs synchronize.

But like lockdep, where deadlocks can crash the kernel, we don't enable it
for production.

The overhead is another function call within the function tracer. I had
numbers before, but I guess I could run tests again and get new numbers.

Thanks,

-- Steve
