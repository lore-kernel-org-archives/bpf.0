Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740763191D6;
	Fri, 16 Oct 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178437; cv=none; b=AmX6fihN1yYa6/L4niL/E+ktXNpUmZ4RbHrE5h26QU97q8gu48FxB6K4HMG4IHwCKm/feTjkcbXaXSDi8OoUlZVL+SK6hOrxPp3MYX7U4+3aDV/Yw/N5wT5AarNNCM7w+A7pMERCoqOzGhR40fY/ekPUtgob9qlLbW2+zfCZRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178437; c=relaxed/simple;
	bh=SJrqD/VCmw6z+WTKG34qauJ0EmMEGv2IOVkDd92QLZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tr0q+ptN2bhLfF1K0RPOI5HCzsmzzoNO4OHvthcVZrQqd5ZM6mMDVmlUyJm78TFrPsRDgsMrFckISC9bWH7fq4kxtaFJWQnpfJWQ/VgZUMmvnj193DN3bhla+oMR5k58HDb5iC68Cmph/XmBthUgN046CK7sjTR3+KWBKF9sk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UlGuLb4x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+awnHoyF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UlGuLb4x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+awnHoyF"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792178433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJrqD/VCmw6z+WTKG34qauJ0EmMEGv2IOVkDd92QLZo=;
	b=UlGuLb4xXnDzgNvwkurAsRS0GasMl2MYti5HJHxo9d0HMPW7fusyW1MlYS28Fl1tOGwZBB
	3sLzj5Siq5pk/sFaU7GaXGoa0jQJxoJG4Ok7KoOiBfs2wSBoSKVkjN2kpkWCyfi6dR0vdh
	WiaU5kWZ3ClzOdJOeSrm6zSB/NKZPllGwqb2QvmqHMauYldysAe16fiI1b1lG59EcKvcAl
	lS7RI2TjjTiz9wCTmfyYKVTqGpdD9d9Rtpyuqlin9MNOts5yaXkc8CR5PorqIMIQg1p0Z6
	xOilK8WrVU5etwCRUWut0H94Pwmz88eWX57/9tnbEpP8RcSVS1Q58MWe4a3B6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792178433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJrqD/VCmw6z+WTKG34qauJ0EmMEGv2IOVkDd92QLZo=;
	b=+awnHoyFJo4veYV0jm/k7YHAwZbcwpRLYYoG8fMS3dU4Pu7Kgu6udc3QoB+EGx//pOjPLb
	XoaaQeisPav5PrAg==
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
Date: Fri, 16 Oct 2026 21:26:33 +0206
Message-ID: <878q3xtptq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-16, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
> On Thu, Oct 08, 2026 at 11:54 AM Gabriele Monaco <gmonaco@redhat.com> wrote:
>> Reactors in this patch use bpf_printk(), which is in fact a trace_printk()
>> instead of a real printk, is there a technical limitation forbidding us to
>> create a kfunc using some flavour of printk_deferred()? Or am I missing an
>> existing one? (this need was brought up by John, Cc'd here)
>
> No technical limitation, and there is no such kfunc today.
> printk_deferred() is a lockless store into the ring buffer plus irq_work.
> It's ok in any context where tracing progs run.
> The closest we have is bpf_stream_vprintk(). That's stdout/stderr of
> the prog. User space has to read it.
> rv tool is around for as long as the monitor is loaded, so it can read
> the stream and log it anywhere like /dev/kmsg.
> If the message has to reach the console when user space cannot run
> then the kfunc makes sense, but using bpf_stream is imo much cleaner.

I am still not clear how the rv tool will replace the existing in-kernel
implementation. Right now violations call printk(), which conveniently
show up in kernel logs and consoles. More importantly, there are the
rtapp violation events, which makes it very easy to use ftrace and perf
features to record traces, take actions, generate statistics, and dump
backtraces on violations.

Is it planned to pull all this out of the kernel but then somehow the rv
tool allows ftrace, perf, and console to continue to work with
violations? (For example, by somehow defining kprobes for violations and
writing violation information to /dev/kmsg?) Or is the rv tool supposed
to provide its own DIY variant of these features?

John Ogness
