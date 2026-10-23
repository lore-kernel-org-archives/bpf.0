Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767617;
	b=BEhHzzrxAxbyo/8gTm2ZbxBC848VljfKpYGp/0Ad7BX9nWYAG1XCje/pjU4CSbupM0Jq
	 5TVIKARHiTzJPE/wEVdeFg89H0d+MQzTcAZPHGBfsXwZajfEE2af0Bgf/etMgLSgGQTYT
	 xKE6FdHzF+jiloT997UgnyVpcwt8IuR+JSDauxRxUmG38kyMUhcTg9dV3eAadSZ1BLXYo
	 F5Oxiq2Rt9ITZ+xia6zSNnKzjD5qpBaS7FCq1J4FWbca41eYVGe6mAJv/5FytIWgWMhPf
	 hapArkvpCL5jR1x8/icLecyRSLssoei1aU1bp0nlgGlW5VLnh5K1rUviXdXVjBGjg0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767617;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=1lWMhA1bQ2yHwuqf8gHmpbMxtpUWrTLQQpjIrzyOuEM=;
	b=nVIW5+UMQ2nWUvxiJ3q7rVhwJi8Bup72AoCnIv4yq/O+M4X4BD4lQZ6gWdydiapOzxJw
	 4sFY5a2t0kySLWaOaZZuaY5AVhycwGxi5R17Y/SiJS9i9MoQ0bmOTesfnJU1u9n1h1qqz
	 M/C6wriay/Ij0hXR4RG3jio84TPX7PAgOwfwpGOHmCpUyzzo4ZdA0WC/K8XCNyBT42/LL
	 Nhj8B/g63mOzZcmRISSlFHITY0HpLVi6GTFK1NT23EnfXd2Bu32QaVOS4YslZVAxqApTM
	 kNyrGtORJy0W9Xkqh76HuhcCkQfznb+G1skNkxKgIcPVvyYnOtKNDryVCDFEfC/b4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ja55ckul;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SyVdKzd3;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624E606A320;
	Fri, 23 Oct 2026 15:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8624E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ja55ckul;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SyVdKzd3
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792767613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lWMhA1bQ2yHwuqf8gHmpbMxtpUWrTLQQpjIrzyOuEM=;
	b=Ja55ckulQnInpHCZq6lTIT7NkcKRYSnuqjkdlwv15W/mx0qqni/jhOlH3UP7AwpM1WvGtf
	eq3qpnE4YAe/LqFojE7gjKOrJLANFJFMpg/Y7s8t/cGv1wmgG5krd1RUyKUQcA4XsDkobY
	dmYf+Agz01vs8F4794xYNqqK2C0oHvIzT/vonCyIUAyvYA4GLLmqJKC5+YW4tYg4jzqMJv
	ezVGFi5B04sFED6poKUaORVsHfzH8NQvQO8yUpKqPe+JH+n3JirRY6+qYXHEBl7OkUOD8T
	xAci9YklgWEwh5bZoT6fgVKNu6ynZownYRhBtgQmoEh27tlWN1XhX1jT1M1dtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792767613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lWMhA1bQ2yHwuqf8gHmpbMxtpUWrTLQQpjIrzyOuEM=;
	b=SyVdKzd3XEuzytIIoguSI6DLM6smCU0LbIq5U/HKMV20iFVHaDKBSM5vlu7gsda7FweoKj
	xjvrE9P2KymVEEBg==
To: Gabriele Monaco <gmonaco@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
 <871p9ita52.fsf@yellow.woof>
 <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
Date: Fri, 23 Oct 2026 17:00:12 +0200
Message-ID: <87fqxwv4w3.fsf@yellow.woof>
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
> That could work, though we'd lose some ergonomics around filtering events, not
> so much in the unified tracepoint thing but in what fields events have. We would
> need to parse a string (so I wonder if globs can express constraints like
> matching whole words or we'd need to arrange the format to accommodate glob
> limitations).

Yes. But the transition event thingy (not sure what we are naming that)
is only for debugging RV, and the error event should not appear
often. So I think some parsing overhead is not much of an issue.

Nam
