Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F5330644;
	Mon,  3 Aug 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746128; cv=none; b=gV51hG3TRzXyxvw6HH+YertZVIHpjZGgg1GtRivEaEml6JuBEBVFaTMRPlIUuPRvAE2BawhXuwtwZjDJ5AwuyRQsuEVrSa9ELBpQnK2EOD6WQfA+N3bdGkSdZjLzPGZeLBmruOXzX6X7Rcz12qfo7hLNbNF69G7XIMIJdCSxZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746128; c=relaxed/simple;
	bh=ZdQmvYy5PM0kMYZcuSGO1iZEZqW6uMelzNt4ZpPc4kk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f/wAd4EavIQ5MX5hAzcq8BVcTqLToPMz1WSaqthwbqadDP5ZzgrvrfNIJvA48/m1OdH4VcYCvs26fX6NNGykcvVC6CRmoNfAD3s+fTU9J50zbNYvlY5CCYxkEhbxlSFiLKWPxUwK5eOHjOnK6qydbPFv8e+kMm6o5Yg7Nw+f43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVo0nCqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVo0nCqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89B71F000E9;
	Mon,  3 Aug 2026 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746127;
	bh=9+rTU04TRiQfur2pbyp+bMw4+ReZ07fn07OIkmJ3u5s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WVo0nCqVWLi+lqudJVpGvg+sZywD70GKTHaxKxt4w7jAyzx/Ylz4kJqUd7wYoa4s2
	 ptyBCRP6RFYPlENCatB/AOEX71Eb7hZ7g6ql7g8NptuFmaiAReWnqO3e6uOkpynjjj
	 kbRSeApfaqtqfvT7/sVAoyRQpwyNfNigDm69uGxQROwJU1Px9xwk3SOVmY2YovJG0g
	 MWpy7T15eTi9fTUX8lNHOzyi1aYUNKdZZNoPC8/zhrQSR8vEjjHvFjgG+hBSpXG9j3
	 j6STSvNy31RxgBT2A5O0GSTsvu3j6GH1A/bmzecZBzR/G4mfBEJR4Pejo0lkVCKFFT
	 P25I1BFJsC2bw==
Content-Type: multipart/mixed; boundary="===============4298303249341813352=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eac3adb0094cfdbbd998c459ddecd92179c0fa252a44878ea5c69eb991c1a11a@mail.kernel.org>
In-Reply-To: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
References: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: keep polling connection that is still in progress
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 08:35:25 +0000 (UTC)

--===============4298303249341813352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..2f2719a28f02 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -40,6 +41,8 @@
>  #define IPPROTO_MPTCP 262
>  #endif
>
> +#define CONNECTION_IN_PROGRESS_TIMEOUT_MS	3000
> +
>  #define clean_errno() (errno == 0 ? "None" : strerror(errno))
>  #define log_err(MSG, ...) ({						\
>  			int __save = errno;				\

[ ... ]

> @@ -294,7 +297,8 @@ int client_socket(int family, int type,
>  int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>  		    const struct network_helper_opts *opts)
>  {
> -	int fd;
> +	socklen_t errlen;
> +	int fd, err;
>
>  	if (!opts)
>  		opts = &default_opts;
> @@ -305,13 +309,42 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> +	err = connect(fd, (const struct sockaddr *)addr, addrlen);
> +	if (err && errno == EINPROGRESS) {
> +		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
> +
> +		err = poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);

Does the fixed 3000 ms timeout override opts->timeout_ms correctly?

client_socket() in this file passes opts->timeout_ms to settimeo(), which
converts it into SO_RCVTIMEO and SO_SNDTIMEO:

tools/testing/selftests/bpf/network_helpers.c:settimeo() {
	...
	if (timeout_ms > 0) {
		timeout.tv_sec = timeout_ms / 1000;
		timeout.tv_usec = (timeout_ms % 1000) * 1000;
	} else {
		timeout.tv_sec = 3;
		timeout.tv_usec = 0;
	}
	...
}

tools/testing/selftests/bpf/network_helpers.c:client_socket() {
	...
	if (settimeo(fd, opts->timeout_ms))
		goto error_close;
	...
}

That opts->timeout_ms is the caller's requested timeout contract. But the
new poll() discards it and uses CONNECTION_IN_PROGRESS_TIMEOUT_MS instead,
which is always 3000.

This changes observable timing for callers in both directions:

Callers that request a SHORT timeout now wait longer than they asked for.
prog_tests/assign_reuse.c calls connect_to_fd(fd_sv, 100) at lines 42 and
66, requesting a 100 ms budget. A stalled connect now blocks for 100 ms
(SO_SNDTIMEO) plus 3000 ms in poll() - a 30x overrun.
prog_tests/test_tc_tunnel.c sets .timeout_ms = 1000 at line 171.

The commit message explicitly argues against lengthening timeouts:
"increasing the timeout value would increase overall test execution
duration again", yet the patch lengthens these callers' timeouts from
their requested values.

Callers that request a LONG timeout get a shorter window than they asked
for. prog_tests/tc_redirect.c uses TIMEOUT_MILLIS (10000) at lines 428,
561, and 658. prog_tests/xdp_synproxy.c uses 10000 at line 135. On a
loaded runner the connect is now abandoned at SO_SNDTIMEO + 3 s rather
than the requested 10 s.

Would deriving the poll timeout from opts->timeout_ms preserve the single
timeout contract that callers already use?

>
> +		if (err <= 0) {
> +			if (err == 0) {
> +				log_err("Connection timeout");
> +				errno = ETIMEDOUT;
> +			} else {
> +				log_err("Failed to poll connection status");
> +			}
> +			goto close;
> +		}
> +
> +		errlen = sizeof(err);
> +		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
> +			log_err("Failed to getsockopt");
> +			goto close;
> +		}
> +
> +		if (err) {
> +			log_err("Eventually failed to connect to server");
> +			errno = err;
> +			goto close;
> +		}
> +	} else if (err) {
>  		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +		goto close;
>  	}
>
>  	return fd;
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30795380743
--===============4298303249341813352==--
