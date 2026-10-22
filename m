Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656947;
	b=U6RFlOc+Dds9ZDTk7L9n6VAB29dmJlQneMuqwJTU8SR5QSt1q2aOuhdTl7ft/HKfmR+F
	 NfqJnnXreaRgOirl/YB4csFOF6AHX2jM7lQiQLJVAQ4r1CkqTd9aUzGCXXLf4SCHkxcZl
	 tpo7SZ5tLH8nn1gQsdJIsEIFsiMx7lluFeqRq6V1ozPZMwo9nCkNSHYl17pr9ewH4U2JS
	 pz2Lm+9WxrUzdjmFAlNznFxHqYYYlIhTfNqVG651O1Jct4RLAQLqQs0k3DJkL4vV5Z7m8
	 M50TJ9bqUloV9CzQ8Ws0dCHfL9T+EdKIHK6TjWj1KN2Z9saDhVai/6FW3fdKBzE4K1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656947;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=J5vbUlRNCs7S8y6HZc8htFWDT7aYGvGDyqB/FQ/diuk=;
	b=p4MxzyNZ6DgbySuHTTO1eu2XZGLRVnnB8SJkgDqoIEtBud2c5tlP36PT8vie0AsbBOus
	 HBhn6pXOKTbfbGT+zc2gOzJpBZWgfUfBgyMZmUFtLA9Urp8wff8PZHyiAapAnUCIqrGW5
	 95ulpOuadivJ6Coqn+fAka6ltJJyR97JOc23oZ+FBurX89c8K36s6FsPfdfGQjcJc8n7F
	 wy9O8+JhbxzmkCw5xGrJDrKk/R2zheA5juGXzLSixze7krzO+XN4x+OEiara3ey/PkC+H
	 xRPrxsBbEa1sPvFd0pgwpUCVbMM8X7fLqESZYF4nvqxYIKEeQt36UXgE5SERK3Zpzbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pb3tIRh4;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=d6RpW0SI;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B1606A319;
	Thu, 22 Oct 2026 08:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8B1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pb3tIRh4;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=d6RpW0SI
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792656943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5vbUlRNCs7S8y6HZc8htFWDT7aYGvGDyqB/FQ/diuk=;
	b=pb3tIRh4qt//ziCyq6bXR09LSLhWXItxh/VvgzpKAy+noDQsJb8Zx2HRtFqr50N3q/9EPk
	r3gdYLhKu0jKQM2O8e/iWuS5jTaRnZdpk4SgAoYZvVMiItDag6FXXBPHTikNa8It3qziud
	1miGLbmdpTOOusdX63FgYBzjl43g+q1/sHOpzFnEUEXE8/bsrsP/TbJAzzatzVlBw81DXC
	kMPSie8EkZ1VY68hVQbibJ0hckMAW0T7GsPf/bFi/etFyKokjglg4EzfKNoi4sDoTmjshO
	baRQcTTAjYiu8DA0ezpK+v/7n7Y2GBX32sAmQEiWTmLkqsl2kfkG1fdq9ysJYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792656943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J5vbUlRNCs7S8y6HZc8htFWDT7aYGvGDyqB/FQ/diuk=;
	b=d6RpW0SIcYw3QOU8+HZa/z8hLhxYcGe+jyeP/DU772pZunn+T50KIaSSSZW2ZUOi4cUcNd
	fFF0azj++viFPdAw==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
 <87h5ifqy6w.fsf@yellow.woof>
 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
 <20261021094853.29b9f7be@gandalf.local.home>
 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
 <87h5ifvw3p.fsf@jogness.linutronix.de>
 <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
Date: Thu, 22 Oct 2026 10:21:42 +0206
Message-ID: <874ieetakx.fsf@jogness.linutronix.de>
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

On 2026-10-22, Gabriele Monaco <gmonaco@redhat.com> wrote:
>> I am wondering if coexistence should be the goal. For example, the
>> monitor classes (DA, LTL, HTA) are only implemented in the kernel and
>> provide kfuncs for the state transition functions to be available to BPF
>> monitors. I would expect that this would allow BPF monitors to have the
>> full functionality as in-kernel monitors, since the events, errors, and
>> reactors would all trigger from the monitor class code.
>
> Well, this would be yet another hybrid requiring BPF monitors registration in
> the kernel like I proposed in the RFC [1], which was the main point of
> contention (that fully shared reactors and sysfs interface, by the way).

I think there is a difference, because the registration could be via
kfunc interface rather than requiring kernel patches. Similarly, the
kernel is able to load drivers that it does not know about it advance.

> For this I would argue, though, that such monitors would be BPF just
> on paper, we wouldn't be able to use many advantages BPF provides
> (e.g. BPF maps).

It seems to me that your main motivation of BPF is to move the
RV-machinery into BPF. For example, moving include/rv/ltl_monitor.h into
BPF. But that code should not require the flexibility that BPF
offers. It is the monitors themselves that I think benefit from BPF. For
example, kernel/trace/rv/monitors/wakeup/wakeup.c

I do not understand why you would call it BPF on paper, when the
semantics of the states and transitions is all coded in BPF. Everything
that makes two monitors using the same monitor class different from each
other. Only the generic state machine (with its tracepoints for events
and errors) and calling of reactors is in the kernel.

> The current implementation already shares the header with in-kernel monitors, so
> the actual logic is shared.

When you say "shared" you really mean "copied". If it was "shared" (in
the kernel) then the whole tracepoint/reactor topic would nearly solve
itself.

> Besides, we'd need to be extra careful on controlling the callers. Right now
> handlers are static, so it's easier to make sure no rogue caller messes up with
> monitoring.

That problem is orthogonal. But I expect kfunc flags, capabilities,
and/or signed BPF objects will be the direction to take.

The reason for my suggestion of a "true" hybrid approach is because I
feel like you were trying to completely relocate RV to BPF, and now due
to the tracepoint/reactor requirements, we're trying to find some hacks
to somehow make it work good enough.

I was suggesting to take a step back and consider an approach where
there are in-kernel pieces to leverage the benefits of in-kernel
(generic state machine, tracepoints, reactors) and BPF pieces to
leverage the benefits of BPF (freedom to define the semantics of states
and transitions for any domain-specific monitor).

John
