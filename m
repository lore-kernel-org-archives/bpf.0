Received: from out-189.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C33321A7
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460749; cv=none; b=cNK57SntxCY5Vod56gYkyx3Q02osn+f6mQFeCQ6U+hPnVebrAPkxvoUVWHKKEWWKVtEGfWsz03XQhxRrRXfbIqVAjZY7epzJ3Nv71dq6f3z9l34Ybw1P9B63VFtbOEeds6q5tOTuPSj6IiXBYgsBGSaU0VGEbVPwS/2oINuBEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460749; c=relaxed/simple;
	bh=cMGGvcnuFFGukbZhID6mK5u1EMw6HEKElg6I010dBLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDolyLnhNsXbn1+gP5cF7e07YihHUP9HXOAh/ydBRw58EhudTERqATuBg3qexa12dZmDrCopC45IlBIGN1ha8h4NrtGFLTpveJd8Qd9rNu4qRSCqq96kvDuRlY8OKto2Wpb3gNVSAMW01C3n/T9IBlY4YtBT59xpOdVh09aHsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmjL1X6L; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmjL1X6L"
Message-ID: <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786460735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGFt9K8OWRTlwxZvRIzXVJQCG2LtAHLRfdvti+gu57o=;
	b=qmjL1X6L231E6K1YuUbpjPxwJ8IrQ7DIdrWDq+SlJtPAmUnw0G6Wb4uLi9VX2nw7XgybOL
	xXllF0zMid0H7jFSmpwJB8+mWTmS6BqOmDDeGkyJ5cYReoBo8w4aqoq1QP5DTcTwWV/FAp
	J3ismvTmR4B8xi0fDYoCd2+ck4CYl80=
Date: Tue, 11 Aug 2026 23:05:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that is
 still in progress
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
 <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/11/26 10:26 PM, Alexis Lothoré (eBPF Foundation) wrote:
> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
> following logs:
>
>    (network_helpers.c:309: errno: Operation now in progress) \
>      Failed to connect to server
>    send_and_test_data:FAIL:connect to server unexpected error: -115
>
> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
> socket (see settimeo() in client_socket()), allowing connect() to return
> an error and to set errno to EINPROGRESS instead of blocking until
> connection result is known. Increasing the timeout value for those tests
> is likely not a good solution (and it has already been done by commit
> 2790db208b44 ("selftests/bpf: Improve tc_tunnel test reliability")):
> they involve subtests that expect the connection to fail, and so
> increasing the timeout value would increase overall test execution
> duration again (not only the connection, but any socket operation).
>
> Another solution, as documented in man 2 connect, is to poll the socket
> for POLLOUT once connect has returned EINPROGRESS, and to get the actual
> connection result through getsockopt: this allows to keep the overall
> timeout values low for the general traffic, while letting a chance to
> the connection to succeed even if CI runners are loaded.
>
> When connect() returns EINPROGRESS, poll the socket for POLLOUT and
> check the connection result via getsockopt(SO_ERROR). This new handling
> conforms to the configured timeout: the polling loop will only run for
> the amount of time still available, accounting for the time used by the
> initial connect() call.


So IIUC this patch doesn't actually fix the flakiness: connect() on a 
blocking socket only
returns EINPROGRESS after SO_SNDTIMEO is fully consumed, so remaining_ms 
is always ~0 and the
overall time budget is still 1s, same as before. Am I missing something?


