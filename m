Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421706;
	b=ei+L/tE3NSbTTcq1fTGCitQOJVuEHL/6P5sBV7nZdlIUV7HxrSFQqTCvM0Fl1aZbtP61
	 kNAD8u4HF9xJO+3J3UHhb1/Vnu7E30ZyrWVZW9Gg0P3VA89kwSuDanZMxAIFhoQLIc4rM
	 9NpV6WmV/6Vz9oAMo7AES3piS4HJR/SRjemckjJhHFO8DJPmeXlbvE7DgNFgY09QE3oau
	 3OjBGOxqDKQtOxcyWRc1EI6pQr19XFpSXNv6ykygS7dVV1aUurabFZasVNfm2w2wVzVt+
	 TeoMHDNsYYpo/w0fL8fVuZKz588IOCwhuBuHUyUEEVlHpGvIBJCm8d8HHEQJ45ad2wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421706;
	h=Received:Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mZLzRwRYboY/RmAU+vEf+KfhFzbpntUfPL9/1QMLPg4=;
	b=GCgR7D6d9SfRaYV226T9vC8CNfHsflX5NSht0VUFHsOhrhQ+SkEXvDKrqRrgP6gqky2K
	 xZ5VXgVjp7GljaUJ5lMPtReA6bjTwpCgHc1UOEOaIswy+DaBV+yHAl9MqirNZa26zTs4u
	 PUV5cOauu4ELT9nT9xpMFdbYQbD86qou91BUoZKVU8uudgQJbx5BMUt062AzwENQhU9Er
	 SZk12hg4aUKF5DQUwuLW62Dzvo3j7mcjwQscScTRCLh8A/63RaCl1WcBgKD0RK4uNN8qz
	 2mF9QfBDlQd9HACVpostfQBImSKzBG1yoC9qWls7XYA/L1j40nWbe0dyg+tTPepun2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHHofU0r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007B606EFE6;
	Mon, 19 Oct 2026 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHHofU0r
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBE234964;
	Mon, 19 Oct 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421706; cv=none; b=TCnLJuB3FaGM41lcTEq2aWDzCDHTl8TD8XX++TZc52MwHT7PhCag2sSFh7cx5nxv3yDN1QVDBLoX1jCiik56UfdtLt9awUXTXFPF1hkdVLFxV35fLn8kPAwnWLZk4v9/aNJOunDo6D7ilxchKBGqduKvrHdPd8ut3HOUNtnA5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421706; c=relaxed/simple;
	bh=rzZ8aVYHTbvvvHXdIbMH7BBTWk45dgc5mYEFN5NQOlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m1fZLah0vPULlyLzU9lUVjC99sltZZjXQKpqaUIsfXtjFeC6ku308uJGdFLlGcLRvPmKjeVI0fcNdl0uzS6XYVvAxAMFSozDnQlPmTtfSgU6dD9Jnpethn14G5delDQT1Y45vYkgFtS1I4y5AXEJFsqe8X9wWrEIcL3dS3zGVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHHofU0r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526C01F000C4;
	Mon, 19 Oct 2026 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421705;
	bh=mZLzRwRYboY/RmAU+vEf+KfhFzbpntUfPL9/1QMLPg4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kHHofU0rYuCnhF24LmEHw4SnsG9PEmLBo2DwGVUs58j86P/0FdZ6XWeHDZVLvTErD
	 x+nBzd9woAXRC3l15OeMB2SlHqkfUknr7620h8Qw4aOs5iK5MiNwO3y4ZITB91sqbf
	 KFSL4LR8q+FXg/ttYU8yCEw4UF3zy4j1ho4b//W/OrxVJzexrr/Gl14YZI46TTMFYX
	 5F/oYIRGQcdconbxeDYTqbmyc9ZBEUKlERt8NvM5jRfpq83cMG1JeKy6YVKoLKVbGm
	 YD3+tckFU23CE+YxRzCrFnAFxDC8FNpacA+kHqx1WGrt7z22o7RoX6nmDYc1b6v3ip
	 VFfur1KqMae5w==
Subject: Re: [PATCH net-next v6 1/5] selftests/bpf: Fix XDP feature test setup
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
Date: Mon, 19 Oct 2026 14:55:02 +0000
Message-ID: <179242170282.3135.3655485232785325877@kernel.org>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-1-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-1-7336e1282ca3@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The `xdp_attached` guard only records that an attach succeeded at
  some point.

Pre-existing issues:
- [Medium] test_xdp_features.sh uses only the tester's exit status, and
  tester_run() returns 0 whether or not the capability is DETECTED or…
- [Low] In tester_run(), the settimeo() and connect() failure paths
  return directly without close(sockfd), which leaks the control socket.
- [Low] recv_msg() accepts payloads shorter than val_size and copies only
  the bytes it received.

--

selftests/bpf: Fix XDP feature test setup and teardown

This commit fixes several setup and teardown problems in the xdp_features
selftest tool. It initializes the DUT state and socket address lengths,
hands the echo socket back to the caller, and stops and joins the echo
thread only if it was started. It also samples the tester counters before
teardown, and it detaches XDP programs only after a successful attach.

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
> index a27ed663967c4..3076fdda61fa4 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/bpf/xdp_features.c

[ ... ]

> @@ -341,10 +343,14 @@ static int recv_msg(int sockfd, void *buf, size_t bufsize, void *val,
>  		    size_t val_size)
>  {
>  	struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
> -	size_t len;
> +	ssize_t len;
>  
>  	len = recv(sockfd, buf, bufsize, 0);
> -	if (len != ntohs(tlv->len) || len < sizeof(*tlv))
> +	if (len < 0)
> +		return -errno;
> +	if (!len)
> +		return -ECONNRESET;
> +	if (len < sizeof(*tlv) || len != ntohs(tlv->len))
>  		return -EINVAL;
>  
>  	if (val) {

[Severity: Low]
This isn't a bug introduced by this patch, but recv_msg() only rejects
payloads that are larger than val_size:

	if (val) {
		len -= sizeof(*tlv);
		if (len > val_size)
			return -ENOMEM;

		memcpy(val, tlv->data, len);
	}

Can a short payload leave part of the destination unwritten?

In tester_run(), stats and advertised_feature are both declared without
an initial value. Leftover stack bytes could then affect the feature
result that gets printed.

A later patch in this series changes the check to:

	if (len != val_size)
		return -ENOMEM;

That rejects short payloads before the memcpy().

[ ... ]

> @@ -403,9 +412,12 @@ static int dut_run(struct xdp_features *skel)
>  			if (err)
>  				goto out;
>  
> +			xdp_attached = true;
> +
>  			err = dut_run_echo_thread(&dut_thread, &echo_sockfd);

[ ... ]

> @@ -422,6 +434,7 @@ static int dut_run(struct xdp_features *skel)
>  
>  			exiting = true;
>  			bpf_xdp_detach(env.ifindex, flags, NULL);
> +			xdp_attached = false;

[Severity: Low]
The xdp_attached flag records that bpf_xdp_attach() succeeded at some
point. However, bpf_xdp_detach(env.ifindex, flags, NULL) removes
whatever program is attached to the device at the time it runs.

If another privileged user replaces the program between the attach and
the detach, would this still remove that other program?

The out: label in tester_run() uses the same pattern:

	if (xdp_attached)
		bpf_xdp_detach(env.ifindex, flags, NULL);

A later patch in this series appears to fix this. The DUT attaches with
bpf_link_create() and cleans up with close(link_fd). The tester no
longer attaches an XDP program at all, because it uses AF_PACKET.

>  
>  			tlv->type = htons(CMD_ACK);
>  			tlv->len = htons(sizeof(*tlv));

[ ... ]

> @@ -578,7 +596,7 @@ static int tester_run(struct xdp_features *skel)
>  	struct bpf_program *prog;
>  	unsigned int stats;
>  	int i, err, sockfd;
> -	bool detected_cap;
> +	bool detected_cap, xdp_attached = false;
>  
>  	sockfd = socket(AF_INET6, SOCK_STREAM, 0);
>  	if (sockfd < 0) {

[Severity: Low]
This is a pre-existing issue, but the settimeo() and connect() failure
paths just below this return without closing sockfd:

	if (settimeo(sockfd, 1000) < 0)
		return -EINVAL;

	err = connect(sockfd, (struct sockaddr *)&env.dut_ctrl_addr,
		      sizeof(env.dut_ctrl_addr));
	if (err) {
		...
		return -errno;
	}

Does this leak the control socket? Now that xdp_attached starts out
false, could these paths go to the out: label instead?

A later patch in this series changes them to "err = -errno; goto out;".

[ ... ]

> @@ -636,19 +655,21 @@ static int tester_run(struct xdp_features *skel)
>  	if (err)
>  		goto out;
>  
> +	/* Sample before teardown, which can produce additional echo traffic. */
> +	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
> +
>  	/* stop the test */

[ ... ]

>  	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
>  		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),
>  		env.feature.drv_feature & advertised_feature ? GREEN("ADVERTISED")
>  							     : RED("NOT ADVERTISED"));
>  out:
> -	bpf_xdp_detach(env.ifindex, flags, NULL);
> +	if (xdp_attached)
> +		bpf_xdp_detach(env.ifindex, flags, NULL);
>  	close(sockfd);
>  	return err < 0 ? err : 0;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but detected_cap and
advertised_feature are only printed here. tester_run() returns 0
whatever their values are.

test_xdp_features.sh checks only the exit status of the tester:

	ip netns exec ${NS} ./xdp_features -t -f XDP_PASS \
					   -D $V1_IP6 -C $V1_IP6 \
					   -T $V0_IP6 v0
	[ $? -ne 0 ] && exit

Could a broken or unadvertised XDP action still pass the selftest?

A later patch in this series ("selftests/bpf: Track XDP test processes
and isolate namespaces") adds:

	if (!err && detected_cap != !!(env.feature.drv_feature & advertised_feature))
		err = -EINVAL;

The same series also replaces the shell script with
drivers/net/hw/xdp_features.py.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3%40gmail.com
