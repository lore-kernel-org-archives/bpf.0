Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581154;
	b=OcvoYNrM88cWhYyhpVVnRJCW5bC00Nexbmlc5twWr1qrbfrMbp9y6tI+NbpqJ2LG5eB0
	 ByyNlB88y3AFe/m05ludDDQyo+yoUzRN0GMcgAiX/tuCVyeY5zECBzDryL7eiMnQjPR4y
	 duHzM20L75NzMh74rmRtJVXg13+6Q7RVno0icsGBjnPFqd2/wQ4H1e9Svp92DkrhDx8Z5
	 8D0Aowbn4hoY0v05VkH8AmKVWVybvUDFVLhaGfwUXrAORpo1iYi1xu+RSh6RVTEj0yq0n
	 XltPLJ4FcHmbYqysX2ZHEkOCjHnvk+rXwhcC2J21E/qv5PfWUYpEjOH3RZeJ7y65cfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581154;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=jokl2NzuN6rP59MgvZG0IKJjOr16KzDimnhtNpmKlr4=;
	b=OOy/yleog8YBtAFyJ5PKuM+D6y4o/ZSYw9ltPPZnVhyul8oMOOqvxV3YPe6JpjXcWOo8
	 TwVR7+90RNIRfT9gUvk3p3zZ08Nwej+K5Q1+aGNhN3f7MZOlzsCPTTiymojxQTI2Sjrk9
	 /fUM6LuouLuIgLBcfhA0ICcjNN/sz9a8Y2t9DDWCLyRz4P/JqDJ+0+H810o6rUIaAdhSl
	 FEYqu9YFlC1EWqiSsKKbRntqsm9P0Hm3JmYsH0Ys7+mpMzBCVnzmsApZs3IfUibEx2Og3
	 yD51gnsT+X/AhxEHqqRDGYMR1fVKIfGm0DNnpdPLG7IBhyYrZRmtt6f5lFhpBRmbUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tqXM9clm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iLK3iLnG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B11606A319;
	Wed, 21 Oct 2026 11:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B11606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tqXM9clm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iLK3iLnG
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792581150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jokl2NzuN6rP59MgvZG0IKJjOr16KzDimnhtNpmKlr4=;
	b=tqXM9clmNV/dZ5qDdktJYK7BCvz4rLvGReVVaIPiC58YazSkaG95/PmiD4+ZwpbGC2+nP5
	MMCpGIBoxAV6RU+5tzZwORFZZwT0egPkk9EnruDzfa2M0zqX2FuKzywRCtrnghhaIljI8z
	fsDpMzN3cf/z5uoJ4NfNhTn5xaUO0a0ocupRjOPYmYwrotbMsToqLKRXpBvQWUufzG2zAU
	5L6fcwq7TJ2AHovlcoB88PSYArEV6DQpTaNE7MsFyjSuvQbI5Pq1socyOlUi35uOUSZYi2
	38Yoal8Bo9/j7JnoZOvDHoomMbAMjVRNXWwuYvV1bixnPn7SVfP6mvNeUNBd8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792581150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jokl2NzuN6rP59MgvZG0IKJjOr16KzDimnhtNpmKlr4=;
	b=iLK3iLnGcPJeWBqfClmfe1r1rYI1JofLzpyBfF3pBpyc2J5V6rAHX2bYw4scEmaEtSqnEL
	hO0nMDKkOYomu2Cw==
To: Gabriele Monaco <gmonaco@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
 <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
 <87bj8s8ih9.fsf@jogness.linutronix.de>
 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
 <871p9mqcn2.fsf@jogness.linutronix.de> <87ld7trgzg.fsf@yellow.woof>
 <87mrs9q1d3.fsf@jogness.linutronix.de> <87ecdjqxnr.fsf@yellow.woof>
 <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
Date: Wed, 21 Oct 2026 13:12:29 +0200
Message-ID: <878q3rqpcy.fsf@yellow.woof>
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
> On Wed, 2026-10-21 at 10:13 +0200, Nam Cao wrote:
>> I wouldn't enable those by default though, it's way too much noises. As
>> it's for debugging the model, we can have some sort of compile-time
>> switch to turn it on.
>
> That's almost what's happening already, in-kernel use tracepoints, gated by
> static branches. Those are the closest thing you can get to a dynamic compile-
> time switch (assuming such a thing can exist), it's patching the code.

I was talking about how people are going to enable transition events,
not how kernel enables them. Do we expose some user API for people to
enable at run-time (and kernel can use run-time patching or whatever),
or people enable them while compiling their BPF programs. I think the
latter should suffice.

Nam

