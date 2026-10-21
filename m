Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570395;
	b=eVRo2/qgUSxNT+LPAPZMATKYo8zLdrRT+BL7grYm0Jc4dVnbiPabgj1y4yN6w0llDyLz
	 D3In9zfxMVhEZwz4Q3qGBJ6lktnXbZWU+mcpi2HfzhOGfGUp12WeYdWYyZ6XjU0+kx41O
	 NddYJNh3RnwK9FUMsTB5+XVUccFAOaSif667OO8WAjWPBptuY2ogdB38g81D1kNqlYvb1
	 4mrIkYfzbUPT/QBWWJ+NHnN94U+yvUKEm7iHcH7WWsocHgR6no5/TBJZJ6Zv0MAOGRSm1
	 RmbTGp0aP+Wz8uazi7vWOLMyg97PX8qFCwlMbZdDE0ivfS7g1J1NCzlTXc3DuSj6uDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570395;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=MfI4kDTikSzCsjWhrmPwGoETAFbx0LQKhs0E/LmGsFA=;
	b=E++dMzBAkfj8eD6AMahGHhyDBPdwLrOQer2ftMAQ2WfU0kV3knlmmHWsUV1B85eQmEmp
	 eiSiBuJ5D91HVzp6ILO5WsqUv04IA16kM8wMuwAHQdV4RSSwY6BA/XRENyzCpgQ4HwNaf
	 7sGy4lek+/rwkNQFj3NnSDlGsTefbXeoz4j1VkTdOrskLvJbXj1ArPDDSinJBt3oX6/gT
	 V7GciKlXMXWaGqczuZf79phrFkV/5PrCM7kow1W9242h/mhY2VI1yWr9EaMDWHmkANw7U
	 5U/RxeAJIhk9MF8OWFTbKfvsFKMjg966qOc2S8OwOGQYER+veA4O2Ic0QqHVYkoqsng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kqSxzlYP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=XAgOtmoQ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A5606A31F;
	Wed, 21 Oct 2026 08:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17A5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kqSxzlYP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=XAgOtmoQ
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792570392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfI4kDTikSzCsjWhrmPwGoETAFbx0LQKhs0E/LmGsFA=;
	b=kqSxzlYPJ+khrBAGYireBrpgFbLRXyBKaWQR76OomEL7+aIIumgIKk2OCoeIaBeBAydyhp
	G8Up2wYhOA4VETp6I1GjrTqqPd/jx4m8X1Rx+k9eu1sV/bI1Os3wl98v9gG2zl3UNndLGd
	6Jw+8iIkFMCJdJnzqDlrrj5eHTSl6IwwKp13zPIunffGKFXI5cnOoKRsb1006td/+stV3G
	FN7EeHX7HW6I1fSk7MEXK5Iz7/mB0No7XxwqMyw6e0DJb/tmS24tkDQ1IZVuU268t21glm
	C/y4yeKlk3HdbZU0jgl8x4D8hjPgK+DI0co1A1nMDeyMPcZWqJSjjpOvsrmp4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792570392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfI4kDTikSzCsjWhrmPwGoETAFbx0LQKhs0E/LmGsFA=;
	b=XAgOtmoQV/ZPHNasUxhxT2Y2p/JSatRixfq9jm7SVEmKCktK7zfkJ+A9KKYNIc/ncdaW1G
	BoIeFil4P88cpaDw==
To: John Ogness <john.ogness@linutronix.de>, Gabriele Monaco
 <gmonaco@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <87mrs9q1d3.fsf@jogness.linutronix.de>
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
 <87mrs9q1d3.fsf@jogness.linutronix.de>
Date: Wed, 21 Oct 2026 10:13:12 +0200
Message-ID: <87ecdjqxnr.fsf@yellow.woof>
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

John Ogness <john.ogness@linutronix.de> writes:
> On 2026-10-19, Nam Cao <namcao@linutronix.de> wrote:
>> John Ogness <john.ogness@linutronix.de> writes:
>>> @namcao: Maybe you could chime in if you want the transitions as events.
>>
>> No. Those are only useful for debugging RV itself and do not need to be
>> upstream.
>
> Sure, but debugging RV itself _is_ a use case. Especially when RV moves
> to eBPF and lots of people will start writing their own RV monitors.

Right.

I wouldn't enable those by default though, it's way too much noises. As
it's for debugging the model, we can have some sort of compile-time
switch to turn it on.

Nam
