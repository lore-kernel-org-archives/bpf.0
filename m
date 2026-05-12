Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBC383304
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553365; cv=none; b=m2/oHGe3L55Jl8TVgt2HUBWoMI0vOvuQdyISB87KpP8wDIO+//9lJeUsZWjoUgBgXKfKAau983+huZzmsFFrVh1ttGmLeShBK/YcIbr1dwphSm6KNOl8g9vovlXQXWnTLBzmy+JKWNRVbpN8QlUOXnA1lm+msKmSgXk+Iljo++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553365; c=relaxed/simple;
	bh=1WslB9UEKKDX1uSJtp8q1keI80QEBI+YCG3k4moOh2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGj/RhyVf/017ABl244GQe9h9Fjj1zJsRjj1tn7uQ+qR0lKQ/NnrI6H5J95irDmJAsIgn5A1jhpIsynGYQUuDSWtiCNPDE8QMG3y7/wDbLMuPOHZ3rvfOyREV+5Dt0fVsIsVKp5a3+ktOApf3NdEJ6gFDYnQUIlMJKhyDN4palk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKTXRBEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKTXRBEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E9C2BCB0;
	Tue, 12 May 2026 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778553365;
	bh=1WslB9UEKKDX1uSJtp8q1keI80QEBI+YCG3k4moOh2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iKTXRBEgibesk6xnXuiJh2CFv3190CoqJjYUn4eSDIcYHMR4hdLCMNmEc9ZLycNKY
	 JWahpekU0hIQKdSAg1AnfcNXz8tV9jDrIzLlVl9JUQ+MzvxlpAdXQIYZipoAgYEjpX
	 2un3S5bx2Z6cL+RCD9SDGUCHlj03wSVOd8c4HRaBgBMWEPBWEOh7xwhK+rZY1k29Qz
	 W3bnqew3NIhBt6Tutw4IRSQCeIMGa0oqsUvHohysrhwJ2m2J8KB2coiBx/UdFFe4Pq
	 FxKPbjNJLu6lDbxysgkQDPKVg7Lni1u15cUamFn+lg87fbDYdyjinO4L58SVrIgjNh
	 wj2/9MkhqmnnQ==
Date: Mon, 11 May 2026 19:36:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <20260511193603.3ef00cee@kernel.org>
In-Reply-To: <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
	<20260511085344.3302-2-mahe.tardy@gmail.com>
	<20260511182019.69ebc7c6@kernel.org>
	<DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 18:59:56 -0700 Alexei Starovoitov wrote:
> unusable toys? What are you talking about?

Please refer to the comments on the RFC. netpoll bypasses most of 
the networking stack. And there either has to be some user space 
to negotiate crypto or this is unusable for anyone serious.

> netpoll is already called from everywhere.

You mean all contexts because it's used by console?

> bpf_netpoll_send_udp() won't add any more bugs.

Same as TLS + sockmap didn't? I spend enough time mopping up after
people.

> I like this netpoll approach way more then creating and keeping proper socket
> within bpf and all head aches of keeping it around and doing send from
> good context. With netpoll all of these issues are gone.
> Just bpf_netpoll_send_udp() from anywhere and it works just like it does
> for dmesg.

No, netpoll is high risk / brittle and tightly integrated with NAPI.

"I don't want to run a tiny user space program" is nowhere near strong
enough justification to expose this API. SMH.
