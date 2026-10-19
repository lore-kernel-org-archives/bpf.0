Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82D4F30D1;
	Mon, 19 Oct 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414960; cv=none; b=VXW/7Iqj2PsoyBTxVfBEFNmMRXTFXzJQkre3ximBiZhm/q8pJ8NIYePwqKae4OVeRgTzsfHa3BXw/GE9KL07a/pvAmrpnrkeoU9tXV1CEJBu2RRWdd0h1nsMsjEsyph9BX6yXCv34Clh7MPQVU0DQ7lHnhlCbrsSdeJ+6KGYXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414960; c=relaxed/simple;
	bh=G3di3YezjuBKA0ZdP5UVOTurojcEYCmvMm1o0bVsOsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+gNM0LYX/vGDrQWUia5g1stUtevwvCqA7s+mKPmq+ZKtv3Lusvkgm5axtSp89KMVWtvjud/k2vLzurs2ZsDk4oDryTYmUYVehE4Nm0OXRYXLUTMaB/yLMj5DHDuYGRU4LaLJ88tCVL3PPws4NcsSz2KHWSuZ5vbdLNwxCqx314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sk02VzIs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SGnxVuD7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sk02VzIs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SGnxVuD7"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792414956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXeCxHrc/AAnCx73GOUVk/bEIS4sVoxPXjzs3hxfe2s=;
	b=sk02VzIsy8isdpa0IxBjHGUl2hEwGu9WHMjRNLMWpzIOMIRTAiQMbbfzymIwuK58CcA6fg
	SnUAbxCXTqyYE67887j/CZP2z80fYFSyjsgES75WYhjA56XKK9DXegiuFD0YYX53R/86Ax
	DDFOni/ZaH3ShXPl0XxMoi/nS1vxVXtaVTGejc0UGiUDyh4jQOeHIAnE0rRn8asO1xnfiJ
	d0liABzShl5Vb7ITArGqvcnwdYR+Y4p1Pc6f7emecMx9HeftPUNns/0In/bQUQTF/K9scR
	bSgjipUm3/zb9x/XsrHbisdpZY8vtrR0zSpjL/Vm37k8hanM2I675quuLzLNsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792414956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXeCxHrc/AAnCx73GOUVk/bEIS4sVoxPXjzs3hxfe2s=;
	b=SGnxVuD7oj0vsSVaR5lN56bj/+Tra1PJcpSA5Fy9hASz1vH0nSh6D6cTCaFaRN5xwKyHOS
	3JGWQL8DfmhCRxDg==
To: Tomas Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam Cao
 <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
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
Date: Mon, 19 Oct 2026 15:08:35 +0206
Message-ID: <87pkx5q1w4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-19, Tomas Glozar <tglozar@redhat.com> wrote:
> Do I understand it correctly that the idea is to modify existing
> tracefs instances when enabling an RV monitor to filter our RV-related
> bpf_trace_printk events?

Not necessarily. But does the ordering matter? If I run:

$ sudo trace-cmd record -e bpf_trace:bpf_trace_printk \
                        -f 'bpf_string ~ "rv: violation: *"'

it does not matter if the instance is running before or after starting
the monitor.

>> > I can imagine an RV-specific trace event for that, however, it would
>> > require a separate kfunc to generate it, and ideally also distinct
>> > labeling of a BPF program eligible to call that kfunc. The "rv"
>> > userspace tool could then iterate over these labels so the user knows
>> > which violation events can be expected to occur on the system.
>>
>> That'd work too. It's what I initially envisioned but I'm not sure a kfunc
>> producing a tracepoint is something BPF folks would really like (and technically
>> any other unrelated BPF program could call that, unless there's some access
>> control mechanism I'm not aware of).
>>
>> Not sure how much it matters in practice against the glob filter, it probably
>> really depends on the other bpf_printk users (and a mildly better usability).
>
> bpf_trace_printk is already a BPF helper producing a tracepoint, this
> would be equivalent. Of course, that does not mean we want it, but it
> is something we already have in at least one instance. I know of at
> least one quirk: you can have a BPF program attached to a tracepoint
> that will call bpf_trace_printk(), and a tracefs instance tracing both
> bpf_trace_printk() and the original tracepoint. That leads to a new
> tracepoint triggering while another tracepoint is already in progress.
> I don't know how it is currently handled; from what I recall when
> testing RTLA's BPF actions, the bpf_trace_printk() event might get
> dropped by the tracefs instance, so I had to use a different way to
> signal to userspace in BPF actions test.

This is interesting because it is very likely that the RV monitor is
attaching to and generating the violation from the same tracepoints that
I may be additionally tracing. For example, the sleep RV monitor
attaches to sched_waking, which I would also use while investigating my
broken real-time system.

However, I just ran a test with a simple eBPF program that attaches to a
tracepoint and calls bpf_trace_printk(). I started trace-cmd to trace
both the attach tracepoint and also bpf_trace_printk using a glob. After
starting trace-cmd, I loaded/attached the eBPF program. The running
trace-cmd was able to capture both events (with about 15us difference in
timestamp).

> As I said, to prevent unrelated BPF programs from calling the new
> tracepoint, you'd need to recognize and track RV BPF programs as a
> special type of program, similarly to what your original RFC did. I'm
> not sure if that's what we want, but I see some advantages. In
> addition to better filtering of reactor events, you could separate
> reactors from the monitors entirely: you could trigger the tracepoint
> unconditionally, and attach reactors as tracepoint triggers to the new
> tracepoint.

Thank you for making this suggestion. This is the direction I would
prefer we take.

> All of that adds complexity, though, and requires separate discussion,
> so it's probably not something relevant for the initial
> implementation. I just wanted to mention it so that it doesn't get
> lost.

Since relocating RV to userspace requires an enormous amount of effort
and coordination (mainlining, packaging, distributions, documentation),
I do not think it makes sense to have an "initial implementation" that
is already not what we want in the long term.

John
