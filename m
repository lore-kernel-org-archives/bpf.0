Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C3D26D;
	Mon,  1 Apr 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970757; cv=none; b=OEWqSj+twhEUONAlEoVuVYIDZHU2FfD+AKps9LoU2eywzCr2QsRd2SprD/4VoQ1d7RO5+ZUQ0DNBTwtXGDJr5f7W3VctoPqdyW1BXX3V162Qls+ZwDOWjGrZMDanb02ZyXm9Mk3BK+RTbbn8BwyoMtS2vPDfgdwD1vmH3eTd5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970757; c=relaxed/simple;
	bh=soL5GP59Hivwt9LMbJNYlwL7wJckl7uPqtNfuPXBBK8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tiJGbJnKrnMWzH6B3gAHsEPKrUKCeMQ1w2r5R1OnoPxEUjFHGN4//v8th9RThp0hLy7qtBlP6f4CySGxJ4o0Vh/kkCGIZ/WYaMA33v5O1xa8D90y/w5dmZOLYfq5x26LAnkm22l+FXSittHDAUJrGc5YAoZOGqBNalIQXo3FMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxgviBOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxgviBOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1913C433F1;
	Mon,  1 Apr 2024 11:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711970757;
	bh=soL5GP59Hivwt9LMbJNYlwL7wJckl7uPqtNfuPXBBK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxgviBOnlq5q6rQlRSwByIhO7qB8q+SRJuY6VADCvHu6XbBcHq9iszEp7KfZAN+Lu
	 D1nH2TJGJwCmJ4HEg+5qjKGrNNEHieR85yXgeKcXV0pxcuj2F9wDUqZKTbbc70jqJJ
	 /3ilk08aw4Oh75WdjgrsFCiadIJOPsyC/a2jKdcyHxdLaoTlMtJYJj10k/xMicI4KF
	 LRUzI8ux+aWcSwSAm+JBQAGSxP0bCzU3H1rCVa4hQWpbpXERwUybEHDRikuC2kx3w3
	 XEZbT9bR6P9sJiagZBQ7AA0Q6Llp7q9pB0slVmfx14CfpygfY5PKAMuSiw1nV9Y3vf
	 IQtINp6V/h4mQ==
Date: Mon, 1 Apr 2024 20:25:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-Id: <20240401202552.470d845bd79c841b9158fb56@kernel.org>
In-Reply-To: <20240326150121.68e9db8a@gandalf.local.home>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
	<20240326150121.68e9db8a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 15:01:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Mar 2024 09:16:33 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > > It's no different than lockdep. Test boxes should have it enabled, but
> > > there's no reason to have this enabled in a production system.
> > >  
> > 
> > I tend to agree with Steven here (which is why I sent this patch as it
> > is), but I'm happy to do it as an opt-out, if Masami insists. Please
> > do let me know if I need to send v2 or this one is actually the one
> > we'll end up using. Thanks!
> 
> Masami,
> 
> Are you OK with just keeping it set to N.

OK, if it is only for the debugging, I'm OK to set N this.

> 
> We could have other options like PROVE_LOCKING enable it.

Agreed (but it should say this is a debug option)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
