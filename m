Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F77E6;
	Tue,  2 Apr 2024 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025918; cv=none; b=VYAK0rZDalyhabqBT6XH7Ubb0ASL8/ahErRNh3+gLbIflVbuvy/hAyE4pTtY5gi3VDfj6F1xVFTuDe7TeOFuPuHmMbe8HjkAW+s8FB92tnwvf5mACsqYzjpNsurg1/yIukm2RzRN7yV3M/Zeq09U6zFyH9eix52rDbJ/oFxMD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025918; c=relaxed/simple;
	bh=kF8o1eihOF70PBahEkvpbm2JAS6wgSAaxi232q/Xt4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+EkJGZQGJhGkuhg7RVmM4I1dhf5tcjY9tiGjobTNQM4dKLo87MTOel4v3xSR1gkv/0Ed0v9YPt/doyeiOc8o8fQxBlzZVZ2VDnyMzyuSV1vC8kJeNuiuExUnqvFT6EIRudswY1DdveXHJgJzB2szFZQW0CUDMmNlK5QkEKv97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8B5C433F1;
	Tue,  2 Apr 2024 02:45:16 +0000 (UTC)
Date: Mon, 1 Apr 2024 22:47:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240401224733.7a9bcbb6@gandalf.local.home>
In-Reply-To: <CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
	<20240326150121.68e9db8a@gandalf.local.home>
	<20240401202552.470d845bd79c841b9158fb56@kernel.org>
	<20240401120918.67cc3191@gandalf.local.home>
	<20240402093839.7de89341138748f743ae896d@kernel.org>
	<CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 19:29:46 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 1, 2024 at 5:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > On Mon, 1 Apr 2024 12:09:18 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > =20
> > > On Mon, 1 Apr 2024 20:25:52 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > =20
> > > > > Masami,
> > > > >
> > > > > Are you OK with just keeping it set to N. =20
> > > >
> > > > OK, if it is only for the debugging, I'm OK to set N this.
> > > > =20
> > > > >
> > > > > We could have other options like PROVE_LOCKING enable it. =20
> > > >
> > > > Agreed (but it should say this is a debug option) =20
> > >
> > > It does say "Validate" which to me is a debug option. What would you
> > > suggest? =20
> >
> > I think the help message should have "This is for debugging ftrace."
> > =20
>=20
> Sent v2 with adjusted wording, thanks!

You may want to wait till Masami and I agree ;-)

Masami,

But it isn't really for "debugging", it's for validating. That is, it
doesn't give us any information to debug ftrace. It only validates if it is
executed properly. In other words, I never want to be asked "How can I use
this option to debug ftrace?"

For example, we also have:

  "Verify ring buffer time stamp deltas"

that makes sure the time stamps of the ring buffer are not buggy.

And there's:

  "Verify compile time sorting of ftrace functions"

Which is also used to make sure things are working properly.

Neither of the above says they are for "debugging", even though they are
more useful for debugging than this option.

I'm not sure saying this is "debugging ftrace" is accurate. It may help
debug ftrace if it is called outside of an RCU location, which has a
1 in 100,000,000,000 chance of causing an actual bug, as the race window is
extremely small.=20

Now if it is also called outside of instrumentation, that will likely trigg=
er
other warnings even without this code, and this will not be needed to debug
that.

ftrace has all sorts of "verifiers" that is used to make sure things are
working properly. And yes, you can consider it as "debugging". But I would
not consider this an option to enable if ftrace was broken, and you are
looking into why it is broken.

To me, this option is only to verify that ftrace (and other users of
ftrace_test_recursion_trylock()) are not called outside of RCU, as if they
are, it can cause a race. But it also has a noticeable overhead when enable=
d.

-- Steve


-- Steve
