Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B117C8;
	Wed,  3 Apr 2024 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104854; cv=none; b=UZcyyjNmdHg7hkIMi+Xy5QJk9dln7R8pzkiEZ7Pgfax8f4WoFlNXPjiGDLmmkY9xrg8SrVRCGQD6uz1o3D3bZvtG3GlgawMQLCePmH5pQh2/17KT0AGcy1H3R4TpY7qrHdkNDoD0CbcRk4a41gUnytHYu/RoIGJ+ECjGsQar4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104854; c=relaxed/simple;
	bh=z25WTNFGlSINEp3/ATKJXLSzog3c/MLWasaZ1Z1Ohqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K+HTIzZWk/pVnAoD4vDbqErvdAAAF8XeeK4pV6goNXCJaawxQaxFl83CdtkhDhPNtqwZRziLzK2MvgdkXJwSN8zYOHqAyC+fR6dSGSgX/VfH+67LvDrM5WROgp3BGyjBDemalTyQ0p2PCMtX/TCtAk20Ya2klc54ObaMUbobfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/3B0GhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/3B0GhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F53C433F1;
	Wed,  3 Apr 2024 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712104853;
	bh=z25WTNFGlSINEp3/ATKJXLSzog3c/MLWasaZ1Z1Ohqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/3B0GhFDqZD8Vk1KjExD9V2zaLK+XBa/dkSHP122TDQzAo8f+fEPYLMcUr7x3p+g
	 SOLws31tM94hGfvI6PRnhg74TPNTbzNKobtjRzAcirQzyvgsgvxiFMplkMnDfQOBYF
	 9S0g4JMr+Y5dtUF672Tw4EamN9vp7ILF67lzxEkJBIZOSsn+hoO8LjPKO1w60N/NNZ
	 tslqpjjBgT8io1fI8zH1rkVSXA5P7zsfohlJZFBvv1XsFM837z8lr+nh/1BB1bDgH+
	 40MB1Ob9NII6xoDc62LycNE3mBY+bF4xa6HQDzJZAUptDGV4z0Ekd3h36CHse0yHhW
	 YOhifF2wvb/ig==
Date: Wed, 3 Apr 2024 09:40:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-Id: <20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
In-Reply-To: <20240401224733.7a9bcbb6@gandalf.local.home>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 1 Apr 2024 22:47:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Apr 2024 19:29:46 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > On Mon, Apr 1, 2024 at 5:38 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Mon, 1 Apr 2024 12:09:18 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >  
> > > > On Mon, 1 Apr 2024 20:25:52 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >  
> > > > > > Masami,
> > > > > >
> > > > > > Are you OK with just keeping it set to N.  
> > > > >
> > > > > OK, if it is only for the debugging, I'm OK to set N this.
> > > > >  
> > > > > >
> > > > > > We could have other options like PROVE_LOCKING enable it.  
> > > > >
> > > > > Agreed (but it should say this is a debug option)  
> > > >
> > > > It does say "Validate" which to me is a debug option. What would you
> > > > suggest?  
> > >
> > > I think the help message should have "This is for debugging ftrace."
> > >  
> > 
> > Sent v2 with adjusted wording, thanks!
> 
> You may want to wait till Masami and I agree ;-)
> 
> Masami,
> 
> But it isn't really for "debugging", it's for validating. That is, it
> doesn't give us any information to debug ftrace. It only validates if it is
> executed properly. In other words, I never want to be asked "How can I use
> this option to debug ftrace?"
> 
> For example, we also have:
> 
>   "Verify ring buffer time stamp deltas"
> 
> that makes sure the time stamps of the ring buffer are not buggy.
> 
> And there's:
> 
>   "Verify compile time sorting of ftrace functions"
> 
> Which is also used to make sure things are working properly.
> 
> Neither of the above says they are for "debugging", even though they are
> more useful for debugging than this option.
> 
> I'm not sure saying this is "debugging ftrace" is accurate. It may help
> debug ftrace if it is called outside of an RCU location, which has a
> 1 in 100,000,000,000 chance of causing an actual bug, as the race window is
> extremely small. 
> 
> Now if it is also called outside of instrumentation, that will likely trigger
> other warnings even without this code, and this will not be needed to debug
> that.
> 
> ftrace has all sorts of "verifiers" that is used to make sure things are
> working properly. And yes, you can consider it as "debugging". But I would
> not consider this an option to enable if ftrace was broken, and you are
> looking into why it is broken.
> 
> To me, this option is only to verify that ftrace (and other users of
> ftrace_test_recursion_trylock()) are not called outside of RCU, as if they
> are, it can cause a race. But it also has a noticeable overhead when enabled.

OK, for me, this last sentence is preferred for the help message. That explains
what this is for. 

	  All callbacks that attach to the function tracing have some sort
	  of protection against recursion. This option is only to verify that
	　ftrace (and other users of ftrace_test_recursion_trylock()) are not
	  called outside of RCU, as if they are, it can cause a race.
	  But it also has a noticeable overhead when enabled.

BTW, how much overhead does this introduce? and the race case a kernel crash?
or just messed up the ftrace buffer?

Thank you,

> 
> -- Steve
> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
