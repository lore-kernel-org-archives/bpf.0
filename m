Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0D21ABBB;
	Sun, 11 Oct 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717426; cv=none; b=qB23yxRXJ9C4msFBj+9v2oeABq+QqS5fUHPZsmeIbqFEAUzJEYxqYWp5589mFqmZRf6/BTrTj1Wm4SR8WCxJsSRGe6/1DAI2DtJ57baPouqkPw8LPIrGgd65xgPa4WiiC5JTGjJVl+wLmt79Cy9j8m10Q3L0FXsEVPh0kp1Zkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717426; c=relaxed/simple;
	bh=HVsrWvucrQcXjkudyOXS1wXXoKzNbk7II2+g7nzYm8Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X83mVxOkKy48YK5dwm9/w6pRG7ldcOiWocZT/bg+wg6sgl7K03HAQ59vv7ze8k+QhH+6SUxeNCsVrP7xgFOiRM33L17lL0cVrs1zzMNOq/skhzjw+dficzHzZVMgLd6Y7DxbENrBUgBqKb2vj/LU5vzwwE7NvcY0UBcNME00GP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWbjxPDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWbjxPDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D11F0089B;
	Sun, 11 Oct 2026 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717424;
	bh=uz8P9b0IBLj9RXAHuDi1sqnLdo4PWDKNphfZAMMNPY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bWbjxPDaqF5js10gssfjfUcob7+6eOtDBK01n7QlCyw6AwQGukZghPX1czfXqcnnl
	 fuV7SC4MgQriVvJqpM6WEFaCPtG2U2RNZ0+3BJYsPwq3jvDt5k529qJ9koMbhfApEk
	 fNp3ZyOpIfu6wa57n/q+s/Cid3SINsIUE1V27yC0s3b/Enkv3AvdKV+DwogjC4xccn
	 jUsGaAMTZOs4wyZ7f4hMB5Vx1Up/FgK+ZRzeI8fTM0SBnxQOZ1jXuNZ/X2tXgIfHt0
	 l3kX3ECbmFZqGWXr1Ou1bHo27I/ut6MxT+xJGbSSZL0jAQrwUTeno5JPqchK3JqTTa
	 hMK7TBp7SqRkA==
Subject: Re: [PATCH net-next v5 1/5] selftests/bpf: Fix XDP feature test setup
 and teardown
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Sun, 11 Oct 2026 11:17:02 +0000
Message-ID: <179171742230.434549.5200541568736578334@kernel.org>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-1-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-1-de687cb67c40@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tester_run(), the new comment `/* Sample before teardown can
  produce additional echo traffic.

Pre-existing issues:
- [Medium] In this commit, dut_run() spins forever if the tester closes
  the control connection without sending CMD_STOP.

--

selftests/bpf: Fix XDP feature test setup and teardown

This patch fixes setup and teardown in the XDP features test tool. It
initializes the DUT state and socket address lengths, returns the echo
socket fd to the caller, and joins the echo worker only if it was
started. It also reads the tester counters before sending CMD_STOP, so
the teardown echo does not cause a false XDP_DROP failure.

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
> index a27ed663967c4..5b802b14d8589 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/bpf/xdp_features.c

[ ... ]

> @@ -484,7 +488,9 @@ static int dut_run(struct xdp_features *skel)
>  	}
>  
>  end_thread:
> -	pthread_join(dut_thread, NULL);
> +	exiting = true;
> +	if (thread_started)
> +		pthread_join(dut_thread, NULL);
>  out:
>  	bpf_xdp_detach(env.ifindex, flags, NULL);
>  	close(ctrl_sockfd);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The
commit message says "Stop the worker on error paths". Can the new
exiting = true and pthread_join() be reached if the tester closes the
control connection without sending CMD_STOP?

At EOF, recv() in recv_msg() returns 0. That gets the same -EINVAL as a
malformed message:

	len = recv(sockfd, buf, bufsize, 0);
	if (len != ntohs(tlv->len) || len < sizeof(*tlv))
		return -EINVAL;

dut_run() then just loops again:

		err = recv_msg(ctrl_sockfd, buf, BUFSIZE, NULL, 0);
		if (err)
			continue;

exiting is still false, so the next recv() returns 0 at once. The DUT
spins at full CPU and never reaches end_thread or out. Meanwhile the
echo worker keeps running and the XDP program stays attached until
SIGINT or SIGTERM.

After CMD_START, tester_run() can close the socket without sending
CMD_STOP in several ways:

- send_echo_msg() fails.
- send_and_recv_msg(CMD_GET_STATS) fails or times out.
- The tester is killed.

The later patch in this series, "selftests/bpf: Send XDP feature probes
with AF_PACKET", appears to fix this. In that patch, recv_msg() returns
-ECONNRESET on a short or zero-length read. dut_run() then jumps to
end_thread for any error other than -EAGAIN or -EINTR.

[ ... ]

> @@ -636,12 +642,14 @@ static int tester_run(struct xdp_features *skel)
>  	if (err)
>  		goto out;
>  
> +	/* Sample before teardown can produce additional echo traffic. */

[Severity: Low]
This isn't a bug, but the comment reads as if sampling causes the extra
echo traffic, when it is the teardown that does. Would something like
"Sample before teardown, which can produce additional echo traffic" be
clearer?

Also, moving the detected_cap assignment leaves two blank lines in a row
after send_echo_msg() below. checkpatch warns about this.

Both go away when the later patch "selftests/bpf: Send XDP feature
probes with AF_PACKET" rewrites tester_run().

> +	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
> +
>  	/* stop the test */
>  	err = send_and_recv_msg(sockfd, CMD_STOP, NULL, 0);
>  	/* send a new echo message to wake echo thread of the dut */
>  	send_echo_msg();
>  
> -	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
>  
>  	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
>  		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40%40gmail.com
