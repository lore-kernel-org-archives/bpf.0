Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E731A07F;
	Tue, 11 Aug 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464133; cv=none; b=J+nGvqKW4O+UtzLOgh1i/YehRODIKVRzZRhthhoHDXJCxjlt6cSzFMo4w6R9fDsFQIM2CsVW1UbnpAPmHlb02pcoDPh9FyczUa0px4gl7nMRnDeH8qR7ZIlwKhnvJc6bh8SEXEWUKWJUlLHP2y2C29rz+9AQVEt2wmwz+LuIBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464133; c=relaxed/simple;
	bh=fpm8MYDcbycUyzw1ZHMxVnJF+G4TOcIz/O+cE2Wi2zo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=ILIrrdsg57VJKmBcrGOuG+D1Jr9SjPXjPrEIat8HLZ5weadJyxk2DM5hd7gWLAbbTwrhpapFxiTT22TbVoTuDP8IWwyuS8YVitqtswyoJOONuEO38TsyODogv1XCgbxg6R6L6LBgHmK9JsYKsVNCfQFS+u/YOsBeT5xK5XPB2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ms7+bHPR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ms7+bHPR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F9461A1569;
	Tue, 11 Aug 2026 16:02:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6936E6033C;
	Tue, 11 Aug 2026 16:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB40011C48F43;
	Tue, 11 Aug 2026 18:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786464123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ImJ9NdLaQd8W1XCZx8eTnRD/mgTjVGIfA7VAn+AVSzU=;
	b=ms7+bHPRfCtZgQkipEYUqd+R+7+VTlLfalEwMJo7KlJWRkPfMEM1YmINcP9W+NOp1XQJco
	65V1sIm2O1DBJhld3lXjOUzCrpaGZZcAhr5WO/3kyHpyOOaiPdTFWE+2vkXLLR89z4Yh8Y
	PV+Kgv6JrVCJdW//Z7GaTQoRX0esrl3o6daO+Q7Db/SLu+hbyTN2jHTS2HUnEWYr0wJA+5
	14AHNo6S6wiIOy/UqAZGVvcwDQ4NAFjk7Zi6vJ/bRpKDZfXf5HIksBFfPR4z8w/6GJ052m
	LCA67Li+plncZPzjHzuKarTr7oR05/pSTCygOk62d6dsC/nATKofNCBSABIbWg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 18:01:58 +0200
Message-Id: <DKM8OE4Q8051.2HW18WLYW4LBA@bootlin.com>
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that
 is still in progress
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
 <9100335a46140b0e6aa30d49dad88a74afd532c1c924580012a4b3450c004edc@mail.kernel.org>
In-Reply-To: <9100335a46140b0e6aa30d49dad88a74afd532c1c924580012a4b3450c004edc@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Aug 11, 2026 at 5:30 PM CEST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testi=
ng/selftests/bpf/network_helpers.c
>> index b82f572641b7..25e4d2fa6f6f 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>
> [ ... ]
>
>> @@ -305,13 +309,69 @@ int connect_to_addr(int type, const struct sockadd=
r_storage *addr, socklen_t add
>>  		return -1;
>>  	}
>>
>> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
>> +	start_ms =3D get_time_ms();
>> +	err =3D connect(fd, (const struct sockaddr *)addr, addrlen);
>> +
>> +	if (!err)
>> +		return fd;
>> +
>> +	if (errno !=3D EINPROGRESS) {
>>  		log_err("Failed to connect to server");
>> -		save_errno_close(fd);
>> -		return -1;
>> +		goto close;
>>  	}
>>
>> -	return fd;
>> +	duration_ms =3D get_time_ms() - start_ms;
>> +	remaining_ms =3D duration_ms < opts->timeout_ms ?
>> +			       opts->timeout_ms - duration_ms :
>> +			       0;
>> +	if (!remaining_ms) {
>> +		errno =3D ETIMEDOUT;
>> +		log_err("Can not poll connection, already in timeout");
>> +		goto close;
>> +	}
>> +
>> +	while (remaining_ms) {
>> +		struct pollfd pfd =3D { .fd =3D fd, .events =3D POLLOUT };
>> +
>> +		start_ms =3D get_time_ms();
>> +		ret =3D poll(&pfd, 1, remaining_ms);
>> +
>> +		if (ret =3D=3D 0) {
>> +			errno =3D ETIMEDOUT;
>> +			log_err("Connection timeout while polling");
>> +			goto close;
>> +		} else if (ret < 0 && errno =3D=3D EINTR) {
>> +			duration_ms =3D get_time_ms() - start_ms;
>> +			remaining_ms =3D duration_ms < remaining_ms ?
>> +					       remaining_ms - duration_ms :
>> +					       0;
>> +			if (!remaining_ms) {
>> +				errno =3D ETIMEDOUT;
>> +				log_err("Connection timeout after signal");
>> +				goto close;
>> +			}
>> +		} else if (ret < 0) {
>> +			log_err("Failed to poll connect status");
>> +			goto close;
>> +		}
>> +
>> +		errlen =3D sizeof(err);
>> +		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
>> +			log_err("Failed to getsockopt");
>> +			goto close;
>> +		}
>> +
>> +		if (err) {
>> +			errno =3D err;
>> +			log_err("Eventually failed to connect to server");
>> +			goto close;
>> +		}
>> +		return fd;
>> +	}
>
> Does the EINTR branch need to continue the loop? When poll() returns
> EINTR, the code recomputes remaining_ms but then falls through to
> getsockopt(SO_ERROR). If the connection is still in progress, SO_ERROR
> will be 0 and connect_to_addr() returns the fd even though the socket
> is not yet connected.

Argh, I accidentally got rid of the continue that was in the EINTR
branch while reorganizing a bit all the branches. And it then defeat the
whole purpose of the EINTR branch... Will be updated.
>
> Also, no path inside the while loop reaches the loop condition again -
> every branch either does 'goto close' or 'return fd'. So after the EINTR
> budget recalculation runs, the code never re-enters poll() to use that
> budget.
>
> Would adding 'continue;' at the end of the EINTR branch fix this? That
> way poll() gets called again with the updated remaining_ms, and the
> connection completes properly after a signal interruption.
>
> Test_progs installs a SIGINT handler without SA_RESTART in
> test_progs.c, so EINTR is reachable here.
>
>> +
>> +close:
>> +	save_errno_close(fd);
>> +	return -1;
>>  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/315037=
00726




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

