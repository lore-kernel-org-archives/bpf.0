Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451C472539;
	Fri,  4 Sep 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522238; cv=none; b=Pm96N7IPZeExNhoThr4wyZ3yI8TsbgH2zAyglQZd+fxhkTdp+jnf82Eo/WhmJUtrDcyft6Os0PxwvbfgVlxEm+x4iGynyQulyiILdEgCwcYKXhuEf/MKuUkV1HA1fvWpZyebLB6HyCpJaq4AmJVvrodErdBTeAPklKiBeDJg10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522238; c=relaxed/simple;
	bh=vr/1XDWlC+AfqoxUbrPlk9gUtgGvjqpvBvwrXcNXooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9IPXQBwx+0G1/H98L301cttg6rOsZS4kjy7+xUQLuUrhSGHkH+hqP8afyoeDGPIGhNnnkDU32st+3Q/Tbm8Uzn2b0rsmHN/2/6OmZNq1edd6l2OYMACUUtrQ7eKF6jGtdBtv3Nw+wGMWXiF5lu3Oapun154PrNMq8vskLT8Ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ddvI1dCf; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ddvI1dCf"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6B7AC40E49;
	Fri,  4 Sep 2026 11:43:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 3566417;
	Fri,  4 Sep 2026 11:43:19 +0000 (UTC)
Date: Fri, 4 Sep 2026 07:43:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260904074317.01b2c0e1@robin>
In-Reply-To: <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	<87se3sakgi.fsf@yellow.woof>
	<df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	<DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	<eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	<20260903090211.50d15220@gandalf.local.home>
	<CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j1kkfpi4gojfpg5c5e9naqy4uxxxfsjg
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3566417
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+m0/96ibbkXyhA2oM6hgFVLGuTXbap8Mk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9NCJ2MrPceZv4Eg9KUCeMzKIK7vnGd21QO4yAxDIaU4=; b=ddvI1dCfcZupBvYDJ9XfOtik4prxOH5sFIVAUIbJ2STTBsK1H1SZl0aevlLbCibS3ZP1QRsP+BZCTsJCZ1lARD5mbF7sKpog5HizQWvU5G681PtsPWHKCPL6/Kc2Nnj8BL3VHz1ZumhY+nd+BWVqoMYH6f4e3wW9hnrPfmNWoD4=
X-HE-Tag: 1788522199-38575
X-HE-Meta: U2FsdGVkX1+LTu9k/3lph9WvVQyICFaH9loNkO03f00ZkR5Mx34O6iy6h4wvAJD7Qtxfszrh14uv4xNi0uCHQ2uviHkbioW6k5GAGjxfnqGeiofRjzp3+GK3DMXhi/TePjUlO2JBXEgMcYQAOR3hJ0cRsJ19djvgnNkRn9iv+K6k92NOt4mXkPQ8jFtKUaNFG8JE543V3Jv9Ct50921mubMfuc/SoDKF4bvOlMXiqUq9nUDe0cnXCnu5YWUh0yGb9G99QEVjv6jQFlRAaF8JQewM2ulEQS8n+l8B27YboQfjcYuus3725uN4vm39L2gtjchx2TkQmh3uL6sRVZSUJw0o9UamNvnDHB3UhK1o4MGc/SlfPy9JG8xeRJjXByhTQCfqnihy3SaVGrmmZO80W5auKyCG+ALdz/e34SRieJ4FJBcI5LMyeUH5bYfWB8T3qPQ3UZ4lXH8=

On Thu, 3 Sep 2026 20:30:19 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > > On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:  
> > > > I don't think bpf fits here. I haven't seen active use of RV and even less
> > > > so of any request from people who want this kind of programmability.
> > > >
> > > > So Nack for now. Sorry.  
> > >

> 
> Ok.
> Please add
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> 
> when you submit it to Linus.
> Let him decide whether bpf maintainers have an authority
> to say where bpf is used in the kernel.

When this is ready, I'll be happy to inform Linus on the pull request
that you NACKed it, if you are still against it by then. He's Cc'd on
this conversation now. But you left out any technical reason for the
NACK. You basically just said "I don't see how this is useful to me".
That's not a valid reason for a NACK.

Gabriele will be presenting this work at Linux Plumbers[1]. This will
not be going in before then. I would strongly recommend attending
Gabriele's session and we can then go into the technical arguments
about the use of BPF there. If you bring up valid technical reasons
against it, then we will either work with you to solve those technical
issues, and if they can't be solved then sure, it will not go in. But
if it's just your opinion about the work not being useful to you, then
I will push this forward, as it is very useful to others.

Cheers,

-- Steve

[1] https://lpc.events/event/20/contributions/2446/
