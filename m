Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7951DFCE;
	Wed,  3 Apr 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152297; cv=none; b=W28tdk9X7Yv6pGHNMFa1W5PQeKu7zZdEGXcT+PGv4JbRvRYWOfEoFQx9MiG+wUEjGsHHl+HU+fcrS8K1yCDaq1JJjKxs/np0CD4lHuLdUsO278s4oYHV09gjS1hEYGGNe7lEopaUsqX0wwj3Kr2qC3CZXMXp//gytwGsVhPKIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152297; c=relaxed/simple;
	bh=adB+gCRzpwfKmKZt8hDBaLfbB7JeLd5QVEHPOWq6fE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArGIKCHcyqk5Bi40dxOReP/5gbv4Anh/ZmWGbVd+KvFRdhWlQ/Py7WHU7gdqHoBOz6DYo4mNPNwyjHkUWq4jNUtoIfdbqtrDHAjsID0DqbN3S6kuiJdGdldCoHzHmO+4/wqtjAOjiWvTMxXUojMvz6ILTgc1bRBFXodukXJrPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC838C433C7;
	Wed,  3 Apr 2024 13:51:35 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:53:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240403095355.1a0e53dc@gandalf.local.home>
In-Reply-To: <CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
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
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 21:00:19 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I just noticed another rcu_is_watching() call, in rethook_try_get(),
> which seems to be a similar and complementary validation check to the
> one we are putting under CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING option
> in this patch. It feels like both of them should be controlled by the
> same settings. WDYT? Can I add CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> guard around rcu_is_watching() check in rethook_try_get() as well?

That is totally up to Masami. It may have even less overhead as I'm not
sure how many times that gets called, and there may be more work to do than
with function tracing.

-- Steve
