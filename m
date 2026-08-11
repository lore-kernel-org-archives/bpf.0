Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54A3B0598;
	Tue, 11 Aug 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462222; cv=none; b=gI8xI2J3cT7G5YuvvSBIPg48gScbwRhc6YsidOvERGWEXLXEOo6kkBWbYHb/fHBnAyJzZB1VIrG99zKPk4R3tNr4gDbdBwVxyGbGUH5JWPfPN1M0TH6pY/+Mr90bvBmptY1FSbN01aum3RD2IN+Fxjqkp2CxCnRKYtxFAfsJDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462222; c=relaxed/simple;
	bh=uU1XXUONAYhfVZ+1XODrFL1b86eR/LB4CXC5+T1Sfk8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EBIaExKybV+g/nv9+5ohgWMiwdP0yEFplVE/718YXlU/y5jl/xROt8yPQjptNbylzkUoF2Q66EgOwLvZMOuOQisonJsl9/jAZbMszPGwXwFzbsSUkRQRhCDtv2IbdHI+YbQ0LA+lBnVSAMKK2emkwJLfDVidFKMjIXHarwCM8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpZnTuZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpZnTuZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491EA1F000E9;
	Tue, 11 Aug 2026 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462221;
	bh=TUD9UHp3XK9SUc5YmyrjuFBWex9I+YRnQmmHiGPBVxw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IpZnTuZqjF1dAcTC46LsSnvXZqQwmsm9vJRZuarMWpnJIVI5hxSVM61lYyZCs6tA1
	 9X+oz/fuC8ZduAwr1HpPevRPPCuld1WIXf5uJqT4oDKQNCowVfvtLzeIAKRB+LDCOi
	 1u3RMrBojQ0oKk0OFtGDU6oWo28kMfBJ5V7J3UgsxygBSYYL3CEq77LPLwsJ3vbT8Z
	 vRX7dMUZ7WB/rPPSNtDDrKRILqMr8m8w8CEqaBcvNyETrPjjH92XSwgNH6FMmqloA/
	 JJw1Mj+fTE4golRdTH0j5OOmqhP0CBVNnsxUhWS0gY9A6WbHFq4ZK9VGTi/U5Ki5Sv
	 IlE8ZPBUdX3VQ==
Content-Type: multipart/mixed; boundary="===============5971125322800962547=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9100335a46140b0e6aa30d49dad88a74afd532c1c924580012a4b3450c004edc@mail.kernel.org>
In-Reply-To: <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
References: <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that is still in progress
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 15:30:20 +0000 (UTC)

--===============5971125322800962547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..25e4d2fa6f6f 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -305,13 +309,69 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> +	start_ms = get_time_ms();
> +	err = connect(fd, (const struct sockaddr *)addr, addrlen);
> +
> +	if (!err)
> +		return fd;
> +
> +	if (errno != EINPROGRESS) {
>  		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +		goto close;
>  	}
>
> -	return fd;
> +	duration_ms = get_time_ms() - start_ms;
> +	remaining_ms = duration_ms < opts->timeout_ms ?
> +			       opts->timeout_ms - duration_ms :
> +			       0;
> +	if (!remaining_ms) {
> +		errno = ETIMEDOUT;
> +		log_err("Can not poll connection, already in timeout");
> +		goto close;
> +	}
> +
> +	while (remaining_ms) {
> +		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
> +
> +		start_ms = get_time_ms();
> +		ret = poll(&pfd, 1, remaining_ms);
> +
> +		if (ret == 0) {
> +			errno = ETIMEDOUT;
> +			log_err("Connection timeout while polling");
> +			goto close;
> +		} else if (ret < 0 && errno == EINTR) {
> +			duration_ms = get_time_ms() - start_ms;
> +			remaining_ms = duration_ms < remaining_ms ?
> +					       remaining_ms - duration_ms :
> +					       0;
> +			if (!remaining_ms) {
> +				errno = ETIMEDOUT;
> +				log_err("Connection timeout after signal");
> +				goto close;
> +			}
> +		} else if (ret < 0) {
> +			log_err("Failed to poll connect status");
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
> +			errno = err;
> +			log_err("Eventually failed to connect to server");
> +			goto close;
> +		}
> +		return fd;
> +	}

Does the EINTR branch need to continue the loop? When poll() returns
EINTR, the code recomputes remaining_ms but then falls through to
getsockopt(SO_ERROR). If the connection is still in progress, SO_ERROR
will be 0 and connect_to_addr() returns the fd even though the socket
is not yet connected.

Also, no path inside the while loop reaches the loop condition again -
every branch either does 'goto close' or 'return fd'. So after the EINTR
budget recalculation runs, the code never re-enters poll() to use that
budget.

Would adding 'continue;' at the end of the EINTR branch fix this? That
way poll() gets called again with the updated remaining_ms, and the
connection completes properly after a signal interruption.

Test_progs installs a SIGINT handler without SA_RESTART in
test_progs.c, so EINTR is reachable here.

> +
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31503700726
--===============5971125322800962547==--
