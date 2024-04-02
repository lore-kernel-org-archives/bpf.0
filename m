Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626A10E4;
	Tue,  2 Apr 2024 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712018324; cv=none; b=PLwYlggYzqDeqnYptvHBOqhFAkoFud848/IDICT6C5BivW7XABkk4hWgzMOZK4vVCxNDWNcFeENBa71kX2q7ATX/tH2OYaivqPu30qMV7md3bKIH2JuxrRObu0sUqAwnE6RglDB9cAIy3gRitYJf1PEUXxXnsDEAseeKNZEmVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712018324; c=relaxed/simple;
	bh=lneP+EUgNiEaeomVK5I/yhgrIivXWWwKe9x1rE3ckwM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b+zs1JMionEmGKKXjwgikHFxc6jFBnxmHH6noN8ViJBMQTDdUYy+oO5IaHWpVNlAKqJC8NwfIjzbJOL49yL23VXQw7l11N71oOSHTOtvonlPhAy0cK9XaBTHYBFPzQ6GE9vLIQoqZ9hcUEfkI1W7tDTMoB4SFieiqAO/AMnydts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHCpNX7u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHCpNX7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B572AC433F1;
	Tue,  2 Apr 2024 00:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712018323;
	bh=lneP+EUgNiEaeomVK5I/yhgrIivXWWwKe9x1rE3ckwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHCpNX7u6xNgv26mUcLYsggkdwDt5n/Ipqsg2dNkbcWFVncZ7hxqckUTYhrSJon2y
	 4cDtiL5z4/ZaEnyXV/6SMvji/GQax7Rc/AIe1ebmfUmtfndW71eCBKeZqoOGc9zHeI
	 hyCWan126m1+pUMRPxE5IvF79Sueb2kngVAjODGuHt/SOLtNHmEtA4Od3J9zesaHxU
	 RRJNnKCVUlFza+SNrSiIgQhvgBl+pSaFipfza5kKA34PwSSvM5nh6C4a19lk0r4S2e
	 ukxFzL/c7WAUVB3fwfM8htFsixr+/dwSI+axr+UEdldv7mqfLcX0iXltkD3TfIVKPO
	 TlnXMD3N0JSpQ==
Date: Tue, 2 Apr 2024 09:38:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-Id: <20240402093839.7de89341138748f743ae896d@kernel.org>
In-Reply-To: <20240401120918.67cc3191@gandalf.local.home>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
	<20240326150121.68e9db8a@gandalf.local.home>
	<20240401202552.470d845bd79c841b9158fb56@kernel.org>
	<20240401120918.67cc3191@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 12:09:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Apr 2024 20:25:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Masami,
> > > 
> > > Are you OK with just keeping it set to N.  
> > 
> > OK, if it is only for the debugging, I'm OK to set N this.
> > 
> > > 
> > > We could have other options like PROVE_LOCKING enable it.  
> > 
> > Agreed (but it should say this is a debug option)
> 
> It does say "Validate" which to me is a debug option. What would you
> suggest?

I think the help message should have "This is for debugging ftrace."

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
