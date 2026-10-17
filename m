Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B937DEBE;
	Sat, 17 Oct 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250237; cv=none; b=QSTe4fZp8HLLtLX+4fLY9trWUa75IafXELbQGt8IbuPVgmoW1Ee4A+138HNFBGl3yluqVOwDEfIwpjSXN0nGwVK0uDK2ZFS/HAgdcwurn2mkHeyvtgR5Zc07tJD75uVlQkObcT06hgqWNYPu/NR5AMyCjK5ZNpsGeSiBM4/CLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250237; c=relaxed/simple;
	bh=T3HwOIJ2T9WyXzwkmLuUUf9CONJB3fI5/Vd5B0HBB9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCxvoQkhTlt6CcpctapIvITv+yYtoxpbR7OiQWmdtfjkBPmj1C8Bg7evLZrvItcXtCvTH3AEZvjrEPjdWE8B+gFb+rcdeTxjZYodPsTtFrSh3PPUv/LnQktWQm+1PC5SIFA/4jw4ZEt30DBEiqDRn4NRFUKROIyj/shLP6V8X3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxn4pngX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjqhEFaT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxn4pngX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjqhEFaT"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792250227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXdifV80/bIYv8mAuKYgekSIXYnPDSdgCZOfWP0YQBM=;
	b=wxn4pngXZJw6lHFQKr2nopr2DKLKqEGTWTR6ytj1cCJev8KVwtZ2qgFb/+4CllN1T0rNQP
	EPZtTrmDAso9g12mq2Mndquu33HvAH9IPNW2Bs2iSGuysxhPcwyFqtfX/7hnqsp0TilBPM
	1Mk7uClKw546Ocqv1c6BvMYGJa7TBphiejO7AvktaBIiOZ7200Rf8csFX34dkiwH6Jm/jO
	5w7S+Bm+8KuRIo+gQKdjXgzWR8l5pTuPnxBBLRDyJ+ChlftYRXmJeNxavYwP5QLUslbha/
	v71nji01c7ADa0IbJYqRHCUsJGgO+o3I6tHAu1kVCm+o0s72gctjEFqaN1di+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792250227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXdifV80/bIYv8mAuKYgekSIXYnPDSdgCZOfWP0YQBM=;
	b=ZjqhEFaTSgZJrsohdjXzeidz05bpbn1rdiOPNYs5FrTVDbH4rgWKMCEplszAgO7K3F5STB
	wzGg1oj9rhVS7bCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
Date: Sat, 17 Oct 2026 17:23:06 +0206
Message-ID: <87bj8s8ih9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-17, Gabriele Monaco <gmonaco@redhat.com> wrote:
>> I am still not clear how the rv tool will replace the existing
>> in-kernel implementation. Right now violations call printk(), which
>> conveniently show up in kernel logs and consoles. More importantly,
>> there are the rtapp violation events, which makes it very easy to use
>> ftrace and perf features to record traces, take actions, generate
>> statistics, and dump backtraces on violations.
>
> The plan is to keep everything you'd now do with perf/ftrace as plain
> stdout of the RV tool. Right now you can see the same ftrace output
> using rv mon <monitor> -t for in-kernel monitors (only deterministic
> automata).

IMHO it would be a pity to lose support for ftrace/perf. I use these
tools extensively for my daily work evaluating real-time systems. Having
the rtapp RVmon integrated allows me to easily and naturally extend my
workflow to include rtapp violations. Plain stdout is hardly a
replacement for trace recordings that can be imported into existing
visualization and analysis tools.

> We are missing stack traces (which I'd optionally add only on errors)
> and perhaps other events (e.g. the -e in either tool if you aren't
> only interested in errors/events of the monitor).

I don't see the point of reinventing tools that already do the job
well. I do not mind if developers want to create their own tools that
provide some small subset of existing features. But I am concerned about
removing the in-kernel RV support for ftrace and perf.

>> Is it planned to pull all this out of the kernel but then somehow the
>> rv tool allows ftrace, perf, and console to continue to work with
>> violations? (For example, by somehow defining kprobes for violations
>> and writing violation information to /dev/kmsg?) Or is the rv tool
>> supposed to provide its own DIY variant of these features?
>
> My plan isn't particularly strict right now. I'm aiming to allow BPF
> monitors in the user space tool as an exploratory effort.  I don't
> think you would easily interact with ftrace/perf from those though.
>
> If that's a requirement, you could probably call a kfunc from BPF and
> attach a kprobe there. I would implement that from a reactor
> (violations only).

That sounds like it could work. As long as there are kprobes in the call
stack of violations, I am happy.

> For a pure printk reactor, I drafted an implementation that calls
> directly printk_deferred(), Alexei is suggesting to write to /dev/kmsg
> from user space what BPF passes.  Since you were the one suggesting
> having a real printk, would your use-case favour either solution? I'd
> expect some different latency if the log passes from BPF to /dev/kmsg,
> but I'm not sure that's an issue for you.

A delayed kernel record is better than none. Although I really do not
see why it cannot simply call printk_deferred() directly. It is safe and
lockless. And it has the advantage of appropriate timestamping when
compared to any other printk's that may be happening at that time.

If we are already adding kfuncs for panics and violations, why the
resistance to printks?

John
