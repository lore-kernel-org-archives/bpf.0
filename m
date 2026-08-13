Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B43F0A8C;
	Thu, 13 Aug 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648022; cv=none; b=SNRwak3Of1P+1EPaLmjXA60uViBARAjpx+whiTOhMdBEsIzDJqXdJLAe8ktonWxsRixkkchC2S7olwFEcWwGqTtmWwAzlXMghtxRSddObGXyp2H/v6ZpWophGrRtbl0SKmwk+BWJ6yC7nTycz4JnDZLrBBbmL19v4INFHmTpi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648022; c=relaxed/simple;
	bh=I6HZENCbkK0H7LIhHlGg/StmIj5irvrNVH9hPo3Buzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=BWffWf+EhI79ctgTE/RuwgJh0oDn4LSPhan048CPd4eYAbtRHvdBf/LJCafoWJm8Gle89vzNIGILpQfxOabclw9omv6tXD0XzMggh9Ujt1MszY/gxi49Zrv2J4R9uhgwgM6EoHs3eKPczrduOg2hZCd8h0cBmxj6d29XUVfqQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zxV3Sej0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zxV3Sej0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EC1444E4120B;
	Thu, 13 Aug 2026 19:06:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7B225FF0B;
	Thu, 13 Aug 2026 19:06:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08CB211C4E340;
	Thu, 13 Aug 2026 21:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786648011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B59fl9QIx9ohhPU7kIBieVV7W7ojR83QgOwZM21uQ4Y=;
	b=zxV3Sej0XtQctvH95beJkvklN42MnNDzqk915x3D8+n7995OvzCFItpJUQ0vArA0eXNGzD
	ARYsCuclYHetjbv1nvOJ9Xfb2aK8Y2AWCttpfvvCdcslk9bge0uhs9L6mRY5iaU9PBIcPs
	ltfmjNKI98P8NpG2NkdBtiaewkZMTT9GRnM+rDFm+DXPLtut95EslwbnDPORLPeTQA2ae6
	Nnr+UkhF+BFrXbyx8pD5Ikf5G+40lfPW2VA9JRcEr6/OPpR5OngEdLEJSh9Kn2Ytub0rLD
	+oyDKNP/tbtVlsrwCfccxmKQ7gnhNd1XxdtMSsq6jHgSF4U6Gw/5uLb8M1ZpfA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 21:06:46 +0200
Message-Id: <DKO1UZCX0LFJ.3SSPJ0ZBKTUTN@bootlin.com>
Subject: Re: [PATCH bpf v4] selftests/bpf: allocate a larger timeout for
 connection
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
 <92e15af5-b490-4a4e-a908-9a6320da6583@linux.dev>
In-Reply-To: <92e15af5-b490-4a4e-a908-9a6320da6583@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Aug 13, 2026 at 8:55 PM CEST, Ihor Solodrai wrote:
> On 2026-08-13 2:38 a.m., Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
>> following logs:
>>=20
>>    (network_helpers.c:309: errno: Operation now in progress) \
>>      Failed to connect to server
>>    send_and_test_data:FAIL:connect to server unexpected error: -115
>>=20
>> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
>> socket (see settimeo() in client_socket()), allowing connect() to return
>> an error and to set errno to EINPROGRESS instead of ETIMEDOUT.
>> Increasing the timeout value for those tests is likely not a good
>> solution (and it has already been done by commit 2790db208b44
>> ("selftests/bpf: Improve tc_tunnel test reliability")): some tests
>> expect some data transfer to fail, and so the timeout value would
>> increase overall test execution duration again (not only the connection,
>> but any socket operation).
>>=20
>> Another solution is to allocate a timeout budget specific to the
>> connection: we can apply a larger timeout only for connections, and once
>> the connection is established, set back the timeout configured through
>> opts->timeout_ms; this would allow connection to succeed under heavy CI
>> load, while keeping timeout reasonable for the rest of the test traffic.
>>=20
>> Set a larger SO_SNDTIMEO/SO_RCVTIMEO for the connection step, and reset
>> it back to the timeout configured by the test once the connection has
>> succeeded.
>>=20
>> Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_help=
ers.c")
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>> ---
>> Hello,
>> this is the v4 of the series aiming to reduce the flakyness of
>> tc_tunnel/tc_edt tests in CI. This revision takes a step back, based on
>> Ihor's tests,  and drops the poll loop in favor of a bare, larger
>> timeout value applied only for the connection step. The main downside
>> of this new mechanism is a slight increase of the duration for tests
>> expecting a connection failure. In my testing setup (x86-based Qemu on
>> my work laptop), I observed a ~10s increase (on a ~5m18 base for the
>> whole test_progs set).
>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> I think it's better to fix those comment nits.

ACK, I'll send a new rev then.

Thanks,

Alexis
