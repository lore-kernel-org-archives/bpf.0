Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D044A414;
	Sun, 18 Oct 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325408; cv=none; b=OU6sBD2BiuNcvdGJeIek8RCnshEDb6wjIbjokV/a9owfBzRT6Ihg6JDH/KYbCRd5vr0UovuxFJZU8YlJ9paSZZfc+ldi77qi6OLKW/tMH6RbnyCz4EI7oSEyM5cDPvm0Wi4cQjrsBoldUteINN4+JDi7g5qElTS0Yff7t/o+Pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325408; c=relaxed/simple;
	bh=nrE8K3ZJMYd4/DYevz/Oj1oqhY7ZQHsG0VyN8WPlhcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFd8gyubnUMGBw3BqbbgVzjKD7gC8mgElpxSGI79OcT8CEkmEA1rAyicm1fwuq6PACmzvC6tkccOMZtTyNE4pQx6lbavI+uyFFdSLizlV0QTKGZoKGTzsA57vsi9u9VRBeldKVhb4/F8z0PWkDPWPUic1yywEO/9MJjBEjtqRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmDM8heN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GjXs0Haa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmDM8heN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GjXs0Haa"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792325404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrE8K3ZJMYd4/DYevz/Oj1oqhY7ZQHsG0VyN8WPlhcU=;
	b=wmDM8heNY3lBLBtcBlMJB/2Dn13GA8eeviIjwqAZQli9LUApXd+mkoGOVgjbdq67+dUPrF
	kSwhTxqSMHGoKXHncXtI8FMUiNhpMVQ/O0Ff1FD/IeLYmlj5U5pnk8I6QoCXHqqTJjScc7
	UH2Sr/nU2m9Zpw9pSapWoXlG0jxlcVUGG71KCQh9gvKtk95myHZCOYI/5CF7wheL9n/jxz
	u2X7OjbkEBckEd36Sxk5j1nBIzkomEAl6nxOsGE9Su4TqJg25PGiHJnPWfxfiLlcukfmgR
	ZbWRT1a0Je6CMRxKybTZcFDXs/qGslcO0cFhko68PcKiPQD8MBMjNXNLUAR4VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792325404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrE8K3ZJMYd4/DYevz/Oj1oqhY7ZQHsG0VyN8WPlhcU=;
	b=GjXs0HaabzRRkMStq73HasvZPstvl17frN1Ek09L/c+KZw3ylbXAsbSEtc4rYxidliI2UD
	2U3p7e/WoKp9TiAg==
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
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
Date: Sun, 18 Oct 2026 14:16:03 +0206
Message-ID: <87ik2zryzo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-17, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
> On Sat, Oct 17, 2026 at 07:02 PM John Ogness <john.ogness@linutronix.de> wrote:
>> It would be nice if it could be filtered so that only RV violation
>> bpf_printk's would trigger. I do not think it is possible for a filter
>> to do primitive pattern matching on @bpf_string. Or am I wrong?
>
> not an ftrace expert, but it should be possible. bpf_string is
> a dynamic string field and filters take globs on those.

Yes, indeed this works. Thanks for mentioning the globs.

>> With the "new" ringbuffer and nbcon implementations, it no longer dos-es
>> the kernel, so I have no problem with bpf programs calling
>> printk_deferred(). And besides, userspace can already blast the
>> ringbuffer and consoles via /dev/kmsg.
>
> well, /dev/kmsg is ratelimited unless printk.devkmsg=on,
> but the kfunc wouldn't be.
> I still feel that bpf_stream + user space that writes into
> /dev/kmsg is a better design.

My issue with the /dev/kmsg design is bogus timestamps. But let's just
drop my suggestion to allow eBPF programs to call printk(). Since the RV
move to eBPF will require new user workflows anyway, the users will need
to learn these new packages, tools, and output sources. The important
thing (for me) is RV violations can still be used effectively with
ftrace/perf, which they can (using globs in bpf_trace:bpf_trace_printk
filters).

@gmonaco: There should be clean glob-friendly RV bpf_trace_printk
strings so that filters can be easily and reliably set up.

John
