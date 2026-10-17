Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00E34B437;
	Sat, 17 Oct 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256192; cv=none; b=gYtWVrPv2LR5KovneFfzql52EBI77OHgolpGj680G9j2mO2bm7IzXiCLV5GD+VXRTD7x4hDUPTPf9TKK7QtSsVe5HoDDtfwCV4B5hQ0zp3tG/srnD1WFp9tevqMhTpxDFjvvRILpldHrKnYrC9kE9+qiTmGv27+5nRGedfOOAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256192; c=relaxed/simple;
	bh=IYQ1suEjolEOaNpO6FsMbWf1oA4VxVpvSTQtFRMoT2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHUzJ60+cD+TT2q9qJQxEsJrUTReF6V/4wQbTCQ8jPFaIBNm0ny1XXxsAnr0C5rI3qwdZUvRAeLdhXJzofYhmRs14dvWDsJ0vLqaJoaZjui5qAXCz6Ir+OuY41acRS3oLJ5SVg/JrvncmPkZU0ydsTQP1YL75F8lLf2PwTjOWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DdDLGiPW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PurO5z4w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DdDLGiPW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PurO5z4w"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792256188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYQ1suEjolEOaNpO6FsMbWf1oA4VxVpvSTQtFRMoT2k=;
	b=DdDLGiPWN/twWwHyGBbl1ohDMS0GeeaSzq7vgptCoPDPW7EAQlXDACXt6CeUQxrxP3MV/K
	GYqiIDm8iETO5VPgaFqQHAeqv13X2YOKqkHCokvUItbH+8URENh6cwni/T1jdhb7elkWNK
	MXU86DO3UzCDFYgujbEIJv6AdxPe3k8E+NHzT7qgIdFRKNjx+lHR+BKxEFfvBh8TqRVE0R
	3XiZFqFVCMiXfG4YUnxsFOoDKgX6SBUXEjiXXaWqsCKo30SljkHBy7wD7Beb4PzdzFIoFc
	RoqCxKKUGfdLTck/CmVHKgzfhX7CeyhCZb3hW3+kUE7UvODzmmqqKPSwtjtoEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792256188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYQ1suEjolEOaNpO6FsMbWf1oA4VxVpvSTQtFRMoT2k=;
	b=PurO5z4w6cXSK80q9C2+GbGdIluadgOAe7HEMbuo7CGqzUjAYXs2XWgSfO43X0NouZeQ9U
	5DjcHkdZxRMgUEAg==
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
Date: Sat, 17 Oct 2026 19:02:28 +0206
Message-ID: <87v770uuyr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-17, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>> That sounds like it could work. As long as there are kprobes in the call
>> stack of violations, I am happy.
>
> No need for a kfunc to get that.
> bpf_printk() in the reactor is a regular bpf_trace:bpf_trace_printk
> event, fired from the prog where the violation is detected.
> ftrace triggers and perf can attach to it.

It would be nice if it could be filtered so that only RV violation
bpf_printk's would trigger. I do not think it is possible for a filter
to do primitive pattern matching on @bpf_string. Or am I wrong?

>> A delayed kernel record is better than none. Although I really do not
>> see why it cannot simply call printk_deferred() directly. It is safe and
>> lockless. And it has the advantage of appropriate timestamping when
>> compared to any other printk's that may be happening at that time.
>>
>> If we are already adding kfuncs for panics and violations, why the
>> resistance to printks?
>
> printk kfunc wouldn't be limited to rv. Any tracing prog would
> be able to write to dmesg with no rate limit and then you, Petr
> and others will start yelling that bpf is abusing printk
> and dos-ing the rest of the kernel.

With the "new" ringbuffer and nbcon implementations, it no longer dos-es
the kernel, so I have no problem with bpf programs calling
printk_deferred(). And besides, userspace can already blast the
ringbuffer and consoles via /dev/kmsg.

John
