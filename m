Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D11449B30;
	Tue, 11 Aug 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465558; cv=none; b=NHUuQFvN+2eJuvkVgtl1iNTKw5QmBLJ4hZk5X8iM+GWMXdtVEyfaVFDKRCiiD6ofuLDfcMdCeWWDZc0SRIy8vxAuRKvEUFMNCPXHX68e8s/n9vxj6JzuxKjO3XiyV7jMH7mTP3z9fplMAJJ2nOvWZCOHXpQTPOoXwQkDufyCIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465558; c=relaxed/simple;
	bh=kT+RZjIs0aoo4WU9r1GFjps7jssTpnsoSowV6PkRtvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=LM0nVocBMxJUHWoVAyDaBWztB4vpStCwhrCCvJkTw1fmV90WfZN0c3jbpB2X1/x6DOqU9Kq2X6FUq0+i9K9spkXS5YG2v/cyZ8TBQ6/zJ84gljR3MPiUBaq89Y379SK0osQ1qoWy+LeDuWowTSqWfC7Fdg8ggWmlrdKA1UlQwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U1nYKXVC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U1nYKXVC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6DBEB4E411BC;
	Tue, 11 Aug 2026 16:25:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2BD9A6033C;
	Tue, 11 Aug 2026 16:25:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA91211C48FF5;
	Tue, 11 Aug 2026 18:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786465550; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6Kp3HefoIknhVRMmBHxHJIgm3y1cQRRzAfaXuLOS1Ho=;
	b=U1nYKXVCWIr/SsumSPSM82tBVRSRbpWrLNYcBWDETLegsTgKp0dbLThusltHwvW3Ai3xkA
	pQwQxbOnF7MT25TNoHpCmuoFUuVOXpF/sqbYfL1aS44Nr9XVg9ImeTcxsDHIg3UE+8lbwI
	QcUmiblTv3tRvXo6d0SBD1YohaoMgTFxuYEF1RW6izq24zuRLMMvxj0PP4lNYBfDBcI7PL
	1VmiNEfg1bVdRd8tan0hO4lZOjXm4LirY7slLDvYHYlI3/97LE7X6738BX0ut29NO/3PzV
	0+GzLkK2Qo/dMNKFq3unpxPtgxFM1c94TxIJkKfeof/8GiZ3RQ2MWHlKy7KFpg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 18:25:45 +0200
Message-Id: <DKM96LSV880C.1QEALTH06N0GI@bootlin.com>
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that
 is still in progress
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
 <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
 <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
In-Reply-To: <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Aug 11, 2026 at 5:05 PM CEST, Jiayuan Chen wrote:
>
> On 8/11/26 10:26 PM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
>> following logs:
>>
>>    (network_helpers.c:309: errno: Operation now in progress) \
>>      Failed to connect to server
>>    send_and_test_data:FAIL:connect to server unexpected error: -115
>>
>> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
>> socket (see settimeo() in client_socket()), allowing connect() to return
>> an error and to set errno to EINPROGRESS instead of blocking until
>> connection result is known. Increasing the timeout value for those tests
>> is likely not a good solution (and it has already been done by commit
>> 2790db208b44 ("selftests/bpf: Improve tc_tunnel test reliability")):
>> they involve subtests that expect the connection to fail, and so
>> increasing the timeout value would increase overall test execution
>> duration again (not only the connection, but any socket operation).
>>
>> Another solution, as documented in man 2 connect, is to poll the socket
>> for POLLOUT once connect has returned EINPROGRESS, and to get the actual
>> connection result through getsockopt: this allows to keep the overall
>> timeout values low for the general traffic, while letting a chance to
>> the connection to succeed even if CI runners are loaded.
>>
>> When connect() returns EINPROGRESS, poll the socket for POLLOUT and
>> check the connection result via getsockopt(SO_ERROR). This new handling
>> conforms to the configured timeout: the polling loop will only run for
>> the amount of time still available, accounting for the time used by the
>> initial connect() call.
>
>
> So IIUC this patch doesn't actually fix the flakiness: connect() on a=20
> blocking socket only
> returns EINPROGRESS after SO_SNDTIMEO is fully consumed, so remaining_ms=
=20
> is always ~0 and the
> overall time budget is still 1s, same as before. Am I missing something?

Hmmm, I have been assuming that this EINPROGRESS could be returned
_before_ the configured timeout depletion, but I may have been mistaken,
it indeed happens only  the socket is O_NONBLOCK, which is not the case
here. So indeed, it does not fix anything for the blocking case, as the
budget is already depleted when getting EINPROGRESS...

I added this budget mechanism to follow up on Ihor's suggestion, so I
either got it wrong, or it can not work. An intermediate solution could
be to exceptionally raise the budget by 1s when getting EINPROGRESS.
That potentially brings back part of the issues he has been mentioning
with selftests duration possibly increasing by a non negligeable amount,
but maybe 1s is a better compromise, compared to my initial 3s proposal
?

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

