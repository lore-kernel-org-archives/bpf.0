Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601277;
	b=l4fjWh27xtZx68kg4TygVAi6nJc9TJ5/vdBS2wAlt+eOT0QVW8l5JqeP1endY9iDY7rw
	 H5wW5CcqUVoKzMVI/maErteYeQcB2Wz2xtMmHdqq0Q22JCuJRrQU4+vaTkk6n3lpd7so4
	 GIvB4qEnWMnsPpUZyIgORjzqrjyMnR80Md25+At3CChsmvhZ6hj3vHUxi/d8fdNu1mwP2
	 xxE3enXPGdJPFSCXyhgJqyJeJgZEQeeSsVO+BPf8TmgkwJbKsCuM/oLczWwXHEEaDTY9z
	 FSmWjfyFl5UvMv+MyT8Q5uxHaFaKuyiQ5Z3HImrU6de+8VC3zuqi3fzSszlUlrxg2nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601277;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=31usUnW4ODC36qUh8fuNmRwGkC1IR0lXVsQJbpp8rl4=;
	b=FrgdZLGNYh0QcznIG95OzGQ1S6W2QnT/LnZtMB8ZrQYz9BwEyzdpzbsb7poIZNDK0QkQ
	 9VXBV6+ZH6Mva/5ySHtc6NMQYZjUOaJ1AI7KSJBLKZT1nGHkGV8iAxeZHhVRunYArOTvF
	 M0/Aii/LPgirsSAdTY10b62y4rW1wyR9SkTerIfBIkb4Iy1pUBAZZDJG6g4TBcUDOxXEZ
	 NbN24xk6PpmmmX88+buMMR863DM0Sr66B+aAW2hHcfxxlknjFLeFx61NQMI9dNbJs7F8p
	 NHC3RguuKw/YLhB+2iLTNEY1k4fOaIMtkZZKjaO2Jo0anRvZcQ3S8M2+JTD3DR9UwYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SPcmhiTO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VWvD3Eo4;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05456606A319;
	Wed, 21 Oct 2026 16:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05456606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SPcmhiTO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VWvD3Eo4
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792601274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31usUnW4ODC36qUh8fuNmRwGkC1IR0lXVsQJbpp8rl4=;
	b=SPcmhiTONIz2mFY6TbdupPeG3Znj5JmktovOePmdvsNlJFU9zt7XhNS+ndTo/ZEm8+TdHQ
	3eG9+O97LWRnu2VizuL1dcyoFv5rj7o0qYhUOF5hbcYcqtmcu6cyPjfYW7SNDZ4QS+knaF
	U2wJ6I6sKg48KpItSonCpcuz0BS4Zw6XYAfb+lQQmiXUfnv3VEqCJ5f1ZTdvh4l0Cx6EGK
	8ocJrjGApS3pnT0z1PUvSRP72ZJzjeYzqROavzEnsN2AK+tPVOUXJTupNSXY5Pix/TF9N1
	W/715TqPFXhzrMoHSFHxYB9Qmgex6v0YNeeLcXzQ/jmGPWD0TsnePjN8YfN4ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792601274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31usUnW4ODC36qUh8fuNmRwGkC1IR0lXVsQJbpp8rl4=;
	b=VWvD3Eo4Z+PAbHYAkP+MgCt1Jxwhy7DalH1DVBHBkZN1WPcPm2fKIsDLYI3/fxpdmzD/ms
	Sm+VxCq69zW5ffBg==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
 <87pkx5q1w4.fsf@jogness.linutronix.de>
 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
 <87h5ifqy6w.fsf@yellow.woof>
 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
 <20261021094853.29b9f7be@gandalf.local.home>
 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
Date: Wed, 21 Oct 2026 18:53:54 +0206
Message-ID: <87h5ifvw3p.fsf@jogness.linutronix.de>
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

On 2026-10-21, Gabriele Monaco <gmonaco@redhat.com> wrote:
>> BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
>> monitors? That is, for those cases that do not change often and has a
>> well known model, to simply keep those as modules and hard coded.
>
> In my opinion it is possible and I'm designing every change with that
> coexistence in mind.
>
> I would say we could only drop in-kernel if BPF does such a great job
> to cover every single technical and non-technical requirement or
> use-case, AND if it makes maintaining the whole thing easier.

I am wondering if coexistence should be the goal. For example, the
monitor classes (DA, LTL, HTA) are only implemented in the kernel and
provide kfuncs for the state transition functions to be available to BPF
monitors. I would expect that this would allow BPF monitors to have the
full functionality as in-kernel monitors, since the events, errors, and
reactors would all trigger from the monitor class code.

John
