Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6F463B92;
	Mon, 19 Oct 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401029; cv=none; b=OPcAhQC5RIAV3xkfENEmYXS+fmPOiTEnx8NpSPm94vMqTg9E2VPQ9StayqApZ6JxtXdXl0PExBgrzgpwQndINF4dy5TglIcxu2roELV+ZxXXC3KtIUYQlkJDOhY6kEPKQ437dx41Sh19/T3sKcQ8csnOFALdU6qiLQ4qHlp9xQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401029; c=relaxed/simple;
	bh=QZvmOBsCZKiBl07Joeh3dh1Uae4OCenSx2c1nJxFszA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXdbRG2EeOgg/uBSptAbgAGsCb8iazYoYk9BJ2SDxpUnDoQCxBKQm88BCHnGsqN/nUiw5G121z+dv3BwT/skKbWrlf3gYV1QdzEEufhvjZsbI4ecsoOAOHF3CBfJ0qiEA4YMsAYfUTq0A/gqiqJYpiF9Sx9Oyu0GpbK0Y+74vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TCaz3bgD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jdJxnczf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TCaz3bgD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jdJxnczf"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792401026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHZ3qYBNpxGqi8iGBwXZTR+KofiAQ5y+KIHBjZ1X8yo=;
	b=TCaz3bgD7sZlgZvJes4zR2feEoyA20nEtvTgfESjtfSlo/V5rObYZH/AGvPEibvyQXL7HA
	Ypv53qNsnIm15lcka49pgOfr2Sk7m8Cg7ozx+PgaaaDZ9l+30uVZAA1coR+W3grjfLdUmD
	hmS7UyLwrvmowHe94e2D1O+4Dh0gAulxbezrEPKWlds/DHcWOhsDTB9hkOTtwJg9WuqKO0
	eM8C1V3OgRY52qCTpz9+F1XgnyrgaB7E+GQZzG4pj4qaIRssM71PKKnKSwcQSzhAprSPHQ
	DK0xYJbX3OxzLVcEQkS7MIozVe+E2o1yw79EMcDXPKXddMVppwr6W3uc27yLcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792401026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHZ3qYBNpxGqi8iGBwXZTR+KofiAQ5y+KIHBjZ1X8yo=;
	b=jdJxnczfVaVLLsnpGOEnU4SA/yXheEy/4yEy4+nrSkWhI+AuloHyW+lUjAReWGaYWrHd9n
	BGOiTLPEdjVhPHBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
Date: Mon, 19 Oct 2026 11:16:25 +0206
Message-ID: <871p9mqcn2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-19, Gabriele Monaco <gmonaco@redhat.com> wrote:
>> > We are missing stack traces (which I'd optionally add only on errors)
>> > and perhaps other events (e.g. the -e in either tool if you aren't
>> > only interested in errors/events of the monitor).
>> 
>> I don't see the point of reinventing tools that already do the job
>> well. I do not mind if developers want to create their own tools that
>> provide some small subset of existing features. But I am concerned
>> about removing the in-kernel RV support for ftrace and perf.
>
> That's valid too. We'd need at least the rv tool to start/stop
> monitors in addition to ftrace/perf. Kind of what you already do now
> with sysfs.

I do not expect the rv tool to start/stop ftrace/perf. Nor would I
consider that useful. When I am using ftrace/perf, I am interested in
additionally related events. The rv tool can not know what what else I
need and I do not want the rv tool to become a wrapper for ftrace/perf.

I would use the rv tool only to start the monitor. It would be enough if
the tool would report the bpf_trace:bpf_trace_printk globs that are
needed for the various possible violations. Then, with the monitor
started, I would start ftrace/perf for my own investigations (also
capturing any violation events).

If you want the rv tool to provide some basic stdout data from the
monitors, I am fine with that. That is certainly useful to easily see if
a violation occurred.

But for serious investigations, I really just need the tool to
start/stop the monitor and tell me how to grab the violation events.

> I'm trying to keep this use-case in mind though.

Thank you.

> I assume you aren't interested in the "event" events (transitions in
> the model), those are useful when developing models, at least in
> DA. And those do not trigger a reaction (stdout only for now).

As an RV-monitor _user_ I am not interested in RV state transitions. I
do not know if RV-monitor _developers_ might need that. I would think it
would be useful when debugging RV-monitor false-positives or missed
violations.

@namcao: Maybe you could chime in if you want the transitions as events.

John
