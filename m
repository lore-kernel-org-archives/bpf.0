Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569710;
	b=UtQ4qwumg0s8jk0mreDQOtpyB5fL+3+tv2nuFX8dcXffxBTAT83IJGS11qNzj9OQ7PWl
	 y8qTIZda0lyMzf5+Bli+PCAB9GgC1ZxXKFY2PCtmxN4GrZJfUqIbJJc7e/enyiNA3JVAc
	 6CgI+tUcF+9GZ5M+87ci0bLsNqAgx5w3cEqMIHSqgT9CHNwW/wR2AzN7MHUmH2clb1R0Q
	 X105xg/u7VPEhqXjiRjat2jTUb+b56m/Ddnc3RjzZ+AptZs1uCUG46/ObmI1mTge09GmU
	 kDGusREQIp6nFi8j85wkq2eY/AV+it7ty0l4ljGsFmLo+Xks2b9zmn89PNvXjxmPXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569710;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=BUn1QdKzl4Cr/v8eftwHB9SnV5StijGa2ThVubvbbAs=;
	b=nMxVMjyx0+WKMNZcFYJxMXiWjFkODpgBRXMifep6fw5rrRKXwjlvmGIefm2qP9VoJvoU
	 i8bgCZ1K7N1MXcVtlMapRRDfiFE0UBihpvDpr73nIFKvYb3Qc6DTfKkv6nCD+1XQrnEfq
	 IP81BR68vscyjfCq1KJ1rX7GWYm11p7XECXAHikkCN7oHZOnilNXePq5pDi7yFZZ0vZIr
	 w7Gp+58Fr6XDwqXKh/ZvoCfMkwaXUzWpjIaPJ6L6JzvxdiHgwKNWw4SHDqVPjTSiiauzW
	 FdckCn8V+hOfp0aa6dQzUbtaBHC2JthI0RIA48k8tVCY8YZ2Ndc3xIJz/sPh6LZWaEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=C9UMcKAV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7MRbqANG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844F606A31A;
	Wed, 21 Oct 2026 08:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6844F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=C9UMcKAV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7MRbqANG
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792569705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUn1QdKzl4Cr/v8eftwHB9SnV5StijGa2ThVubvbbAs=;
	b=C9UMcKAVtsU1ARJ2C8w3DcZsgz6Nq8g5Uo333++m3aE0rK94IECvF57KEqFKxy/JN3er+K
	eDl937sXnOYMj9TzDakc8j9CVvpiO9YtptnrGUkvbCoLQWQx6jZpCxzd4iK7wkghfr24dw
	9SSJk6CNuie2jma6V4RqEGM0UqyiGctQBOdtHk5ePLGjrMv3ErkL9tPWKzyrALwvckLD7l
	wTF0BXrSgXaFRJA8Yk97IEVnO/wii5DUquBTGY1Wv+n0XUphWfTOjApSJYHIvv5loHdo3D
	0cjt33kgorRGKxf743mPpwG7tIsa4IXxkoe9usGky15in4haLDVccs7ntY37tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792569705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUn1QdKzl4Cr/v8eftwHB9SnV5StijGa2ThVubvbbAs=;
	b=7MRbqANGZ44f+uKLFbfrSOo3CyiFttxzDrKdM+sZxqjgLMtS9g/pMqFs0wWmrWfYKFBcMp
	b78mNTjikXvIpUAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Tomas Glozar <tglozar@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
 <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
 <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
 <87pkx5q1w4.fsf@jogness.linutronix.de>
 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
Date: Wed, 21 Oct 2026 10:01:43 +0200
Message-ID: <87h5ifqy6w.fsf@yellow.woof>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Fair enough, I feel to be cautious at redefining what reactors are right now,
> though. Currently they are nothing but a function call to the set-up action.
> It's trivial to verify where the code goes without adding the tracing subsystem
> as a dependency in the path (typically important in some safety critical cases).
> Sure, handlers are called by the same tracing subsystem nonetheless, so it may
> not add much value.

I am thinking about dropping reactors entirely and only use
bpf_printk. I have never been a fan of the panic reactor, crashing the
system because of an RV violation is a bit much. And the printk reactor
would be replaced by bpf_printk, just that the messages would be in
tracing ring buffer instead of kernel log.

Or do you already have potential future reactors in mind?

> Let's leave reactors aside for a moment. What I am coming to terms with,
> instead, is that the current ringbuffer to userspace design isn't what we want.
> In kernel monitors communicate their status through tracepoints, perfectly
> integrating to tracing tools, BPF monitors use a custom buffer.
>
> Generating a tracepoint here is probably the way to go. bpf_printk does generate
> one, but as Tomas pointed out, hijacking that for everything (think of monitor
> events) might be a bit much.
> Nonetheless, we want RV BPF handlers to generate tracepoints, then attaching
> actions on error tracepoints (whether we call that reactors or not) can be done
> later.
>
> Summarising, we have 2 potential designs.
>
> 1. bpf_printk only:
>   bpf_printk("event: monitor: curr_state x event -> next_state")
>   bpf_printk("error: monitor: event not expected in curr_state")
>
> 2. new kfunc(s) calling a tracepoint: 
>   trace_event_da_bpf("monitor", "curr_state", "event", "next_state")
>   trace_error_da_bpf("monitor", "curr_state", "event")
>
> 1. is simpler and works mostly out of the box, depending on how powerful glob
> filters are, it can reach the same functionality as 2. Might risk to overload
> the shared bpf_printk event and perhaps have a higher filtering overhead.
> 2. is closest to the current in-kernel implementation and offers flexibility to
> easily filter the type of event (useful for DA, e.g. I want a backtrace only
> when going from state A to B). But it requires a series of kfuncs (e.g. error
> and event for each monitor class).
>
> In both cases a malicious actor could call the kfunc and make us believe there
> was a reaction (they cannot mess with the model though). If we own the kfuncs we
> can at least limit the availability (tracing-only and CAP_SYS_BOOT).
> This, unless we register BPF monitors in the kernel like in V1.
>
> I'm going to test each design once I get again to work on this.
>
> Thoughts?

I vote 1, much simpler (but maybe I just haven't quite got the issue). I
feel a bit ensure about adding RV kfuncs and would only go that route if
there is no other way.

Nam
