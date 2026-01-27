Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D5C8F0
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473212; cv=none; b=Wx4CZOHV15VsMaPfLGCrlDc12OUZZJ3vRPUP6grGumQvWgW7rAImS2algGndAagn7OZanV1JBb7fLaQ1hT5YTHFaq3QbW8Zj2u5sXHcbjKzpE9b4/IkO9eSfVr3wlkdMuD915reQ+Fv8RhUEocJDzvX3ls7tmqyTWhjXRk2ri+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473212; c=relaxed/simple;
	bh=gAUzytqYrmhYj30PzKnHGBcXUC1A4PFIlvRkT2lzmw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbOgnsoBoDSiIID1zzwvXc+HR7IH5NM5l+52zsyc4xoJeBvpU+kaGezoi2vcKLNgv25qyrJGvydEAUb3TTD7+72Z3FMILzU+IA3U9cjg69hkhyWOVVRtuZn7uN/HOWq7sjuiacpCJHm0Uv1+3JYHKjNjGN09mBuEzLv+mxmw+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 0CB411B0D29;
	Tue, 27 Jan 2026 00:20:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 32EFB20027;
	Tue, 27 Jan 2026 00:20:07 +0000 (UTC)
Date: Mon, 26 Jan 2026 19:20:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>, Blake Jones
 <blakejones@google.com>
Subject: Re: BPF with deferred stacktrace and sframes?
Message-ID: <20260126192010.4f14bcb9@gandalf.local.home>
In-Reply-To: <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
References: <20260126142118.2ea3cf13@gandalf.local.home>
	<CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8dx3ioqyjd6bdbaat8sn4nfptotes6jy
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 32EFB20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/6jCB3FkR1jwrW+gfAgCMB7dEnSm+fdOw=
X-HE-Tag: 1769473207-528079
X-HE-Meta: U2FsdGVkX18rCuMin9NFeZ2lr+VV6I6PI372vAUMQQZh9OLK3TypaFkNZv7RYitlYDH7yp5DUVVcg3CEfZTnRYSbEibWNSPmNkzjg4tTDHSR29Vodjayb74J478HRuqgtvS+mRcaZjD1xA/qXZf+dwRdvsP2G1C+oEQkIDf750lsllmmfT2PPAhbLzmc6w9MJVJpSjC5hZOETcplHPLIhecGcDNKY3U4XKLcpbOOUl1jyU0N4sAHXBe5BcEyjd7JX+RIl9UJuFzD7S3xMWyJsEfRN551f+epUBDqXyJ10ZdT80f9MuOv4KMwVCjVy1qbTihVvMvSbykSSpnbxcvYxD2ZY+zkhntr

On Mon, 26 Jan 2026 16:02:10 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> So what we will need from kernel's sframe support side is just an
> internal API to get stack trace, similar to get_perf_callchain(). But
> it will be guaranteed to be called in a nice task context. No NMI, no
> irq disabled, no nothing.
> 
> This shouldn't be a problem, right?

Not at all. The unwind interface already has a method to get a stack trace
at any time, but it's up to the caller to make sure it's safe to do so.

See unwind_user_faultable()

I guess all we need to do is add a perf API to call that?

> 
> >
> > I've been Cc'ing the BPF list (and maintainers) on the deferred stack trace
> > work and did get a few comments. But I haven't heard anything about BPF
> > utilizing the feature yet. So I'm asking now if that's in the works?
> >
> > If not, perhaps this would be a good topic to bring up at LSFMMBPF?  
> 
> Yeah, we definitely can sync up on this during LSFMMBPF.

Awesome, I was looking for an excuse to go to Croatia ;-)

-- Steve
