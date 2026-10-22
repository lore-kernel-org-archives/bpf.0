Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657518;
	b=DexybkusxP+PFkb38gZE63aTjMYWIiaR+dNcvrYrEvXx6c/kvkso+es8B7Z+2ZwBDGGb
	 73KwYqRXleDT58Me7KpKX5aqVhuHvx/XRRA6503juhEpuAcmaZM8wlcUvvkqGwLLN4kCP
	 8QIxrUKCubd6joeUbd+dow3GD7T4wKOL3ECxj29flEwSFS6XDDzopWI2OIwmPDABe9ILu
	 +NtC51XDUxxfLbJQth7/pLcMfVAmSAXDINkVIBQ6qXHk24p5GlsTp0V8DtmfTAbQsUtXc
	 dYLWv03+UFVDGySGvf0dlcXM/5cRueqVhU2xKU7dAv9VoA356+G7ouaV8bE3Y6fgQTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657518;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=IdtW1rAGsIKxN6Wm0qAXHuMt9ue8GvhTyEgWLvkduZ0=;
	b=MYGxvI1x8cepj1elnJJPEGSbOqc3fYNs4T2ttio+0H+ZHjLKvxYO3etV5hno5a3SJKv4
	 1W1Anyw7rzC0XdS/6INVBVQQfvk1LVzX4CE/fbIBQ/KiUM0+KZe0YC9E2O102q1OgG0/6
	 VcPzxzQ7eMKYDXHm2x7DioOpl+wvsKZUCrlOil10G5/it5ACpfJKvqUVcJEJeo4Egn1oO
	 3tUgr6NpV5s65fTJVmig3ZohGzJUUxQMKAqhNQh5XjVpwbOE6VlGFuWxvbuzTkSt2vUd6
	 ute+M94drtQniSGrVkMp5gGViUgbcRuWamUmmAgkl9NEa8egOSOfg8Dk4ff2bYklHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KZKBtfkL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HHOqeu7g;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D80606A319;
	Thu, 22 Oct 2026 08:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D80606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KZKBtfkL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HHOqeu7g
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792657515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdtW1rAGsIKxN6Wm0qAXHuMt9ue8GvhTyEgWLvkduZ0=;
	b=KZKBtfkLOohZWzF4oIYIRhvdb09VOKMPhLw2V8fDhpRHj3h9GnYQMpv0t293qqJqKRwesI
	poOjDC6dfJ/O5p34g8bc4PnV3htPx95LK0LWkXwXie/8G+gvy4siPKGJfubiFgaq9J6U9w
	gcpebuoexjQuyTcFnXnb19cVnUFpKQ6ay4CX4kILN1I97fjvvC1Xh0ZeMv+O/MIbELpwdn
	3enNKb+SEJwwTdgctZJc8VjSa4/UBOANhfkm1mmAPmdN9W6xnZf+LYfqAYLg4PKe1o8RDe
	nI7G8YmDmgyhVjsfrFFGy75F73uQcEPfcBSpTI/YqJgghv4Yj1IEmqOh2FTsng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792657515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdtW1rAGsIKxN6Wm0qAXHuMt9ue8GvhTyEgWLvkduZ0=;
	b=HHOqeu7gLFukHBH/txj8Tw027E18BDEDbfJ71r0uSGIt2a11SNlupFhE0o+/vx1+iw1evk
	eac6JX00Eb8FlUAg==
To: Gabriele Monaco <gmonaco@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
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
Date: Thu, 22 Oct 2026 10:25:13 +0200
Message-ID: <871p9ita52.fsf@yellow.woof>
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
> Well, this would be yet another hybrid requiring BPF monitors registration in
> the kernel like I proposed in the RFC [1], which was the main point of
> contention (that fully shared reactors and sysfs interface, by the way).
>
> For this I would argue, though, that such monitors would be BPF just on paper,
> we wouldn't be able to use many advantages BPF provides (e.g. BPF maps).
>
> The current implementation already shares the header with in-kernel monitors, so
> the actual logic is shared. What isn't shared is the storage type and some glue
> around it.
> I used BPF maps because they offer some nice flexibility especially around per-
> task and per-obj monitors. On top of using more battle tested code.
> I would like to keep that.
>
> Besides, we'd need to be extra careful on controlling the callers. Right now
> handlers are static, so it's easier to make sure no rogue caller messes up with
> monitoring.
>
> What else definitely isn't shared, which is the main point of this whole
> conversation, is trace events.
> Those could be kfuncs. And no matter what you do, BPF monitors will need to
> share the trace events (unlike in-kernel that have separate events per monitor).
>
> In short, I don't think this would be easy to achieve and wouldn't earn us that
> much. (Plus I'd lose the hardly earned Alexei's blessing ;) )
>
> What do you think?

What about we refactor the in-kernel monitors' trace events into a
single one. I am picturing two functions for ALL classes and ALL
monitors:

    void rv_error(const char *monitor_name, const char *message);
    void rv_event(const char *monitor_name, const char *message);

which trigger the tracepoints. And we make those kfuncs. This allows
sharing trace events between in-kernel monitors and BPF monitors.

Then everything else (kernel reactors, users, perhaps even eBPF reactors
in the future) hook into those tracepoints.

Nam
