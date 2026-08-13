Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086A34DCC8;
	Thu, 13 Aug 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606167; cv=none; b=TONzw1LtaQmXzEUWbHi2FTsELciiZA3tP5JZh+ETqpfUl3gGaHGuXn0mBt9ff1dw9eKLBywhxgt7SR+P0HlFAksKj3bzxEre0KQVayHDpgSSJT68IhR9ObDtRclAcwgH/sSFinRSWYCXm27Pg1p0J7HpUZHyOl5PH/zQ+bRRyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606167; c=relaxed/simple;
	bh=S/VAShHcevrViJB8wQhNtkhVJSComrICQ4y7x9+Ze1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=I9YT8ZcVUWbMikmneLagLvDCa/Mk6O9o3KrhZ/TOexQhxbnglW1QbePZXEfzvTlxDsv0WFUDtKBE39eSp7TBrYyEmP+ApLIqucjI87zz4X0DuJW6KT1RekzpTm08sGhq1JwAHpA+Dr8Wak1ieFHvi5iR6S2laaVXE0je/wYW2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xXGXcOcV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xXGXcOcV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AED2B1A15DD;
	Thu, 13 Aug 2026 07:29:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FB23602B8;
	Thu, 13 Aug 2026 07:29:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9755911C4DA21;
	Thu, 13 Aug 2026 09:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786606158; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L4ojeu33ip8jl3mLzSpKehc1PAPxLG2vivjYcXSyHZ8=;
	b=xXGXcOcVfWUha/cSmkh4IgRV6/SWTLYdLNbgw2VX7k2k2IlXTyqH4L6FqQX8LmWWvRD7zj
	gJ6f4RToyCtqP/hqhDH326qPjN7fZmLlHEa/eDKbTRaGyz0EFfy7E84x+zLbH+z72fl//t
	yqgY5ldqLopa+9OopMNcZnsOfGhxTYiSJqkLFIcbvQA9GLhpEzjZpggXp519Wrmcw11ntb
	MQb/gssJtipdCIjONsZdIGlHrTKtqCO5jvBtSksvpoLkIdvde0P7SrTD+kRB8H4vovBjXD
	bBuKo7b/HPXjbYZ0G3BIY8Ugd5V/zPBFRUiAkeJt6OeHvUR1bRIfb5571joBxw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 09:29:14 +0200
Message-Id: <DKNN0WMD9XW8.MCJAMGS5NPYR@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that
 is still in progress
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
 <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
 <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
 <DKM96LSV880C.1QEALTH06N0GI@bootlin.com>
 <d92da576-4930-4b10-b8bd-ea1158ec08bc@linux.dev>
In-Reply-To: <d92da576-4930-4b10-b8bd-ea1158ec08bc@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,
thanks for the extensive investigation

On Wed Aug 12, 2026 at 8:46 PM CEST, Ihor Solodrai wrote:
> On 8/11/26 9:25 AM, Alexis Lothor=C3=A9 wrote:
>> On Tue Aug 11, 2026 at 5:05 PM CEST, Jiayuan Chen wrote:
>>>
>>> On 8/11/26 10:26 PM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:

[...]

>>> So IIUC this patch doesn't actually fix the flakiness: connect() on a=
=20
>>> blocking socket only
>>> returns EINPROGRESS after SO_SNDTIMEO is fully consumed, so remaining_m=
s=20
>>> is always ~0 and the
>>> overall time budget is still 1s, same as before. Am I missing something=
?
>>=20
>> Hmmm, I have been assuming that this EINPROGRESS could be returned
>> _before_ the configured timeout depletion, but I may have been mistaken,
>> it indeed happens only  the socket is O_NONBLOCK, which is not the case
>> here. So indeed, it does not fix anything for the blocking case, as the
>> budget is already depleted when getting EINPROGRESS...
>>=20
>> I added this budget mechanism to follow up on Ihor's suggestion, so I
>> either got it wrong, or it can not work.
>
> Hi Alexis,
>
> Looks like my suggestion was bad, sorry. Jiayuan is right. I didn't
> realize what -EINPROGRESS actually means here.
>
> See __inet_stream_connect() in net/ipv4/af_inet.c:697
>
> 	err =3D -EINPROGRESS;
> 	...
> 	timeo =3D sock_sndtimeo(sk, flags & O_NONBLOCK);
> 	...
> 	if (!timeo || !inet_wait_for_connect(sk, timeo, writebias))
> 		goto out;
>
> -EINPROGRESS is a default that reaches userspace only when the wait
> expires. Every other exit sets a different error code. So on a
> blocking socket -EINPROGRESS does not mean "connection started", it
> means "waited the whole budget, gave up in SYN_SENT". On a nonblocking
> socket it means the opposite, and man 2 connect seems to only document
> the nonblocking case.
>
>> An intermediate solution could
>> be to exceptionally raise the budget by 1s when getting EINPROGRESS.
>
> I believe you're right that the flakiness can be addressed with bigger
> timeout, which is why v2 fixed it for you. But +1s may not be enough.
>
> IIUC the way the helpers are written cause -EINPROGRESS instead of
> -ETIMEDOUT. If SO_SNDTIMEO is not set before connect(), the kernel
> reports plain ETIMEDOUT, but it is set in settimeo().
>
> I vibe-coded a userspace repro: loopback listener with a full accept
> queue drained at t=3D1500ms, so the handshake completes at ~2040ms.
> Caller asks for timeout_ms=3D1000, like tc_tunnel:
>
>   mainline (blocking)                     budget 1000   FAIL at 1016ms
>   v3 (blocking + leftover poll)           budget 1000   FAIL at 1015ms # =
my suggestion
>   O_NONBLOCK + poll(timeout_ms)           budget 1000   FAIL at 1001ms # =
Jiayuan's suggestion
>   O_NONBLOCK + poll(3500)                 budget 3500   OK   at 2031ms
>   blocking, SO_SNDTIMEO raised to 3500    budget 3500   OK   at 2040ms
>   v2 (blocking 1000 + fixed 3000 grace)   budget 4046   OK   at 2067ms
>
> Everything that gave the handshake more than ~2040ms passed. Blocking
> vs nonblocking makes no difference, poll() vs no poll() makes no
> difference. We just need to increase the budget for connect().

Ok, so indeed the poll() loop complexifies the connection helpers
without much gain.

> I don't think swtiching to O_NONBLOCK makes sense. Apparently, it was
> nonblocking in the past, see 99126abec5e5 ("bpf: selftests: A few
> improvements to network_helpers.c")
>
> So I think we can introduce a separate connect() budget, similar to
> your v2. And then use opts->timeout_ms for everything after. Something
> like this:
>
> 	#define CONNECT_TIMEOUT_MS	5000
>
> 	static int connect_timeout_ms(const struct network_helper_opts *opts)
> 	{
> 		/* don't shorten what the caller asked for: tc_redirect
> 		 * and xdp_synproxy pass 10000
> 		 */
> 		return MAX(opts->timeout_ms, CONNECT_TIMEOUT_MS);
> 	}
>
> and in connect_to_addr():
>
> 	fd =3D client_socket(addr->ss_family, type, opts);
> 	if (fd < 0) {
> 		log_err("Failed to create client socket");
> 		return -1;
> 	}
>
> 	/* SO_SNDTIMEO is a ceiling, not a sleep: a wider handshake
> 	 * budget costs nothing on connections that succeed.
> 	 */
> 	if (settimeo(fd, connect_timeout_ms(opts)))
> 		goto close;
>
> 	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> 		log_err("Failed to connect to server");
> 		goto close;
> 	}
>
> 	if (settimeo(fd, opts->timeout_ms))	/* data I/O budget */
> 		goto close;
>
> 	return fd;
>
> close:
> 	save_errno_close(fd);
> 	return -1;
>
> This is simpler than poll() and retry loops.

Ok, I'll give it a try with this simpler connect-only-extended-budget,
without the poll loop

> An entirely different alternative that Eduard brought up in an
> off-list discussion, is to drop all the timeout machinery from
> network_helpers.c altogether, and rely solely on the test_progs
> watchdog to kill the subtest processes: d9d4d127e813 ("selftests/bpf:
> watchdog timer for test_progs")
>
> I am not convinced it's a good idea, because I don't know what will
> happen with all the tc_* tests if there is no connection timeouts. If
> you're interested, you could try it and see.

Hmmm, I'm not very familiar with this mechanism, but aside from the
potential issues you are mentioning, wouldn't it make us loose a bit of
info here, when the watchdog kicks the runner out ? We may know from the
stacktrace that the subtest was in connect(), but we would loose any
formal error/errno on connection timeout I guess, and I am not sure how
confident we can get about any watchdog kick being a connect timeout.

>> That potentially brings back part of the issues he has been mentioning
>> with selftests duration possibly increasing by a non negligeable amount,
>> but maybe 1s is a better compromise, compared to my initial 3s proposal
>> ?
>>=20




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

