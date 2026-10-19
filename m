Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2D347C6;
	Mon, 19 Oct 2026 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402080; cv=none; b=tP+ILQmM+0zWPJP1cKZvy76kAfrl78o+mdGgQ29E/AIVUtB/1ZDIqQtur3P1uxWydqZGmJV3rfRJ35Et2365hWXQ3aH3P6aZusshVZAqOcGJGK1fVyZouxNr4d3XCMYbHZktOTKmp3G1gAgsl9MQg0skCZ8T0dQvA6moMi68ArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402080; c=relaxed/simple;
	bh=M21EIc0kbcj5wAAP+pIIhFJ9G8tMFU/JTtcTqKOOb9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rIBnRHH5eq1Or+zdAYkssfLDDxdYj2jAsW3156Tqoz5aO4FGfa6a3TM/pyhmR6hUCY798mkKWG6p7EytWGgVsivm0Y3vuVX0KmxZsCTusjB9iHYUCqx2CXt9fdFgx/plKjNkT96DBDF4NJs/MQ5KGAu+b1xCNJaKqcM+BQ7u7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9D/4EIC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9/RoMIEV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9D/4EIC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9/RoMIEV"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792402077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGlMXZ27OkoZTr158Yx0TitBlTz67qkGcCV0HwG3INg=;
	b=N9D/4EICjWmvQzFcuVl8GnkMbktgYESDfCyJUA5YlXSUVVsyLac3WCJIVU11zsPWV79UEC
	2zgnnGjRiqoWKq994F9pJKl0ZYEKxH0LjjthfnRrTMz4ieYLCeZC0JfJITn0qaw+ArHE/y
	8C1x32fFv5Wb5nH6ETPELMs+/lfekP8lN/B66rGI/T+I0OvwkkoEDGEblPWY9KBI6K6FC+
	HlLRnSJKVj3WBvEPbpcwkcFDKHjNWMEdb3n3G4hu3HA6yXWH6+WA8qiL4uSv6O153R0r7t
	Jbf0LVcujl78vpbNpA9M1nE3twYEe7EXUJJYue80PP06eEyrHw651cIJts3MYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792402077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGlMXZ27OkoZTr158Yx0TitBlTz67qkGcCV0HwG3INg=;
	b=9/RoMIEVVTxrveGpvZ3mdCZp3RpcBsqPaxd/yhd0aOOYcjUKhZKikn1cNwxMl3Es5xVub1
	D9t6jjixpbWe95CA==
To: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
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
Date: Mon, 19 Oct 2026 11:33:56 +0206
Message-ID: <87y0buox9f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-19, Gabriele Monaco <gmonaco@redhat.com> wrote:
>> @gmonaco: There should be clean glob-friendly RV bpf_trace_printk
>> strings so that filters can be easily and reliably set up.
>
> If I leave the LTL header unmodified, you'd get something like:
>
>   rv: sleep: <comm>[<pid>] violation detected
>
> It should be glob-friendly enough, but I'll try it out.

If transition-events will also be included (should be optional for
performance reasons), a better format may be:

  rv: violation: sleep: <comm>[<pid>] <violation text>

  rv: event: sleep: <comm>[<pid>] <event text>

> I wonder if string matching brings additional overhead (trace_printk
> itself does, if I recall correctly), but that's probably rather minor.

For production environments, I expect that trace_printk's are only
occurring for violations, in which case the cost of a string compare
will probably be irrelevant.

Are these trace_printk's available without getting the scary kernel
warning when kernel code uses trace_printk()? We do want RV support to
be enabled in production kernels.

John
