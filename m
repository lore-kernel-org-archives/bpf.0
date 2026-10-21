Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567611;
	b=rsZICBBp6Qv6YBsd/SH9tq822NyOOwsS7o1j2uXDkdgzYH3x7bMqKAd444GZmuZyUyqN
	 V1kZKnzz04kCrC6baNvr569buybClQMyJrkW1aEXFYGwuzXJVt8Phxf+v3/mguE39kboQ
	 Xofd5d/r2wY9Uiu9pRK3HKqnTid6vY0ltRmvzY/I5Et9+xKbwXz84GRlIaYoxedZH6zxe
	 DaduHbtEUyM9/9jVsjFiI9sew/8N8xAbrDtxdP/tFOcwemqLa1Tn0Z48eiPIB/jLqkzC6
	 ICIMLM/NI2XFSFTyz2fHyRyWPzyvUmgebQqyUNnLZFtX/ltCiKzpYa82blmKMJpIzgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567611;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=MmY/Cqb/51x27vhDGhhClvRe7mwYyr7WYVbHZ3b+GBs=;
	b=eOOThRAQn3us0gFB/5LW6lVOw3JBe6alA2RvLZValYzRQa3JU2SSL5Dr9ibAMHi0lC9d
	 LoJ5w/09SZJ+1A70T+PeGAv5wPG6fXWr1ZtL65KlxznjJ/nlm2o4KmBYI/PFDE6u/kYfL
	 8XtvwTkKNWe1+AthjCVOoPYcVBODsjt2P6fXuNk/LzF78Zg0wWKOa6FqcgjR/ylkpuzXy
	 JYbaBIGd0YdtuH/Wa+Jzwvd8I9xbLgmKqHu6AYPDSZDZ67Xp1orvR+8MoBIAuxyPp+ARL
	 312z86JRvjIRRTRnIDbyAU4yKjZeGNe9iQzqs+xWZTl0tSUmyD35cIskc68DzkBqMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pVeemAe0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="hHJqxrN/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D774606A31B;
	Wed, 21 Oct 2026 07:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D774606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pVeemAe0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hHJqxrN/
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792567607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmY/Cqb/51x27vhDGhhClvRe7mwYyr7WYVbHZ3b+GBs=;
	b=pVeemAe0oC7+BXr2Nm5S22/CDr1Fs8NBhSgl4XA8ij0Z21b54dIk//ioyijJPBNvm5gT4D
	/6vTxMT+dsxaB6br0Dh63C4vkY5QFwm3lTBGnxY6TS1A9c4AI2tMnvxQiQnG4YactPoaXJ
	5DOfSCvGnhemTzZc2EDs9/9Rc5BWOTtTgaHNP8AlMtrKLnOD2Eb5BZJ2f1dHPByhLtaOi7
	/BqEKdAA6anfukRbswNsV+hGU74DONvETLyzCKQrgz7ncu6kJ3M1vRi8rbzpCe4JT6fZ+F
	Mj0xCn2S4VBVySzK6ogYPgWb9tsvnNXcDeAAUjcAs30V2xy+NzpTgUgtZbKaxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792567607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmY/Cqb/51x27vhDGhhClvRe7mwYyr7WYVbHZ3b+GBs=;
	b=hHJqxrN/mmcQYiY62HFm6wBzMv2y5I6wLjiF79tC7PsdDuenyjthDa5EioiP6OFshnScTD
	AhGTvvyxpNgL0/DQ==
To: Tomas Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <CAP4=nvRhd1d+o8O045LB=dcYa2UudH7ZbG388wcwEX+JNBWY=Q@mail.gmail.com>
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
 <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
 <CAP4=nvRhd1d+o8O045LB=dcYa2UudH7ZbG388wcwEX+JNBWY=Q@mail.gmail.com>
Date: Wed, 21 Oct 2026 09:26:46 +0200
Message-ID: <87ld7rqzt5.fsf@yellow.woof>
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

Tomas Glozar <tglozar@redhat.com> writes:
> I was talking about preventing other (non-RV) consumers of
> bpf_trace_printk from seeing the RV prints. Eg. if I create a tracefs
> instance and enable bpf_trace_printk, intending to see my own debug
> prints, I will also see debug prints for RV, unless I explicitly
> filter them out. I get that on the RV side, these are mostly
> equivalent.

I haven't used BPF before, but is that not an RV-specific problem? If
user has two BPF programs running that both do bpf_trace_printk,
obviously they get mixed prints. They can either filter out other
prints, or stop running the other one.

Additionally an RV message only appears when something is wrong. So when
there is an RV print, there is a bigger problem to worry about.

Nam
