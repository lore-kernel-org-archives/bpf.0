Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110646D564;
	Tue, 18 Aug 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057388; cv=none; b=YKV5d8aaK3tXIltEguVrqMZESvY05XEXuXaVUUhOBGv3v/uYnff1IqcbUKGE4zl2nNv9St83FSsHCpYkqCH9kN9jrDMgueKUhuH+puZNQJymnFS99iym/wlMUvZAkEocOq6yie1vrSCoywFF4z7QH/s9V+JhQtGzrx6vvkwyziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057388; c=relaxed/simple;
	bh=Gq2r1FfeEGK0v5W9yu0Rt48rAmYvUZwtw+oK7zZ+amI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gqJdPT1YsvaXDDJGhl4qmhchd5NUUPxuhgY/2Kzm0V4MCtYBQrfPjnandjU44XIyEOhkuA+/nDv6tkpHp+fkX7BrNtHYAOg6PfEC7PpCItRB0KZl6QCznT1xBa718fYUX66aib7r08CmoiLkBgu9O83MEnFdbK9SbPbz0SfBcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l6RIcNPs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l6RIcNPs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B59861A16FC;
	Tue, 18 Aug 2026 12:49:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8854660355;
	Tue, 18 Aug 2026 12:49:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1C5111C70324;
	Tue, 18 Aug 2026 14:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787057377; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zaPuVgk6vBQFQ2iyk57rrQKoeBKvURSjuf5b4I6ULVQ=;
	b=l6RIcNPs1SQmIadkjYJzP2zpSgAveZwq5HUZxoHrNmnaiqAx4/xQwddSE11k8J42pMv9ac
	40qhpa7c+Ty4UlBsGR/V6qpf6GJw2BE7qxPch5p2D+SB+Uac/pF3xCzKE5pWfbmfda2GtC
	pvNPVRrC+3dlfV2DhtnyMREc6qw4AMLaRLp1QzaUg2JeDmzN3qX6CYwPxoeWjb+uu0r3S/
	aUE6py5AwDBhAWiwNcI1Sb0aJnWemjSR8jLnTltgIhCbHFpIT1cZkZQGpb022QoI36zG10
	1/Dwvu4VIuHOkzskahMsBBUfOuCRAvajIPpWPS2KNyo42BfiY5lEAneMAaeArA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 14:49:30 +0200
Message-Id: <DKS2YUE3JPJO.1QKR47OVLV5UW@bootlin.com>
Subject: Re: [PATCH bpf v6] selftests/bpf: allocate a larger timeout for
 connection
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ihor.solodrai@linux.dev>, <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-tc_tunnel_flaky-v6-1-c02ccde847f2@bootlin.com>
 <c7945c532eb31abc4d3fbbd0720d7a1f47eff936621cf8d11ecdfd9aeef27f93@mail.kernel.org>
In-Reply-To: <c7945c532eb31abc4d3fbbd0720d7a1f47eff936621cf8d11ecdfd9aeef27f93@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Aug 17, 2026 at 10:14 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testi=
ng/selftests/bpf/network_helpers.c
>> index b82f572641b7..1fda1fa7281c 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c

[...]

>> +static int connect_with_timeout(int fd, const struct sockaddr_storage *=
addr,
>> +				socklen_t addrlen, int timeout_ms)
>> +{
>> +	int connect_timeout_ms =3D MAX(timeout_ms, CONNECT_MIN_TIMEOUT_MS);
>> +
>> +	/*
>> +	 * Override timeout configuration with a larger value for the
>> +	 * connection
>> +	 */
>> +	if (settimeo(fd, connect_timeout_ms)) {
>> +		log_err("Failed to set connect timeout");
>> +		return -1;
>> +	}
>> +
>> +	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
>> +		log_err("Failed to connect");
>> +		return -1;
>> +	}
>> +
>> +	/*
>> +	 * If the timeout configured by the test is different from the
>> +	 * connect timeout, restore it
>> +	 */
>
> This isn't a bug, but do the two block comments here add anything over
> the code they sit above? The first sits above settimeo(fd,
> connect_timeout_ms) where connect_timeout_ms was computed with MAX(...,
> CONNECT_MIN_TIMEOUT_MS) on the line before. The second transliterates
> the condition on the line below (timeout_ms !=3D connect_timeout_ms means
> "restore it"). Could they be trimmed to a single line about why a larger
> connect budget is needed?

This is slowly turning into bikeshedding (and if the comment wasn't
there, another LLM run could possibly request it to clarify the
intent...) so I'll keep it as-is.

[...]

>> -	if (connect(client_fd, (const struct sockaddr *)&addr, len)) {
>> -		log_err("Failed to connect to server");
>> -		return -1;
>> -	}
>> -
>> -	return 0;
>> +	return connect_with_timeout(client_fd,
>> +				    &addr, len,
>> +				    timeout_ms);
>                             ^^^^
>
> This isn't a bug, but could this call fit on one line? With the leading
> tab it comes to about 71 columns as a single statement, well inside the
> 80-column limit. Elsewhere the file only wraps arguments when the line
> doesn't fit.

True. Will be fixed.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

